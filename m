Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004656C39C9
	for <lists+linux-pm@lfdr.de>; Tue, 21 Mar 2023 20:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjCUTGw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Mar 2023 15:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjCUTGv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Mar 2023 15:06:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB39050FB4
        for <linux-pm@vger.kernel.org>; Tue, 21 Mar 2023 12:06:48 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso21208127pjb.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Mar 2023 12:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679425608;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6UPpKpeSvW/WQW9b0YJAWW5afUjTfpxDRaqP+/frAUI=;
        b=G4e05FlDD56j/PVxGQm8cAZFKmW3dCVqGw/BDEYu+o46gI1xCEzAITDVPFVKorcqGF
         0rancWj8KZyJfiX5FmHqWIWfIDb39RazRUNObpHJY7eumL4BhF/jyENaBls2cPNsAqIP
         WpGiKQP6iTbjZj++bfZraZcWHhFeIiV+1V9DvrI+19VieGmF1gfqKc2zOksVo8ZtwXhe
         2jG4xHdfngZ2SImJSdu2lHT1cHG51czrUpZRT0b1Ja+gAJ0sIQyt1UFZUVmd6cL//P9S
         Xq9HtuT3W1DjgzigaPA/ImXr/5kuaK7nfwoxviS8Y/xPR/kqRqdICxnlEj5Antg/6sZf
         dJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679425608;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UPpKpeSvW/WQW9b0YJAWW5afUjTfpxDRaqP+/frAUI=;
        b=IiBw0CgOy1hxzwaaUkHpZgoipVfaMKXXQelDLiHrN+hHFJq12s3uB7YomzavRorQUv
         Hucp6NyEeBB0oI4nMDX5UPSLyO8R8JhMtZmptPiNOieIBF1kDuFNpYPoMMI35ZrXhjsl
         Tn1RSQKuHIuBU1YaeCFW9/VK19Djut65solOj4ERxTgbaR0P3p6sFO8iJjaSScZ+EauV
         Kte7qGyjjQCjdCat3ZNJe7/8nZjeyZIDUVxj4aLi/ageAz1YHleJnUl4Z6JT3vlUkc8R
         HIQQ7TrrxUGNkk0zHWES5a0SzX2m8v0eI/oCOv3inwA+ZCPfNZDo+DGSc8Rq9XimAAhs
         3cNA==
X-Gm-Message-State: AO0yUKWJ6wh4I9Zu8Umiqy40oSlnEZjG1fnZbhEK8NHTPhEgPLUogzGk
        gox8ULFdX0a2Zj43tf1ASwXKMiRIRBNDxsCmEdt+Ew==
X-Google-Smtp-Source: AK7set90ku2M/vVrFAr44w49aQ/K3lSfTvpGxpqtvTh+/AjitoQYPUsauwrHowU/UeeTcQOT5oiquQ==
X-Received: by 2002:a17:902:e5cf:b0:19d:7a4:4063 with SMTP id u15-20020a170902e5cf00b0019d07a44063mr147800plf.46.1679425608014;
        Tue, 21 Mar 2023 12:06:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o11-20020a1709026b0b00b0019a96d3b456sm5339618plk.44.2023.03.21.12.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:06:47 -0700 (PDT)
Message-ID: <641a0047.170a0220.e76d8.98ed@mx.google.com>
Date:   Tue, 21 Mar 2023 12:06:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.3-rc3-33-g8e95155f8f29
Subject: pm/testing baseline: 50 runs,
 6 regressions (v6.3-rc3-33-g8e95155f8f29)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 50 runs, 6 regressions (v6.3-rc3-33-g8e95155f8f29)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
fsl-lx2160a-rdb       | arm64 | lab-nxp     | gcc-10   | defconfig | 1     =
     =

kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 5     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.3-rc3=
-33-g8e95155f8f29/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.3-rc3-33-g8e95155f8f29
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      8e95155f8f299d6c2941c7bfa133ae8d0242870e =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
fsl-lx2160a-rdb       | arm64 | lab-nxp     | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6419f9b8733b04c89f9c954b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc3-33-g8e9515=
5f8f29/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc3-33-g8e9515=
5f8f29/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6419f9b9733b04c89f9c9554
        failing since 5 days (last pass: v6.1-rc5-55-g60453df62d30, first f=
ail: v6.3-rc2-33-g1240ce78c05e)

    2023-03-21T18:38:16.034208  [   13.120338] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1180604_1.5.2.4.1>
    2023-03-21T18:38:16.139754  / # #
    2023-03-21T18:38:16.241569  export SHELL=3D/bin/sh
    2023-03-21T18:38:16.242114  #
    2023-03-21T18:38:16.343584  / # export SHELL=3D/bin/sh. /lava-1180604/e=
nvironment
    2023-03-21T18:38:16.344056  =

    2023-03-21T18:38:16.445477  / # . /lava-1180604/environment/lava-118060=
4/bin/lava-test-runner /lava-1180604/1
    2023-03-21T18:38:16.446244  =

    2023-03-21T18:38:16.448100  / # /lava-1180604/bin/lava-test-runner /lav=
a-1180604/1
    2023-03-21T18:38:16.473396  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 5     =
     =


  Details:     https://kernelci.org/test/plan/id/6419f90125d0d9ffb29c9512

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc3-33-g8e9515=
5f8f29/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc3-33-g8e9515=
5f8f29/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6419f90125d0d9ffb29c9519
        failing since 14 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, fir=
st fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-21T18:35:23.377584  / # #
    2023-03-21T18:35:23.478876  export SHELL=3D/bin/sh
    2023-03-21T18:35:23.479253  #
    2023-03-21T18:35:23.580259  / # export SHELL=3D/bin/sh. /lava-300075/en=
vironment
    2023-03-21T18:35:23.580567  =

    2023-03-21T18:35:23.681291  / # . /lava-300075/environment/lava-300075/=
bin/lava-test-runner /lava-300075/1
    2023-03-21T18:35:23.681800  =

    2023-03-21T18:35:23.693423  / # /lava-300075/bin/lava-test-runner /lava=
-300075/1
    2023-03-21T18:35:23.753611  + export 'TESTRUN_ID=3D1_bootrr'
    2023-03-21T18:35:23.753798  + <8>[   22.418644] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 300075_1.5.2.4.5> =

    ... (14 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/6419f90125d0d9ffb29c951d
        failing since 14 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, fir=
st fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-21T18:35:24.814973  <8>[   23.505193] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-driver-present RESULT=3Dpass>
    2023-03-21T18:35:25.850640  /lava-300075/1/../bin/lava-test-case
    2023-03-21T18:35:25.851051  <8>[   24.527275] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>
    2023-03-21T18:35:25.851172  /lava-300075/1/../bin/lava-test-case   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/64=
19f90125d0d9ffb29c951f
        failing since 14 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, fir=
st fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-21T18:35:26.914746  /lava-300075/1/../bin/lava-test-case
    2023-03-21T18:35:26.914931  <8>[   25.567957] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2023-03-21T18:35:26.915073  /lava-300075/1/../bin/lava-test-case
    2023-03-21T18:35:26.915194  <8>[   25.586566] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2023-03-21T18:35:26.915306  /lava-300075/1/../bin/lava-test-case
    2023-03-21T18:35:26.915412  <8>[   25.606138] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-probed RESULT=3Dpass>
    2023-03-21T18:35:26.915518  /lava-300075/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/6419f90125d0d9ffb29c9524
        failing since 14 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, fir=
st fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-21T18:35:27.990321  /lava-300075/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/6419f90125d0d9ffb29c9525
        failing since 14 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, fir=
st fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-21T18:35:27.993510  <8>[   26.683390] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2023-03-21T18:35:29.052034  /lava-300075/1/../bin/lava-test-case
    2023-03-21T18:35:29.053345  <8>[   27.704484] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>
    2023-03-21T18:35:29.053501  /lava-300075/1/../bin/lava-test-case
    2023-03-21T18:35:29.053605  <8>[   27.722774] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc_mdio-driver-present RESULT=3Dpass>
    2023-03-21T18:35:29.053701  /lava-300075/1/../bin/lava-test-case
    2023-03-21T18:35:29.053797  <8>[   27.742595] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc_mdio-probed RESULT=3Dpass>
    2023-03-21T18:35:29.053893  /lava-300075/1/../bin/lava-test-case   =

 =20
