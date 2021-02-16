Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB7531CDEC
	for <lists+linux-pm@lfdr.de>; Tue, 16 Feb 2021 17:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhBPQX0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Feb 2021 11:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhBPQXZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2021 11:23:25 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE1EC061574
        for <linux-pm@vger.kernel.org>; Tue, 16 Feb 2021 08:22:45 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id q20so6434223pfu.8
        for <linux-pm@vger.kernel.org>; Tue, 16 Feb 2021 08:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=fpk8JRQwHjPgZsLU239SDVUHwq3EuTyc8ZSCJh4viCo=;
        b=qRcarW4pl6k6Uh28tGZpWWXdREZK3Do1HbS7LG5Vpma67AxWugzZWoKaUx2NjH29E4
         GvFMHINizzTZe09TvlZVuxNqF3fQc/YImurT/scBzczUXdmdhzbB06lWh9NE3EIhowY4
         MLYDp4N/Mp7LF/UObtf+KSS1N8Ui3rFHapNakwL24EQMFsUDFBEVURcngwwhJnxPE+6E
         KWhnwFruU1NfZkUEVk+SfMTawvu63FyO4p5YTdnaXUlFMvluty3LgIRTNtBswL5x+FPB
         13NkySPkKRUcUlWp+rbSazmEMXcij/hP11lGtapKyuDa6AGBpPOKHBt3jo+fuBJM8Zcl
         CjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=fpk8JRQwHjPgZsLU239SDVUHwq3EuTyc8ZSCJh4viCo=;
        b=XVZauUNjm+cIPx0pxzeXCEb4wSKEKKQwmwPz3Q6z6bDX71JrTjZ+3NSjmd4YPanaNS
         dixzl7cIoiWtFwKw8sWxHusvyJvZyL3XNdQ61fIrzfby+y30ceXLAPBd5k/NbWuF8Caq
         icH4ahRtDosz+Se60eRnKgMqazsllP3UxekP7dIYRj/FACINiq15T1P29xAZo/th7WyF
         fdE9JpoqnDPWYiVx5Pz97nWyOw+xzYcA00FhdzmKNx6Be4ovKB/BieqplLnFsDvdvBBw
         SDLo92CHQeggweoFJSwMEaZsIVf3dDutbBP/eOEU3FuqCb+vnXWm/K1CdC8h5u5vB0aP
         uljg==
X-Gm-Message-State: AOAM533xM+/7pBsrDnHoYN/rZ/Mw/4HfA9FR469g3Ud2uKNbTkuNoftB
        QHbpsoJn5sS/1GEVLTVIoLegbw==
X-Google-Smtp-Source: ABdhPJz4gl+5z1LkzKOMRY/ewYlCsPp6wCVE8zHH6suo/jKYS701QwgBYqVGVGpmM9m5CvVhmfRAbw==
X-Received: by 2002:a62:75d1:0:b029:1e3:6598:a827 with SMTP id q200-20020a6275d10000b02901e36598a827mr20346429pfc.55.1613492564801;
        Tue, 16 Feb 2021 08:22:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t15sm3248985pjy.37.2021.02.16.08.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 08:22:44 -0800 (PST)
Message-ID: <602bf154.1c69fb81.c002b.7353@mx.google.com>
Date:   Tue, 16 Feb 2021 08:22:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: pm-5.11-rc8-155-g606a19484587
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 6 runs,
 1 regressions (pm-5.11-rc8-155-g606a19484587)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 6 runs, 1 regressions (pm-5.11-rc8-155-g606a19484587)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-5.11-=
rc8-155-g606a19484587/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: pm-5.11-rc8-155-g606a19484587
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      606a1948458764ff9a1ffa47a3d68749b9b93041 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/602be4ab61bd0d960faddcb7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.11-rc8-155-g60=
6a19484587/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.11-rc8-155-g60=
6a19484587/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0215.2/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/602be4ab61bd0d960faddcb8
        failing since 180 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
