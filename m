Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08732AE684
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 03:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbgKKCqf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 21:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgKKCqf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 21:46:35 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614B6C0613D1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 18:46:35 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id f21so211780plr.5
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 18:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=fzOR4VLWzJLL++xxRnTOCad6IwZ4a0+V+DbuBKKhnTY=;
        b=KEU+IzwyGVknX2msD8ZrK26KEmXz/9H72z1Ygj8TQkIXKJnTAQybKNFwI1NsHNI7Jq
         XN03asGPhZF+z7TdxK4qMmdeibzxn6sSG/rhsBONC68OMGnUiA8iyhj7K1VKjx/072zd
         yyGZDre6luYqex1ayK0gQAjXO5Ksd3k8ZDEyOjAwY9uiLRROLVSZQtm+5j9x6z4EsVxS
         oTnWjyGpfAqLUEaOOgNypyaXU6PRNFN3blX+2k+Kdzz6VbSHL6rkt3vFLsUHMcU3Xtl6
         4VF8Fn+9EhvTgdeuOtq7Zsl6PobQLarGcXEyke7S6DapsZumUgErQTNk+gi0qbopMyJ8
         GIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=fzOR4VLWzJLL++xxRnTOCad6IwZ4a0+V+DbuBKKhnTY=;
        b=VDJrUjuremEVwZtFAyEnAjRhUajp7/7CSgistB8aML/rP2+m1T4c/L1vEFcWiz13QZ
         53mJCY8t97VROGSu10zdH43nnxY1/F3D4xU7BhbfXmuBIIIDIeZmeI+olv3jca7rXq8n
         JLfCoGzQEqvdwU+mxYI74oXHkKZiMG3xXr+l5rTIAs36p783SDxpz+sejEbDe3JHSZXV
         EghWvvum65aMZDNTFcDnbkbitksVNAYu0U0R3J2PPGM9/Lz67QQrc/DH8rNBvxxqsgj2
         MVqFETYTSJTvb59oYH27Yz7S4PC+I3ebwxNudNL1rKFYKRWP5xDX6ZBFyVS2QWV9NgSz
         CqMQ==
X-Gm-Message-State: AOAM532nMOom1BTAuE5aL9SoUiplQ07iBoRSXmeKrKYXuwDxRnGPWfRT
        o8nzpmM+ZRFm61+DUlkSIwQKQg==
X-Google-Smtp-Source: ABdhPJy4tLT8c5cv8Puc3LnBt46C0+LuuIj07faX6cHc/YWTklMgM2Rf/1U6sExBSqZ7NHpbDAwTjA==
X-Received: by 2002:a17:902:8508:b029:d8:bdcd:d83b with SMTP id bj8-20020a1709028508b02900d8bdcdd83bmr444350plb.59.1605062794784;
        Tue, 10 Nov 2020 18:46:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r127sm461232pfc.159.2020.11.10.18.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 18:46:34 -0800 (PST)
Message-ID: <5fab508a.1c69fb81.221fa.1da2@mx.google.com>
Date:   Tue, 10 Nov 2020 18:46:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.10-rc3-25-gfc4b18739b23
Subject: pm/testing baseline: 116 runs,
 1 regressions (v5.10-rc3-25-gfc4b18739b23)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 116 runs, 1 regressions (v5.10-rc3-25-gfc4b18739b23)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
3-25-gfc4b18739b23/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc3-25-gfc4b18739b23
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      fc4b18739b234869e8ee6c499ed8b69e3281a262 =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fab467eeee437ab82db8867

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc3-25-gfc4b1=
8739b23/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc3-25-gfc4b1=
8739b23/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5fab467feee437ab=
82db886a
        new failure (last pass: v5.10-rc3-14-g103ceda28388)
        2 lines

    2020-11-11 02:01:30.094000+00:00  Connected to bcm2837-rpi-3-b console =
[channel connected] (~$quit to exit)
    2020-11-11 02:01:30.094000+00:00  (user:khilman) is already connected
    2020-11-11 02:01:45.148000+00:00  =00
    2020-11-11 02:01:45.148000+00:00  =

    2020-11-11 02:01:45.148000+00:00  U-Boot 2018.11 (Dec 04 2018 - 10:54:3=
2 -0800)
    2020-11-11 02:01:45.149000+00:00  =

    2020-11-11 02:01:45.149000+00:00  DRAM:  948 MiB
    2020-11-11 02:01:45.164000+00:00  RPI 3 Model B (0xa02082)
    2020-11-11 02:01:45.251000+00:00  MMC:   mmc@7e202000: 0, sdhci@7e30000=
0: 1
    2020-11-11 02:01:45.284000+00:00  Loading Environment from FAT... *** W=
arning - bad CRC, using default environment =

    ... (383 line(s) more)  =

 =20
