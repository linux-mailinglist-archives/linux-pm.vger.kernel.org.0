Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAF3345560
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 03:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhCWCMJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 22:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhCWCLz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 22:11:55 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6361DC061574
        for <linux-pm@vger.kernel.org>; Mon, 22 Mar 2021 19:11:55 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x26so12660235pfn.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Mar 2021 19:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Qzfbpb9ihKzHBsRgdIBfu9iA4FadgQq3Jnd6KbPO19c=;
        b=CAkASLdFPozLi2GCU1Otz6tlFXQCkAI4A6q6+O0JHm+AwtSP1FVzFor9O9bLrTrYRt
         NYw4jWmdOGLILTBMhIybhQCg66rf9qW2TeKI8ejU0reV4WmQH/DCSposi93Jv5JNiLTx
         DZy7tvc4I2sHJUPm3vIKlb0MknaCfUTfj+a6ACX02HaLAr4+5KeTKE+oxrFraI5DlwWv
         1S4crWdFaKhAIsmt1COT4ssUCDp828dxn6cgp+I2/6tlbcrUCs/AnCWGblkxjFAOu/U9
         Q6mfQnQso+Mmum93UmDPNXJMnX0Y+9yd4j88Ad3QGKReF+eBWKfzuRu1lZf7eE7Qa68Y
         GpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Qzfbpb9ihKzHBsRgdIBfu9iA4FadgQq3Jnd6KbPO19c=;
        b=CPZOQ0RLWa8+85xe6d4RSagw7wZh0kmzdVGmrlSA1HaKE/WTQjVJQp7ssxbB9mhLPD
         H06TdSK6ihkE8G33X1T9yD8stonAOL3K1yr6yJc223KRYVEJbzSaYspWO7usBdIrJEW3
         Ej3XJxrgzQ7+CtSsZpdW6+ewmAgzwfnJZ8MX45CiMMm00PHZusqtRZVN0O02tOdY0T8l
         QY1il57tgVDhDkCymday4f+Q+EQg4roSOrSOP/s3l/uhUmMG+SQUBR7W59NugNZvWcCK
         698us6TjHg9U9f9KgFtxboPNGpeWCBdry0OtXjwk/jyHSVS48CuY9J2KC5PPwGlTvmCf
         pm8Q==
X-Gm-Message-State: AOAM532qyszQ1gf0uIvRBtmTWUCxaaR4ILnvorgHfQcBAX/S+tQ7GOXs
        baJX4ZUvZU3Llr9jDcsVYwXhVg==
X-Google-Smtp-Source: ABdhPJwdIFmLhbSrBnn3RF/2ulaxSgXYibd7SrgOMhqa2QZigyd8QDe2qX1SLFHGzQerghp6SIXXUA==
X-Received: by 2002:aa7:808b:0:b029:1ce:8a32:f5e8 with SMTP id v11-20020aa7808b0000b02901ce8a32f5e8mr2530168pff.34.1616465514991;
        Mon, 22 Mar 2021 19:11:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i7sm12990936pgq.16.2021.03.22.19.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 19:11:54 -0700 (PDT)
Message-ID: <60594e6a.1c69fb81.7f235.0cdd@mx.google.com>
Date:   Mon, 22 Mar 2021 19:11:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc4-38-g0fc4b6feae23
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 70 runs,
 4 regressions (v5.12-rc4-38-g0fc4b6feae23)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 70 runs, 4 regressions (v5.12-rc4-38-g0fc4b6feae23)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
imx8mp-evk               | arm64 | lab-nxp | gcc-8    | defconfig | 1      =
    =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =

r8a774c0-ek874           | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
4-38-g0fc4b6feae23/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc4-38-g0fc4b6feae23
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      0fc4b6feae239ecf9e355838c15521f9896dda22 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
imx8mp-evk               | arm64 | lab-nxp | gcc-8    | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/60594023e03929f952addcc0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc4-38-g0fc4b=
6feae23/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc4-38-g0fc4b=
6feae23/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60594023e03929f952add=
cc1
        new failure (last pass: v5.12-rc3-29-g4bcad1ff6cfa) =

 =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/60593f74d2b93174a3addd12

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc4-38-g0fc4b=
6feae23/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc4-38-g0fc4b=
6feae23/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60593f74d2b93174a3add=
d13
        failing since 2 days (last pass: v5.11-168-gd10b8fa0d6dfd, first fa=
il: v5.12-rc3-29-g4bcad1ff6cfa) =

 =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/60593f75b7f9a25693addcbf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc4-38-g0fc4b=
6feae23/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc4-38-g0fc4b=
6feae23/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60593f75b7f9a25693add=
cc0
        failing since 2 days (last pass: v5.11-168-gd10b8fa0d6dfd, first fa=
il: v5.12-rc3-29-g4bcad1ff6cfa) =

 =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774c0-ek874           | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/60593f73b7f9a25693addcba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc4-38-g0fc4b=
6feae23/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc4-38-g0fc4b=
6feae23/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60593f73b7f9a25693add=
cbb
        failing since 2 days (last pass: v5.11-168-gd10b8fa0d6dfd, first fa=
il: v5.12-rc3-29-g4bcad1ff6cfa) =

 =20
