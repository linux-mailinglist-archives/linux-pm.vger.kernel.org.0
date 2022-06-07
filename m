Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC59653F3D6
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jun 2022 04:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiFGCGu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jun 2022 22:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbiFGCFz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jun 2022 22:05:55 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7906BDA20
        for <linux-pm@vger.kernel.org>; Mon,  6 Jun 2022 19:05:43 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o17so13603109pla.6
        for <linux-pm@vger.kernel.org>; Mon, 06 Jun 2022 19:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=qegWHThAxSzuD/uuIgzL+F5Jl7rzvpDqhHSWtbjVaxI=;
        b=w11Ouff9sDaGzI2vrVrLCAGRMKq4OSSHAbNm7cv0zvCpfm7SUCjppwKkE1xAEXKsoe
         Ded2nEL8+5YKtCOrgwyHmsT8mXuV6gfqh5bmxNoHVaPp+H00BMrbNBsTdsBhAm9l3EmF
         2UOZGyKMNOgK427RoXWZJh3b67Onx/00i2l7IDwWd3dDzlWou1afC7JZGCsYzxk0ol3g
         tSy6u4dIFnhM0CpFOYrHiZ9lpzjRSVVN6b2zK/xTUtaodG1o1ZfdqnaXvftBaRzSEMUm
         RZeowZcIA2BTT0Pw1TOVecTJYCRFUPos8dgbtlPD7KLOMpIG+1bytsPE2Hpik3ntqVqr
         bCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=qegWHThAxSzuD/uuIgzL+F5Jl7rzvpDqhHSWtbjVaxI=;
        b=bCMFBTdAAID7dRbcd8ujnh+PbivVbLngpbzzY8J/NoQIoh04vlqB2lu6zYLwDjTpwe
         HqVu1LaJABbcPpnjgXZ0qayaUfAKzvkDvU6n/WdKQ1/PhVJVcanX/mmkawGyRxbFkzhk
         hKrsLSVsJclsIbSyOBWUTOsA3KexmfXCdM+NEaALP+0NXWvScRXI7fOKUPSIy8F0gk0h
         3e6m35Ym8Pu9JFO04eMnMfjXy61UY7SFuUG247HbWxQ4hfs1JAEntmr+gtvF+ffUduTn
         2bkcouvfw38bXJSaBoDM3AuIUxwhB/Pi8bsLJTuBfqJrrER7JBFBYgTH4blp+XFEL1PK
         DoIg==
X-Gm-Message-State: AOAM532Vpygu9fnvHhdsLXViukxLMG6FLz2acQNs0yF+8xmbSqPDM1+B
        JSzrJsM6LlSOmQeregyVe4NRpQ==
X-Google-Smtp-Source: ABdhPJzQFbMZ93XuouWebMPBwxszI9kaWrIO929nlkpEi8p6P5XVQC1g4VfvtwX/mo7dyxhUqm4tfA==
X-Received: by 2002:a17:903:2451:b0:167:8179:62a8 with SMTP id l17-20020a170903245100b00167817962a8mr7161220pls.148.1654567543199;
        Mon, 06 Jun 2022 19:05:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z27-20020aa79e5b000000b0051bba3844d2sm11055190pfq.162.2022.06.06.19.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 19:05:42 -0700 (PDT)
Message-ID: <629eb276.1c69fb81.e49c6.8b73@mx.google.com>
Date:   Mon, 06 Jun 2022 19:05:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc1-2-g6a8964e282382
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 62 runs,
 3 regressions (v5.19-rc1-2-g6a8964e282382)
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

pm/testing baseline: 62 runs, 3 regressions (v5.19-rc1-2-g6a8964e282382)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
kontron-kbox-a-230-ls        | arm64 | lab-kontron  | gcc-10   | defconfig =
         | 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie  | gcc-10   | defconfig =
         | 1          =

sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.19-rc=
1-2-g6a8964e282382/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.19-rc1-2-g6a8964e282382
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      6a8964e282382ab8f2e64355d2ce8eda80e8fe30 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
kontron-kbox-a-230-ls        | arm64 | lab-kontron  | gcc-10   | defconfig =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/629ea6f17dfb1ee22aa39be8

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc1-2-g6a8964=
e282382/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc1-2-g6a8964=
e282382/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220603.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/62=
9ea6f17dfb1ee22aa39bf1
        new failure (last pass: v5.18-rc7-183-g45785e0ed597)

    2022-06-07T01:16:21.361832  /lava-125182/1/../bin/lava-test-case
    2022-06-07T01:16:21.404824  <8>[   15.941515] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-06-07T01:16:21.405115  /lava-125182/1/../bin/lava-test-case
    2022-06-07T01:16:21.405260  <8>[   15.953982] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2022-06-07T01:16:21.405402  /lava-125182/1/../bin/lava-test-case
    2022-06-07T01:16:21.405539  <8>[   15.966564] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-probed RESULT=3Dpass>
    2022-06-07T01:16:21.405676  /lava-125182/1/../bin/lava-test-case   =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie  | gcc-10   | defconfig =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/629ea93988ec2c052ca39bf1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc1-2-g6a8964=
e282382/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc1-2-g6a8964=
e282382/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220603.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/629ea93988ec2c052ca39=
bf2
        new failure (last pass: v5.18-rc7-126-g6b601767c503e) =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/629ea96931092579c5a39c63

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc1-2-g6a8964=
e282382/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-l=
ibretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc1-2-g6a8964=
e282382/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-l=
ibretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220603.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/629ea96931092579c5a39=
c64
        new failure (last pass: v5.18-rc6-123-g84d13b694ebbe) =

 =20
