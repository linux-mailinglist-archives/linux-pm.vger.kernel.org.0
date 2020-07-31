Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1482348D9
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 18:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgGaQBf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 12:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbgGaQBf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2020 12:01:35 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0195EC061574
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2020 09:01:35 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id j19so16242753pgm.11
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2020 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=4dShpcJgkk8syliJ2NOLvUxvSXqZTsnn9GWASpqDMUQ=;
        b=f9cI/vLqoACXnqiX1jOTF6YRbkqWCdOXWe6bvNF486513oRVZCHeM9MhsfjV1o+702
         r9P+r6WsyKDkWhcDwXcvEe/2jhHr5+UGbHeVk+oJ+sDNr+aTiF0pnBXoRYwdrldQmUit
         VEzySNMBuZWAiZ+wTP//F03Dzc9k/tkzBY/M6tqS/2SOookD7iKkfci6HWt1dx+oZ/3Z
         +TAHzjDpvlA6n3PWmuK43xruZ5Es5HXaAKD6gWWguvJ8DGCDTwC6kB0Apt3F1eAESL1P
         KrFm1F5l3loG41UEpepJlyJjjogQr/6i3VdfN99XEyGbBB5CSkU5AnpQeFy3oJGNhHAt
         1BFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=4dShpcJgkk8syliJ2NOLvUxvSXqZTsnn9GWASpqDMUQ=;
        b=iK+lcLA8Tk8DsskD3tsPSbPGC25XIfwTziVNKWxiUrlzvQOKYV3M2CcsSBh/7rc51m
         R/9a+wxffJnvlovBp2ti8fpUt4tukpuuzv7uvKqATeRvwJxhiJxd2JbwRiGnvZ9Wc+hl
         W410g9vu2i13pbnXwfIOvQrZzj+JAEtWP2v9GsDvNjsK9SPtR6rdYZV/SoCoGpM0u3mO
         gJR+rJZKiKH3aVRrJbmFlKCOkPDa5GpBsl5XI0v15GwPYQ6uhjhCgANRSzwfN206H2VO
         fCXxzvqpVtsIU3pdWcTVxCMP3m1JzSxS7iEmXLgjoN9ofRC0OJUk44eAcSbvzIt3/w9m
         Dp7Q==
X-Gm-Message-State: AOAM531ZSJKJOMqoMhafVhOI17Jyo9f02HaIDsYuZ2RLCsel66A/fOxM
        Zp2X9KXYLnNrGNlIYH7R58DpOQ==
X-Google-Smtp-Source: ABdhPJwkqqqg3L/SNn/RiyJD/OpRp6XYF1pE023Vwy6DsCin1UeaE9cgYE+oJbmDZBc/QxMCPRjzKA==
X-Received: by 2002:a62:27c4:: with SMTP id n187mr4079365pfn.208.1596211294312;
        Fri, 31 Jul 2020 09:01:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id fv21sm642684pjb.16.2020.07.31.09.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:01:33 -0700 (PDT)
Message-ID: <5f24405d.1c69fb81.dcb4f.12e8@mx.google.com>
Date:   Fri, 31 Jul 2020 09:01:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.8-rc7-109-g86ed8b05f597
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 122 runs,
 3 regressions (v5.8-rc7-109-g86ed8b05f597)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 122 runs, 3 regressions (v5.8-rc7-109-g86ed8b05f597)

Regressions Summary
-------------------

platform                 | arch | lab           | compiler | defconfig     =
     | results
-------------------------+------+---------------+----------+---------------=
-----+--------
exynos5422-odroidxu3     | arm  | lab-collabora | gcc-8    | multi_v7_defco=
nfig | 0/1    =

imx6q-var-dt6customboard | arm  | lab-baylibre  | gcc-8    | multi_v7_defco=
nfig | 3/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.8-rc7=
-109-g86ed8b05f597/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.8-rc7-109-g86ed8b05f597
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      86ed8b05f59717b20b75cd2a4a17cbd26788183a =



Test Regressions
---------------- =



platform                 | arch | lab           | compiler | defconfig     =
     | results
-------------------------+------+---------------+----------+---------------=
-----+--------
exynos5422-odroidxu3     | arm  | lab-collabora | gcc-8    | multi_v7_defco=
nfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f2438bf131b8bf50b52c22a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-rc7-109-g86ed8=
b05f597/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos5422-odro=
idxu3.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-rc7-109-g86ed8=
b05f597/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-exynos5422-odro=
idxu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.login: https://kernelci.org/test/case/id/5f2438bf131b8bf50b52c=
22b
      failing since 0 day (last pass: v5.8-rc7-94-g89beac5dc8d0, first fail=
: v5.8-rc7-107-g97987ea7f86a) =



platform                 | arch | lab           | compiler | defconfig     =
     | results
-------------------------+------+---------------+----------+---------------=
-----+--------
imx6q-var-dt6customboard | arm  | lab-baylibre  | gcc-8    | multi_v7_defco=
nfig | 3/5    =


  Details:     https://kernelci.org/test/plan/id/5f24349dc7162e7ef752c1af

  Results:     3 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-rc7-109-g86ed8=
b05f597/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-imx6q-var-dt6cus=
tomboard.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-rc7-109-g86ed8=
b05f597/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-imx6q-var-dt6cus=
tomboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05/armel/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f24349dc7162e7=
ef752c1b3
      new failure (last pass: v5.8-rc7-107-g97987ea7f86a)
      4 lines* baseline.dmesg.emerg: https://kernelci.org/test/case/id/5f24=
349dc7162e7ef752c1b4
      new failure (last pass: v5.8-rc7-107-g97987ea7f86a)
      54 lines =20
