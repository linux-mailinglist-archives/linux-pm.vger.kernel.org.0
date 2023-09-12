Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B79879D313
	for <lists+linux-pm@lfdr.de>; Tue, 12 Sep 2023 16:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbjILOB4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Sep 2023 10:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbjILOBs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Sep 2023 10:01:48 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EEB10DC
        for <linux-pm@vger.kernel.org>; Tue, 12 Sep 2023 07:01:44 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bf57366ccdso46675125ad.1
        for <linux-pm@vger.kernel.org>; Tue, 12 Sep 2023 07:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694527304; x=1695132104; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u+9Aj2XfdGoEcas/B516sqTjAY0lSxsGMxCLrIoY1gY=;
        b=Jb23C/3o1EuZakFZ4k02mTunpnI7W5gFExMgaZKRoW4k+75fc+0MWIeRuqZhqjhPWb
         m4nTC+S4oDZRCk9Zv+8KiHQ3r0ZNGxWa7wF+SVXkDxZ/oRSTJJOVtAIQX12+pGO7oJYY
         9EsL8dAM5n3Pdoly238ERxTLHleyl+7mWMUo6RmxS2AYk6jCLwwigjfkM5P6ecFPqulm
         3JFGzgBi2rQD4IOsEU2ad4eqP6MR+RwNl5eEVNkpGSTVxIJMIKcfDVJ/s52hA7M+NpbN
         /U0qT4SJZz4xv5tFqclRk70xAqG3SZS6G5Feah109lWCHnme07pC/dYoGgblsPetUN1H
         WF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694527304; x=1695132104;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+9Aj2XfdGoEcas/B516sqTjAY0lSxsGMxCLrIoY1gY=;
        b=KaPcrv13OTiilwGnkJca3l1T/c0BXvdryOAmaic+W/nvQre/wA6mY9zR+cpTtM+zke
         wdW1IEFw0ZYci/zqgyTmVDxHWIqY1uijDTUrLjBGTJFRFPO7d4nrFsi6kGndZiQju+gP
         9o1DxHezZ9gOFCcVFA4+6qkN3LREdWHdaYx/B5Q9cs2zP5N7/D9B/JPBltWveFBQPln7
         JsLc4DLiLAFGSDC8q0i/I4HMU+78ODNJlrdfxwqsy2ZaLJDPMrOH1PjkvdPFoo9ji1nZ
         mFug0fmwsSYBom/LMlaqLfSYBwv84vFhr3AtbrXGdGlJxf9T3klQJk/hXyD2TBJlZvaP
         fWjg==
X-Gm-Message-State: AOJu0YwfZglE/Kn8Ncuq9sJhLkU5NTJefrDtUKLI6W3bQdmwLWUBkySu
        eM0rCtx5efai+Wn91hBeMcTWRN9US8XVSz0RD8Y=
X-Google-Smtp-Source: AGHT+IGnYXxlO2B6nP12uCKxgIq/rjikOUCHGX6bwPQxHGvW/+CEo9gbiwb+67RK1tVSHAgc35q1Tg==
X-Received: by 2002:a17:902:da87:b0:1be:f37f:a8d5 with SMTP id j7-20020a170902da8700b001bef37fa8d5mr2965152plx.10.1694527304256;
        Tue, 12 Sep 2023 07:01:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c11100b001b8a1a25e6asm8481927pli.128.2023.09.12.07.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 07:01:43 -0700 (PDT)
Message-ID: <65006f47.170a0220.ffad3.6b98@mx.google.com>
Date:   Tue, 12 Sep 2023 07:01:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.6-rc1-5-gb5eda4c9c923
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 49 runs, 5 regressions (v6.6-rc1-5-gb5eda4c9c923)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 49 runs, 5 regressions (v6.6-rc1-5-gb5eda4c9c923)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
imx8mp-evk         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =

kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig | 2      =
    =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

r8a779m1-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.6-rc1=
-5-gb5eda4c9c923/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.6-rc1-5-gb5eda4c9c923
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      b5eda4c9c923df3ee79181406652733b3faf2994 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
imx8mp-evk         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/650065466619d8db378a0a67

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc1-5-gb5eda4c=
9c923/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc1-5-gb5eda4c=
9c923/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650065466619d8db378a0a70
        new failure (last pass: pm-6.6-rc1-122-g07b618ec9d7a)

    2023-09-12T13:18:34.156843  + set<8>[   29.054628] <LAVA_SIGNAL_ENDRUN =
