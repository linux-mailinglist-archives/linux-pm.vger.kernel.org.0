Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67633346F87
	for <lists+linux-pm@lfdr.de>; Wed, 24 Mar 2021 03:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhCXCa2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 22:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhCXCaB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 22:30:01 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8867DC061763
        for <linux-pm@vger.kernel.org>; Tue, 23 Mar 2021 19:30:01 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id h3so16253939pfr.12
        for <linux-pm@vger.kernel.org>; Tue, 23 Mar 2021 19:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=9Qt6tc8bi1FLSnrB9NtG7Cpi7vcbvnvsv8EaZqKHn40=;
        b=TjsCAIpl2Qxp/0ZEPhueXchl9bkrCn4DTrKH6fB6E9+fDiBk9mvLRz//ybPc4qmCv3
         +BrMF5i0HdcEu2AfMCYFWJAPQjiGsrVRanENSKy5cHEw0rx9QNwnu/bWpTeOJs1jOR64
         Qawzr1Pig6GcfW/W1DPQEVq0/dYz1sAxLN+MhbxfFYBhuyzpgHLk1jR82nSXBkfxm12+
         okfT0EpLEVTJa2Ey3c/0Wk3h6ZSD39QiuprUxWHwy2IUtd9SW2E8EDgKWUKu5nNXl7rC
         X/1wF7eKEyu4jRALPJTd9m6on//UAc+QT0lSU8MOeWKMIw8tlHjW+S/2ru6lEyXqYCBM
         Ljgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=9Qt6tc8bi1FLSnrB9NtG7Cpi7vcbvnvsv8EaZqKHn40=;
        b=g5seLPVlLHogTTjDIiZehx6uAIcRBnjARvCU4YJeeyPBaP62UJcu2DK8TflsbX+pEp
         Fnp5d13OCiA/7QIxTK1fGAKEN9LCA89VgMm8L9zpUP84FuW3v9MkvtMnAX5rKB4+2y4Y
         rMXXb4nNlUS57ReLW3kHuhiOzLi1i6BC841O7uJvkwmcRqyzBEGH4eprbnHkK3pf8fBB
         t6Dh39XYscVTzU95ZJZZdS6xNSs0xWxc49GvyLN+q6tPuf7BS7qYK5Ao9Z/VCB6SeGaN
         nUfXzz1wfWAbfFVk6xLHtRF1aUzDawmhDgcm19HNJF82ZbyrGI+FlVhYhU7AGqZsBaNd
         jc4A==
X-Gm-Message-State: AOAM533hpRYL96ARA1EWADuZoSl71EqxSPM+siMQiQJcTSiwK3sqmXji
        SKMF6H7Z5vQvzPWUwAZuuPSSow==
X-Google-Smtp-Source: ABdhPJwfKYwbmIr8gqs5W2JijOMHC9+E9uWRYNEG+kgUQEDevq4LiGFuITCwCmsknA1nuIH8m3VxHQ==
X-Received: by 2002:a63:1b55:: with SMTP id b21mr1093990pgm.38.1616553000794;
        Tue, 23 Mar 2021 19:30:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o19sm429597pgh.62.2021.03.23.19.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:30:00 -0700 (PDT)
Message-ID: <605aa428.1c69fb81.571c4.1ee7@mx.google.com>
Date:   Tue, 23 Mar 2021 19:30:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.12-rc4-41-g144389e954ef
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 3 runs, 1 regressions (v5.12-rc4-41-g144389e954ef)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 1 regressions (v5.12-rc4-41-g144389e954ef)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
4-41-g144389e954ef/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc4-41-g144389e954ef
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      144389e954ef1b556d4f192276f009158faecff7 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/605a970abb859b6325032d1b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc4-41-g14438=
9e954ef/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc4-41-g14438=
9e954ef/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0315.0/arm64/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/605a970abb859b6325032d1c
        failing since 216 days (last pass: v5.8-107-gb72b3ea38c81, first fa=
il: v5.9-rc1-4-g1f08d51cd57f) =

 =20
