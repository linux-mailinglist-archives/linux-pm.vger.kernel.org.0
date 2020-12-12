Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFF22D8388
	for <lists+linux-pm@lfdr.de>; Sat, 12 Dec 2020 01:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437812AbgLLAnN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 19:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437801AbgLLAnJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 19:43:09 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E42FC0613D3
        for <linux-pm@vger.kernel.org>; Fri, 11 Dec 2020 16:42:27 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id s21so8033162pfu.13
        for <linux-pm@vger.kernel.org>; Fri, 11 Dec 2020 16:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=s/HcVf7QkxpIxxIG84pFZVvxdcTq5VPQRCDKIK3GE7s=;
        b=DmcXzsd6UOvjON4CQGQy7nyVRSbNO9LlmyoATg3DeL4kV3bpzTMKLfehEQRItzCIL3
         oz5F6cfQ3W5PznOV9Ovjw7Rzs1uLkDcK2TVH13DDRDwLuVBlmZtpb/VWHXNyGVx53g6o
         9pnAeE2Vyiw4aeKjrRivrIMLQY9pfHBh8JOEn24fZ/Ih6wIVti4AUWpYb+vmkxrY+wRf
         V5SUIR0Bv2+/ewOHVW86oADMbaImDwNgDwy/BiYLsEtAWmAHHVJNEMthGygvFUmWrwCU
         h1GDAyqikAde+PeGMntrCZrIzHMWXiGKdp3q5vHNdhjs+KKvazqUtKXtzWKiMTuxDzlk
         uonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=s/HcVf7QkxpIxxIG84pFZVvxdcTq5VPQRCDKIK3GE7s=;
        b=q3ik4gY8LfGBT94qFKal6Zr/acqKzFNMAcBkjhFzzVRdCE5TqVJfU8oG8z6Va2dbl2
         g3pHwFKUxlsNooyBADx0UV3Fhgif9XnpPwVUiWNQcyg+Zn13+GOgGITRcblLUo6lKGAr
         avoVC2zB0jlQdrRJmMj0/CQkZhxaOI/KITAGepjv08kqAo2E2d5eUn8ei9nuBankjMn4
         hNykQPqn5k6EXBL0h6HpYOPGoEDVeC/TiLQnZLUa0pVp7ilu84sJ5KnliW6UAx+U113M
         EwmEEb6FPTYE30s0iXLw0Ev6+7tyfSreZH3i/s925tw5ByYOGPsWhax1gCCvZRxN+WN/
         xneA==
X-Gm-Message-State: AOAM533Z5DXAfoEYl7MEaiJBjltZ1rlMj3ZcYw8UeWfdpwCay4Y5lGIf
        NBYdnGOSfR9ZlaSuWWgvPgMggbbh3/zLXw==
X-Google-Smtp-Source: ABdhPJynrcwaVssmVtuKRR0lzN/gF6B/HN2QN23sSbzZ4pNmT5sGd9IlWQGir0b7y2LVPeRpRehLSA==
X-Received: by 2002:a62:6844:0:b029:198:4f13:e9b2 with SMTP id d65-20020a6268440000b02901984f13e9b2mr14230995pfc.29.1607733747224;
        Fri, 11 Dec 2020 16:42:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z9sm11461622pji.48.2020.12.11.16.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 16:42:26 -0800 (PST)
Message-ID: <5fd411f2.1c69fb81.3f88d.5ab0@mx.google.com>
Date:   Fri, 11 Dec 2020 16:42:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc7-106-g97756044ce06
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 106 runs,
 1 regressions (v5.10-rc7-106-g97756044ce06)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 106 runs, 1 regressions (v5.10-rc7-106-g97756044ce06)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
7-106-g97756044ce06/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc7-106-g97756044ce06
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      97756044ce0645570f22b356174ed0c811458ca7 =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fd406d61e1ff633ecc94cbf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc7-106-g9775=
6044ce06/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc7-106-g9775=
6044ce06/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fd406d61e1ff633ecc94=
cc0
        new failure (last pass: v5.10-rc7-88-g58dfa0fa290bb) =

 =20
