Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2175605E3
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 18:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiF2Qao (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 12:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiF2Qao (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 12:30:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786DA344CC
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 09:30:42 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso19984882pjn.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 09:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=SbEVNJVPmostVrDxiHYGvw9+Jsh1Z2k306WRrlOuT9w=;
        b=Z3LucVdgitErQyAPiivFRSnVJ49kC7wKb78+SRAesEPwHsVLsefDzDN7brukzS3D29
         MyYWmU6HvVO23HpFX7mfVLaID0pElolLonDU/jitPYRufe2ekL9ns6IrBAqEcu/tImF8
         lALIWaa9arPxay0+5u6ePkHo6bXnPQjH2adY1qgYBve1jUDm56VO/GxzDdyO9OPaqEB4
         oYAk3T4bcWXzqZ2mJnzm7+MkoMTR3iSWLfrTNi3/CBjCDbD6Dsnw1skA25BmroMcYKME
         88RqgN080qLaA8pSluNRe5d2LOK+o+ncL3BKQie1VXo6LFymC/4z7iB0jpfxU2wnin3d
         9KIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=SbEVNJVPmostVrDxiHYGvw9+Jsh1Z2k306WRrlOuT9w=;
        b=Ipa6c3nbDtWACwSh7HgWZV7Ghn+0MHyJi2tbkZcQ2BcVrJbHTKjDz51vtaLoDzzeqU
         aVFu0MzsMG/Kqe6vz6h8kR0MsYd2sPWmmX82W7BYVFvLAKuhnptBTCxyWXkhx1DLZ1iX
         ygeorSIrAER8TOcHieC1FKsdDnSFX5tHUiCR1gXRRqNXhZ5USz1PfoRKibgrOhXd/DBf
         C+64Bktr5T954q/a/9HU97hk4mcpzowgTlPnI7G7lPSpsfmvEZUGEqDUQOFJNzdUtr/C
         ypmxba5RCEUcghK95mWDxpHz3A+WtFVSv2uq90VT358Ay6C0kYBo/10XpLMUxZ9kkYtS
         SNHg==
X-Gm-Message-State: AJIora961fo3rwG8DjU+CUxf76wy/7yUxGhCgLuLUCsKZyVBBbObsJTL
        DrFLA+nuxuBVf1mE0COJ08uPDw==
X-Google-Smtp-Source: AGRyM1vdB7XlJqMPfNW7uGLTg44fuOT6dPgNRSH97+1knMH7HHfiPqTrzMjm35rfrTJSoKeDAuLmNQ==
X-Received: by 2002:a17:902:e1d1:b0:16a:1748:19a8 with SMTP id t17-20020a170902e1d100b0016a174819a8mr9714138pla.80.1656520241771;
        Wed, 29 Jun 2022 09:30:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m6-20020a635806000000b0040c9213a414sm11526402pgb.46.2022.06.29.09.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 09:30:41 -0700 (PDT)
Message-ID: <62bc7e31.1c69fb81.44f1e.006c@mx.google.com>
Date:   Wed, 29 Jun 2022 09:30:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc4-35-g06cab9aecb43
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 90 runs,
 3 regressions (v5.19-rc4-35-g06cab9aecb43)
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

pm/testing baseline: 90 runs, 3 regressions (v5.19-rc4-35-g06cab9aecb43)

Regressions Summary
-------------------

platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
imx6ul-pico-hobbit    | arm   | lab-pengutronix | gcc-10   | multi_v7_defco=
nfig | 1          =

jetson-tk1            | arm   | lab-baylibre    | gcc-10   | multi_v7_defco=
nfig | 1          =

kontron-kbox-a-230-ls | arm64 | lab-kontron     | gcc-10   | defconfig     =
     | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.19-rc=
4-35-g06cab9aecb43/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.19-rc4-35-g06cab9aecb43
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      06cab9aecb43a2bac09c7f2fa90df13f29130313 =



Test Regressions
---------------- =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
imx6ul-pico-hobbit    | arm   | lab-pengutronix | gcc-10   | multi_v7_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62bc75d035eae953f6a39bd0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc4-35-g06cab=
9aecb43/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6ul-pico-=
hobbit.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc4-35-g06cab=
9aecb43/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6ul-pico-=
hobbit.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62bc75d035eae953f6a39=
bd1
        failing since 22 days (last pass: thermal-5.16-rc5-48-gf1f42573b6f3=
, first fail: v5.19-rc1-2-g6a8964e282382) =

 =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
jetson-tk1            | arm   | lab-baylibre    | gcc-10   | multi_v7_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62bc781f43df4bd5e9a39beb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc4-35-g06cab=
9aecb43/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc4-35-g06cab=
9aecb43/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62bc781f43df4bd5e9a39=
bec
        new failure (last pass: v5.19-rc4-36-g4035647418c1) =

 =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
kontron-kbox-a-230-ls | arm64 | lab-kontron     | gcc-10   | defconfig     =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/62bc731b4ab52da0f9a39c52

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc4-35-g06cab=
9aecb43/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc4-35-g06cab=
9aecb43/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/62=
bc731b4ab52da0f9a39c5f
        failing since 22 days (last pass: v5.18-rc7-183-g45785e0ed597, firs=
t fail: v5.19-rc1-2-g6a8964e282382)

    2022-06-29T15:43:10.869744  /lava-133069/1/../bin/lava-test-case
    2022-06-29T15:43:10.870097  <8>[   18.383283] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-06-29T15:43:10.870313  /lava-133069/1/../bin/lava-test-case   =

 =20
