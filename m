Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7058359020
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 01:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbhDHXFZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 19:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhDHXFZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 19:05:25 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCDDC061760
        for <linux-pm@vger.kernel.org>; Thu,  8 Apr 2021 16:05:13 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id b17so2450555pgh.7
        for <linux-pm@vger.kernel.org>; Thu, 08 Apr 2021 16:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=16w958FwN5Guu0WocuFd5k+MEYWRc3u0S2V/5BmEYzs=;
        b=kIrewaP9KOmww0Uh7LyVRG2rj/cxBylzwzoY+XcgJ4FX49aPV/QkTmpDismsgyzz6V
         RlaI6jE0fG3vwoQxE/SgWo5QNbeVIocK4kvtiRBD5comSIBdZFmQn64hwae4kWdtTdT4
         9yeT3sbgYl8jNwtaYdzLUpYrLnM1AFfolK0k5PdLlWSA2pnpnIO7iYhNUZVASw3hYxaC
         yRfEpCSR+HGfKr0o3cXeU+Vz6ww/3utMOz5ymT3S1e79SPMqGbvxw6aBPcEBmuZE43Ad
         zAn+qCBd02Hh1o1I8eim2nIf7jGGbpcC/pfR8gILxUTMD2TBd8NkuzM4PWSJ9cowyTJ7
         Y5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=16w958FwN5Guu0WocuFd5k+MEYWRc3u0S2V/5BmEYzs=;
        b=GHvq8su6GZaD1Vevc2DRyU/2uGpnbxtyf6b4Ci+SfcVI+74VF3ztD6gnEMTGNgO3t2
         ZxyvNcvK/pQykUX3FrT0RBJSsQsu+UOuB01iYXEUisgAg0BtKiAG5bf7Xj7m0r9i7Gpr
         VBbLmYFdesacJRBRUMebJk8qSNDrjDwL1h3SV3aRKCk1tIIgAYT19wg2s8WGOuRXR422
         j2rLOGS3d2lo+wVisdCEY2obnn9HHf53JQduUuOU9xMsipOriC9p9D4WzmScstEtFcH8
         R9dBp0fIRI9tA4Y2du3SykgZRLumg5Wvd7pOni9zbJazjZaKSuky+5AnoWaxHi5mMwIA
         N/Og==
X-Gm-Message-State: AOAM53367gXEdYojlkrHMH3FhGHvYrzm131aqb4OpEQU/Z+D5fv2Mr44
        LOL5C4zfWQqVtG6rfLpUcdIsTA==
X-Google-Smtp-Source: ABdhPJw7pcaXUWTvpxSna9cl+f0q2JaAkl4uEIaKFmFBGBeq0pcfvRnvTSsavtc/cXtc9MyxAlX/ig==
X-Received: by 2002:a63:fa41:: with SMTP id g1mr10437240pgk.143.1617923113301;
        Thu, 08 Apr 2021 16:05:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c5sm413343pfp.183.2021.04.08.16.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 16:05:13 -0700 (PDT)
Message-ID: <606f8c29.1c69fb81.bdc04.1bda@mx.google.com>
Date:   Thu, 08 Apr 2021 16:05:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.12-rc6-72-gea176976603a0
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 105 runs,
 2 regressions (v5.12-rc6-72-gea176976603a0)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 105 runs, 2 regressions (v5.12-rc6-72-gea176976603a0)

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


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.12-rc=
6-72-gea176976603a0/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.12-rc6-72-gea176976603a0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      ea176976603a0deb74a3453f09a83f21adfde207 =



Test Regressions
---------------- =



platform            | arch  | lab          | compiler | defconfig | regress=
ions
--------------------+-------+--------------+----------+-----------+--------=
----
imx8mp-evk          | arm64 | lab-nxp      | gcc-8    | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/606f83922e885195c2dac6b3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc6-72-gea176=
976603a0/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc6-72-gea176=
976603a0/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/606f83922e885195c2dac=
6b4
        failing since 7 days (last pass: v5.12-rc5-47-g506a524e05e2, first =
fail: v5.12-rc5-47-g85f34ae663986) =

 =



platform            | arch  | lab          | compiler | defconfig | regress=
ions
--------------------+-------+--------------+----------+-----------+--------=
----
r8a77950-salvator-x | arm64 | lab-baylibre | gcc-8    | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/606f82ed713cf335ccdac6bb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.12-rc6-72-gea176=
976603a0/arm64/defconfig/gcc-8/lab-baylibre/baseline-r8a77950-salvator-x.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.12-rc6-72-gea176=
976603a0/arm64/defconfig/gcc-8/lab-baylibre/baseline-r8a77950-salvator-x.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/606f82ed713cf335ccdac=
6bc
        new failure (last pass: v5.12-rc6-37-gcf66fa75745a0) =

 =20
