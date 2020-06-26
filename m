Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA7520BA85
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 22:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgFZUsM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 16:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFZUsM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2020 16:48:12 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7709C03E979
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2020 13:48:11 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id g67so4543247pgc.8
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2020 13:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=1GeCKZxck0NP824k+iQXNkeKHaD39GQiroganjhKk1Y=;
        b=hoNYSsOEim2dad6GFXKHpDI4e2CaTPhQK/WcEsIe+8wCr7wZVY22vIt2m423KtfGtq
         vgWZ5DEJztvX7NKnisZlQuJDGLRLtXYtmzBQa0c8i4z497UIHIoMkDUioPChllVqz8A0
         lonpBUcmSPFvjezw1ZI1+mXmvOENlRNEqndBzhoSP2paAOyAFtBFiX4TfjJ3ZnPsTs0q
         bX9V9m2JVFZfHi5jJJwefLAJaCa8Z5pCWVpg8l7XAVa3wPp02TGrrNKb7TIlzZ25B8GR
         WjQ/1BsRyNOrMWYEfQ/8W0oJb8OorYzK7JPoOpQ+lrCmIfVWfjVd2Ji5rFrw3PaR3O1y
         DdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=1GeCKZxck0NP824k+iQXNkeKHaD39GQiroganjhKk1Y=;
        b=OQcGObZ/CflMHfm5wPadkeCQ7RpLALNgjkvgR2Dsx5BCrcPZQVGq0GclXVpL/AK6BI
         IsjlQ0V8JeLJ2Wg/Uift16tQMtSmFfX8+2oLZXUnSLisO79BuLMpXa4/PnTGwimszTLi
         vnite5Wkb3Bv4VJog0QCpDOEgb4RREkuKQxY/OWzv+s7iavrbBHkhwdMVutgKyRpxaT+
         KGBk7JI0bdtgmais+QMzQ/FGvQ2XfOwiXzok9bM3N+oI7FZtnaXf/IKxXDV3AOQrnjn6
         f71diVanXQfNTx+q+kAIvP3Gaik46xvhbXEEtWtnVdqktr8e/+QASH2fPVUVTvIc3ZQl
         ofiA==
X-Gm-Message-State: AOAM532BjMmgrrw2pZao4R/IJUSf60KI48u4ZTk7D+g4nHfjWVR80GPO
        NibcMFq+f2AzaDJe6upk6g1sk98/IjA=
X-Google-Smtp-Source: ABdhPJz1sTbkav+Lj7jmnZsC2RHpIy3y/lsGpFBrtyYDEuqzbD2nWKyb3j8NTlRSy8YS3qC4o/5cEw==
X-Received: by 2002:a63:f541:: with SMTP id e1mr471737pgk.375.1593204491200;
        Fri, 26 Jun 2020 13:48:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v14sm483518pjd.48.2020.06.26.13.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 13:48:10 -0700 (PDT)
Message-ID: <5ef65f0a.1c69fb81.a047b.1804@mx.google.com>
Date:   Fri, 26 Jun 2020 13:48:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc2-27-g3168a010c528
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 69 runs,
 1 regressions (v5.8-rc2-27-g3168a010c528)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 69 runs, 1 regressions (v5.8-rc2-27-g3168a010c528)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| results
-----------------------------+-------+--------------+----------+-----------=
+--------
meson-gxl-s805x-libretech-ac | arm64 | lab-baylibre | gcc-8    | defconfig =
| 4/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.8-rc2=
-27-g3168a010c528/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.8-rc2-27-g3168a010c528
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      3168a010c528831387512bed536416d87a9e8a18 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| results
-----------------------------+-------+--------------+----------+-----------=
+--------
meson-gxl-s805x-libretech-ac | arm64 | lab-baylibre | gcc-8    | defconfig =
| 4/5    =


  Details:     https://kernelci.org/test/plan/id/5ef6555cef8c4bc3b785bb18

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-rc2-27-g3168a0=
10c528/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s805x-libretec=
h-ac.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-rc2-27-g3168a0=
10c528/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s805x-libretec=
h-ac.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/5ef6555cef8c4bc=
3b785bb1d
      new failure (last pass: v5.8-rc2-24-gdcc4e8ba3539)
      2 lines =20
