Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829DA316943
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 15:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhBJOkH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 09:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhBJOkE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2021 09:40:04 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0F8C06174A
        for <linux-pm@vger.kernel.org>; Wed, 10 Feb 2021 06:39:22 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l18so1254035pji.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Feb 2021 06:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=q3j/o6VHTvc9VFUVO+FM7psHmvPT6g7+yheRUhB9LB8=;
        b=BAf5Bfcx91UMaTNbyVLunFh/ZpD2d5h6fGGRd3TNoDh8yfV58PWh27LoA21WpSXLEu
         n92SxUYO9bq1GSncIgBi+CczBPjhCmmbVGUAqp81MYGNEMhnc/DAtqE8YVjuYDMLj0cC
         STV5brROVGiVtY89RRsa//poV+8lK6qtOa0oeCJ+aKTvqPXeOnVwYTwcICjjSOd2eDuR
         uYhN/JPdxsXAmSXku84yj3fQ/dsbzQBxDzbd9e2LgJrwqC4ikEHXNv5ipOFkiCnVKLGz
         J6/pHDrMGJcnOCOu/7chLvCo4rMd/e9Dp+LX2092FmLi5kq1XoE1RReAAiDi9kKTXsrc
         TYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=q3j/o6VHTvc9VFUVO+FM7psHmvPT6g7+yheRUhB9LB8=;
        b=WVpvz2xHuwb2h5HxcXJBemiMY21ZXf639xkLDg3aXRPlV+NOLRbxvkCzEJFWg7Hkxm
         CQZyK6fi/eozuQsUO8+Uem8TU5PEW+SX7FCpuX6mLRVa0vRjLiY2wyM6gTnl+fnFzoin
         vXH2Mfp7YPqiru2b6vMelz7bpRWCIFVtMnZycBfE3Oi4Kda4d54dMCn13L0IdCbrsNji
         T1TfzkFTDUDQT3zhGhUetVxYjXj0ItqpV1HD4gCzxFhYEPv5hgs6gXdKXfiWXrZE6ULx
         aBaPdLv6w+6NuytAnaWxb/woKBXuhjQoEkFwRbMqq0j6gL55YEVZaM+UmbzWW9SGn2wO
         t1gQ==
X-Gm-Message-State: AOAM531I2u9w8/G9x10M8Idk7mXEHIv0Ij2q9jDzqg5vo82GwypFQqk6
        fF1t4Bv0fw8kwD8SuwGkXd488g==
X-Google-Smtp-Source: ABdhPJyWZaA0N1J9N0gxWKeRdQPv2Rgsb3BjF+V2mHqhIrXEH+DbDNQUtfeqXKPdCgVI+gxB0bJtOQ==
X-Received: by 2002:a17:90a:c702:: with SMTP id o2mr3295535pjt.7.1612967962351;
        Wed, 10 Feb 2021 06:39:22 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m5sm2634059pgj.11.2021.02.10.06.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 06:39:21 -0800 (PST)
Message-ID: <6023f019.1c69fb81.d21eb.57a7@mx.google.com>
Date:   Wed, 10 Feb 2021 06:39:21 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.11-rc7-105-g32890f947002
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 54 runs,
 2 regressions (v5.11-rc7-105-g32890f947002)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 54 runs, 2 regressions (v5.11-rc7-105-g32890f947002)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 1          =

imx8mp-evk      | arm64 | lab-nxp      | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.11-rc=
7-105-g32890f947002/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.11-rc7-105-g32890f947002
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      32890f947002ed83bfa76ad73fae15393292a21a =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6023e6296f9c0333063abe62

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc7-105-g3289=
0f947002/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc7-105-g3289=
0f947002/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/6023e6296f9c0333=
063abe67
        new failure (last pass: acpi-5.11-rc7-89-g5f8da9ef1c5d8)
        1 lines

    2021-02-10 13:54:51.869000+00:00  Connected to bcm2837-rpi-3-b console =
[channel connected] (~$quit to exit)
    2021-02-10 13:54:51.870000+00:00  (user:khilman) is already connected
    2021-02-10 13:55:07.284000+00:00  =00
    2021-02-10 13:55:07.284000+00:00  =

    2021-02-10 13:55:07.284000+00:00  U-Boot 2018.11 (Dec 04 2018 - 10:54:3=
2 -0800)
    2021-02-10 13:55:07.284000+00:00  =

    2021-02-10 13:55:07.285000+00:00  DRAM:  948 MiB
    2021-02-10 13:55:07.293000+00:00  RPI 3 Model B (0xa02082)
    2021-02-10 13:55:07.380000+00:00  MMC:   mmc@7e202000: 0, sdhci@7e30000=
0: 1
    2021-02-10 13:55:07.417000+00:00  Loading Environment from FAT... *** W=
arning - bad CRC, using default environment =

    ... (382 line(s) more)  =

 =



platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
imx8mp-evk      | arm64 | lab-nxp      | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6023e7a3395db94d9e3abe67

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc7-105-g3289=
0f947002/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc7-105-g3289=
0f947002/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6023e7a3395db94d9e3ab=
e68
        failing since 5 days (last pass: v5.11-rc6-72-gc42187278fc1, first =
fail: acpi-5.11-rc7-89-g5f8da9ef1c5d8) =

 =20
