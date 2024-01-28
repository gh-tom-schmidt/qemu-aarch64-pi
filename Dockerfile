FROM ubuntu:23.04@sha256:ea1285dffce8a938ef356908d1be741da594310c8dced79b870d66808cb12b0f

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    qemu-system-aarch64 \
    fdisk \
    wget \
    mtools \
    xz-utils \
    python3 \
    && rm -rf /var/lib/apt/lists/* \
    && wget -O 2023-12-05-raspios-bullseye-arm64-lite.img.xz \
    https://downloads.raspberrypi.com/raspios_oldstable_lite_arm64/images/raspios_oldstable_lite_arm64-2023-12-06/2023-12-05-raspios-bullseye-arm64-lite.img.xz \
    && unxz 2023-12-05-raspios-bullseye-arm64-lite.img.xz \
    && rm -f 2023-12-05-raspios-bullseye-arm64-lite.img.xz \
    && CURRENT_SIZE=$(stat -c%s "2023-12-05-raspios-bullseye-arm64-lite.img") \
    && NEXT_POWER_OF_TWO=$(python3 -c "import math; print(2**(math.ceil(math.log(${CURRENT_SIZE}, 2))))") \
    && qemu-img resize "2023-12-05-raspios-bullseye-arm64-lite.img" "${NEXT_POWER_OF_TWO}" \
    && OFFSET=$(fdisk -lu 2023-12-05-raspios-bullseye-arm64-lite.img | awk '/^Sector size/ {sector_size=$4} /FAT32 \(LBA\)/ {print $2 * sector_size}') \
    && echo "drive x: file=\"2023-12-05-raspios-bullseye-arm64-lite.img\" offset=${OFFSET}" > ~/.mtoolsrc \
    && mcopy x:/bcm2710-rpi-3-b-plus.dtb . \
    && mcopy x:/kernel8.img . \
    && touch /tmp/ssh \
    && echo 'pi:$6$rBoByrWRKMY1EHFy$ho.LISnfm83CLBWBE/yqJ6Lq1TinRlxw/ImMTPcvvMuUfhQYcMmFnpFXUPowjy2br1NA0IACwF9JKugSNuHoe0' > /tmp/userconf \
    && mcopy /tmp/ssh x:/ \
    && mcopy /tmp/userconf x:/

EXPOSE 2222

ENTRYPOINT ["qemu-system-aarch64", "-machine", "raspi3b", "-cpu", "cortex-a72", "-nographic", "-dtb", "bcm2710-rpi-3-b-plus.dtb", "-m", "1G", "-smp", "4", "-kernel", "kernel8.img", "-sd", "2023-12-05-raspios-bullseye-arm64-lite.img", "-append", "rw earlyprintk loglevel
