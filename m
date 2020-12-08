Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008E42D33BB
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 21:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgLHUY2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 15:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgLHUY1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 15:24:27 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBC1C06179C
        for <linux-pm@vger.kernel.org>; Tue,  8 Dec 2020 12:23:41 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id v29so109794pgk.12
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2020 12:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=jlKNfCJ5wtw6PhwJmq7JYl5WY/+ZkN5WRMR1UTTUqD8=;
        b=R6OdE0EbCppenuCPrnCjc/xtxfu/oDnTjNmF0NyOAJjH72hVCZBat5CSVIc0Sb3y57
         Q1zO8PQpxzS7NIfT5DtZ24OvJ9TI13TTLAthhLqgRjibgdvOXaqVwNKn6kxvQHAMwqOz
         vcOlZNHiB/SUnaClqG6ogLJOWQ8VQTwvXI/VifLZeekbZLgJ+31VhOG6qwa2MMXr8aqK
         gqfe4jQroScwJOFYYhQ3D5+opledZPuMuF2QK6xvEDgUda0rRJ7F1jkwW62+Voov44vi
         0OPwtVm7wMEVyD86J3TGObX53wqTuXEotOmIqGWrB2xRZpV/VrU9lQuUl1nHs4ZILBeN
         EPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=jlKNfCJ5wtw6PhwJmq7JYl5WY/+ZkN5WRMR1UTTUqD8=;
        b=tz3nwMm7VgsKVj1lCn5JBAL5w1egNjaydHI+GBmVInXRvzwusNEhuvZl5ISz6upttr
         06qfQ1jdKpZALYp7qxSO4s6oTpSkm5dnGSnMlJGZBpeWv+t2d4lZGb4cnlqE8MXnBCdP
         8j7/dIyeCkcPo7kJIpUs8MEZZCy7vNPzSLTK4H84Vu/1HLrpLjniUwYIu9h0LAaeQstA
         9ToJz8LpnvXTRA947ETzc20U7WupMVUKI7PxSUaueUG/qkg4/hrVz3h6/BibVt+k/k5z
         zg07J8U0DZjNHP0MCeA6gjoauGJBAuC3cYsM4wgLfb23YnGlwqxxvb83OFsWae6SbNZH
         8aqw==
X-Gm-Message-State: AOAM533MlsrBdkeYFtAyVp896qUBI7UB3/mxw+GaD6wR7t1tfboZfEld
        xmtj++8pP/bhozoOJyq8cWUxuA==
X-Google-Smtp-Source: ABdhPJzOASpRvV8XZxpZKTK9Kz7C8PcebKuhfcfZU6/CcO3v/lrPLjSc64eMpb0ha4dTrVfpc+CguA==
X-Received: by 2002:a63:f308:: with SMTP id l8mr24487830pgh.68.1607459021184;
        Tue, 08 Dec 2020 12:23:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n5sm16796980pgm.29.2020.12.08.12.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 12:23:40 -0800 (PST)
Message-ID: <5fcfe0cc.1c69fb81.c6f23.5860@mx.google.com>
Date:   Tue, 08 Dec 2020 12:23:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc7-92-g717f8fce803b
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 97 runs,
 1 regressions (v5.10-rc7-92-g717f8fce803b)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 97 runs, 1 regressions (v5.10-rc7-92-g717f8fce803b)

Regressions Summary
-------------------

platform    | arch   | lab          | compiler | defconfig        | regress=
ions
------------+--------+--------------+----------+------------------+--------=
----
qemu_x86_64 | x86_64 | lab-baylibre | gcc-8    | x86_64_defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
7-92-g717f8fce803b/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc7-92-g717f8fce803b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      717f8fce803b9501e192fef85d508e3d592f1c16 =



Test Regressions
---------------- =



platform    | arch   | lab          | compiler | defconfig        | regress=
ions
------------+--------+--------------+----------+------------------+--------=
----
qemu_x86_64 | x86_64 | lab-baylibre | gcc-8    | x86_64_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/5fcfd42ece898bb2a2c94ce7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-8 (gcc (Debian 8.3.0-6) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc7-92-g717f8=
fce803b/x86_64/x86_64_defconfig/gcc-8/lab-baylibre/baseline-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc7-92-g717f8=
fce803b/x86_64/x86_64_defconfig/gcc-8/lab-baylibre/baseline-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/x86/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fcfd42ece898bb2a2c94=
ce8
        new failure (last pass: v5.10-rc7-87-g960e625edeb5) =

 =20
