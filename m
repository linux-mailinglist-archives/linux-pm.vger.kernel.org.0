Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A6B29F58F
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 20:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgJ2Ttj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 15:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgJ2Tth (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 15:49:37 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D65EC0613CF
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 12:49:36 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id i26so3214377pgl.5
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 12:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Ob295t5ieRf0A+SuPuLvtav9VEDJk8IfEXqBcfJJIag=;
        b=zreWZcCwoaOLXRYWK872a2vZYA17kSxLHf2Xgt/VkYi2Vv7MYivoN8bI//PBUHjxIl
         ID1v9U3pgy5LuRwNj6zGyAQgYNUCpWuw+HvWSI/qnpMHEWsOTzN8dYKe3s+HrxpZsjpZ
         i0bqEtnHkyNS7YUvMCeLKc5UFCim05KGCz277bf2xme1huXbG+2vHDUKZbgi/shmlroa
         X6yQe0nWwSWVJW45rZLXjrBNdGloySLnauSGFlQArqattvEnN2sSpFxm786m08Nui6D8
         6s72zPMZecTVd1swAcEpJwrpWfg4YtfbAXh5GA64xrFmKqjq9ZOnHfxZIV/w7WEYGccc
         Jb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Ob295t5ieRf0A+SuPuLvtav9VEDJk8IfEXqBcfJJIag=;
        b=WAnPqtTvXoFnj10ir9MvU/ax9ZE7llUN5wu6x1r7JeA7/cOWJ+YC1jgfswnk3OA1Nw
         g6TY2Yj3jyaIPdBx5N6hLGs1OV8EvyBaLHAT2anMyXjBcKZ26yPbtZTZsX+6izcKgLq/
         vVzvQDt8auOBj/O/a/yx9/AHE8qeCLc3QUpmoKRFj0lFq9IXcHDCXHxbofSh2gTYPRom
         vJ2pz0Kage8VaFK2Y/ixoK+NZGCp/PgXAr5ROajcvwrGgmPKbnj3fQQ9+DjnzDSycZ9T
         gZiKBx5wfdeuOfmBJAxsdA4I0i63Bpv03rn6E+3p2xYzNs7tGH6+vfQBP2IbkrnKziFF
         Vkhw==
X-Gm-Message-State: AOAM533m5NOhUh0yHKESLWwK/VDLNnSgOWZFqrv7xkD7eOD4Z1HqfqZj
        hRI80K1n6b96ZRhqazJXxbohmmrjgSimVw==
X-Google-Smtp-Source: ABdhPJyoq2nKLDOLADExBfsTQAZ80VNHgcyZCFdfbz9O0Ee0sxNEqfJrtV6K0Zdq7QI5qJ4wPDM4eg==
X-Received: by 2002:a63:b50a:: with SMTP id y10mr5341156pge.88.1604000975982;
        Thu, 29 Oct 2020 12:49:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l2sm610748pjy.6.2020.10.29.12.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 12:49:35 -0700 (PDT)
Message-ID: <5f9b1ccf.1c69fb81.75dcd.1671@mx.google.com>
Date:   Thu, 29 Oct 2020 12:49:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10-rc1-21-gc0300fd595bb
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 115 runs,
 3 regressions (v5.10-rc1-21-gc0300fd595bb)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 115 runs, 3 regressions (v5.10-rc1-21-gc0300fd595bb)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig          | r=
egressions
----------------+-------+---------------+----------+--------------------+--=
----------
bcm2837-rpi-3-b | arm64 | lab-baylibre  | gcc-8    | defconfig          | 1=
          =

imx8mp-evk      | arm64 | lab-nxp       | gcc-8    | defconfig          | 1=
          =

panda           | arm   | lab-collabora | gcc-8    | multi_v7_defconfig | 1=
          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
1-21-gc0300fd595bb/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc1-21-gc0300fd595bb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c0300fd595bb14b0f13400d75380859f1558bcac =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig          | r=
egressions
----------------+-------+---------------+----------+--------------------+--=
----------
bcm2837-rpi-3-b | arm64 | lab-baylibre  | gcc-8    | defconfig          | 1=
          =


  Details:     https://kernelci.org/test/plan/id/5f9b12d3bc39e109f5381054

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc1-21-gc0300=
fd595bb/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc1-21-gc0300=
fd595bb/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5f9b12d3bc39e109=
f5381059
        failing since 1 day (last pass: v5.9-rc8-160-g91e0225c546b, first f=
ail: v5.10-rc1-4-ge213cd8f175c)
        2 lines

    2020-10-29 19:04:46.419000+00:00  Connected to bcm2837-rpi-3-b console =
[channel connected] (~$quit to exit)
    2020-10-29 19:04:46.419000+00:00  (user:khilman) is already connected
    2020-10-29 19:05:02.462000+00:00  =00
    2020-10-29 19:05:02.463000+00:00  =

    2020-10-29 19:05:02.463000+00:00  U-Boot 2018.11 (Dec 04 2018 - 10:54:3=
2 -0800)
    2020-10-29 19:05:02.463000+00:00  =

    2020-10-29 19:05:02.463000+00:00  DRAM:  948 MiB
    2020-10-29 19:05:02.479000+00:00  RPI 3 Model B (0xa02082)
    2020-10-29 19:05:02.565000+00:00  MMC:   mmc@7e202000: 0, sdhci@7e30000=
0: 1
    2020-10-29 19:05:02.597000+00:00  Loading Environment from FAT... *** W=
arning - bad CRC, using default environment =

    ... (383 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig          | r=
egressions
----------------+-------+---------------+----------+--------------------+--=
----------
imx8mp-evk      | arm64 | lab-nxp       | gcc-8    | defconfig          | 1=
          =


  Details:     https://kernelci.org/test/plan/id/5f9b14591c50a4bc52381031

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc1-21-gc0300=
fd595bb/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc1-21-gc0300=
fd595bb/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5f9b14591c50a4bc52381=
032
        new failure (last pass: v5.10-rc1-19-gd1cd1a35b7d5) =

 =



platform        | arch  | lab           | compiler | defconfig          | r=
egressions
----------------+-------+---------------+----------+--------------------+--=
----------
panda           | arm   | lab-collabora | gcc-8    | multi_v7_defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/5f9b118123d62b3fdc38106f

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc1-21-gc0300=
fd595bb/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc1-21-gc0300=
fd595bb/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f9b118123d62b3=
fdc381075
        failing since 71 days (last pass: v5.8-107-gb72b3ea38c81, first fai=
l: v5.9-rc1-4-g1f08d51cd57f)
        60 lines

    2020-10-29 19:01:15.641000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c802
    2020-10-29 19:01:15.647000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c803
    2020-10-29 19:01:15.653000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c804
    2020-10-29 19:01:15.659000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c805
    2020-10-29 19:01:15.665000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c806
    2020-10-29 19:01:15.671000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c807
    2020-10-29 19:01:15.676000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c808
    2020-10-29 19:01:15.682000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c809
    2020-10-29 19:01:15.689000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c80a
    2020-10-29 19:01:15.694000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c80b =

    ... (49 line(s) more)  =

 =20
