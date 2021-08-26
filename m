Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173EF3F8E4A
	for <lists+linux-pm@lfdr.de>; Thu, 26 Aug 2021 20:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243393AbhHZS5h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 14:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243375AbhHZS5h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 14:57:37 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C8EC061757
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 11:56:49 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id r13so3144840pff.7
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 11:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=GW5vv+4se0d7/6Njr449ocjQzAi4HUbEO9CR0+vrVpA=;
        b=Dll+itLNCGwuaSiugKlYP3Y69aT9uLtj2ehm/e5dFDDSw/jjg8YcS2+lmOLgoaIRQS
         hS6Djzu5/ihW7gjh8QL3qRJbG6x6guotj6SkII3AnnxRHt2C27ofsv1aBWfnvz7RsPN3
         kcKPg3hrHaJJwMpjx1BVcymEpTQ42br6eqvAe1VXjhspX//KkACY2FQ9aT+S6zKgUYDA
         NaGfMFunbvcSDI7KxhO/aJtUPXxg5H8e/PW0nIpEgGmTe7y5w6hgGGnC76Q1xT7/ZOoE
         TIZ2yaQcMnnH6MJrKbkBPluO7STDvSHVoLNH38eQJ04sEkMiAN4wRrDE4WT/ym0c2juA
         DSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=GW5vv+4se0d7/6Njr449ocjQzAi4HUbEO9CR0+vrVpA=;
        b=eFmd5+Lwg4Df9G8AJ221z22p7RkCKTfkkazBsERkQ77TcV/LxMtdhXU+MExPPdVMNd
         xiucw/+aZN3qwh60bG2R/QSe2mQ2Iv9ZEvfskgBrNEGUWnpDMlc70AwHAMj8OEsxdPAH
         oKbRyjlFleXw+EFaN7TPoDdkJWyrsBIUz6OfCdMgoz2MNrvnSw+MdmFY7lpbfoDL++y3
         6UADeF+gG2V4xSxSNNes8+cDuv2RtwJJa/R/rVoxe8LPXKnHjTI16BU0OH8u9ZhoMjXX
         doZy7TOK6PS+8hs9Gc3AyW+FFe/F9qdNigAyvBlotS0UVEeCGEYZaQdH8LlQNT5BvMAr
         /yNA==
X-Gm-Message-State: AOAM532VW9IhKg4yHVpmOQFpPczumxLl8PgVmyjIuEtzdOiBTZnPvoQf
        2sYQbTAJHR9QT9wDbZL5LMtkr56yuAusg6DH
X-Google-Smtp-Source: ABdhPJxh7XjzbJ03AtxCv1C5kvk8BYFQq4BSupO8vtx2OuN/qn+M6BmvqglXCF03pwT1q0KIzZKXLw==
X-Received: by 2002:aa7:86c3:0:b0:3eb:1857:8ae9 with SMTP id h3-20020aa786c3000000b003eb18578ae9mr5072652pfo.52.1630004208895;
        Thu, 26 Aug 2021 11:56:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g3sm3743301pfi.197.2021.08.26.11.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 11:56:48 -0700 (PDT)
Message-ID: <6127e3f0.1c69fb81.bbb4b.a0e6@mx.google.com>
Date:   Thu, 26 Aug 2021 11:56:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.14-rc7-64-g2a7254aa7491
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 88 runs,
 4 regressions (v5.14-rc7-64-g2a7254aa7491)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 88 runs, 4 regressions (v5.14-rc7-64-g2a7254aa7491)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
bcm2837-rpi-3-b  | arm64 | lab-baylibre  | gcc-8    | defconfig          | =
1          =

beagle-xm        | arm   | lab-baylibre  | gcc-8    | multi_v7_defconfig | =
1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.14-rc=
7-64-g2a7254aa7491/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.14-rc7-64-g2a7254aa7491
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      2a7254aa7491b3da13bb3fa15a3972f5660cd32e =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
bcm2837-rpi-3-b  | arm64 | lab-baylibre  | gcc-8    | defconfig          | =
1          =


  Details:     https://kernelci.org/test/plan/id/6127da9e378922c0218e2c7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc7-64-g2a725=
4aa7491/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc7-64-g2a725=
4aa7491/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6127da9e378922c0218e2=
c7b
        failing since 44 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1) =

 =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
beagle-xm        | arm   | lab-baylibre  | gcc-8    | multi_v7_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/6127d97fb7b0f3def78e2c89

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc7-64-g2a725=
4aa7491/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc7-64-g2a725=
4aa7491/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6127d97fb7b0f3def78e2=
c8a
        failing since 20 days (last pass: v5.14-rc3-20-g604483c9d252, first=
 fail: v5.14-rc4-28-g9ac32de19606) =

 =



platform         | arch  | lab           | compiler | defconfig          | =
regressions
-----------------+-------+---------------+----------+--------------------+-=
-----------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-8    | defconfig          | =
2          =


  Details:     https://kernelci.org/test/plan/id/6127dab5d2fdb9897d8e2cde

  Results:     89 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.14-rc7-64-g2a725=
4aa7491/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.14-rc7-64-g2a725=
4aa7491/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/arm64/baseline/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/6127dab5d2fdb9897d8e2ce4
        failing since 44 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-08-26T18:17:11.879178  /lava-4419945/1/../bin/lava-test-case
    2021-08-26T18:17:11.890003  <8>[   24.790246] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/6127dab5d2fdb9897d8e2ce5
        failing since 44 days (last pass: devprop-5.13-rc8-173-ge132b9a1079=
c, first fail: v5.14-rc1)

    2021-08-26T18:17:10.844519  /lava-4419945/1/../bin/lava-test-case
    2021-08-26T18:17:10.855725  <8>[   23.755751] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>   =

 =20
