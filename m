Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF65C3B0581
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 15:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFVNMY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 09:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhFVNMX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 09:12:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D44C061574
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 06:10:06 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id k6so16336329pfk.12
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 06:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=IRpo+nl4/PEnVRh+QFVwie68i84D3hgs/w55oIX8OA8=;
        b=1Lsz75z6Dr2H6IuFV1tJP8Fvu1HecCOiAbk7oltA9yL0/oRLb1oPr+qxltQwKdb8/e
         5dl3DfoPnt6qb5X4Tjah7v1YTPf7nbBgAKO23ZHF+xZl7Sj99UV1IG9zOyLU79lQWkHU
         6rQP5saBrdttSQinYz2eUxmlQ12KTXZNLeWvF5vjdEkWL7a2SRDQHP5uyb0hqdp8WuRy
         6BtZ2wyg50aRxtISmUaX89bPlqezyAWtZw72G2s9f+hfBbnee9MnWpFP9kmXqRVRfmAi
         DtC0TDDLvma2aayiY2L0RhTRoutjICdf1iWFn+XmfozRvEUukFlW9SPdB828sPors8O9
         65XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=IRpo+nl4/PEnVRh+QFVwie68i84D3hgs/w55oIX8OA8=;
        b=TA7PJUU/hUOPmtKHOWMUsc61S3B0TZLFqZ42r2aJv3PPfUV4he5aPptUDr/eQ1fq14
         /hhW2S8GqxrzTkhOIlsqSrrNma8iimbcT5Zf1mx8p6w89NqrcHQUVNqHPbwMQXW8pYPl
         riXlWSl57QaW3agKG69xQ+01ESSOvy8TLRhJ+smD9nWSyOyGCJycsTM/nQPX5hh2aupv
         4S+whUILa6BrVv9ynSxtm7MyMx16vHNNL+/JwWaXkXbjyNAHsv0HNfKFCIfpvMW1kuZU
         GpWX8hRN9VmsWEs82jd5zS/2tJl98WAvi+HOf81lc7qsBA9IpRqs2uHTmavdltyks6hE
         FogQ==
X-Gm-Message-State: AOAM532+1FzFq20ua9ycKj1CRrw4Dbs+qvpotcAvchZyysyul+IEzLis
        6hAvLrnNJuOnOG5w/Qtb81tjUg==
X-Google-Smtp-Source: ABdhPJyvClvc/w2VbCsguSNzLBeWc8N7wSVBl0/iruV4Wq6ygSKVXObPvsCbWGKXAJzJqPU+KhQeqQ==
X-Received: by 2002:a65:6a45:: with SMTP id o5mr3732336pgu.409.1624367406323;
        Tue, 22 Jun 2021 06:10:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w20sm10949902pff.90.2021.06.22.06.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 06:10:05 -0700 (PDT)
Message-ID: <60d1e12d.1c69fb81.9adc.ba30@mx.google.com>
Date:   Tue, 22 Jun 2021 06:10:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.13-rc7-145-g1b02478a82ab
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 98 runs,
 2 regressions (v5.13-rc7-145-g1b02478a82ab)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 98 runs, 2 regressions (v5.13-rc7-145-g1b02478a82ab)

Regressions Summary
-------------------

platform            | arch  | lab          | compiler | defconfig | regress=
ions
--------------------+-------+--------------+----------+-----------+--------=
----
imx8mp-evk          | arm64 | lab-nxp      | gcc-8    | defconfig | 1      =
    =

r8a77950-salvator-x | arm64 | lab-baylibre | gcc-8    | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
7-145-g1b02478a82ab/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc7-145-g1b02478a82ab
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1b02478a82abb3950fbd9d64cf8c7d404ffe08d6 =



Test Regressions
---------------- =



platform            | arch  | lab          | compiler | defconfig | regress=
ions
--------------------+-------+--------------+----------+-----------+--------=
----
imx8mp-evk          | arm64 | lab-nxp      | gcc-8    | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/60d1d7d0172e1f514b413268

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc7-145-g1b02=
478a82ab/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc7-145-g1b02=
478a82ab/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60d1d7d0172e1f514b413=
269
        failing since 14 days (last pass: acpi-5.13-rc5-42-ga25ea0c642c2, f=
irst fail: v5.13-rc5-37-gfcbef3bdf3a8) =

 =



platform            | arch  | lab          | compiler | defconfig | regress=
ions
--------------------+-------+--------------+----------+-----------+--------=
----
r8a77950-salvator-x | arm64 | lab-baylibre | gcc-8    | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/60d1e0294e045f309f41328f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc7-145-g1b02=
478a82ab/arm64/defconfig/gcc-8/lab-baylibre/baseline-r8a77950-salvator-x.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc7-145-g1b02=
478a82ab/arm64/defconfig/gcc-8/lab-baylibre/baseline-r8a77950-salvator-x.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60d1e0294e045f309f413=
290
        new failure (last pass: pm-5.13-rc7-139-g5469c0cf8416) =

 =20
