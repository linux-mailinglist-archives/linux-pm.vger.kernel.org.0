Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1B56C842F
	for <lists+linux-pm@lfdr.de>; Fri, 24 Mar 2023 19:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjCXSCa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Mar 2023 14:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjCXSCP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Mar 2023 14:02:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA811BAED
        for <linux-pm@vger.kernel.org>; Fri, 24 Mar 2023 11:01:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c18so2526924ple.11
        for <linux-pm@vger.kernel.org>; Fri, 24 Mar 2023 11:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679680896;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LnkAbJdeK53JCzn6C89txQk6ag8qHKp4D3/ibMP4EDo=;
        b=oIh5KXeB/F4oPyYXFtmWLs9NCUGAv448tk2M49UoiRqEQLAEGbNyzvsFOtVYOZ4/Wp
         zFSSuHJwl3buvnCEciw8p4iiA7zoUQyrXJoXfKUmp1UOP/LsN1veNvdLhIAVLFDqAt1y
         0rV2DzejHC6uhOZXb7I8iWvQwIKS2P2pjxMJAUSiqArO0u+YN83+klpkzPhUz7hwfers
         2Q45XDT/ib0frDTetk99zQ+v0ZlnySKxm0ydurqQpeuQVwvnTiW/swUVZj2Uq3jw0Qcu
         trnoT+u5XTGMSC0wnZXDbydnO/addIhZkahCkjUqrFF4FtMbbieQ3izKZi9ulmZGSxx0
         fDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679680896;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnkAbJdeK53JCzn6C89txQk6ag8qHKp4D3/ibMP4EDo=;
        b=bs8Sjz62+R2Ibv581cF8zx3uHPCdyRdXHYa4u/pvEHWZovRO8XYdLVNhxC4s6fNXUo
         H4Wi9/jnvZh/oQIsvoE+rfS9bY/1qgBwaoInF0jcPQDGAqfY0PsXTqPaSxgAcMZPnXvh
         5JyfgC2jlHVKaDg65YCsogTFprJs4MJ3reFx2IVTb7b8uswFIycXWGN0SMG6MB7Sxsod
         UYJBwQLq/7vqzwk5660wu0KGNe6YfW0NSWNdb4JrA0v4KWprXnUB7hvSD3qIJoyX+WRD
         BZIkGDCuktlisDKTuxXfzLJS0JyY2rOUWHwHyKyzxHr3FSvWdlmWrzfva33kozmMZ4fY
         dDGA==
X-Gm-Message-State: AO0yUKUXx+EDPpMov2X6x8chw5m1iEffursghV0WdQTxKkEyyAwr/ugH
        gWsMggGdK3NTK+vMRvDXffLyddDP/JFoa1q7PxXjig==
X-Google-Smtp-Source: AK7set8Nja2A7SkM+ucX9lSKwA2onqneC7ZlEy9T+nMcwmcun7ZTG3JhfUFD0Aab2bojNGeMbAceOQ==
X-Received: by 2002:a05:6a20:1a9c:b0:d8:a2ee:6b60 with SMTP id ci28-20020a056a201a9c00b000d8a2ee6b60mr3521580pzb.42.1679680896508;
        Fri, 24 Mar 2023 11:01:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k23-20020aa790d7000000b006247123adf1sm14596746pfk.143.2023.03.24.11.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 11:01:36 -0700 (PDT)
Message-ID: <641de580.a70a0220.869d.ac30@mx.google.com>
Date:   Fri, 24 Mar 2023 11:01:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.3-rc3-53-g7473086579df3
Subject: pm/testing baseline: 60 runs,
 6 regressions (v6.3-rc3-53-g7473086579df3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 60 runs, 6 regressions (v6.3-rc3-53-g7473086579df3)

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
-53-g7473086579df3/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.3-rc3-53-g7473086579df3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      7473086579df355c73c562503a622866052017fe =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
fsl-lx2160a-rdb       | arm64 | lab-nxp     | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/641dda9e4b9f0472539c950a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc3-53-g747308=
6579df3/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc3-53-g747308=
6579df3/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641dda9e4b9f0472539c9511
        failing since 8 days (last pass: v6.1-rc5-55-g60453df62d30, first f=
ail: v6.3-rc2-33-g1240ce78c05e)

    2023-03-24T17:14:44.487413  [   17.464700] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1185357_1.5.2.4.1>
    2023-03-24T17:14:44.590949  / # #
    2023-03-24T17:14:44.692150  export SHELL=3D/bin/sh
    2023-03-24T17:14:44.692365  #
    2023-03-24T17:14:44.793288  / # export SHELL=3D/bin/sh. /lava-1185357/e=
nvironment
    2023-03-24T17:14:44.793611  =

    2023-03-24T17:14:44.894703  / # . /lava-1185357/environment/lava-118535=
7/bin/lava-test-runner /lava-1185357/1
    2023-03-24T17:14:44.895248  =

    2023-03-24T17:14:44.896976  / # /lava-1185357/bin/lava-test-runner /lav=
a-1185357/1
    2023-03-24T17:14:44.920435  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 5     =
     =


  Details:     https://kernelci.org/test/plan/id/641dda02d034ed7e769c9505

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc3-53-g747308=
6579df3/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc3-53-g747308=
6579df3/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641dda02d034ed7e769c950c
        failing since 16 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, fir=
st fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-24T17:12:12.092995  / # #
    2023-03-24T17:12:12.195083  export SHELL=3D/bin/sh
    2023-03-24T17:12:12.195833  #
    2023-03-24T17:12:12.297714  / # export SHELL=3D/bin/sh. /lava-303154/en=
vironment
    2023-03-24T17:12:12.298105  =

    2023-03-24T17:12:12.399722  / # . /lava-303154/environment/lava-303154/=
bin/lava-test-runner /lava-303154/1
    2023-03-24T17:12:12.400974  =

    2023-03-24T17:12:12.406352  / # /lava-303154/bin/lava-test-runner /lava=
-303154/1
    2023-03-24T17:12:12.472735  + export 'TESTRUN_ID=3D1_bootrr'
    2023-03-24T17:12:12.472946  + <8>[   22.363905] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 303154_1.5.2.4.5> =

    ... (17 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/641dda02d034ed7e769c9510
        failing since 16 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, fir=
st fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-24T17:12:14.569479  /lava-303154/1/../bin/lava-test-case
    2023-03-24T17:12:14.569883  <8>[   24.471265] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>
    2023-03-24T17:12:14.570133  /lava-303154/1/../bin/lava-test-case   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/64=
1dda02d034ed7e769c9512
        failing since 16 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, fir=
st fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-24T17:12:15.628824  /lava-303154/1/../bin/lava-test-case
    2023-03-24T17:12:15.629093  <8>[   25.510764] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/641dda02d034ed7e769c9517
        failing since 16 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, fir=
st fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-24T17:12:16.703643  /lava-303154/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/641dda02d034ed7e769c9518
        failing since 16 days (last pass: pm-6.2-rc9-232-gea150b53b1fd, fir=
st fail: v6.3-rc1-23-g06401c1b98b0)

    2023-03-24T17:12:16.706775  <8>[   26.623371] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2023-03-24T17:12:17.765156  /lava-303154/1/../bin/lava-test-case
    2023-03-24T17:12:17.765329  <8>[   27.644638] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>
    2023-03-24T17:12:17.765437  /lava-303154/1/../bin/lava-test-case   =

 =20
