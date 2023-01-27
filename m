Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB89567EED3
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jan 2023 20:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjA0TyV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Jan 2023 14:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjA0TyI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jan 2023 14:54:08 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D98888F28
        for <linux-pm@vger.kernel.org>; Fri, 27 Jan 2023 11:51:15 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id k18so6066068pll.5
        for <linux-pm@vger.kernel.org>; Fri, 27 Jan 2023 11:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rI3B29BWDMyy9KKoss/dhVg7Dl8oDvx9k3GAo8kFYmU=;
        b=SsKa7FiocMjn5802PA1/JsY01o8yP2xo7d4WoqFF21rGL6XXOCbSgGL6TJeEEDC1wR
         PhxUapkXz2Bp1yhictQed2sdThlnPWrSEhhtGwxFREj20L2LuFhXUUN49JrVbRkub/XC
         m7NSrHlnaT0tSgp/xXtOY/b4YPnFiouH68CGGj3dGrqLdU0qU68b9NjxSTnamMkWggaS
         4HdWKwLaiBtPsmt9WcmU08axHx1hK3hD8z5P3wcW8OmZDoO3dZc8P1YUoVAv0ndjQrlj
         C8BZoN99Z598KRa6CYjjmIWsjIAD/i7147xcIeLQCEY44UuHaWOKQkm8GC9eSAoTajKU
         zGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rI3B29BWDMyy9KKoss/dhVg7Dl8oDvx9k3GAo8kFYmU=;
        b=zUoCkR2YJ2vqteeXzJmRtnp03znn5yEcKtIM7DNcgtAN4u25oz86cDieASEnBZwQJB
         9S8KmN4sKVW5wQAdtslHIbAtYws3dEtc9F7hagiUwhlwnyhf4w64XZbrZSaFBAcfndrh
         NH6978ThUNyoHvrul1mcpLj0kGpupyFzsM5KHMCyDmqnuTfDRaoGxGGF0hflrBLrBpwg
         xhG4hsJdxoJ0BLhZ6ytHY/090lbzi4BMhnNIIuvT5YS3KIXZVn/ArvoqqnG8aEACPE4G
         RVNvNHGqUxC8Y4q8dEB9wGlgO6JEtFkJ/dr/V9Fz12Ke3bntfqVux13xP6xP7XX1hnOX
         200A==
X-Gm-Message-State: AFqh2kohtjEap9E+g4o7EcxemEzxjpPa83hRs31iPd2kfIaG/ixvy2cV
        TMg/43/5Aq93SdzhrDE84k0o0wyMkvr41sP9HLEIXQ==
X-Google-Smtp-Source: AMrXdXuaSou2Mau5lrDV0ZPPM22irKuKTY0RsTudVelKDnM0a1b1X0Ztu7wcAg7uuGJKNrE1EgIQPw==
X-Received: by 2002:a17:90a:30d:b0:229:f58a:9f65 with SMTP id 13-20020a17090a030d00b00229f58a9f65mr31553986pje.2.1674849001500;
        Fri, 27 Jan 2023 11:50:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s5-20020a637705000000b004da425922c6sm2687891pgc.74.2023.01.27.11.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 11:50:01 -0800 (PST)
Message-ID: <63d42ae9.630a0220.bb9b1.4eba@mx.google.com>
Date:   Fri, 27 Jan 2023 11:50:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: acpi-6.2-rc6-146-g628c61874ffd
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 86 runs,
 3 regressions (acpi-6.2-rc6-146-g628c61874ffd)
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

pm/testing baseline: 86 runs, 3 regressions (acpi-6.2-rc6-146-g628c61874ffd)

Regressions Summary
-------------------

platform                     | arch | lab             | compiler | defconfi=
g          | regressions
-----------------------------+------+-----------------+----------+---------=
-----------+------------
cubietruck                   | arm  | lab-baylibre    | gcc-10   | multi_v7=
_defconfig | 1          =

imx53-qsrb                   | arm  | lab-pengutronix | gcc-10   | multi_v7=
_defconfig | 1          =

sun8i-h3-libretech-all-h3-cc | arm  | lab-baylibre    | gcc-10   | multi_v7=
_defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/acpi-6.2=
-rc6-146-g628c61874ffd/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: acpi-6.2-rc6-146-g628c61874ffd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      628c61874ffd18b2ac7596523a60d3a4b3a0e567 =



