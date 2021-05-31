Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C263969AB
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 00:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhEaWYD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 18:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhEaWYD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 18:24:03 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95B8C061574
        for <linux-pm@vger.kernel.org>; Mon, 31 May 2021 15:22:22 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 29so9224702pgu.11
        for <linux-pm@vger.kernel.org>; Mon, 31 May 2021 15:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=vm6bhNu4T/3GTxkRNzR4Wa+C+DEuL250MhuAuQW5/vs=;
        b=fLVkWZKgWkTVTestFaj9TDL6cjEFE6WoR0BH76ExWCViei0JfzurBId13Mue3dUudU
         2J9zARu9yzx6/98GGZhIwMowPdnDBt7JCPdQx2IUyW1OcSzzKwHtD5hLZml+t7a0F21s
         iDg3GQyUZPDw6Sn8YDF2KzFRNN0dF8CKqsjPLPYrQxWGRMx3+X4qPkk/C4uH/VOEZdSR
         eZyiWK6UrQ55y/aJBozhXAE4+ExHOTGjXSYzisDUlcraSb2bobhLKSR3R2RV98fx+aDN
         f3ya6EhRQdbcuh4XdgTMZZvkr8tDH5Wf4p5cuzH7sJycN7NMcYkgp+Pgv4Pk26QNP/ei
         bayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=vm6bhNu4T/3GTxkRNzR4Wa+C+DEuL250MhuAuQW5/vs=;
        b=l10by+3zIGP2GjcfsdccnmOdSuOsKIhyqYBCfFKGNJH4y0TYVG3aUvV7cnudznBtGS
         XzkDTB7u9gBiadZn5H6KVGjSzhQ3joanC8HEH753YYju6EFUdLEizKdjef9auHcEgGtc
         2qZklsSd0gYA1mVg1NCuEf7q32GxnJv01DgxIJeup74NqVhXW0QWSpoi7tIDmrinLtUJ
         W6ucCsV9c7WUxdSppynKNkG9V/+Yuaonnret0Ekmk2lKws8N96kFVCeFqu31owyJCMr/
         BN3ld4kBuZls0bcoYonIf6DnBaWuOZuj7eytU5fidzxXA8iGuQtTzoy8320tuyhZRj/O
         Zq5w==
X-Gm-Message-State: AOAM530HWOxguUxTbYyv9/jfOJ5CibYP2JrWeV1mFCzHzDJUbZ6ivboG
        H2a4fAkdo4k7i7dv9MAGHxVBgg==
X-Google-Smtp-Source: ABdhPJwZeYBHc0iAnyLQUcifZ1EJ1kxDffe6kT6nwyRi/7lgyKs0ARPabaiYLjziuPFWtbGb3TZThw==
X-Received: by 2002:a65:42ca:: with SMTP id l10mr5640747pgp.292.1622499742314;
        Mon, 31 May 2021 15:22:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u13sm7220076pga.64.2021.05.31.15.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 15:22:22 -0700 (PDT)
Message-ID: <60b5619e.1c69fb81.6b427.5bdf@mx.google.com>
Date:   Mon, 31 May 2021 15:22:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.13-rc4-36-g3931fd6facb6
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 5 runs, 3 regressions (v5.13-rc4-36-g3931fd6facb6)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 3 regressions (v5.13-rc4-36-g3931fd6facb6)

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
4-36-g3931fd6facb6/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc4-36-g3931fd6facb6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      3931fd6facb67570e97b861b6beb5a673c492fda =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
mt8173-elm-hana   | arm64 | lab-collabora | gcc-8    | defconfig          |=
 1          =


  Details:     https://kernelci.org/test/plan/id/60b554eaf98077cf63b3b014

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc4-36-g3931f=
d6facb6/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc4-36-g3931f=
d6facb6/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60b554eaf98077cf63b3b015
        failing since 285 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =



platform          | arch  | lab           | compiler | defconfig          |=
 regressions
------------------+-------+---------------+----------+--------------------+=
------------
rk3288-veyron-jaq | arm   | lab-collabora | gcc-8    | multi_v7_defconfig |=
 2          =


  Details:     https://kernelci.org/test/plan/id/60b557dfc7846101eeb3afab

  Results:     21 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc4-36-g3931f=
d6facb6/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-veyron-jaq.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc4-36-g3931f=
d6facb6/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-veyron-jaq.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/armhf/rootfs.cpio.gz =



  * sleep.rtcwake-mem-2: https://kernelci.org/test/case/id/60b557dfc7846101=
eeb3afb0
        failing since 20 days (last pass: v5.12-rc8-168-g3c44d15e5ffdb, fir=
st fail: v5.13-rc1-4-gdc9d574fa82fc)

    2021-05-31 21:38:22.336000+00:00  rtcwake: assuming RTC uses UTC ...
    2021-05-31 21:38:22.337000+00:00  <6>[   82.283824] smsc95xx 2-1.1:1.0 =
eth0: hardware isn't capable of remote wakeup
    2021-05-31 21:38:22.347000+00:00  rtcwake: wakeup from \"mem\" using rt=
c0 at Mon May 31 21:38:28 2021
    2021-05-31 21:38:22.348000+00:00  <6>[   82.301872] PM: suspend entry (=
deep)
    2021-05-31 21:38:22.354000+00:00  <6>[   82.308345] Filesystems sync: 0=
.000 seconds
    2021-05-31 21:38:22.366000+00:00  <6>[   82.316289] Freezing user space=
 processes ... (elapsed 0.001 seconds) done.
    2021-05-31 21:38:22.373000+00:00  <6>[   82.328701] OOM killer disabled.
    2021-05-31 21:38:22.621000+00:00  <6>[   82.335402] Freezing remaining =
freezable tasks ... =

    2021-05-31 21:38:22.645000+00:00  <6>[   82.574440] usb 2-1: new high-s=
peed USB device number 4 using dwc2
    2021-05-31 21:38:27.912000+00:00  <3>[   87.864499] usb 2-1: device des=
criptor read/64, error -110 =

    ... (22 line(s) more)  =


  * sleep.rtcwake-mem-3: https://kernelci.org/test/case/id/60b557dfc7846101=
eeb3afb1
        failing since 20 days (last pass: v5.12-rc8-168-g3c44d15e5ffdb, fir=
st fail: v5.13-rc1-4-gdc9d574fa82fc)

    2021-05-31 21:38:42.826000+00:00  rtcwake: wakeup from \"mem\" using rt=
c0 at Mon May 31 21:38:48 2021
    2021-05-31 21:38:42.838000+00:00  <6>[  102.793678] PM: suspend entry (=
deep)
    2021-05-31 21:38:42.852000+00:00  <6>[  102.806907] Filesystems sync: 0=
.000 seconds
    2021-05-31 21:38:42.871000+00:00  <6>[  102.821376] Freezing user space=
 processes ... (elapsed 0.001 seconds) done.
    2021-05-31 21:38:42.877000+00:00  <6>[  102.833227] OOM killer disabled.
    2021-05-31 21:38:43.430000+00:00  <6>[  102.839544] Freezing remaining =
freezable tasks ... =

    2021-05-31 21:38:43.453000+00:00  <3>[  103.384480] usb 2-1: device des=
criptor read/64, error -110
    2021-05-31 21:38:43.812000+00:00  <6>[  103.764436] usb 2-1: new high-s=
peed USB device number 5 using dwc2
    2021-05-31 21:38:49.111000+00:00  <3>[  109.064431] usb 2-1: device des=
criptor read/64, error -110
    2021-05-31 21:39:02.891000+00:00  <4>[  122.849330]  =

    ... (18 line(s) more)  =

 =20
