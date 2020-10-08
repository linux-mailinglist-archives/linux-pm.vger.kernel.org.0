Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFA5287B39
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 19:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbgJHRxc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 13:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgJHRxb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 13:53:31 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCB9C061755
        for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2020 10:53:31 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 144so4605955pfb.4
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2020 10:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=wclNKRupa4LvwLBivPMcpNdQy9NjeILkB2mY653j63w=;
        b=c+fLdyiBKxYb09Vok1e+o34XsJkhD3fhTRq2cP+VVU/Y5kINOheQbDhI9Z9IpVQwRo
         kIC3wGZs7uZ9FeyihcGyhD9lJPf1GKEX6K/6zUPNXD6WMbkUyuDVsl1mbZVVmFbitxli
         IekeptU0lP/G5S2SwakpkQDjaj3HN0N801h5pqGKH2T9sHZH7BaDZjhjWlL0yBl7QLN4
         1P3X7/h2fBPS246wm1vHLzDpRyO6Gh5a60BoEHVUaziRaZxJKXbL509BzkvglV00tR/7
         1WFmXfSVuJk0njY2bbpl90D1OGo3I2wfmUZ0xQyPzcwPCm3pNj5iFNirrbknqRK5WXdL
         aaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=wclNKRupa4LvwLBivPMcpNdQy9NjeILkB2mY653j63w=;
        b=OGxbMw/CDtYXNCkAwKPy6QJI+Lk0aoYeJzFEFBzpLbFlRg9VxR/giboWVPgdgFA1C0
         bfBntReYHwK7yopIJTexg8uJ3wyKmTaZ5JfRowWq/VJHI/7qeVl+c1y/hdDbYwlkTiPH
         GY7BdbjLAYCK3Yg+6WauxzsRbQGdWCHuJAopXHqg5ZZeejLD9tUq8bnq5z/A7ZbQS/K7
         ynsXGCZ2s8JitXvsB+JwOVGYB6nNKmPZ0DsxhNvAVeUTcTGOawOjIf+Y4hTAXmGH70yW
         oZ1hkxZrALp1GI44V527YWMe2BdlPYKSmCDicDv3toq/KsVUTFzPiyRQyUFWUgOZCOUE
         26KQ==
X-Gm-Message-State: AOAM532Z33Gy7GjF1qYX6mJOCipJ+MAT0HY9kd8S0ENO1RpcVlk47EVJ
        MghQoWnZj2C2MF3D+HyycuLbww==
X-Google-Smtp-Source: ABdhPJynTVlk2ZTnXX6gaeQC2MvYTK7hLwwAbXkhqAYvBs2TMIK85aQ7iDUL5XlIwbbxOX5lW8R/cg==
X-Received: by 2002:a63:1262:: with SMTP id 34mr86465pgs.452.1602179610139;
        Thu, 08 Oct 2020 10:53:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g4sm7895958pgj.15.2020.10.08.10.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 10:53:28 -0700 (PDT)
Message-ID: <5f7f5218.1c69fb81.1240b.e286@mx.google.com>
Date:   Thu, 08 Oct 2020 10:53:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc8-158-g4ae5e76f4c5d
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 4 runs, 5 regressions (v5.9-rc8-158-g4ae5e76f4c5d)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 5 regressions (v5.9-rc8-158-g4ae5e76f4c5d)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | results
-----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 8/12   =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc8=
-158-g4ae5e76f4c5d/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc8-158-g4ae5e76f4c5d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      4ae5e76f4c5d75baac0f3466ab0798c6d124a4bf =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | results
-----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana  | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f7f45e7ed51ce91904ff3e0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc8-158-g4ae5e=
76f4c5d/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc8-158-g4ae5e=
76f4c5d/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1002.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f7f45e7ed51ce91904ff3e1
      failing since 49 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)  =



platform         | arch  | lab           | compiler | defconfig | results
-----------------+-------+---------------+----------+-----------+--------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 8/12   =


  Details:     https://kernelci.org/test/plan/id/5f7f464552992e60144ff3e8

  Results:     8 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc8-158-g4ae5e=
76f4c5d/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc8-158-g4ae5e=
76f4c5d/arm64/defconfig/gcc-8/lab-collabora/sleep-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
1002.0/arm64/rootfs.cpio.gz =


  * sleep.rtcwake-mem-3: https://kernelci.org/test/case/id/5f7f464552992e60=
144ff3ed
      new failure (last pass: v5.9-rc8-137-gc3cdb7873495) * sleep.rtcwake-m=
