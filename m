Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77EF7D1502
	for <lists+linux-pm@lfdr.de>; Fri, 20 Oct 2023 19:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377891AbjJTRlM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Oct 2023 13:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377924AbjJTRlL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Oct 2023 13:41:11 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B83B126
        for <linux-pm@vger.kernel.org>; Fri, 20 Oct 2023 10:41:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-27d425a2dd0so928052a91.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Oct 2023 10:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697823668; x=1698428468; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=idYYF3/ULcSarp+Z8cfx7bZ5X7x+XASnSvzS+YBGo5M=;
        b=HhcLgU/0Gb6j+L4dK4sKIJSVvgELu61zktfGVA29V5HWxzaPj1B3jzwyZBHjmnayVQ
         U2db2Jyl/YRaJsrs27LxwExuTpLn8acXGOJcH2IiwKBn6HgCSsoQVvsDlkJyhQisfhne
         xucKgqSWip6pC3V1ofhIX6pd3WkuKocsvCm033aiguUoSroONah/advP1175tS87NlmU
         b2+Wi7MHy63iBZ9sYxZQI7xMwN09OhzZrrBLaUE+E96vX0Z1ynlNoFoYJBQ2TRJGvOur
         O2hI6iV8Dzj4dIMDAetMa/65rWeaXpKljByEJCCvdaDakyg4Zo0Cw1p6tIo10XO7Gunn
         9t8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697823668; x=1698428468;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idYYF3/ULcSarp+Z8cfx7bZ5X7x+XASnSvzS+YBGo5M=;
        b=or9tf7CVgbHT5HbXVCh8GsND2vnOTBaOcjCa2AoPmZY+AZah0WD9D9ObtJK6a1jJkt
         sJOTxAT31SVYH7wK5xg9wF6rG15xY/kEinDWmzt+pIku3goQThMs7xoF+FNku+ZGwwyC
         usA2b8eUFAIVRlZLahVhkqa1IKVGZx6XL1KTU0kYV4zFz2934V1w3DOBr3AAUzFv8FWM
         XpApZNJ+mrAj75iutvpkIYYXRDMckb5vOIh/K38aQm01uygBXS9qzPJmJJ/BSdjruhAf
         nZj3YnA7eu51YLf/6lFor8DntZm+rpkzMz2HjPH/ueFx55xwUJPq1gcNw0H+gOVHPd3W
         fxKQ==
X-Gm-Message-State: AOJu0YzFLs/tCwjQjLak0n7M0JVQ91QwLullpYhwenkIJszAMB46xqNo
        /RRGb2JvIvxE7YoUP2vnm8imSA==
X-Google-Smtp-Source: AGHT+IElLT9Abcq/W2pMSavbtLqxNlAYtiLopmnfporvmAAKqRN6ceFvIjcHVIXYiII7AscrAhT+HA==
X-Received: by 2002:a17:90a:d24d:b0:274:c284:c83c with SMTP id o13-20020a17090ad24d00b00274c284c83cmr2406794pjw.48.1697823667919;
        Fri, 20 Oct 2023 10:41:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jb14-20020a17090b408e00b002774d7e2fefsm1704468pjb.36.2023.10.20.10.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 10:41:07 -0700 (PDT)
Message-ID: <6532bbb3.170a0220.acc48.60d8@mx.google.com>
Date:   Fri, 20 Oct 2023 10:41:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc6-162-g10a07821099f
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 48 runs,
 3 regressions (v6.6-rc6-162-g10a07821099f)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 48 runs, 3 regressions (v6.6-rc6-162-g10a07821099f)

Regressions Summary
-------------------

platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
imx8mp-evk    | arm64 | lab-broonie   | gcc-10   | defconfig | 1          =

r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =

r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.6-rc6=
-162-g10a07821099f/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.6-rc6-162-g10a07821099f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      10a07821099f90ca90922f7dd011a4b630e2c702 =



Test Regressions
---------------- =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
imx8mp-evk    | arm64 | lab-broonie   | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6532af8e19e823717aefcfe3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc6-162-g10a07=
821099f/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc6-162-g10a07=
821099f/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532af8e19e823717aefcfec
        failing since 38 days (last pass: pm-6.6-rc1-122-g07b618ec9d7a, fir=
st fail: v6.6-rc1-5-gb5eda4c9c923)

    2023-10-20T16:48:56.908134  + set<8>[   29.368047] <LAVA_SIGNAL_ENDRUN =
0_dmesg 181661_1.5.2.4.1>
    2023-10-20T16:48:56.908528   +x
    2023-10-20T16:48:57.016966  / # #
    2023-10-20T16:48:58.183189  export SHELL=3D/bin/sh
    2023-10-20T16:48:58.189246  #
    2023-10-20T16:48:59.688296  / # export SHELL=3D/bin/sh. /lava-181661/en=
vironment
    2023-10-20T16:48:59.694466  =

    2023-10-20T16:49:02.418302  / # . /lava-181661/environment/lava-181661/=
bin/lava-test-runner /lava-181661/1
    2023-10-20T16:49:02.424971  =

    2023-10-20T16:49:02.428624  / # /lava-181661/bin/lava-test-runner /lava=
-181661/1 =

    ... (13 line(s) more)  =

 =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6532af6e85d2a566bbefcf30

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc6-162-g10a07=
821099f/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc6-162-g10a07=
821099f/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532af6f85d2a566bbefcf39
        failing since 92 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-10-20T16:52:51.135556  / # #

    2023-10-20T16:52:51.236141  export SHELL=3D/bin/sh

    2023-10-20T16:52:51.236258  #

    2023-10-20T16:52:51.336726  / # export SHELL=3D/bin/sh. /lava-11831202/=
environment

    2023-10-20T16:52:51.336840  =


    2023-10-20T16:52:51.437264  / # . /lava-11831202/environment/lava-11831=
202/bin/lava-test-runner /lava-11831202/1

    2023-10-20T16:52:51.437457  =


    2023-10-20T16:52:51.448964  / # /lava-11831202/bin/lava-test-runner /la=
va-11831202/1

    2023-10-20T16:52:51.491865  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-20T16:52:51.507965  + cd /lava-118312<8>[   19.276646] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11831202_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6532af9c19e823717aefd00b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc6-162-g10a07=
821099f/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc6-162-g10a07=
821099f/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6532af9c19e823717aefd014
        failing since 92 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-10-20T16:51:49.132457  / # #

    2023-10-20T16:51:50.210741  export SHELL=3D/bin/sh

    2023-10-20T16:51:50.212006  #

    2023-10-20T16:51:51.697311  / # export SHELL=3D/bin/sh. /lava-11831204/=
environment

    2023-10-20T16:51:51.699176  =


    2023-10-20T16:51:54.424116  / # . /lava-11831204/environment/lava-11831=
204/bin/lava-test-runner /lava-11831204/1

    2023-10-20T16:51:54.426291  =


    2023-10-20T16:51:54.438894  / # /lava-11831204/bin/lava-test-runner /la=
va-11831204/1

    2023-10-20T16:51:54.497905  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-20T16:51:54.498412  + cd /lava-118312<8>[   28.525652] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11831204_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =20
