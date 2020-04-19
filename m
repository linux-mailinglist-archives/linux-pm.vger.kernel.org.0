Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A961AFD59
	for <lists+linux-pm@lfdr.de>; Sun, 19 Apr 2020 21:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDSTVZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 15:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgDSTVY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 15:21:24 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FC5C061A0C
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2020 12:21:24 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ng8so3586206pjb.2
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2020 12:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=zZPgjp033HUiwr+Oj60ac8KjdXZ+qVlgtEXyRfYarVc=;
        b=1m0mPByG2EYl23MC8Na9OUUTw/77gRuqHCSjLywT1mHFJni1KbTZrZFdrlsIBwrO2g
         pdTQoSoer8xfIyAElk5+U0JVaFjNCLLFCRP9C3quruyNKXTml8VFQLW09gHOeJoOkh4v
         kBi22nEK7hRSS5vo/xPofLeQ46FgPrXU+I3ReeardUoNTC9N0fBrdwAb7hO8kiE2orQJ
         k3uYQIJmTJPeYTCiBMtuS5kRIdQQe6/N8CMzVtyJYYLUhZxTxtlwNh1ml+hTglVwyRth
         RjsTqj/qjbo1VUSopfp+W78Y7cpAT6zcroxo34Zs38cW56EUhhtKSBQd4UfulPDXOSbu
         Fzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=zZPgjp033HUiwr+Oj60ac8KjdXZ+qVlgtEXyRfYarVc=;
        b=bqQL+NiP7+zjxWOOUZrbdfF1Es+crB0GfVrEr2fuQNaRai73e53HqNDJ/IeZCEFCzB
         UYLMp8XdSmSiaOt2iynBIpnlegtHte2DXz6zkDIu5M8Yxq62mwj8LnLIhV5STbnLyu+Y
         SPDirCvqityGkyFFKDdl9+G07NKyAL23UacWp9UBmYWOvp37b/wLRWa6KfuLAS4pK5MT
         NtOXHKKPb3/aCJtc2mUcnNBrkT4ZvGhDYkxmkmkmRK2joDBWFXHZ3JKqzvCAUKGYKw+8
         XO/XMOAH5LcpY0as8kLDxIByvwzmRHoMyZO7ILJ458U3P6R7nT8tE+jgtPr2wJugmMj9
         joIg==
X-Gm-Message-State: AGi0PubcK3z/RPe6Yf72RKJuZ+zbZcQv7+7UdyK8xrIf3Zox9pERU6rq
        ecVTQgJ4+JByc33CHDU9MPYl+uZIpr8=
X-Google-Smtp-Source: APiQypJtzG/sFS8YGnUKCRKOBjzl/PpGQc78+udSQWgSsoZ1pB3OhHwCvweh/OfoeFmBgIY7OlXyZQ==
X-Received: by 2002:a17:902:8497:: with SMTP id c23mr13829163plo.335.1587324084168;
        Sun, 19 Apr 2020 12:21:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b13sm15580409pfo.67.2020.04.19.12.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:21:23 -0700 (PDT)
Message-ID: <5e9ca4b3.1c69fb81.efcb7.9ca1@mx.google.com>
Date:   Sun, 19 Apr 2020 12:21:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: pm-5.7-rc2-184-gc087b3aec013
Subject: pm/testing baseline: 20 runs,
 0 regressions (pm-5.7-rc2-184-gc087b3aec013)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 20 runs, 0 regressions (pm-5.7-rc2-184-gc087b3aec013)

Test results summary
--------------------

run | platform                 | arch   | lab             | compiler | defc=
onfig          | results
----+--------------------------+--------+-----------------+----------+-----=
---------------+--------
1   | bcm2836-rpi-2-b          | arm    | lab-collabora   | gcc-8    | mult=
i_v7_defconfig | 0/1    =

2   | exynos4412-odroidx2      | arm    | lab-collabora   | gcc-8    | mult=
i_v7_defconfig | 4/5    =

3   | exynos5422-odroidxu3     | arm    | lab-collabora   | gcc-8    | mult=
i_v7_defconfig | 5/5    =

4   | hip07-d05                | arm64  | lab-collabora   | gcc-8    | defc=
onfig          | 3/5    =

5   | imx6dl-riotboard         | arm    | lab-pengutronix | gcc-8    | mult=
i_v7_defconfig | 5/5    =

6   | imx6q-sabrelite          | arm    | lab-collabora   | gcc-8    | mult=
i_v7_defconfig | 5/5    =

7   | imx6ul-pico-hobbit       | arm    | lab-pengutronix | gcc-8    | mult=
i_v7_defconfig | 5/5    =

