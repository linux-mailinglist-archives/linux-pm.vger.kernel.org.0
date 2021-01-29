Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2985E308EFA
	for <lists+linux-pm@lfdr.de>; Fri, 29 Jan 2021 22:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhA2VFW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Jan 2021 16:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhA2VFU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jan 2021 16:05:20 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F60C061574
        for <linux-pm@vger.kernel.org>; Fri, 29 Jan 2021 13:04:40 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id t29so6991738pfg.11
        for <linux-pm@vger.kernel.org>; Fri, 29 Jan 2021 13:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=GM8IjY54RAU+IQvFDoE1xqChtRnocFRdlIODav8FmxQ=;
        b=av1LbYeND/FQI/mRoP6gMLFSnxEYzmZ0mXhGuRh8t/THc6ldJdzkdCXEqbKLS7wvLd
         8eQkCJaKX//gTjb/ETAFTfpZJTd2u5BasnFZlRmQeSx9hyU8CeXC0lqrGsTVsoA9IzTz
         a8HMfk50omoI35YedOdGelMg9d+nsN6Ol1bIkmcBYZX+WEwdfZbaHDFylJZ5L+Dq6QbI
         pyApd3y96PMmHtjxujaEC2708RpVOSf3kniPg35zZkqFMF3kMRpGxp7ZdY4Zkbg+fTYm
         qcx4wOOC7qugjFewsGhV8cXTevaqZ+wZI+46zBX3wTUh0uzGZkDRe1elRzSSF3b1ADcN
         wkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=GM8IjY54RAU+IQvFDoE1xqChtRnocFRdlIODav8FmxQ=;
        b=kjG/B+ai464E7P0fxohDaLMkI7YQTjZPkMG/N1dE+9Twr2sNHo6V8YggHDoDvL8pii
         jtKENXSzvWmEQSyU1QGrqeKWzxJTtf1zZY4oFIFcH0cyT2HkJxPNJ1hbDIgG5NqRkagX
         pPMUCF7QPATnNUYvOU+lV1524n1fV/QavdUtyElthyQp3hGjjowooRma8LsJKy2r3T4N
         VwRlReT+Wuca4OI65dVZc1Qf3JXu0NqqmGqdHgLnYbeeG/oUqAYCaASeTeZzhZOwi95m
         IaDq7nlr9GrwzxwhFW4+aMPrzTvxhRQ+bUNDqM3gL3Kii/TE60ICTBLrFqbBTahzx2IC
         bgfw==
X-Gm-Message-State: AOAM531axB9AuAkANXH55ZCCLnBSWx6EQD26goMXAaq2C/QQz4NvdegI
        rN5b3gQ8q+3B9DlaWplfRhH5OA==
X-Google-Smtp-Source: ABdhPJy+klum2NejEQf1c+OhxU4KHAYB0biUuawq7tx+ZOJgis0yq6pj/VNzBPoc+pjrTs5USpUkvQ==
X-Received: by 2002:a62:8ccc:0:b029:1cb:1c6f:b77d with SMTP id m195-20020a628ccc0000b02901cb1c6fb77dmr716594pfd.74.1611954279651;
        Fri, 29 Jan 2021 13:04:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z11sm10552000pfk.97.2021.01.29.13.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 13:04:39 -0800 (PST)
Message-ID: <60147867.1c69fb81.2a769.9dea@mx.google.com>
Date:   Fri, 29 Jan 2021 13:04:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: pm-5.11-rc6-71-ge86d494782b7e
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 5 runs,
 1 regressions (pm-5.11-rc6-71-ge86d494782b7e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 1 regressions (pm-5.11-rc6-71-ge86d494782b7e)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-5.11-=
rc6-71-ge86d494782b7e/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: pm-5.11-rc6-71-ge86d494782b7e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      e86d494782b7e43504b343d37b88c5c1d7af9ff6 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60146c44ff3c248031d3e03b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.11-rc6-71-ge86=
d494782b7e/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.11-rc6-71-ge86=
d494782b7e/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0125.1/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60146c44ff3c248031d3e03c
        failing since 163 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
