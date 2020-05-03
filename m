Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3E61C2ADE
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 11:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgECJQ5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 05:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgECJQ4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2020 05:16:56 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651A7C061A0C
        for <linux-pm@vger.kernel.org>; Sun,  3 May 2020 02:16:55 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t16so5561842plo.7
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2020 02:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=dKheKIl+HzrQoKcAIW+W1McBqWU+UD71Pljgu088DE8=;
        b=tFYKLgmRQ8NYSJf6x7m8XkiYc4OW9pW0YoxtCA2hjcDz/8r/rgqFB7+xd1PdW3JD95
         BIeONdnz5Bg8C3Ut35yN/MAD/qqnnewmz3XBnwlEm4CZcz6rPvTsTmJWCtoIwvjG7oPq
         wPKv6JHmZSH1iBQn9wwO8SzeOkEBEWumGh0O8oOPMoG9XdnAxsJ61/3pf/Pjvg/T9lZV
         yMDKgdybfACU+vzK8LPsYKyaUtwdnM2iEcvnsqP10ONOGZZryuSPy1g6eRCeV4kAJ3nf
         iFQaRrvTSpcOUoFMigxVuwBC06xi38gK3CRFltTjauX0e2xvTxJHmN+yUfKyFlt7A4W/
         HRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=dKheKIl+HzrQoKcAIW+W1McBqWU+UD71Pljgu088DE8=;
        b=aGMtuaGxo0rpvNEcNKVE/DuKNOJS9PegXE3agDQiXeOhhx/npO4c9yY4zHbpA0S1Ke
         l6tI9QrPlvod3ExvitGK1Yt1ls/cray5KYCTk96U8unr9cNUHInCRz6ejM1bl/KfixUT
         QJzH1YHic4zuklDt/zpagkMb6UIL/5rDDCG/PSWesv0jivQjvwho1iWCIq4lMLnthyIk
         BSGJzDv/UZchqgNvCtvITvWi8+j5X+2e4r3kJcjCFBb3piMM27DqjGpvaqZ4t16+nkdJ
         XpJC+T0jcl/NjC7/zqKq4LkBwuAmanTGlJnvhJExj5ezjQRLd3V39hUm3HkGRjcit+HT
         4AUQ==
X-Gm-Message-State: AGi0PubHjev0+IQRnucqdvhW0KII8QuHKYVgDYVYADxgnA3JDttTu6um
        ySUHVEyDz2g7naObB/UwBeNlHfAsOD8=
X-Google-Smtp-Source: APiQypLY53WBX+xLVt3KLGjSVRjYaks25NTEtl8x9QDcQ8bYsrRf8NzNH5TK0YNDIL1+C5ei3ysXbQ==
X-Received: by 2002:a17:902:fe03:: with SMTP id g3mr12647531plj.28.1588497414967;
        Sun, 03 May 2020 02:16:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d18sm6166196pfq.177.2020.05.03.02.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 02:16:54 -0700 (PDT)
Message-ID: <5eae8c06.1c69fb81.58467.8d7a@mx.google.com>
Date:   Sun, 03 May 2020 02:16:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc3-24-g1985b45de014
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 6 runs, 0 regressions (v5.7-rc3-24-g1985b45de014)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 0 regressions (v5.7-rc3-24-g1985b45de014)

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

3   | rk3288-rock2-square  | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =

4   | rk3288-veyron-jaq    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 21/21  =

5   | rk3399-gru-kevin     | arm64 | lab-collabora | gcc-8    | defconfig  =
        | 11/11  =

6   | tegra124-nyan-big    | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 2/2    =



  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.7-rc3-24-g1985b45de014
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1985b45de01473658db9194e948eb151f9e076ae =



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
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc3-24-g1985b4=
5de014/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc3-24-g1985b4=
5de014/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0424.0/armhf/rootfs.cpio.gz  =


  1 tests: 0 PASS, 1 FAIL, 0 SKIP
    * login:
        never passed   =

         =


run | platform             | arch  | lab           | compiler | defconfig  =
        | results
----+----------------------+-------+---------------+----------+------------=
--------+--------
3   | rk3288-rock2-square  | arm   | lab-collabora | gcc-8    | multi_v7_de=
fconfig | 1/21   =


  Results:     1 PASS, 20 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc3-24-g1985b4=
5de014/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc3-24-g1985b4=
5de014/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-square=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0424.0/armhf/rootfs.cpio.gz  =


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
