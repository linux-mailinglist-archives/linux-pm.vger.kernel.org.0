Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24897878FF
	for <lists+linux-pm@lfdr.de>; Thu, 24 Aug 2023 21:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243462AbjHXT6g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Aug 2023 15:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243375AbjHXT6K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 15:58:10 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAFF1BEF
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 12:58:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c0d0bf18d7so2491515ad.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Aug 2023 12:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692907088; x=1693511888;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KiAJjaFzmGQrS0krSHQyLAe4cSJq3IVa/IEb0WCmUUY=;
        b=y713DrRJxwkAkRoxTd3ooLB4xKtCk75fnVoGYDcftM8aHBd1Dm5b09pl32CTrb7x/g
         lbNpscA+U+TuriJ30cXyCDn6fsxQegdp1eZZKySyGmbgiaFqIo0BjqBszOAnXwQQwqQR
         RUrtwnl8VYxfhH2ZTky+WmNte0LbcmFvZSW3130zXQfgOprZ6ySb9N/jrFpl9nwvcyb6
         tNNP6u9YLCqd/dTbnMa2DUptLU3BjsmtXzb12UxivKfkITMT7WgS+B6YyAck6mbN8iLw
         KhUyVZeuM1GR4BYS+/OJ3r4nJYbjcq+eb1q+UVmMgNFHibZvwGczH7Bo1cZzTm5LhVZh
         h1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692907088; x=1693511888;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KiAJjaFzmGQrS0krSHQyLAe4cSJq3IVa/IEb0WCmUUY=;
        b=few9X1czTkmwjafOPhLcRU4txicWf1e1RJ2z5P4qzF0Z/jlenpkPFKws0tIrsDlOrQ
         oX4VJIsyDgtgC1evYRKNMgRr9t4nvt1uLnOvtP1QMWiFMGCxyJQ1/8+iClaCvzXIRsJ5
         Jy0jLYjPz8iJZ75HPjyvhH2dTzNNlS0nazor5poMXVUAQKLyBceK0q0tbUWOxFCQJDol
         Zkh8hT45kZY1ZFykm9QHZ+WgUIcXFCJmmHzKncGk8TKzoPrha48LQCWFZK56cMyxjrfy
         AZkc+J75koayQ3F6K1EoenHAzasgMRZPtjCvHqQWpi0sSswl/LzY32aH9qaqeW7B0Em6
         gXAA==
X-Gm-Message-State: AOJu0YyhsngxPjxOPTouoecWrXqRSiu/aq7mAHADMkM3v04WKQFH4hnL
        iLxqJh6D3Om1zQWCO+oFXQS+C+yUCLaDWM89aD4=
X-Google-Smtp-Source: AGHT+IHJ51SfgNB8xioJywEq09SG1WEzwu2sYTwGbJRjNTYqkYS8nl+itApfFwT6UI8+8TM1OGT4Mw==
X-Received: by 2002:a17:902:d507:b0:1bf:3c10:1d70 with SMTP id b7-20020a170902d50700b001bf3c101d70mr16238573plg.6.1692907087759;
        Thu, 24 Aug 2023 12:58:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k8-20020a170902694800b001b83dc8649dsm42784plt.250.2023.08.24.12.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 12:58:07 -0700 (PDT)
Message-ID: <64e7b64f.170a0220.19d7b.02e7@mx.google.com>
Date:   Thu, 24 Aug 2023 12:58:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: acpi-6.5-rc8-154-ge1903ccb69a7c
Subject: pm/testing baseline: 51 runs,
 4 regressions (acpi-6.5-rc8-154-ge1903ccb69a7c)
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

pm/testing baseline: 51 runs, 4 regressions (acpi-6.5-rc8-154-ge1903ccb69a7=
c)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
fsl-ls2088a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =

fsl-lx2160a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =

r8a77960-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =

