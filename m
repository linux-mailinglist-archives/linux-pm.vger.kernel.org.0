Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6EB2CC65E
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 20:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgLBTQy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 14:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgLBTQx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 14:16:53 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93416C0613CF
        for <linux-pm@vger.kernel.org>; Wed,  2 Dec 2020 11:16:13 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id r9so1562311pjl.5
        for <linux-pm@vger.kernel.org>; Wed, 02 Dec 2020 11:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=jIdGQRubdc8BP54pJEjKFMdWCj0dGE9iNaOEiAkUcrc=;
        b=Y7YevLCBcFEniIuF4Mfj0I+IfEWNCuu2c0rNGvBO10C23OJs2LbLY+x9Q0L7NHO8Ya
         0acMtJjcmGAEPTJ+HMb2UtfLYjTZxwDwfApwBPzu+rjkYHkPvvmwyNuVG250fcN+LnG0
         6w0IEJNL79dH3qkNEmzzTDGVF6kcekg3U0NCcwg7gR1HxBa0lZs1YQ20xkXhtlXKHkcw
         rlfbW7yB/+c1JooOgWuRexmomBVt5gA8kC0sd88rAMqVF3wups9VvVnvjRjU+3dky6XC
         KNZMJGxnjZlAyJNj0LiswGgAW7IhGfAB5Hquk0n0Jm1pEJEEwpCT2FPLDcL4L2Ups9Ak
         NLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=jIdGQRubdc8BP54pJEjKFMdWCj0dGE9iNaOEiAkUcrc=;
        b=aZhy9AS4Y7YvlsD1XIrZtoevEAA1KuSvtR3VsIdbawb7qwPs/5/vmTCWp7mNQH6dhu
         vDHtLu53FeNCkK7XnZRNdBkos03s3dzZjfJQ3Lt+kukHoNoQEbYe+vQfNX1y2m/+FdFu
         JuyKeryusTGg3FU94jmwGU+KWBANquHw3MDiTXRyoYOlujpLWHQbCf2SzCBCs0zCiUMs
         WqxVWnbE4bWImaGXSCzQyfTqpW2dEi0rtnGSvJsHNvKWpy39NWZHewCS6IYGzoSzrEBU
         QopwMPk7brgbcCQm5+LL8Lj9pTJ+sXnH8Wlc8tVwut/LabgQpOVgV0fBXCPb972rY/qy
         sL3Q==
X-Gm-Message-State: AOAM533bh/neUQEv5M3ilxDXV3pa1lr3bT3x249xlqfsITsTrZIFpHUo
        bkm3P1Blphblv6hE0v8zDdP0OlUtXhsNZQ==
X-Google-Smtp-Source: ABdhPJzRItxU7r1wt8ZYszLEy+8DnV9WV1RYZg5axAQsZV6N1pCn4KeVN9A7TBAx4IWpQ4iTe6+c+g==
X-Received: by 2002:a17:90a:558f:: with SMTP id c15mr1224658pji.161.1606936573102;
        Wed, 02 Dec 2020 11:16:13 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q18sm512891pfs.150.2020.12.02.11.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:16:12 -0800 (PST)
Message-ID: <5fc7e7fc.1c69fb81.80b11.16d6@mx.google.com>
Date:   Wed, 02 Dec 2020 11:16:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc6-87-g53bf34061bc2
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 123 runs,
 1 regressions (v5.10-rc6-87-g53bf34061bc2)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 123 runs, 1 regressions (v5.10-rc6-87-g53bf34061bc2)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
6-87-g53bf34061bc2/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc6-87-g53bf34061bc2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      53bf34061bc25d8191db8c0d66104c9e7ed7f9b3 =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fc7dfc0ce7292cf49c94cc3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc6-87-g53bf3=
4061bc2/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc6-87-g53bf3=
4061bc2/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fc7dfc0ce7292cf49c94=
cc4
        failing since 1 day (last pass: pm-5.10-rc6-75-g735f7fba25ec, first=
 fail: v5.10-rc6-78-gc6c91db76539e) =

 =20
