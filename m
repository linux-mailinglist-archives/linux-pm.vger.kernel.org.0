Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF6523490C
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 18:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgGaQQd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 12:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbgGaQQd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2020 12:16:33 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89769C061574
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2020 09:16:33 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id u185so14730064pfu.1
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2020 09:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=6IheWizVMmXTnFVSULn5nOsJnrMjElflkO/jj7vaLKM=;
        b=GLJZ/1OOPUXfs8U7TCVRWUQvXYcsoKyKI1+fQyc/ENiI8uMZBhVf6FD7iJSQkTao+8
         AeOIQ38zJzOoI5jihHLTWn6OXPtMqqGcb46ey+2Yw0lhHiWzqmSgrMiW3sJli3NfMIQM
         Ep+51Pl++G+DtvVUdKX/f7HMFLe1vvkNEE64HZqlabxSyPAq6w4i9z9UlEHOTWaM2/t5
         Rx/+hUU+WXYtC8H3CGzWLv93lDByiEJ3IjhgjUw6pVkxkW1XHaZPIrKuK2yLxux85Lem
         tXe5CIsj0/wPvT2+kn/S8VVpqYuKmeJml13j4++tKnVQwJ8NGdit546JcG6JmtmneX62
         VoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=6IheWizVMmXTnFVSULn5nOsJnrMjElflkO/jj7vaLKM=;
        b=uD/o1Q3m992Msogkzu34zp/QWNrhlljUpAsRNFifnCOJJX8RVTB96mwfbk7aDAxwUF
         +9AY3dVuTMXBItjUqH76mNm1s9GROzEmSk2O54khtK+d99sNntxAcVx6STCmqGlala++
         gTG1sTGJ+E+yNLdYRS7SbrkNU+hzNb2Ajlg0+257SPO39qssa/h7pLtmhql4jsDrDwr+
         yR1Ncr4gE0ib1k2StjWhkB8ejFvtsRZ6EcyZd+TVgnc6YBLnYmWcyZ+hDYdBIrjTiorY
         2OpXPdFZLGEHb0NPb8N1tlGmczrl8T1XdQIGR2J0llfJnOgyJviopWMV7EGkGn/rnoOK
         E9+g==
X-Gm-Message-State: AOAM531WzUPvSLnAPaMCIyCmwWlcfTgSycTqcNi/zKMWsFvcUNdrBaFQ
        xC7wfLmmi1ox68bFac/qCV6rug==
X-Google-Smtp-Source: ABdhPJyYOBlGxkSe4PjAvNnrybEQBKLgbxMImHa1zQZH3yhKUBK7zjpCtITe07docJ+4lTEQw84OrA==
X-Received: by 2002:aa7:8e9e:: with SMTP id a30mr4498635pfr.319.1596212192852;
        Fri, 31 Jul 2020 09:16:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o4sm10453641pfd.25.2020.07.31.09.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:16:32 -0700 (PDT)
Message-ID: <5f2443e0.1c69fb81.774d6.b1d2@mx.google.com>
Date:   Fri, 31 Jul 2020 09:16:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.8-rc7-109-g86ed8b05f597
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 8 runs, 1 regressions (v5.8-rc7-109-g86ed8b05f597)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 8 runs, 1 regressions (v5.8-rc7-109-g86ed8b05f597)

Regressions Summary
-------------------

platform             | arch | lab           | compiler | defconfig         =
 | results
---------------------+------+---------------+----------+-------------------=
-+--------
exynos5422-odroidxu3 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig=
 | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.8-rc7=
-109-g86ed8b05f597/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.8-rc7-109-g86ed8b05f597
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      86ed8b05f59717b20b75cd2a4a17cbd26788183a =



Test Regressions
---------------- =



platform             | arch | lab           | compiler | defconfig         =
 | results
---------------------+------+---------------+----------+-------------------=
-+--------
exynos5422-odroidxu3 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig=
 | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f24377c615e15171e52c1b4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-rc7-109-g86ed8=
b05f597/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-exynos5422-odroidx=
u3.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-rc7-109-g86ed8=
b05f597/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-exynos5422-odroidx=
u3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0729.0/armhf/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f24377c615e15171e52c1b5
      failing since 0 day (last pass: v5.8-rc7-94-g89beac5dc8d0, first fail=
: v5.8-rc7-107-g97987ea7f86a) =20
