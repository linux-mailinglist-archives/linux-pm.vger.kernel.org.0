Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D5C3922EE
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 00:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhEZWtp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 May 2021 18:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbhEZWto (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 May 2021 18:49:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F0BC061574
        for <linux-pm@vger.kernel.org>; Wed, 26 May 2021 15:48:12 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n8so1360024plf.7
        for <linux-pm@vger.kernel.org>; Wed, 26 May 2021 15:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Afc/SUdrSTfmvzdTe54bvzcu3Bwqig/2/GJVIoUQdBw=;
        b=piuyz++zAO+APcFOILGKnLGcnhRbUq/EeDOKAoq2sEbJxX42VyIZXZjANg2MoLwZQv
         LoXdVLudQsOXb3vBr4PVMHdnUmj1jZw/NHLrJSxY4+IVmhe0Wy8erft/yiV5UC+6fQYs
         5Y+oE2R3/B50/XBFs3kXkQ8CpdE9QKKsO0KTB6+N1ngH8oWs3v9cej4g5M8mAgTfGSM+
         PSKRkCzKy+XFji0ONMxZqdz6oMTW4104LnD4oB2nKF4RjezUzeckPKALWYOfM5N9CkXH
         wATILOtAAj+baJxL9YyZiPVyF0MneM+TGFa8wHfAr6VhNZyilHx47YFwR7SNoc9GyMhu
         T/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Afc/SUdrSTfmvzdTe54bvzcu3Bwqig/2/GJVIoUQdBw=;
        b=Xno5Y2/2aU/GHrQYZQeOXCVyxHvUW1P3fRo+ajUo4gJZeJONEsOlkR1HO3AbvRo0F7
         AOw5o2H6fjAKdci/mZSroe6V55gDYdjAPrlbTFauROPNyt55DXynOmkXXrv8b40KJZpy
         ze1ujFPagsztq4hzFX5F9IFZWOWTOy3mIWSzqWxtpB4AkXWMAYQDv4x9fLEEuXMaewN0
         rIdLJrkd8Qq4DcY6RMewbI8PnDWbJZ6QJlKxlPyMbH1hADf1qI3ttkRnM5VOjuvg9l1i
         NGECDNNst1fYRU7uFDvkDJKEY8SXaei/AG8pxYK7WnOQgtmiXR8AXqW67zO9NriqKbt/
         8bjw==
X-Gm-Message-State: AOAM530asqagn2PhTEy9VEz1ZyMm9PaSY5Sw1ueZTP0zOCONTeleRGRY
        qfcp5/cgop5sXnef+QSfu39mUA==
X-Google-Smtp-Source: ABdhPJwwdYhhUbu32eFb4TZ/+8gk9bN2dlBbiqEU9BBi5+JjlZEe/1WNcI8ItLgmR2IGaxrX41liQw==
X-Received: by 2002:a17:90a:6289:: with SMTP id d9mr513029pjj.84.1622069292107;
        Wed, 26 May 2021 15:48:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v18sm223481pff.90.2021.05.26.15.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 15:48:11 -0700 (PDT)
Message-ID: <60aed02b.1c69fb81.9d0da.14de@mx.google.com>
Date:   Wed, 26 May 2021 15:48:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.13-rc3-39-gb2864f8ca01d
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 4 runs, 5 regressions (v5.13-rc3-39-gb2864f8ca01d)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 5 regressions (v5.13-rc3-39-gb2864f8ca01d)

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


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
3-39-gb2864f8ca01d/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc3-39-gb2864f8ca01d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      b2864f8ca01d373c62bbfe71fa01695b039edbbf =



Test Regressions
---------------- =



platform            | arch  | lab           | compiler | defconfig         =
 | regressions
--------------------+-------+---------------+----------+-------------------=
-+------------
mt8173-elm-hana     | arm64 | lab-collabora | gcc-8    | defconfig         =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/60aec3846859218018b3b030

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc3-39-gb2864=
f8ca01d/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc3-39-gb2864=
f8ca01d/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0503.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60aec3846859218018b3b031
        failing since 280 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =



platform            | arch  | lab           | compiler | defconfig         =
 | regressions
--------------------+-------+---------------+----------+-------------------=
-+------------
rk3288-rock2-square | arm   | lab-collabora | gcc-8    | multi_v7_defconfig=
 | 4          =


  Details:     https://kernelci.org/test/plan/id/60aec1cc78d40df3b9b3afb7

  Results:     2 PASS, 14 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc3-39-gb2864=
f8ca01d/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squar=
e.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc3-39-gb2864=
f8ca01d/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squar=
e.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0503.0/armhf/rootfs.cpio.gz =



  * sleep.rtcwake-mem-1: https://kernelci.org/test/case/id/60aec1cc78d40df3=
b9b3afba
        new failure (last pass: v5.13-rc3-39-gb4a1c81b7736)

    2021-05-26 21:46:44.396000+00:00  rtcwake: read rtc time failed: Invali=
d argument
    2021-05-26 21:46:44.396000+00:00  <4>[   13.551361] rtc-hym8563 0-0051:=
 no valid clock/calendar values available
    2021-05-26 21:46:44.396000+00:00  rtcwake: assuming RTC uses UTC ...
    2021-05-26 21:46:44.396000+00:00  rtcwake: read rtc time failed<4>[   1=
3.567811] rtc-hym8563 0-0051: no valid clock/calendar values available
    2021-05-26 21:46:44.396000+00:00  : Invalid argument   =


  * sleep.rtcwake-mem-2: https://kernelci.org/test/case/id/60aec1cc78d40df3=
b9b3afbb
        new failure (last pass: v5.13-rc3-39-gb4a1c81b7736) =


  * sleep.rtcwake-mem-3: https://kernelci.org/test/case/id/60aec1cc78d40df3=
b9b3afbc
        new failure (last pass: v5.13-rc3-39-gb4a1c81b7736) =


  * sleep.rtcwake-mem-4: https://kernelci.org/test/case/id/60aec1cc78d40df3=
b9b3afbd
        new failure (last pass: v5.13-rc3-39-gb4a1c81b7736)

    2021-05-26 21:46:44.444000+00:00  rtcwake: <4>[   13.587913] rtc-hym856=
3 0-0051: no valid clock/calendar values available
    2021-05-26 21:46:44.445000+00:00  read rtc time failed: Invalid argument
    2021-05-26 21:46:44.445000+00:00  rtcwake: assuming RTC use<4>[   13.60=
8668] rtc-hym8563 0-0051: no valid clock/calendar values available
    2021-05-26 21:46:44.445000+00:00  s UTC ...
    2021-05-26 21:46:44.446000+00:00  rtcwake: read rtc time failed: Invali=
d argument   =

 =20