r8a779m1-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/acpi-6.5=
-rc8-154-ge1903ccb69a7c/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: acpi-6.5-rc8-154-ge1903ccb69a7c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      e1903ccb69a7c4c52d4cb4c8ffeefe18ae36bc0f =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
fsl-ls2088a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64e7aa6765287db236286d9d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-6.5-rc8-154-ge=
1903ccb69a7c/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-6.5-rc8-154-ge=
1903ccb69a7c/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e7aa6765287db236286da4
        failing since 41 days (last pass: v6.0-rc3-85-gf6f4c123bfbc, first =
fail: v6.5-rc1-21-g3c61a03588dd8)

    2023-08-24T19:07:04.112285  + [   13.698760] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1245874_1.5.2.4.1>
    2023-08-24T19:07:04.112580  set +x
    2023-08-24T19:07:04.217963  =

    2023-08-24T19:07:04.319153  / # #export SHELL=3D/bin/sh
    2023-08-24T19:07:04.319591  =

    2023-08-24T19:07:04.420549  / # export SHELL=3D/bin/sh. /lava-1245874/e=
nvironment
    2023-08-24T19:07:04.420959  =

    2023-08-24T19:07:04.521937  / # . /lava-1245874/environment/lava-124587=
4/bin/lava-test-runner /lava-1245874/1
    2023-08-24T19:07:04.522618  =

    2023-08-24T19:07:04.526557  / # /lava-1245874/bin/lava-test-runner /lav=
a-1245874/1 =

    ... (12 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
fsl-lx2160a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64e7aadf3014b33134286d77

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-6.5-rc8-154-ge=
1903ccb69a7c/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-6.5-rc8-154-ge=
1903ccb69a7c/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e7aadf3014b33134286d7e
        failing since 161 days (last pass: v6.1-rc5-55-g60453df62d30, first=
 fail: v6.3-rc2-33-g1240ce78c05e)

    2023-08-24T19:08:55.117108  [   16.060777] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1245877_1.5.2.4.1>
    2023-08-24T19:08:55.222419  =

    2023-08-24T19:08:55.323707  / # #export SHELL=3D/bin/sh
    2023-08-24T19:08:55.324112  =

    2023-08-24T19:08:55.425129  / # export SHELL=3D/bin/sh. /lava-1245877/e=
nvironment
    2023-08-24T19:08:55.425647  =

    2023-08-24T19:08:55.526743  / # . /lava-1245877/environment/lava-124587=
7/bin/lava-test-runner /lava-1245877/1
    2023-08-24T19:08:55.527519  =

    2023-08-24T19:08:55.531397  / # /lava-1245877/bin/lava-test-runner /lav=
a-1245877/1
    2023-08-24T19:08:55.553648  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
r8a77960-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64e7aa45360d4bb441286d74

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-6.5-rc8-154-ge=
1903ccb69a7c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-6.5-rc8-154-ge=
1903ccb69a7c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e7aa45360d4bb441286d79
        failing since 35 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-24T19:08:05.365355  / # #

    2023-08-24T19:08:05.467412  export SHELL=3D/bin/sh

    2023-08-24T19:08:05.468121  #

    2023-08-24T19:08:05.569550  / # export SHELL=3D/bin/sh. /lava-11348991/=
environment

    2023-08-24T19:08:05.570264  =


    2023-08-24T19:08:05.671696  / # . /lava-11348991/environment/lava-11348=
991/bin/lava-test-runner /lava-11348991/1

    2023-08-24T19:08:05.672796  =


    2023-08-24T19:08:05.689879  / # /lava-11348991/bin/lava-test-runner /la=
va-11348991/1

    2023-08-24T19:08:05.739443  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-24T19:08:05.739947  + cd /lava-113489<8>[   19.556703] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11348991_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64e7aa55360d4bb441286d83

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-6.5-rc8-154-ge=
1903ccb69a7c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-6.5-rc8-154-ge=
1903ccb69a7c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e7aa55360d4bb441286d88
        failing since 35 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-24T19:08:02.953240  / # #

    2023-08-24T19:08:04.033540  export SHELL=3D/bin/sh

    2023-08-24T19:08:04.035464  #

    2023-08-24T19:08:05.526097  / # export SHELL=3D/bin/sh. /lava-11348992/=
environment

    2023-08-24T19:08:05.527982  =


    2023-08-24T19:08:08.252547  / # . /lava-11348992/environment/lava-11348=
992/bin/lava-test-runner /lava-11348992/1

    2023-08-24T19:08:08.255027  =


    2023-08-24T19:08:08.260382  / # /lava-11348992/bin/lava-test-runner /la=
va-11348992/1

    2023-08-24T19:08:08.324908  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-24T19:08:08.325420  + cd /lava-<8>[   28.496442] <LAVA_SIGNAL_S=
TARTRUN 1_bootrr 11348992_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =20
