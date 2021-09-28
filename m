Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB0941BB7D
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 01:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243358AbhI1X7w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Sep 2021 19:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243379AbhI1X7s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Sep 2021 19:59:48 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A71BC061746
        for <linux-pm@vger.kernel.org>; Tue, 28 Sep 2021 16:58:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w11so235452plz.13
        for <linux-pm@vger.kernel.org>; Tue, 28 Sep 2021 16:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=aOG+DMm3PavGubUYubBpnS0bVEEfNkS3GwZxcj930yw=;
        b=ywHdLZ9vnbHjbu7uGsztMmjhH0hBsRWZ0nYqaUHghZHUrROJLnmNiEHxgaca/ssZxV
         vLs7P6WsbgqYqMBY3MHDnucE5PxDk6yabNLbLNuw57/+BIUjBwZo5RnK3iUb13My9Q+L
         qznqc802lRkgW117+jKUt2gbkpSDpbti05JHgxPpuV8hhj5tNVHEMls35zaf362XLHrv
         6Ww/q7iVF8uyYugd/MLJsCwy3PqV7iO+z/TF8vb8muSso9vRHIuHe8K7XJDqLmIBep7J
         y2CmttxgqnAzFYK40kBc5MLC0vd++a/UlquDTvMATg9f1v2tWzJws/MXBt0juLvJDd5V
         8KWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=aOG+DMm3PavGubUYubBpnS0bVEEfNkS3GwZxcj930yw=;
        b=WL9hKTmAUteTeFa66GI2hGOQD6HC7PHM/EXMzMEDzwA+dBTwtMm2uOIXDTf3hnfOfr
         PfrFCdpGi4xq2XkNb5mb5G8ZiPAH5DiEnUiL8xCFmekumzmcOhFw9nU4f7B5ACi2KPSU
         NBK15WAtITryYwFNXWhW27F0inu+as3nheulDZ6bTMtMZl2mKeaoqW1hP/DUFqHkajra
         hoPg4qO7Yfhu0g9TUpgDilQGX1UVCmNGqS1FFZT8Ir4Xl40qGbyBbd9cZrHWtbhmrjPy
         4DSd98feuLbPfOiWhqFDI7lWA4NHknNK69oIdlGDDYwAxhbaXM103OCcPmICe9pXf0Hc
         mCTQ==
X-Gm-Message-State: AOAM531VbWLMnI3ylVJEioHQvDxtmkPzaqLXY49ItKQufAhOXWqUYBND
        kPUVMPLRGbDUdOKELhLrFAmm6LK3unefLgiY
X-Google-Smtp-Source: ABdhPJwzzTThfLNFE0zntBt5VI5Iuj57XvEyMzB3nPOiyjOI3QD4H0CZQVlhbXTfyaA4qxlfXKQBDw==
X-Received: by 2002:a17:90b:3a8f:: with SMTP id om15mr2989688pjb.51.1632873487694;
        Tue, 28 Sep 2021 16:58:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t13sm192212pjg.25.2021.09.28.16.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 16:58:07 -0700 (PDT)
Message-ID: <6153ac0f.1c69fb81.3c39c.1380@mx.google.com>
Date:   Tue, 28 Sep 2021 16:58:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc3-23-g5264d800ffd5
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 75 runs,
 4 regressions (v5.15-rc3-23-g5264d800ffd5)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 75 runs, 4 regressions (v5.15-rc3-23-g5264d800ffd5)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
beagle-xm        | arm   | lab-baylibre  | gcc-8    | multi_v7_defconfig | =
1          =

hip07-d05        | arm64 | lab-collabora | gcc-8    | defconfig          | =
1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
3-23-g5264d800ffd5/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc3-23-g5264d800ffd5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5264d800ffd532b515f32ad3a3439b5611438157 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
beagle-xm        | arm   | lab-baylibre  | gcc-8    | multi_v7_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6153a2bdb8991f0f8299a2db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc3-23-g5264d=
800ffd5/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc3-23-g5264d=
800ffd5/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6153a2bdb8991f0f8299a=
2dc
        new failure (last pass: v5.15-rc3-18-g7c86bb8dfc1b) =

 =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
hip07-d05        | arm64 | lab-collabora | gcc-8    | defconfig          | =
1          =


  Details:     https://kernelci.org/test/plan/id/6153a30ef19f14c9b299a2e1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc3-23-g5264d=
800ffd5/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc3-23-g5264d=
800ffd5/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6153a30ef19f14c9b299a=
2e2
        failing since 90 days (last pass: pm-5.13-rc8-159-g3304616e985f, fi=
rst fail: devprop-5.13-rc8-173-ge132b9a1079c) =

 =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
2          =


  Details:     https://kernelci.org/test/plan/id/61539f752447e3c2fc99a2e3

  Results:     89 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc3-23-g5264d=
800ffd5/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc3-23-g5264d=
800ffd5/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/61539f752447e3c2fc99a2e9
        failing since 78 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-09-28T23:04:13.405420  /lava-4599568/1/../bin/lava-test-case
    2021-09-28T23:04:13.416504  <8>[   25.546868] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/61539f752447e3c2fc99a2ea
        failing since 78 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-09-28T23:04:11.348890  <8>[   23.477863] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>
    2021-09-28T23:04:12.369750  /lava-4599568/1/../bin/lava-test-case
    2021-09-28T23:04:12.382366  <8>[   24.511894] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>   =

 =20
