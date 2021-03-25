Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A442E34859A
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 01:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhCYAFo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Mar 2021 20:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhCYAF3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Mar 2021 20:05:29 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DB9C06174A
        for <linux-pm@vger.kernel.org>; Wed, 24 Mar 2021 17:05:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t18so294555pjs.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Mar 2021 17:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=3FiqF6ifcAZ7/edEbelffUyt2QHAhJziPYtEH+oKLPA=;
        b=G5wVu2r5cBxUC509HB885sAgbCWTnCUmnUDJmHL6sW0iMdItMOEa+MiqgsBtCnafdC
         aJNk1KIEFpbnnMDXp4rIqd1AVcbHIDqnFwK2Xtky6v4cWuCzwVkMnXXfC6BaiOyHfeO4
         7P35JqXhzIvomkQ5951wWnzbCJN5Y8GbiHVrtjuObTanIX6IX7kwor+wCji16JB+pi0T
         HVQQvUx7rN2SohEP9c19VPcuYnWYcyUBbXMNwDQBeCUNNzhsYvYiME2KXGEXqqEH7tGg
         /jdOSCGBm48EndGOJfslKWuxUOP5asgtZSJ++M/pP2mTfjbhVxxzi/Zy38dZi4c9n5jr
         Y29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=3FiqF6ifcAZ7/edEbelffUyt2QHAhJziPYtEH+oKLPA=;
        b=NEaB3YqOD1f9qt/UO0fA52Waka7dLsFLXddEQCjGBflRyFIYcsVAo2kOCMF55K52Vt
         RRqoiLSv2U7ITRmKBHucaRISW7YkUI1e5Hf56VEFGqGkjWrOrpVaFimMWxELTQArLLRX
         5+KchNqcZXzOshjJN9LH+pRqo+N2LYdszRw/RfpmPB7pHV4iLF2anzCgc8cgbK7lisnr
         vEAKZY2olWTYu0i7POJCOcvbZJSNQN9w509xxIh4c4sw+H9by8IfRyKW53HvQ/jONSSs
         oRGj00lWhh4rHAufnMU67Uaitk6kEgO+/q/j4EPYvimdl1sdgdIpZJMnCNHjEIKTe8zP
         c+IA==
X-Gm-Message-State: AOAM533AYsPNR07NmYgYqfVimr1NLbqAgNIyQQlnbAgDk/0c83vzoen1
        vcl/NK0XbNJLd4Gm0Md81R8RuA==
X-Google-Smtp-Source: ABdhPJxOWIR1rkgJCRDzKX2nxx/TckVZxuEseKUzHTLHJAb6dD9dCjNAFOhwBgBl0pkNwszLHLwChw==
X-Received: by 2002:a17:90a:4104:: with SMTP id u4mr5755538pjf.81.1616630729160;
        Wed, 24 Mar 2021 17:05:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k127sm3580860pfd.63.2021.03.24.17.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 17:05:28 -0700 (PDT)
Message-ID: <605bd3c8.1c69fb81.c9daa.9bc3@mx.google.com>
Date:   Wed, 24 Mar 2021 17:05:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.12-rc4-45-g972d86381b186
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 107 runs,
 3 regressions (v5.12-rc4-45-g972d86381b186)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 107 runs, 3 regressions (v5.12-rc4-45-g972d86381b186)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =

r8a774c0-ek874           | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
4-45-g972d86381b186/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc4-45-g972d86381b186
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      972d86381b186fde03c69fb4cc0ca70f5255baa7 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/605bca2c8b1917d962af02bc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc4-45-g972d8=
6381b186/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc4-45-g972d8=
6381b186/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/605bca2c8b1917d962af0=
2bd
        failing since 4 days (last pass: v5.11-168-gd10b8fa0d6dfd, first fa=
il: v5.12-rc3-29-g4bcad1ff6cfa) =

 =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/605bca54497d048eeeaf02d2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc4-45-g972d8=
6381b186/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc4-45-g972d8=
6381b186/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/605bca54497d048eeeaf0=
2d3
        failing since 4 days (last pass: v5.11-168-gd10b8fa0d6dfd, first fa=
il: v5.12-rc3-29-g4bcad1ff6cfa) =

 =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774c0-ek874           | arm64 | lab-cip | gcc-8    | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/605bca54497d048eeeaf02d5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc4-45-g972d8=
6381b186/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc4-45-g972d8=
6381b186/arm64/defconfig/gcc-8/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/605bca54497d048eeeaf0=
2d6
        failing since 4 days (last pass: v5.11-168-gd10b8fa0d6dfd, first fa=
il: v5.12-rc3-29-g4bcad1ff6cfa) =

 =20
