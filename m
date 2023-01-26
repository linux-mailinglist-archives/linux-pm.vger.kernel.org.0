Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAE967D3AC
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jan 2023 19:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjAZSAt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Jan 2023 13:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjAZSAs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jan 2023 13:00:48 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725A8298F1
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2023 10:00:47 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so6344367pjq.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2023 10:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qZzjwd3KVjDyGhWiPjDdf9n4VMM2DAJ3PvdN861J9a0=;
        b=3RlsPvXpIC96VSaNkUCZB+fWaLphNUuxWTmL6txT16Lyo87BfgSQjnUHbmWK1RiXbM
         eJtgvOVPUGo2a1GKYg13BArnFiHuRZHsYaL9Im6TtyCuhnaE3yIIpMFsSURpe5DdlFYg
         d/NReqJ1iGo1yJXfNtBfwuLBvdlvQTdTUIwoVr0pUGWaIl/TI705ZnccVNk/K1Cynx8q
         ULZzIrWy6e/tzYRjs35TCGpkmbVOchZiLm8rPJL4nOvwDT+N4DLIKo6PtSl4YK+qTJUa
         4lj6Je7umNvSrwuELHFShcQLlxXFQPGNK16TBq/6vzEBZNISnGBQw7MTb86oJ8WLKNOh
         orPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZzjwd3KVjDyGhWiPjDdf9n4VMM2DAJ3PvdN861J9a0=;
        b=0QBCenndXHEhIhkkcWaKuMsg/UVLXVh9FRDybxlOleYoAprGnDbsLwnLih7IF2qcnR
         ChqWAlzAw2cOKDwLzbBqiUMl61TS5zVyNPWUy2uqvDSy0bc2xkXLg7Ne/ug+XhOmF0c2
         +lzSw8CH5+GanCQ0pKw+oqboK6b7MoPBP4sAS1tyQySpXrHZKxApuurM+qRT+CM5weib
         zUrLBBnLZFwS0Czm4yL2P0JBB+3WFfJqS3qqRnLH7fL6ULKt7l1dLznrY63C/A3RJZWn
         XJ7GNE53CqE6OaCmZI/VYnJNaDzjkj83Jo++tQ7EYOO42YUprGM8NKS4mrB/18bh7vlg
         c7kA==
X-Gm-Message-State: AFqh2kpoBMEzJfKTDl/yKVFzNkHNnpQMSMfEnNfnZlLFenhPVDnS3SB0
        qtx8sMy3MJ2jVgcDuepHy9U95jUyna3+D+bDgDE=
X-Google-Smtp-Source: AMrXdXvLvBtMOFfGcAN2yj+dJzmIbMAmwTCt4R9mHwl+jgGOuzEzC6wSGn1j/svjMx8Ql696JbQ2Ag==
X-Received: by 2002:a17:902:ea02:b0:194:8bda:c68 with SMTP id s2-20020a170902ea0200b001948bda0c68mr45463919plg.44.1674756046727;
        Thu, 26 Jan 2023 10:00:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ay2-20020a1709028b8200b0019468fe44d3sm1280101plb.25.2023.01.26.10.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 10:00:46 -0800 (PST)
Message-ID: <63d2bfce.170a0220.b88c2.2403@mx.google.com>
Date:   Thu, 26 Jan 2023 10:00:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc5-104-ga91e079a2f6a
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 84 runs,
 5 regressions (v6.2-rc5-104-ga91e079a2f6a)
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

pm/testing baseline: 84 runs, 5 regressions (v6.2-rc5-104-ga91e079a2f6a)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
cubietruck                   | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =

kontron-pitx-imx8m           | arm64 | lab-kontron  | gcc-10   | defconfig =
         | 1          =

meson-g12b-odroid-n2         | arm64 | lab-baylibre | gcc-10   | defconfig =
         | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =

