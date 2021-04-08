Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E096359045
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 01:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhDHXU0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 19:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhDHXUZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 19:20:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FB3C061760
        for <linux-pm@vger.kernel.org>; Thu,  8 Apr 2021 16:20:12 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so2241347pjv.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Apr 2021 16:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=LuN7pqNyHZWwPU1G9ObkIDSxrY6IQQGE+xCm6BUdMHI=;
        b=04CJYvFXXb/GaDSa3UxuBt+Z6H5tK8DckIG2u1JSyUhzMNLY7wLEo9wc34kHnlfht5
         mUr3fyCK9GQJFER/eBiG+s31uMPq/QBrExrM+wCRlROkpGWBNXKFgE0GCVQ9fPrQwaqw
         TZIAT2IdLWd6suxCNIbA7J+0AUQL0pGm3biGnQ95NmxcLnDM1bVmR6Ur/8w03bWNEC/D
         ZwnZldQ7snw5bfB3v+g3KIP5efcLdYBqgA1moFUh7Zt0lVqloRfjUwIHe4zqggmHawpk
         0dMpLgNUhzqht1F7UvsDGBnSdD6UwDg7fsyIEyTE+0M/Qa2ZSJ1rOulInXQoRHGbA6Zv
         7PJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=LuN7pqNyHZWwPU1G9ObkIDSxrY6IQQGE+xCm6BUdMHI=;
        b=bYscXi/Jxio6dPEiLuCqdBjqjggLBYZHQCaicYDYCFwE09eaityvS1NrsnfiOb5nDT
         t2T7xnoXJjVOR9bfgQqPPvhwbrbMKNGYjHMXpGmN0mFIF1ux0aHhA8qg4pkAIffRi+4F
         iWVDAWW1C3n+1ssW6qRozjjLsBv6X0juVoS/5DnkBqLXG2uXL+VzZPsyPGHvwJlL2cRW
         whrYXjFyKF5zFrELHIDslnIu+Z7DT90vy5Ii/m8t0JsOyl8wjeIQM+hof7/QA9BSpteN
         DfP/Tc5BWWcAXt2PhZ6Cqoco/YU/rdF1ziiwO1nwYB3F8Yj0Wj99lwiA0t+zKlpdEEL5
         zf8g==
X-Gm-Message-State: AOAM531T9gdhttaCmGyP5a228I0h5m1p3xeMf7wVFQLIa4+rEYkIRhvd
        ttKyhMYbacKwtju+dzPmgZ6sKdnmerA+cQ39
X-Google-Smtp-Source: ABdhPJwHU4hWPgcJgB8YtSErFCUj3BANz0xGtd+v+pT2JGAouTU/xN4vMQkafuHFwgLcL4c3fivA5w==
X-Received: by 2002:a17:90b:1bce:: with SMTP id oa14mr10822642pjb.9.1617924012294;
        Thu, 08 Apr 2021 16:20:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j1sm381978pjn.26.2021.04.08.16.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 16:20:12 -0700 (PDT)
Message-ID: <606f8fac.1c69fb81.d71bd.1a28@mx.google.com>
Date:   Thu, 08 Apr 2021 16:20:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.12-rc6-72-gea176976603a0
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 5 runs, 1 regressions (v5.12-rc6-72-gea176976603a0)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 1 regressions (v5.12-rc6-72-gea176976603a0)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
6-72-gea176976603a0/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc6-72-gea176976603a0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      ea176976603a0deb74a3453f09a83f21adfde207 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/606f83214c41a832e0dac6b6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc6-72-gea176=
976603a0/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc6-72-gea176=
976603a0/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0324.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/606f83214c41a832e0dac6b7
        failing since 232 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
