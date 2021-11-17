Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B821454F36
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 22:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhKQVTp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 16:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbhKQVTm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 16:19:42 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26657C061766
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 13:16:34 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so6344055pja.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 13:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=6J+7BAzIxmsGb6IR1tzAKZD+tKV+JGKO6Y5xBUvlgDE=;
        b=8LKa1UlSlzT77fNXI0OhRLrZIeIgSdFHLo6/6oBSk15swhh6XIfSYkDbU6087D1ZFO
         xqv7FiHQvenwYI+JPoE+QVHVcilKbXRVUWIdlQKBY8jQqbjB2gSYiznX3PhsnkWjtTtZ
         Px6DYBs1V+G8U0qMVnI2YZVkvXvMOkLM1jx07KuzSlgea/o8QTVDiiN+zCbwIiMyznLR
         3igWVwBA48wdg9YEsYmzid5nURC+WpKapN4MzNnHbYljtPmUYFle3AQ+RBJz7zKeqnFH
         wCslvkOQSr3UzUHrZ0SUH+pDvuiG9B5CWEwAwRIW4aVs5g7ZI8usyKttPqgTwA9CitDJ
         Owsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=6J+7BAzIxmsGb6IR1tzAKZD+tKV+JGKO6Y5xBUvlgDE=;
        b=ISSegLef52B5y0gWNAuthk/CcFG1M4t5Uq5TnHRmC5WjlpeatMkD5ujBc56iBix3eL
         F9SuQ4ifuLZUUt59wlcTBYXVfRl/IYW66bpBg6L/SPGHuOpZi6Eyta0pi+y4Twuizgdm
         H0eq3YTXvMK3oiHkd0Ct6QHLgyMAoJXWeIr/9qN45AW97tmzAm4U2brLS5FT72oc+5gZ
         o+513EvWvV8jcAvaXVUUsttj37lPDH+A2eaaccOZun41ciqCIfytong6xtK8QVIWMSFX
         tI80jX7PoVh0RidFHaGfFWolSLK9aeitSc7b0kLERPyUtraFP/N7VeeDT6w0gZKDEATd
         EjMw==
X-Gm-Message-State: AOAM530QsLJNbDQXuB7pKOB+mh2TCDspyaw2K1xOhERAUd1rzdSxw1pZ
        erdC6CUwFawtvfoWcWnrOy7QbQ0WbeQPB0d/
X-Google-Smtp-Source: ABdhPJyT9b+3Jpad/XZJsd0c5XbtnDDW2985yEvx9zkl2nIotffl8ybjzE5t9NpTG2O61cYz9sX2IA==
X-Received: by 2002:a17:902:a40e:b0:143:ca72:be9d with SMTP id p14-20020a170902a40e00b00143ca72be9dmr26099786plq.67.1637183793767;
        Wed, 17 Nov 2021 13:16:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z4sm522636pfg.101.2021.11.17.13.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 13:16:33 -0800 (PST)
Message-ID: <61957131.1c69fb81.763d2.2c96@mx.google.com>
Date:   Wed, 17 Nov 2021 13:16:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.16-rc1-14-g3b8bfff0a7ef
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 83 runs,
 3 regressions (v5.16-rc1-14-g3b8bfff0a7ef)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 83 runs, 3 regressions (v5.16-rc1-14-g3b8bfff0a7ef)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
meson-gxbb-p200              | arm64 | lab-baylibre  | gcc-10   | defconfig=
 | 1          =

meson-gxl-s905d-p230         | arm64 | lab-baylibre  | gcc-10   | defconfig=
 | 1          =

mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
 | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.16-rc=
1-14-g3b8bfff0a7ef/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.16-rc1-14-g3b8bfff0a7ef
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      3b8bfff0a7efce0592d4260b49b79e45dfcf7e5b =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
meson-gxbb-p200              | arm64 | lab-baylibre  | gcc-10   | defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6195672005478a30b23358f6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.16-rc1-14-g3b8bf=
ff0a7ef/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.16-rc1-14-g3b8bf=
ff0a7ef/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6195672005478a30b2335=
8f7
        new failure (last pass: v5.16-rc1-12-g273b3dc3453c) =

 =



platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
meson-gxl-s905d-p230         | arm64 | lab-baylibre  | gcc-10   | defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/619568d8ec6d41068e3358ef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.16-rc1-14-g3b8bf=
ff0a7ef/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s905d-p230.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.16-rc1-14-g3b8bf=
ff0a7ef/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-gxl-s905d-p230.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/619568d8ec6d41068e335=
8f0
        new failure (last pass: v5.16-rc1-12-g273b3dc3453c) =

 =



platform                     | arch  | lab           | compiler | defconfig=
 | regressions
-----------------------------+-------+---------------+----------+----------=
-+------------
mt8183-kukui-...uniper-sku16 | arm64 | lab-collabora | gcc-10   | defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6195669bf63918113c335900

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.16-rc1-14-g3b8bf=
ff0a7ef/arm64/defconfig/gcc-10/lab-collabora/baseline-mt8183-kukui-jacuzzi-=
juniper-sku16.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.16-rc1-14-g3b8bf=
ff0a7ef/arm64/defconfig/gcc-10/lab-collabora/baseline-mt8183-kukui-jacuzzi-=
juniper-sku16.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6195669bf63918113c335=
901
        new failure (last pass: v5.16-rc1-12-g273b3dc3453c) =

 =20
