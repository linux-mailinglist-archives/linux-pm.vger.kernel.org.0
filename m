Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF05E2738BD
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 04:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgIVCgN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Sep 2020 22:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbgIVCgM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2020 22:36:12 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA85CC061755
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2020 19:36:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id k14so10693857pgi.9
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2020 19:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=BUNvHSYVqCgky2rfRfdbT7SwMneV3sacOOcG1QLW69A=;
        b=J7277531LNq/1W0ogtEcd0CO+6poFm/4FQc7IY4edVq1ILO3dlp4IMnLnMXgcZ15OJ
         WAKgMIf3hNkJ+08OhDLixUKxu8ChZZjsZBjVgjl+I7Et/k0KFkrLmMvhbKLr7CazaN1g
         NRYmrJIVp1uMzFICDxcoeQ/DkVu4i4HBR0FBcPq2i4v/+0o9DK048IJlERfdyXMjVSpx
         T9ax/2GkL/F8rPMuqmlSwekaunFK0yw81FvRwSaBMStWaCdILxGA4ArE3rfUbQsvWe+J
         L2AMzajy9Pztyz/5Bu94gbezA8oQ8q8fhxiATpxQTgN0g9MNgPDGfoLzuPR2+peoKBuy
         AydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=BUNvHSYVqCgky2rfRfdbT7SwMneV3sacOOcG1QLW69A=;
        b=tLULIZhV3SxMTSQHrsZ9ZBWaer+g3RLQM1yvemzufMc7wFX/KLlORj+OM3tWZKRZrn
         4U4eiuItXOgzReCpfoNAn9Lse7JAJksSnX3dtsEcyNC1QJZjqHIzXGzUKotQxqkrdub+
         agZZkGhIGlnJnwZy7R8Pw2DV6bouZyDzDwS9p/yT1wHHE/pDaIbkimJbWMALudZaveip
         tSl4QAZQKmz7IBWfVbeyyC/b+SkpOL4RJwPSHOE5b0x9rqQBQt8fvOJE/RIU5xQgX/BU
         2fV8bklFsKpTOvlqmwEkTir1loYe/Fu9AbXg842LKZZHRKE2gI34FwDa+gpHBItBaFa7
         JX5w==
X-Gm-Message-State: AOAM532brZQbrD0BloWH4563//0PV1lLeZDazB8UghcDZrYb0g2XpyHc
        eKxAAzQ+c2LKeNkgLG3x1STH+JQZdX55tw==
X-Google-Smtp-Source: ABdhPJwTOwHtT08xfcCEQyUIoNJCFg+eLOQnp7HPPN1k3l4pVUUJhV0rBxHZ6FcLMOQyjsYrXpQStQ==
X-Received: by 2002:a62:dd01:0:b029:13c:f607:5fff with SMTP id w1-20020a62dd010000b029013cf6075fffmr2268601pff.3.1600742172300;
        Mon, 21 Sep 2020 19:36:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f207sm13885961pfa.54.2020.09.21.19.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 19:36:11 -0700 (PDT)
Message-ID: <5f69631b.1c69fb81.21bc6.234e@mx.google.com>
Date:   Mon, 21 Sep 2020 19:36:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.9-rc6-23-g24a16b940f0b
Subject: pm/testing sleep: 7 runs, 2 regressions (v5.9-rc6-23-g24a16b940f0b)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 7 runs, 2 regressions (v5.9-rc6-23-g24a16b940f0b)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | results
-----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc6=
-23-g24a16b940f0b/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc6-23-g24a16b940f0b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      24a16b940f0be5f822951a86ba0db8664f6d0677 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | results
-----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f6956318228d3ba0dbf9dbc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc6-23-g24a16b=
940f0b/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc6-23-g24a16b=
940f0b/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0911.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f6956318228d3ba0dbf9dbd
      failing since 33 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)  =



platform         | arch  | lab           | compiler | defconfig | results
-----------------+-------+---------------+----------+-----------+--------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f69588e3db8782304bf9dbe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc6-23-g24a16b=
940f0b/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc6-23-g24a16b=
940f0b/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0911.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f69588e3db8782304bf9dbf
      failing since 6 days (last pass: v5.9-rc4-6-g23818c154bae, first fail=
: v5.9-rc5)  =20
