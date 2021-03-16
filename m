Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F5D33D7EE
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 16:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbhCPPpu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 11:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhCPPpX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 11:45:23 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2144CC06174A
        for <linux-pm@vger.kernel.org>; Tue, 16 Mar 2021 08:45:23 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t37so12052808pga.11
        for <linux-pm@vger.kernel.org>; Tue, 16 Mar 2021 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=eoMatMbqAVNaPafPDglVHDaItFh9/Kbqlh47hq3luGY=;
        b=XlTlYO6ojdOEWAvkd/1L5qGo5aMb3XaqkVchr9UwYQGnafdeR/AZtXSFdjEYzTbIex
         RAT19D1Fk6Jn8vg5wek5sqHtyd/p1NGpROboaN741M5qvvKr9NlIX4e1lr3uHxhPtVqI
         Tp1Go1e0nWLTkShJgJfSfsIJ7p9ZwQ51EsL3xyXLFIwftekqOLhDdCbByahkLrGVDcc0
         2r27SRPs/1lDJehUpT4Nbdyx6E5fOM/0UaVvB+Gd+InfWu4nQv1XF3FaZi6Qi89RWo7E
         apYoAlRshKm8+wnH0AH7WATVAkV/h+zL9Lb0CSCGVFxS5jzHXE5dgSTCxDI3090raDoq
         j95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=eoMatMbqAVNaPafPDglVHDaItFh9/Kbqlh47hq3luGY=;
        b=IHRFsp2D+qndFrYxl2fQv8OUy3OFDZ2MpznGKFPrKYIYETjnVhzvAeUY90SEt2SDfE
         prs0YwbWtaYHPTX4t+eclWM/U83lhhiZpybrrd6fjuXLe3X1pu+QxYzOmZf+mSzFb3AW
         R9YX9zZ3cqOO+A3qiGdyF8qt2pZQnaPrjCWNynVg3M/mUcsQdHPk1817tR/tZbgMAX+a
         T+AGCTFMvq21n6xt1CmW755ZXGn6F8giY9+NYHA/l0jCrVu+uw1xfZJAfm3TesSTcNYP
         eAdlRG6Qsrfz8S8nyLGDE22wYoweQ6tbuRkx5tC8CK4tr5A6QvQ1dmE5xc2dw42R5XaV
         +tTA==
X-Gm-Message-State: AOAM532OYooisbhEmVLyXip2GEG7eZrQ15HZXlDqwtXZrdckaQnZ/DFp
        uxOGCJddZlKdIcUtKlOfliXVwTrUsfnOKw==
X-Google-Smtp-Source: ABdhPJziQhymW6q9yP+pkL6vkpoBuNEOjNxGvN7RLFHL403dFrec6s4y+pmeDj/myJM+zCbebyMOtg==
X-Received: by 2002:a05:6a00:856:b029:208:f11c:231f with SMTP id q22-20020a056a000856b0290208f11c231fmr239826pfk.25.1615909522638;
        Tue, 16 Mar 2021 08:45:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i17sm18700207pfq.135.2021.03.16.08.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:45:22 -0700 (PDT)
Message-ID: <6050d292.1c69fb81.982cf.d1f2@mx.google.com>
Date:   Tue, 16 Mar 2021 08:45:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc3-19-g1a7a93e88ae21
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 66 runs,
 1 regressions (v5.12-rc3-19-g1a7a93e88ae21)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 66 runs, 1 regressions (v5.12-rc3-19-g1a7a93e88ae21)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
3-19-g1a7a93e88ae21/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc3-19-g1a7a93e88ae21
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1a7a93e88ae21b39d09117d5a0dde26db783ff92 =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6050c9da74742e5e11addcbd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc3-19-g1a7a9=
3e88ae21/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc3-19-g1a7a9=
3e88ae21/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6050c9da74742e5e11add=
cbe
        new failure (last pass: devprop-5.12-rc3-29-g42326a293954f) =

 =20
