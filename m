Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434A6604A44
	for <lists+linux-pm@lfdr.de>; Wed, 19 Oct 2022 17:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiJSPB5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Oct 2022 11:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiJSPBk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Oct 2022 11:01:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C552620
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 07:55:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so216104pjf.5
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 07:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5lJzImO3jGvM4OpdjgBJUfZEj12UyXnzA/P3pY1G35I=;
        b=PeCRgL515EaiqE6vlqfu+NHBGh9Ld343KcMU8CdLudykPkB35zMVGbXPAAZiJIKzST
         4psDtjHyp5UWJmgl3P2Qos6XIfK9u+kgwOcUU8y6/Fc5ZXXeMWTEZ3B+KxBUsUzW5DIl
         6CZyQlJHYV8ZzMJOZvGsfm8wEPjrauT2DzQcn0OFG8bJp2hFmXRPZ1LY/FUcP/q6spPc
         pRGKDnqkhOfJGZMsOJBhAGMTeXIptJJWyTsxHoB5yTaQcZO3TcVgy4pT9soYTLBJFTQp
         klGDsWawI4PVrVTzTA9QPxYRQnAjqbQfnB9gu+ADFRlOX/BI05p75lobL5tPnmRIKtML
         0CpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5lJzImO3jGvM4OpdjgBJUfZEj12UyXnzA/P3pY1G35I=;
        b=MibMmqJSBTvRF8Thp1wOev0gwmXgtZG+Hs4WzF7aPra0//yE60dAYxwb/YE+2nReQ/
         z4nGakP9cX0sSqAkBHpbVfG3532/9w4wJ6MgDDYAoJfkOY1Zr1xPF3vdO9JIvePslObZ
         pEcKOodvPsx3WwxQAUimuBzfp7WUTqZm4DSwUHZ/CxxvkE77/bRwyZRiwdSMindDU7yh
         i/6nLmuJgPUULzI/D64o8ptCLItntEvM99/1j9l0KpWim2QFegOLnQO8BBOs7q/TsRH3
         GXKWTw1BZnnhmnAHKHWKT9Fdk9mKIdgIsujRmhpaba/AXpRJzdE+HAqCxx2HCpPPaFiB
         mX1g==
X-Gm-Message-State: ACrzQf2Af3+v+PNtZyrGOvQ7xo69P6gvtLi+/sLwS1PNIyK0Cl7mF89D
        SBxybl0CbjA0Lnx5LjLy0VyYig==
X-Google-Smtp-Source: AMsMyM4/eHVMe4aDWAQXg2Zzld8sRVDjYwBNG2wc1vJPLOBVm1OHP8uYBeu9B57+IagOD6bvfROQdA==
X-Received: by 2002:a17:90a:4588:b0:205:d605:8bcc with SMTP id v8-20020a17090a458800b00205d6058bccmr10279707pjg.205.1666191321791;
        Wed, 19 Oct 2022 07:55:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x184-20020a6286c1000000b005622f99579esm11506316pfd.160.2022.10.19.07.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:55:21 -0700 (PDT)
Message-ID: <63500fd9.620a0220.3f967.5895@mx.google.com>
Date:   Wed, 19 Oct 2022 07:55:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1-rc1-20-g1c24b2556ca7
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 65 runs,
 2 regressions (v6.1-rc1-20-g1c24b2556ca7)
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

pm/testing baseline: 65 runs, 2 regressions (v6.1-rc1-20-g1c24b2556ca7)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
kontron-kbox-a-230-ls | arm64 | lab-kontron  | gcc-10   | defconfig | 1    =
      =

meson-gxbb-p200       | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.1-rc1=
-20-g1c24b2556ca7/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.1-rc1-20-g1c24b2556ca7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1c24b2556ca732f37204db7e4ab5970ccef9196e =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
kontron-kbox-a-230-ls | arm64 | lab-kontron  | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/635005c581a479a0a95e5b46

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.1-rc1-20-g1c24b2=
556ca7/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.1-rc1-20-g1c24b2=
556ca7/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221007.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/63=
5005c581a479a0a95e5b53
        failing since 134 days (last pass: v5.18-rc7-183-g45785e0ed597, fir=
st fail: v5.19-rc1-2-g6a8964e282382)

    2022-10-19T14:12:08.501739  /lava-186765/1/../bin/lava-test-case
    2022-10-19T14:12:08.502040  <8>[   16.689475] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-10-19T14:12:08.502190  /lava-186765/1/../bin/lava-test-case
    2022-10-19T14:12:08.502330  <8>[   16.705545] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2022-10-19T14:12:08.502470  /lava-186765/1/../bin/lava-test-case
    2022-10-19T14:12:08.502604  <8>[   16.721657] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-probed RESULT=3Dpass>
    2022-10-19T14:12:08.502739  /lava-186765/1/../bin/lava-test-case   =

 =



platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
meson-gxbb-p200       | arm64 | lab-baylibre | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/635006036406e703735e5b3b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.1-rc1-20-g1c24b2=
556ca7/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.1-rc1-20-g1c24b2=
556ca7/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221007.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/635006036406e703735e5=
b3c
        new failure (last pass: v6.1-rc1-8-g2deb12ae181b) =

 =20
