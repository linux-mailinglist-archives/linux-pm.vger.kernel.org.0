Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC6E31F185
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 22:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhBRVFf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 16:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhBRVFQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 16:05:16 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA55C061574
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 13:04:35 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id my11so3403810pjb.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 13:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=gjrrzwVNd4dyROKa6VCMajpbSyXOTIgCq27S/UqZyLc=;
        b=qHkDgH6oaXULpYjnoVICeN+zH9s9XOeownCthnClCFu2vKkdTMohqejopu6HKzRVkj
         OKfxUlVV39K2tb65HkPcRePcBZuWSuRNthnOuX8II8gEBLLWtlGXTcqUlpRevsATY5gc
         DQZkIFrWOHW+M7JeJHYypz/ODV3KvTf7XHS7e+0D9WkSQ8IEkGgjIzcYvmgEUhUkcHOM
         zdga8XtOEVLo77NBtLC+OhgwaCJGkaabo18Tz/1CKxaclrCYm8DIhnPHMhaqOJX+SBfF
         M+Y6/lqPNn8a9rhOEEKk1SsIqQZ0KGUCeelsqFtHyrKvI9rRQ6+15EFoQJDsXN0zZJcB
         zaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=gjrrzwVNd4dyROKa6VCMajpbSyXOTIgCq27S/UqZyLc=;
        b=jybOewXWJdsVt1lfYgsvX5oBlPkQUe1Pe5YxIb1XMWdcxzeqXI17Cb7hUdic9zA5GF
         PBUKnGnj5YoGTveOXX8bR8jmWIKXvUvFQIrHBoUfmhpfXeQ0C3/rfxEjxgpunmCadfiB
         ohO34RzGBtDJJGu+vTcEbhPg6peG0k4jTRwyutftS8Y8RPW+d/tyw7bAQS8svYGQdHSI
         Z2PZQhICm3zZrtAuOKAN1JcSkBRZPD3jDB28IWoMRAISlypDZkZQJWDT4lSh72KJFWhd
         N9PKdfsXScpoaXECQjfL+Hu8PPmRKj5QFCzq/7LbNhCaEM+6K0CIMB7CzzplY9sCltHk
         q+gg==
X-Gm-Message-State: AOAM5321HVdKoexG6e1XUns7yT2QHxb/m5Uk8Qf6cfAWAY0VgtumhzZK
        q4TFOE3TsRVzDPOBPyGLd9Uqegk6yz+afQ==
X-Google-Smtp-Source: ABdhPJzLkNsKnu9fLsfapaXR87X3TdVq1cCrQe4L8DGMRThaq2OL5wB1JiLcs+odY+Hdn36dUQfmkw==
X-Received: by 2002:a17:90b:3d8:: with SMTP id go24mr5881935pjb.181.1613682274671;
        Thu, 18 Feb 2021 13:04:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k10sm6322887pgl.43.2021.02.18.13.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 13:04:34 -0800 (PST)
Message-ID: <602ed662.1c69fb81.103c5.da06@mx.google.com>
Date:   Thu, 18 Feb 2021 13:04:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: pm-5.11-rc8-201-g8b72d3aa065c
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 6 runs,
 2 regressions (pm-5.11-rc8-201-g8b72d3aa065c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 2 regressions (pm-5.11-rc8-201-g8b72d3aa065c)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-5.11-=
rc8-201-g8b72d3aa065c/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: pm-5.11-rc8-201-g8b72d3aa065c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      8b72d3aa065ce33df4f042840078542b1e5d2c45 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/602ec9e996a89a439caddd3a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.11-rc8-201-g8b=
72d3aa065c/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.11-rc8-201-g8b=
72d3aa065c/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0215.2/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/602ec9e996a89a439caddd3b
        failing since 183 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/602ec9df15862ad986addcb1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.11-rc8-201-g8b=
72d3aa065c/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.11-rc8-201-g8b=
72d3aa065c/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0215.2/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/602ec9df15862ad986addcb2
        new failure (last pass: v5.11-156-gc9756fcd3979) =

 =20
