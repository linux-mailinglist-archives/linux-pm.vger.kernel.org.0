Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D4B31FF8B
	for <lists+linux-pm@lfdr.de>; Fri, 19 Feb 2021 20:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBSTpC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Feb 2021 14:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBSTpB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2021 14:45:01 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3392CC061574
        for <linux-pm@vger.kernel.org>; Fri, 19 Feb 2021 11:44:21 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o38so5486486pgm.9
        for <linux-pm@vger.kernel.org>; Fri, 19 Feb 2021 11:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=gQLT+orF3JmWjsh3mE8lccCc7oyMnWdpo+VHMppPq9k=;
        b=1L/zpR/LTdjzuOIb2oOI77l7dwAz/XepxpDmaFozRE87a0AOPQzk/xYu3I9p2jHFf/
         9lZ6aFUPXi/tlRnznzijxF/CMFb3E1SPp5QqMBj930c7pdZfZjPLj70oPY75vWEpnEtJ
         Eh0DihkQ9JQW4It4QmrF1QUdWiZw8MxGAsZbe0gvniQSw4ZpOmkAOseMapgHZSA2JLW5
         DNRLToPSoq01W5wKmxQi2S9aJ+hr1u8IrnFNMMJGEaoVHGJrhhzMgAXMF5iZp6JJRzmF
         ZEvP4Ewm3C904r5f9ITa6ss3GxkrQv3K+9jxCuZiwYctg+OTqYpKAsCeUBSsZ4vqsE4Z
         siFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=gQLT+orF3JmWjsh3mE8lccCc7oyMnWdpo+VHMppPq9k=;
        b=T8cYpweU37D9PuAC445pG4qJcArzO2dRjyFDzGRLYPZO+TafeCCd7tKGSRfbBsqjaS
         xWZTqcQvgCJt6Pxalkd2YLJr2EimnQbX7P4LUxzRajKsONOTJRzRZMAEyhzX2RXqejD1
         AQ6xe3cQGpOevh4Sr4pEJYUknKfjSx/n5zRjw8eSHYGjsRQV14AuOANPAtOLSoo+Cc9A
         gaodPN1FFHtCY32SL9kfKO2jAT/S1uq3cTkGb+QdJyWSEijToJc5YE2BRReQzgTries7
         UJD72AfqvdQSAv8/nV9l/I86WskymgDMh3ShnQWzOUtN41Wxcf/ZKqJsvsqZW933IwJm
         jzcQ==
X-Gm-Message-State: AOAM530Nh21KdfhIWcQF0GFzpq/HKTivx4O+qpZkbb40wyTO3WKLsjLL
        KH4ieIUvMVV8dSCDBylsBWLhOgtP4cW3Tw==
X-Google-Smtp-Source: ABdhPJzdDqw8SfTP2vpFZHZoQqOOdCpkcM6FXQy1ai/U2wGSFfUWnVXXf1vuCz0UoUshXSFM2Ep9zg==
X-Received: by 2002:a65:648e:: with SMTP id e14mr9874638pgv.453.1613763860699;
        Fri, 19 Feb 2021 11:44:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t4sm10369982pfe.161.2021.02.19.11.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 11:44:20 -0800 (PST)
Message-ID: <60301514.1c69fb81.c83e.737c@mx.google.com>
Date:   Fri, 19 Feb 2021 11:44:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: pm-5.11-rc8-205-g4475f0291af9
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 7 runs,
 1 regressions (pm-5.11-rc8-205-g4475f0291af9)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 7 runs, 1 regressions (pm-5.11-rc8-205-g4475f0291af9)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-5.11-=
rc8-205-g4475f0291af9/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: pm-5.11-rc8-205-g4475f0291af9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      4475f0291af9a9a16535123a859e154e35ad2277 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/603008cd458c0c1d1aaddd0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.11-rc8-205-g44=
75f0291af9/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.11-rc8-205-g44=
75f0291af9/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0215.2/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/603008cd458c0c1d1aaddd0c
        failing since 184 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
