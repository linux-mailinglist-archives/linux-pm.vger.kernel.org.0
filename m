Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB3831F153
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 21:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhBRUuW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 15:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhBRUuU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 15:50:20 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAFFC061574
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 12:49:35 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id u143so2117175pfc.7
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 12:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=vIk0opq3f6mdI/klVfBeTYk18n/l04gucnF20AVhiTA=;
        b=Dl3XrzyKDmcZsSeB6gh2y24pAuwdxoH7HMjYVqzxwdmfo24GA39JwJjt06zrx9Ov3a
         h9gP8jYc4zmDxUUEMSZHZoHDAijloXabAeLogsRiqHFSynNodXwpS78zX8l4i8UYv81r
         /aWB8lOwZ7QC0xBaNQDc/VMEFEdHX0Xadqaue96mhBRhCdQB0vOCiK03NNZO5H8U+5t9
         9EI/Cv6fQB8iEPXdlpsvsx9ADQC8ifNR9VC1F3VNMcMrwGSuzkJECb+N/F/AmuTaG3zi
         eDkhW38Hw9jHydf6CZsyZd7jt0LaEAe24VDxwPfc8ewiNB4JAqTYXkcuFzWgNo6PIn+G
         hg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=vIk0opq3f6mdI/klVfBeTYk18n/l04gucnF20AVhiTA=;
        b=r5rjoREL+J00ksGiChXMrbng+1+Fkaxn3Q1iwc77+tIrO7eu5NYFYLRmbgrf0FxPKn
         Q0HlnmEv9L7vNBpIafJ/k2jOKyk5ziWD/W8UyNiX9iHJWqYOUGPHoAt2sc5FxYnmsKWK
         4UCikBlU/cRkvmU+YYXAOZcx8Hky3cPcmeRLpr4glFiyuQoKQyFDRJrWYCNSDFNp8Jd6
         qJBDoBZAa5h3MAP7yntEenl1aq3M0w0f7XoB9MvVxJwsSj02V7gHsVpy9k4pmulIupkT
         WEjo5nz00J7sE7msKi1obmJIcAlfrGpZrOk3L2bvoiyYxx6UU9xm2bESyluYDyAROTKo
         yHTw==
X-Gm-Message-State: AOAM530LP83TbhzOEEMTcXncwrWFIuYYiEa2NPscEKs1I9syXMzXLeGR
        VsthLc/u4Ccj8na6Fj9EHdTPiVwP8zPeRA==
X-Google-Smtp-Source: ABdhPJzkRyLrMeYUrEXT6ctg5Lyvt87eSy/UqOKAQCqhqR3gwsPdNdSJcane9TP9Zu0bq6pNz/qvXg==
X-Received: by 2002:a63:504e:: with SMTP id q14mr5482947pgl.306.1613681375125;
        Thu, 18 Feb 2021 12:49:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a5sm6517364pgh.15.2021.02.18.12.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 12:49:34 -0800 (PST)
Message-ID: <602ed2de.1c69fb81.7fe1f.e40c@mx.google.com>
Date:   Thu, 18 Feb 2021 12:49:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: pm-5.11-rc8-201-g8b72d3aa065c
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 62 runs,
 1 regressions (pm-5.11-rc8-201-g8b72d3aa065c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 62 runs, 1 regressions (pm-5.11-rc8-201-g8b72d3aa065c)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
hifive-unleashed-a00 | riscv | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-5.11-=
rc8-201-g8b72d3aa065c/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: pm-5.11-rc8-201-g8b72d3aa065c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      8b72d3aa065ce33df4f042840078542b1e5d2c45 =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
hifive-unleashed-a00 | riscv | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/602ec4dec781979777addcb1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (riscv64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.11-rc8-201-g8b=
72d3aa065c/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a00=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.11-rc8-201-g8b=
72d3aa065c/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a00=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/riscv/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/602ec4dec781979777add=
cb2
        failing since 84 days (last pass: pm-5.10-rc4-33-g52d108cd060d, fir=
st fail: pm-5.10-rc6-75-g735f7fba25ec) =

 =20
