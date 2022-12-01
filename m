Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC86963FBB6
	for <lists+linux-pm@lfdr.de>; Fri,  2 Dec 2022 00:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiLAXMD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Dec 2022 18:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiLAXLV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Dec 2022 18:11:21 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1517BCCED6
        for <linux-pm@vger.kernel.org>; Thu,  1 Dec 2022 15:10:44 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id w23so3059141ply.12
        for <linux-pm@vger.kernel.org>; Thu, 01 Dec 2022 15:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/akBnDtmuLyJRTwRxdDf/dv66C4/WmmYvIo52Mu2rqQ=;
        b=wSru/4B9wAgbCZzYqRvpPeGTLJLwUSGU5MUR6I+/F2CphQo67HuFoScDScb0vOh9ST
         Q2+Wz0JvixXHU+6qIfGMTHRKKhTvyQyES6HVE+gURWf0TWh2H6g/x9j/DSKPNxsqBhzj
         CIN1G21o8exR6zAc3j33saIYbyQSyO/S4C4Us8iUSutr++EIcUJm778wJ2j1A/srQVCf
         UioTSnIOteShMdBndglgUPF11Q+AzzAlINjNVI0KhrkWGiPFbDdxkqfa6f6CPW2+v45A
         DGExKou4A7ylfG50HbORfCDDob+ZKrMzyniID+cXbTfbrNCLfCrvrfkEzq8zCCwubwjy
         wkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/akBnDtmuLyJRTwRxdDf/dv66C4/WmmYvIo52Mu2rqQ=;
        b=RWXHVUz6up3VP++UOdcQLjfWweyaXuTze2ZbQnKQB0cG3scua5p9zjNMYKEbyf2NTT
         caLi0ycuSdf47/sa7HgrzJ9OL34V5p4XAxbTIzIn4O606PmashOx0yDcFkBdG0JQxnXU
         5kLhtVnqBrrVOfVf0MqvZ00R+w6mKgx6jkYhkc3EMdY1y61Vl5IedEsuQ/MiuctObjX2
         4USfV+dPbS5aUvcWVV3q514ZuzB4eJUMTMeT2o+d8SltBsRNkqzLmN5EzTFSY+8ANcBo
         F15SZeogBtu9APCWWat5OatNiv/wfy62QGlYY68Jjh3VyU6Dy8suQuLbsJQgWg0Yll7q
         S4GA==
X-Gm-Message-State: ANoB5pls0nua92ZIG0KPR1WNGQCGH9hs9VM/W/SU47XJvj/LPnj/eRZG
        XpoKyuwknnzJXVD6HI2zOeBjFw==
X-Google-Smtp-Source: AA0mqf6FaKs03MiNvefTL61zrxwTCYwoibTRxHkxcVfABTUflTJoeeQaxz3AGT6AmHM03P2YXBtmQg==
X-Received: by 2002:a17:90a:5d08:b0:218:770c:9a40 with SMTP id s8-20020a17090a5d0800b00218770c9a40mr55989737pji.158.1669936244317;
        Thu, 01 Dec 2022 15:10:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090332ce00b00189422a6b8bsm4219669plr.91.2022.12.01.15.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:10:43 -0800 (PST)
Message-ID: <63893473.170a0220.83e13.8589@mx.google.com>
Date:   Thu, 01 Dec 2022 15:10:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.1-rc7-101-g0ed70fd3fac1
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 67 runs,
 1 regressions (v6.1-rc7-101-g0ed70fd3fac1)
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

pm/testing baseline: 67 runs, 1 regressions (v6.1-rc7-101-g0ed70fd3fac1)

Regressions Summary
-------------------

platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.1-rc7=
-101-g0ed70fd3fac1/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.1-rc7-101-g0ed70fd3fac1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      0ed70fd3fac1e58af85c571c2d003319eb24ce1a =



Test Regressions
---------------- =



platform           | arch  | lab         | compiler | defconfig | regressio=
ns
-------------------+-------+-------------+----------+-----------+----------=
--
kontron-pitx-imx8m | arm64 | lab-kontron | gcc-10   | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/63892640e94f8aff102abd0b

  Results:     51 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.1-rc7-101-g0ed70=
fd3fac1/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.1-rc7-101-g0ed70=
fd3fac1/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221125.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/638=
92640e94f8aff102abd1e
        new failure (last pass: pm-6.1-rc7-97-g0b54caa6f14b)

    2022-12-01T22:09:52.311247  /lava-221214/1/../bin/lava-test-case
    2022-12-01T22:09:52.311632  <8>[   16.850057] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2022-12-01T22:09:52.311890  /lava-221214/1/../bin/lava-test-case
    2022-12-01T22:09:52.312122  <8>[   16.870907] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dimx8mq-usb-phy-driver-present RESULT=3Dpass>   =

 =20
