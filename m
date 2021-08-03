Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC343DF354
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 18:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbhHCQyJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 12:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbhHCQyI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Aug 2021 12:54:08 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7487EC061757
        for <linux-pm@vger.kernel.org>; Tue,  3 Aug 2021 09:53:56 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso5591802pjo.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Aug 2021 09:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=pKASxBjj5LxdB/XIFpeEeZCvb4Eq6FLfU44aE55aSKI=;
        b=Hgy2BOmB6jOE8DEu8w7XFSoDoSZvWmKP9uRkAP+Z1NBBIPQqCd4fdCrgPp4MBuWRnx
         KGFnUqv3SRskRVwBt86URK1S95oHIXOqTG7cKpwxhIueCKPmAcuLxj80ePTLURCPCH9R
         2cAgPtaL2JD5sttlzBn0IDXElygt7CVd/SiLOjru7il0DnlUl/05/kP5YVQc0JGunf4p
         s8oLndxcw/TP/GNNpK3nCL0A8UNBurMCcsHNB6dobNDj7EqNA1wyROm8kc2TQe0emjRL
         FJ5nG4biDwiODY00ca1W+lDtvjaI2tFdlOnz1EcvaeDvGtRMa4GcrsrnTAHbpz0Ijrr7
         f2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=pKASxBjj5LxdB/XIFpeEeZCvb4Eq6FLfU44aE55aSKI=;
        b=lqHUGbex4fkTHJpUdBLitYa+2eYYUREw+No0LXdC/SpKqKGgjmI9k86+OaKoAyZhPn
         azVjIuSNDV2vQHzZQqeM7f2ncLeqVnO6zmBpthwuW7/GTWkKSqjoV7KJAuizhx9U46EY
         bqVxzvG0DHQIjKBPZ0vpa8WJwCjOlSgK8jlwHYNTGzbc3uFLW5j5PqfN+X/vK9O0oGV6
         agjlkndcyLek8s+EQnzNPIlWnvfENT0OlpiAp0FyZ7o3ZjLivpdfyduBz5ElIY8d0QUp
         rKeJv6J8JwTMUvSqO13kDNbbQp2eneadboYgIZ9dGclkKSAKT4hgavCJL449M10dSLkS
         Y8Tg==
X-Gm-Message-State: AOAM532b7/j7tpa/bQ5xPlIq9ijIjLU24P2AzKmbobOSVYWeb3gPhymi
        cDm+S2M1EYPJYBDv1nHZGj9eGA==
X-Google-Smtp-Source: ABdhPJzbn/zF+ZC99DudkjEMAHlFn/hCmTrw4ZmYUk+gJvwxEEyYeKPxuq8m1ADhkLFOC0LVN0mAbg==
X-Received: by 2002:a63:b91d:: with SMTP id z29mr2040397pge.436.1628009635953;
        Tue, 03 Aug 2021 09:53:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v31sm17389822pgl.49.2021.08.03.09.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 09:53:55 -0700 (PDT)
Message-ID: <610974a3.1c69fb81.9f10.1cfa@mx.google.com>
Date:   Tue, 03 Aug 2021 09:53:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.14-rc4-14-g392ac3ea48ca
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 92 runs,
 4 regressions (v5.14-rc4-14-g392ac3ea48ca)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 92 runs, 4 regressions (v5.14-rc4-14-g392ac3ea48ca)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
bcm2837-rpi-3-b  | arm64 | lab-baylibre  | gcc-8    | defconfig | 1        =
  =

hip07-d05        | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 2        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.14-rc=
4-14-g392ac3ea48ca/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.14-rc4-14-g392ac3ea48ca
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      392ac3ea48ca393968b11b98ea9e026203b1bcee =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
bcm2837-rpi-3-b  | arm64 | lab-baylibre  | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/61096a61f5c8155a6bb13697

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc4-14-g392ac=
3ea48ca/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc4-14-g392ac=
3ea48ca/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/61096a61f5c8155a6bb13=
698
        failing since 21 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1) =

 =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
hip07-d05        | arm64 | lab-collabora | gcc-8    | defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/61096d8b085a3c99edb13695

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc4-14-g392ac=
3ea48ca/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc4-14-g392ac=
3ea48ca/arm64/defconfig/gcc-8/lab-collabora/baseline-hip07-d05.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/61096d8b085a3c99edb13=
696
        failing since 33 days (last pass: pm-5.13-rc8-159-g3304616e985f, fi=
rst fail: devprop-5.13-rc8-173-ge132b9a1079c) =

 =



platform         | arch  | lab           | compiler | defconfig | regressio=
ns
-----------------+-------+---------------+----------+-----------+----------=
--
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig | 2        =
  =


  Details:     https://kernelci.org/test/plan/id/61096a3de04ad5f2c9b136b5

  Results:     89 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc4-14-g392ac=
3ea48ca/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc4-14-g392ac=
3ea48ca/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/61096a3de04ad5f2c9b136bf
        failing since 21 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-08-03T16:09:05.832477  /lava-4318852/1/../bin/lava-test-case   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/61096a3de04ad5f2c9b136c0
        failing since 21 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-08-03T16:09:04.797390  /lava-4318852/1/../bin/lava-test-case
    2021-08-03T16:09:04.808934  <8>[   24.036187] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>   =

 =20