sun8i-h3-libretech-all-h3-cc | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.2-rc5=
-104-ga91e079a2f6a/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.2-rc5-104-ga91e079a2f6a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a91e079a2f6a26dd09fbd45d53e03e7c089282c0 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
cubietruck                   | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d2b4d6cc0291801c915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-104-ga91e0=
79a2f6a/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-104-ga91e0=
79a2f6a/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d2b4d6cc0291801c915ebe
        failing since 7 days (last pass: v6.1-rc8-176-gcb06e36a6532, first =
fail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-26T17:13:39.812461  + set +x<8>[   15.111348] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3219413_1.5.2.4.1>
    2023-01-26T17:13:39.812674  =

    2023-01-26T17:13:39.919100  / # #
    2023-01-26T17:13:40.020680  export SHELL=3D/bin/sh
    2023-01-26T17:13:40.021039  #<3>[   15.208610] Bluetooth: hci0: command=
 0xfc18 tx timeout
    2023-01-26T17:13:40.021196  =

    2023-01-26T17:13:40.122285  / # export SHELL=3D/bin/sh. /lava-3219413/e=
nvironment
    2023-01-26T17:13:40.122637  =

    2023-01-26T17:13:40.223779  / # . /lava-3219413/environment/lava-321941=
3/bin/lava-test-runner /lava-3219413/1
    2023-01-26T17:13:40.224350   =

    ... (13 line(s) more)  =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
kontron-pitx-imx8m           | arm64 | lab-kontron  | gcc-10   | defconfig =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/63d2b6aa6fe7e276f1915ec9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-104-ga91e0=
79a2f6a/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-104-ga91e0=
79a2f6a/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63d2b6aa6fe7e276f1915=
eca
        new failure (last pass: v6.2-rc5-97-gf108f07918a9) =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
meson-g12b-odroid-n2         | arm64 | lab-baylibre | gcc-10   | defconfig =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/63d2b5903820d51877915f96

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-104-ga91e0=
79a2f6a/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12b-odroid-n2.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-104-ga91e0=
79a2f6a/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12b-odroid-n2.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63d2b5903820d51877915=
f97
        new failure (last pass: v6.2-rc5-97-gf108f07918a9) =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d2b4be847f31083b915ebd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-104-ga91e0=
79a2f6a/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-l=
ibretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-104-ga91e0=
79a2f6a/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-l=
ibretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d2b4be847f31083b915ec2
        failing since 7 days (last pass: v6.1-rc8-224-g02f29b079520, first =
fail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-26T17:13:17.128252  / # #
    2023-01-26T17:13:17.229977  export SHELL=3D/bin/sh
    2023-01-26T17:13:17.230358  #
    2023-01-26T17:13:17.331683  / # export SHELL=3D/bin/sh. /lava-3219423/e=
nvironment
    2023-01-26T17:13:17.332071  =

    2023-01-26T17:13:17.433443  / # . /lava-3219423/environment/lava-321942=
3/bin/lava-test-runner /lava-3219423/1
    2023-01-26T17:13:17.434148  =

    2023-01-26T17:13:17.455480  / # /lava-3219423/bin/lava-test-runner /lav=
a-3219423/1
    2023-01-26T17:13:17.567377  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-26T17:13:17.567890  + cd /lava-3219423/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
sun8i-h3-libretech-all-h3-cc | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d2b4c2847f31083b915ecb

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-104-ga91e0=
79a2f6a/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-libret=
ech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-104-ga91e0=
79a2f6a/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-libret=
ech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d2b4c2847f31083b915ed0
        failing since 7 days (last pass: v6.1-rc8-224-g02f29b079520, first =
fail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-26T17:13:15.808776  / # #
    2023-01-26T17:13:15.910648  export SHELL=3D/bin/sh
    2023-01-26T17:13:15.910995  #
    2023-01-26T17:13:16.012328  / # export SHELL=3D/bin/sh. /lava-3219426/e=
nvironment
    2023-01-26T17:13:16.012676  =

    2023-01-26T17:13:16.114010  / # . /lava-3219426/environment/lava-321942=
6/bin/lava-test-runner /lava-3219426/1
    2023-01-26T17:13:16.114614  =

    2023-01-26T17:13:16.121284  / # /lava-3219426/bin/lava-test-runner /lav=
a-3219426/1
    2023-01-26T17:13:16.227210  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-26T17:13:16.227469  + cd /lava-3219426/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
