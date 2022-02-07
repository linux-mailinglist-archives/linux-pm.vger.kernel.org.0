Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581304ACC55
	for <lists+linux-pm@lfdr.de>; Mon,  7 Feb 2022 23:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241457AbiBGWxo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Feb 2022 17:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245318AbiBGWxm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Feb 2022 17:53:42 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AE0C061A73
        for <linux-pm@vger.kernel.org>; Mon,  7 Feb 2022 14:53:41 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id i17so15557609pfq.13
        for <linux-pm@vger.kernel.org>; Mon, 07 Feb 2022 14:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=kNpAFmeZu+pw0WMZ/ZH1LIOWwF5YnvLBkUKWNuf+zm4=;
        b=sZtWiBS+2o35vrKRQRnMjh+B2PxnQLhBtwt1L/WmkzM39el5ivFfxGgXD7310X/LM3
         T0RLQG6wNhDEGKohlbvE4StLOKt8LPQ3Q84/JLio1rNekuhiML5sHmLofGa7zEdAkT0B
         SPTIpOzm09XyM505AIP2O4wu3qtnhioGA97bSiUKHOXI7bS5g0NOpA8j3eCjUhJB1stx
         DREj+WxQIU59ZKlI7IKyxjc3Fj5c5WsBCYR7/1+uqyBx/qUhVKnV2CLcjTxo5Zpa0aH0
         PjYvqqe6hoZ7IDnYYlQ3AZF9RMqTDsFQO463bwWmIG8p5Cg4U5cteJXnjGHsAhQjpjsI
         UHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=kNpAFmeZu+pw0WMZ/ZH1LIOWwF5YnvLBkUKWNuf+zm4=;
        b=d7G2dcooV2PFpGu2DylXiBr454vC2Jx+OPFD/RolV0Vo4HtU3sW19YYJRa4nRN+4rp
         ul9VkMxcFFI+bNS40LE/E2tbl6KG+b0Kl9WhzBqMVU+KvBhRMuDgaJ8OWVxGdAXbroeb
         GVLIRo+8XzL47HvYEOmV4fC/qgzUywTRz/AzqZHCp1BCRFNr8iwZnLP5wnSjirCErSEn
         50bmCuCLaFgrAkoqAZeCQur2xAPf+v5H9+WqDmw9WAxe/sa9wZV9U3+u7USfMX8OjkU+
         qokbpDS8XVUUGF58zkMPQgfPHXOCBl+qy7AjZLWMTHFA8IHQXBLEVfW774r5ttuLLlPh
         9TpA==
X-Gm-Message-State: AOAM532gp/7eOgG43+vqmAlNKGZdQ6XttosV/3tGC4Ar6v2ZRG/CP2LX
        2T6vFadTUtIxGB+gIDPTj9+TTWCXJgC665Ge
X-Google-Smtp-Source: ABdhPJzRHm3nVlQFuLVMxsthOwkFjs6rYb4Wl7mlzB6crdPnUmDY7cN5Blv25sKUkS2d2+w8d6z3oA==
X-Received: by 2002:a63:1d56:: with SMTP id d22mr1243933pgm.149.1644274420951;
        Mon, 07 Feb 2022 14:53:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id mh1sm385517pjb.29.2022.02.07.14.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 14:53:40 -0800 (PST)
Message-ID: <6201a2f4.1c69fb81.773fa.1985@mx.google.com>
Date:   Mon, 07 Feb 2022 14:53:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.17-rc3-33-g4e3e936b36f6
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 60 runs,
 4 regressions (v5.17-rc3-33-g4e3e936b36f6)
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

pm/testing baseline: 60 runs, 4 regressions (v5.17-rc3-33-g4e3e936b36f6)

Regressions Summary
-------------------

platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-kbox-a-230-ls  | arm64 | lab-kontron | gcc-10   | defconfig | 2    =
      =

kontron-sl28-var3-ads2 | arm64 | lab-kontron | gcc-10   | defconfig | 2    =
      =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.17-rc=
3-33-g4e3e936b36f6/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.17-rc3-33-g4e3e936b36f6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      4e3e936b36f69b2f9cd7417564b0f54111df9a7e =



Test Regressions
---------------- =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-kbox-a-230-ls  | arm64 | lab-kontron | gcc-10   | defconfig | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/620195af334dc314785d6ee8

  Results:     91 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-33-g4e3e9=
36b36f6/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-33-g4e3e9=
36b36f6/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/620195af334dc314785d6f29
        failing since 12 days (last pass: v5.16-rc8-171-gf099fd60c342, firs=
t fail: v5.17-rc1)

    2022-02-07T21:56:34.405152  /lava-84751/1/../bin/lava-test-case   =


  * baseline.bootrr.ftm-alarm-probed: https://kernelci.org/test/case/id/620=
195af334dc314785d6f2a
        failing since 12 days (last pass: v5.16-rc8-171-gf099fd60c342, firs=
t fail: v5.17-rc1)

    2022-02-07T21:56:34.408590  <8>[   17.266059] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>
    2022-02-07T21:56:35.454957  /lava-84751/1/../bin/lava-test-case
    2022-02-07T21:56:35.455331  <8>[   18.284761] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-sl28-var3-ads2 | arm64 | lab-kontron | gcc-10   | defconfig | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/620195c3334dc314785d6f58

  Results:     99 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-33-g4e3e9=
36b36f6/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-33-g4e3e9=
36b36f6/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/620195c3334dc314785d6fa0
        failing since 12 days (last pass: v5.16-rc8-171-gf099fd60c342, firs=
t fail: v5.17-rc1-9-g52d883c7bbae)

    2022-02-07T21:57:02.771314  <8>[   12.431592] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drcpm-probed RESULT=3Dpass>
    2022-02-07T21:57:03.785588  /lava-84748/1/../bin/lava-test-case   =


  * baseline.bootrr.ftm-alarm-probed: https://kernelci.org/test/case/id/620=
195c3334dc314785d6fa1
        failing since 12 days (last pass: v5.16-rc8-171-gf099fd60c342, firs=
t fail: v5.17-rc1-9-g52d883c7bbae)

    2022-02-07T21:57:03.788781  <8>[   13.448065] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>
    2022-02-07T21:57:04.837179  /lava-84748/1/../bin/lava-test-case
    2022-02-07T21:57:04.837576  <8>[   14.466705] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-probed RESULT=3Dfail>
    2022-02-07T21:57:04.837815  /lava-84748/1/../bin/lava-test-case
    2022-02-07T21:57:04.838038  <8>[   14.483608] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsimple-mfd-i2c-driver-present RESULT=3Dpass>   =

 =20
