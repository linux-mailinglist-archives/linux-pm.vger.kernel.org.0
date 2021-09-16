Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0222240D2D5
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 07:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhIPFRu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 01:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbhIPFRt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Sep 2021 01:17:49 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB3EC061574
        for <linux-pm@vger.kernel.org>; Wed, 15 Sep 2021 22:16:29 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id w8so5055446pgf.5
        for <linux-pm@vger.kernel.org>; Wed, 15 Sep 2021 22:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=OOMlQvhHNpyvfDOEbMo20jIjaOaGIBtQcJODPH+iBoo=;
        b=haIlOmyd1VqwtMm38hSLBaDphjeW5n665ZfJFlT6sXtaMo6EswsQJguLe7FK7Eku4h
         2OYAaFzly+yAzWYC1dMgcsuy+JanPXLG0PVfBmgKqzgU3BinRb9BWNZz7zCYqzVIafBy
         nhFImOKcKZ96sJFo+M9syUV9WLRKflxjKPt9ZIf60LQc3239yw3yGSp+UvEsFPZXiofU
         /3bUvlxO4Xcp0t+ddqffgzS+XJhh+hxgwpcDaK1mRyNhNJ6VEMF/nctepmS2MLqDTUFw
         1bFacrxFhCYjA8XpthrjdX0s3CEFatmj5x+/xG3Jnq+OJsuqgaNkn1G6XNOKRabc+d5U
         O1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=OOMlQvhHNpyvfDOEbMo20jIjaOaGIBtQcJODPH+iBoo=;
        b=2Et7FSK8OwvXgWr3KxFK4EhYZrLTJ2roHlh1d8llcznO0q+afEkF2ETY60zUd8pXC7
         5meKoKhCNgAHxLpSJzOHX//XSIb32v3WTAcu+N4udBjaBqcHWMGbNaVQsPzwGq6Ngp38
         knXAlj0SwWykSvbBWtfkqHrf7P01CMIbJUau//fMWZg8A+/5CF8HpGw9DdxQpE5NKzIl
         P3N7BRY95URfPp6zoyKL0TUj1FTlNZIvwS0fdHTIxsSE3tV/NSenVMEPfhMND9fx1Rks
         HXJS+fhiDsbUXAGeSQbLQTYJrvhWyl0FiT6ro5eNACQUUfEbgYGx3BgeLoTSJerORDLI
         6t/A==
X-Gm-Message-State: AOAM531/Hvp7YAkmztno1tzoycKIr1l2mJ6dSqRPdfiDqm5V6qn1s5VR
        qPQSzyMaldTYb/+cce/qI1A189obPA2HjGSaXYQ=
X-Google-Smtp-Source: ABdhPJzm4qiURaHfPrGBcg7ENhPY5YCrHtrCnERUY3I3azSK6gBrTSZRkBi+BzjN4yyI3PDi4HCx5A==
X-Received: by 2002:a63:d250:: with SMTP id t16mr3270459pgi.95.1631769388585;
        Wed, 15 Sep 2021 22:16:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y2sm1225888pjl.6.2021.09.15.22.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 22:16:28 -0700 (PDT)
Message-ID: <6142d32c.1c69fb81.eb76b.5c27@mx.google.com>
Date:   Wed, 15 Sep 2021 22:16:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc1-5-g7f2d17677d02
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 4 runs, 1 regressions (v5.15-rc1-5-g7f2d17677d02)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (v5.15-rc1-5-g7f2d17677d02)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
1-5-g7f2d17677d02/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc1-5-g7f2d17677d02
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      7f2d17677d02a80230c9ef4b9b7dc986aa4c2914 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6142c628d22035fe7499a2df

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc1-5-g7f2d17=
677d02/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc1-5-g7f2d17=
677d02/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0827.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/6142c628d22035fe7499a2e0
        failing since 392 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
