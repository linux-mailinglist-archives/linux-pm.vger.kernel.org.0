Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE0F501F89
	for <lists+linux-pm@lfdr.de>; Fri, 15 Apr 2022 02:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240077AbiDOAW6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Apr 2022 20:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243569AbiDOAWh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Apr 2022 20:22:37 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C453BBDA
        for <linux-pm@vger.kernel.org>; Thu, 14 Apr 2022 17:20:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c23so6033387plo.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Apr 2022 17:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=oIqdTb2P8BlgXu+9L2k23fAfVjfu31eaImG149sIL14=;
        b=XrO/wrYLgazXXIXxvjng9jmTrZdVnrnFTuAT9hBCwcOQQ5uj/RgA+sweZcogY6pYYR
         +2aoGE5gVEONYVMlo1xaCEQtHahll3xronObv5Ez4XR9Md0T15d6mSgk4yX/lm8Fc28X
         0GTDRgy0ckqCdAL/b1D1rM4lRRLXPHUMMU+xQcKp6kjD5bAt1hLo6B4venRNRgMYbVQF
         c5J2jNc0AX79qDpcgcCvOpGi43uZawoOYsbqfxk/OFRox78O/oC3zMPaIDJ4T+uJWL2P
         k/NsEt3n/ydXPPPthFeIGsbwjqeTCtwYJW/GxYQoAhy4EX5ejKp6FsUiAupxYXiQm5gS
         cCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=oIqdTb2P8BlgXu+9L2k23fAfVjfu31eaImG149sIL14=;
        b=RbMcLZeSpY0hlFsQByafnLxQUBAaDlmSmrExAtHE3ecbEf6C7+H9jBR9Pn86pla3YF
         AhK5zTVRBeUdkLZAnElxWp1dRGdEfkpsoTy0jdccEMQ7jKjgw1fTaG9BUAtxE3OzzIS8
         IhlAoQLmG+WMhbo2NAIdUgDOAuaW9s6hxwFKJpgSwzxTtm4K+aovfip6YyPsdicC2tG7
         tNvL14pTeAVvdqkV7BF8+C9av3rdkPNHILlUIBaVfViUS8U5xWaKHn841gtMwXvjSo9A
         P56faXZfezl9DZbi3uP0k8gZfCDD3TqUTwkWV+mUM07gflqpGjNoG8FCbUaTUsuGa7q/
         +JkA==
X-Gm-Message-State: AOAM530UrrrV+fAoTIxWxKJtbdsNa6g9i/6L6pQkT6q1uC91sP8oTj9B
        kAO6L0UoUt+NeT4I5HMYppw3/g==
X-Google-Smtp-Source: ABdhPJyT4SttKYVM3fXJ0EqC5lblsxcKIGtI1RlKoZOAR63u+fwCgQmGWFyt5kR9rfZJwBs6WvfD8A==
X-Received: by 2002:a17:90a:f011:b0:1cd:8da6:122 with SMTP id bt17-20020a17090af01100b001cd8da60122mr1207729pjb.59.1649982007716;
        Thu, 14 Apr 2022 17:20:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y4-20020a056a00190400b004fac0896e35sm972276pfi.42.2022.04.14.17.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 17:20:07 -0700 (PDT)
Message-ID: <6258ba37.1c69fb81.e5967.3b90@mx.google.com>
Date:   Thu, 14 Apr 2022 17:20:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.18-rc2-76-g5675fd487f2b2
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 78 runs,
 3 regressions (v5.18-rc2-76-g5675fd487f2b2)
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

pm/testing baseline: 78 runs, 3 regressions (v5.18-rc2-76-g5675fd487f2b2)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
am57xx-beagle-x15  | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig =
| 1          =

sun50i-h6-pine-h64 | arm64 | lab-baylibre  | gcc-10   | defconfig          =
| 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.18-rc=
2-76-g5675fd487f2b2/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.18-rc2-76-g5675fd487f2b2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5675fd487f2b221a27a44f6ac78bdb2e5f235052 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
am57xx-beagle-x15  | arm   | lab-baylibre  | gcc-10   | multi_v7_defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6258b116a9d2848348ae067c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.18-rc2-76-g5675f=
d487f2b2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-am57xx-beagle-=
x15.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.18-rc2-76-g5675f=
d487f2b2/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-am57xx-beagle-=
x15.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220401.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6258b116a9d2848348ae0=
67d
        new failure (last pass: v5.18-rc2-13-g781d19cfe317e) =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
sun50i-h6-pine-h64 | arm64 | lab-baylibre  | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6258b0f802f3c488faae06e6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.18-rc2-76-g5675f=
d487f2b2/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.18-rc2-76-g5675f=
d487f2b2/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-pine-h64.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220401.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6258b0f802f3c488faae0=
6e7
        new failure (last pass: v5.18-rc2-13-g781d19cfe317e) =

 =



platform           | arch  | lab           | compiler | defconfig          =
| regressions
-------------------+-------+---------------+----------+--------------------=
+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6258b11002f3c488faae06f8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.18-rc2-76-g5675f=
d487f2b2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.18-rc2-76-g5675f=
d487f2b2/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220401.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6258b11002f3c488faae0=
6f9
        new failure (last pass: v5.18-rc2-13-g781d19cfe317e) =

 =20
