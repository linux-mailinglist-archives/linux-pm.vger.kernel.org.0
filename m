Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B9C252236
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 22:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHYUuV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 16:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYUuV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 16:50:21 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073DBC061574
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 13:50:19 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p11so5095850pfn.11
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 13:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=9PQWALDqGvML2yeQQVLbp1V3Z9yOfzxCP9nW7DK+z4I=;
        b=dqrcnYs+uy8j48Qv40KgaeSCLKFUVpeKo4vGFyAErKPFhC4eMk2EowcZ4JGF29lAF1
         Smk50Uw5NLLaFTGq2XSR9ctdUQ8CualkCu5fSGJkzq+nzcHnvDRrylZbTt1DSGqin2Hi
         yeJJxtDQYg6Rjayi/aercY/aec6gi4ECpirvXBq4GzAXP76t9Yinf0JRbgVadn8c3ZnU
         68111TXmLv/vSyA+tbi+10EIJ3zzH9FSRLexr8qsaNR4g/L7NI6SI66gdxgFY6z6x9Rb
         yUdVdDS3NmvMwETI5tudHBPIueFCz6OGInz6YD3R++a24lWP8M/8nJ0Wr8R/cADYzu7S
         dodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=9PQWALDqGvML2yeQQVLbp1V3Z9yOfzxCP9nW7DK+z4I=;
        b=tJfbritQxeRq3sHgxtXXuCT3XLAEguRbxh/1elWildv9Q87YjhZ0ScYucd1bglRcxW
         JQyYOJxI+Mp8RMvXF4UA0iHY5lM7uUBQTyR+NOG5QdeBWUpu6jUauOUV6LCK9BUjMH7L
         4++k6xjKSnKhLchb6YFSgeeV474scyFTjcDyxGwHphBdTx1+ibdWQqtdZfPw5qD1hMAF
         bbx1m68g8x5NOOGrUk+qNF6387ExgbedGktpC58/v15SfyhyQfnImGlyMaVmyzXD8DvL
         ePf0crTsr221lV17Vf3OSuCZhUYawTIzJ1o6D7V4XVHyRQEVyD9Zune9Hd7+jzcmn95O
         rd9A==
X-Gm-Message-State: AOAM530OBCw4qHo/lxKZLjJtZo4zpkTMDJocm3WQmyBFfp9a0xB2Qg2L
        wlIe1WSjoPn8LeAnfgAlA4UIaxvOStMkaA==
X-Google-Smtp-Source: ABdhPJwwlgTFCfQphJwwee83VCWKomEDMoin3mBHXrhtT0Bd2SU7PVJei16dwC6qYSpZEM/eyaqTow==
X-Received: by 2002:a65:4502:: with SMTP id n2mr7965735pgq.132.1598388618432;
        Tue, 25 Aug 2020 13:50:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c20sm99678pjv.31.2020.08.25.13.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 13:50:17 -0700 (PDT)
Message-ID: <5f457989.1c69fb81.ec790.0537@mx.google.com>
Date:   Tue, 25 Aug 2020 13:50:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc2-12-g4958dfca3d0f
Subject: pm/testing baseline: 107 runs,
 5 regressions (v5.9-rc2-12-g4958dfca3d0f)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 107 runs, 5 regressions (v5.9-rc2-12-g4958dfca3d0f)

Regressions Summary
-------------------

platform               | arch  | lab           | compiler | defconfig      =
    | results
-----------------------+-------+---------------+----------+----------------=
----+--------
mt8173-elm-hana        | arm64 | lab-collabora | gcc-8    | defconfig      =
    | 0/1    =

omap4-panda            | arm   | lab-collabora | gcc-8    | multi_v7_defcon=
fig | 4/5    =

rk3399-gru-kevin       | arm64 | lab-collabora | gcc-8    | defconfig      =
    | 0/1    =

sun50i-a64-pine64-plus | arm64 | lab-baylibre  | gcc-8    | defconfig      =
    | 0/1    =

