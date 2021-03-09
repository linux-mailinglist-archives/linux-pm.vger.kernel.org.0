Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4824E331D4E
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 04:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhCIDG0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 22:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCIDGJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 22:06:09 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D70C06174A
        for <linux-pm@vger.kernel.org>; Mon,  8 Mar 2021 19:05:54 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id w34so6727625pga.8
        for <linux-pm@vger.kernel.org>; Mon, 08 Mar 2021 19:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=cm7nJAHrCq0btANObGTQxjDGJufMVgvUTCdeM5dQd5Q=;
        b=zsasfP/Edkt9z1xg3Bz1EqUjJ0S1iCpHYp29hsetZUeWADkV4fryPCuWtzS27xF2RU
         0BPO3nxtUQENEISsAEggs4aBeJi6CjzALat/jtcwXr/mIczCQAKm+PQq8dV7buku/fkw
         i/NouXjIhnKBTGRkVb+PHjG4l8orcBNdpCPtIU0epRxlLGkQevcwW5DOohTNIEUZM3Am
         lR2eKQ1E02c9wyQC3/iFWGHrknyJCSHZR/rZUG9fzNOAu20cvo3XK2oAWfsUSlBQ57Kt
         wUHaLWqclwsJHgZd8kNSSTZM6+mI+K138CvSwFbGvB9SUjmNN7abKWfrazyPaEwjCjnv
         Uqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=cm7nJAHrCq0btANObGTQxjDGJufMVgvUTCdeM5dQd5Q=;
        b=p7IlATgVaVGianp+LMfUJcUy7yRVyCAcsLTDhWFq1FbGygZfkzStH9HDj/Qf0bNaox
         B8ApbVe47B988K2UlnIlccsXhaztZVfEAyvKwHr29cl+M2HLNcdAZw1rHdYnnXWKX8QJ
         N8a5ZixXq1oeKfWVeuZjEKJeB10ohWkUD6s0a/0gurfEn67e6Xj3I7bGYw7OY5Zhlxei
         UqShRYCwV2FkrDvB+bgPLSxjTEiw5T+dVYeH1YEcpalv28RF2jC3LrPx17Ij49YpSUaI
         CfNfAaamwGTG+RWZuerGy/2+q0o3tnGAoMMup9FucUuHHI6/zWz2Bfmzz9Nq5Blo6PYh
         7dYQ==
X-Gm-Message-State: AOAM531l2FW+ece3so9ieRhZyRMZpGSSeN1vBy6NepTNj2BcBrxKDrSt
        zdPIUMCHQaIcZpyh+K0059HshUbmpWlzHL52
X-Google-Smtp-Source: ABdhPJxxmJ6MtQ7/66NJnuyKctsxOlYInBoONENBo2QSwjkgCmzEqo4QOno+HuQc426w76mPDTOgAQ==
X-Received: by 2002:a63:fd0a:: with SMTP id d10mr22852319pgh.345.1615259153646;
        Mon, 08 Mar 2021 19:05:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t5sm10646212pgl.89.2021.03.08.19.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 19:05:53 -0800 (PST)
Message-ID: <6046e611.1c69fb81.23441.b1e0@mx.google.com>
Date:   Mon, 08 Mar 2021 19:05:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc2-18-gf15befeb2bc3
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 1 runs, 1 regressions (v5.12-rc2-18-gf15befeb2bc3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 1 runs, 1 regressions (v5.12-rc2-18-gf15befeb2bc3)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
2-18-gf15befeb2bc3/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc2-18-gf15befeb2bc3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      f15befeb2bc3590b212cdec60241a25b78450bc4 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6046dbd5fda799b706addcc8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc2-18-gf15be=
feb2bc3/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc2-18-gf15be=
feb2bc3/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0301.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/6046dbd5fda799b706addcc9
        failing since 201 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
