Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960A737B321
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 02:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhELAnT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 May 2021 20:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhELAnT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 May 2021 20:43:19 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B43DC061574
        for <linux-pm@vger.kernel.org>; Tue, 11 May 2021 17:42:11 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id h127so17305020pfe.9
        for <linux-pm@vger.kernel.org>; Tue, 11 May 2021 17:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=VOSWrI2W9F52SZh/s8ZgnfcNhnttVg30p8mxTyK1900=;
        b=1dhTBuzXU0ckDiI0lbCGYtuUUiyBi2EiTccg/eYKAeK/0PTCE42GZtyFM6ZvzsX//J
         0DG8J7vaw/bhwscZ/VMl61hvZ0iZcC1W9dYzeUacsVZZ6mtc+ojHZPoc/2lQmWeJuVNs
         jiFnjHAOonsxbLSZRcWvnrtM9Kvqvkm04CTy8J9pngCo6bUJ5OtasPs0VmwZaeTjzqra
         HPPonuXS+yqwxarL+UfNPGemhnsaj+62667qgZ8Gob4fu7vXZ/jReICoHzBcbsnriYpy
         YZ5SV31JRbtbgtuw5bwgCXprp5cleLqaHTzU6pDa2lTjVzZJKi2zpFeitDBzYog3Ss2b
         lNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=VOSWrI2W9F52SZh/s8ZgnfcNhnttVg30p8mxTyK1900=;
        b=OGUhj2+4xUXoRCvxgzOYXmUzjqmIcQxJOdaXiVl5YygJwNSK8I1UjGtMmokTb6/IQ/
         wXziL3r2o8/kPS4QULfEs/LZsO5+xfctXFsvI6xAH4pYvslHghF17pHimD54lGERrPjl
         3ewbCVcF4NrGi8/rkci/DmTtaCb0B36g8NLD5H4sCwEIBQ42vuo2wSVzdZc6zqX/NXJg
         LqD9/bIJAXvOG3Bo4FNCcACmDeH/gkbz+8i/i4ACod1+4PsKG3toLRaeQgDMaXwPzD/I
         Y/6vpgCt14LPSYOaWkLqMuKzeNZEnc9T2PiZ9AbbLJhAINxUcrwuKm/SHCix3d4kawCK
         owzg==
X-Gm-Message-State: AOAM53390OJCcF71hYwDbpIlGqxlvtyLSyC1d9bIV/e9EuM0sg1fjAY8
        gSswP7nrc48BVvxiKVFvJQVVRw==
X-Google-Smtp-Source: ABdhPJxFVqeuDZ9SryzJheaPEtaYY/gL7PIMem2r6C+H9SHICsii8fGUP9nsnb2Jm5+9O8xJDR4IgQ==
X-Received: by 2002:a63:c13:: with SMTP id b19mr33465339pgl.198.1620780130811;
        Tue, 11 May 2021 17:42:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id cv24sm15634588pjb.7.2021.05.11.17.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 17:42:10 -0700 (PDT)
Message-ID: <609b2462.1c69fb81.3868a.0c9b@mx.google.com>
Date:   Tue, 11 May 2021 17:42:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.13-rc1-9-gcb7accda3e01f
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 4 runs, 3 regressions (v5.13-rc1-9-gcb7accda3e01f)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 3 regressions (v5.13-rc1-9-gcb7accda3e01f)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
mt8173-elm-hana   | arm64 | lab-collabora | gcc-8    | defconfig          |=
 1          =

rk3288-veyron-jaq | arm   | lab-collabora | gcc-8    | multi_v7_defconfig |=
 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
1-9-gcb7accda3e01f/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc1-9-gcb7accda3e01f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      cb7accda3e01f71abfb7a987f8733e8c2d2d911d =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
mt8173-elm-hana   | arm64 | lab-collabora | gcc-8    | defconfig          |=
 1          =


  Details:     https://kernelci.org/test/plan/id/609b17b719ff9e7141d08f26

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc1-9-gcb7acc=
da3e01f/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc1-9-gcb7acc=
da3e01f/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0503.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/609b17b719ff9e7141d08f27
        failing since 265 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =



platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
rk3288-veyron-jaq | arm   | lab-collabora | gcc-8    | multi_v7_defconfig |=
 2          =


  Details:     https://kernelci.org/test/plan/id/609b21c0d85d7d9245d08f1c

  Results:     21 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc1-9-gcb7acc=
da3e01f/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-veyron-jaq.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc1-9-gcb7acc=
da3e01f/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-veyron-jaq.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0503.0/armhf/rootfs.cpio.gz =



  * sleep.rtcwake-mem-2: https://kernelci.org/test/case/id/609b21c0d85d7d92=
45d08f21
        failing since 1 day (last pass: v5.12-rc8-168-g3c44d15e5ffdb, first=
 fail: v5.13-rc1-4-gdc9d574fa82fc)

    2021-05-12 00:28:26.771000+00:00  rtcwake: wakeup from \"mem\" using rt=
c0 at Wed May 12 00:28:33 2021
    2021-05-12 00:28:26.781000+00:00  <6>[   82.303332] PM: suspend entry (=
deep)
    2021-05-12 00:28:26.787000+00:00  <6>[   82.309747] Filesystems sync: 0=
.000 seconds
    2021-05-12 00:28:26.800000+00:00  <6>[   82.317077] Freezing user space=
 processes ... (elapsed 0.001 seconds) done.
    2021-05-12 00:28:26.806000+00:00  <6>[   82.328413] OOM killer disabled.
    2021-05-12 00:28:27.211000+00:00  <6>[   82.334378] Freezing remaining =
freezable tasks ... =

    2021-05-12 00:28:27.219000+00:00  <3>[   82.731498] dwmmc_rockchip ff0c=
0000.mmc: Busy; trying anyway
    2021-05-12 00:28:27.733000+00:00  <3>[   83.248010] mmc_host mmc1: Time=
out sending command (cmd 0x202000 arg 0x0 status 0x80202000)
    2021-05-12 00:28:27.739000+00:00  <6>[   83.259801] smsc95xx 2-1.1:1.0 =
eth0: Link is Down
    2021-05-12 00:28:27.749000+00:00  <6>[   83.267450] smsc95xx 2-1.1:1.0 =
eth0: hardware isn't capable of remote wakeup =

    ... (24 line(s) more)  =


  * sleep.rtcwake-mem-3: https://kernelci.org/test/case/id/609b21c0d85d7d92=
45d08f22
        failing since 1 day (last pass: v5.12-rc8-168-g3c44d15e5ffdb, first=
 fail: v5.13-rc1-4-gdc9d574fa82fc)

    2021-05-12 00:28:47.042000+00:00  rtcwake: wakeup from \"mem\" using rt=
c0 at Wed May 12 00:28:53 2021
    2021-05-12 00:28:47.055000+00:00  <6>[  102.575901] PM: suspend entry (=
deep)
    2021-05-12 00:28:47.066000+00:00  <6>[  102.586429] Filesystems sync: 0=
.000 seconds
    2021-05-12 00:28:47.080000+00:00  <6>[  102.597425] Freezing user space=
 processes ... (elapsed 0.001 seconds) done.
    2021-05-12 00:28:47.086000+00:00  <6>[  102.609328] OOM killer disabled.
    2021-05-12 00:28:48.856000+00:00  <6>[  102.615787] Freezing remaining =
freezable tasks ... =

    2021-05-12 00:28:48.872000+00:00  <3>[  104.376616] usb 2-1: device des=
criptor read/64, error -110
    2021-05-12 00:28:49.217000+00:00  <6>[  104.736620] usb 2-1: new high-s=
peed USB device number 5 using dwc2
    2021-05-12 00:28:54.537000+00:00  <3>[  110.056619] usb 2-1: device des=
criptor read/64, error -110
    2021-05-12 00:29:07.096000+00:00  <4>[  122.621923]  =

    ... (21 line(s) more)  =

 =20
