Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595FB27D1E0
	for <lists+linux-pm@lfdr.de>; Tue, 29 Sep 2020 16:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgI2OxS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 10:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgI2OxS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2020 10:53:18 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF201C061755
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2020 07:53:17 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id l126so4793546pfd.5
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2020 07:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=CcVJIsD8Qv9Mn30ye5I35VA9z9WSZGl1c7zVEILyFu0=;
        b=W0uCIBtLFjHYpAmeOHJg947tzV5gKNGYgkS0S0uLYdHAsCIVSP7NQaRM8Rw8b4Vyiu
         V2Fg3SMI9U3QmrqoFGx/rccxrXKhMnZ/ehpeYw3JSmgM/gahh5qpDpWLymzOf9y7HHbz
         j0Oe9RuSORepXESWTdFmPb3ZxST91SXqAVwq9nOGecNIjEHZXBn+zFWM67sqo/ASfzpc
         vdBjXxgYyXZMVylqCan0L+CWopvI7S4sYe3i3vmvz5J7qxP4Wha5ssJY7CgYbozwGZXI
         zEjipjzcEc3pww0nLaLdq81s3MUU8gTqkm/rDFOc8NKRdSA1QNqxt0N7N1VQjUrd7Yme
         tsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=CcVJIsD8Qv9Mn30ye5I35VA9z9WSZGl1c7zVEILyFu0=;
        b=tVt8jOhi66NnXFwmXoBGnrZ6+rGqENPdmPQFpuYldu7DfJTXZZPzwxnuiJkhMXdvVx
         FfmfFx2gqkTXgI9usOiGTwsIGl1AwTJzOdOSd3K4c72a757UUj+a4Et1R2L0aWcCVSpE
         vhi+DS0sFdZIdZ1ceeVEMvfjFcTmNL22tSA5BXHGYJcPKJz7/N0S6p4DW6I7LcYBgUjp
         brFOjeCWkK7Gf5g57l2S1+lvCnJz1mFbnT6pVRrg01DPprTcXHGkmeK0gU9g+oBJIpOC
         Pve12mlbHPAPgvXPuEKXDu9doxRMaNKIB+BelQifgq77O5/pHDxauunwUCShZyIS5RQa
         coDQ==
X-Gm-Message-State: AOAM530vSLHC8x8fd0pDiiBWWDDK7//Rl06U8i+rHF8/p3DhcQNUcWMV
        30RankdT206rtNdOeNvJIjDy5Q==
X-Google-Smtp-Source: ABdhPJzUPIHJ9cFvYgPKBePk6O1+reAmRF7EZn1n4Az4cLC56FLNCus4TU308GhpJETx6w02lTLRUw==
X-Received: by 2002:a17:902:8682:b029:d1:e5e7:be5b with SMTP id g2-20020a1709028682b02900d1e5e7be5bmr4934829plo.53.1601391197287;
        Tue, 29 Sep 2020 07:53:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k7sm4932532pjs.9.2020.09.29.07.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 07:53:16 -0700 (PDT)
Message-ID: <5f734a5c.1c69fb81.d3dc8.9abd@mx.google.com>
Date:   Tue, 29 Sep 2020 07:53:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc7-68-geb6335b68ce3
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 90 runs,
 2 regressions (v5.9-rc7-68-geb6335b68ce3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 90 runs, 2 regressions (v5.9-rc7-68-geb6335b68ce3)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig          | =
results
-----------------+-------+---------------+----------+--------------------+-=
-------
panda            | arm   | lab-collabora | gcc-8    | multi_v7_defconfig | =
4/5    =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc7=
-68-geb6335b68ce3/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc7-68-geb6335b68ce3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      eb6335b68ce3fc85a93c4c6cd3bb6bc5ac490efe =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig          | =
results
-----------------+-------+---------------+----------+--------------------+-=
-------
panda            | arm   | lab-collabora | gcc-8    | multi_v7_defconfig | =
4/5    =


  Details:     https://kernelci.org/test/plan/id/5f7340639d0b4f1fc9bf9e1b

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc7-68-geb6335=
b68ce3/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc7-68-geb6335=
b68ce3/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-2-g61393d279614/armel/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f7340639d0b4f1=
fc9bf9e21
      failing since 40 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)
      60 lines

    2020-09-29 14:10:37.363000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c802
    2020-09-29 14:10:37.369000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c803
    2020-09-29 14:10:37.374000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c804
    2020-09-29 14:10:37.381000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c805
    2020-09-29 14:10:37.386000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c806
    2020-09-29 14:10:37.392000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c807
    2020-09-29 14:10:37.398000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c808
    2020-09-29 14:10:37.404000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c809
    2020-09-29 14:10:37.410000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80a
    2020-09-29 14:10:37.416000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80b
    ... (49 line(s) more)
      =



platform         | arch  | lab           | compiler | defconfig          | =
results
-----------------+-------+---------------+----------+--------------------+-=
-------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
0/1    =


  Details:     https://kernelci.org/test/plan/id/5f733ea12619e6ef71bf9db6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc7-68-geb6335=
b68ce3/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc7-68-geb6335=
b68ce3/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-2-g61393d279614/arm64/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f733ea12619e6ef71bf9=
db7
      new failure (last pass: v5.9-rc6-48-g537658447367)  =20