em-4: https://kernelci.org/test/case/id/5f7f464552992e60144ff3ee
      new failure (last pass: v5.9-rc8-137-gc3cdb7873495)

    2020-10-08 16:58:11.573000  rtcwake: wakeup from \"mem\" using rtc0 at =
Thu Oct  8 16:51:51 2020
    2020-10-08 16:58:11.591000  <6>[   37.420659] PM: suspend entry (deep)
    2020-10-08 16:58:11.606000  <6>[   37.435540] Filesystems sync: 0.000 s=
econds
    2020-10-08 16:58:12.259000  <6>[   37.448132] Freezing user space proce=
sses ... (elapsed 0.636 seconds) done.
    2020-10-08 16:58:12.270000  <6>[   38.099910] OOM killer disabled.
    2020-10-08 16:58:12.287000  <6>[   38.110703] Freezing remaining freeza=
ble tasks ... (elapsed 0.001 seconds) done.
    2020-10-08 16:58:12.304000  <6>[   38.129575] printk: Suspending consol=
e(s) (use no_console_suspend to debug)
    2020-10-08 16:58:13.393000  <3>[   38.763399] mwifiex_pcie 0000:01:00.0=
: adapter is not valid
    2020-10-08 16:58:13.401000  <4>[   38.795929] xhci-hcd xhci-hcd.15.auto=
: WARN: xHC CMD_RUN timeout
    2020-10-08 16:58:13.408000  <3>[   38.795969] PM: dpm_run_callback(): p=
latform_pm_suspend+0x0/0x78 returns -110
    ... (7 line(s) more)
     * sleep.rtcwake-mem-5: https://kernelci.org/test/case/id/5f7f464552992=
e60144ff3ef
      new failure (last pass: v5.9-rc8-137-gc3cdb7873495)

    2020-10-08 16:58:13.509000  rtcwake: wakeup from \"mem\" using rtc0 at =
Thu Oct  8 16:51:53 2020
    2020-10-08 16:58:13.513000  <6>[   39.288248] OOM killer enabled.
    2020-10-08 16:58:13.526000  <6>[   39.288251] Restarting tasks ... done.
    2020-10-08 16:58:13.537000  <6>[   39.309072] PM: suspend exit
    2020-10-08 16:58:13.549000  <6>[   39.359935] PM: suspend entry (deep)
    2020-10-08 16:58:13.561000  <6>[   39.390118] Filesystems sync: 0.000 s=
econds
    2020-10-08 16:58:14.323000  <6>[   39.402406] Freezing user space proce=
sses ... (elapsed 0.746 seconds) done.
    2020-10-08 16:58:14.353000  <6>[   40.182549] OOM killer disabled.
    2020-10-08 16:58:14.370000  <6>[   40.193406] Freezing remaining freeza=
ble tasks ... (elapsed 0.001 seconds) done.
    2020-10-08 16:58:14.391000  <6>[   40.216335] printk: Suspending consol=
e(s) (use no_console_suspend to debug)
    ... (28 line(s) more)
     * sleep.rtcwake-mem-6: https://kernelci.org/test/case/id/5f7f464552992=
e60144ff3f0
      new failure (last pass: v5.9-rc8-137-gc3cdb7873495)

    2020-10-08 16:58:17.700000  rtcwake: wakeup from \"mem\" using rtc0 at =
Thu Oct  8 16:51:57 2020
    2020-10-08 16:58:17.718000  <6>[   43.547648] PM: suspend entry (deep)
    2020-10-08 16:58:17.730000  <6>[   43.559027] Filesystems sync: 0.000 s=
econds
    2020-10-08 16:58:18.372000  <6>[   43.577572] Freezing user space proce=
sses ... (elapsed 0.620 seconds) done.
    2020-10-08 16:58:18.402000  <6>[   44.231057] OOM killer disabled.
    2020-10-08 16:58:18.419000  <6>[   44.241857] Freezing remaining freeza=
ble tasks ... (elapsed 0.001 seconds) done.
    2020-10-08 16:58:18.437000  <6>[   44.262393] printk: Suspending consol=
e(s) (use no_console_suspend to debug)
    2020-10-08 16:58:19.533000  <3>[   44.902277] mwifiex_pcie 0000:01:00.0=
: adapter is not valid
    2020-10-08 16:58:19.540000  <4>[   44.934764] xhci-hcd xhci-hcd.15.auto=
: WARN: xHC CMD_RUN timeout
    2020-10-08 16:58:19.551000  <3>[   44.934806] PM: dpm_run_callback(): p=
latform_pm_suspend+0x0/0x78 returns -110
    ... (5 line(s) more)
      =20
