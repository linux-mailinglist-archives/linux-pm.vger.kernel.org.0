Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CF66032AB
	for <lists+linux-pm@lfdr.de>; Tue, 18 Oct 2022 20:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiJRSnp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Oct 2022 14:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiJRSng (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Oct 2022 14:43:36 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684808E735
        for <linux-pm@vger.kernel.org>; Tue, 18 Oct 2022 11:43:32 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g28so14938054pfk.8
        for <linux-pm@vger.kernel.org>; Tue, 18 Oct 2022 11:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oKvqhRpWreaje4XKClwgJiI5zDtEyA4r+qs7oRQws48=;
        b=zXyHOtJxW/fE2oz4aSny/GRjj62wLrHTksiUzpNp4rYZ2jiMvaR06y9YFRx7CiAXYf
         sLd9MYPWgFmIkwkep4GEG8zDK7ihsuQMn1iWlswJBYfu6erCL04mlvixXh5pv31CU6mi
         8afiE71/DEZwnqWzPOaa2qnNY/A7ACCU76m2j0bgJEg8VZCNu9dSeyrnW8PytakUZUgu
         4bgfPoHRvPte4yS7JOZL/MMPQPwZ4MYfuznXARDi+maFxkF8rd3HwwFNdy4f7yI05xny
         y59WxB70kpklQShU1QpE8s6itxld+M/mDlxhHZSB4oGAXgiaDJj9M4z3PP1t/3BxSV0V
         OJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKvqhRpWreaje4XKClwgJiI5zDtEyA4r+qs7oRQws48=;
        b=2J6Z0iR19e4n2rmHSqmfssAs7y8DuzAwhV3a+g1cnWszy9YQl+Lu4kpOS2qTdqWWf4
         F2ibfUmWwXOnnjaG66mM+bl9tyEYk27EgWOub5dFM2FgK7Rpkx8aRJddFgpDUI7yT1qL
         kM6KatmPlXDc8DC+qq0XRiBnm6JZaG59zs68tEqQOODdpi8AX3+UpszEpzPovaZRwqyY
         +53s28O3snX1mc/9byRmWnx2bhENANIkxzKjAAKfZU+TyAf436FHwuhZM4obxKcwGfy1
         FCZdiR5/B2QE1XNsAYEsyG86sj3q5N04NYIG7x91u9+XFugtTc8QbkdJwIqtCYAV4g6X
         y43w==
X-Gm-Message-State: ACrzQf1HRIBId7ieGzxfwJ+v/llVwc98ZM/NVfeatUk4D8tfmj/kSMgq
        Jc2eI0r7Pw2BAGNnDwwKGEfj0nH9CDwdy2sX
X-Google-Smtp-Source: AMsMyM4Didgp+RdFLT/33zlHedt/56hQCBacruFUr819Jn7Vts0QBazfo+GANm0Ie42U1bnkMURorg==
X-Received: by 2002:a63:ff4f:0:b0:439:61d6:197 with SMTP id s15-20020a63ff4f000000b0043961d60197mr3746791pgk.67.1666118611891;
        Tue, 18 Oct 2022 11:43:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h22-20020aa796d6000000b00561b455267fsm9716993pfq.27.2022.10.18.11.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:43:31 -0700 (PDT)
Message-ID: <634ef3d3.a70a0220.199f1.23ef@mx.google.com>
Date:   Tue, 18 Oct 2022 11:43:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.1-rc1-18-gba1b46e36fd7
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 58 runs,
 1 regressions (v6.1-rc1-18-gba1b46e36fd7)
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

pm/testing baseline: 58 runs, 1 regressions (v6.1-rc1-18-gba1b46e36fd7)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.1-rc1=
-18-gba1b46e36fd7/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.1-rc1-18-gba1b46e36fd7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      ba1b46e36fd7cae85e58325de9814fd9a594b4fe =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/634ee98884d0a5a67ec2a857

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.1-rc1-18-gba1b46=
e36fd7/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.1-rc1-18-gba1b46=
e36fd7/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221007.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/63=
4ee98884d0a5a67ec2a864
        failing since 133 days (last pass: v5.18-rc7-183-g45785e0ed597, fir=
st fail: v5.19-rc1-2-g6a8964e282382)

    2022-10-18T17:59:20.584550  /lava-186093/1/../bin/lava-test-case
    2022-10-18T17:59:20.584834  <8>[   13.981543] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-10-18T17:59:20.584984  /lava-186093/1/../bin/lava-test-case
    2022-10-18T17:59:20.585122  <8>[   13.999678] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2022-10-18T17:59:20.585258  /lava-186093/1/../bin/lava-test-case
    2022-10-18T17:59:20.585390  <8>[   14.016758] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-probed RESULT=3Dpass>
    2022-10-18T17:59:20.585523  /lava-186093/1/../bin/lava-test-case   =

 =20
