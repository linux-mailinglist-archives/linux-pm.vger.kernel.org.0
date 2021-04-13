Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E9035E6C1
	for <lists+linux-pm@lfdr.de>; Tue, 13 Apr 2021 21:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343540AbhDMTCC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Apr 2021 15:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245722AbhDMTCC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Apr 2021 15:02:02 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D26BC061574
        for <linux-pm@vger.kernel.org>; Tue, 13 Apr 2021 12:01:42 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id j7so3199570pgi.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Apr 2021 12:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=2RaDHGnElvgSsGoT7VxfU/bz+iwzbiqt/1J4UN+LTag=;
        b=Bjc0ayJlUV/orwGoBZbFbaneh+zBunj5RuRbfOg2vBZWL8FfmUZS9xr9cS7CGAqFtx
         39K/D4n72o5aXaKCS/+Z6UESjFl+dygTOr4/wFWmsA4IfNfmV9XOCebctJfMtPbEQyru
         F5BnqFxbGWgZIqtmY/90tQeebDRkxxUagGQoFxFaXTJCospVxUJl6LVpwYkmOw1isJR5
         VkGRXqZYa/+2iSgXzO0Qqr0zw2sd0q4oAK9uKBaArtxZ0UGsa9TWrKf4jLWHZ7XFETuD
         r4JKkLXAONLiOdyAl0il2I7a8Nqjrlj+UP6Mub8MvNKxgOnJKRCg6cpQlB9UDsLFA6jT
         iLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=2RaDHGnElvgSsGoT7VxfU/bz+iwzbiqt/1J4UN+LTag=;
        b=Q78cDKk1EBOAhH5VhMIavGf7G+64Q+Q6mKCv/1cuyoZDUi2RgZ2dqrdz6qR5ix+YPC
         9ueyrRR2BV+hqwbqvGRjjbwnUmKk8UvrTMFKL32RcgCtslsJk67SkShCXVT77xC2cPKE
         iU6VOz1dxVSUlnJzJMWwkby0Fj6E7GDhXtREZeCYNekavqg6G3Fzz+t0pw+RmgmFO8NV
         kG7Usi4b+p0tZjioNanyyiHLRBny/VMs81SKFa6K+iR+0iTYzuOKQ0xGXgXAsfn8Jz/P
         5lhWgabGneTWzDoql0JNxgObeanwI9DZmgDc6wopEB7kDsbqSXc/7PHK2z4daYneEeJ/
         5RcQ==
X-Gm-Message-State: AOAM533B28pVFxt2CTU/VTI/y6QSY15lxLO9rfqHnmQGmswt663XOWuN
        Z6DW8Nr1XMs+ZJSQs8CtFKQRng==
X-Google-Smtp-Source: ABdhPJz6BblngGDYFz7p2c2ripo98wIik31hsf02I+FgqtkMKb8TIUwlB6miwYeVOuI/xTRm5sl1Kw==
X-Received: by 2002:a65:5088:: with SMTP id r8mr33085199pgp.434.1618340502228;
        Tue, 13 Apr 2021 12:01:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ir3sm2920605pjb.42.2021.04.13.12.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 12:01:41 -0700 (PDT)
Message-ID: <6075ea95.1c69fb81.d2c21.8107@mx.google.com>
Date:   Tue, 13 Apr 2021 12:01:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.12-rc7-158-gf0ad2a845d869
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 4 runs, 5 regressions (v5.12-rc7-158-gf0ad2a845d869)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 5 regressions (v5.12-rc7-158-gf0ad2a845d869)

Regressions Summary
-------------------

platform            | arch  | lab           | compiler | defconfig         =
 | regressions
--------------------+-------+---------------+----------+-------------------=
-+------------
mt8173-elm-hana     | arm64 | lab-collabora | gcc-8    | defconfig         =
 | 1          =

rk3288-rock2-square | arm   | lab-collabora | gcc-8    | multi_v7_defconfig=
 | 4          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
7-158-gf0ad2a845d869/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc7-158-gf0ad2a845d869
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      f0ad2a845d869594a16bab7da43c361f0cccce59 =



Test Regressions
---------------- =



platform            | arch  | lab           | compiler | defconfig         =
 | regressions
--------------------+-------+---------------+----------+-------------------=
-+------------
mt8173-elm-hana     | arm64 | lab-collabora | gcc-8    | defconfig         =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6075dc9dbc037c4741dac6c3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc7-158-gf0ad=
2a845d869/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc7-158-gf0ad=
2a845d869/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0412.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/6075dc9dbc037c4741dac6c4
        failing since 236 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =



platform            | arch  | lab           | compiler | defconfig         =
 | regressions
--------------------+-------+---------------+----------+-------------------=
-+------------
rk3288-rock2-square | arm   | lab-collabora | gcc-8    | multi_v7_defconfig=
 | 4          =


  Details:     https://kernelci.org/test/plan/id/6075dd16d9625fdb5ddac6d3

  Results:     2 PASS, 14 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc7-158-gf0ad=
2a845d869/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squ=
are.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc7-158-gf0ad=
2a845d869/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squ=
are.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0412.0/armhf/rootfs.cpio.gz =



  * sleep.rtcwake-mem-1: https://kernelci.org/test/case/id/6075dd16d9625fdb=
5ddac6d6
        new failure (last pass: v5.12-rc7-154-g3bf8ef9db350)

    2021-04-13 18:03:55.249000+00:00  rtcwake: read rtc time failed: Invali=
d argument
    2021-04-13 18:03:55.292000+00:00  <4>[   19.520535] rtc-hym8563 0-0051:=
 no valid clock/calendar values available
    2021-04-13 18:03:55.294000+00:00  rtcwake: assuming RTC uses UTC ...
    2021-04-13 18:03:55.294000+00:00  rtcwake: read rtc time failed<4>[   1=
9.535522] rtc-hym8563 0-0051: no valid clock/calendar values available
    2021-04-13 18:03:55.295000+00:00  : Invalid argument   =


  * sleep.rtcwake-mem-2: https://kernelci.org/test/case/id/6075dd16d9625fdb=
5ddac6d7
        new failure (last pass: v5.12-rc7-154-g3bf8ef9db350) =


  * sleep.rtcwake-mem-3: https://kernelci.org/test/case/id/6075dd16d9625fdb=
5ddac6d8
        new failure (last pass: v5.12-rc7-154-g3bf8ef9db350) =


  * sleep.rtcwake-mem-4: https://kernelci.org/test/case/id/6075dd16d9625fdb=
5ddac6d9
        new failure (last pass: v5.12-rc7-154-g3bf8ef9db350)

    2021-04-13 18:03:55.296000+00:00  rtcwake: <4>[   19.557856] rtc-hym856=
3 0-0051: no valid clock/calendar values available
    2021-04-13 18:03:55.297000+00:00  read rtc time failed: Invalid argument
    2021-04-13 18:03:55.341000+00:00  rtcwake: assuming RTC use<4>[   19.57=
9342] rtc-hym8563 0-0051: no valid clock/calendar values available
    2021-04-13 18:03:55.342000+00:00  s UTC ...
    2021-04-13 18:03:55.342000+00:00  rtcwake: read rtc time failed: Invali=
d argument   =

 =20
