Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D8240D2BC
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 07:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhIPFCt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 01:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbhIPFCs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Sep 2021 01:02:48 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6663C061574
        for <linux-pm@vger.kernel.org>; Wed, 15 Sep 2021 22:01:28 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q22so4868567pfu.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Sep 2021 22:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=+1q4J3G7aFDTw3BWqrD/cEqoq0fxoNrjMx7MyV2JYpQ=;
        b=FTlsZckE20SjOPROMLWqeurjaYLDCOX+IFvoZZCb6vO8DZh1I/DXpxHPJYOhk9iV6X
         j2h9qDwqewhYYvCzW0xa9e7uXC6S1SgkNNjWTWxW7ylGB74se2jj3H9bh7uU6uHEYn8X
         g17UTUY0Lv0skGYPSMZKC2+nqY5hKx+8brNVzbuC37AF7i4jgzPPH/ylIQlttk4HV+xO
         jMH2st+8kzzI2dbZPx9Ooj5euEL0R8Msl9FtjRI2LUzNjtnJXlyFA+Cp0nzj6xrpI41W
         T4nSfbUvb72stcOhL0FaU9+vUd4Nw8Ehl65UH9SAp0NQEaZ637PdDqm0ULaGv1sn7Q1e
         6XNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=+1q4J3G7aFDTw3BWqrD/cEqoq0fxoNrjMx7MyV2JYpQ=;
        b=SCkhDoVWcKygjYDNNc6cr6zgAac701k+JS4PbL720xlk5WDKc75WBEsttEkrx6m+/I
         AV3Oxo1zItN1qSp/Q0fUu8hYnlGbullO7gu+Z3P7vlffQfgPsqFRGrzpXA4JqcnHDxCL
         I2RdRqFfpe96uLl7tLC+eKCnLxdlGJPHdvWVNHKv3GI7exVPlL51CHLEJafi/4SLgSr9
         7lLVyJawyJD6+wRVjI3/3As1OZBmVZHycRWjILAsx6ybjJTnIC/cODfQgotr+cGn7VV0
         QPD56UcS9HTihmuuSNs3S2KCOHQbekygpRHnZnaR9kNXIKBcFaOOkZgloW4UZaFQr+Kk
         BAMA==
X-Gm-Message-State: AOAM532F32kOJcIfEhVI5gJIphmouJHy+/JVkRJrFzaHR59lX2Eng44+
        rlMC24WUpBQzVQXvGy9lMOUz9Q==
X-Google-Smtp-Source: ABdhPJwow2qJukeD8t/TUGIZxVhtNBQnAb6CSSG2OeHvrnfnFg+aoXQ7MDefTSD8dWDEfxGI0Bl5cA==
X-Received: by 2002:a63:935e:: with SMTP id w30mr3201559pgm.208.1631768488418;
        Wed, 15 Sep 2021 22:01:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e16sm1370055pfc.214.2021.09.15.22.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 22:01:28 -0700 (PDT)
Message-ID: <6142cfa8.1c69fb81.16070.6859@mx.google.com>
Date:   Wed, 15 Sep 2021 22:01:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc1-5-g7f2d17677d02
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 52 runs,
 5 regressions (v5.15-rc1-5-g7f2d17677d02)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 52 runs, 5 regressions (v5.15-rc1-5-g7f2d17677d02)

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

imx8mp-evk       | arm64 | lab-nxp       | gcc-8    | defconfig          | =
1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
1-5-g7f2d17677d02/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc1-5-g7f2d17677d02
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      7f2d17677d02a80230c9ef4b9b7dc986aa4c2914 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
beagle-xm        | arm   | lab-baylibre  | gcc-8    | multi_v7_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6142c5af9b64612ca999a325

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc1-5-g7f2d17=
677d02/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc1-5-g7f2d17=
677d02/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6142c5af9b64612ca999a=
326
        failing since 41 days (last pass: v5.14-rc3-20-g604483c9d252, first=
 fail: v5.14-rc4-28-g9ac32de19606) =

 =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
hip07-d05        | arm64 | lab-collabora | gcc-8    | defconfig          | =
1          =


  Details:     https://kernelci.org/test/plan/id/6142c75e978601822299a2db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc1-5-g7f2d17=
677d02/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc1-5-g7f2d17=
677d02/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6142c75e978601822299a=
2dc
        failing since 77 days (last pass: pm-5.13-rc8-159-g3304616e985f, fi=
rst fail: devprop-5.13-rc8-173-ge132b9a1079c) =

 =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
imx8mp-evk       | arm64 | lab-nxp       | gcc-8    | defconfig          | =
1          =


  Details:     https://kernelci.org/test/plan/id/6142c725deabd442cf99a2da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc1-5-g7f2d17=
677d02/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc1-5-g7f2d17=
677d02/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6142c725deabd442cf99a=
2db
        failing since 2 days (last pass: v5.14-rc7-64-g2a7254aa7491, first =
fail: v5.15-rc1) =

 =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
2          =


  Details:     https://kernelci.org/test/plan/id/6142c5c59b64612ca999a32b

  Results:     89 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc1-5-g7f2d17=
677d02/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc1-5-g7f2d17=
677d02/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6142c5c59b64612ca999a331
        failing since 65 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-09-16T04:18:52.441691  <8>[   51.431748] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
    2021-09-16T04:18:53.462125  /lava-4534114/1/../bin/lava-test-case
    2021-09-16T04:18:53.473400  <8>[   52.465899] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6142c5c59b64612ca999a332
        failing since 65 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-09-16T04:18:52.428052  /lava-4534114/1/../bin/lava-test-case   =

 =20
