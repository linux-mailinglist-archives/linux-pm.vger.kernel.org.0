Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A793C658C
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 23:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhGLVq6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 17:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhGLVq5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 17:46:57 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1805FC0613DD
        for <linux-pm@vger.kernel.org>; Mon, 12 Jul 2021 14:44:09 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y4so17650439pfi.9
        for <linux-pm@vger.kernel.org>; Mon, 12 Jul 2021 14:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=qyOatt4S+BS0JtcFoLzC96plx91Rm3KR8rkiR5LMTlY=;
        b=aS1/OC1xEECg67STT+/QF/KxMnJVih1oRn1Pc2Hw0DJnv6PrkXjPluRTuLB/uCj8li
         UpH0KkyAIlL89DUX0zHLWEbw9sqx9hDyWTxN93XSQQWL/MxNTljpsJbSxWSVo///8ZWL
         duS3EUsblhlNUN94P26h0MTUiFj0j+7O7GfbDbqHWnw16SPmBcrWLyW+JLqoSAFY4e1K
         N7RlZF0JsRAVz0fV++zKBCuW7U8VeAK63065iVnEyDWYQTiIDKAu9hM+FzrwZSlRCmVQ
         qPHwLN3YxbWiZ5o1ziAytZn+LOpeijmE4QW/cU8lXlhImJIzhuZvc6AuAY2mtY3JUFg0
         8L9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=qyOatt4S+BS0JtcFoLzC96plx91Rm3KR8rkiR5LMTlY=;
        b=LqDM65iynGHWu/cd700lPoqrGwAMktv4HJ5BF4b6XDnubF0GrOs4AjHVFxF57AHQjM
         AlgsfVhDfqaJzwA4cYpHgLiAm2MZsrV1LJCF1JzW+sq+J3u8o1ePaY/qc5r4cEs8dCN1
         3jBNONvtZDm7O49/nuMTDnjrjmQMu2TDnyF4+uNMtLBkZiEbiKd+9DARs1z8h/yCfLcD
         1qoJdIsdCVOV9NttioTgkf1hTw42PBoKRlbEZ9AEVYgJTisLjwuJmfjEwHr5ZnmpDubn
         PVmU/HXNdOtSqeCX5suqw9Gm9GtQ83xNewuw9+Ab7Xx1ig0Diu9GHOtVLehCFI3F+89j
         Ts1w==
X-Gm-Message-State: AOAM532hjzYGoIgiZTs4z3fqUzn+QDJj+MTE1PVKlGz84tcBJp8Uw8U0
        WgVINyoJT6YTGZVjwgMmfeq1ml1ac5s02A==
X-Google-Smtp-Source: ABdhPJxZhH5eQatdiCkFGJZViLbEjfU1ptDcIKuw4foFBmu8wtIrnhBmuYIhaQL+0JEoScBGIyr+vQ==
X-Received: by 2002:a05:6a00:cc1:b029:32b:8465:9b59 with SMTP id b1-20020a056a000cc1b029032b84659b59mr1258854pfv.66.1626126248586;
        Mon, 12 Jul 2021 14:44:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u185sm3312168pfu.49.2021.07.12.14.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 14:44:08 -0700 (PDT)
Message-ID: <60ecb7a8.1c69fb81.1bee6.955b@mx.google.com>
Date:   Mon, 12 Jul 2021 14:44:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.14-rc1
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 104 runs, 3 regressions (v5.14-rc1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 104 runs, 3 regressions (v5.14-rc1)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig        =
  | regressions
----------------------+-------+--------------+----------+------------------=
--+------------
bcm2837-rpi-3-b       | arm64 | lab-baylibre | gcc-8    | defconfig        =
  | 1          =

beaglebone-black      | arm   | lab-cip      | gcc-8    | multi_v7_defconfi=
g | 1          =

kontron-kbox-a-230-ls | arm64 | lab-kontron  | gcc-8    | defconfig        =
  | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.14-rc=
1/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.14-rc1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      e73f0f0ee7541171d89f2e2491130c7771ba58d3 =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig        =
  | regressions
----------------------+-------+--------------+----------+------------------=
--+------------
bcm2837-rpi-3-b       | arm64 | lab-baylibre | gcc-8    | defconfig        =
  | 1          =


  Details:     https://kernelci.org/test/plan/id/60ecae5d6f4f1c33ba1179c5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc1/arm64/def=
config/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc1/arm64/def=
config/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60ecae5d6f4f1c33ba117=
9c6
        new failure (last pass: devprop-5.13-rc8-173-ge132b9a1079c) =

 =



platform              | arch  | lab          | compiler | defconfig        =
  | regressions
----------------------+-------+--------------+----------+------------------=
--+------------
beaglebone-black      | arm   | lab-cip      | gcc-8    | multi_v7_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/60ecad6753d492a8cb11798d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc1/arm/multi=
_v7_defconfig/gcc-8/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc1/arm/multi=
_v7_defconfig/gcc-8/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60ecad6753d492a8cb117=
98e
        new failure (last pass: devprop-5.13-rc8-173-ge132b9a1079c) =

 =



platform              | arch  | lab          | compiler | defconfig        =
  | regressions
----------------------+-------+--------------+----------+------------------=
--+------------
kontron-kbox-a-230-ls | arm64 | lab-kontron  | gcc-8    | defconfig        =
  | 1          =


  Details:     https://kernelci.org/test/plan/id/60ecad4a02be26936211797b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc1/arm64/def=
config/gcc-8/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc1/arm64/def=
config/gcc-8/lab-kontron/baseline-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60ecad4a02be269362117=
97c
        new failure (last pass: devprop-5.13-rc8-173-ge132b9a1079c) =

 =20
