Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921DD305490
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 08:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S317115AbhA0AkB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 19:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728603AbhAZUb5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jan 2021 15:31:57 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C922BC061574
        for <linux-pm@vger.kernel.org>; Tue, 26 Jan 2021 12:31:11 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id j12so11117325pfj.12
        for <linux-pm@vger.kernel.org>; Tue, 26 Jan 2021 12:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Du/6ZC4zcHjk+Vweff8Gq4LYgkSdWILSBs6zwCUlsvo=;
        b=lluJi+FTfQGUX5JGuDPl1HrtKp9gphukPz0ELvp6FnrTcguMnO2J1Vez/MaqgHygQ6
         JiauairKZXAUIzd6D57lE3g6RfEqrZERmkltlTzINSVXhbyew015QjS0tzP0YfTx3ygb
         sFGaWuEV5mktnP4oqJqDCv9jdBrlyKAFh25SHk+tooXr8aQwi9pRDXUYbX2OYF6dUPSc
         MG3YhSspuVi64O5GOZGtSHF32TtpjBKpe7LhcqslyHnIO33tYTYrXdisBbkt+fuiQztb
         Hq0lB91+1737X3KkI8EFzsQl4n1SoVTXVJwaZlWVY+8OnRGW8FEuFOTQZriHyTXnRvzG
         8efA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Du/6ZC4zcHjk+Vweff8Gq4LYgkSdWILSBs6zwCUlsvo=;
        b=nkofFa9HLvV021vwkRiK7bvInCDWmSHSh1MxdcJIOCHBtguzVu+dvqrJEPFiu7YR/a
         2BSGSp7/OhIX39KujzMtvqxaDbPrELZkF2X52iqDaEwP9giKxt8iqj/UiK1vYzgl56+j
         IYzerJQtLH2a2sP9wCBirgCsLhxThZYLrZnki/6017slioeeNr3SOKmukU0gYD+fML1W
         zsuH/fXdPosvhbz+VxKQNdAH+xSzbU776SNf1X5i6R6yAla6vyEb9d9eGV5ynV4A2Ku1
         4NHUEXO2S40s3ZTcyxEjY4zKP3YZGDW+FrM5ZUE+Eb0rSkVvBWrIAqT9WGyQoVhbiTFD
         Sfvw==
X-Gm-Message-State: AOAM530XNlXYWLvi5CD8yHKJeMBtY/FjlzQE9e0p2/efNRzalvu4iBxc
        dl2/PHxuG/8VLSGg7p3P7fB/rg==
X-Google-Smtp-Source: ABdhPJzmwQhQMJrxoKgCdUGqbQLGKDFKAdy4evCi/mxX/PxNxV7Q6yzgfbELwTU1Sf1jz4jh8YNGeQ==
X-Received: by 2002:a65:56cb:: with SMTP id w11mr7547881pgs.88.1611693071410;
        Tue, 26 Jan 2021 12:31:11 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a2sm5621061pgq.94.2021.01.26.12.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 12:31:10 -0800 (PST)
Message-ID: <60107c0e.1c69fb81.ac986.eb93@mx.google.com>
Date:   Tue, 26 Jan 2021 12:31:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.11-rc5-48-gfeb0d85db3fd2
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 3 runs, 3 regressions (v5.11-rc5-48-gfeb0d85db3fd2)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 3 runs, 3 regressions (v5.11-rc5-48-gfeb0d85db3fd2)

Regressions Summary
-------------------

platform            | arch | lab           | compiler | defconfig          =
| regressions
--------------------+------+---------------+----------+--------------------=
+------------
rk3288-rock2-square | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
| 3          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.11-rc=
5-48-gfeb0d85db3fd2/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.11-rc5-48-gfeb0d85db3fd2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      feb0d85db3fd2da4a4a0d9f09eece2a3e111ebdc =



Test Regressions
---------------- =



platform            | arch | lab           | compiler | defconfig          =
| regressions
--------------------+------+---------------+----------+--------------------=
+------------
rk3288-rock2-square | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
| 3          =


  Details:     https://kernelci.org/test/plan/id/60106f54c6824c7083d3dfd4

  Results:     2 PASS, 13 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc5-48-gfeb0d=
85db3fd2/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squa=
re.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc5-48-gfeb0d=
85db3fd2/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squa=
re.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0125.1/armhf/rootfs.cpio.gz =



  * sleep.rtcwake-mem-1: https://kernelci.org/test/case/id/60106f54c6824c70=
83d3dfd7
        new failure (last pass: acpi-5.11-rc5-27-gad758c58a703)

    2021-01-26 19:36:47.744000+00:00  rtcwake: read rtc time failed: I<4>[ =
  20.040378] rtc-hym8563 0-0051: no valid clock/calendar values available
    2021-01-26 19:36:47.744000+00:00  nvalid argument
    2021-01-26 19:36:47.745000+00:00  rtcwake: assuming RTC uses UTC ...
    2021-01-26 19:36:47.746000+00:00  rtcwake: rea<4>[   20.057590] rtc-hym=
8563 0-0051: no valid clock/calendar values available
    2021-01-26 19:36:47.746000+00:00  d rtc time failed: Invalid argument   =


  * sleep.rtcwake-mem-2: https://kernelci.org/test/case/id/60106f54c6824c70=
83d3dfd8
        new failure (last pass: acpi-5.11-rc5-27-gad758c58a703) =


  * sleep.rtcwake-mem-3: https://kernelci.org/test/case/id/60106f54c6824c70=
83d3dfd9
        new failure (last pass: acpi-5.11-rc5-27-gad758c58a703)

    2021-01-26 19:36:47.748000+00:00  TC ...
    2021-01-26 19:36:47.792000+00:00  rtcwake: read rtc time failed: Invali=
d argument
    2021-01-26 19:36:47.793000+00:00  rtcwake:<4>[   20.098241] rtc-hym8563=
 0-0051: no valid clock/calendar values available
    2021-01-26 19:36:47.793000+00:00   assuming RTC uses UTC ...
    2021-01-26 19:36:47.794000+00:00  rtcwake: read rtc time failed: Invali=
d argument   =

 =20
