Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF38632C2DB
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 01:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhCDAAN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Mar 2021 19:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579674AbhCCSbu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Mar 2021 13:31:50 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905CAC061760
        for <linux-pm@vger.kernel.org>; Wed,  3 Mar 2021 10:31:09 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id z7so14512335plk.7
        for <linux-pm@vger.kernel.org>; Wed, 03 Mar 2021 10:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=iy1L/5eJG9qtH0tddKxsUXdX4+LADViJrjw3YU7Le98=;
        b=f3sI/LW3UizyZqe/yATKVmovbfIF/6CxuJp7Uu6lYltNBASks3PV4MdQHf6agoXuj0
         y/2tMLCnu3hyXbgd95fQvP5nvvNA8d8OiAeUIbVM3Z2+UColeQmWDeLTsnsaKlh3cn5n
         fE1dmwnea0VprLPYKH/jp0SBHHKVqM3X9fL3CVp0GVJs9cY/jb+memF+QDOvvv9+2Dt1
         wKV9RES6+oPmwLaLNrOXekiwDD+3YPDNn/bf+RMyJVO0jjDGDjNlMhmZLYbiAdKH5CEy
         OZs7z1QwtFR57uBHbALD/PSCt9vOxaEzxDYwkvb5deJBielOxuy45Z6OWSW5BQBDz8Sg
         WXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=iy1L/5eJG9qtH0tddKxsUXdX4+LADViJrjw3YU7Le98=;
        b=Zl8vvtS+toaAFN1GltZguhWoO/gTapATXzjbfAPjGOT/xgLU7ZD4SbnqBseFPwKTFW
         7qZDp2DB1YW5ndFIuKUVRfsCy5s2A+8PGYOCiqQesom24kf4AbUgoAMJig2DyrDEWhBj
         gQtq8zkt4HZC0bIhHr8alq4CO5CsjZs4dlyDhzwmJJK+6/JtbqC/t8grSxrJEqxGHXlV
         K43bWNa9iBKwxqwl75JIP32dlIZUtR/1lueuBAogKLYco9hZ1xV96HaLW9w3SIQ6bXF/
         wogQdZj15bnN2X7iZLqeOHkKiAd9cgEF24uX1YYR3+fa2nkndHvJxfAP6kQVGCMvLspZ
         ooOw==
X-Gm-Message-State: AOAM5316RfL90rIssbTzB4F3TGEFEmO0gOjPq/rU84emODIwOxX/AEmb
        twugdeeIoWbPlopgo0hJmzYEtQ==
X-Google-Smtp-Source: ABdhPJyfVNkW9EBcc87yWD1Yu8QQ1y0hCusYEalIz9FqeL43vF3xv0q8qDoOCm0CkBEP2HJ58DPdIw==
X-Received: by 2002:a17:902:9795:b029:e4:888f:7390 with SMTP id q21-20020a1709029795b02900e4888f7390mr499297plp.26.1614796269087;
        Wed, 03 Mar 2021 10:31:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r4sm7466940pjl.15.2021.03.03.10.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 10:31:08 -0800 (PST)
Message-ID: <603fd5ec.1c69fb81.d48b4.04ba@mx.google.com>
Date:   Wed, 03 Mar 2021 10:31:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc1-5-g51165d52eceb9
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 49 runs,
 1 regressions (v5.12-rc1-5-g51165d52eceb9)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 49 runs, 1 regressions (v5.12-rc1-5-g51165d52eceb9)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
1-5-g51165d52eceb9/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc1-5-g51165d52eceb9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      51165d52eceb9a6a227e39c9b369b4f437e4e620 =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/603fcc30820ab15128addd07

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc1-5-g51165d=
52eceb9/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc1-5-g51165d=
52eceb9/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/603fcc30820ab15128add=
d08
        failing since 11 days (last pass: pm-5.11-rc8-201-g8b72d3aa065c, fi=
rst fail: pm-5.11-rc8-205-g4475f0291af9) =

 =20
