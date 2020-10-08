Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D80287B17
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 19:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgJHRic (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 13:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgJHRic (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 13:38:32 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3C6C061755
        for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2020 10:38:31 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x5so3113494plo.6
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2020 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Tcw+Hn/R7gQMR2edGzUaAbBuUkt4+JRCYonfOy36olc=;
        b=diqcBbesuQK+64JdDdgBeguF6X42JwseLqpuinUhLW5KHaYevYWYc3O/4nyCoQ7iB/
         BSsV7NzFmy/g85ab29HVN9AKLCb20P+OQ2x2btzygvgeSMdNOP4F9kTSsH5rADpzPsPu
         KOSscSKxaKu9cV+ztpkAP4vInCDdOzETIgWqi2cYOPDS9i+ousIRF/Jc58thtlDvRHbs
         64LJySGNJM+vuNvu6QOmdZn36ckpp8kPtY99UkKF9hKppPSPrzWmtaXkqCA0l4d91m07
         2F3A3peDpBmv8tI2M5N98o5v83fy6In/Dw1Y22vnuFimCyxe2nLFt8CD0WhOBPttxSHg
         roJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Tcw+Hn/R7gQMR2edGzUaAbBuUkt4+JRCYonfOy36olc=;
        b=TdMj2c87qLYEYx6sBc7nU5W9iZZDPSkf8Ru2oX5TJvAd6yeJJJQoIF/L21LGDCxhA9
         iT9mwVzRsmmOWA2u1EeveRuNSssaO4/4abUiM42nkRm404yY+gHt23MBm1dWRr9dBO4F
         7LNXM5Imf0ifB1iGKjhW+Aor56kBat3UZOpjKY/rjMebJa/FA/5FgaruNoP11Ia2TxMI
         hg7rGFWakyMBfphKOzv8z9VlPIY80Rh06235VqchCrhPtE5YGQGY368mjYl8CZxJHw2C
         9DdFAjtISeJmv3MnKcvyQc8+XsNGEJRXRZWawB0VEdPSESRfbVoYPyQLu4xl77d5llrH
         3xhA==
X-Gm-Message-State: AOAM533yQe6ypf+cY6U89Py+ezchOgMZDbUvWg9EBrT0HPwLy2D4R3TE
        MB1LIYKTVxKGPxihV+MrUQ3BIg==
X-Google-Smtp-Source: ABdhPJzwZKkCqxJnWlcWoRw5T/xuOQQAnoX3ZYXQPv5uS9a3fyIGZ/2/0al5/5N3HovUhxEBGp6twA==
X-Received: by 2002:a17:902:6803:b029:d2:42a6:312 with SMTP id h3-20020a1709026803b02900d242a60312mr8404865plk.24.1602178710329;
        Thu, 08 Oct 2020 10:38:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o20sm8494595pgh.63.2020.10.08.10.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 10:38:29 -0700 (PDT)
Message-ID: <5f7f4e95.1c69fb81.7f41b.f236@mx.google.com>
Date:   Thu, 08 Oct 2020 10:38:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc8-158-g4ae5e76f4c5d
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 85 runs,
 2 regressions (v5.9-rc8-158-g4ae5e76f4c5d)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 85 runs, 2 regressions (v5.9-rc8-158-g4ae5e76f4c5d)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig          | r=
esults
----------------+-------+---------------+----------+--------------------+--=
------
bcm2837-rpi-3-b | arm64 | lab-baylibre  | gcc-8    | defconfig          | 3=
/4    =

panda           | arm   | lab-collabora | gcc-8    | multi_v7_defconfig | 4=
/5    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc8=
-158-g4ae5e76f4c5d/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc8-158-g4ae5e76f4c5d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      4ae5e76f4c5d75baac0f3466ab0798c6d124a4bf =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig          | r=
esults
----------------+-------+---------------+----------+--------------------+--=
------
bcm2837-rpi-3-b | arm64 | lab-baylibre  | gcc-8    | defconfig          | 3=
/4    =


  Details:     https://kernelci.org/test/plan/id/5f7f449cb094f5267b4ff3ff

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc8-158-g4ae5e=
76f4c5d/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc8-158-g4ae5e=
76f4c5d/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-3-g27eeeac7da2d/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5f7f449cb094f526=
7b4ff403
      new failure (last pass: v5.9-rc8-137-gc3cdb7873495)
      1 lines

    2020-10-08 16:53:50.003000  Connected to bcm2837-rpi-3-b console [chann=
el connected] (~$quit to exit)
    2020-10-08 16:53:50.003000  (user:khilman) is already connected
    2020-10-08 16:54:05.335000  =00
    2020-10-08 16:54:05.336000  =

    2020-10-08 16:54:05.336000  U-Boot 2018.11 (Dec 04 2018 - 10:54:32 -080=
0)
    2020-10-08 16:54:05.337000  =

    2020-10-08 16:54:05.337000  DRAM:  948 MiB
    2020-10-08 16:54:05.350000  RPI 3 Model B (0xa02082)
    2020-10-08 16:54:05.438000  MMC:   mmc@7e202000: 0, sdhci@7e300000: 1
    2020-10-08 16:54:05.472000  Loading Environment from FAT... *** Warning=
 - bad CRC, using default environment
    ... (378 line(s) more)
      =



platform        | arch  | lab           | compiler | defconfig          | r=
esults
----------------+-------+---------------+----------+--------------------+--=
------
panda           | arm   | lab-collabora | gcc-8    | multi_v7_defconfig | 4=
/5    =


  Details:     https://kernelci.org/test/plan/id/5f7f441124fa2c2f154ff3e8

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc8-158-g4ae5e=
76f4c5d/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc8-158-g4ae5e=
76f4c5d/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-3-g27eeeac7da2d/armel/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f7f441224fa2c2=
f154ff3ee
      failing since 49 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)
      60 lines

    2020-10-08 16:53:31.878000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c802
    2020-10-08 16:53:31.883000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c803
    2020-10-08 16:53:31.889000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c804
    2020-10-08 16:53:31.895000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c805
    2020-10-08 16:53:31.901000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c806
    2020-10-08 16:53:31.907000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c807
    2020-10-08 16:53:31.913000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c808
    2020-10-08 16:53:31.919000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c809
    2020-10-08 16:53:31.925000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80a
    2020-10-08 16:53:31.931000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80b
    ... (49 line(s) more)
      =20
