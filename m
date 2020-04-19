Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE851AFD8F
	for <lists+linux-pm@lfdr.de>; Sun, 19 Apr 2020 21:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgDSTgZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 15:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgDSTgY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 15:36:24 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F7DC061A0C
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2020 12:36:24 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b12so897982pff.4
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2020 12:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Dsxnjhvf5caBbfDVXoTy72iXEtacYt5xFBdDlMyRaKg=;
        b=uEGBd8V01bG9vNf5lP8F3ua8h5s63ChETCCvDPNXYKT7ei65sRNaPzaXs+Ig+6d680
         1S51jRXHV3taXuSeWHb9/OsJxg4BcHT/WYFfRoLUvCllGgzO3Pdm4hBkAq+s4GWD/te3
         JzOpb786Y13st/ABMNu6SeE5+BaTVNF/ly7MIXl/gVyWlJuzgWS5dLRWBuHINh/jR0Au
         ruB13wlzAftAgAJsRm8OYVvKl9kFP6//f7OT2dTO2EXfecqr3FrqoBqooavexBlag5Lg
         d4dBLOLRZ2MWlPSRgtVFMvYGLEcDy3iYOjCjwqHJAKcqprlF5q0xVPj0kuEcKz1WBJQP
         G+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Dsxnjhvf5caBbfDVXoTy72iXEtacYt5xFBdDlMyRaKg=;
        b=XLi6+kubGvuoLH1SLfZZ3SAuiA/iu4QWA8/LevgXCmlMu+CIgUto4oYFlN0uLzgJEM
         5hM19/RbCvqeRTt20g3mO900kDUZ1zGjFGeadsMJSZXzR6m+Niin6/n04x1aTi3cK1Z1
         J9PDqQ4W42XK2z9q1icxN24nZK+k6vugD40GclZrlFGpDJI0TXUCPGlX3YVIk6sW0mhk
         KaiBLKSDwvWbilkpE0zZw37Uc4Qxi2f/jULe+fB6bdBDwtD0CR2pYH7MW8y+XcI//9zk
         vSsVSC3lv7cY7L2oSuqUEHYspojFHJYhW/WJPbpkClez+TMeEpMV/Vh720XOzjl5f+l8
         skTQ==
X-Gm-Message-State: AGi0PubvFYMZeRG9DzexDS+x5HuakeHp0/4NBoLS2PR8IyddQQ/AFbCZ
        oJDCQqvvYqxr5fZuoHypSw+GTA==
X-Google-Smtp-Source: APiQypJ4XXowBTcYtzk2CBd165YuUTV6Hxk9tQD8VFHOSOgfFuDcIBOb+I7IR2ZrFupfBTV9QuhXQQ==
X-Received: by 2002:aa7:94a3:: with SMTP id a3mr7187680pfl.101.1587324983917;
        Sun, 19 Apr 2020 12:36:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o63sm12148458pjb.40.2020.04.19.12.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:36:23 -0700 (PDT)
Message-ID: <5e9ca837.1c69fb81.1bd9b.b9f2@mx.google.com>
Date:   Sun, 19 Apr 2020 12:36:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: pm-5.7-rc2-184-gc087b3aec013
Subject: pm/testing sleep: 7 runs, 0 regressions (pm-5.7-rc2-184-gc087b3aec013)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 7 runs, 0 regressions (pm-5.7-rc2-184-gc087b3aec013)

Test results summary
--------------------

run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
1   | bcm2836-rpi-2-b      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 0/1    =

2   | exynos5422-odroidxu3 | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 21/21  =

3   | imx6q-sabrelite      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =

4   | rk3288-rock2-square  | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =

5   | rk3288-veyron-jaq    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 21/21  =

6   | rk3399-gru-kevin     | arm64 | lab-collabora | gcc-8    | defconfig  =
        | 4/4    =

7   | tegra124-nyan-big    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 2/2    =



  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: pm-5.7-rc2-184-gc087b3aec013
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c087b3aec013062ef1d49510b70112a33daabb54 =



Test Failures
-------------
  =


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
1   | bcm2836-rpi-2-b      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 0/1    =


  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.7-rc2-184-gc08=
7b3aec013/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.7-rc2-184-gc08=
7b3aec013/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0417.1/armhf/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        never passed   =

         =


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
3   | imx6q-sabrelite      | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.7-rc2-184-gc08=
7b3aec013/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.7-rc2-184-gc08=
7b3aec013/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-imx6q-sabrelite.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0417.1/armhf/rootfs.cpio.gz  =


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


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
4   | rk3288-rock2-square  | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.7-rc2-184-gc08=
7b3aec013/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squ=
are.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.7-rc2-184-gc08=
7b3aec013/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squ=
are.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0417.1/armhf/rootfs.cpio.gz  =


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
