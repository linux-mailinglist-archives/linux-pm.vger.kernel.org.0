Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB6F42FF68
	for <lists+linux-pm@lfdr.de>; Sat, 16 Oct 2021 02:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbhJPAWA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 20:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhJPAWA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 20:22:00 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66269C061570
        for <linux-pm@vger.kernel.org>; Fri, 15 Oct 2021 17:19:53 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id g5so7381576plg.1
        for <linux-pm@vger.kernel.org>; Fri, 15 Oct 2021 17:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=melXPuRhsv/Z0NlsBfahsZMg0ZQt/3HCtr/FUUI5Jhw=;
        b=K/SzqSjO79nepVcfU1ANPjgMdFCxumqUGkxrrXwFd0V0X5bDLFGYU/ZLB9FZVG50Yw
         +amADw1BKs34WOgJVd+oPI67ajDgS2VZeaqjfOYSSd3E1qcA2VB3GQidaoAevyLpueDv
         BUPi0cUHmgD9TrXLjSUksfLgAZQeTEtbxoiJxCg3Qs3AWhxX1b/dyCp3ngO0nzovFLiZ
         1OS5WNC+3PJYupWsiOpyk+xrfUaf5sjp2OvCsEvrXs1mFp9USyffMGdVguftgDdefWUs
         skKY1mmG9yg3E3ID16kf4wtMhIKIMrmoCzLq94dHzhMrOwB0QHcN1NXpt0ssr+8KCIAo
         M8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=melXPuRhsv/Z0NlsBfahsZMg0ZQt/3HCtr/FUUI5Jhw=;
        b=5M+BKu2Ut2ZwwLmfKG3JvhaqkrkZEmQMX45jKwLmg/yk35AUUim2Za2GpNEhSp1yYg
         AqDsApMOtLnR2mai883LvMthJMtRbUeY+XjNg0Wq16vqkmGJMuam6CcFSYdPK7zGJ7In
         Lh1xs9RNr4mfz22+PCFTmvDXH7o1JdyAk6OL8OWyJFKtT56QtdWdIkq/7Mr9aXp1NlWL
         32v75V6QEJ46O1vU1gs3fUwE4m25tIfxs/7jtJbYV1XU4o6mPwVQD77rtJHDQJGpcLFp
         VClj417c0sfwXGodf9Q+bDJvgyeyG0ztkbEDCq+sj2fNNhyXf96mq/GhKsvXUROVSVCH
         +iEw==
X-Gm-Message-State: AOAM533DTQVIcifAXyeXHI7HDRC7AJZyipM6eHkb6walwDKrGzU+Y0r8
        EmBLEXLGSRCWamAjqIRdYXoUb1A3MT0+fQ==
X-Google-Smtp-Source: ABdhPJw1pgQFDCfaz9HviG5MK2RtnvgDx6EoA9YxDudlU6M8SMvKWoGjtjXXMhUv5tb8znl+ZyCFxg==
X-Received: by 2002:a17:90b:3a8b:: with SMTP id om11mr10155071pjb.216.1634343592818;
        Fri, 15 Oct 2021 17:19:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u2sm5721190pfi.120.2021.10.15.17.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 17:19:52 -0700 (PDT)
Message-ID: <616a1aa8.1c69fb81.6b16.27af@mx.google.com>
Date:   Fri, 15 Oct 2021 17:19:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: acpi-5.15-rc6-59-g180a736395e7
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 40 runs,
 1 regressions (acpi-5.15-rc6-59-g180a736395e7)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 40 runs, 1 regressions (acpi-5.15-rc6-59-g180a736395e7)

Regressions Summary
-------------------

platform  | arch | lab          | compiler | defconfig          | regressio=
ns
----------+------+--------------+----------+--------------------+----------=
--
beagle-xm | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/acpi-5.1=
5-rc6-59-g180a736395e7/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: acpi-5.15-rc6-59-g180a736395e7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      180a736395e7e100b947e3e4a2a5bfe046faacfc =



Test Regressions
---------------- =



platform  | arch | lab          | compiler | defconfig          | regressio=
ns
----------+------+--------------+----------+--------------------+----------=
--
beagle-xm | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/616a0ca7e4e3b144193358ea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.15-rc6-59-g1=
80a736395e7/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.15-rc6-59-g1=
80a736395e7/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/616a0ca7e4e3b14419335=
8eb
        failing since 8 days (last pass: v5.15-rc4-24-g8e0efc215fb1, first =
fail: v5.15-rc4-42-g574167bf7ed8) =

 =20
