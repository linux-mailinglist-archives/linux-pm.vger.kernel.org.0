Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3CF69AE45
	for <lists+linux-pm@lfdr.de>; Fri, 17 Feb 2023 15:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBQOn7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Feb 2023 09:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjBQOn6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Feb 2023 09:43:58 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F856E669
        for <linux-pm@vger.kernel.org>; Fri, 17 Feb 2023 06:43:48 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id x5so1522519plg.9
        for <linux-pm@vger.kernel.org>; Fri, 17 Feb 2023 06:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ckQgcuzHG1CIKLT7/wnp7ocM+7t7i0wzqy7ZyPNv+kk=;
        b=0ffiedaA1hOr5qs9so/jtBGHemgzAeVpqkW/uAU3AYz7XRe2KdVHSM6Qlyds/thsVP
         VJF9wgRxALEySojdUDeDx+akW25esxcgHj0uS3lli1ylJ/R6tTy4I38RcyXqCMdxfAmq
         P5pXHzvJgELynlHdteEhw0AVQvTRb8GlPvqg+DeW9hoVDh6S2n6wfHzW+VH46rK9+wTd
         Gwl6wB11A+WnFH1rVTHAJZweWikDM2M1jvCjWpwYEjyWXGFxHI4+kG579VkBa0xdgi7M
         OA7W6UvTHXHixRFi8+X2IMmYtSIyjd0j48YYU2B8bUH8Tr1xY+8GCYYF+kCTN43cgZg6
         LISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ckQgcuzHG1CIKLT7/wnp7ocM+7t7i0wzqy7ZyPNv+kk=;
        b=i02eleGqgNCXgtI1AuugiLcXIpmO9Lnt30Knx6mAPlTWuHn+ntScpeyoxgsrifzq36
         Of2p5yAc+VUYmTLo+t3tYnWkhJJ5ZSeOFSCU2PWuTgwbjXCTajWW1ExI1tgo3U9URkfb
         syM55tV5QZFW6GOuOhwPwyb4/tRg3i86Uj0dqWk4SfJ40k+pxnm3XYJbPM/NV7+OaZNR
         YEo5fCk92Pnlw3Fe0hxZUD3CgSLQXDxLUCMmGF0Uc/UF9E3L9Dcf/b5GiOQAGiWXQgQ6
         hieHq297Z87paCd64Plv66V7C5UoqtW+EsX3BUY6eTGsB24orNcq6Cykjg/I5BUvD36t
         l5tg==
X-Gm-Message-State: AO0yUKWFP3ZuFOg+A5ZMj5aMkSBlxri3wQW4sgymZj1Eew16iNRzaAu5
        bOqqCF12LrHC2BSDR8R5JVYlSQ==
X-Google-Smtp-Source: AK7set8R4alA3C/58hClbRRPP06ZnjClmiflmjuvcaSxhoviH6magXSFY4IvKE1aqSdYNdSoJkdBTw==
X-Received: by 2002:a17:902:fa8e:b0:19a:b4a9:9ddb with SMTP id lc14-20020a170902fa8e00b0019ab4a99ddbmr1402891plb.49.1676645028373;
        Fri, 17 Feb 2023 06:43:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v5-20020a170902b7c500b00199193e5ea1sm3260625plz.61.2023.02.17.06.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 06:43:48 -0800 (PST)
Message-ID: <63ef92a4.170a0220.ae305.6376@mx.google.com>
Date:   Fri, 17 Feb 2023 06:43:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: pm-6.2-rc9-232-gea150b53b1fd
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 30 runs,
 3 regressions (pm-6.2-rc9-232-gea150b53b1fd)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 30 runs, 3 regressions (pm-6.2-rc9-232-gea150b53b1fd)

Regressions Summary
-------------------

platform               | arch   | lab             | compiler | defconfig   =
       | regressions
-----------------------+--------+-----------------+----------+-------------=
-------+------------
imx53-qsrb             | arm    | lab-pengutronix | gcc-10   | multi_v7_def=
config | 1          =

qemu_x86_64-uefi       | x86_64 | lab-collabora   | gcc-10   | x86_64_defco=
nfig   | 1          =

qemu_x86_64-uefi-mixed | x86_64 | lab-collabora   | gcc-10   | x86_64_defco=
nfig   | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-6.2-r=
c9-232-gea150b53b1fd/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: pm-6.2-rc9-232-gea150b53b1fd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      ea150b53b1fd250a0c49f9ade353634dd7976fbf =



Test Regressions
---------------- =



platform               | arch   | lab             | compiler | defconfig   =
       | regressions
-----------------------+--------+-----------------+----------+-------------=
-------+------------
imx53-qsrb             | arm    | lab-pengutronix | gcc-10   | multi_v7_def=
config | 1          =


  Details:     https://kernelci.org/test/plan/id/63ef86843112f2b5fc8c864c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-6.2-rc9-232-gea1=
50b53b1fd/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-6.2-rc9-232-gea1=
50b53b1fd/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63ef86843112f2b5fc8c8655
        failing since 20 days (last pass: v6.1-rc8-156-g0a9e32afe717, first=
 fail: acpi-6.2-rc6-146-g628c61874ffd)

    2023-02-17T13:51:44.301189  + set +x
    2023-02-17T13:51:44.301357  [   12.896577] <LAVA_SIGNAL_ENDRUN 0_dmesg =
907281_1.5.2.3.1>
    2023-02-17T13:51:44.409366  / # #
    2023-02-17T13:51:44.511131  export SHELL=3D/bin/sh
    2023-02-17T13:51:44.511572  #
    2023-02-17T13:51:44.613067  / # export SHELL=3D/bin/sh. /lava-907281/en=
vironment
    2023-02-17T13:51:44.613648  =

    2023-02-17T13:51:44.715036  / # . /lava-907281/environment/lava-907281/=
bin/lava-test-runner /lava-907281/1
    2023-02-17T13:51:44.715551  =

    2023-02-17T13:51:44.718778  / # /lava-907281/bin/lava-test-runner /lava=
-907281/1 =

    ... (12 line(s) more)  =

 =



platform               | arch   | lab             | compiler | defconfig   =
       | regressions
-----------------------+--------+-----------------+----------+-------------=
-------+------------
qemu_x86_64-uefi       | x86_64 | lab-collabora   | gcc-10   | x86_64_defco=
nfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/63ef86ce27416962108c8672

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-6.2-rc9-232-gea1=
50b53b1fd/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-qemu_x86_64=
-uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-6.2-rc9-232-gea1=
50b53b1fd/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-qemu_x86_64=
-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63ef86ce27416962108c8=
673
        new failure (last pass: v6.2-rc7-185-gbe3ba1769837) =

 =



platform               | arch   | lab             | compiler | defconfig   =
       | regressions
-----------------------+--------+-----------------+----------+-------------=
-------+------------
qemu_x86_64-uefi-mixed | x86_64 | lab-collabora   | gcc-10   | x86_64_defco=
nfig   | 1          =


  Details:     https://kernelci.org/test/plan/id/63ef86cce1096f0f938c8657

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-6.2-rc9-232-gea1=
50b53b1fd/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-qemu_x86_64=
-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-6.2-rc9-232-gea1=
50b53b1fd/x86_64/x86_64_defconfig/gcc-10/lab-collabora/baseline-qemu_x86_64=
-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230211.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63ef86cce1096f0f938c8=
658
        new failure (last pass: v6.2-rc7-179-g929367dbdffe) =

 =20
