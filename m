Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E46D29F767
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 23:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgJ2WIr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 18:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2WIr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 18:08:47 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B784C0613CF
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 15:08:47 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id o129so3548015pfb.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2020 15:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ATGVks7skqOyoH4Tam8JNzztBK8L4oXYpZa9XDf3jhM=;
        b=ZITZFzHA7zKY8RnfHqTEV4A20Ntg05J7rX9uSYk785Zt8TBrQFL5LPaLkCR8c6hTMJ
         z3GHXI7Z12CRpwaOeGaMU+muD0MaWHAKVv5RhZ0iwtErBqYuq2lpq4twIcxDbmPsQPJ7
         Rpl1olYMakgy1fJD9RdVlAw5/467Q/8HNc99qLH1WIlLaQTzuQ7xWnTX0zj4Tmjuv1kn
         bBOEb7PtWHbwfP8EwWRunXLhO9pyl1SeoF7pogZbiOOVMNjE/C2IitlQ+YbthebnuL5o
         cn69IOsNsgns1eHZ7g8z+sTswDQFNoSiXGGOEQs+4rBvDtZ2DMlRMmQaUDOEq94CbxR3
         1Mxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ATGVks7skqOyoH4Tam8JNzztBK8L4oXYpZa9XDf3jhM=;
        b=oOiT41Z8x2RxruapKP3e2gGFnAU2w97a9LRHJxFyXFO+c7DxHtiRU9eErJmUu2gWZg
         kfqm0Mh1lo6xdwz9fSSQGeZOg3SzK8CXM2vbZuH+DCEZA0Uu1TVYT1g/vlLh62CGDbhc
         uwndMq+xGF1x979cOcfAKO9qCg8xUkhAa1ftAq4g1HUmYI4TJvP0DO4Ek6Q2geqCFHHN
         NhOMr5+VqQcuqFWvItNdQARodwr4DWY61wnI64fJQ6ocNDCmLNPiKcr+0KBqQGRABntp
         ZIGFHVGDbHK0j0xMb3g8tU9HF3+Qmzr3Dg8TaAn3AHiWlrOXRbpVFKS2Zqc9h/BsGXBf
         O7Jg==
X-Gm-Message-State: AOAM531/UJkmbp/iAi4iLBKXa53OaLQQHLgeXW0ZYbmWB2XmoA/6WcyQ
        EwdgEZtOFCBLl3IrlJIld+xyeOE/gX9eNw==
X-Google-Smtp-Source: ABdhPJy5pCJ0VsRB57DeSVrUbNw/msP9jG0f6ur6Td9uljBivT/tuARthe8X6raYp6Up60ujxSZ+Mw==
X-Received: by 2002:a17:90a:d104:: with SMTP id l4mr1317059pju.194.1604009326827;
        Thu, 29 Oct 2020 15:08:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k1sm3512756pgn.66.2020.10.29.15.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 15:08:46 -0700 (PDT)
Message-ID: <5f9b3d6e.1c69fb81.b1eb9.7c1a@mx.google.com>
Date:   Thu, 29 Oct 2020 15:08:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10-rc1-24-g5e00eb5f6209
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 5 runs, 1 regressions (v5.10-rc1-24-g5e00eb5f6209)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 1 regressions (v5.10-rc1-24-g5e00eb5f6209)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
1-24-g5e00eb5f6209/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc1-24-g5e00eb5f6209
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5e00eb5f62091ac1f78776b876efe2a09a9263a2 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5f9b2de3ff4439983238101d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc1-24-g5e00e=
b5f6209/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc1-24-g5e00e=
b5f6209/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1022.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5f9b2de3ff4439983238101e
        failing since 71 days (last pass: v5.8-107-gb72b3ea38c81, first fai=
l: v5.9-rc1-4-g1f08d51cd57f) =

 =20
