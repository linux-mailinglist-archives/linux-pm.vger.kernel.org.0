Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D05017B3E5
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 02:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgCFBoV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Mar 2020 20:44:21 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:38153 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFBoV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Mar 2020 20:44:21 -0500
Received: by mail-pf1-f173.google.com with SMTP id g21so284997pfb.5
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2020 17:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=t8lApLOZBI+fP4XhBBc+RfZervE3Yo6SDSZ699XHI1k=;
        b=c9lS3zuvJll7+EEAnPhg0hKU0wvoP0e8vK0Yop8gevZKH2CcOspMw57hXstoq20Pa2
         znf6A4MJ+E7Jgt+60pTuwHaayp+5zDxV39uhftG/Fje0D1qEFV1ZFcbOqjhheQ0/u2ib
         3cX/yXtADQ+jR5EGKE7nCvMJTiRzcHuy22GPoIH09G89+SOO2gSVyjJJMAencur5VHsH
         TOqL4gV4eUk4mIzQ8w1MutPuoHbFr5tCtBwy0kTAMcA8B7efw+7aNgqg9ppO2dUYxDCz
         iX7XqkCa3FVXNsyxuYNtHoeEsNHm5SydKFGPCIJNuI4vBjkziZn4WJ+bIaxAhL8e9Zlr
         4BYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=t8lApLOZBI+fP4XhBBc+RfZervE3Yo6SDSZ699XHI1k=;
        b=eHb3W4mK9u/b6ddQvBOkMzOsd7CaTLLUbFEmfLDCm2Z/uCxIlKjAQvypHEm+W93tQf
         REWku5hq42lgu91UqrhY87M63/NC300T8q9Bw6AkHTAmBkTi3QDZyrmOg6uO8dEY30ZS
         UCY07ejX/tTejT3aZqKtFwxu5e8kbJgPELsGxs2ePjq24HdUGi2XJghQNTAQFbKbO5je
         7xPDCaJbCSrypw+8f6GVmvCZR5fV+ITpWo1YhwHhtdGIpGAP19CKii+Q0WwdpQAGoR94
         Ft83cwdYGOyURpSrJMYi2xstuiu5g/paVw9LENTD41sBZzrw7ptzjBPEwiTZtTefX0wJ
         D7lA==
X-Gm-Message-State: ANhLgQ0HQ2h20GRjECSLEnUEKfylI7U0nZr4QE3id9U5xHew9ToTxPzs
        LbzYMd1mE2+EfcqLG4qoZD7iAg==
X-Google-Smtp-Source: ADFU+vuKWNzRkCu538AiiF0K9CrIUD9PmBJVT5Mubzt8PpK47KfFB4ocrcm1e28hdT/sd4w12fG6yg==
X-Received: by 2002:a63:1d15:: with SMTP id d21mr1015257pgd.212.1583459060090;
        Thu, 05 Mar 2020 17:44:20 -0800 (PST)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t17sm33267489pgn.94.2020.03.05.17.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 17:44:19 -0800 (PST)
Message-ID: <5e61aaf3.1c69fb81.2ea01.818f@mx.google.com>
Date:   Thu, 05 Mar 2020 17:44:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.6-rc4-78-ge63a6b3d7d38
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 30 runs,
 0 regressions (v5.6-rc4-78-ge63a6b3d7d38)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 30 runs, 0 regressions (v5.6-rc4-78-ge63a6b3d7d38)

Test results summary
--------------------

run | platform                     | arch   | lab                   | compi=
ler | defconfig        | results
----+------------------------------+--------+-----------------------+------=
----+------------------+--------
1   | bcm2711-rpi-4-b              | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

2   | bcm2837-rpi-3-b              | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

3   | hifive-unleashed-a00         | riscv  | lab-baylibre          | gcc-8=
    | defconfig        | 1/1    =

4   | hip07-d05                    | arm64  | lab-collabora         | gcc-8=
    | defconfig        | 3/5    =

5   | imx8mn-ddr4-evk              | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

6   | meson-g12a-sei510            | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

7   | meson-g12a-u200              | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

8   | meson-g12a-x96-max           | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

9   | meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

10  | meson-g12b-odroid-n2         | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

11  | meson-gxl-s805x-p241         | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

12  | meson-gxl-s905d-p230         | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

13  | meson-gxl-s905x-khadas-vim   | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

14  | meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 4/4    =

15  | meson-gxm-khadas-vim2        | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

16  | meson-gxm-q200               | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

17  | meson-sm1-khadas-vim3l       | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

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

26  | rk3399-gru-kevin             | arm64  | lab-collabora         | gcc-8=
    | defconfig        | 79/82  =

27  | rk3399-puma-haikou           | arm64  | lab-theobroma-systems | gcc-8=
    | defconfig        | 5/5    =

28  | sun50i-a64-pine64-plus       | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

29  | sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

30  | sun50i-h6-pine-h64           | arm64  | lab-collabora         | gcc-8=
    | defconfig        | 5/5    =



  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.6-rc4-78-ge63a6b3d7d38
  URL:      git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it
  SHA:      e63a6b3d7d38c359b20aded5ec6964ffdf61ca96 =



Test Failures
-------------
           =


run | platform                     | arch   | lab                   | compi=
ler | defconfig        | results
----+------------------------------+--------+-----------------------+------=
----+------------------+--------
4   | hip07-d05                    | arm64  | lab-collabora         | gcc-8=
    | defconfig        | 3/5    =


  Results:     3 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc4-78-ge63a6b=
3d7d38/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc4-78-ge63a6b=
3d7d38/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/buildroot/kci-201=
9.02-8-gd700ebb99e8f/arm64/baseline/rootfs.cpio.gz       =


  dmesg - 3 tests: 1  PASS, 2 FAIL, 0 SKIP
    * alert:
        never passed
        11 lines
    * emerg:
        never passed
        2 lines  =

                                                                     =


run | platform                     | arch   | lab                   | compi=
ler | defconfig        | results
----+------------------------------+--------+-----------------------+------=
----+------------------+--------
26  | rk3399-gru-kevin             | arm64  | lab-collabora         | gcc-8=
    | defconfig        | 79/82  =


  Results:     79 PASS, 3 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc4-78-ge63a6b=
3d7d38/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc4-78-ge63a6b=
3d7d38/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/buildroot/kci-201=
9.02-8-gd700ebb99e8f/arm64/baseline/rootfs.cpio.gz     =


  bootrr - 78 tests: 75  PASS, 3 FAIL, 0 SKIP
    * cros-ec-sensors-accel0-probed:
        never passed
    * cros-ec-sensors-accel1-probed:
        never passed
    * cros-ec-sensors-gyro0-probed:
        never passed    =

                 =20
