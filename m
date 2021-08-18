Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2933F0A66
	for <lists+linux-pm@lfdr.de>; Wed, 18 Aug 2021 19:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhHRRmU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Aug 2021 13:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhHRRmT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Aug 2021 13:42:19 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE380C061764
        for <linux-pm@vger.kernel.org>; Wed, 18 Aug 2021 10:41:44 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r2so3006014pgl.10
        for <linux-pm@vger.kernel.org>; Wed, 18 Aug 2021 10:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ga/GEJxH5BHPnvCHe5jv6DfHU5iRoG1LFm+60aWXgi8=;
        b=w5XczgOMWq7I46+6sAteo/YiaFdALensGI3Y6IzZPRLNesEr7c9JdhxZ87pXgLaZXv
         fxtWD1puxxg9ErcZtYr2fq1id0Zn/ZSSH6zisW1kZB7ruuXYUT2LQfOumnR6YwkffXXs
         vwbV625/2V4/z9GcpF/3/Tq7zTld3hIeQG3UuGiDCGtOUfbhXdXlcVgBzraMCKiPOJhp
         UkQujQgz/+hL/7Mtwgn7Z+ElVt5Ch89Y6JniGqSrdSlIQUGAuzL/zwH0qSy//7nrHvjA
         yAYqyRf4/bFGRAz70dAJeGApeecrYwMpI3NpbrCm6rIBrZ6QiEl1tbI6AVCxOn2Qrb9y
         UVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ga/GEJxH5BHPnvCHe5jv6DfHU5iRoG1LFm+60aWXgi8=;
        b=tI/AXZfpDCZmis1MB486Yds0b44cghuRgIUGEhUYezp7CTRbOdW7s6Pwqyd4rT4/hc
         6iA1IwvTgQnl+5aGP72xKTifEKfQMvYvSrlA3uFs+Uv3JmJhX1CfgGS3YXa3vy86HGZ5
         KOmv/Z9iQWTGIhtPF5zgUGzabYc7FwzRV7Ayn4i/1MMJ98X/R2dFxUjQcuQ61j09k3C3
         LyIUvXwrYcEQkSjfaqgVIV/7R9TmjYg+kJVe0pEBjCK/j2MXJnU/MW/h7043+yVo+KhY
         VthSzry7ZL5Fzhoa+vDPMdn6aiXGzbl20oKgd3+x1ub0MVFrEPGrO6hytHUz+b2zLP00
         dSqQ==
X-Gm-Message-State: AOAM531oK+1ftc0rP6NhtWeKpRo+cklvdSb6/QvM52oUwAHQHFBOnKHK
        OpGPjLlJ/3F4/KoWg/eNFVfAGQ==
X-Google-Smtp-Source: ABdhPJx05bJJnBHhf6JNaNittDE0fe7aolDAsV+ZEai9+XS8DhvmTGt4kxUr6wh/ACY5qIEKe13x8Q==
X-Received: by 2002:a63:e807:: with SMTP id s7mr9851305pgh.200.1629308504108;
        Wed, 18 Aug 2021 10:41:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l2sm379270pfc.157.2021.08.18.10.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 10:41:43 -0700 (PDT)
Message-ID: <611d4657.1c69fb81.de16a.18de@mx.google.com>
Date:   Wed, 18 Aug 2021 10:41:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.14-rc6-60-g10bc7fbefe3a
X-Kernelci-Report-Type: test
Subject: pm/testing sleep: 3 runs, 1 regressions (v5.14-rc6-60-g10bc7fbefe3a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 1 regressions (v5.14-rc6-60-g10bc7fbefe3a)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.14-rc=
6-60-g10bc7fbefe3a/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.14-rc6-60-g10bc7fbefe3a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      10bc7fbefe3a9ab4a8e7531752e200ceff5919c7 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/611d3aa74fa0fec001b1366c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc6-60-g10bc7=
fbefe3a/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc6-60-g10bc7=
fbefe3a/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0730.6/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/611d3aa74fa0fec001b1366d
        failing since 363 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
