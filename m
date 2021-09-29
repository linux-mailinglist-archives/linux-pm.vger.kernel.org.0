Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEDC41CF57
	for <lists+linux-pm@lfdr.de>; Thu, 30 Sep 2021 00:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343498AbhI2Wna (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 18:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245276AbhI2Wn0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 18:43:26 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7E5C06161C
        for <linux-pm@vger.kernel.org>; Wed, 29 Sep 2021 15:41:45 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 17so4251094pgp.4
        for <linux-pm@vger.kernel.org>; Wed, 29 Sep 2021 15:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=IfuYit17Iu6M/GxWxQJQONiF6oiTjmZSMhYZVR8QPMc=;
        b=v6kSrxdcb08VNRKG0HI9Cv8FsAGfTH132uEQpvIkQ0nXsfqJvnl00ZKLemJb0zib3U
         gWFD1vqQJxdNsELv+MpXmeGqILxHDK3Pdsmi7PM8/lwgR7RlQnn0QhtRCrzlwuwCLnjE
         GR5hl523ugjjvQdtS3WV9MWJPryssRRLmBNakfccv38XGjA6Dmjb2tMWWA/6URS4G5Ja
         kauk2VPZXSxyeyc/nyLsUit53JfM78J3bXJsD3mGkvVSRzG0zBFeRK3iKF2xurrIwqfZ
         qgS9ZDJx7Tnsfb/1FU6unGqeqMRuUrgj82yn+Xgx3/AISX4PgzRocQL31unZJDc8mgqs
         Pn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=IfuYit17Iu6M/GxWxQJQONiF6oiTjmZSMhYZVR8QPMc=;
        b=q+3M54E+EGRFrRTzzlUksjOYDBp8OUfBhzu9ojhixnR9UGwCyNTMCEREiwRmHXV42a
         +ojArmnaurj3F31eGgw9MI1/jEOMPrNAIjM6aydFJXS1oARZJXwOhG6fyyLdHPGHOZLf
         BZn1kCKm/lLgHYP8YooIIeeJB/XRWGIR25nTagJ2kQWTj3hx3wT8RODhDtGFwosJVgEB
         gAZQyAn1BudjwIAHwnc02fXHKhFmkCd4C76p3rhQdcZGxD7CyES48oJeSghj4CCJZZIz
         c8R2rBZLYaInMa8RoaFEJtDVm7I31n99Fd11nwh7hgEGsVIOHI49/+ZfV96+MGILHvtP
         flLg==
X-Gm-Message-State: AOAM531aqUhVQzKmPVQ8ROWteGi4Bx76ebMMCptHC8baBgBAPH+wMI49
        bDzHCl2aDVOiVVqh/SM4DB/G5g==
X-Google-Smtp-Source: ABdhPJxY2MwGf+i9T+pAYcMT6C/W25T8KBwVEvjQhxTyi4ceOB+BQa0ZeAMeQOPiiBQ4gr41ckZ25w==
X-Received: by 2002:a63:4c1f:: with SMTP id z31mr2068729pga.50.1632955304895;
        Wed, 29 Sep 2021 15:41:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o3sm2688703pjq.34.2021.09.29.15.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 15:41:44 -0700 (PDT)
Message-ID: <6154eba8.1c69fb81.87354.7785@mx.google.com>
Date:   Wed, 29 Sep 2021 15:41:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc3-23-gd91db9b878c3
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 77 runs,
 4 regressions (v5.15-rc3-23-gd91db9b878c3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 77 runs, 4 regressions (v5.15-rc3-23-gd91db9b878c3)

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
3-23-gd91db9b878c3/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc3-23-gd91db9b878c3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d91db9b878c32d8a746d69b30925174081c951d4 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
beagle-xm        | arm   | lab-baylibre  | gcc-8    | multi_v7_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6154e1b60a24779c2599a2e4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc3-23-gd91db=
9b878c3/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc3-23-gd91db=
9b878c3/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6154e1b60a24779c2599a=
2e5
        failing since 0 day (last pass: v5.15-rc3-18-g7c86bb8dfc1b, first f=
ail: v5.15-rc3-23-g5264d800ffd5) =

 =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
hip07-d05        | arm64 | lab-collabora | gcc-8    | defconfig          | =
1          =


  Details:     https://kernelci.org/test/plan/id/6154e415ae3961245e99a2e3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc3-23-gd91db=
9b878c3/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc3-23-gd91db=
9b878c3/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6154e415ae3961245e99a=
2e4
        failing since 91 days (last pass: pm-5.13-rc8-159-g3304616e985f, fi=
rst fail: devprop-5.13-rc8-173-ge132b9a1079c) =

 =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
2          =


  Details:     https://kernelci.org/test/plan/id/6154e1b04dccbc948b99a2e6

  Results:     89 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc3-23-gd91db=
9b878c3/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc3-23-gd91db=
9b878c3/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6154e1b04dccbc948b99a2ec
        failing since 78 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-09-29T22:18:03.487232  <8>[   24.340213] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
    2021-09-29T22:18:04.511096  /lava-4606750/1/../bin/lava-test-case
    2021-09-29T22:18:04.521898  <8>[   25.375845] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6154e1b04dccbc948b99a2ed
        failing since 78 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-09-29T22:18:03.474607  /lava-4606750/1/../bin/lava-test-case   =

 =20
