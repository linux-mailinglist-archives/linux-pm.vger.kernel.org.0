Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4966E59D06D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 07:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239967AbiHWFXG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 01:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239968AbiHWFXF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 01:23:05 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9ED57897
        for <linux-pm@vger.kernel.org>; Mon, 22 Aug 2022 22:23:04 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p9so11350608pfq.13
        for <linux-pm@vger.kernel.org>; Mon, 22 Aug 2022 22:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=ByKrNoKnaz+mzCTp3tMm6k/d//lHX8Nf+xz0gECUU2s=;
        b=4Ai8RhhyJcJCMdo1qKCvMtI1VGEfuEXosyjM85//UJQTZ3jUTo6vJf6AVX0ITNQ0BV
         P2LuVP92LVNmrY1VaNq+mwOl7df6L/jef2Gn/gl8GQYcuLEG2uuEUWe3eKqvEIO+TKRJ
         MbAoe4DkmeXR40UuJuJ/jMCwpZtdJvoecIf/7FHtR/sE2AM7SOZs6D9eaesiPHxCH90E
         WwQeT8Wbos2JJWEvgy8JlXdsZuhF+jWE2W1JL15Vlz67BSseXWuWK4w1LIjtDLWiMuQ+
         Tfek4kvP5NqnxmqDUjWN/Sjm9jmLGXhm5f1WaidDDAKttJqfQYE6mz2qvzzhWqVVMikY
         uIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=ByKrNoKnaz+mzCTp3tMm6k/d//lHX8Nf+xz0gECUU2s=;
        b=2pVPvOAIy4r7RCjAZcaSjPSlYIXJvwg/7XWyk++uRG0HZIn2A3L2FyES7FWjbfpktT
         nIWA5oyARalUdm/gBeOHsF/kABDsXluXKieUwy95gsB91Kqj6jDz3JhVk0ia8NXGFNVQ
         6mPh+GgjnVxNUcLLUYCT7AqvGRxaEsZkofMtnTrtExHgQZ3XixmbUhVSULd7n8gDpH13
         P5aNeHJ8pYnDQJUeECVWT0rHtYBW8Z6xMeouWv3nEwF7VcIaiS+3kaPKzoBVGKsybdeQ
         zjIRRgn5UC/SSTsOlxwigbz/AP9jVe1olIw8W6aGXecOg7nC00KexBTwbal52niucqJG
         phQQ==
X-Gm-Message-State: ACgBeo39j36UpUgi/lsU8+0VfcUzxyX47I04aPg9yiLwxt8GhhyXy6+l
        cciLN7sHDlfHvDfkcqqhfo6YgtTjxZD2D73m
X-Google-Smtp-Source: AA6agR5NHj4mTMp/oKUHaIfK9TObiB4rf5NoBr0zroMass29bWL8xtHqSBTj+CtcFYkIEDLLflK6DQ==
X-Received: by 2002:a65:490e:0:b0:41c:5b91:e845 with SMTP id p14-20020a65490e000000b0041c5b91e845mr19489733pgs.436.1661232184023;
        Mon, 22 Aug 2022 22:23:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id iw3-20020a170903044300b00172709064besm9339851plb.46.2022.08.22.22.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 22:23:03 -0700 (PDT)
Message-ID: <63046437.170a0220.f496d.1b91@mx.google.com>
Date:   Mon, 22 Aug 2022 22:23:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.0-rc1-6-g977346c02019
Subject: pm/testing baseline: 79 runs, 3 regressions (v6.0-rc1-6-g977346c02019)
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

pm/testing baseline: 79 runs, 3 regressions (v6.0-rc1-6-g977346c02019)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =

kontron-pitx-imx8m    | arm64 | lab-kontron | gcc-10   | defconfig | 2     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.0-rc1=
-6-g977346c02019/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.0-rc1-6-g977346c02019
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      977346c0201990e55abf89a202849e71ba88c6c8 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/63045a108a42e8f6ef355673

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.0-rc1-6-g977346c=
02019/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.0-rc1-6-g977346c=
02019/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/63=
045a108a42e8f6ef355680
        failing since 77 days (last pass: v5.18-rc7-183-g45785e0ed597, firs=
t fail: v5.19-rc1-2-g6a8964e282382)

    2022-08-23T04:39:27.963621  /lava-158035/1/../bin/lava-test-case
    2022-08-23T04:39:27.963990  <8>[   18.991863] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-08-23T04:39:27.964246  /lava-158035/1/../bin/lava-test-case
    2022-08-23T04:39:27.964475  <8>[   19.007961] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>   =

 =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-pitx-imx8m    | arm64 | lab-kontron | gcc-10   | defconfig | 2     =
     =


  Details:     https://kernelci.org/test/plan/id/630459fbf63f46400635565e

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.0-rc1-6-g977346c=
02019/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.0-rc1-6-g977346c=
02019/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.imx6q-pcie-pcie0-probed: https://kernelci.org/test/case=
/id/630459fbf63f464006355670
        new failure (last pass: v5.19-rc8-92-ge240a33f1bc48)

    2022-08-23T04:39:10.825855  /lava-158034/1/../bin/lava-test-case
    2022-08-23T04:39:10.826235  <8>[   19.246528] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dimx6q-pcie-pcie0-probed RESULT=3Dfail>
    2022-08-23T04:39:10.826487  /lava-158034/1/../bin/lava-test-case   =


  * baseline.bootrr.intel-igb-probed: https://kernelci.org/test/case/id/630=
459fbf63f464006355672
        new failure (last pass: v5.19-rc8-92-ge240a33f1bc48)

    2022-08-23T04:39:11.863133  /lava-158034/1/../bin/lava-test-case
    2022-08-23T04:39:11.863523  <8>[   20.290542] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dintel-igb-probed RESULT=3Dfail>
    2022-08-23T04:39:11.863775  /lava-158034/1/../bin/lava-test-case
    2022-08-23T04:39:11.864009  <8>[   20.310475] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-driver-present RESULT=3Dpass>   =

 =20
