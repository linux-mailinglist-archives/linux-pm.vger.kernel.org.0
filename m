Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B78C3E0E6E
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 08:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhHEGe6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 02:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhHEGe6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Aug 2021 02:34:58 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C62C061765
        for <linux-pm@vger.kernel.org>; Wed,  4 Aug 2021 23:34:44 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id e21so5891865pla.5
        for <linux-pm@vger.kernel.org>; Wed, 04 Aug 2021 23:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=XfemrDGDN9HUdSdle6RGdRgZ+VSUdI8M6pBZqNMmwSc=;
        b=KV5WeRKGWi92t3RCYMIDyisROCI/62JfFy2/9aUsaPWpD5PIcfkg+u/rHS8jD/r4NP
         dYmdHPAqp5Y2mWYibS2f0XHbIsLBL8goMOI3tMSXNHuA31md/vSzoknWb9fklg9jBxYf
         hfpKPt/KOU3tn4DbgMHy+gL29AcRTAWOM/FZGFjr2SrfGd60CH/SBrwTr+0OHwKk9Yv9
         GHB605jdVlQ7cZ2b2UXn2e1kDdXK2KVsxGwtGKZxd568ikBWN5kRNLV2rAYnDiZF+66S
         2yphO0ZUxUnLQwvQQgyWZ7DZC8DqRodXL2kz/XgQ4HxcWkX41jiL4IjfFibzj+eLkFWz
         UIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=XfemrDGDN9HUdSdle6RGdRgZ+VSUdI8M6pBZqNMmwSc=;
        b=jfFZ9WPG9hHnOJPtmvud9r8HFnOb7ZdgKkDKC5uZvmwXBh1eYBPJ2rGhieqF+N15T5
         3dOVd90M2rkArhvg/lcpZDGbH+WA9AuBBQmwLzO4RGmcRJ3ODjfT4+NiYccx0kgyNM2r
         BB9EKCUG509F7tZGObsVvOJ6gJmRmDdpoHLP0UgZDgCv15z7RcXdJfk/MGROyLskAY59
         eDL/YUo4IGycbWgxZ9iQRSkZQHZ+iHNUdCiTDBSvtzrFSlpVPgxE4lFRi9hbnVYOVijz
         6Y6nGHM/PA7VCKo0BXcnPLEgsAsigAitVqqc+Ol63O+wmRfGJAkQUgRiJeljOqTlRQ6t
         HsYA==
X-Gm-Message-State: AOAM530BQ8hqc2YrZXsuHsodRVE26blmkvWp6yzvxf18qVzHwfMGvx/B
        2uRFIAjiFz9todPNYUE/tDdFfA==
X-Google-Smtp-Source: ABdhPJyyVKam3gcG9v3dIFljwVhZI8qI52hwGVVrVap8CudUrAZ0e/9ifJBudlkzy2pZT9RTfZWwnw==
X-Received: by 2002:a17:90b:1896:: with SMTP id mn22mr3056643pjb.148.1628145284130;
        Wed, 04 Aug 2021 23:34:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b7sm4897131pfl.195.2021.08.04.23.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 23:34:43 -0700 (PDT)
Message-ID: <610b8683.1c69fb81.1c104.f4d9@mx.google.com>
Date:   Wed, 04 Aug 2021 23:34:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.14-rc4-18-g197da54f3a8e
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 65 runs,
 2 regressions (v5.14-rc4-18-g197da54f3a8e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 65 runs, 2 regressions (v5.14-rc4-18-g197da54f3a8e)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 1          =

meson-gxbb-p200 | arm64 | lab-baylibre | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.14-rc=
4-18-g197da54f3a8e/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.14-rc4-18-g197da54f3a8e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      197da54f3a8ea155a1d3c5bf025cf6329a8dafc7 =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/610b7fb17c444fdd3db1369a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc4-18-g197da=
54f3a8e/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc4-18-g197da=
54f3a8e/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/610b7fb17c444fdd3db13=
69b
        failing since 23 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1) =

 =



platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
meson-gxbb-p200 | arm64 | lab-baylibre | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/610b7da8ab0b5afddcb13676

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc4-18-g197da=
54f3a8e/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc4-18-g197da=
54f3a8e/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/610b7da8ab0b5afddcb13=
677
        new failure (last pass: v5.14-rc4-14-g392ac3ea48ca) =

 =20
