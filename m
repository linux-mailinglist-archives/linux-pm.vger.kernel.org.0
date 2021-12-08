Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF1846DB75
	for <lists+linux-pm@lfdr.de>; Wed,  8 Dec 2021 19:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239264AbhLHSry (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Dec 2021 13:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhLHSrx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Dec 2021 13:47:53 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB18C061746
        for <linux-pm@vger.kernel.org>; Wed,  8 Dec 2021 10:44:21 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 71so2825045pgb.4
        for <linux-pm@vger.kernel.org>; Wed, 08 Dec 2021 10:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=1TGy/xy7xbhEqCj701hTYswxxgXxk3dPMwxA/z1Apy0=;
        b=MsokQv8S2j2I9sdnMqxnvu+7xxRraFdmo4i7QFpb8e8YGAjNwQRgXWN8mXD6r8G3L2
         nwWeecpcXA0Wvv25Q0RtKack63EOCz7saviAQygr4t+eyUJDdKkJYWZIgrOCGmMMNqvg
         w5Qx58LUwJtXz+VcpM8TR8myIsEcQ1eMD8rN4tkRO5Unlgp9F5b5kXARDmCU4Su7WbnN
         00bllGdCswSgKmE5NSoqf1EfJoSfvb4pDUgZ/Yt3nmRlo4fLV8se6Rn2w/aODLr4gQP/
         oNAlx6+NxsQbbs7ZErkr4GJvQ+STFJkwSxxQ5g28cFBe4vM412pmlQk4p9DHXmwM4T9c
         QJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=1TGy/xy7xbhEqCj701hTYswxxgXxk3dPMwxA/z1Apy0=;
        b=UvaOgcNjbcKQ6Pn56VE2zvSFGW8earGAZKcahDeGo6xjjLyMuzoDFUsv0x6bxru35a
         Nxwn8f1XNB1M5o///aH2m6pEKJw6Xoo1IqwmUruZr2beWfELH2Ki/08I1VYo+KEYLZAu
         Aa7YY0avmTFsN7tQn+gRncdNDpcVR2W7SjfChwqW54kIm0cWWH7qKvOUl+Wzl97JF4Ge
         lEOihnZOpxnS5badsnAbSEN+jbI+xp45Ww7w8FSS2SAuqlrUdemIM03Sn0IvUUkxRAvf
         PKNpPm3CcM6t7gThCP2Rdj1ZSxweA0fjOSc9h+xJeTT0EbTQZmiOKPopGmurQgLKnZM+
         34XA==
X-Gm-Message-State: AOAM530CnG+XaHyagTzmOiDfJY3mb+V7uVxMb7jk+AbltAv2ZvttTDTL
        H/e+0ybTwoMUI5gjSxB5y5KhwA==
X-Google-Smtp-Source: ABdhPJy1ypuGp6+6lGMbkO5xtbu76X8HlBJUrR5GnjGoreQ52eGxyi5EWE1JGq8Jw9EZjU7485HplA==
X-Received: by 2002:a05:6a00:a82:b0:4ae:d8bb:a8e0 with SMTP id b2-20020a056a000a8200b004aed8bba8e0mr7107012pfl.28.1638989061189;
        Wed, 08 Dec 2021 10:44:21 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v38sm3183913pgl.38.2021.12.08.10.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 10:44:20 -0800 (PST)
Message-ID: <61b0fd04.1c69fb81.d0030.94c5@mx.google.com>
Date:   Wed, 08 Dec 2021 10:44:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.16-rc4-42-gc4f4801e994a
Subject: pm/testing sleep: 3 runs, 1 regressions (v5.16-rc4-42-gc4f4801e994a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 1 regressions (v5.16-rc4-42-gc4f4801e994a)

Regressions Summary
-------------------

platform            | arch | lab           | compiler | defconfig          =
| regressions
--------------------+------+---------------+----------+--------------------=
+------------
rk3288-rock2-square | arm  | lab-collabora | gcc-10   | multi_v7_defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.16-rc=
4-42-gc4f4801e994a/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.16-rc4-42-gc4f4801e994a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c4f4801e994a1697de4c30ac9afb749c396e1c2e =



Test Regressions
---------------- =



platform            | arch | lab           | compiler | defconfig          =
| regressions
--------------------+------+---------------+----------+--------------------=
+------------
rk3288-rock2-square | arm  | lab-collabora | gcc-10   | multi_v7_defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/61b0ef790f477d9f520737bc

  Results:     2 PASS, 11 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.16-rc4-42-gc4f48=
01e994a/arm/multi_v7_defconfig/gcc-10/lab-collabora/sleep-rk3288-rock2-squa=
re.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.16-rc4-42-gc4f48=
01e994a/arm/multi_v7_defconfig/gcc-10/lab-collabora/sleep-rk3288-rock2-squa=
re.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
211203.0/armhf/rootfs.cpio.gz =



  * sleep.rtcwake-mem-4: https://kernelci.org/test/case/id/61b0ef790f477d9f=
520737c5
        new failure (last pass: v5.16-rc4-36-g3a18d25cb836)

    2021-12-08T17:46:11.377926  rtcwake: assuming RTC uses UTC ...
    2021-12-08T17:46:11.425624  rtcwake: read rt<4>[   18.195069] rtc-hym85=
63 0-0051: no valid clock/calendar values available
    2021-12-08T17:46:11.426129  c time failed: Invalid argument
    2021-12-08T17:46:11.426874  _ID=3Drtcwake-mem-1 RESULT=3Dfail>
    2021-12-08T17:46:11.427215  rtcwake: assuming RTC uses UTC .<4>[   18.2=
28258] rtc-hym8563 0-0051: no valid clock/calendar values available
    2021-12-08T17:46:11.427553  ..
    2021-12-08T17:46:11.428442  rtcwake: read rtc time failed: Invalid argu=
ment
    2021-12-08T17:46:11.473744  L_TESTCASE TEST_CASE_ID=3Drtcwake-mem-2 RES=
ULT=3Dfail>
    2021-12-08T17:46:11.474313  rtcwake: assuming RTC uses UTC ...
    2021-12-08T17:46:11.474703  rtcwake: read rtc time failed: Invalid a<4>=
[   18.257103] rtc-hym8563 0-0051: no valid clock/calendar values available =

    ... (5 line(s) more)  =

 =20
