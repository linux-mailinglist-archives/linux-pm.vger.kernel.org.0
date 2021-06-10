Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634203A343A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 21:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFJToX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 15:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFJToW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 15:44:22 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D73C061574
        for <linux-pm@vger.kernel.org>; Thu, 10 Jun 2021 12:42:26 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d16so2467081pfn.12
        for <linux-pm@vger.kernel.org>; Thu, 10 Jun 2021 12:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=eppMFaGyo0UT0Mda5SioM9CNGCurHnufke2XvJiWkSA=;
        b=YF3LB7hA3PhLB61VkHjGdwj1mMwLxYtrV62Sp46EUldHGYHJVnM+IGmSNVFi/vh+Q9
         ejWr0gxE3RBB8JHPrew5JiEiK0wkbCLDcvV0YoCS63IIAPQFCp8UmlhAvk3lxDPsFzdE
         1WOyEmrKauCcNT7XSqp3RCR4xOCNKh5t+G2SqdqcYP+PvD9hYTI8GcBK8zpygS6h25eo
         8aCZpJOZvxnojxyXcOPyJ9xqUWqZSHhaql0CgIbJ4A9zS6T4lWDnA5xbADYt7i9WKdEE
         JrgJN03xYi1QaDcBxDMYwJcHBLMS03XrLtK1Ec8vuyHT9J31TzeKpRvac2G8TodhMxiw
         V/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=eppMFaGyo0UT0Mda5SioM9CNGCurHnufke2XvJiWkSA=;
        b=lNjKvqg7X/5hiRsgo6f3h/FwqLBx/mSKpT9Tb4hYB+iuk+nQoutftFMqGHOjcCuz9+
         RYn3z7ju68zN65VOA5FG2KcNGqtnhjlDVa3vJALW8ynueOqZZD+vSFNpB+kcEtNWj6EQ
         D0t8Vs1IR7PLH1DFw16b4gqZTtoxgbemVRV3Iheb4/IC45i5IwOIi5Pl/OksTzWCJxuj
         SM2Ilt70G+zeyM0EnsSTIqMHlFUXEHV1PF5n5HePMFx8BcOU2cTzPcvV7XiglMXvyiw3
         unTY0QkIA2DqFQfFV89a/PdaW1hJwdI6oR3eDQ1E24aOb0/SLs4t6wk4y7S9cV32xh+a
         A6Wg==
X-Gm-Message-State: AOAM531WzbMeU3act7GUvmohc9KCTT1Zk3OWGCIh1l2N0T3SR4BWmIYW
        cr5BGjWDrgo1blh0stB56acTnw==
X-Google-Smtp-Source: ABdhPJy3f2sttcAUCYwDdw303Twsp/xDQ6BhXzcJWGnTMqexkhMFIYrJonQHvFtWywfjNmbaHPTMnw==
X-Received: by 2002:a62:2bc6:0:b029:2e7:a7c2:201 with SMTP id r189-20020a622bc60000b02902e7a7c20201mr4554090pfr.64.1623354145929;
        Thu, 10 Jun 2021 12:42:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 65sm3189819pfu.159.2021.06.10.12.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 12:42:25 -0700 (PDT)
Message-ID: <60c26b21.1c69fb81.c5beb.9c66@mx.google.com>
Date:   Thu, 10 Jun 2021 12:42:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.13-rc5-103-ga72d57d38055
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 3 runs, 2 regressions (v5.13-rc5-103-ga72d57d38055)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 2 regressions (v5.13-rc5-103-ga72d57d38055)

Regressions Summary
-------------------

platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | =
2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
5-103-ga72d57d38055/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc5-103-ga72d57d38055
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a72d57d38055f31e713e57d59999b04027b74e0d =



Test Regressions
---------------- =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | =
2          =


  Details:     https://kernelci.org/test/plan/id/60c269746e6f8082fe0c0e10

  Results:     21 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc5-103-ga72d=
57d38055/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-veyron-jaq=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc5-103-ga72d=
57d38055/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-veyron-jaq=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/armhf/rootfs.cpio.gz =



  * sleep.rtcwake-mem-2: https://kernelci.org/test/case/id/60c269746e6f8082=
fe0c0e15
        failing since 30 days (last pass: v5.12-rc8-168-g3c44d15e5ffdb, fir=
st fail: v5.13-rc1-4-gdc9d574fa82fc)

    2021-06-10 19:32:46.372000+00:00  rtcwake: wakeup from \"mem\" using rt=
c0 at Thu Jun 10 19:32:53 2021
    2021-06-10 19:32:46.382000+00:00  <6>[   82.112733] PM: suspend entry (=
deep)
    2021-06-10 19:32:46.393000+00:00  <6>[   82.122593] Filesystems sync: 0=
.000 seconds
    2021-06-10 19:32:46.408000+00:00  <6>[   82.133440] Freezing user space=
 processes ... (elapsed 0.001 seconds) done.
    2021-06-10 19:32:46.415000+00:00  <6>[   82.145918] OOM killer disabled.
    2021-06-10 19:32:46.668000+00:00  <6>[   82.152984] Freezing remaining =
freezable tasks ... =

    2021-06-10 19:32:46.689000+00:00  <6>[   82.396629] usb 2-1: new high-s=
peed USB device number 4 using dwc2
    2021-06-10 19:32:51.929000+00:00  <3>[   87.656629] usb 2-1: device des=
criptor read/64, error -110
    2021-06-10 19:33:06.429000+00:00  <4>[  102.161893] =

    2021-06-10 19:33:06.454000+00:00  <3>[  102.177856] Freezing of tasks f=
ailed after 20.008 seconds (0 tasks refusing to freeze, wq_busy=3D1): =

    ... (21 line(s) more)  =


  * sleep.rtcwake-mem-3: https://kernelci.org/test/case/id/60c269746e6f8082=
fe0c0e16
        failing since 30 days (last pass: v5.12-rc8-168-g3c44d15e5ffdb, fir=
st fail: v5.13-rc1-4-gdc9d574fa82fc)

    2021-06-10 19:33:06.671000+00:00  rtcwake: wakeup from \"mem\" using rt=
c0 at Thu Jun 10 19:33:13 2021
    2021-06-10 19:33:06.681000+00:00  <6>[  102.411482] PM: suspend entry (=
deep)
    2021-06-10 19:33:06.704000+00:00  <6>[  102.433445] Filesystems sync: 0=
.000 seconds
    2021-06-10 19:33:06.732000+00:00  <6>[  102.457173] Freezing user space=
 processes ... (elapsed 0.001 seconds) done.
    2021-06-10 19:33:06.738000+00:00  <6>[  102.468908] OOM killer disabled.
    2021-06-10 19:33:07.448000+00:00  <6>[  102.474937] Freezing remaining =
freezable tasks ... =

    2021-06-10 19:33:07.472000+00:00  <3>[  103.176635] usb 2-1: device des=
criptor read/64, error -110
    2021-06-10 19:33:07.829000+00:00  <6>[  103.556635] usb 2-1: new high-s=
peed USB device number 5 using dwc2
    2021-06-10 19:33:13.129000+00:00  <3>[  108.856684] usb 2-1: device des=
criptor read/64, error -110
    2021-06-10 19:33:26.748000+00:00  <4>[  122.480262]  =

    ... (22 line(s) more)  =

 =20
