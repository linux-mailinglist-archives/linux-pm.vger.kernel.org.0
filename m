Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F3235E6A6
	for <lists+linux-pm@lfdr.de>; Tue, 13 Apr 2021 20:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347712AbhDMSrD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Apr 2021 14:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347709AbhDMSrD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Apr 2021 14:47:03 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88674C061574
        for <linux-pm@vger.kernel.org>; Tue, 13 Apr 2021 11:46:43 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id em21-20020a17090b0155b029014e204a81e6so1737129pjb.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Apr 2021 11:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=xO8R2NXNqRkKkwuT6RktVmiBvNixwRl2F5ExNe7Jul8=;
        b=NI9c7nDlMbD52BLZhF1pW2C3ZLxwMXm2QPXamQekAgG869A5M1wjqBx+qcThRfBTor
         FHkQFR0N60sdpYyGRY3UEO2ZLDc/WJxusQm9QKU77C4tzb9FuUBLbRgTeFCMn8B4GIuF
         evtUndwZBZ4Q5JGLojT/2rTL5HsCM9aeN8IdnACxCX4zB6wfe+VZ1QN82gcHTDhhis0f
         ewX7cKyPQew0LpbNEhcwVkIMKG8MqYhWWQSrcSe+4TY5UbM19VXmJPrIj60sbXpj6C4/
         E6w5uqUTzuBkAI+66sUoxugE5ZIM4XWmbtY2N0BtTIjYT70GtXr9FZB3QX9F8XdymEf6
         KzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=xO8R2NXNqRkKkwuT6RktVmiBvNixwRl2F5ExNe7Jul8=;
        b=HaS/t/9e8NbW9j2IzmStpSeoJA1FleqFwKTootK4+mK5l35l4UsUWhVuMCqKLQOsy1
         EgPky2qSjvQdcRxZXysUmUJJOnRad5rHpiHnVpT3DgbN/Fcc4O7ibAwYH1rdtBGaHrmL
         sB7iicYtqYV9j0pOZwoKqsT3zN7cSNbfE9v9DG0o2089rakEhQnS4g55K/myLNBJui0d
         k/KJPd9zgTdZ2j0ja00LGrUkcCZNgvCDb8VXpGmcnVzyPxtqffUNwS4XY/JA3ONvd+ky
         qrDgXTWVqtO628+hKhTX908WEvq2pgT1MvxFerfAA4gKLO57L2ApS01+QBPMHkwjIt1N
         ZJZQ==
X-Gm-Message-State: AOAM531WcTA0TmrvghQCwu2B8bKG9Mn5QYByiUBVeXX1MsGrwB16ZxSa
        BeLkPMbJEwwnrK5mItEkajxveskDtTDwh8Xm
X-Google-Smtp-Source: ABdhPJyl3FCC1ymttde1EKlFD/+7iWltu4riMt+osFUdO2THRqCI6c4GW2y9GxH/UkcxcOxitD9BYg==
X-Received: by 2002:a17:90b:4005:: with SMTP id ie5mr1443307pjb.195.1618339603127;
        Tue, 13 Apr 2021 11:46:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f5sm1384210pfc.57.2021.04.13.11.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 11:46:42 -0700 (PDT)
Message-ID: <6075e712.1c69fb81.4f8f9.347e@mx.google.com>
Date:   Tue, 13 Apr 2021 11:46:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.12-rc7-158-gf0ad2a845d869
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 90 runs,
 1 regressions (v5.12-rc7-158-gf0ad2a845d869)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 90 runs, 1 regressions (v5.12-rc7-158-gf0ad2a845d869)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
7-158-gf0ad2a845d869/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc7-158-gf0ad2a845d869
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      f0ad2a845d869594a16bab7da43c361f0cccce59 =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6075de9fb0a40f8b09dac6ce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc7-158-gf0ad=
2a845d869/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc7-158-gf0ad=
2a845d869/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6075de9fb0a40f8b09dac=
6cf
        failing since 12 days (last pass: v5.12-rc5-47-g506a524e05e2, first=
 fail: v5.12-rc5-47-g85f34ae663986) =

 =20
