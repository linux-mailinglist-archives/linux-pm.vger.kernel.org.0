Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2652E34DCCD
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 02:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhC3AFI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 20:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhC3AEu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 20:04:50 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80DCC061762
        for <linux-pm@vger.kernel.org>; Mon, 29 Mar 2021 17:04:50 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id h8so5210742plt.7
        for <linux-pm@vger.kernel.org>; Mon, 29 Mar 2021 17:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=zLNAOsEKyI3vcPaeq7jYNNjK/plcCMD1eMwnxFPTvag=;
        b=RS3aTwiU8ttvL6WqfLhfw4DqRtWG5h/roZMD11Nt/MJufksXoXNVwRmEkUttMGNpLX
         8jKrwkHZiveK31gHxHtCUuxG9zlhS1UtaCR1pwv27rhDppjnWhy4HRR9Iz+ZXpIdggn/
         DFiqaAzRaer5fjhz0WLDF7H4cWLkUpOhsIXfFuFGuKeZLvEJlQICbqNgBGlwsb4B3rzB
         fckj9QCItC7qjk8n0si5diK7S97gv8R7xtsi6QnBZ6LJVCPv78zcjF+6FvP7AAKG99nc
         3QqxiHW5lDRtBckkdEJc3o3BNliQZTu8oRa+vynLdlGlCwsqMY8t0nrw90oHvityGXw8
         5PJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=zLNAOsEKyI3vcPaeq7jYNNjK/plcCMD1eMwnxFPTvag=;
        b=ii53dadPEZV0RWvocJVJ9xnHjoFx5r3/uxb+xpxcAT75twTAaLFhKHIGBULD6QLjiz
         fB1nxdAj/4QDUlXlDyY5yi0R8zcA86mFd2qOt5zQJlt1yJreAaly2G8DRTwI9a/SWBHE
         PaK5lHEEgXzxvR4FjLe6py+xOkURFGoZElltPD5ls6jZ4h4c5y8zM+sG2sFX/Nh2entD
         S9nh2JFaHWYbUPg4cj2F0Hy6Jw3/UuX0+wVQswdgVjbZMq47epiAfqyfv77yC/l6WXDl
         F/yCq7kCAui/JxXoYV3xXKGTSApRliMF+2jpUc9/WXoFNbg3LryCAJAGDyr3jo68yRFg
         8DAA==
X-Gm-Message-State: AOAM533WUMNamHIaRpiLdaBbeAWk9ePTWaC/ct9Bd9xUKPJKZW3sifkY
        YNg1zJyyLw7Eh4YzPth3K/HNFzSAJLG7Qg==
X-Google-Smtp-Source: ABdhPJyQOq5fKFJzStZdzoxBgUZCH4s+V2beWhMRZfcPaxF5ErfKEzZKIzkBIFAPN/HkQc3C7XBiDg==
X-Received: by 2002:a17:90a:5d14:: with SMTP id s20mr1583478pji.6.1617062690081;
        Mon, 29 Mar 2021 17:04:50 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d24sm718878pjw.37.2021.03.29.17.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 17:04:49 -0700 (PDT)
Message-ID: <60626b21.1c69fb81.b179c.1eb5@mx.google.com>
Date:   Mon, 29 Mar 2021 17:04:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.12-rc5-44-g1d535f1c735a0
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 94 runs,
 1 regressions (v5.12-rc5-44-g1d535f1c735a0)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 94 runs, 1 regressions (v5.12-rc5-44-g1d535f1c735a0)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
5-44-g1d535f1c735a0/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc5-44-g1d535f1c735a0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1d535f1c735a0cbe50c8446d81760a1d07605610 =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60626305f274b75b0faf02c9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc5-44-g1d535=
f1c735a0/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc5-44-g1d535=
f1c735a0/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60626305f274b75b0faf0=
2ca
        failing since 3 days (last pass: v5.12-rc4-45-g972d86381b186, first=
 fail: v5.12-rc4-49-ga78dc08f39195) =

 =20
