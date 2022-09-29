Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377875F000A
	for <lists+linux-pm@lfdr.de>; Fri, 30 Sep 2022 00:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiI2WZD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Sep 2022 18:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiI2WZA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Sep 2022 18:25:00 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4918612098
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2022 15:24:58 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id iw17so2459100plb.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2022 15:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=gm4Cc2MJz7YR7/Pm0P++E+wKU7M/B6ITpNo7bOMKdbM=;
        b=hxi0EZ/zBf2aoyehcj5GQR26kJ74kJ8w4jzOScWbR87zKhxu4aguB3h+uADc8a+3qt
         HUTc+A/SmdpKuYGcxpnBTc4dwpmekZBHA36+Y7GRy0z4G1292lslY+ewAJx7Av6HZ16x
         +Rb11ZMhxtB5QpIZBvpmwoMiTw7TdxSKWVrrWLXUfucgDXYqQKZEZofIjRLGKNyI596d
         1L2V4FlB/6wgvLyuIbZGJPYQJTsypeVn0RLJUyAmgF+LAikF/0jgI5mgo5jol/X/p4XY
         /RTLVry4XXhhJ8wjXq1ldHzK8dEv7GQEeYFsBPIg29xLe7Wd8DP9tlx/XmItVe645cKL
         wIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=gm4Cc2MJz7YR7/Pm0P++E+wKU7M/B6ITpNo7bOMKdbM=;
        b=0s1hoAbuWYrIYhh/rWSsX+mhvGAsxkpq+X79SeG+AxITWpqQ6lHz72ExvlfvxQaWuJ
         5GxkQg05f6RA+j8rIRcVkBN38sVAU2PpPU36z8xxD32XsFt3Z805brGHDU754Ls7pSAD
         44Jko11aEr7bmKxtnrNfRz/42O7VL03spbpmWHJWXcFYzeVDFGBlmN4eBdcldpKx/mTI
         teby/0+1bDFAjJrf1RVdJl86vpx3KQGa0otUppW2i6Qy8r5H9zsmjbEosst81xHnrTxH
         g1R8NYnimtX39SmBFz3hjILL1Aw5GrksbnXuZm4q+NKa5gw1buuHNp8GwMVdEVttCJoN
         0b8g==
X-Gm-Message-State: ACrzQf2JZSqkOOfxlnxsDbr1eGbMXRsL6PsbeJpwC1BahnipZvjyylVj
        e2rOAYhbe6zTuRNv/DTDgUX+Gw==
X-Google-Smtp-Source: AMsMyM6//EAYc0O22Cx8jdzILHCg53MVlCrAzoBgspf2uwgRsCGOLDwhE6ZrGUvXPql1KJmCqH/s2A==
X-Received: by 2002:a17:902:8214:b0:178:95c9:bd5d with SMTP id x20-20020a170902821400b0017895c9bd5dmr5775485pln.106.1664490297877;
        Thu, 29 Sep 2022 15:24:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b0017a0668befasm389185pln.124.2022.09.29.15.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 15:24:57 -0700 (PDT)
Message-ID: <63361b39.170a0220.12b4e.0fb5@mx.google.com>
Date:   Thu, 29 Sep 2022 15:24:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.0-rc7-186-gfa11712315997
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 77 runs,
 2 regressions (v6.0-rc7-186-gfa11712315997)
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

pm/testing baseline: 77 runs, 2 regressions (v6.0-rc7-186-gfa11712315997)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig         =
 | regressions
----------------------+-------+-------------+----------+-------------------=
-+------------
imx7ulp-evk           | arm   | lab-nxp     | gcc-10   | multi_v7_defconfig=
 | 1          =

kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig         =
 | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.0-rc7=
-186-gfa11712315997/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.0-rc7-186-gfa11712315997
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      fa117123159976b3799c5738677e0489f8537abc =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig         =
 | regressions
----------------------+-------+-------------+----------+-------------------=
-+------------
imx7ulp-evk           | arm   | lab-nxp     | gcc-10   | multi_v7_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6336121b6229346ebfec4eb8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.0-rc7-186-gfa117=
12315997/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.0-rc7-186-gfa117=
12315997/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6336121b6229346ebfec4=
eb9
        new failure (last pass: pm-6.0-rc7-143-g00674ddf1b594) =

 =



platform              | arch  | lab         | compiler | defconfig         =
 | regressions
----------------------+-------+-------------+----------+-------------------=
-+------------
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig         =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/63360fbb8843c0fd87ec4ea9

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.0-rc7-186-gfa117=
12315997/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.0-rc7-186-gfa117=
12315997/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/63=
360fbb8843c0fd87ec4eb6
        failing since 114 days (last pass: v5.18-rc7-183-g45785e0ed597, fir=
st fail: v5.19-rc1-2-g6a8964e282382)

    2022-09-29T21:35:40.521842  /lava-176316/1/../bin/lava-test-case
    2022-09-29T21:35:40.522137  <8>[   19.568449] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =

 =20
