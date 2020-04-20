Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6921B06CF
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 12:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgDTKoc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 06:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTKoc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 06:44:32 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B7EC061A0C
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2020 03:44:32 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id d17so4866313pgo.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2020 03:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=d2KJ1pmbY8epYP6qvMcIL5L+dVBhCEdbzPyMNVvITYI=;
        b=gzF+r6o4sGwlXEaKd+wOD1oSJQCobIffI2po03EeVHBZ52VwaJ4kFFOObk/N5wseN3
         YTLAyV7euN8Iu1E6liVOrYzGJvorQcZGaNeJM0P2kaqWI7J25HAAel8YS+LNpQHBbr33
         hVbni8SJvI1lq4e/Efljsf/+qSUkL6UGUNSFkem3HxTXWjHE3fyWcfCSK5NRY9F5aMYD
         77Ci/eNfzKL5kBjRgMdoYQNAaLa/7n0hTxKlRHcjpv5QsII8/i+5RDPbre7eP46VaDXs
         +CoOsQFbS/O67jrh3UXAOpqq2plxTuskfTbnzpbZQfI1SPpS/2OW1rQhd8N0hVq0VjBp
         +ZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=d2KJ1pmbY8epYP6qvMcIL5L+dVBhCEdbzPyMNVvITYI=;
        b=r6PeDwUeYf9PKMvVnWOj6k7+UXEOe+MGSimV/jxvMrMe9Yx+BEdzQ3e/ta57sdSZ73
         whK5Ci3jefGgK+sqcBuv11xnzIQUL6TRN/rjo+r4Or0K9LJn1fyEPj3KwRKCff34vXWt
         j9yl071ETvG2hZqCvVJQBXbKH5Rm1kb8jIiIwLIMoFqgQSB+axFcSdcBbuI5ztZ11jxp
         gGvbSmqw7+BiN/1Y343fhBXFIs3xOPFD7oVpGNwd3S8ijKs/sF8vpbJUiXf/WgtMDeLI
         CS8EAH+WcIwcVhTVUTaHQqw/L4UXR65/MuMvZGqGlp4+GROSh32/ke9GnMwqIDSOT7On
         sJGw==
X-Gm-Message-State: AGi0PuZulEyc9z/UAhAlVaeLDZWgMX141+YRSG6jtnlha6ze744H8+uz
        OXwwEIA+2GcflMKGU9bgDlFeZg==
X-Google-Smtp-Source: APiQypIvbotJ7zyW+TfEtRC6+ORHafyqPrIRMAo1oIeY+G5b5POkvI3Je0TS1BRT7fTrmTcgYck04w==
X-Received: by 2002:aa7:9345:: with SMTP id 5mr4841533pfn.145.1587379471494;
        Mon, 20 Apr 2020 03:44:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i18sm774968pjx.33.2020.04.20.03.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 03:44:30 -0700 (PDT)
Message-ID: <5e9d7d0e.1c69fb81.9b625.1cb1@mx.google.com>
Date:   Mon, 20 Apr 2020 03:44:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc2-16-g247f4817f956
Subject: pm/testing baseline: 18 runs,
 0 regressions (v5.7-rc2-16-g247f4817f956)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 18 runs, 0 regressions (v5.7-rc2-16-g247f4817f956)

Test results summary
--------------------

run | platform              | arch   | lab             | compiler | defconf=
ig          | results
----+-----------------------+--------+-----------------+----------+--------=
------------+--------
1   | bcm2836-rpi-2-b       | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 0/1    =

2   | exynos4412-odroidx2   | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 4/5    =

3   | exynos5422-odroidxu3  | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 5/5    =

4   | hip07-d05             | arm64  | lab-collabora   | gcc-8    | defconf=
ig          | 3/5    =

5   | imx6dl-riotboard      | arm    | lab-pengutronix | gcc-8    | multi_v=
7_defconfig | 5/5    =

6   | imx6ul-pico-hobbit    | arm    | lab-pengutronix | gcc-8    | multi_v=
7_defconfig | 5/5    =

7   | omap4-panda           | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 5/5    =

8   | qemu_arm-virt-gicv2   | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 5/5    =

9   | qemu_arm-virt-gicv3   | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 5/5    =

10  | qemu_arm64-virt-gicv2 | arm64  | lab-collabora   | gcc-8    | defconf=
ig          | 5/5    =

11  | qemu_arm64-virt-gicv3 | arm64  | lab-collabora   | gcc-8    | defconf=
ig          | 5/5    =

12  | qemu_x86_64           | x86_64 | lab-collabora   | gcc-8    | x86_64_=
defconfig   | 5/5    =

13  | rk3288-rock2-square   | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 5/5    =

14  | rk3288-veyron-jaq     | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 68/68  =

15  | rk3399-gru-kevin      | arm64  | lab-collabora   | gcc-8    | defconf=
ig          | 85/88  =

16  | sun50i-h6-pine-h64    | arm64  | lab-collabora   | gcc-8    | defconf=
ig          | 5/5    =

17  | tegra124-jetson-tk1   | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 5/5    =

18  | tegra124-nyan-big     | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 5/5    =



  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.7-rc2-16-g247f4817f956
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      247f4817f95659c2102343dedb580362ae60eb86 =



Test Failures
-------------
  =


run | platform              | arch   | lab             | compiler | defconf=
ig          | results
----+-----------------------+--------+-----------------+----------+--------=
------------+--------
1   | bcm2836-rpi-2-b       | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc2-16-g247f48=
17f956/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc2-16-g247f48=
17f956/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-9-g25091c539382/armel/baseline/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        never passed   =

      =


run | platform              | arch   | lab             | compiler | defconf=
ig          | results
----+-----------------------+--------+-----------------+----------+--------=
------------+--------
2   | exynos4412-odroidx2   | arm    | lab-collabora   | gcc-8    | multi_v=
7_defconfig | 4/5    =


  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc2-16-g247f48=
17f956/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odroi=
dx2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc2-16-g247f48=
17f956/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos4412-odroi=
dx2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-9-g25091c539382/armel/baseline/rootfs.cpio.gz     =


  dmesg - 3 tests: 2  PASS, 1 FAIL, 0 SKIP
    * alert:
        never passed
        1 lines    =

         =


run | platform              | arch   | lab             | compiler | defconf=
ig          | results
----+-----------------------+--------+-----------------+----------+--------=
------------+--------
4   | hip07-d05             | arm64  | lab-collabora   | gcc-8    | defconf=
ig          | 3/5    =


  Results:     3 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc2-16-g247f48=
17f956/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc2-16-g247f48=
17f956/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.html
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


run | platform              | arch   | lab             | compiler | defconf=
ig          | results
----+-----------------------+--------+-----------------+----------+--------=
------------+--------
15  | rk3399-gru-kevin      | arm64  | lab-collabora   | gcc-8    | defconf=
ig          | 85/88  =


  Results:     85 PASS, 3 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc2-16-g247f48=
17f956/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc2-16-g247f48=
17f956/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
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
