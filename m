Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA2C55291D
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jun 2022 03:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiFUBrj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jun 2022 21:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiFUBrj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2022 21:47:39 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9DC19C1C
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 18:47:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so8257792pjr.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 18:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=5hiMUsOAiispV9lKD8nR1kn5+H7az4ocRnG4z3AL4AM=;
        b=IpItlXKe5T0Iilljd0dWpxCOCnVmcSYud76DGzauFHH2eXnuWwd81hWWf3/bEz79CK
         PmXvVEoZsAOOP5p2QwH1dbVdr2xO7W86cxqVWcEncz4XY/i51dPSRKDoP2vZ6DR3wori
         Pb02rU9q1gx1EDl2ly8q8S6+miWRc4M8xm71aaT+FVPRhNGkh2sa23U9m/i4Fp6UGAeH
         txR1ivJ7yOJjP2PJHlZAvYzLLUU9wl4u3rWWcqWGB2+0zkMaXI85FgBI+OGSQ6r+L2iT
         jYyerkWl6S/zajvDAPar2xl6PvGHM1QnQomp6LNtz/q27jEOKg5GoC/+xAA6xQqq3be2
         qLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=5hiMUsOAiispV9lKD8nR1kn5+H7az4ocRnG4z3AL4AM=;
        b=0KXFOoxzufLfqzsYwGWlQ8SH4C3+/XpSr5AZ482qD6Jp2kcEWSpwz5HG2qZ+kUAJTi
         vkamciL20RriDOYjW4WJx4ofOpHYypYjwX7xk8X6YVRKeraaJQG73xVNgsXPKdhBoDIJ
         Myzh3QFtN9+PyJ6aQ3tvqm2ZS2KuTofWEdkkk9O4qSgS2JT6XVI6pBf/AyAH3w6STQCC
         EGn9MLtDYZBZH8jVe9MZVGjrf+yhe+dAvuwL8rVvJ3HzC7TjTeHelYQxiNF0tPM3kvPf
         eyLacOlak2PGfTVbSfNI399Mn8DPoLxgoGK0m+xm90SeQa9ecVnjccDmJMaCyP2HrHZp
         p8RA==
X-Gm-Message-State: AJIora+DIu6Q/nm/BfdMv6lP5/uzIhQpKfZANiovgXdW1VDGGqWgWkYF
        83Vb3EVhTyPJ2ubOJBs41bAhnx9pMFDG7f48vqo=
X-Google-Smtp-Source: AGRyM1ubuGvCsaSU2rN2I2CPLN7LoKcm5P6slJZRKXDTkiS/PsTuEbT19gMABLQzb8IlHKPrCpoh5g==
X-Received: by 2002:a17:90a:1696:b0:1ec:9d1b:305d with SMTP id o22-20020a17090a169600b001ec9d1b305dmr11658060pja.199.1655776058000;
        Mon, 20 Jun 2022 18:47:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bd44-20020a056a0027ac00b00525113281dasm5400261pfb.201.2022.06.20.18.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 18:47:37 -0700 (PDT)
Message-ID: <62b12339.1c69fb81.961f5.74da@mx.google.com>
Date:   Mon, 20 Jun 2022 18:47:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc3-9-g4abf3e80fc980
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 78 runs,
 3 regressions (v5.19-rc3-9-g4abf3e80fc980)
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

pm/testing baseline: 78 runs, 3 regressions (v5.19-rc3-9-g4abf3e80fc980)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
          | regressions
-----------------------------+-------+---------------+----------+----------=
----------+------------
kontron-kbox-a-230-ls        | arm64 | lab-kontron   | gcc-10   | defconfig=
          | 1          =

sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
          | 1          =

sun8i-h3-libretech-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.19-rc=
3-9-g4abf3e80fc980/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.19-rc3-9-g4abf3e80fc980
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      4abf3e80fc9800c4a666e3167d102c34050a1615 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
          | regressions
-----------------------------+-------+---------------+----------+----------=
----------+------------
kontron-kbox-a-230-ls        | arm64 | lab-kontron   | gcc-10   | defconfig=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/62b11bba0115405aaaa39c29

  Results:     93 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc3-9-g4abf3e=
80fc980/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc3-9-g4abf3e=
80fc980/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/62=
b11bba0115405aaaa39c32
        failing since 13 days (last pass: v5.18-rc7-183-g45785e0ed597, firs=
t fail: v5.19-rc1-2-g6a8964e282382)

    2022-06-21T01:15:24.086037  /lava-130145/1/../bin/lava-test-case
    2022-06-21T01:15:24.131515  <8>[   17.457423] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-06-21T01:15:24.131787  /lava-130145/1/../bin/lava-test-case
    2022-06-21T01:15:24.131934  <8>[   17.470130] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2022-06-21T01:15:24.132079  /lava-130145/1/../bin/lava-test-case
    2022-06-21T01:15:24.132216  <8>[   17.482731] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-probed RESULT=3Dpass>
    2022-06-21T01:15:24.132393  /lava-130145/1/../bin/lava-test-case   =

 =



platform                     | arch  | lab           | compiler | defconfig=
          | regressions
-----------------------------+-------+---------------+----------+----------=
----------+------------
sun50i-h6-pine-h64           | arm64 | lab-collabora | gcc-10   | defconfig=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/62b119f388fa11d14ba39c41

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc3-9-g4abf3e=
80fc980/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc3-9-g4abf3e=
80fc980/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62b119f388fa11d14ba39=
c42
        new failure (last pass: v5.19-rc2-3-gd3104995c5831) =

 =



platform                     | arch  | lab           | compiler | defconfig=
          | regressions
-----------------------------+-------+---------------+----------+----------=
----------+------------
sun8i-h3-libretech-all-h3-cc | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62b11a8bc4299f422aa39c23

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc3-9-g4abf3e=
80fc980/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-libret=
ech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc3-9-g4abf3e=
80fc980/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-libret=
ech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62b11a8bc4299f422aa39=
c24
        new failure (last pass: v5.18-rc6-123-g84d13b694ebbe) =

 =20
