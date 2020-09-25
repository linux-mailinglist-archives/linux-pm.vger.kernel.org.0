Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFB92794EB
	for <lists+linux-pm@lfdr.de>; Sat, 26 Sep 2020 01:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgIYXps (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 19:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbgIYXpq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2020 19:45:46 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23D7C0613CE
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2020 16:45:46 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id o20so4727040pfp.11
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2020 16:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=GeFUscgmNAndklwzX2zhLs1ShzV0uQVSZhR30BSOfPo=;
        b=ERYAtzujdHbwKMcXcdqM88sXqIyzPIq9wicVapyHEJvJ32UmIKpXJv7+u7BVaUUSKU
         6oPHjJIJlZvxCf4MBWgayRE5VRkVyVEOzyCfmuSmqjRf/v5upv123ozHDK5RZztIHmS4
         liIMYI5kGgRyckubhhKpPQizGdMTgf6v2Orpr8L13hcgmHGYp24EpBiSodnhTBHSRIgF
         c0mlLPXYO0Lw7qQshIvNyFfo/Kmjr38JrvAEIHNjCAfwSr4j7JKppeCKBed9JipTAnR6
         S3csBFcXcpNHM3suDBrel3/clj/93vxukPgJZJwBR3FaPmYSM+JXei4mPQ6Uz5cmBWH0
         wZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=GeFUscgmNAndklwzX2zhLs1ShzV0uQVSZhR30BSOfPo=;
        b=StKP7EP5/Ij3/KsS+yVjrYlYhoXNvxXqccGGj/zKWcMTA1urI3P0pdNuOnaxz8wp3n
         EsrOWOVJLEF+80wQ59u9P7YdXbr0o0YOJGDAXlIxSocSUpvTuf6JWMhPyD90PzBvXm0i
         O/jAbeyIBoe+9jhoYU2lWSkoj4xx3auVJ9EIX6EVy1REKMMKBw5EP71AOmOEf+Qnw+sq
         2gk8xJc164DrZl15Ow1TexV6x80Ji9alJkcMuTfUyfYkU4z4ptSOB6vYf/YQc4rDt36R
         gjgvGI2uI3EwcP2GG0Q8AtvBVu3i3BnF6bKZkhSFPTbMzZqEr9+lYFAplAiiBHOE/sR5
         tKrQ==
X-Gm-Message-State: AOAM532hoagOIag1lAcD5Eqcj55jL2Lrp2YlNl3Y5F9l6TSXc3EHi2Ye
        XJ6hExFVpxGL5eL99tqSEEaxwA==
X-Google-Smtp-Source: ABdhPJyb+nYBxsb/XKhPoFjKMHXWjTUnJh5JdU/sfskxz1+CCb6pfnUfJh0tB1ci3uxvrrp3eltNjQ==
X-Received: by 2002:a63:5916:: with SMTP id n22mr963972pgb.375.1601077546339;
        Fri, 25 Sep 2020 16:45:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z7sm3676153pfj.75.2020.09.25.16.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:45:45 -0700 (PDT)
Message-ID: <5f6e8129.1c69fb81.81997.a7bf@mx.google.com>
Date:   Fri, 25 Sep 2020 16:45:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.9-rc6-48-g537658447367
Subject: pm/testing sleep: 5 runs, 1 regressions (v5.9-rc6-48-g537658447367)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 5 runs, 1 regressions (v5.9-rc6-48-g537658447367)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc6=
-48-g537658447367/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc6-48-g537658447367
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      537658447367fc0c4c1edf81958e10e7c63fceac =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f6e7453a80ad3ba01bf9ddf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc6-48-g537658=
447367/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc6-48-g537658=
447367/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0925.2/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f6e7453a80ad3ba01bf9de0
      failing since 37 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)  =20
