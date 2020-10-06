Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C8F284B64
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 14:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgJFMKO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 08:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgJFMKN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 08:10:13 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86301C061755
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 05:10:12 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x5so1119486plo.6
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 05:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=m2Bju6l/8/6XsORAyp8wWJVC5m8rx+JKRvZApR963ys=;
        b=lovbOIzOAAwJrW6ZNSm5Z4+sfeGdhUwnHDThhoW9XcP6nEMJ5Ql4nD6AbM0Izk/Wya
         uqKslBZbsxy+NqohLE5JqEFFXrKSjAnk3LidMLl2gOSixmb3+cwl+IV0oaOYTYy6+rJj
         oY+3Y2Dlplor2X+2Dd3Nr/22s27+cLXDPlKORor4AOPp7N2tbtFOQhqbCe55Uz6LLmJl
         0ESLqP/71BuieXQpeZi/pIy0Ey0hLCULvhEIaNbXvPe0nUWL5mRs7NSCpGg0IiYjQs0V
         WbFZiuFVLqRyvhLQi4aSjKq8p01Ik7WN4Ys/NfxX6ADzFV9tQHP55MGjqIABSUaUJF0O
         s7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=m2Bju6l/8/6XsORAyp8wWJVC5m8rx+JKRvZApR963ys=;
        b=UgQWCDYI2pCX3sjvkL4oyPatDI+QSvtoRSOZWDFI0+wbzy3TfG6bpDbIZSvp6dpS07
         cC0a3bOSU9eYn/RJY0e2gU+PJgo7Lkt0WMyOppJBRfnOd38IIJoHrjDdjA2aCRsMLQR0
         ZkGq+gDGuLYxs6dYg04SlIGKhi09C8si3wPboH71LyOJICoPsF1UOAkhEGy1QZBVMHYL
         W/zBYhS1kAHm7dxdc3SUpMW+hz1qMx1IgjuRZZxmunWZLsOXLbevfeG0a8nnFAywcHy7
         wFg5yIwC7vqqxJ529ki76yteE+5RALuMeTdWbiARPxr3tIC/ckS6SocUufgsdauAOE3Y
         97ng==
X-Gm-Message-State: AOAM531Pd6QK98HojWxPB3C+yDxqvMf4RW2mjeJQWRvystsyHQ/lNlJ5
        1iI5N2iCg8xX/zEeRpI+7/ouEgiblURc9Q==
X-Google-Smtp-Source: ABdhPJx7axOnLt2C4dB1cn8m4rHyaNswA8wYhVvMKyDMknmRYxECybmSZ50nEEnAPdYvEaa8GMtzOg==
X-Received: by 2002:a17:902:864b:b029:d3:ce46:2829 with SMTP id y11-20020a170902864bb02900d3ce462829mr3106732plt.16.1601986212013;
        Tue, 06 Oct 2020 05:10:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c187sm3775613pfc.0.2020.10.06.05.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 05:10:11 -0700 (PDT)
Message-ID: <5f7c5ea3.1c69fb81.bf5cd.825f@mx.google.com>
Date:   Tue, 06 Oct 2020 05:10:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.9-rc8-119-g9acb56ca0dec
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 80 runs,
 2 regressions (v5.9-rc8-119-g9acb56ca0dec)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 80 runs, 2 regressions (v5.9-rc8-119-g9acb56ca0dec)

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
-119-g9acb56ca0dec/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc8-119-g9acb56ca0dec
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      9acb56ca0dec044037bf2d0a76f49ba773134ec0 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig          | r=
esults
----------------+-------+---------------+----------+--------------------+--=
------
bcm2837-rpi-3-b | arm64 | lab-baylibre  | gcc-8    | defconfig          | 3=
/4    =


  Details:     https://kernelci.org/test/plan/id/5f7c5015447eca13724ff3ea

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc8-119-g9acb5=
6ca0dec/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc8-119-g9acb5=
6ca0dec/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-3-g27eeeac7da2d/arm64/baseline/rootfs.cpio.gz =


  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5f7c5015447eca13=
724ff3ee
      failing since 0 day (last pass: v5.9-rc7-75-g027a0d093137, first fail=
: v5.9-rc8-85-g66bebc5f7cab)
      1 lines

    2020-10-06 11:06:02.215000  Connected to bcm2837-rpi-3-b console [chann=
el connected] (~$quit to exit)
    2020-10-06 11:06:02.215000  (user:khilman) is already connected
    2020-10-06 11:06:18.304000  =00
    2020-10-06 11:06:18.304000  =

    2020-10-06 11:06:18.304000  U-Boot 2018.11 (Dec 04 2018 - 10:54:32 -080=
0)
    2020-10-06 11:06:18.304000  =

    2020-10-06 11:06:18.304000  DRAM:  948 MiB
    2020-10-06 11:06:18.320000  RPI 3 Model B (0xa02082)
    2020-10-06 11:06:18.407000  MMC:   mmc@7e202000: 0, sdhci@7e300000: 1
    2020-10-06 11:06:18.439000  Loading Environment from FAT... *** Warning=
 - bad CRC, using default environment
    ... (378 line(s) more)
      =



platform        | arch  | lab           | compiler | defconfig          | r=
esults
----------------+-------+---------------+----------+--------------------+--=
------
panda           | arm   | lab-collabora | gcc-8    | multi_v7_defconfig | 4=
/5    =


  Details:     https://kernelci.org/test/plan/id/5f7c54a2575bfd64ad4ff3fd

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc8-119-g9acb5=
6ca0dec/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc8-119-g9acb5=
6ca0dec/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-3-g27eeeac7da2d/armel/baseline/rootfs.cpio.gz =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f7c54a2575bfd6=
4ad4ff403
      failing since 47 days (last pass: v5.8-107-gb72b3ea38c81, first fail:=
 v5.9-rc1-4-g1f08d51cd57f)
      60 lines

    2020-10-06 11:27:23.182000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c802
    2020-10-06 11:27:23.188000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c803
    2020-10-06 11:27:23.194000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c804
    2020-10-06 11:27:23.200000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c805
    2020-10-06 11:27:23.206000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c806
    2020-10-06 11:27:23.212000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c807
    2020-10-06 11:27:23.218000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c808
    2020-10-06 11:27:23.224000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c809
    2020-10-06 11:27:23.230000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80a
    2020-10-06 11:27:23.237000  kern  :alert : BUG: Bad page state in proce=
ss swapper/0  pfn:9c80b
    ... (49 line(s) more)
      =20