Test Regressions
---------------- =



platform                     | arch | lab             | compiler | defconfi=
g          | regressions
-----------------------------+------+-----------------+----------+---------=
-----------+------------
cubietruck                   | arm  | lab-baylibre    | gcc-10   | multi_v7=
_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d41da35d920fb81c915f2d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-6.2-rc6-146-g6=
28c61874ffd/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-6.2-rc6-146-g6=
28c61874ffd/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d41da35d920fb81c915f32
        failing since 8 days (last pass: v6.1-rc8-176-gcb06e36a6532, first =
fail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-27T18:53:01.497744  + set +x
    2023-01-27T18:53:01.507001  <8>[   14.747892] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3229509_1.5.2.4.1>
    2023-01-27T18:53:01.616085  / # #
    2023-01-27T18:53:01.719669  export SHELL=3D/bin/sh
    2023-01-27T18:53:01.720718  #
    2023-01-27T18:53:01.823019  / # export SHELL=3D/bin/sh. /lava-3229509/e=
nvironment
    2023-01-27T18:53:01.824059  =

    2023-01-27T18:53:01.824620  / # . /lava-3229509/environment<3>[   15.04=
8441] Bluetooth: hci0: command 0xfc18 tx timeout
    2023-01-27T18:53:01.926944  /lava-3229509/bin/lava-test-runner /lava-32=
29509/1
    2023-01-27T18:53:01.928599   =

    ... (13 line(s) more)  =

 =



platform                     | arch | lab             | compiler | defconfi=
g          | regressions
-----------------------------+------+-----------------+----------+---------=
-----------+------------
imx53-qsrb                   | arm  | lab-pengutronix | gcc-10   | multi_v7=
_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d41d33c46b1face4915eec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-6.2-rc6-146-g6=
28c61874ffd/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qs=
rb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-6.2-rc6-146-g6=
28c61874ffd/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qs=
rb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d41d33c46b1face4915eef
        new failure (last pass: v6.1-rc8-156-g0a9e32afe717)

    2023-01-27T18:51:14.696335  + set +x
    2023-01-27T18:51:14.696472  [   12.862839] <LAVA_SIGNAL_ENDRUN 0_dmesg =
889654_1.5.2.3.1>
    2023-01-27T18:51:14.804182  / # #
    2023-01-27T18:51:14.905958  export SHELL=3D/bin/sh
    2023-01-27T18:51:14.906574  #
    2023-01-27T18:51:15.008484  / # export SHELL=3D/bin/sh. /lava-889654/en=
vironment
    2023-01-27T18:51:15.009020  =

    2023-01-27T18:51:15.110278  / # . /lava-889654/environment/lava-889654/=
bin/lava-test-runner /lava-889654/1
    2023-01-27T18:51:15.110866  =

    2023-01-27T18:51:15.113889  / # /lava-889654/bin/lava-test-runner /lava=
-889654/1 =

    ... (11 line(s) more)  =

 =



platform                     | arch | lab             | compiler | defconfi=
g          | regressions
-----------------------------+------+-----------------+----------+---------=
-----------+------------
sun8i-h3-libretech-all-h3-cc | arm  | lab-baylibre    | gcc-10   | multi_v7=
_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d41ce40902abc458915ebc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-6.2-rc6-146-g6=
28c61874ffd/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-li=
bretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-6.2-rc6-146-g6=
28c61874ffd/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-li=
bretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d41ce40902abc458915ec1
        failing since 8 days (last pass: v6.1-rc8-224-g02f29b079520, first =
fail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-27T18:49:47.996065  <8>[   11.078961] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3229497_1.5.2.4.1>
    2023-01-27T18:49:48.101257  / # #
    2023-01-27T18:49:48.202968  export SHELL=3D/bin/sh
    2023-01-27T18:49:48.203356  #
    2023-01-27T18:49:48.304719  / # export SHELL=3D/bin/sh. /lava-3229497/e=
nvironment
    2023-01-27T18:49:48.305083  =

    2023-01-27T18:49:48.406428  / # . /lava-3229497/environment/lava-322949=
7/bin/lava-test-runner /lava-3229497/1
    2023-01-27T18:49:48.407047  =

    2023-01-27T18:49:48.410754  / # /lava-3229497/bin/lava-test-runner /lav=
a-3229497/1
    2023-01-27T18:49:48.520636  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
