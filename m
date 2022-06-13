Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355CC549EC2
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jun 2022 22:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245118AbiFMUQ4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jun 2022 16:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350984AbiFMUQo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jun 2022 16:16:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D6C2AE25
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 11:54:07 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id z17so6528458pff.7
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2022 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=hos+vM7QPhmLKHrhoq7Tsb+wSvmhwbry7MYW25bIJ6o=;
        b=zNHyYqDOfZejcq5aSVCs9Zw5L4PORk78uJU1e/GvCsYcxGcdcC/viU7v5qwtMPnj2T
         Ua2fv7rFiYJivU/Lje0XgGnbueiAwbqhQITAZ/QJPyjHQbddyIq5hHMIo7aJResyzGNV
         cz+ZyvoZPmqWCZVjZJ7pGxsLB/i6DGVl9uOjVir1Zeh1pAyP/yspsSu/aqjwSjswKeyr
         fdSPowgK3wyQgWYyg3dPcUHw0y7PeMkMSYaTjxpEd1kxuuZ5AFTURIcDu61cW7R5Hm5e
         J1MToaompqQLDaFb3MsM6vKcRJsczQvNkLLMsX760wWp7mot51XnXEdtL8H0fNahjS+6
         UKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=hos+vM7QPhmLKHrhoq7Tsb+wSvmhwbry7MYW25bIJ6o=;
        b=w471QcP5cg8YSN+R90mnSlakWGuj3HSlM0OqTAcfR6NnYAG9a2sm7yzf3Hel12Ceog
         MpHajXXgG8Z8joehfDL4KbL7BdRINmGnpwBE/ggtf2Kx1l0GgXLll/CGsrTAJfuzn6Jx
         RqiCCAQVUUIJGOV+TV2ik6iu+oD35Hg8o3iu9jxDRTOu1lRoQfJ/9S5C78q3rwjrvX3O
         /W5lX5MdVfHXmwAhWCJBo/7+JQVmNU6uWpNlcB6twZVO1NbemjQpE8YMD9aGel9ZxHGn
         PsDx7JAaikzgvnLBrFQ8PFij8nAUlZDJWEuPP/+skq1097HISCFL36JW+xlP9SoCZvy/
         7T2w==
X-Gm-Message-State: AOAM532FFpwZff8SsomKPf6HHvEw3sz7ZBTPxKyVDkATXcQmFE1sZep8
        Y2maXzuQq71PHT9y8Kwhyo5KUlaPxzO834/4AuE=
X-Google-Smtp-Source: ABdhPJzsjapAf3rDksbZmVpFCd2ISbCszY25vJdh+NXkbKXcC1QzMx65ur9k8CgSyG60ff5FLb81nQ==
X-Received: by 2002:a62:e116:0:b0:51b:c452:47e6 with SMTP id q22-20020a62e116000000b0051bc45247e6mr707807pfh.25.1655146447223;
        Mon, 13 Jun 2022 11:54:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n19-20020a638f13000000b00401a213a5f5sm5717962pgd.34.2022.06.13.11.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 11:54:06 -0700 (PDT)
Message-ID: <62a787ce.1c69fb81.338c3.60ca@mx.google.com>
Date:   Mon, 13 Jun 2022 11:54:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc2-3-gd3104995c5831
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 85 runs,
 6 regressions (v5.19-rc2-3-gd3104995c5831)
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

pm/testing baseline: 85 runs, 6 regressions (v5.19-rc2-3-gd3104995c5831)

Regressions Summary
-------------------

platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
imx6ul-pico-hobbit           | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig | 1          =

jetson-tk1                   | arm   | lab-baylibre    | gcc-10   | multi_v=
7_defconfig | 1          =

kontron-kbox-a-230-ls        | arm64 | lab-kontron     | gcc-10   | defconf=
ig          | 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre    | gcc-10   | multi_v=
7_defconfig | 1          =

sun8i-h2-plus-orangepi-zero  | arm   | lab-baylibre    | gcc-10   | multi_v=
7_defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.19-rc=
2-3-gd3104995c5831/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.19-rc2-3-gd3104995c5831
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d3104995c583179bd2018b049a834319969baa80 =



Test Regressions
---------------- =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
imx6ul-pico-hobbit           | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62a77f2e0c42d17506a39bd4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc2-3-gd31049=
95c5831/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6ul-pico-=
hobbit.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc2-3-gd31049=
95c5831/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6ul-pico-=
hobbit.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a77f2e0c42d17506a39=
bd5
        failing since 6 days (last pass: thermal-5.16-rc5-48-gf1f42573b6f3,=
 first fail: v5.19-rc1-2-g6a8964e282382) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
jetson-tk1                   | arm   | lab-baylibre    | gcc-10   | multi_v=
7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62a77eef2e7534b257a39bd5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc2-3-gd31049=
95c5831/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc2-3-gd31049=
95c5831/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a77eef2e7534b257a39=
bd6
        failing since 6 days (last pass: v5.18-rc6-123-g84d13b694ebbe, firs=
t fail: v5.19-rc1-2-g6a8964e282382) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
kontron-kbox-a-230-ls        | arm64 | lab-kontron     | gcc-10   | defconf=
ig          | 1          =


  Details:     https://kernelci.org/test/plan/id/62a77d7eb1ef5f5d39a39c29

  Results:     93 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc2-3-gd31049=
95c5831/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc2-3-gd31049=
95c5831/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/62=
a77d7eb1ef5f5d39a39c32
        failing since 6 days (last pass: v5.18-rc7-183-g45785e0ed597, first=
 fail: v5.19-rc1-2-g6a8964e282382)

    2022-06-13T18:09:39.995567  /lava-127311/1/../bin/lava-test-case
    2022-06-13T18:09:39.995821  <8>[   15.953249] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-06-13T18:09:39.995971  /lava-127311/1/../bin/lava-test-case
    2022-06-13T18:09:39.996112  <8>[   15.965875] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2022-06-13T18:09:39.996274  /lava-127311/1/../bin/lava-test-case
    2022-06-13T18:09:39.996411  <8>[   15.978636] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-probed RESULT=3Dpass>
    2022-06-13T18:09:39.996552  /lava-127311/1/../bin/lava-test-case   =

 =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =


  Details:     https://kernelci.org/test/plan/id/62a782cc4c77618985a39bd9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc2-3-gd31049=
95c5831/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc2-3-gd31049=
95c5831/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a782cc4c77618985a39=
bda
        failing since 6 days (last pass: v5.18-rc7-126-g6b601767c503e, firs=
t fail: v5.19-rc1-2-g6a8964e282382) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre    | gcc-10   | multi_v=
7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62a77f251ecfc696aea39cc9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc2-3-gd31049=
95c5831/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-l=
ibretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc2-3-gd31049=
95c5831/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-l=
ibretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a77f251ecfc696aea39=
cca
        failing since 6 days (last pass: v5.18-rc6-123-g84d13b694ebbe, firs=
t fail: v5.19-rc1-2-g6a8964e282382) =

 =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
sun8i-h2-plus-orangepi-zero  | arm   | lab-baylibre    | gcc-10   | multi_v=
7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62a77eda77a65e54f0a39c92

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc2-3-gd31049=
95c5831/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-o=
rangepi-zero.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc2-3-gd31049=
95c5831/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-o=
rangepi-zero.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62a77eda77a65e54f0a39=
c93
        new failure (last pass: v5.19-rc1-2-g6a8964e282382) =

 =20
