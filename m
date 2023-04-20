Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645766E9CE7
	for <lists+linux-pm@lfdr.de>; Thu, 20 Apr 2023 22:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjDTUPu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Apr 2023 16:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjDTUPu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2023 16:15:50 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305671BF2
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2023 13:15:48 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b7588005fso1363473b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2023 13:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682021747; x=1684613747;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7L5UHa4GcQaEh9X8oV+tu9Ka3oO1hh7JeK907NmNaRc=;
        b=qegU44Op6JanC9SBUbBGs5XJ7As6veN8bItkaqT74nNiNrokITRVjgTo9glApWktvb
         CSz5R8o06/qUPqdKGNM20NNaCCBir/U8NFoXJT1kYJY00kHtv6OdVjoVAC9F8F9ADWQt
         8W3JmVcm4FDOx3rB8jfCnU7UCjzhcrmB7pBfxCtuKzph0lWusKJTSiIyn92lLbIbKqDG
         e1IAuQbQGqho6rUDLw15Q+tUMIU4brs/fIqEMyCnYQ7TLpUUpraJMc2ix2+422DSY0Eg
         D6cDalNIXY1LQ9mciXXZcVw5niiryBOFn6HSFugX7mt2ntVhMe6TAuaWpGajztE3O+/H
         qRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682021747; x=1684613747;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7L5UHa4GcQaEh9X8oV+tu9Ka3oO1hh7JeK907NmNaRc=;
        b=d8R4aOx3WXvu1oFtu0oYqmVhHEtAwgFd2uA6AKue8RRhBQHCEMi+aK5aiNcKHlWzF3
         uj5YKHPkX+2bziKvLWEGfT3T4UNyoR7bK6oxvpu45HKL1W9llaC1d1pNsDpz9awTAFZp
         U+gUzZpslog86GBJHif0OEbG0fGI8AF1NuDNtOFss9pN8XbjmIbH7xqNii8Eq3bPzFak
         aQ4VpVrIz05MtTSuZ+LVUlYCi4ONxsMjcmiT1JAFmaJ7DiwPQ64fovcxvamzkdLWLNmo
         7c5f5/fA07QMMMcQtqfpWsBnmZ5kZwu58zABVKavt6Qd2xb7E7Wh0FN5SJEqAN6DUD0Z
         ZbFw==
X-Gm-Message-State: AAQBX9dn8zKNsC9Nv/JchJq2A3eL3UrDh3/Sj83K2lgnMObAvTePE2hK
        OZH/mxMn+IGuQKp1A1CYU41FTg==
X-Google-Smtp-Source: AKy350ZDFifAyfmLGJolOVh1nj23wLU6lz0Uj4sv2SD0Qh5MwCrW3E8kCDZc0OKEwVc1nbSTkFisSQ==
X-Received: by 2002:a05:6a00:2411:b0:63b:599b:a2da with SMTP id z17-20020a056a00241100b0063b599ba2damr2734522pfh.27.1682021747650;
        Thu, 20 Apr 2023 13:15:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v10-20020a62c30a000000b006352a6d56ebsm1596784pfg.119.2023.04.20.13.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:15:47 -0700 (PDT)
Message-ID: <64419d73.620a0220.72308.3b6e@mx.google.com>
Date:   Thu, 20 Apr 2023 13:15:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.3-rc7-189-g704d7a52a540b
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 60 runs,
 3 regressions (v6.3-rc7-189-g704d7a52a540b)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 60 runs, 3 regressions (v6.3-rc7-189-g704d7a52a540b)

Regressions Summary
-------------------

platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
fsl-lx2160a-rdb              | arm64 | lab-nxp         | gcc-10   | defconf=
ig          | 1          =

imx53-qsrb                   | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.3-rc7=
-189-g704d7a52a540b/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.3-rc7-189-g704d7a52a540b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      704d7a52a540b6ab2f6cc6a0c10d3b9fe851a459 =



Test Regressions
---------------- =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
fsl-lx2160a-rdb              | arm64 | lab-nxp         | gcc-10   | defconf=
ig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644190ec16186dcd1b2e8625

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc7-189-g704d7=
a52a540b/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc7-189-g704d7=
a52a540b/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/644190ec16186dcd1b2e862a
        failing since 35 days (last pass: v6.1-rc5-55-g60453df62d30, first =
fail: v6.3-rc2-33-g1240ce78c05e)

    2023-04-20T19:21:52.896751  [   16.358297] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1204940_1.5.2.4.1>
    2023-04-20T19:21:53.005140  / # #
    2023-04-20T19:21:53.107458  export SHELL=3D/bin/sh
    2023-04-20T19:21:53.108102  #
    2023-04-20T19:21:53.209600  / # export SHELL=3D/bin/sh. /lava-1204940/e=
nvironment
    2023-04-20T19:21:53.210156  =

    2023-04-20T19:21:53.311693  / # . /lava-1204940/environment/lava-120494=
0/bin/lava-test-runner /lava-1204940/1
    2023-04-20T19:21:53.312624  =

    2023-04-20T19:21:53.315042  / # /lava-1204940/bin/lava-test-runner /lav=
a-1204940/1
    2023-04-20T19:21:53.337111  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
imx53-qsrb                   | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6441934af52d7e20902e85f2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc7-189-g704d7=
a52a540b/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc7-189-g704d7=
a52a540b/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6441934af52d7e20902e85f7
        failing since 83 days (last pass: v6.1-rc8-156-g0a9e32afe717, first=
 fail: acpi-6.2-rc6-146-g628c61874ffd)

    2023-04-20T19:32:02.960981  + set +x
    2023-04-20T19:32:02.961185  [   13.078806] <LAVA_SIGNAL_ENDRUN 0_dmesg =
932704_1.5.2.3.1>
    2023-04-20T19:32:03.068815  / # #
    2023-04-20T19:32:03.170360  export SHELL=3D/bin/sh
    2023-04-20T19:32:03.170811  #
    2023-04-20T19:32:03.272060  / # export SHELL=3D/bin/sh. /lava-932704/en=
vironment
    2023-04-20T19:32:03.272500  =

    2023-04-20T19:32:03.373788  / # . /lava-932704/environment/lava-932704/=
bin/lava-test-runner /lava-932704/1
    2023-04-20T19:32:03.374373  =

    2023-04-20T19:32:03.377876  / # /lava-932704/bin/lava-test-runner /lava=
-932704/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =


  Details:     https://kernelci.org/test/plan/id/644191d6886907d83b2e85ff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc7-189-g704d7=
a52a540b/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-al=
l-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc7-189-g704d7=
a52a540b/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-al=
l-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230414.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/644191d6886907d83b2e8=
600
        failing since 2 days (last pass: v6.3-rc6-135-g5235219c59f8, first =
fail: v6.3-rc7-153-gbc538c8be4bd) =

 =20
