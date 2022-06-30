Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49F5562574
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 23:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiF3Vla (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jun 2022 17:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiF3Vl3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 17:41:29 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5CE393FB
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 14:41:28 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id b2so624695pfb.8
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 14:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=upSgHMpJgFuIuVKrROGHyjRHEij6pFoTECDeZaaS/B0=;
        b=szdm3NeLzCwhF2aD1vdpv/IIKH3qk9YiL3jeviaTVbAJuTRDwevHGaU8lmil77XLsz
         qAWLJem9JbkHHDXrNtsrb+jQFYa18dIhCfNILNuNNg0/Hnnv26AQF5UVUoIbepcSPsS3
         hAfxEr1NRS3TNMRygnQiBelwrMzeveGuDi9m0P8ZeZdcn16iOxV37uimo0kFF+QIzIQp
         U92jCKzBlB+MLxKyfTqMJ8HBKwg4wc9jjpgbOUHbiZlGrpMieyT3HFn7IXjWCqJTNhDk
         TwffIbQ8G91T/fWuXLKVRC6hcYa0ch3GKLEhR5yACCkT1XoIqK0rvGa5uI7l5KfeSn4J
         Xugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=upSgHMpJgFuIuVKrROGHyjRHEij6pFoTECDeZaaS/B0=;
        b=e1xqqeab72MwF/GIDtlgPOcx4eryZQIwZ/KqUKY5PLqKWLoKpjYwmH2mc7OhOFKpEu
         qQ+ubXNd4CxuFelJJdkc5RcYKqhUopCV4Z65G33Do98av7EA3AfsuRdf4bHjJAym7Snm
         Zaobo49Xt/UQC45RS/SM9SVgEI4eTW14YgMYFaF5W1OOINFipyJ7wSK57dXXgRIW0Xh6
         lZX4iSW1m6JAvTsD83bKwJj3dzkzJZYzE2gAzdQYo68MGb/idZS320zqzDmZPp+Ye+cK
         IyN5Kk7Px6/i2eZ6MI2aSjztEWqULV2OI21lROvOuPfL1Do2r3K6k1mafosH6Hgw0TUX
         8DhA==
X-Gm-Message-State: AJIora+MLDvTq2vGj1d5qjcSnf6p1QrLv5/xYkxyyEOVwG70CDZyaJeY
        OobiJMY50rMZXrraFA5S3bgMsA==
X-Google-Smtp-Source: AGRyM1s8DEOU2bAewF2z/7vkZ0DdYzlvuIcEO06ai3e0NdYdNFVexr2llRgRg8hc0NJ4i8xHF4+/Yg==
X-Received: by 2002:a63:1b49:0:b0:411:c101:eda5 with SMTP id b9-20020a631b49000000b00411c101eda5mr2091676pgm.600.1656625288138;
        Thu, 30 Jun 2022 14:41:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902bcca00b0015e8d4eb26csm13949438pls.182.2022.06.30.14.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:41:27 -0700 (PDT)
Message-ID: <62be1887.1c69fb81.685bc.485d@mx.google.com>
Date:   Thu, 30 Jun 2022 14:41:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc4-63-g5a03ffb415cc
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 79 runs,
 2 regressions (v5.19-rc4-63-g5a03ffb415cc)
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

pm/testing baseline: 79 runs, 2 regressions (v5.19-rc4-63-g5a03ffb415cc)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
imx8mn-ddr4-evk       | arm64 | lab-nxp     | gcc-10   | defconfig | 1     =
     =

kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.19-rc=
4-63-g5a03ffb415cc/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.19-rc4-63-g5a03ffb415cc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5a03ffb415cc385a45feeacdb7fefba77519321f =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
imx8mn-ddr4-evk       | arm64 | lab-nxp     | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/62be0d282e5756348aa39bd9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc4-63-g5a03f=
fb415cc/arm64/defconfig/gcc-10/lab-nxp/baseline-imx8mn-ddr4-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc4-63-g5a03f=
fb415cc/arm64/defconfig/gcc-10/lab-nxp/baseline-imx8mn-ddr4-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62be0d282e5756348aa39=
bda
        new failure (last pass: v5.19-rc4-35-g06cab9aecb43) =

 =



platform              | arch  | lab         | compiler | defconfig | regres=
sions
----------------------+-------+-------------+----------+-----------+-------=
-----
kontron-kbox-a-230-ls | arm64 | lab-kontron | gcc-10   | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/62be0c08ab71df886fa39c00

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc4-63-g5a03f=
fb415cc/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc4-63-g5a03f=
fb415cc/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/62=
be0c08ab71df886fa39c0d
        failing since 23 days (last pass: v5.18-rc7-183-g45785e0ed597, firs=
t fail: v5.19-rc1-2-g6a8964e282382)

    2022-06-30T20:47:42.190019  /lava-133930/1/../bin/lava-test-case
    2022-06-30T20:47:42.190297  <8>[   17.391835] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-06-30T20:47:42.190446  /lava-133930/1/../bin/lava-test-case
    2022-06-30T20:47:42.190584  <8>[   17.408650] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2022-06-30T20:47:42.190721  /lava-133930/1/../bin/lava-test-case
    2022-06-30T20:47:42.190855  <8>[   17.424306] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-probed RESULT=3Dpass>
    2022-06-30T20:47:42.190989  /lava-133930/1/../bin/lava-test-case   =

 =20
