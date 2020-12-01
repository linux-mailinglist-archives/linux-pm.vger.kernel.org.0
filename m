Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE412CAB42
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 20:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392283AbgLATBU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 14:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392282AbgLATBU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2020 14:01:20 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4021DC0613CF
        for <linux-pm@vger.kernel.org>; Tue,  1 Dec 2020 11:00:40 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id b10so1726009pfo.4
        for <linux-pm@vger.kernel.org>; Tue, 01 Dec 2020 11:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=m9qmdws5NXJc8P9IC1SFFbr3nfUQwCMymUM8Kxdw1sg=;
        b=Jps53Cy1l9+pRixXtgahZbAKZ/m9NyzlMC92Vt9OmSovXK73VudixYadEDKTasf6VP
         hnPyvOunuN7+B63W7MG069nyClJozc2P/h/VQR4HtSotDQcnFh+9Q/ik5VYq9Xllhfj/
         k33USRfUJTY9hh0CQahI+6xxVLii1twDmMHWVwWAKksc1MxZY4Yml2jWQDSnThsP05UG
         tvWXigW+jpak+cO8jCuMBCZm/qdRcDUzRHQraz3hJYPj9VeMPk8NhQ/dFsIseeDIx2Bz
         HhANISZ/pcVkZufTHqz7bq1KlUxeYtx6bo22JzYtLKnN5Q7J7C0ruP0Tc/jlPCwOPzDQ
         M4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=m9qmdws5NXJc8P9IC1SFFbr3nfUQwCMymUM8Kxdw1sg=;
        b=cbkiR1NNlSXmkCgX0SsrYYkVTqr/pl2p4mCWoCgKJwotRDKJGjEhqTUm0GqRMKRnLs
         2IRZprHFZNE8C/YHtIfefohgjVgdG5PXajC4tT6WCM3nq8wUKtq1Qj43Oo/0t/SI3R4B
         TL395mo+ryLiyvR0ObigE4ikw5OV8NU+b7Po+kuX/g9ihiZ7/uuofinAKuNTHLFBFJbx
         UrDSt5Ql+O/YYdO3TP7QLCGAvBSdYDSZN/M/qyuKtnP8bKt4Uuq7S8G84WaEqb94zwnK
         dImAXnwjUzV0FT60xyYMrwqSSOAdTBwM8k/Idlwt0YnzN8X/ZOqcEGwNfs2FG+5MK/9J
         FfbQ==
X-Gm-Message-State: AOAM532D+3ex3wN7ki3g3AqImWxRRkLg1dJ5zeP9Ejm29koJZ/g9Iqes
        9hDMS0XTgxr9rTi4qwEs3ZuisKSzoQa6cQ==
X-Google-Smtp-Source: ABdhPJwTzthzwWwqQN0Ab6DjpVJ33k0VC+fIynDAQfTSLzadOXUnbs93VPEhr4eeqfUhdwzC9eDkeQ==
X-Received: by 2002:a63:2045:: with SMTP id r5mr3573674pgm.6.1606849239775;
        Tue, 01 Dec 2020 11:00:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b13sm341985pgr.59.2020.12.01.11.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:00:39 -0800 (PST)
Message-ID: <5fc692d7.1c69fb81.7847d.0c5d@mx.google.com>
Date:   Tue, 01 Dec 2020 11:00:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.10-rc6-78-gc6c91db76539e
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 121 runs,
 2 regressions (v5.10-rc6-78-gc6c91db76539e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 121 runs, 2 regressions (v5.10-rc6-78-gc6c91db76539e)

Regressions Summary
-------------------

platform       | arch  | lab          | compiler | defconfig | regressions
---------------+-------+--------------+----------+-----------+------------
imx8mp-evk     | arm64 | lab-nxp      | gcc-8    | defconfig | 1          =

meson-gxm-q200 | arm64 | lab-baylibre | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
6-78-gc6c91db76539e/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc6-78-gc6c91db76539e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c6c91db76539e729139e47085af40adf240800a4 =



Test Regressions
---------------- =



platform       | arch  | lab          | compiler | defconfig | regressions
---------------+-------+--------------+----------+-----------+------------
imx8mp-evk     | arm64 | lab-nxp      | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fc6882cd4c6b74f8ec94cc0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc6-78-gc6c91=
db76539e/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc6-78-gc6c91=
db76539e/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fc6882cd4c6b74f8ec94=
cc1
        new failure (last pass: pm-5.10-rc6-75-g735f7fba25ec) =

 =



platform       | arch  | lab          | compiler | defconfig | regressions
---------------+-------+--------------+----------+-----------+------------
meson-gxm-q200 | arm64 | lab-baylibre | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/5fc68e3818748ab6d7c94cb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc6-78-gc6c91=
db76539e/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc6-78-gc6c91=
db76539e/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fc68e3818748ab6d7c94=
cba
        new failure (last pass: pm-5.10-rc6-75-g735f7fba25ec) =

 =20
