Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4382C46F1
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 18:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732930AbgKYRjl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 12:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732606AbgKYRjl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 12:39:41 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2526DC0613D4
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2020 09:39:41 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id e8so3020210pfh.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2020 09:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=pZx9XAvwUQ/qFSQkJ1vsumTGcbekvlGydYXlljVtAoE=;
        b=Mn5lVCYHpUbl5r8MCClcoQdx3xZ3vbA450b+Gs1MYHmFUb/1aHCDYfSr/F0N4D9nrj
         Uos4oSoQ4KHwesZbUOjEXeljbsLe28/MKFFMkcsdmgOrGDSg1lnFNDPp3QLLSLd3kw7M
         7vJQ9nUluu/fw41VmrmenKcjaPpQKdRZ6RA2ahwPSYmHoJgGDh1z1nARkaR0fjfmVU3w
         02wWXlb1RNGIhzQZ8x2SDUxgY5hoaS0dK3N1i3i0il8Ju16o3PhyDZPpGENRc+aYX32f
         Dm2xz6x8dq/I+6zkMpOITwku6bN/gWANczXjHG27mDlFvkiZ2rfP+21czbuk3JqdD08U
         Zfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=pZx9XAvwUQ/qFSQkJ1vsumTGcbekvlGydYXlljVtAoE=;
        b=HWqcrK3k7seONsi9utp+czo7c54nxg08ewvmA2wApRGogQ9MxtRJbwZTW/GSIUtvmP
         Rd9TX07ajVgfugr6ccpBRLnBGliTlySt/QBUHKQ1q6Uc6uor9MwyGEnnQynhEEqnoIaq
         WZH4Xx3+41/YL6S3vFPl4sal7Srz82gtjjyJVMxdCKUpRuStg/xU2ZdzpFh9i7K/AiLB
         q6v6PhYpT5Jjd8JQQqLwfqYJiMAaxq8bKvOwjIfKo/xCFG8f3a3VPWWjappFtYGA6UXg
         3bZTwGztzA8qygiEgWIG780+LsrmX59eKVZ4X/28kZib/BKqMcrju0swlxK5JDdMEQRU
         hO2A==
X-Gm-Message-State: AOAM5334leEi++qHBIuxAwYZCWKw+fR3UbFHtkO57xzOKsycSefJeD2J
        UnJI2gDJ/Q6Nd3kPlNik4ZLySA==
X-Google-Smtp-Source: ABdhPJwDGcbYe4fKmriMv13ec8LarmOIn815OVm/xDypikFsZIiiufT/eZ1aR7yIe8ZtkLnb7W5nbw==
X-Received: by 2002:a63:5564:: with SMTP id f36mr3948541pgm.153.1606325980757;
        Wed, 25 Nov 2020 09:39:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y24sm1085697pfe.42.2020.11.25.09.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 09:39:39 -0800 (PST)
Message-ID: <5fbe96db.1c69fb81.eb2cf.23d8@mx.google.com>
Date:   Wed, 25 Nov 2020 09:39:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc5-65-g0a1829d7eb6a
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 126 runs,
 1 regressions (v5.10-rc5-65-g0a1829d7eb6a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 126 runs, 1 regressions (v5.10-rc5-65-g0a1829d7eb6a)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
5-65-g0a1829d7eb6a/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc5-65-g0a1829d7eb6a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      0a1829d7eb6a677eea1b7173d6dd77ca5315a7b2 =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fbe8e1286ef909404c94cd1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc5-65-g0a182=
9d7eb6a/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc5-65-g0a182=
9d7eb6a/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fbe8e1286ef909404c94=
cd2
        new failure (last pass: v5.10-rc5-53-ga8cb5559d8098) =

 =20
