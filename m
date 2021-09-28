Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21E641B27F
	for <lists+linux-pm@lfdr.de>; Tue, 28 Sep 2021 17:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241479AbhI1PCR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Sep 2021 11:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241478AbhI1PCH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Sep 2021 11:02:07 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF97C06161C
        for <linux-pm@vger.kernel.org>; Tue, 28 Sep 2021 08:00:27 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id u7so1323139pfg.13
        for <linux-pm@vger.kernel.org>; Tue, 28 Sep 2021 08:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=pjaX6v6m8TAg/YaS/RWxjLYhu6bfe3+4yF5r1qV3QM8=;
        b=vyile476z2NYOeb+yLhhVgUvlpuFqrCRsODfVy7crhZg0hVRAo5PkGwduQo+d80FP3
         J+u7aNZn6AQde7JY/tl9nNCKKQw2s9rPB3VuXu+u7IInC0GOB73RDGU8QWsQBcyqwiwd
         MVn0IdcMGudxnNRBTcre7WZ4qPZln0YEQM4buDqQFKBogcCswYHa3Z+RFHa+LlEW3mPz
         A1Vkl9jJJCmwcEnq0kVk8NEcCd69abB7Tg1nGDjPkXzIy6zp3zDN3U1h9IfOtWedn+/E
         Uhg/xJchPj1gAG4LcVKYCqqsTyILmojFhzml0KMrqs3mrQVcMIlxA6DLezzdaQCzwIty
         nzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=pjaX6v6m8TAg/YaS/RWxjLYhu6bfe3+4yF5r1qV3QM8=;
        b=krf3R1U5r9J2DJ3lFo7dm1YEIBfATRYiIOA94PAU5a1zCPukDNOXAfl8SiSh4g4MJq
         2uMfwUMyqBcfzfi5i5T6WEHQsIGYnMAehAMV7QmMjygNuyZ5Mb5CLaeQOXcKoeYE6CDp
         QZoRkUTQwk+cWxK3w3gsW6OdbFFLQXqV7Jon4vatcsRC5tM2hCzjHCuC5R3rQRdY+8Tp
         jPhXopWgtJB+2CkIUQKTyOS+IGUsnnF+vfH90QqAMRJlvZFQUlncZDEWPob141NmcYlq
         YIXtTmzmykesihUrFJK3YjK9nXu6V3RmbIDnJE5AIZcUMktj7WFdywamdzjBAvRRs2tw
         R6ZA==
X-Gm-Message-State: AOAM530PbuQI8Lt7J5Bslt6Yq4uVGhUwwWDzwr1O1b/aJptoHwbyZqQj
        n2nVo90SayEPcLj6A+9ZmBxRlw==
X-Google-Smtp-Source: ABdhPJyw4Nn31I+p572A9JPx9F5ZUVoBtYdLWUnAMxa9yTCAhynELAuPTAZsTX5mk8bL3kycFgRCbA==
X-Received: by 2002:a62:403:0:b0:433:9582:d449 with SMTP id 3-20020a620403000000b004339582d449mr5710778pfe.15.1632841226608;
        Tue, 28 Sep 2021 08:00:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o14sm21516720pfh.84.2021.09.28.08.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:00:26 -0700 (PDT)
Message-ID: <61532e0a.1c69fb81.c4d82.41f0@mx.google.com>
Date:   Tue, 28 Sep 2021 08:00:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc3-18-g7c86bb8dfc1b
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 64 runs,
 3 regressions (v5.15-rc3-18-g7c86bb8dfc1b)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 64 runs, 3 regressions (v5.15-rc3-18-g7c86bb8dfc1b)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
hip07-d05        | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 2        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
3-18-g7c86bb8dfc1b/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc3-18-g7c86bb8dfc1b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      7c86bb8dfc1ba1e8f6fef352555cf21a37ea2bc3 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
hip07-d05        | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/6153285e76ede86e4d99a2da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc3-18-g7c86b=
b8dfc1b/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc3-18-g7c86b=
b8dfc1b/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6153285e76ede86e4d99a=
2db
        failing since 89 days (last pass: pm-5.13-rc8-159-g3304616e985f, fi=
rst fail: devprop-5.13-rc8-173-ge132b9a1079c) =

 =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 2        =
  =


  Details:     https://kernelci.org/test/plan/id/6153252c88a51543c599a306

  Results:     89 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc3-18-g7c86b=
b8dfc1b/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc3-18-g7c86b=
b8dfc1b/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6153252c88a51543c599a30c
        failing since 77 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-09-28T14:22:19.603543  /lava-4594391/1/../bin/lava-test-case
    2021-09-28T14:22:19.614397  <8>[   52.457824] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6153252c88a51543c599a30d
        failing since 77 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-09-28T14:22:18.568340  /lava-4594391/1/../bin/lava-test-case
    2021-09-28T14:22:18.579806  <8>[   51.423406] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>   =

 =20
