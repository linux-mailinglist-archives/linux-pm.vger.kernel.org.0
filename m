Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADB245FC76
	for <lists+linux-pm@lfdr.de>; Sat, 27 Nov 2021 04:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351971AbhK0DwQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 22:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbhK0DuJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 22:50:09 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5390C061785
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 18:53:17 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id p17so9750798pgj.2
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 18:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=JuVD0cgEXZdk9ixA747TOCXsQrW5yD0rDIUGilUB4uA=;
        b=4njVfbX1CZoAHiDUhooB56gJJ2R5u6aXyG2axF7fM7kCDFikFCPHsh2cXtX8P7S4+8
         IO/5wzdxB1iSBC//BqWbAWw2PBldFfmwKZOm8dWKh/Udjc23BVLo33ESA1auuV76l8h+
         9H9prhudY1ntYMcXRhY44atgDudoWhS6fUypf1D8g7wxIFhdVikT1BV8rXI1PmBtmjlP
         DZ0UYwCtQCBug1iCaMjVZsirtBFcenrX9ILCRnIqcl23ZsxXW5TOlnnY8kjK5mcDYYqX
         fBP2Ht9OalYK5bb8uL8CoSOhE3PMiYvBWZQD4O7J6lo9XLt45DPvNiA/05qpbUBYCmCQ
         mk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=JuVD0cgEXZdk9ixA747TOCXsQrW5yD0rDIUGilUB4uA=;
        b=jZ7pkSDimozN0/GJjQkb6DASNj24vZWUTkeHR8b4/U0+BdLhzD8hUrZDhAHCLVxONt
         luzvZmh+Ub7nqJUbeJyM8fJHX+qjvoIu5Hsz2NBhkFLuiahS5U+ofp8wfPCRa52/o2Po
         H3k0kBIAMwWzhlbnCTGTMzRmPA29tUWJiMjD5brpznsn5HAd2MGLKRlD/8/CwQmlrsNe
         ofr6tw7Knf2jrCqm0cwqqfHPA4e1KYKa4zRyg+OSb1vtN7SkM0onuOQuKHXshqCwdAd2
         PQe1p9Q+/kDmBE8HiwkqL/PNmaQBrdAQejZtIQLZW1mFbc3m0Kwjg+JbSx9ZdrVMXAYs
         gOPg==
X-Gm-Message-State: AOAM532Nauk/8OD4M4a4UUtoOrVsPA3qfsZ78JC8+e7DoNSCvrDemQvm
        3YNcEEaZ9EffYkj1dNG7hgYNwmsLFS9ks6HN
X-Google-Smtp-Source: ABdhPJzDGtn9Gt1WFW24CcgT8fqQjCyZwQ3iT+uBktwKEUoiEdfyiZ/y0/nCkX8ZP5oXcUc0mKhWZQ==
X-Received: by 2002:a63:7c4f:: with SMTP id l15mr11128958pgn.310.1637981597351;
        Fri, 26 Nov 2021 18:53:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o7sm6093966pgq.59.2021.11.26.18.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 18:53:17 -0800 (PST)
Message-ID: <61a19d9d.1c69fb81.de5d4.1af4@mx.google.com>
Date:   Fri, 26 Nov 2021 18:53:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.16-rc2-31-g7975c7f139bb6
Subject: pm/testing baseline: 85 runs,
 1 regressions (v5.16-rc2-31-g7975c7f139bb6)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 85 runs, 1 regressions (v5.16-rc2-31-g7975c7f139bb6)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
bcm2711-rpi-4-b | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.16-rc=
2-31-g7975c7f139bb6/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.16-rc2-31-g7975c7f139bb6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      7975c7f139bb692861600c15d89034a24e467aa9 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
bcm2711-rpi-4-b | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/61a193a92a1115ae6118f6ef

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.16-rc2-31-g7975c=
7f139bb6/arm64/defconfig/gcc-10/lab-collabora/baseline-bcm2711-rpi-4-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.16-rc2-31-g7975c=
7f139bb6/arm64/defconfig/gcc-10/lab-collabora/baseline-bcm2711-rpi-4-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/61a193a92a1115ae6118f=
6f0
        new failure (last pass: v5.16-rc2-16-ga3f78507f993) =

 =20
