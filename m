Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55FB71562C4
	for <lists+linux-pm@lfdr.de>; Sat,  8 Feb 2020 04:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgBHDIl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Feb 2020 22:08:41 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:35954 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgBHDIl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Feb 2020 22:08:41 -0500
Received: by mail-wr1-f42.google.com with SMTP id z3so1136960wru.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Feb 2020 19:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=XXufYLry9mVtiMgB0ajzlYR0YbgmVYc7d/zxKMK+ZLY=;
        b=jrV/gP7EyiTcOGD3iF2HQJUkJzPYB+Hxd0evUU0MQVuPX0Sq9MKLwwoCIbgiT71h/s
         i0M1KAZdEABLEZKxfgRiprex4vxVS4LD0gMR3XI6zPwwmUO3lkIWgd6fnalMIHILm48D
         2r7AEWMzwDl9p3vewSRU694wlSdlfBshWUw487kGmyAzy6n2ogN/zT28vbggDltKe6cS
         T16gEEwZ+NAbiBihLhvdC4WzFSfnZ6hzFb+0GGbH7poiDH9dmvP/ziLX4ZWXjE/V8BFI
         7m6abGXpviDGqaF/t3arJONuSmURhb91V0VQ5uMlHXYtewRSTPOzDi5xywlvhUjeNAYv
         nbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=XXufYLry9mVtiMgB0ajzlYR0YbgmVYc7d/zxKMK+ZLY=;
        b=Hr+nyBbf2RQSfPJwvW8MA9SP+82yBt8II8CQU51AhhUr+zEIXaSMSMsTpOITqBx/1w
         +TBYCpjT5IYK1CyByhbelFsVmC1RBeVeDtP097PCkcoYw2qsB1dMhh6vk04Y2cdXiqin
         Oh6bW4UgHg29hPEB8RSwSJC9Tj1+WFlxGW/r7Dg8hBZIAIzG+o2rP5QiWNauyuqUAv/t
         3vouTMqq4hc/dW/2Y+TRpIgkl66J4tRI2Eyv20yI8XkBo3+ZBW1lqbaEoOqopk6uJmMh
         8uzALqkCiiVySA5IhaSsDp4psXF0iKNTNrDSfgpZrnM9C6Tz3Y2ieDMrSZsQCkw+TLEv
         m8yA==
X-Gm-Message-State: APjAAAXCwrRYvIjGUSqBVQX1gVxAf1Ar3OHIbYLDKvOGed/wrPDSEgYA
        39aHDCHjhlGz+ch1cW3tqAQ6AqBN9yo=
X-Google-Smtp-Source: APXvYqwNycf757iCXHk8fb/imMzsUqsc+CYN15oK+J6ToCSeaTzYPz0uvpg4fLp5cwvHfhUuOUYIKw==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr2452161wrq.331.1581131318597;
        Fri, 07 Feb 2020 19:08:38 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id r5sm5794780wrt.43.2020.02.07.19.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 19:08:38 -0800 (PST)
Message-ID: <5e3e2636.1c69fb81.16eab.97c8@mx.google.com>
Date:   Fri, 07 Feb 2020 19:08:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.5-rc7-146-g4529d29bc6a6
Subject: pm/testing baseline: 33 runs,
 0 regressions (v5.5-rc7-146-g4529d29bc6a6)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 33 runs, 0 regressions (v5.5-rc7-146-g4529d29bc6a6)

Test results summary
--------------------

run | platform                     | arch   | lab                   | compi=
ler | defconfig        | results
----+------------------------------+--------+-----------------------+------=
----+------------------+--------
1   | bcm2837-rpi-3-b              | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 4/5    =

2   | hifive-unleashed-a00         | riscv  | lab-baylibre          | gcc-8=
    | defconfig        | 1/1    =

3   | hip07-d05                    | arm64  | lab-collabora         | gcc-8=
    | defconfig        | 3/5    =

4   | imx8mn-ddr4-evk              | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

5   | meson-g12a-sei510            | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

6   | meson-g12a-u200              | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

7   | meson-g12a-x96-max           | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

8   | meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

9   | meson-g12b-odroid-n2         | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

10  | meson-gxbb-p200              | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

11  | meson-gxl-s805x-libretech-ac | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 0/1    =

12  | meson-gxl-s805x-p241         | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

13  | meson-gxl-s905d-p230         | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

14  | meson-gxl-s905x-khadas-vim   | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

15  | meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 4/4    =

16  | meson-gxm-khadas-vim2        | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

17  | meson-gxm-q200               | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 0/1    =

18  | meson-sm1-sei610             | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

19  | minnowboard-turbot-E3826     | x86_64 | lab-collabora         | gcc-8=
    | x86_64_defconfig | 5/5    =

