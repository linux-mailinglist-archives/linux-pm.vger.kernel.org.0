Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536A73F0A3E
	for <lists+linux-pm@lfdr.de>; Wed, 18 Aug 2021 19:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhHRR1U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Aug 2021 13:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhHRR1U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Aug 2021 13:27:20 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606ECC061764
        for <linux-pm@vger.kernel.org>; Wed, 18 Aug 2021 10:26:45 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id c17so2968345pgc.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Aug 2021 10:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=2afRP+XUbMakn+AepSZQpJTopshVOdBPKHho93Jf7fM=;
        b=CNdRJRb3yM3QfaJOwk8ntf3b/AAogWtmvMG/l1f0SkqOjdmdGiQ/h/hrrvy7iJmCkV
         2/mZ98va0K+DM5ADIAFW+ZvBKlBNjvjYqVZvycLpmuyAvuxJsQ8txRbLGCFLPT0PlZHD
         PTP5gHQhjPgP1D8rsNHjesKBI1kH2fnO6aLIihJ3u8Z6XZpkMT64eKusOSTX4aVJ5xg0
         KwSgQmJtK+xxy5HpY8C+LR3BHP0JBBVuILF8BgIHlfF/8ATJLNQCzrG3HvvK84Yl426a
         xMtmvESF3g5L9E0S73JGdiQWGw8CzMPr2GvKkZkY4bgq6cZJgda2ZsDc1QReR2op579c
         1O/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=2afRP+XUbMakn+AepSZQpJTopshVOdBPKHho93Jf7fM=;
        b=IXX50wixL3gIROHeqK5T+QB7rBqGyUP2IweZLP0c0cszokxbHhrE4Ue+xVNmIenRey
         oF8hi8eDaqoK/AR2hobP2K2FXxNGrcWnjpkPp987Jfab3tHxW8XY3xvow+Af5hk8ivSK
         3CHsqejZOPfZZUJPhQE/wDgrDdr00819+paEqCr1iq50sWQUpx/hggPqxBzttgSeKlx3
         ZTwkGHJW1xuvmp5psCgMIGC7fcCxzAwFeQgMRq5w87Dujbiio+KuSwlmlezpCe4DH8DZ
         tFU+yNN1xa04QaE4w4p5vS2JX59XvQs/EOzqYKYy8BEBIODsTXbrfEPXN738Hx7DjGsX
         73KA==
X-Gm-Message-State: AOAM531+s3iVCjJKR00bBJ1Nvx/muPIj+m/pH+aoPBAet2Oc1CqTkTPQ
        fXLx7GsdpA9j+JF/BJzS+f/dMd89hJ7A+5no
X-Google-Smtp-Source: ABdhPJxoq4FxC8PBofIM8JNmfffh6dSC15gaXazn0Ep21QtP83gdoy+cxn6TDzRHvNWy0TCvXxdtiA==
X-Received: by 2002:a05:6a00:1808:b0:3e1:f8c5:3436 with SMTP id y8-20020a056a00180800b003e1f8c53436mr10483026pfa.3.1629307604777;
        Wed, 18 Aug 2021 10:26:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d14sm373433pfl.90.2021.08.18.10.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 10:26:44 -0700 (PDT)
Message-ID: <611d42d4.1c69fb81.98455.179c@mx.google.com>
Date:   Wed, 18 Aug 2021 10:26:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.14-rc6-60-g10bc7fbefe3a
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 83 runs,
 4 regressions (v5.14-rc6-60-g10bc7fbefe3a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 83 runs, 4 regressions (v5.14-rc6-60-g10bc7fbefe3a)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
bcm2837-rpi-3-b  | arm64 | lab-baylibre  | gcc-8    | defconfig          | =
1          =

beagle-xm        | arm   | lab-baylibre  | gcc-8    | multi_v7_defconfig | =
1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.14-rc=
6-60-g10bc7fbefe3a/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.14-rc6-60-g10bc7fbefe3a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      10bc7fbefe3a9ab4a8e7531752e200ceff5919c7 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
bcm2837-rpi-3-b  | arm64 | lab-baylibre  | gcc-8    | defconfig          | =
1          =


  Details:     https://kernelci.org/test/plan/id/611d3df54503f9cd50b13672

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc6-60-g10bc7=
fbefe3a/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc6-60-g10bc7=
fbefe3a/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/611d3df54503f9cd50b13=
673
        failing since 36 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1) =

 =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
beagle-xm        | arm   | lab-baylibre  | gcc-8    | multi_v7_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/611d38b379cf05064eb13678

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc6-60-g10bc7=
fbefe3a/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc6-60-g10bc7=
fbefe3a/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/611d38b379cf05064eb13=
679
        failing since 12 days (last pass: v5.14-rc3-20-g604483c9d252, first=
 fail: v5.14-rc4-28-g9ac32de19606) =

 =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
2          =


  Details:     https://kernelci.org/test/plan/id/611d3e51e15fe53e58b136ab

  Results:     89 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc6-60-g10bc7=
fbefe3a/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc6-60-g10bc7=
fbefe3a/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/611d3e51e15fe53e58b136b5
        failing since 36 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-08-18T17:07:11.672164  /lava-4378255/1/../bin/lava-test-case
    2021-08-18T17:07:11.683359  <8>[   25.069882] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/611d3e51e15fe53e58b136b6
        failing since 36 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-08-18T17:07:09.615679  <8>[   23.000538] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>
    2021-08-18T17:07:10.637504  /lava-4378255/1/../bin/lava-test-case
    2021-08-18T17:07:10.648896  <8>[   24.034983] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>   =

 =20
