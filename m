Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0237974F88F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 21:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjGKTxl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 15:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGKTxl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 15:53:41 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C72510D2
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 12:53:40 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8b318c5cfso45021755ad.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 12:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689105219; x=1691697219;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yx7286RInQe/fgz3rRGJm49jQUE1I3yrTBxZNuEqjNI=;
        b=gsJkfRL7oKkvNyPIwEBX/zpxztxhvlToPXan1ObrLc8U5sY+oyTbKzUnPMFJsbk/vj
         AU0u3lyzTW+8icI2zMUzn4A2hl/NYwwGSf1QnA8cfdzOgX7MlWIqLvNBftV0XeRvBTVE
         WXCvvRx7BmV6cp36LpMSRgI3Qf/It8jUbGSV/PTxnuInLMY5PWb6n3EH5c9Ia7VnGDOD
         TSutp5VYMuj5wZPJYd7GyyNAgG9urNiQ+8N3LVSC6Js0H5UoFCIz225bDdeiUtT4NibG
         EsDkXH49Pv+R7LE4f0rYduZfDwb9F2M9ZjViwr5JDLo+U3cXlSYJLsqxka5AWamgP8I1
         ct9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689105219; x=1691697219;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yx7286RInQe/fgz3rRGJm49jQUE1I3yrTBxZNuEqjNI=;
        b=PkmjhyaH9XEjBVijMYkwrphG1u/vrmvG8vsjXE0sfRNfOGqWADl0JyGI3MiYNGdUWr
         l4JWS7drqXdEAMHN43leA5OfYZhrdX7NWoy5wECuBvAJvMzVVLkvNIzwCTeWFjhXGP9W
         kk/UIR72qpzlFqOyNN8+qBS7tovbm18Ej9DMrVwRUD5qO5+HIyrQ+Ja4mbTpmaSap3ks
         Wyt4DG8wHk3Iri1Jfu+8y8l5EVUK5vibeKnShshSiB4CBv4rYqn2P186mDhimeE/SaEQ
         yDvQ6SUsKSOWAoIwVgp0z//vNnr/Zvw+zNc4g1PXL/ZzA6i8wbDaMyiX3FgQI+QSrQGY
         a+RQ==
X-Gm-Message-State: ABy/qLbbcaTRfD3niKZNyISKDmdv2wxKY9XoBSTMOf0QP3qx4NiEYvuD
        F+q+WvhrAHioMiXXXy87IdPNkRhSdzVWj0cBYsjWwg==
X-Google-Smtp-Source: APBJJlGtd0js7MaJztZWY23a/bc3yz8VdGtehm21Bw8L5hCitkW+2RLXyNVzVyalYo293CQTMUq/HA==
X-Received: by 2002:a17:902:ab01:b0:1b6:6f12:502e with SMTP id ik1-20020a170902ab0100b001b66f12502emr15255171plb.49.1689105219611;
        Tue, 11 Jul 2023 12:53:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jk8-20020a170903330800b001b9dadf8bd2sm2304997plb.190.2023.07.11.12.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 12:53:38 -0700 (PDT)
Message-ID: <64adb342.170a0220.dde20.55d8@mx.google.com>
Date:   Tue, 11 Jul 2023 12:53:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.5-rc1-15-g61ca8e67fe61
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 39 runs,
 4 regressions (v6.5-rc1-15-g61ca8e67fe61)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 39 runs, 4 regressions (v6.5-rc1-15-g61ca8e67fe61)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
kontron-pitx-imx8m           | arm64 | lab-kontron | gcc-10   | defconfig |=
 2          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.5-rc1=
-15-g61ca8e67fe61/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.5-rc1-15-g61ca8e67fe61
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      61ca8e67fe61d3df255cede64416b70502c3232d =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
kontron-pitx-imx8m           | arm64 | lab-kontron | gcc-10   | defconfig |=
 2          =


  Details:     https://kernelci.org/test/plan/id/64ada79f6bb099953fbb2a9a

  Results:     51 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc1-15-g61ca8e=
67fe61/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc1-15-g61ca8e=
67fe61/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ada79f6bb099953fbb2a9d
        new failure (last pass: v6.4-rc7-126-gf28ec6369334)

    2023-07-11T19:03:35.177650  / # #
    2023-07-11T19:03:35.279662  export SHELL=3D/bin/sh
    2023-07-11T19:03:35.280458  #
    2023-07-11T19:03:35.381743  / # export SHELL=3D/bin/sh. /lava-370719/en=
vironment
    2023-07-11T19:03:35.382354  =

    2023-07-11T19:03:35.483550  / # . /lava-370719/environment/lava-370719/=
bin/lava-test-runner /lava-370719/1
    2023-07-11T19:03:35.484508  =

    2023-07-11T19:03:35.526398  / # /lava-370719/bin/lava-test-runner /lava=
-370719/1
    2023-07-11T19:03:35.526698  + export 'TESTRUN_ID=3D1_bootrr'
    2023-07-11T19:03:35.555893  + cd /lava-370719/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/64a=
da79f6bb099953fbb2aad
        new failure (last pass: v6.4-rc7-126-gf28ec6369334)

    2023-07-11T19:03:37.954151  /lava-370719/1/../bin/lava-test-case
    2023-07-11T19:03:37.954354  <8>[   17.959903] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-07-11T19:03:37.954475  /lava-370719/1/../bin/lava-test-case   =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64ada8a7879b6fd11abb2a7e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc1-15-g61ca8e=
67fe61/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc1-15-g61ca8e=
67fe61/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ada8a7879b6fd11abb2=
a7f
        new failure (last pass: v6.4-rc7-126-gf28ec6369334) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64ada8a6a123d8876fbb2b15

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc1-15-g61ca8e=
67fe61/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all-=
h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc1-15-g61ca8e=
67fe61/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all-=
h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ada8a6a123d8876fbb2=
b16
        failing since 84 days (last pass: v6.3-rc6-135-g5235219c59f8, first=
 fail: v6.3-rc7-153-gbc538c8be4bd) =

 =20
