Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58FD38F428
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 22:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhEXUUS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 May 2021 16:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbhEXUUR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 May 2021 16:20:17 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161F8C06138B
        for <linux-pm@vger.kernel.org>; Mon, 24 May 2021 13:18:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id q25so3727700pfn.1
        for <linux-pm@vger.kernel.org>; Mon, 24 May 2021 13:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=lsgF7XQE4NOVDHYDhGL9u7LP020eIcKi1qMkZDxJ5Ow=;
        b=Wd9+2HUjcksU39HKRRngL/RR4CU03m9uD383FJ1PMY9skF+Igt3NNsdsPFcs+Dzz5k
         9N5ybGBm78zh3FkLnv6a1+HvyaWxF2Jiw6DQUzPtzliF9VXBT7XZE6g6ukOwlcvOOGnB
         M6Vkf+kjHxCB8Yg7v05j8VCQQM8Vegq6HyGr6lQ/oK9blORaWrxDSWvvQ7yYgzffZfG5
         0MdB6jzEVLWq/t/Z+lXgcKA9b9qdyE/dGYHIhRG0bDZyzZPLLVc7PbgfUWBmOg0Xu47F
         L6hLM0MpYD6SRn5OZf1jajrb4+pzVWDPM9AJK1Uwpb2jLTp8o198+KktBiLASvK3fwHC
         Ydpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=lsgF7XQE4NOVDHYDhGL9u7LP020eIcKi1qMkZDxJ5Ow=;
        b=jw1VfsyPKX6gXP6o2DPdDqyJIErDeMZeBaF4kwvQafc285K/rSHjdW5fsnHzJ6csUN
         uqOq5noU5PLG9ifDRK5sAgNyU5h9xwpkHJW5vxALrUIyDCHkjDipCwpeCkdKiUSbtl9S
         40giTZYp0VzAkfj9tqA3PyHA66dK/OMevm6StdM65dGsB9Fayo7pAff1D6P5Q0pt0b5u
         UABL4aUQB0/8FvLpxDDfSKE+FA2dA80ciwp3LvZiPIp0hdNLXtrkA+0MjKlr3QvkHBhS
         Si4Y9yb92CkcXVnN0giyqrivDxKEyr8jh+dBZkzfvvBdpaKxVoVpbOCjhYNupECJ93J5
         ukMw==
X-Gm-Message-State: AOAM530OdSKvWF5hF5cuwWJgWE+LIei+WqxtPj/32UbZyeBcANMHfWiT
        HU16PTSpr+S0EArH5e8ABRhz6g==
X-Google-Smtp-Source: ABdhPJwyZ/TMoqn4SVhqAEkpTR9w/gQ9LhaN9rhuw1DDdJoUadCcG4NHT9bvGW7czlDXztwRDpLlBg==
X-Received: by 2002:aa7:92da:0:b029:2e0:461f:2808 with SMTP id k26-20020aa792da0000b02902e0461f2808mr26001524pfa.25.1621887527618;
        Mon, 24 May 2021 13:18:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n11sm12508822pff.96.2021.05.24.13.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 13:18:47 -0700 (PDT)
Message-ID: <60ac0a27.1c69fb81.385b7.9c01@mx.google.com>
Date:   Mon, 24 May 2021 13:18:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.13-rc3-26-gc17108d7145e
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 81 runs,
 2 regressions (v5.13-rc3-26-gc17108d7145e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 81 runs, 2 regressions (v5.13-rc3-26-gc17108d7145e)

Regressions Summary
-------------------

platform                 | arch  | lab          | compiler | defconfig | re=
gressions
-------------------------+-------+--------------+----------+-----------+---=
---------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip      | gcc-8    | defconfig | 1 =
         =

r8a77950-salvator-x      | arm64 | lab-baylibre | gcc-8    | defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
3-26-gc17108d7145e/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc3-26-gc17108d7145e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c17108d7145e8c8b80386c02453df5d4b03dbcb1 =



Test Regressions
---------------- =



platform                 | arch  | lab          | compiler | defconfig | re=
gressions
-------------------------+-------+--------------+----------+-----------+---=
---------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip      | gcc-8    | defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/60ac00fffd7255f46eb3afb2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc3-26-gc1710=
8d7145e/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc3-26-gc1710=
8d7145e/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60ac00fffd7255f46eb3a=
fb3
        new failure (last pass: v5.13-rc2-14-g49f1b0f7d4af) =

 =



platform                 | arch  | lab          | compiler | defconfig | re=
gressions
-------------------------+-------+--------------+----------+-----------+---=
---------
r8a77950-salvator-x      | arm64 | lab-baylibre | gcc-8    | defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/60ac00edfd7255f46eb3af97

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc3-26-gc1710=
8d7145e/arm64/defconfig/gcc-8/lab-baylibre/baseline-r8a77950-salvator-x.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc3-26-gc1710=
8d7145e/arm64/defconfig/gcc-8/lab-baylibre/baseline-r8a77950-salvator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60ac00edfd7255f46eb3a=
f98
        new failure (last pass: v5.13-rc2-14-g49f1b0f7d4af) =

 =20
