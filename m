Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7052CE13B
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 22:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731853AbgLCV5N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 16:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729579AbgLCV5M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 16:57:12 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893E4C061A4F
        for <linux-pm@vger.kernel.org>; Thu,  3 Dec 2020 13:56:32 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id f1so1915557plt.12
        for <linux-pm@vger.kernel.org>; Thu, 03 Dec 2020 13:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Avp9e0zeThGoZKuEqEmRqn1GW3hPsVu/jzJABcSHe+g=;
        b=ELe9lp6JZGotvuK0WrB4Eeizj89xEsuYWbnOiVw2OkzDFdcf9aFb1OulW2+kxhUFBG
         nvwIaKIfAosDRiMa7Ut72I55g6cw89FYn6WV1VqlXOXnxh0NDO07KctR74xHF259Uvt/
         L74QIL8D7agu4+TqkKB2Mc/sXJy3WTFm7jMMYQN+f2kZVmr1frB5Kgb87aXx2zty8ZE7
         Q11R9wGxzcjQhA8d1jfGGe+Vy8s5Uhg5ZCBFjKUKwwXNSSWVceGwe9zCDYOpKjVKh/LT
         1TDitZFJ+Zf+16mF8Sy7i2hqVJw2X7gl3Gwnr5JA/TpfBFE+8uEbCX6yYhDwlastLNZS
         4VEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Avp9e0zeThGoZKuEqEmRqn1GW3hPsVu/jzJABcSHe+g=;
        b=XJE9axDR2yS6g1PQIYV2wKeqxZ6vvTkMb0+BKzZW/SwXX1UHuKyTjywYRXNWlM3c24
         21uVKWNamQDvw9XJW8GuG2PXZ1jLPgDXia+6dFPbm+Z2AGYDy3b7D5PL3npzXJK7dx4v
         Mq/Wr04Tz9gmm1S5gUldSCcLNS4gJxxrIeHJBoPb2ATXRQ9Qbgjxvo5muo7RJNk+9dR3
         rQ/D+Ls+P72EH69PgnL4ZTfgZntMHmX1QSWSiXF63QeJdys9+/f8AReMHD9KawxkIMc+
         6crpA2sfdlt3zoaTXnO3ZD/bcyOF8n56EZLX9TI4UlAd3BHm4nIYDJt3I4G1+6KDt+MP
         L55Q==
X-Gm-Message-State: AOAM5313t7Rd9Otl5TZh811QpXcgXu6oE2KFoVn5bE/8tahH7G0EvKc0
        ybky63GuS5YoWxqZ2oaS1v6OpA==
X-Google-Smtp-Source: ABdhPJyhVD1O1zwu83vEKaSqYR166Up09f40d6yTKJyBRTdibMrRa4YsULGkhurPuqsyoQ8azgNh5Q==
X-Received: by 2002:a17:90a:4295:: with SMTP id p21mr1065814pjg.65.1607032592148;
        Thu, 03 Dec 2020 13:56:32 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t8sm2743944pfe.65.2020.12.03.13.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:56:31 -0800 (PST)
Message-ID: <5fc95f0f.1c69fb81.59e9e.61eb@mx.google.com>
Date:   Thu, 03 Dec 2020 13:56:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc6-90-gc35cc6e0cf05
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 8 runs, 1 regressions (v5.10-rc6-90-gc35cc6e0cf05)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 8 runs, 1 regressions (v5.10-rc6-90-gc35cc6e0cf05)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
6-90-gc35cc6e0cf05/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc6-90-gc35cc6e0cf05
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c35cc6e0cf0522be409eb83e6c2d7ab606627e17 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fc94f6535a41e57c1c94cc6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc6-90-gc35cc=
6e0cf05/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc6-90-gc35cc=
6e0cf05/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1130.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5fc94f6535a41e57c1c94cc7
        failing since 106 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
