Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CBB29CA82
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 21:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439548AbgJ0UmD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 16:42:03 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:37848 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436598AbgJ0UmC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 16:42:02 -0400
Received: by mail-pf1-f172.google.com with SMTP id 126so1610302pfu.4
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2020 13:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=gfTcI+Fg1Sm2oQH4JINxga6/qEMhy5UvO+PRUiYqtfw=;
        b=x4qAvteKEJn0THUk0Ka6ju/7sZRZkoAxNNZqrAlXHDT3Ic7e34DwShuuo4kJCXsbn3
         H7IIyO6fbCkjKSkKYBrHYLFC93kPU+duEimMxYrPog+/NmuRsa0gMQbz5zMkT+WoAJ8R
         UP0hj8Js+EJHutNSphNJ8/70VMZyNfiEdZhgUxa3wrQMLV2z0sjpIC/pc13Y/1tvcrG2
         YICPxStP4ChPEG8zBYmghCAGDCJL8fr/A1fkOFXsylLcyLxpDQbcsrr03MQyIkiI4Bfq
         pZ3hBwGM9NyGKQqEZXJunbQsvBpB71QBaCTS6mmCv2OSeBrVwdcAhMpOqjC14qn+IeZB
         T68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=gfTcI+Fg1Sm2oQH4JINxga6/qEMhy5UvO+PRUiYqtfw=;
        b=Z2iV01i/lGf1TxptBTdoom6edGHZzxzbhIFbjJIDa6MMJdwOQD3OGibKfiePjJ6Aof
         h5dIqgkhGA3ahZeLrR+1Y6uTWiMvzjQ2jWAGMRwZAmh1eHpzLsKDudxeLM1rA4hJNEU2
         OaXGLdkb2zJ1X2tHIwQVKVt8rtD3ASVmnkFXuUwkR9JsN5Ylt8W4H27XLnd72XhjtXvm
         p6bPJmTwQC7v1BL1POeInAIiah99LT8U0BDLQQlt0fQT9XDryy9a7GpafxXezw2eXy00
         vfzP1eo47NGS+dGYIw9tLLSA8Q4vVl9ihNMAuS32a1gzkfGatoGMbg+2pm384X+IrlpD
         UtgQ==
X-Gm-Message-State: AOAM531VAr3KvKpA1WieD62/xo5TH0eZ6fF8OCDXJizBUofOFIvf5mEy
        3bh1C5U+qrz+uZcKKbJaKz4RoZmtQ+h/fA==
X-Google-Smtp-Source: ABdhPJy0VfUoaSvNTgHz+35EV+w5qhYM6B2Nw6o2zWiMh5JKPjsijQLizZhJ+4P/rOLS97W1dqRt3Q==
X-Received: by 2002:a62:502:0:b029:15f:c777:8bb3 with SMTP id 2-20020a6205020000b029015fc7778bb3mr3877517pff.18.1603831321615;
        Tue, 27 Oct 2020 13:42:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 15sm3001991pgs.52.2020.10.27.13.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 13:42:00 -0700 (PDT)
Message-ID: <5f988618.1c69fb81.9f9f9.5b44@mx.google.com>
Date:   Tue, 27 Oct 2020 13:42:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10-rc1-4-ge213cd8f175c
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 122 runs,
 2 regressions (v5.10-rc1-4-ge213cd8f175c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 122 runs, 2 regressions (v5.10-rc1-4-ge213cd8f175c)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig          | r=
egressions
----------------+-------+---------------+----------+--------------------+--=
----------
bcm2837-rpi-3-b | arm64 | lab-baylibre  | gcc-8    | defconfig          | 1=
          =

panda           | arm   | lab-collabora | gcc-8    | multi_v7_defconfig | 1=
          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
1-4-ge213cd8f175c/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc1-4-ge213cd8f175c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      e213cd8f175c811034bc766ac37bcb5b3cf83a22 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig          | r=
egressions
----------------+-------+---------------+----------+--------------------+--=
----------
bcm2837-rpi-3-b | arm64 | lab-baylibre  | gcc-8    | defconfig          | 1=
          =


  Details:     https://kernelci.org/test/plan/id/5f987c390ccec78214381016

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc1-4-ge213cd=
8f175c/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc1-4-ge213cd=
8f175c/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5f987c390ccec782=
1438101b
        new failure (last pass: v5.9-rc8-160-g91e0225c546b)
        4 lines

    2020-10-27 19:57:09.495000+00:00  Connected to bcm2837-rpi-3-b console =
[channel connected] (~$quit to exit)
    2020-10-27 19:57:09.495000+00:00  (user:khilman) is already connected
    2020-10-27 19:57:25.566000+00:00  =00
    2020-10-27 19:57:25.566000+00:00  =

    2020-10-27 19:57:25.567000+00:00  U-Boot 2018.11 (Dec 04 2018 - 10:54:3=
2 -0800)
    2020-10-27 19:57:25.567000+00:00  =

    2020-10-27 19:57:25.567000+00:00  DRAM:  948 MiB
    2020-10-27 19:57:25.582000+00:00  RPI 3 Model B (0xa02082)
    2020-10-27 19:57:25.669000+00:00  MMC:   mmc@7e202000: 0, sdhci@7e30000=
0: 1
    2020-10-27 19:57:25.702000+00:00  Loading Environment from FAT... *** W=
arning - bad CRC, using default environment =

    ... (396 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig          | r=
egressions
----------------+-------+---------------+----------+--------------------+--=
----------
panda           | arm   | lab-collabora | gcc-8    | multi_v7_defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/5f987b6dcc6a49e774381080

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc1-4-ge213cd=
8f175c/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc1-4-ge213cd=
8f175c/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f987b6dcc6a49e=
774381086
        failing since 69 days (last pass: v5.8-107-gb72b3ea38c81, first fai=
l: v5.9-rc1-4-g1f08d51cd57f)
        60 lines

    2020-10-27 19:56:23.367000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c802
    2020-10-27 19:56:23.375000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c803
    2020-10-27 19:56:23.383000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c804
    2020-10-27 19:56:23.387000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c805
    2020-10-27 19:56:23.391000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c806
    2020-10-27 19:56:23.399000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c807
    2020-10-27 19:56:23.403000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c808
    2020-10-27 19:56:23.411000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c809
    2020-10-27 19:56:23.415000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c80a
    2020-10-27 19:56:23.423000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c80b =

    ... (49 line(s) more)  =

 =20