0_dmesg 102572_1.5.2.4.1>
    2023-09-12T13:18:34.157247   +x
    2023-09-12T13:18:34.266046  / # #
    2023-09-12T13:18:35.431932  export SHELL=3D/bin/sh
    2023-09-12T13:18:35.438065  #
    2023-09-12T13:18:36.937144  / # export SHELL=3D/bin/sh. /lava-102572/en=
vironment
    2023-09-12T13:18:36.943284  =

    2023-09-12T13:18:39.663443  / # . /lava-102572/environment/lava-102572/=
bin/lava-test-runner /lava-102572/1
    2023-09-12T13:18:39.669564  =

    2023-09-12T13:18:39.676522  / # /lava-102572/bin/lava-test-runner /lava=
-102572/1 =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
kontron-pitx-imx8m | arm64 | lab-kontron   | gcc-10   | defconfig | 2      =
    =


  Details:     https://kernelci.org/test/plan/id/6500656fdded00e7848a0aac

  Results:     51 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc1-5-gb5eda4c=
9c923/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc1-5-gb5eda4c=
9c923/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6500656fdded00e7848a0ab3
        new failure (last pass: pm-6.6-rc1-122-g07b618ec9d7a)

    2023-09-12T13:19:24.436700  / # #
    2023-09-12T13:19:24.538999  export SHELL=3D/bin/sh
    2023-09-12T13:19:24.539732  #
    2023-09-12T13:19:24.641102  / # export SHELL=3D/bin/sh. /lava-379191/en=
vironment
    2023-09-12T13:19:24.641838  =

    2023-09-12T13:19:24.743332  / # . /lava-379191/environment/lava-379191/=
bin/lava-test-runner /lava-379191/1
    2023-09-12T13:19:24.744513  =

    2023-09-12T13:19:24.763506  / # /lava-379191/bin/lava-test-runner /lava=
-379191/1
    2023-09-12T13:19:24.806393  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-12T13:19:24.818016  + cd /l<8>[   15.713229] <LAVA_SIGNAL_START=
RUN 1_bootrr 379191_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/650=
0656fdded00e7848a0ac3
        new failure (last pass: pm-6.6-rc1-122-g07b618ec9d7a)

    2023-09-12T13:19:27.202178  /lava-379191/1/../bin/lava-test-case
    2023-09-12T13:19:27.202603  <8>[   18.195978] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>   =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6500652f1661c3ba1f8a0a49

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc1-5-gb5eda4c=
9c923/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc1-5-gb5eda4c=
9c923/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6500652f1661c3ba1f8a0a52
        failing since 54 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-09-12T13:22:31.108596  / # #

    2023-09-12T13:22:31.210950  export SHELL=3D/bin/sh

    2023-09-12T13:22:31.211755  #

    2023-09-12T13:22:31.313217  / # export SHELL=3D/bin/sh. /lava-11505621/=
environment

    2023-09-12T13:22:31.313985  =


    2023-09-12T13:22:31.415447  / # . /lava-11505621/environment/lava-11505=
621/bin/lava-test-runner /lava-11505621/1

    2023-09-12T13:22:31.416556  =


    2023-09-12T13:22:31.422513  / # /lava-11505621/bin/lava-test-runner /la=
va-11505621/1

    2023-09-12T13:22:31.482742  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-12T13:22:31.483260  + cd /lav<8>[   20.487088] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11505621_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a779m1-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65006540a502233ff58a0a4f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc1-5-gb5eda4c=
9c923/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc1-5-gb5eda4c=
9c923/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65006540a502233ff58a0a58
        failing since 54 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-09-12T13:20:27.378654  / # #

    2023-09-12T13:20:28.459545  export SHELL=3D/bin/sh

    2023-09-12T13:20:28.461441  #

    2023-09-12T13:20:29.952809  / # export SHELL=3D/bin/sh. /lava-11505622/=
environment

    2023-09-12T13:20:29.954816  =


    2023-09-12T13:20:32.680745  / # . /lava-11505622/environment/lava-11505=
622/bin/lava-test-runner /lava-11505622/1

    2023-09-12T13:20:32.683127  =


    2023-09-12T13:20:32.687541  / # /lava-11505622/bin/lava-test-runner /la=
va-11505622/1

    2023-09-12T13:20:32.752430  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-12T13:20:32.752939  + cd /lava-115056<8>[   29.529134] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11505622_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =20
