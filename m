Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABD42E9E05
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 20:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbhADTPG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 14:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbhADTPG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 14:15:06 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4B8C061795
        for <linux-pm@vger.kernel.org>; Mon,  4 Jan 2021 11:14:25 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id x12so15038733plr.10
        for <linux-pm@vger.kernel.org>; Mon, 04 Jan 2021 11:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Qh/OV4BC3R+V2kJmdNi/V5EnhEzM6CsrtlJRRZUHRnU=;
        b=zwSoB5txKloYDff6BDiTKttq54g0ZKroZSlMRcfdF9msFfK3aquIkjrDY5rZyFlVAI
         F4dn2ZP1i0NOpdLUQ8pNW4sqrfoRU5DRkeuQowrg1L4owmBqPuVP5CvgU69Cvhu+OsfU
         TbGAjQQ2BOhjP1HzqnE8Qm1R/qFtTrttTaIb5UwF34kd0G65HuLY+EVTU79aal9p28qU
         D1+LRmw64pfYLsd90ACoDELfxL2FSDQZxBO2shNurVO32e4CKbx2CQKAW+fqRE5eF06G
         Et+OPvV8O/YHERuqCFLDiO6Mwkw3SLzoekzboen2PYnea4pMNMYpqAZyTFQvg1jREjlS
         uIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Qh/OV4BC3R+V2kJmdNi/V5EnhEzM6CsrtlJRRZUHRnU=;
        b=dmJ8WKTxfM5P4Bb7sHyXIgjWlX40N5qPlP/J7DilQp3TsPqpt46DS6XLDvSWxB4nQX
         XsmLGC+Z48JnbNvfYEErpMOUaHIkV5prBsr5jtBkZjVAf+0i+5nJF2TlS2e9UPhnY9mb
         lJXFZ3Y2WSKhfdeRkXbPfCcYlNfmvkeza46RCw8rZ55r0BDUPf1BnnSWUrmPAM7pzqBa
         SkpxO6HIc9VMQeYpq2SK027N/0naFmBGOQph1igt5kqvSwoM+jAdBNX8Y7vVIwukcTIv
         U1gxyLqxJyKSL5YXcT8nL3VmcTPaKjDNRzMd/QjdwBpRv/s5EO5wMwjDEhQWMfI7Zg86
         nyzQ==
X-Gm-Message-State: AOAM531+wTPHXf0r68EHVSoumYZXlHYRzYM1prP2LFskXUZfhmCkpIG9
        R7Ew/CKwQwB29L6jfg06vUxBjQ==
X-Google-Smtp-Source: ABdhPJxr3xOivKfHRJxcGngBc6a47HvbmXpt0AnrBaSjhPVAsnfx09wHqsJj/D5hc2aHcyw8Wu4R9Q==
X-Received: by 2002:a17:90a:d494:: with SMTP id s20mr336744pju.178.1609787665321;
        Mon, 04 Jan 2021 11:14:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t2sm50865677pga.45.2021.01.04.11.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 11:14:24 -0800 (PST)
Message-ID: <5ff36910.1c69fb81.f0fe6.c938@mx.google.com>
Date:   Mon, 04 Jan 2021 11:14:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.11-rc1-12-ga04307bd9ddd
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 5 runs, 2 regressions (v5.11-rc1-12-ga04307bd9ddd)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 2 regressions (v5.11-rc1-12-ga04307bd9ddd)

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


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.11-rc=
1-12-ga04307bd9ddd/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.11-rc1-12-ga04307bd9ddd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a04307bd9dddb650f84d968165cdf4d3dd3c9b99 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/5ff35c814d9c8c2aa8c94cc8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc1-12-ga0430=
7bd9ddd/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc1-12-ga0430=
7bd9ddd/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1221.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/5ff35c814d9c8c2aa8c94cc9
        failing since 138 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/5ff35e2fc949cd6e88c94cc2

  Results:     11 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc1-12-ga0430=
7bd9ddd/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc1-12-ga0430=
7bd9ddd/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1221.0/arm64/rootfs.cpio.gz =



  * sleep.rtcwake-mem-4: https://kernelci.org/test/case/id/5ff35e2fc949cd6e=
88c94cc8
        new failure (last pass: v5.10-rc7-106-g97756044ce06)

    2021-01-04 18:22:33.127000+00:00  <6>[   26.261564] PM: suspend entry (=
deep)
    2021-01-04 18:22:33.142000+00:00  <6>[   26.275678] Filesystems sync: 0=
.000 seconds
    2021-01-04 18:22:33.161000+00:00  <6>[   26.290084] Freezing user space=
 processes ... (elapsed 0.001 seconds) done.
    2021-01-04 18:22:33.171000+00:00  <6>[   26.306466] OOM killer disabled.
    2021-01-04 18:22:33.189000+00:00  <6>[   26.317825] Freezing remaining =
freezable tasks ... (elapsed 0.001 seconds) done.
    2021-01-04 18:22:33.203000+00:00  <6>[   26.333827] printk: Suspending =
console(s) (use no_console_suspend to debug)
    2021-01-04 18:22:39.845000+00:00  =14=00=00<3>[   26.946300] mwifiex_pc=
ie 0000:01:00.0: adapter is not valid
    2021-01-04 18:22:39.857000+00:00  <6>[   27.170924] Disabling non-boot =
CPUs ...
    2021-01-04 18:22:39.868000+00:00  <5>[   27.171464] CPU1: shutdown
    2021-01-04 18:22:39.887000+00:00  <6>[   27.172487] psci: CPU1 killed (=
polled 0 ms) =

    ... (61 line(s) more)  =

 =20
