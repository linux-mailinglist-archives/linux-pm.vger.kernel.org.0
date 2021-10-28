Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7935F43D80E
	for <lists+linux-pm@lfdr.de>; Thu, 28 Oct 2021 02:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhJ1AZU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 20:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ1AZT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Oct 2021 20:25:19 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D02C061570
        for <linux-pm@vger.kernel.org>; Wed, 27 Oct 2021 17:22:53 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 127so4322790pfu.1
        for <linux-pm@vger.kernel.org>; Wed, 27 Oct 2021 17:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=5QjJWOrboaweUTKWd+ZhBgEdyk0L409tKmcQcU3HKWQ=;
        b=ThW6622/AVDGRdKMdtQh/ZJ8bNscUV3DciLt2GdQitF28SFakinFJVDTx/Vg+mM9hD
         7Kd/XD2xosEg/qrk8DpEmLhW7dLS9hbgms1/5PgWIH24zU9RbhrZXK06iU8aXxf0g8u9
         +RatXkhVqg+y1VWnEfrO5IJsVY07cWQxFJGR1gFULGV/JlX2LpADSZmfRvuWEhYFWw2d
         u8uKzkGVT5v2pgyv0FD3sMDdRpSJT5PwrV3h9DbR49SzyxXkOhPuWbV3xkqt1Ukz/1R1
         /EdMV4Pajfd62mjjTyu24oV9r0gXxk0rDtEJyMq3l1SwtkCuuL/EHwa38CDyHjdijvl4
         wv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=5QjJWOrboaweUTKWd+ZhBgEdyk0L409tKmcQcU3HKWQ=;
        b=q4RmU529fNN2REfrakSUIPmSzUXV1sBbJzHxyiWZIV6YiBWL2gcEOho1X8GG11Z0+L
         DebdJ8Pa4WK4iFrhbk6gM4YqTLVy2b8VC+Dq4hAp1G89ZWzRbxBXsZF0wO2qekUXfvh1
         sF+qZ15ABMt1Hho6PuADTEInWF6gBlwyCL7x007brzG3XAZHZ1nrW/CfJdCNS3ZL9XfE
         zEgJBOHiVP5mLhXbUNVQxllree76rA126OXhdpQTgVwTnPsocGBWp5LnL5q5NCuNoGr4
         upfytkZNI5ZXn5fPqxjPBPiZsJUXXJKTw8RBrCzBzQ5kDB7pB8e1pNTzFOcUwXQcTRz2
         2aGw==
X-Gm-Message-State: AOAM531Rn7ze0xJJ69ebAJnZdfwnWo0MDt0EeLsibBINSLOBMCeEgp9p
        HaG7CMYtKq3Zs+5p1VNnvUI/6A==
X-Google-Smtp-Source: ABdhPJwxrFY3/vYAFkBJ24CwdDQu3/TCKXIZHkq6QOYzR8z+i1yPD6hshk30Fl7CSv7EgiT7WOHhPQ==
X-Received: by 2002:a63:bf41:: with SMTP id i1mr757994pgo.412.1635380573316;
        Wed, 27 Oct 2021 17:22:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b8sm1053229pfi.103.2021.10.27.17.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 17:22:53 -0700 (PDT)
Message-ID: <6179ed5d.1c69fb81.9c618.4c0b@mx.google.com>
Date:   Wed, 27 Oct 2021 17:22:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.15-rc7-108-gba9410801460
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 48 runs,
 2 regressions (v5.15-rc7-108-gba9410801460)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 48 runs, 2 regressions (v5.15-rc7-108-gba9410801460)

Regressions Summary
-------------------

platform           | arch  | lab          | compiler | defconfig | regressi=
ons
-------------------+-------+--------------+----------+-----------+---------=
---
kontron-pitx-imx8m | arm64 | lab-kontron  | gcc-10   | defconfig | 1       =
   =

rk3328-rock64      | arm64 | lab-baylibre | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
7-108-gba9410801460/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc7-108-gba9410801460
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      ba9410801460466c3d47801e2df1052da9f36132 =



Test Regressions
---------------- =



platform           | arch  | lab          | compiler | defconfig | regressi=
ons
-------------------+-------+--------------+----------+-----------+---------=
---
kontron-pitx-imx8m | arm64 | lab-kontron  | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/6179e4c1ef07d7ef3a33590a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc7-108-gba94=
10801460/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc7-108-gba94=
10801460/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6179e4c1ef07d7ef3a335=
90b
        new failure (last pass: v5.15-rc7-95-g5ae5ac40021d) =

 =



platform           | arch  | lab          | compiler | defconfig | regressi=
ons
-------------------+-------+--------------+----------+-----------+---------=
---
rk3328-rock64      | arm64 | lab-baylibre | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/6179e2ebc73ca33284335912

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc7-108-gba94=
10801460/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc7-108-gba94=
10801460/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6179e2ebc73ca33284335=
913
        failing since 1 day (last pass: v5.15-rc6-80-g30c7771b41dc, first f=
ail: v5.15-rc7-95-g5ae5ac40021d) =

 =20
