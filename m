Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8846C5498
	for <lists+linux-pm@lfdr.de>; Wed, 22 Mar 2023 20:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCVTMS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Mar 2023 15:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjCVTMS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2023 15:12:18 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502D85F214
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2023 12:11:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id k2so20183534pll.8
        for <linux-pm@vger.kernel.org>; Wed, 22 Mar 2023 12:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679512317;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q9+wXPxaeIp4fmrh14Hx6h/QwuDzrhwx+mHiCz2Hq9o=;
        b=rCC1yaz99FhFOjE2YJiakO8vZ6EmnkO5J0iYJ45RqOVuszUh1VSFwISYjyXwPfJHvO
         BgD9cTNSqHnbvE8xd22N7xIOF8Fk593nq6Cuh4im8pdIhm7wYRdC/K5d9wmpJZcEVBCb
         TGmnLWQVQmAlR2HM7LOJXwjlpqbO+dfFd4NJRq8yznz0iTxSinj/zrMjuYGIYIUJuyV0
         QW90CYAjnADdcBFyq+elXwFM33k1ifuQJ600E2Cc98yxJcERd96cjcknhZP1+G1PpYsg
         Ns/n7s+CvwT0CfUBVqJVM6MganpG9g3abumlbgQ087A3shgWho2x5RhALY3376kZSVsf
         STJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679512317;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9+wXPxaeIp4fmrh14Hx6h/QwuDzrhwx+mHiCz2Hq9o=;
        b=rcBoK1Ixbk/iuZqLZ2V84UmnAfb2bX9+q/XswG7ThCmzW/5FaCm6V2a6vUGJGWKgVG
         Qy9GF+Pey7KJdefydz+7HtuVvlVdXiZd3jjrG/gqN5emcP3+SvGWe8vt+LTussEFMsnY
         q6Ii0tJBCe5TSg5Kk//ncI9crGlJ2F3vp/ssaTvsPW2FPlrfWix8Q2C9vKMx2/xcyUB5
         hnnVWibmgajJHnISvS7RXrkQ0g0dahyJ5JjB/FfQQRDryKqv6LRghjPWcIdl1x3etVHs
         lTZyhX86wdmfESCsvXdV6XVwsq8d8h4Ql+RalpaAGhR+yViWHA3pVsl2OtVtvI3SePOm
         b9tQ==
X-Gm-Message-State: AO0yUKXNXlfC3Q8IxAHzcmaaeE1SoDwDNl40s90ZylDUN/InC85/r7pX
        VeHczQO3N2IP4yOx2njm/cYBwA==
X-Google-Smtp-Source: AK7set9EyUsMs5v1y6td1I1/En1WvbJPzvcCIIUi2R3u90wR9ICTheobQj5+o6XFmzX44TbBVLV5ZA==
X-Received: by 2002:a17:90b:2245:b0:23d:15e7:e1a2 with SMTP id hk5-20020a17090b224500b0023d15e7e1a2mr4959290pjb.32.1679512316769;
        Wed, 22 Mar 2023 12:11:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k88-20020a17090a4ce100b00233ccd04a15sm5033938pjh.24.2023.03.22.12.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 12:11:56 -0700 (PDT)
Message-ID: <641b52fc.170a0220.29b0e.a0b7@mx.google.com>
Date:   Wed, 22 Mar 2023 12:11:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.3-rc3-45-gfc5f43f31bdc3
Subject: pm/testing baseline: 56 runs,
 5 regressions (v6.3-rc3-45-gfc5f43f31bdc3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 56 runs, 5 regressions (v6.3-rc3-45-gfc5f43f31bdc3)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 5     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.3-rc3=
-45-gfc5f43f31bdc3/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.3-rc3-45-gfc5f43f31bdc3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      fc5f43f31bdc387e18804a52d4a0d28b6282f781 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 5     =
     =


  Details:     https://kernelci.org/test/plan/id/641b46e18b1d907c1d9c9520

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc3-45-gfc5f43=
f31bdc3/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc3-45-gfc5f43=
f31bdc3/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641b46e18b1d907c1d9c9527
        failing since 15 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, fir=
st fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-22T18:19:55.079962  / # #
    2023-03-22T18:19:55.182748  export SHELL=3D/bin/sh
    2023-03-22T18:19:55.183520  #
    2023-03-22T18:19:55.285501  / # export SHELL=3D/bin/sh. /lava-301319/en=
vironment
    2023-03-22T18:19:55.286273  =

    2023-03-22T18:19:55.388341  / # . /lava-301319/environment/lava-301319/=
bin/lava-test-runner /lava-301319/1
    2023-03-22T18:19:55.389628  =

    2023-03-22T18:19:55.409355  / # /lava-301319/bin/lava-test-runner /lava=
-301319/1
    2023-03-22T18:19:55.461282  + export 'TESTRUN_ID=3D1_bootrr'
    2023-03-22T18:19:55.461773  + <8>[   22.349497] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 301319_1.5.2.4.5> =

    ... (17 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/641b46e18b1d907c1d9c952b
        failing since 15 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, fir=
st fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-22T18:19:57.553790  /lava-301319/1/../bin/lava-test-case
    2023-03-22T18:19:57.554236  <8>[   24.452822] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>
    2023-03-22T18:19:57.554634  /lava-301319/1/../bin/lava-test-case   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/64=
1b46e18b1d907c1d9c952d
        failing since 15 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, fir=
st fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-22T18:19:58.611664  /lava-301319/1/../bin/lava-test-case
    2023-03-22T18:19:58.612183  <8>[   25.490629] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2023-03-22T18:19:58.612569  /lava-301319/1/../bin/lava-test-case
    2023-03-22T18:19:58.612891  <8>[   25.507509] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/641b46e18b1d907c1d9c9532
        failing since 15 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, fir=
st fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-22T18:19:59.687258  /lava-301319/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/641b46e18b1d907c1d9c9533
        failing since 15 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, fir=
st fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-22T18:19:59.690435  <8>[   26.603389] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2023-03-22T18:20:00.748931  /lava-301319/1/../bin/lava-test-case
    2023-03-22T18:20:00.749468  <8>[   27.624647] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>
    2023-03-22T18:20:00.749775  /lava-301319/1/../bin/lava-test-case
    2023-03-22T18:20:00.750022  <8>[   27.640966] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc_mdio-driver-present RESULT=3Dpass>
    2023-03-22T18:20:00.750264  /lava-301319/1/../bin/lava-test-case   =

 =20
