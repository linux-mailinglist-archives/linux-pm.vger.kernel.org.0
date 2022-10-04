Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51E25F41D3
	for <lists+linux-pm@lfdr.de>; Tue,  4 Oct 2022 13:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJDLOe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Oct 2022 07:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJDLOb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Oct 2022 07:14:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C0717E35
        for <linux-pm@vger.kernel.org>; Tue,  4 Oct 2022 04:14:30 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso8279532pjk.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Oct 2022 04:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=IURzSERmlWhI8CUkmPugznpVTdYWCnJUt/steetttSU=;
        b=txNdYtukj3vSQoOxO9Hw56l6CAN2jAiXMhVckdgtx3YAjElJlFz7G4TeBbjtofaOdL
         RdekZAqlEzTKVeAyYviM9athUfzAonPQzVGyNMkktgtyafrvTjVRjsfrGGfOxFxwcYRf
         sfiXsGW67PGSmVSLBcsEUldXu9Z6RDvxMtSVYedBhXFU7gMtyZ8V9vOgw4huVnWIyjeX
         zhnF+232UUOLa6bjYcx2FL9k7SFI5xMCobnQMXAeUA8QJbPtADud9TR76+GMZCv7kVuX
         hqEgv/5Wwv9JRO+rAIKFTDzGOLVBDySg7/KRZKRr2LNos+Z02n70JEKa4fYSRkwUw0r6
         y6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=IURzSERmlWhI8CUkmPugznpVTdYWCnJUt/steetttSU=;
        b=cE/o6W9VcULMcnST/lklTRmfRG21Iv3es2PgbDWBkR3daLQL636GgP5NgiDgvRuviC
         FLaiwbb2nnz8lGvChiOhBRfPN+HiE+771Fl2jiOUYK4n5+iI5oekTV8+RYK3SyK5gdKJ
         b8MYHj/+PHCNc+8OayU/IpIaXOcxFH6B/0sPahkC3hoai9aBZG4m4LeUXPrWuOIxaA4o
         Uzl3bAkq+b+bJaGmfTDUYpbb+IKBIyEo8CImQ1wYHcdBZ1+yHXktFTvHTWNL/G0b2r6G
         PPDp3zjLIRg6cAc7J/NSFVhfASIV6mIu1MBVgoCS8ZPOJPmM2ipVXHPZ25h0ftTLtu/T
         7qng==
X-Gm-Message-State: ACrzQf0aWDBOwczm/oFl1S07zYIXQeU4V515Wccsq1LCQLdze8GjaSI1
        wzuDAR+FRmA8fjQ86hvEDTpayQ==
X-Google-Smtp-Source: AMsMyM5ryVGV3Jn8J7HB+F7h7yHDWWwnKcmpozuw0A0r84gnUIjt2ziqDgVlejo6bBC5YTpJuzx6ZA==
X-Received: by 2002:a17:90b:38cc:b0:202:e0e8:e802 with SMTP id nn12-20020a17090b38cc00b00202e0e8e802mr17207184pjb.121.1664882069952;
        Tue, 04 Oct 2022 04:14:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709026f0f00b0017f59ebafe7sm3767760plk.212.2022.10.04.04.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 04:14:29 -0700 (PDT)
Message-ID: <633c1595.170a0220.42ce1.6818@mx.google.com>
Date:   Tue, 04 Oct 2022 04:14:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.0-rc7-188-g34ec1a3f2119
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 60 runs,
 3 regressions (v6.0-rc7-188-g34ec1a3f2119)
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

pm/testing baseline: 60 runs, 3 regressions (v6.0-rc7-188-g34ec1a3f2119)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig        =
  | regressions
----------------------+-------+--------------+----------+------------------=
--+------------
hifive-unleashed-a00  | riscv | lab-baylibre | gcc-10   | defconfig        =
  | 1          =

imx7ulp-evk           | arm   | lab-nxp      | gcc-10   | multi_v7_defconfi=
g | 1          =

kontron-kbox-a-230-ls | arm64 | lab-kontron  | gcc-10   | defconfig        =
  | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.0-rc7=
-188-g34ec1a3f2119/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.0-rc7-188-g34ec1a3f2119
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      34ec1a3f211900baecef2b655ab1017719b7b411 =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig        =
  | regressions
----------------------+-------+--------------+----------+------------------=
--+------------
hifive-unleashed-a00  | riscv | lab-baylibre | gcc-10   | defconfig        =
  | 1          =


  Details:     https://kernelci.org/test/plan/id/633c0789e0ce2fcef0cab5fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.0-rc7-188-g34ec1=
a3f2119/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unleashed-a00.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.0-rc7-188-g34ec1=
a3f2119/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unleashed-a00.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/riscv/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/633c0789e0ce2fcef0cab=
5fb
        new failure (last pass: v6.0-rc7-179-g530bc2b3f53f3) =

 =



platform              | arch  | lab          | compiler | defconfig        =
  | regressions
----------------------+-------+--------------+----------+------------------=
--+------------
imx7ulp-evk           | arm   | lab-nxp      | gcc-10   | multi_v7_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/633c0dde19ee49092fcab5ed

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.0-rc7-188-g34ec1=
a3f2119/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.0-rc7-188-g34ec1=
a3f2119/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/633c0dde19ee49092fcab=
5ee
        failing since 4 days (last pass: pm-6.0-rc7-143-g00674ddf1b594, fir=
st fail: v6.0-rc7-186-gfa11712315997) =

 =



platform              | arch  | lab          | compiler | defconfig        =
  | regressions
----------------------+-------+--------------+----------+------------------=
--+------------
kontron-kbox-a-230-ls | arm64 | lab-kontron  | gcc-10   | defconfig        =
  | 1          =


  Details:     https://kernelci.org/test/plan/id/633c0cce816633a12acab609

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.0-rc7-188-g34ec1=
a3f2119/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.0-rc7-188-g34ec1=
a3f2119/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/63=
3c0cce816633a12acab612
        failing since 119 days (last pass: v5.18-rc7-183-g45785e0ed597, fir=
st fail: v5.19-rc1-2-g6a8964e282382)

    2022-10-04T10:36:38.426475  /lava-178564/1/../bin/lava-test-case
    2022-10-04T10:36:38.426876  <8>[   18.416455] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-10-04T10:36:38.427116  /lava-178564/1/../bin/lava-test-case   =

 =20
