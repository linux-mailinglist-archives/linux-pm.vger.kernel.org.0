Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E12E31A36D
	for <lists+linux-pm@lfdr.de>; Fri, 12 Feb 2021 18:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhBLRTN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Feb 2021 12:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhBLRTM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2021 12:19:12 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD02EC061756
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2021 09:18:31 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id fa16so12801pjb.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2021 09:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=WQHwWjwvnQwsSBvu5N8tfLICJsYyWAXO9aN92QHdCZQ=;
        b=iC+14ULlWPIxXGr9Askag9D3Xsa1x6Hp6woQrVwGMYWQZqkOBZNkd5eU7GRxfHTRfC
         mYIaR76e90N6GgjPT0zFtkE4mKgf5IOD/432SqBlSLPmWC2yvoNKLjCOx67byjI3OKBa
         v9aq5gMyqZSXlc0tbCnwgB1bGL6Loxnaa/Llskbv/7Ga0Ejw53oyYIi/ctyOnH5Wp9Sm
         W9adKEtAqZkpf6Q7LvasEv+LgxTfDKnFyHsDCdZbDkg9ddE7ULuC7AzesZxSn78XXEfl
         NRjGb2YB7F9SMVmI57vvMVjLaXh87sDcPdu2XCewi1bnjOX6EmcG4bR7xUDpzMNPPl+W
         7ITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=WQHwWjwvnQwsSBvu5N8tfLICJsYyWAXO9aN92QHdCZQ=;
        b=Fy3FxTzpZD+y6ArceqtXmGx7jhYaZCtqUEuAnwrLNOmzWbC+3HgSJYhKDEsMHb2ikP
         IlTSfvdnMg1JBg6cSyQ4MlGKTODG6n5h1MLFt94oMfUPvrQqT93adCME+wlalsweM/dv
         O67P01QK0fvbrw0Ut7QbIlysnfjg1/gCYS6ej9WLioJBnWkWZxJi3w2PxEUZOu9LDZg3
         C1wHDI9A/Uh04VMk+ym+WlK5QO5DMOaeiVUyDEVy6hdP7cfpTL08+6RfLi2lGmEZDfHO
         9p8ZmPOkC63AG5XWdcChr1bTK+62F/V4xRnw5dbSfpTL5SI/lUre7fzWrNm0geaATUcC
         vsfQ==
X-Gm-Message-State: AOAM5334lnL7bEIdGCU0Qg9Zr3oS/UIURjJRoQ07dhnGbicGzk1qjkCO
        YKvH5mCgrf6yQVb7L2h2AQhlqg==
X-Google-Smtp-Source: ABdhPJyEr76uNo4UzwCn8b9onuPf21Yp4I7DiYpg3Wxxo5wf7ik8H0wFi4j8JBrNhxekL1PlvejkCw==
X-Received: by 2002:a17:903:2292:b029:e2:d7f7:1390 with SMTP id b18-20020a1709032292b02900e2d7f71390mr3707458plh.21.1613150310850;
        Fri, 12 Feb 2021 09:18:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o11sm7858343pjo.43.2021.02.12.09.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 09:18:30 -0800 (PST)
Message-ID: <6026b866.1c69fb81.bbd34.013b@mx.google.com>
Date:   Fri, 12 Feb 2021 09:18:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: pm-5.11-rc8-133-g5352de4c92b3a
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 54 runs,
 3 regressions (pm-5.11-rc8-133-g5352de4c92b3a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 54 runs, 3 regressions (pm-5.11-rc8-133-g5352de4c92b3a)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
hifive-unleashed-a00 | riscv | lab-baylibre | gcc-8    | defconfig | 1     =
     =

meson-g12b-odroid-n2 | arm64 | lab-baylibre | gcc-8    | defconfig | 1     =
     =

r8a77950-salvator-x  | arm64 | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-5.11-=
rc8-133-g5352de4c92b3a/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: pm-5.11-rc8-133-g5352de4c92b3a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5352de4c92b3acb86d4756be6105203619809e07 =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
hifive-unleashed-a00 | riscv | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6026a875617b42422e3abe7e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (riscv64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.11-rc8-133-g53=
52de4c92b3a/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a0=
0.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.11-rc8-133-g53=
52de4c92b3a/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a0=
0.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/riscv/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6026a875617b42422e3ab=
e7f
        failing since 77 days (last pass: pm-5.10-rc4-33-g52d108cd060d, fir=
st fail: pm-5.10-rc6-75-g735f7fba25ec) =

 =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
meson-g12b-odroid-n2 | arm64 | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6026ac0fe0e99096ea3abe73

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.11-rc8-133-g53=
52de4c92b3a/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-g12b-odroid-n=
2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.11-rc8-133-g53=
52de4c92b3a/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-g12b-odroid-n=
2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6026ac0fe0e99096ea3ab=
e74
        new failure (last pass: v5.11-rc7-105-g32890f947002) =

 =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
r8a77950-salvator-x  | arm64 | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/6026ac0de4f3dde5f83abe7d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.11-rc8-133-g53=
52de4c92b3a/arm64/defconfig/gcc-8/lab-baylibre/baseline-r8a77950-salvator-x=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.11-rc8-133-g53=
52de4c92b3a/arm64/defconfig/gcc-8/lab-baylibre/baseline-r8a77950-salvator-x=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6026ac0de4f3dde5f83ab=
e7e
        new failure (last pass: v5.11-rc7-105-g32890f947002) =

 =20