sun7i-a20-cubieboard2  | arm   | lab-baylibre  | gcc-8    | multi_v7_defcon=
fig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc2=
-12-g4958dfca3d0f/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc2-12-g4958dfca3d0f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      4958dfca3d0f6a66ff603d8ffe5a8c232987cc21 =



Test Regressions
---------------- =



platform               | arch  | lab           | compiler | defconfig      =
    | results
-----------------------+-------+---------------+----------+----------------=
----+--------
mt8173-elm-hana        | arm64 | lab-collabora | gcc-8    | defconfig      =
    | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f456c4beda22fc2889fb43f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-12-g4958df=
ca3d0f/arm64/defconfig/gcc-8/lab-collabora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-12-g4958df=
ca3d0f/arm64/defconfig/gcc-8/lab-collabora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f456c4beda22fc2889fb=
440
      failing since 6 days (last pass: v5.8-107-gb72b3ea38c81, first fail: =
v5.9-rc1-4-g1f08d51cd57f)  =



platform               | arch  | lab           | compiler | defconfig      =
    | results
-----------------------+-------+---------------+----------+----------------=
----+--------
omap4-panda            | arm   | lab-collabora | gcc-8    | multi_v7_defcon=
fig | 4/5    =


  Details:     https://kernelci.org/test/plan/id/5f456fa9810a0e40c89fb44d

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-12-g4958df=
ca3d0f/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-omap4-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-12-g4958df=
ca3d0f/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-omap4-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f456fa9810a0e4=
0c89fb453
      failing since 6 days (last pass: v5.8-107-gb72b3ea38c81, first fail: =
v5.9-rc1-4-g1f08d51cd57f)
      60 lines

    2020-08-25 20:08:03.032000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c802
    2020-08-25 20:08:03.038000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c803
    2020-08-25 20:08:03.044000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c804
    2020-08-25 20:08:03.051000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c805
    2020-08-25 20:08:03.056000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c806
    2020-08-25 20:08:03.062000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c807
    2020-08-25 20:08:03.068000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c808
    2020-08-25 20:08:03.074000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c809
    2020-08-25 20:08:03.080000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80a
    2020-08-25 20:08:03.086000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80b
    ... (49 line(s) more)
      =



platform               | arch  | lab           | compiler | defconfig      =
    | results
-----------------------+-------+---------------+----------+----------------=
----+--------
rk3399-gru-kevin       | arm64 | lab-collabora | gcc-8    | defconfig      =
    | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f456cb2e0e02c431c9fb476

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-12-g4958df=
ca3d0f/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-12-g4958df=
ca3d0f/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f456cb2e0e02c431c9fb=
477
      new failure (last pass: v5.9-rc2-8-gf5eba0ea1052)  =



platform               | arch  | lab           | compiler | defconfig      =
    | results
-----------------------+-------+---------------+----------+----------------=
----+--------
sun50i-a64-pine64-plus | arm64 | lab-baylibre  | gcc-8    | defconfig      =
    | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f45709f5671b3a3d19fb488

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-12-g4958df=
ca3d0f/arm64/defconfig/gcc-8/lab-baylibre/baseline-sun50i-a64-pine64-plus.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-12-g4958df=
ca3d0f/arm64/defconfig/gcc-8/lab-baylibre/baseline-sun50i-a64-pine64-plus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/arm64/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f45709f5671b3a3d19fb=
489
      failing since 6 days (last pass: v5.8-107-gb72b3ea38c81, first fail: =
v5.9-rc1-4-g1f08d51cd57f)  =



platform               | arch  | lab           | compiler | defconfig      =
    | results
-----------------------+-------+---------------+----------+----------------=
----+--------
sun7i-a20-cubieboard2  | arm   | lab-baylibre  | gcc-8    | multi_v7_defcon=
fig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f456f4d31c52a2a9b9fb437

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-12-g4958df=
ca3d0f/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun7i-a20-cubiebo=
ard2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-12-g4958df=
ca3d0f/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-sun7i-a20-cubiebo=
ard2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f456f4d31c52a2a9b9fb=
438
      failing since 6 days (last pass: v5.8-107-gb72b3ea38c81, first fail: =
v5.9-rc1-4-g1f08d51cd57f)  =20
