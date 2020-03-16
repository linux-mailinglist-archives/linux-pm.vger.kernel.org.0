Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE88186C6B
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 14:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbgCPNpu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 09:45:50 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:35045 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731366AbgCPNpu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Mar 2020 09:45:50 -0400
Received: by mail-pg1-f180.google.com with SMTP id 7so9797680pgr.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2020 06:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=KTODTMXEAgbUcDs4oc3FkLmXiCorVUbLJBqgsFYsZGU=;
        b=ObR1cs92skadgm5YXWnj1QQl1945nFR/66rgnwGOctWZtlzcBSaFohWDc1JakVPF1t
         78QmmyeXKl0xCXSZYIr4hzTMpuIuuQeXrzj5iGdxlC6UPuXO70BVXlCmKnHylMRigmy+
         mLD2QODsR5Y0RbfliyHi6NwPPnS1++9P+C/72GV85wnoQ66PORCD64/0AvNgCgwbE2Ym
         HQC5wAlqVbrAaFyNGVNTdIK0FCy7t+gmxcDFQVS+9ZvYYR2Wc38J4GHf1+l3VmcjLSj+
         WLLcHij/yN2cYhI0BkRhDJVQjUsGsLulKjxt6HoeYjQHNhJzgeo91GrfZuh1Fz4RSD4/
         35zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=KTODTMXEAgbUcDs4oc3FkLmXiCorVUbLJBqgsFYsZGU=;
        b=hHRxICpuJ5mgMO0xjX4OoR5+/FKJP2YNdzO6s70c2TQytyO6hv1V9xIA5jId4PZov2
         GzWpydKe4IccwbKEfmruXSjjhi5V4nXvyL+S99nvQlsqi+4X83s7lqIYxezUnVd7JJWh
         KY/kxB5nOt0jLQMA3H1XkIVf2fLVmcZijPcFMiySieL/dsvy/HRTvA06KgyayKLzHrXk
         vOvJquZvRsOeWubeMYnPnE7o2WdpLv10YoiSgu+z+UDRwIlqqJGOpbal/XOIb0Zhwzs/
         Qp710BSTv3712PjF3alK3qBbSqOtWnnARxD2VADM6UNGqWIpw+RnPNaLuMbGw+nB0bmB
         NU+g==
X-Gm-Message-State: ANhLgQ3OsivDteQC1V4efRGuZYXrz2cJCAG/7474RcZIxAtX+8eS06DR
        T+3GlrUm2vWJZcXGX/pStK0m1g==
X-Google-Smtp-Source: ADFU+vusHajIgqsiuuRITJ2B6pv4uu6T9S9pRFid47ZzZ8CUzQfaJVTW5n3JVwagc1Wtr9C3HELxcw==
X-Received: by 2002:aa7:8806:: with SMTP id c6mr26782255pfo.175.1584366348603;
        Mon, 16 Mar 2020 06:45:48 -0700 (PDT)
Received: from [10.0.9.4] ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z20sm36149029pge.62.2020.03.16.06.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 06:45:47 -0700 (PDT)
Message-ID: <5e6f830b.1c69fb81.929bd.f93f@mx.google.com>
Date:   Mon, 16 Mar 2020 06:45:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.6-rc6-99-g90f425b95754
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 6 runs, 0 regressions (v5.6-rc6-99-g90f425b95754)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 0 regressions (v5.6-rc6-99-g90f425b95754)

Test results summary
--------------------

run | platform             | arch | lab           | compiler | defconfig   =
       | results
----+----------------------+------+---------------+----------+-------------=
-------+--------
1   | bcm2836-rpi-2-b      | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 0/1    =

2   | exynos5422-odroidxu3 | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 21/21  =

3   | imx6q-sabrelite      | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 1/21   =

4   | rk3288-rock2-square  | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 1/21   =

5   | rk3288-veyron-jaq    | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 21/21  =

6   | tegra124-nyan-big    | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 2/2    =



  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.6-rc6-99-g90f425b95754
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      90f425b95754aa7c6e93f239ae73e7d250a58e98 =



Test Failures
-------------
  =


run | platform             | arch | lab           | compiler | defconfig   =
       | results
----+----------------------+------+---------------+----------+-------------=
-------+--------
1   | bcm2836-rpi-2-b      | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-99-g90f425=
b95754/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-99-g90f425=
b95754/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0306.1/armhf/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        never passed   =

         =


run | platform             | arch | lab           | compiler | defconfig   =
       | results
----+----------------------+------+---------------+----------+-------------=
-------+--------
3   | imx6q-sabrelite      | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-99-g90f425=
b95754/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-99-g90f425=
b95754/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0306.1/armhf/rootfs.cpio.gz  =


  21 tests: 1 PASS, 20 FAIL, 0 SKIP
    * rtcwake-mem-1:
        never passed
    * rtcwake-mem-2:
        never passed
    * rtcwake-mem-3:
        never passed
    * rtcwake-mem-4:
        never passed
    * rtcwake-mem-5:
        never passed
    * rtcwake-mem-6:
        never passed
    * rtcwake-mem-7:
        never passed
    * rtcwake-mem-8:
        never passed
    * rtcwake-mem-9:
        never passed
    * rtcwake-mem-10:
        never passed
    * rtcwake-freeze-1:
        never passed
    * rtcwake-freeze-2:
        never passed
    * rtcwake-freeze-3:
        never passed
    * rtcwake-freeze-4:
        never passed
    * rtcwake-freeze-5:
        never passed
    * rtcwake-freeze-6:
        never passed
    * rtcwake-freeze-7:
        never passed
    * rtcwake-freeze-8:
        never passed
    * rtcwake-freeze-9:
        never passed
    * rtcwake-freeze-10:
        never passed   =

      =


run | platform             | arch | lab           | compiler | defconfig   =
       | results
----+----------------------+------+---------------+----------+-------------=
-------+--------
4   | rk3288-rock2-square  | arm  | lab-collabora | gcc-8    | multi_v7_def=
config | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.6-rc6-99-g90f425=
b95754/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.6-rc6-99-g90f425=
b95754/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0306.1/armhf/rootfs.cpio.gz  =


  21 tests: 1 PASS, 20 FAIL, 0 SKIP
    * rtcwake-mem-1:
        never passed
    * rtcwake-mem-2:
        never passed
    * rtcwake-mem-3:
        never passed
    * rtcwake-mem-4:
        never passed
    * rtcwake-mem-5:
        never passed
    * rtcwake-mem-6:
        never passed
    * rtcwake-mem-7:
        never passed
    * rtcwake-mem-8:
        never passed
    * rtcwake-mem-9:
        never passed
    * rtcwake-mem-10:
        never passed
    * rtcwake-freeze-1:
        never passed
    * rtcwake-freeze-2:
        never passed
    * rtcwake-freeze-3:
        never passed
    * rtcwake-freeze-4:
        never passed
    * rtcwake-freeze-5:
        never passed
    * rtcwake-freeze-6:
        never passed
    * rtcwake-freeze-7:
        never passed
    * rtcwake-freeze-8:
        never passed
    * rtcwake-freeze-9:
        never passed
    * rtcwake-freeze-10:
        never passed   =

           =20
