Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050D935F9B2
	for <lists+linux-pm@lfdr.de>; Wed, 14 Apr 2021 19:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349746AbhDNRVK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Apr 2021 13:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbhDNRVJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Apr 2021 13:21:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC64C061574
        for <linux-pm@vger.kernel.org>; Wed, 14 Apr 2021 10:20:47 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso11180071pjh.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Apr 2021 10:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=jsIbiMjJp3r45sgR3gjEdgXtrDk2HmDm7F9QLXmWizE=;
        b=PLc28h/0e1FlB1kEKZ47tPA/PBolk6Mw1jT/gQVRE5UR7Z8+nvx3q/fTlhdmldC4sg
         8HXZ1UKpaygZ9csBI0AN1OnsZi8jy48DryRDIOGy+RBb85IxveRMFqNuwON7M+kZTMHj
         p42Sb8+E6CL450EMfu57/izWaZnpmCyvXZcYvU7Wj2XKjs1FNhrO8O6WmYXZnSxLrENP
         f/O9Tay3JMSpJG8Xgk7IkQX39PjpGGeMrlhfe256zO1pb5I3H8FnM6hWPaZS4J2VdUFq
         JCn0bUVQfda6EI3YXwkW64pAlMqbraR7YhFGYXv8mxKRjGcAuYP3vuZ6rZwyKIjnxL7f
         1FsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=jsIbiMjJp3r45sgR3gjEdgXtrDk2HmDm7F9QLXmWizE=;
        b=RNkL8QtWuGXdwejz6XOQO0N8r9P/DpgedFxEzbH4lPR9x1w4dNlTuHccOb5uI4EPwU
         a2Zg2DX5ZH7ovkkMgCHOtg9BCqPBLWFeRgWf1CXxdyW6KUTRDnmrN5Z4e7FbJKwyJ25L
         EtJGDPYXqMDMppFOdyC3X5JYmo9T2w5hSR7g+h/98zvAa0fPwSw54o/OvwOfgln8mHop
         2ynho6d81pQjwuMC9kUsypTN9OcdVT47rXVsUi9PfmgBjCih4eP5CMAy+fV8dJjRE0um
         GikmU1ZAEjycCCd+d8xbV5KRykrIJbzgjLXGsXRUt3btM+efbpAwkQsh6yIu6BggrKFo
         TBoQ==
X-Gm-Message-State: AOAM532Dyq3BTZEwCvyL57QcWpppbxTg7RJXQZIWTWskUOhWDmuMR38Y
        bG61xq30MASAaEnjLZ0j2ySZog==
X-Google-Smtp-Source: ABdhPJwWHGvUwdFB6LdpvcSA9ZLLe2WjCBMys7ob1hNQvc41MfVtjHMB8AlbD9ff2Pjby+Gn9KRRAw==
X-Received: by 2002:a17:90a:8b97:: with SMTP id z23mr4853736pjn.65.1618420847557;
        Wed, 14 Apr 2021 10:20:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r10sm56856pjf.5.2021.04.14.10.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 10:20:47 -0700 (PDT)
Message-ID: <6077246f.1c69fb81.a84de.03a7@mx.google.com>
Date:   Wed, 14 Apr 2021 10:20:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.12-rc7-162-ga5b1c231c4a84
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 6 runs, 1 regressions (v5.12-rc7-162-ga5b1c231c4a84)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 1 regressions (v5.12-rc7-162-ga5b1c231c4a84)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
7-162-ga5b1c231c4a84/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc7-162-ga5b1c231c4a84
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a5b1c231c4a84cae19849db076b8a56ffbc8a079 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/607717c1e04404bc71dac706

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc7-162-ga5b1=
c231c4a84/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc7-162-ga5b1=
c231c4a84/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0412.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/607717c1e04404bc71dac707
        failing since 237 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
