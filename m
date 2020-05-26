Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994DC1E2366
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 15:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgEZNwT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 09:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgEZNwT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 09:52:19 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F2DC03E96D
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2020 06:52:19 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id i17so209001pli.13
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2020 06:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=mVghy4myKTrVo55JKqW8ZpudABx2DALNUmTkceqYsrs=;
        b=CZsfiyOOdtWNwF58Ja/US/YbRUgbzLGDAtw95IqGFnka0WDx5Ium5Xkl4W8UPfDFIx
         Iv0Fbqs40t/UME8In1mL9jfYUewnrAAnkz20JKap8Ec9OR+vIlE2xcq/1dqMtczi4ZMB
         QyhYAPsG9MCRX4BEh/CR3DtZjEp8LFBXh0cm3egrUBPH8uLAiTFZeQm2KW5rkDJTV0H3
         gJ/ZzDuenBQtV8y+gWsytmy3rsz0Adpjr8GHosIwmV+gQMDRRCtLCGklCbIn0qtG4Drb
         lVB4gp+QzYhR6HFYATeY0CNdl306VpOjZx+3siqEfbVaOJ7zmwjja2GkMVjvO1d4LEUu
         zY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=mVghy4myKTrVo55JKqW8ZpudABx2DALNUmTkceqYsrs=;
        b=Zt3OmSlzpBJvdS2EWPmS34Disaf6/JHxvWtX+hvp8G7l1hwrcuPn1NgJzOQz+hXX49
         gG6HJLz+I86JF8dHEWRpRNUglxe8aQWSTUX7Pm8EZz1BFKlg+mxIC7AxITCAD/p+dNiR
         hK0N63hOFP1QNikSEsldlVo3NVtMIfAfGHlNX3USmR6YeLU4m0sJXoFrgyeJQnapWtQT
         978eFu6a+a86f9P6Z0ZNDarBFAUVp4Uo+VLv71e1DkYJIteOvk7ChGLCx3K2KDp6kZmN
         EHaX8mUJIRBRNXsAaOv4LbaOZ4v1UTQIsxhLt6QUTx0z34ovSxKJuAT+1A8qR/BmjeqM
         dKJw==
X-Gm-Message-State: AOAM530ZdZmxn8lArOryNTD1d2lZMM9SLQqShoKV6+xrPPWaKEQhKvzl
        Yoxf/NNUvS2026CZgFpoiwyrJQ==
X-Google-Smtp-Source: ABdhPJz1k7S1e2bD+uBd9AlzxUUZxZIHJdmlVQbcf7LFkCxbWUx+rmYHvevs6/XB/0q+v6FMqM1/Xw==
X-Received: by 2002:a17:902:6b07:: with SMTP id o7mr1177980plk.74.1590501138668;
        Tue, 26 May 2020 06:52:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i66sm15080510pfe.135.2020.05.26.06.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 06:52:17 -0700 (PDT)
Message-ID: <5ecd1f11.1c69fb81.2afa2.ca85@mx.google.com>
Date:   Tue, 26 May 2020 06:52:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc7-85-g813946019dfd
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 56 runs,
 1 regressions (v5.7-rc7-85-g813946019dfd)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 56 runs, 1 regressions (v5.7-rc7-85-g813946019dfd)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | results
----------------+-------+--------------+----------+-----------+--------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 4/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.7-rc7=
-85-g813946019dfd/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.7-rc7-85-g813946019dfd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      813946019dfd8929048c3350d3d320f34ebcb01c =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | results
----------------+-------+--------------+----------+-----------+--------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5ecd1543eb868c348b4397d5

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.7-rc7-85-g813946=
019dfd/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.7-rc7-85-g813946=
019dfd/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5ecd1543eb868c34=
8b4397d8
      failing since 10 days (last pass: v5.7-rc5-53-gfbe093dd16f4, first fa=
il: v5.7-rc5-57-g8ef6544598d6)
      2 lines =20
