Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A515E8F0A
	for <lists+linux-pm@lfdr.de>; Sat, 24 Sep 2022 19:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiIXRrA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 24 Sep 2022 13:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbiIXRqz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Sep 2022 13:46:55 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2613463F11
        for <linux-pm@vger.kernel.org>; Sat, 24 Sep 2022 10:46:51 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c24so2827953plo.3
        for <linux-pm@vger.kernel.org>; Sat, 24 Sep 2022 10:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=xY/ucOteS/CE3dObBNJYlsqyYXh8wVQKpEdC6EgPDR0=;
        b=NdoJPgPsj+Pq+s2Vmd74sJl9OXquPDeGadssU6xXdTLMFJO5veORFuWbUWuwimcak6
         5GNvt9X8y5Qqvqv3EvAcgNNjIyuo9Ml6ZTuAmmpwMv3ZuSf7Nu/AvY19/1c6ggpBpG+N
         SaM2TO6p7JEkvxHnSq47decLJQ/zQqqKiX6KTLQ7u4kJUdbBs+yuCm5K9OrVJjHKTDSn
         tup2ql4sXkMEgCmVYtGUeGOxTjyK5hPcI4sQt6YBKPG1NdRtLnWJbR0zH2ewEVlcGrbN
         hfr6I8IdGDaX+tZVD7aEA1XDQRTYisdPPm+7jk+bCG0tszdJse3y27m3tRgHmGHuyDcn
         Dy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=xY/ucOteS/CE3dObBNJYlsqyYXh8wVQKpEdC6EgPDR0=;
        b=NWI4ijSh92RLvEED39dvptf1MV3kS8RglQx3OeN1aXGYqFauNg7djEg25+igMJn3ul
         IGy/SKAcvGslFfrAs+Q2EOsbWIfoN1uQn70YTvGHwSo2Cw3/9wSisWL8sv7UEu/3quDe
         iscSbvsvtZe0eAAhwJvotd279d54fxeaHj2YEgJZVAiZCveEuRc6bQoklAfEEphFzNkg
         vgdrR34mzl0IUW9BvXJPTuBJSfIwfYlzs/WHZUGJ+4AaoUr93InZb3vIyjV1909lsPOq
         vyra+xV+XxdCmLE2nAeEIhedmn0GnzQG4c61858c0TcQVw6Z+jAFLgo/OoyJKbWDDOUr
         Wr8g==
X-Gm-Message-State: ACrzQf3y+mA3+jnfW2YOOMUBXdjM0R3gxPINkoITKWGZBCEymyAASZCJ
        nDCrf03u3kG+DSxQ5VkJVcHmzg==
X-Google-Smtp-Source: AMsMyM4aTgareTa2+y4E/oAPys8A+Imc21HaqcsutaYVnrqbYDo9gcFcrtixj5zRqhBvgK0ebv9/VQ==
X-Received: by 2002:a17:903:2451:b0:178:4423:af32 with SMTP id l17-20020a170903245100b001784423af32mr14711568pls.51.1664041610620;
        Sat, 24 Sep 2022 10:46:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ce9100b001786b712bf7sm8161859plg.151.2022.09.24.10.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 10:46:50 -0700 (PDT)
Message-ID: <632f428a.170a0220.db9d3.fd05@mx.google.com>
Date:   Sat, 24 Sep 2022 10:46:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: pm-6.0-rc7-143-g00674ddf1b594
Subject: pm/testing baseline: 86 runs,
 2 regressions (pm-6.0-rc7-143-g00674ddf1b594)
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

pm/testing baseline: 86 runs, 2 regressions (pm-6.0-rc7-143-g00674ddf1b594)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
hifive-unleashed-a00  | riscv | lab-baylibre | gcc-10   | defconfig | 1    =
      =

kontron-kbox-a-230-ls | arm64 | lab-kontron  | gcc-10   | defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-6.0-r=
c7-143-g00674ddf1b594/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: pm-6.0-rc7-143-g00674ddf1b594
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      00674ddf1b5943bf978927923f3a8f00e2cad255 =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
hifive-unleashed-a00  | riscv | lab-baylibre | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/632f366a7a42f56298355674

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-6.0-rc7-143-g006=
74ddf1b594/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unleashed-a0=
0.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-6.0-rc7-143-g006=
74ddf1b594/riscv/defconfig/gcc-10/lab-baylibre/baseline-hifive-unleashed-a0=
0.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/riscv/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/632f366a7a42f56298355=
675
        new failure (last pass: v6.0-rc3-85-gf6f4c123bfbc) =

 =



platform              | arch  | lab          | compiler | defconfig | regre=
ssions
----------------------+-------+--------------+----------+-----------+------=
------
kontron-kbox-a-230-ls | arm64 | lab-kontron  | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/632f37cc41c45c78fb355656

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-6.0-rc7-143-g006=
74ddf1b594/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-l=
s.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-6.0-rc7-143-g006=
74ddf1b594/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-l=
s.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/63=
2f37cc41c45c78fb35565f
        failing since 109 days (last pass: v5.18-rc7-183-g45785e0ed597, fir=
st fail: v5.19-rc1-2-g6a8964e282382)

    2022-09-24T17:00:44.287098  /lava-172958/1/../bin/lava-test-case
    2022-09-24T17:00:44.287695  <8>[   18.008666] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-09-24T17:00:44.287965  /lava-172958/1/../bin/lava-test-case
    2022-09-24T17:00:44.288209  <8>[   18.024705] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2022-09-24T17:00:44.288450  /lava-172958/1/../bin/lava-test-case
    2022-09-24T17:00:44.288683  <8>[   18.040230] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-probed RESULT=3Dpass>
    2022-09-24T17:00:44.288920  /lava-172958/1/../bin/lava-test-case   =

 =20