8   | minnowboard-turbot-E3826 | x86_64 | lab-collabora   | gcc-8    | x86_=
64_defconfig   | 5/5    =

9   | omap4-panda              | arm    | lab-collabora   | gcc-8    | mult=
i_v7_defconfig | 5/5    =

10  | qemu_arm-virt-gicv2      | arm    | lab-collabora   | gcc-8    | mult=
i_v7_defconfig | 5/5    =

11  | qemu_arm-virt-gicv3      | arm    | lab-collabora   | gcc-8    | mult=
i_v7_defconfig | 5/5    =

12  | qemu_arm64-virt-gicv2    | arm64  | lab-collabora   | gcc-8    | defc=
onfig          | 5/5    =

13  | qemu_arm64-virt-gicv3    | arm64  | lab-collabora   | gcc-8    | defc=
onfig          | 5/5    =

14  | qemu_x86_64              | x86_64 | lab-collabora   | gcc-8    | x86_=
64_defconfig   | 5/5    =

15  | rk3288-rock2-square      | arm    | lab-collabora   | gcc-8    | mult=
i_v7_defconfig | 5/5    =

16  | rk3288-veyron-jaq        | arm    | lab-collabora   | gcc-8    | mult=
i_v7_defconfig | 68/68  =

17  | rk3399-gru-kevin         | arm64  | lab-collabora   | gcc-8    | defc=
onfig          | 85/88  =

18  | sun50i-h6-pine-h64       | arm64  | lab-collabora   | gcc-8    | defc=
onfig          | 5/5    =

19  | tegra124-jetson-tk1      | arm    | lab-collabora   | gcc-8    | mult=
i_v7_defconfig | 5/5    =

20  | tegra124-nyan-big        | arm    | lab-collabora   | gcc-8    | mult=
i_v7_defconfig | 5/5    =



  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: pm-5.7-rc2-184-gc087b3aec013
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c087b3aec013062ef1d49510b70112a33daabb54 =



Test Failures
-------------
  =


run | platform                 | arch   | lab             | compiler | defc=
onfig          | results
----+--------------------------+--------+-----------------+----------+-----=
---------------+--------
1   | bcm2836-rpi-2-b          | arm    | lab-collabora   | gcc-8    | mult=
i_v7_defconfig | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.7-rc2-184-gc08=
7b3aec013/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2=
-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.7-rc2-184-gc08=
7b3aec013/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2=
-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-9-g25091c539382/armel/baseline/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        never passed   =

      =


run | platform                 | arch   | lab             | compiler | defc=
onfig          | results
----+--------------------------+--------+-----------------+----------+-----=
---------------+--------
2   | exynos4412-odroidx2      | arm    | lab-collabora   | gcc-8    | mult=
i_v7_defconfig | 4/5    =


  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.7-rc2-184-gc08=
7b3aec013/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-od=
roidx2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.7-rc2-184-gc08=
7b3aec013/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-od=
roidx2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-9-g25091c539382/armel/baseline/rootfs.cpio.gz     =


  dmesg - 3 tests: 2  PASS, 1 FAIL, 0 SKIP
    * alert:
        never passed
        1 lines    =

         =


run | platform                 | arch   | lab             | compiler | defc=
onfig          | results
----+--------------------------+--------+-----------------+----------+-----=
---------------+--------
4   | hip07-d05                | arm64  | lab-collabora   | gcc-8    | defc=
onfig          | 3/5    =


  Results:     3 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.7-rc2-184-gc08=
7b3aec013/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.7-rc2-184-gc08=
7b3aec013/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-9-g25091c539382/arm64/baseline/rootfs.cpio.gz     =


  dmesg - 3 tests: 1  PASS, 2 FAIL, 0 SKIP
    * alert:
        never passed
        11 lines
    * emerg:
        never passed
        2 lines    =

                                          =


run | platform                 | arch   | lab             | compiler | defc=
onfig          | results
----+--------------------------+--------+-----------------+----------+-----=
---------------+--------
17  | rk3399-gru-kevin         | arm64  | lab-collabora   | gcc-8    | defc=
onfig          | 85/88  =


  Results:     85 PASS, 3 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.7-rc2-184-gc08=
7b3aec013/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.7-rc2-184-gc08=
7b3aec013/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-9-g25091c539382/arm64/baseline/rootfs.cpio.gz       =


  bootrr - 84 tests: 81  PASS, 3 FAIL, 0 SKIP
    * cros-ec-sensors-accel0-probed:
        never passed
    * cros-ec-sensors-accel1-probed:
        never passed
    * cros-ec-sensors-gyro0-probed:
        never passed  =

              =20
