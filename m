Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2209A48BE64
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jan 2022 06:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350902AbiALFjc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jan 2022 00:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbiALFjb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jan 2022 00:39:31 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C742C06173F
        for <linux-pm@vger.kernel.org>; Tue, 11 Jan 2022 21:39:31 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso9697865pjo.5
        for <linux-pm@vger.kernel.org>; Tue, 11 Jan 2022 21:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=R5hqfUsAPsrAcm5lTbdPCL6TjiAR9gBOlE2FBMp7Mvs=;
        b=htMfhVEWKSLTovh+4fMqYcqwYvnGKzp0CxNC3gTUF6pabrMAtQk9mTgtix4gKL4nFe
         w8LaP9SQ/d31ZRnJqAjoW69WqWufrPkEhYZcS141/4b4apSd3qz6zo6guIciCKdwIzyv
         8W3AhmCTX+2afkFIegCGZlZPrOvhOcZWlTMgVnVxXg9m9dSxRYs8LhJAlgX8a8FAt/wm
         09e0LNx4GMQoXfyqXWRG3GYGKB9EQQhA1AI0Nhhk+c6n2Ar5PONjkbf7QhW4bXrk5Ps8
         mkDl4z4fL0H/SaH2OX5J1FZJ9HwNBNhOih+onxAWBKY3H8MKuTmxhc3i6TeJ76wcBXBN
         xxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=R5hqfUsAPsrAcm5lTbdPCL6TjiAR9gBOlE2FBMp7Mvs=;
        b=OSYnv6XG6T0XexwoO+fal2T+DbJK2EVWgz4UCv82W2gX6fA6/LIJMuYIugrE48ZUi4
         8nEfsrWAMPgJISKGNz3mndeOMhRbhuNHZQBRTH/UsJDCAtsbGZsqcHUx88w0l/dV1RB5
         BiwG8UeniXbCeoaV4iEwSZUyaEBGBQ384Sky+mUQypZ8cN1zRugx1ESl1Oj41MXA+OXW
         lF80zF2s0AM2zdlj/DIzw6TsjJooceDOYovzCFLFX0d1VcHW9i22vHjjRsWQ3cNaHEvn
         7VgTXwu1tCNYcWGKUh98n9xYNxAMkZbG6fj0oxMzfKPlGxjb+YQxFIYOyHA9XpM6Uamc
         51bg==
X-Gm-Message-State: AOAM533yldr7oFmDCE0uuzke3rTlWragMjxP2ug0mqwE2nsnihmIQhP4
        O/oGu+88Mk29MIFbvBgI7Pi4cE1lXk4WyjBh
X-Google-Smtp-Source: ABdhPJx8CQwHeV4aeP/FmZWa/vMFIx+pKzMGAC2yFnPzFSm1aTbaXS9nood/LyeysIaxPjiBQpgDTg==
X-Received: by 2002:a17:902:70c7:b0:149:d966:789d with SMTP id l7-20020a17090270c700b00149d966789dmr7800177plt.164.1641965971022;
        Tue, 11 Jan 2022 21:39:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j16sm13399739pfj.16.2022.01.11.21.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 21:39:30 -0800 (PST)
Message-ID: <61de6992.1c69fb81.62cde.19b0@mx.google.com>
Date:   Tue, 11 Jan 2022 21:39:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.16-rc8-173-g00759929cccb
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 4 runs, 5 regressions (v5.16-rc8-173-g00759929cccb)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 5 regressions (v5.16-rc8-173-g00759929cccb)

Regressions Summary
-------------------

platform            | arch | lab           | compiler | defconfig          =
| regressions
--------------------+------+---------------+----------+--------------------=
+------------
rk3288-rock2-square | arm  | lab-collabora | gcc-10   | multi_v7_defconfig =
| 5          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.16-rc=
8-173-g00759929cccb/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.16-rc8-173-g00759929cccb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      00759929cccbf2e508326f2d9139ca708195d8f1 =



Test Regressions
---------------- =



platform            | arch | lab           | compiler | defconfig          =
| regressions
--------------------+------+---------------+----------+--------------------=
+------------
rk3288-rock2-square | arm  | lab-collabora | gcc-10   | multi_v7_defconfig =
| 5          =


  Details:     https://kernelci.org/test/plan/id/61de5c3047938d481eef676f

  Results:     2 PASS, 16 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.16-rc8-173-g0075=
9929cccb/arm/multi_v7_defconfig/gcc-10/lab-collabora/sleep-rk3288-rock2-squ=
are.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.16-rc8-173-g0075=
9929cccb/arm/multi_v7_defconfig/gcc-10/lab-collabora/sleep-rk3288-rock2-squ=
are.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
211224.1/armhf/rootfs.cpio.gz =



  * sleep.rtcwake-mem-5: https://kernelci.org/test/case/id/61de5c3047938d48=
1eef677c
        new failure (last pass: v5.16-rc8-171-gf099fd60c342) =


  * sleep.rtcwake-mem-4: https://kernelci.org/test/case/id/61de5c3047938d48=
1eef677d
        new failure (last pass: v5.16-rc8-171-gf099fd60c342)

    2022-01-12T04:42:11.551880  rtcwake: ass<4>[   14.779011] rtc-hym8563 0=
-0051: no valid clock/calendar values available
    2022-01-12T04:42:11.552236  uming RTC uses UTC ...
    2022-01-12T04:42:11.597129  rtcwake: read rtc time failed: Invalid a<4>=
[   14.798591] rtc-hym8563 0-0051: no valid clock/calendar values available
    2022-01-12T04:42:11.597658  rgument
    2022-01-12T04:42:11.598527  rtcwake: assuming RTC uses UTC ...
    2022-01-12T04:42:11.598908  rtcwake: read rtc ti<4>[   14.813278] rtc-h=
ym8563 0-0051: no valid clock/calendar values available
    2022-01-12T04:42:11.599280  me failed: Invalid argument   =


  * sleep.rtcwake-mem-3: https://kernelci.org/test/case/id/61de5c3047938d48=
1eef677e
        new failure (last pass: v5.16-rc8-171-gf099fd60c342) =


  * sleep.rtcwake-mem-2: https://kernelci.org/test/case/id/61de5c3047938d48=
1eef677f
        new failure (last pass: v5.16-rc8-171-gf099fd60c342)

    2022-01-12T04:42:11.504813  rtcwake: assuming RTC uses UTC ...
    2022-01-12T04:42:11.548958  rtcwake: read rt<4>[   14.739837] rtc-hym85=
63 0-0051: no valid clock/calendar values available
    2022-01-12T04:42:11.549515  c time failed: Invalid argument
    2022-01-12T04:42:11.550414  rtcwake: assuming RTC uses UTC .<4>[   14.7=
58687] rtc-hym8563 0-0051: no valid clock/calendar values available
    2022-01-12T04:42:11.550798  ..
    2022-01-12T04:42:11.551167  rtcwake: read rtc time failed: Invalid argu=
ment   =


  * sleep.rtcwake-mem-1: https://kernelci.org/test/case/id/61de5c3047938d48=
1eef6780
        new failure (last pass: v5.16-rc8-171-gf099fd60c342) =

 =20