20  | qemu_arm64-virt-gicv2        | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

21  | qemu_arm64-virt-gicv2        | arm64  | lab-collabora         | gcc-8=
    | defconfig        | 5/5    =

22  | qemu_arm64-virt-gicv3        | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

23  | qemu_arm64-virt-gicv3        | arm64  | lab-collabora         | gcc-8=
    | defconfig        | 5/5    =

24  | qemu_x86_64                  | x86_64 | lab-baylibre          | gcc-8=
    | x86_64_defconfig | 5/5    =

25  | qemu_x86_64                  | x86_64 | lab-collabora         | gcc-8=
    | x86_64_defconfig | 5/5    =

26  | r8a7795-salvator-x           | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

27  | r8a7796-m3ulcb               | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

28  | r8a7796-m3ulcb               | arm64  | lab-collabora         | gcc-8=
    | defconfig        | 5/5    =

29  | rk3399-gru-kevin             | arm64  | lab-collabora         | gcc-8=
    | defconfig        | 79/82  =

30  | rk3399-puma-haikou           | arm64  | lab-theobroma-systems | gcc-8=
    | defconfig        | 5/5    =

31  | sun50i-a64-pine64-plus       | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

32  | sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

33  | sun50i-h6-pine-h64           | arm64  | lab-collabora         | gcc-8=
    | defconfig        | 5/5    =



  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.5-rc7-146-g4529d29bc6a6
  URL:      git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it
  SHA:      4529d29bc6a6f458ae731425ce4f7e3856365bbe =



Test Failures
-------------
  =


run | platform                     | arch   | lab                   | compi=
ler | defconfig        | results
----+------------------------------+--------+-----------------------+------=
----+------------------+--------
1   | bcm2837-rpi-3-b              | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 4/5    =


  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.5-rc7-146-g4529d=
29bc6a6/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.5-rc7-146-g4529d=
29bc6a6/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/buildroot/kci-201=
9.02-8-gd700ebb99e8f/arm64/baseline/rootfs.cpio.gz     =


  dmesg - 3 tests: 2  PASS, 1 FAIL, 0 SKIP
    * crit:
        never passed
        5 lines    =

         =


run | platform                     | arch   | lab                   | compi=
ler | defconfig        | results
----+------------------------------+--------+-----------------------+------=
----+------------------+--------
3   | hip07-d05                    | arm64  | lab-collabora         | gcc-8=
    | defconfig        | 3/5    =


  Results:     3 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.5-rc7-146-g4529d=
29bc6a6/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.5-rc7-146-g4529d=
29bc6a6/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/buildroot/kci-201=
9.02-8-gd700ebb99e8f/arm64/baseline/rootfs.cpio.gz     =


  dmesg - 3 tests: 1  PASS, 2 FAIL, 0 SKIP
    * alert:
        never passed
        11 lines
    * emerg:
        never passed
        2 lines    =

                           =


run | platform                     | arch   | lab                   | compi=
ler | defconfig        | results
----+------------------------------+--------+-----------------------+------=
----+------------------+--------
11  | meson-gxl-s805x-libretech-ac | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.5-rc7-146-g4529d=
29bc6a6/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s805x-librete=
ch-ac.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.5-rc7-146-g4529d=
29bc6a6/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s805x-librete=
ch-ac.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/buildroot/kci-201=
9.02-8-gd700ebb99e8f/arm64/baseline/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        never passed   =

                     =


run | platform                     | arch   | lab                   | compi=
ler | defconfig        | results
----+------------------------------+--------+-----------------------+------=
----+------------------+--------
17  | meson-gxm-q200               | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.5-rc7-146-g4529d=
29bc6a6/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.5-rc7-146-g4529d=
29bc6a6/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/buildroot/kci-201=
9.02-8-gd700ebb99e8f/arm64/baseline/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        never passed   =

                                       =


run | platform                     | arch   | lab                   | compi=
ler | defconfig        | results
----+------------------------------+--------+-----------------------+------=
----+------------------+--------
29  | rk3399-gru-kevin             | arm64  | lab-collabora         | gcc-8=
    | defconfig        | 79/82  =


  Results:     79 PASS, 3 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.5-rc7-146-g4529d=
29bc6a6/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.5-rc7-146-g4529d=
29bc6a6/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/buildroot/kci-201=
9.02-8-gd700ebb99e8f/arm64/baseline/rootfs.cpio.gz       =


  bootrr - 78 tests: 75  PASS, 3 FAIL, 0 SKIP
    * cros-ec-sensors-accel0-probed:
        never passed
    * cros-ec-sensors-accel1-probed:
        never passed
    * cros-ec-sensors-gyro0-probed:
        never passed  =

                 =20
