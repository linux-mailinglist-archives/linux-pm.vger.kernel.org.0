Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078C13A1B10
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 18:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhFIQi1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 12:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhFIQi0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 12:38:26 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7395C061574
        for <linux-pm@vger.kernel.org>; Wed,  9 Jun 2021 09:36:16 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id k15so18790356pfp.6
        for <linux-pm@vger.kernel.org>; Wed, 09 Jun 2021 09:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=R5J1S80yVD5G4gNZBmtFdKV5m5KpEvGgEzzYXyGrC2U=;
        b=OepleFERi5thyFQULhpi7LD0b9riAoyhty2c/4eTbSevJEaFKQQZwU69h9SfmCUfWD
         L0A8JDuW+J/cFrrwPHHW+uyWBreWuDqgPgcmLPyOrEVKrdpbakAi0Ec2EABWujyrJSM0
         sR0UyZaa+Zmo7/CV8eVT6dRBNPtDxepjIZFWJ/22fy8k8tBHbeUrhquuFTmHMoE0jCa7
         079S51n0nbHrXzV+/HGyi37xvcwh+g90jk0PlmLsZYDCw61dafMnW91HA1EtCUO2kEon
         HW1NjIay27mNrmYji2vGllpcBWG+JpjicgMNkdfCgwxnA5Zo5EBYkbSjE1wLmmnBa6Tf
         XQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=R5J1S80yVD5G4gNZBmtFdKV5m5KpEvGgEzzYXyGrC2U=;
        b=OW3KD6ipkHcc7rKncl+EOq2tCkJaqlFRwJ4cyZVXhvYAGjnUsLr4EmMLUcLObwgN7x
         QWGBOD5FFZ4RhRX2l2/+HLxOHnMzrFoHdNm7lfBtq4os70J/X/FU9mSMP3QEbGSme599
         O0jsDZY8WgKc+ftPM/VRyp2436oBOBJyhBSHiN5c7OEClRNZB/bRyVG3uyvxuP87Jida
         G4O3H3cu8JoG+hw7LdAEO/Pw1aG0p/d5BDchnDK0MCRuFi5F2YazRWHdamocHYM5VEOE
         KwMF8j2CdMo5FHTrECKoiKVPc/EOce+cq8JDbqt9Aj/3JZJkNmHe4mhfqkPIeWjTSEmL
         WpCg==
X-Gm-Message-State: AOAM5335olmb/88MWav/WYDF3W2p0ug8Y9NZoKL77CsRYrt9d8Y+PlKz
        Z8KNtIPjbka2HiNsvLgRlF2grw==
X-Google-Smtp-Source: ABdhPJyb2khqdMwXfkBWSuzidLuc61WJUw4q3+lyF9Q4h8KvTvPUcOdXAfst8w2lIc1Zip6pqy0lVQ==
X-Received: by 2002:a63:1f57:: with SMTP id q23mr546723pgm.398.1623256576395;
        Wed, 09 Jun 2021 09:36:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u24sm119058pfm.200.2021.06.09.09.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:36:16 -0700 (PDT)
Message-ID: <60c0ee00.1c69fb81.3097.07fe@mx.google.com>
Date:   Wed, 09 Jun 2021 09:36:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.13-rc5-97-g6d0b2a5677ed
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 4 runs, 1 regressions (v5.13-rc5-97-g6d0b2a5677ed)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 1 regressions (v5.13-rc5-97-g6d0b2a5677ed)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
5-97-g6d0b2a5677ed/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc5-97-g6d0b2a5677ed
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      6d0b2a5677ed15cfa1b6ebe8206ddc621d078190 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60c0e076228eebf19e0c0e1a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc5-97-g6d0b2=
a5677ed/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc5-97-g6d0b2=
a5677ed/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60c0e076228eebf19e0c0e1b
        failing since 293 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
