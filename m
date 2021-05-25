Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE2B3908A1
	for <lists+linux-pm@lfdr.de>; Tue, 25 May 2021 20:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhEYSPN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 May 2021 14:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhEYSPN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 May 2021 14:15:13 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB93C061574
        for <linux-pm@vger.kernel.org>; Tue, 25 May 2021 11:13:43 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso13668399pji.0
        for <linux-pm@vger.kernel.org>; Tue, 25 May 2021 11:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=YNu4X3LB0YGZ2t2v5aMm4AP0tFAsdcN6oo9YedEIif4=;
        b=0B9jCFV5tz/nD1moDjhPYlrNBBH/In/eFeKdtTDnrSdcTdr5lGP88Hj26KCGJPtMy8
         KUkDRoJHnI71x/P6yvfz0oBnNj1iF5z/WLkb4Nj92HFD0HU7PjuYyGT6VoTNcZm5+rjU
         RmKpR9g4QzRIr7qo/RRc5Zn/5U/ZcVVzfJyikfOjOeNrTeubm4CVlsVdQVxGp4uyxqdW
         M7K1N4mPAL5xnJ7lsesAaXfRXV0gXR7VIw2TPATsOeSGh3ciY9R5ogNY23Hu80rpAera
         9kfw8dLf7BckINzv89i2dlU1NMPI8unm9e2ZD02uwzKh3ujHTa4oVNSZAhF+jHi5uZRU
         Bm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=YNu4X3LB0YGZ2t2v5aMm4AP0tFAsdcN6oo9YedEIif4=;
        b=fgtmFRi48/AnHMQ7V4Mqm9Zyj/RpkSsznhIXTGVsI5d6jaE+DyGVYOQz3os0PXz7Ce
         3lOIOfPb0hDcJwinMGhOoVUbHk1TI/WPanCrpbZohaPKQA9US0hWTrFvZL7Yc+9IdYwx
         9UrsqMDn1g33LRN35AazRk43paped6SZ9+07Lc891xIIOZmcgS4vGoBrhpvtaqMShaql
         5bUEQLrM5gYIz+gXjSPMiza/G7rLk1Yv7Qoqfx2x7oeB5NGYBDjZTHZMyfqZyaN1GrYg
         rgKgGCmdcjnHftHHBvsyaMy5xXvEYyP/aCnNKK9t0onpOvxFsAYw5t6CXHzdMZdXOtzD
         ElvQ==
X-Gm-Message-State: AOAM530ma+IOExcht6v1hr4q8igtUNqzoRXYYWxpaI0sf0PBoRMSfZB3
        v+SLJ3tBLM+vU5bntHhhgql6/A==
X-Google-Smtp-Source: ABdhPJxttgWA7Gn4W1shjjF8WHzUwOLA9NApVdJStbHZgI66Z45qE/73yZPN+joQoGDVcD6eCUInQg==
X-Received: by 2002:a17:903:2308:b029:f6:5cd5:f126 with SMTP id d8-20020a1709032308b02900f65cd5f126mr27196438plh.58.1621966423259;
        Tue, 25 May 2021 11:13:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l126sm3662676pfl.16.2021.05.25.11.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 11:13:42 -0700 (PDT)
Message-ID: <60ad3e56.1c69fb81.c5c14.bb99@mx.google.com>
Date:   Tue, 25 May 2021 11:13:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.13-rc3-37-gbf15f94bdcd8
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 51 runs,
 1 regressions (v5.13-rc3-37-gbf15f94bdcd8)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 51 runs, 1 regressions (v5.13-rc3-37-gbf15f94bdcd8)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
3-37-gbf15f94bdcd8/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc3-37-gbf15f94bdcd8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      bf15f94bdcd8d77957c0649a2ea7e39705b699a1 =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60ad2f09d16cf8bdefb3af9b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc3-37-gbf15f=
94bdcd8/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc3-37-gbf15f=
94bdcd8/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60ad2f09d16cf8bdefb3a=
f9c
        new failure (last pass: v5.13-rc3-26-gc17108d7145e) =

 =20
