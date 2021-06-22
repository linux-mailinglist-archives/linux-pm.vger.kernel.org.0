Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B363B05C4
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 15:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhFVN1j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 09:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhFVN1X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 09:27:23 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56126C061574
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 06:25:06 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id d12so2533259pgd.9
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 06:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=K+bHyzMLwOiQdCkvZqtrnb/eXQg8wD+ZOuILmE0TDaw=;
        b=cfza5T8VWuQrmFYCI1iK4OB3YuuTlmka5K8CyqTD72e0mguWUO5cvb5ls6Cvw0/GVE
         f349EFW98gT5sK3eoeGMyvJUAwoud8J4cUHTwRhOofclj8ZTFlneKU/lhwRRlwi04w9k
         PN1s9LUZsCxjYQPWj2KkP0386jwNuArqQsmj+0nx8ndefrekCV+UBywYMSkr7zuz4VtJ
         BWq+/a8ZJ0pnhOxnyEeCBiaW2mOX8zGI1LeTy0S9oJaB3JyZ+t2kXHjYyxIbhYEbpEPv
         ngW9a6BmS2Zc9N5G+NClga8gzKvcsXxF7SW+CPji6xE5VXChUY/Kg/egARvWuft37exd
         uXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=K+bHyzMLwOiQdCkvZqtrnb/eXQg8wD+ZOuILmE0TDaw=;
        b=AX8bTFhmyRVV+gdit+RbNjqfMPsJSv6dBnmnT+1t+WybQ7rNCeTszQgCw157gMiNuA
         l6RmUjcARU6ZNKdENxlS/15f4esclhHVC183+kioUM0bRZbKH5nz1f3N2pkaakUrtTUM
         ks/SHe9VQSiHQ9+sshDuYxFdoP/6bHeDQUAZhzyUANNxX9LhXprfgMx9Hpc8ApqDLdhl
         4KhHHIWmDba+ofXgSwh9NIEsDdXByC/w4HPnPFUUn3SUa9qaYA6Z+xGTc++E/P2o6zaE
         vMWMC/93lq7x5P3buPUUnYlSkQAMmhjOyaaJeUxpMuhpy7I1k0UYUhyUBpbFBn1/tesv
         BzDQ==
X-Gm-Message-State: AOAM533C/M+KbKLg6YZWzikik9Bc+1+UZCa3CQmZ0kxbb5bO1enCUvrV
        jvWMWE5SR0Vf4R4codsNYcLs7g==
X-Google-Smtp-Source: ABdhPJzLN+kbLX+EXcLozCBe3d2BMby1WcCiWoQNYbGThXkPK84ycBo+mnhyhpeB9A88MsHKHp0GiQ==
X-Received: by 2002:aa7:8e5a:0:b029:2e9:10d3:376f with SMTP id d26-20020aa78e5a0000b02902e910d3376fmr3697578pfr.19.1624368305867;
        Tue, 22 Jun 2021 06:25:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w7sm2456460pjy.11.2021.06.22.06.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 06:25:05 -0700 (PDT)
Message-ID: <60d1e4b1.1c69fb81.bb2d4.640a@mx.google.com>
Date:   Tue, 22 Jun 2021 06:25:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.13-rc7-145-g1b02478a82ab
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 3 runs, 1 regressions (v5.13-rc7-145-g1b02478a82ab)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 1 regressions (v5.13-rc7-145-g1b02478a82ab)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
7-145-g1b02478a82ab/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc7-145-g1b02478a82ab
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1b02478a82abb3950fbd9d64cf8c7d404ffe08d6 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60d1d784b6fe12f7eb413266

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc7-145-g1b02=
478a82ab/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc7-145-g1b02=
478a82ab/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/60d1d784b6fe12f7eb413267
        failing since 306 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
