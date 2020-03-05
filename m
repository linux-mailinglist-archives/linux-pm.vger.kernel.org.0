Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80673179E32
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2020 04:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgCEDVS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 22:21:18 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:42116 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgCEDVR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 22:21:17 -0500
Received: by mail-pl1-f179.google.com with SMTP id u3so1983862plr.9
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2020 19:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=/JM9m3EzADpFVwMZhlj5/PyI+PRhb52bk9jUylBvheI=;
        b=J4dggVF6aW7x7ShDHy5RnCewkdn5nDDpSdq+6cYMTWEYZLV++sccyVMugVzKFBNk46
         5ELsJ+8aZ6Jp2R8U42dDR4WjCbbE6K3pCqMgm9zG0j+9LLi9T++hVx+6gG6zr0dnzHf8
         Mz1Kux/oMjd0hlbpfSku+Zi2S2ZclY56xX6eBPBc6ctEc9Tdw2aXeWd/hON70NdxsxoT
         CnwYuWDW4ZR2XDzTqU4q+qjKYeVq/iSOEKutG95CitxdhGcf0hzRHl/rcB+JzB4/kGJ5
         rmabs1LvyMez3N5DDcd3g5nnorobo/Q9h9fmG8eBCH89+zYA8hL4mVVSoSlB4dGqf6p5
         BlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=/JM9m3EzADpFVwMZhlj5/PyI+PRhb52bk9jUylBvheI=;
        b=g24aotfJUAgDRQ8mSPS0NLf9KU7lBuIfFzRbbUvgFboElAz6GQMDibVwUNhAZH/MNX
         vpJsYdXjgJ2gI85otMMKK0GYNfJa/1VwdY/F3SaSw6EheC7mER/4vOfrULVKQrbOA3Ij
         xAmRb6BhBNqxSFWdAVYE028r8bM5eqKFghP9AEAahVCqJ3VWYiRWDAveksl8vtR5VWlI
         IzFlGmZm7E1hS2gC+vSvgEpuP1v3xLfGNOwZU8d+Hq2LqnCFHJ5LvdseWAGbWl7ZT1Qp
         BnrxpNrLr53ogWRzVxioOfN5q72I9RpB4iVyJYNXSt/TS2/4dfBF750vepTf+ZBKWTWP
         97dg==
X-Gm-Message-State: ANhLgQ1ZGYt/2MKxt8ngsyJdzSk2qVXa/dwWq11jB2fMHtWnzIo77k0D
        R+oLAeDvFS1m14kvWbJanci1Gw==
X-Google-Smtp-Source: ADFU+vuqWxzLyM6PLN1b0IFcvd81Zwvx6TR91AD8HV7am4WdHYGdjlevCJCSMu7M7O9x7mKynW8QBA==
X-Received: by 2002:a17:90a:24a1:: with SMTP id i30mr6400970pje.128.1583378474894;
        Wed, 04 Mar 2020 19:21:14 -0800 (PST)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k5sm13706274pfp.67.2020.03.04.19.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 19:21:14 -0800 (PST)
Message-ID: <5e60702a.1c69fb81.859e5.4fea@mx.google.com>
Date:   Wed, 04 Mar 2020 19:21:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.6-rc4-67-ga76a126302eb
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 29 runs,
 1 regressions (v5.6-rc4-67-ga76a126302eb)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 29 runs, 1 regressions (v5.6-rc4-67-ga76a126302eb)

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

10  | meson-gxl-s805x-p241         | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

11  | meson-gxl-s905d-p230         | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 0/1    =

12  | meson-gxl-s905x-khadas-vim   | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

13  | meson-gxl-s905x-libretech-cc | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

14  | meson-gxm-khadas-vim2        | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

15  | meson-gxm-q200               | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

16  | meson-sm1-khadas-vim3l       | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

17  | meson-sm1-sei610             | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

18  | minnowboard-turbot-E3826     | x86_64 | lab-collabora         | gcc-8=
    | x86_64_defconfig | 5/5    =

19  | qemu_arm64-virt-gicv2        | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

20  | qemu_arm64-virt-gicv2        | arm64  | lab-collabora         | gcc-8=
    | defconfig        | 5/5    =

21  | qemu_arm64-virt-gicv3        | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

22  | qemu_arm64-virt-gicv3        | arm64  | lab-collabora         | gcc-8=
    | defconfig        | 5/5    =

23  | qemu_x86_64                  | x86_64 | lab-baylibre          | gcc-8=
    | x86_64_defconfig | 5/5    =

24  | qemu_x86_64                  | x86_64 | lab-collabora         | gcc-8=
    | x86_64_defconfig | 5/5    =

25  | rk3399-gru-kevin             | arm64  | lab-collabora         | gcc-8=
    | defconfig        | 79/82  =

26  | rk3399-puma-haikou           | arm64  | lab-theobroma-systems | gcc-8=
    | defconfig        | 4/4    =

27  | sun50i-a64-pine64-plus       | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

28  | sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 5/5    =

29  | sun50i-h6-pine-h64           | arm64  | lab-collabora         | gcc-8=
    | defconfig        | 5/5    =



  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.6-rc4-67-ga76a126302eb
  URL:      git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it
  SHA:      a76a126302eb84e78d7d3fc9c7e69487fb97e8e4 =



Test Failures
-------------
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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc4-67-ga76a12=
6302eb/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc4-67-ga76a12=
6302eb/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.html
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
11  | meson-gxl-s905d-p230         | arm64  | lab-baylibre          | gcc-8=
    | defconfig        | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc4-67-ga76a12=
6302eb/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s905d-p230.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc4-67-ga76a12=
6302eb/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s905d-p230.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/buildroot/kci-201=
9.02-8-gd700ebb99e8f/arm64/baseline/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        new failure (last pass: v5.6-rc4-56-gf99f4dfcc7da)   =

                                             =


run | platform                     | arch   | lab                   | compi=
ler | defconfig        | results
----+------------------------------+--------+-----------------------+------=
----+------------------+--------
25  | rk3399-gru-kevin             | arm64  | lab-collabora         | gcc-8=
    | defconfig        | 79/82  =


  Results:     79 PASS, 3 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc4-67-ga76a12=
6302eb/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc4-67-ga76a12=
6302eb/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
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
