Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F28207862
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 18:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404733AbgFXQGA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 12:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404525AbgFXQGA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 12:06:00 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250F0C061573
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 09:06:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q90so837381pjh.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 09:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=NtTZMG2Jz8Dje9LJz5yqpTDScgUXLlQrrVHIyVPoj/c=;
        b=C3WGlzieXEErDTKc4VA3TPJqYwV2ZeCaDmRF29/fJgfxPyZfstk3CKo+G1TLXTm6g4
         /4xPiY5x6FqANROvr+SONgDbeQ1fxe5bnh5BR/QkTPx3J8lZGY0cC54wM0xV8a242w9o
         x+NZQdpFZ17vqLAH5S6LqBUlNIX59FVld0xyTaaifLibQuvSJkUc6jbDN5WyAtnZKXZM
         vCoPLWs0JXQQ2nWgrq/PuSagtzN9cJ2FaSvLrao7tMtBBkcU0yFEyZ42yPkPHr36KD9h
         vGKBKuHNQjY0ZTEZSe4R03kX3Mm+R+qdRBv37qJP2OvsfYG9EMu0j+sKbILyEaZ9POUs
         o9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=NtTZMG2Jz8Dje9LJz5yqpTDScgUXLlQrrVHIyVPoj/c=;
        b=P9KEEqwRQ48y7EtvA6J55VqDkkIU1T4JWTV/SrJBgRrw/4fsOwmYZB5tKfi5uOvI96
         rExu6Y/zmC9083PJkJ7wXfV5UmV+2exJg+Sv+6OrGR5CWfdrIao47sC6Ddo0ENbck+l5
         SRVy6nAIDOkuBoQ8oNY4UmcAHSg54HIK5X4uxOKFKFTWk9kzGKK3nDq5VNLcio5zoQtM
         G+5c45xDb7YK3Vl/o2dl8+mnT/E9SbdN+k7dRGqC0X0FMQJiGDXrsP9m9zg0ylUbfgir
         6MgYO/knNWS9hSmubKRnW4SbApBax0GzARsTlm7u3oRnf4z0KbNAp1jHTFFNXI4w+j4L
         JImw==
X-Gm-Message-State: AOAM531padGdmgIZVdoiX70bLKgpX57Tm9TEXIW91x2Kyj6Vbc+YSftu
        Q878mwvUzlJiXoFe0gk8W5Q0Di3Qemk=
X-Google-Smtp-Source: ABdhPJxOtJrQ1kUqt872XTuQjeypGWi50398cYRCzSLo9hfdsAPyeTn4wusH1SSrEDGdhjguvjNDNQ==
X-Received: by 2002:a17:90a:39ce:: with SMTP id k14mr28871586pjf.39.1593014759591;
        Wed, 24 Jun 2020 09:05:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y10sm21502941pfq.34.2020.06.24.09.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 09:05:58 -0700 (PDT)
Message-ID: <5ef379e6.1c69fb81.189d.1fd9@mx.google.com>
Date:   Wed, 24 Jun 2020 09:05:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.8-rc2-12-g3f291d339bdc
Subject: pm/testing baseline: 44 runs,
 2 regressions (v5.8-rc2-12-g3f291d339bdc)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 44 runs, 2 regressions (v5.8-rc2-12-g3f291d339bdc)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| results
-----------------------------+-------+--------------+----------+-----------=
+--------
bcm2837-rpi-3-b              | arm64 | lab-baylibre | gcc-8    | defconfig =
| 4/5    =

meson-gxl-s805x-libretech-ac | arm64 | lab-baylibre | gcc-8    | defconfig =
| 4/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.8-rc2=
-12-g3f291d339bdc/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.8-rc2-12-g3f291d339bdc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      3f291d339bdc310cb978e60031aa8d718dd6089a =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| results
-----------------------------+-------+--------------+----------+-----------=
+--------
bcm2837-rpi-3-b              | arm64 | lab-baylibre | gcc-8    | defconfig =
| 4/5    =


  Details:     https://kernelci.org/test/plan/id/5ef36ffb86d301d6bc97bf0d

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-rc2-12-g3f291d=
339bdc/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-rc2-12-g3f291d=
339bdc/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5ef36ffb86d301d6=
bc97bf10
      new failure (last pass: v5.8-rc2-8-g43bad67922e1)
      3 lines =



platform                     | arch  | lab          | compiler | defconfig =
| results
-----------------------------+-------+--------------+----------+-----------=
+--------
meson-gxl-s805x-libretech-ac | arm64 | lab-baylibre | gcc-8    | defconfig =
| 4/5    =


  Details:     https://kernelci.org/test/plan/id/5ef3701886d301d6bc97bf29

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.8-rc2-12-g3f291d=
339bdc/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s805x-libretec=
h-ac.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.8-rc2-12-g3f291d=
339bdc/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s805x-libretec=
h-ac.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2019=
.02-11-g17e793fa4728/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/5ef3701886d301d=
6bc97bf2e
      failing since 0 day (last pass: v5.8-rc2, first fail: v5.8-rc2-8-g43b=
ad67922e1)
      2 lines =20
