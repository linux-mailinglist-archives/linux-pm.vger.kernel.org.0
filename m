Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C004252273
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 23:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHYVFT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 17:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgHYVFT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 17:05:19 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94EAC061574
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 14:05:18 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g1so3886930pgm.9
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 14:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=iAainpUZO5gX4o0s2Jcjw3r67Vi+Z+iEnBtAwMCvpsE=;
        b=lw7V40CC4BpahdAXqOjEC7OzlNBXLNZsCF8OLVfdXUrIHjkli//AViERCIr5xkCtQg
         PHyYq6NBLW7HHqIAq0dniLvE2mQhbUk2Qo2H+JehPYIRtXs1KT9CNNrkJTslxWVpWJbF
         8gOk5zWJenckUe3S9goGlfrLDB+HoGG41M9FRILL9M/NZWzAAcIdnuC9Edq5iSyK8qD/
         pjrY+2/uCsLePSXCrZa0C8nC4Wwpg6uKkJcWGYuJI6cJqK7GA2LE/UeG0K2gk5rNKNzU
         PrR7EDA2o8CswA/ZMmNo8DjQFknO9LcDFwMGueNh0Iav/cCQzu04QawFF2cML5qBeGFH
         xlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=iAainpUZO5gX4o0s2Jcjw3r67Vi+Z+iEnBtAwMCvpsE=;
        b=nh7Dk58jPfsY3yCsHJmH1f/BM+6a+Wt65MIA7Zn3HuzLB4pXWL5yS1Hjf6+z5eE8VP
         StySy1euHMe+btnWrhSxZ0B3hm30xWtoelA+pMBvysHee8Y5gzBaiufJM/PVrf6UB82E
         36zer5BPLnnFut+KI1dlOxx4PHKVqMvqtYuuMc9NRd6oMoHVoHdgzthPx/gtXeDR1Afk
         lvWXMKRdDJIdR55Iayy8G7artsq0JWWYA462UZAJZahij7s1KCE6BRB2mZgVcnT23Ryj
         nnQ+JU0jaTfEYZGxwpZJ6IZTdtv5Z1xlchkUIWJ+3z45RNbqrK2EXM9ohsVpHXGh/O84
         rL3A==
X-Gm-Message-State: AOAM530up3X4NNWwfAAMSpQiIk7Sxf4pbFRirBL8SOGz74HEO+KoAAIn
        exIpkefJD8GQZIkKPBamDWLk0A==
X-Google-Smtp-Source: ABdhPJyP35rvw44un16hz7S+kWCdUO22NcL4c6gdt/hsC71ELNeW/shX4n21wCPt2l9Olczew/JTlQ==
X-Received: by 2002:a63:e615:: with SMTP id g21mr7857855pgh.404.1598389517326;
        Tue, 25 Aug 2020 14:05:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a12sm130985pfr.217.2020.08.25.14.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 14:05:16 -0700 (PDT)
Message-ID: <5f457d0c.1c69fb81.b5af9.0aee@mx.google.com>
Date:   Tue, 25 Aug 2020 14:05:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc2-12-g4958dfca3d0f
Subject: pm/testing sleep: 2 runs, 1 regressions (v5.9-rc2-12-g4958dfca3d0f)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 2 runs, 1 regressions (v5.9-rc2-12-g4958dfca3d0f)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc2=
-12-g4958dfca3d0f/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc2-12-g4958dfca3d0f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      4958dfca3d0f6a66ff603d8ffe5a8c232987cc21 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f456c56eda22fc2889fb451

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc2-12-g4958df=
ca3d0f/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc2-12-g4958df=
ca3d0f/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0821.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f456c56eda22fc2889fb452
      failing since 6 days (last pass: v5.8-107-gb72b3ea38c81, first fail: =
v5.9-rc1-4-g1f08d51cd57f)  =20
