Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CB54404D7
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 23:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhJ2VWl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 17:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhJ2VWk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Oct 2021 17:22:40 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE974C061570
        for <linux-pm@vger.kernel.org>; Fri, 29 Oct 2021 14:20:11 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x33-20020a17090a6c2400b001a63ef25836so1960026pjj.3
        for <linux-pm@vger.kernel.org>; Fri, 29 Oct 2021 14:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=IMxZM5NGdjihd24QduAnzn7/hetSno0xVk7Co1C9F0Y=;
        b=qBzXpx2bRxjOY6hYPWwVElSph/Wwohqf2n0wb7DB4AXObw5p0MxsfqLkuCZRLyFO2Y
         2ceOtdngx6UowaeqwDl2VrCJU6umSTnc6FQKJn40CkAaa9sqyvMkRUTqvdtcr1UBZU5p
         swxdkzrN461EYOd7UuFDe1EdzbNua9nv3q/BsodFmSzVOkjGtw2phPooqqyrdjoG2r5i
         Q+fKtbF/O6Lvirk1LRccMaL2ZceUnBvZWAPrW4PVQ1AZF8StrzVUvMMp0dRgh05Z44aP
         HBZrJPbSgR3KCLMo/vGiWoB4UMbNtdBwusYKneTzglzwN5YdjQ69Y4HD7xeEgYfpzpSO
         fO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=IMxZM5NGdjihd24QduAnzn7/hetSno0xVk7Co1C9F0Y=;
        b=KDzzG769Ipap++dqvfM26JG27PGV5r2Cp6si90EnI1dBBl7JRHc8SzbB/UiCgdpvpm
         gvgJQqgFbWaiXIgSAwSZGV9wbuM+1khHlCUrBYkaFw5MDBf12lR/zBRUEIUp2vGBYV1Q
         VX84pyjiYpxlGSGK5YnE77pWI2cbclFwu+oWWAGZ9yGTclGXnJERxvYBJrp6uZzoJbgm
         8L4EL02lJJq6C4TAk2APThHfQROgq/2tjyRlJh0NMbUsEUr89jBMci5aZKdTRg6Aob2l
         dL76mO4TNiuZ3Z71KQ963j5CoY5xeRcJiX9qKg9dNHftHL5oqHLBWYch3IclTUwf2Lyv
         GSwg==
X-Gm-Message-State: AOAM532ZPuKLbAYLmXapaOo6zF+jC+ZgX1HQuNfB/uM/XTtewQXeM64g
        I+rcxfAnYFzapGPBDzA5fFVzZ20urVg4AG0V
X-Google-Smtp-Source: ABdhPJwnsLJEG3kAR00jUDtWQFUEQZkYD50WgYBuHHeoy9+dlkXS1hE/x+ilZAzIPCRv4c4H16uRKg==
X-Received: by 2002:a17:90a:9906:: with SMTP id b6mr22138083pjp.180.1635542411299;
        Fri, 29 Oct 2021 14:20:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f13sm2853900pfe.218.2021.10.29.14.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 14:20:11 -0700 (PDT)
Message-ID: <617c658b.1c69fb81.cd5f3.6cb2@mx.google.com>
Date:   Fri, 29 Oct 2021 14:20:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.15-rc7-122-g5f6ba0ff183c
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 82 runs,
 1 regressions (v5.15-rc7-122-g5f6ba0ff183c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 82 runs, 1 regressions (v5.15-rc7-122-g5f6ba0ff183c)

Regressions Summary
-------------------

platform      | arch  | lab          | compiler | defconfig | regressions
--------------+-------+--------------+----------+-----------+------------
rk3328-rock64 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
7-122-g5f6ba0ff183c/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc7-122-g5f6ba0ff183c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5f6ba0ff183c91ef793c5db5da532357e7b0ba5e =



Test Regressions
---------------- =



platform      | arch  | lab          | compiler | defconfig | regressions
--------------+-------+--------------+----------+-----------+------------
rk3328-rock64 | arm64 | lab-baylibre | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/617c5b1b524f728f7f335904

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc7-122-g5f6b=
a0ff183c/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc7-122-g5f6b=
a0ff183c/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/617c5b1b524f728f7f335=
905
        failing since 3 days (last pass: v5.15-rc6-80-g30c7771b41dc, first =
fail: v5.15-rc7-95-g5ae5ac40021d) =

 =20
