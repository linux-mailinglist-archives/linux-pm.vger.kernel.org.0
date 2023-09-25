Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E677AD733
	for <lists+linux-pm@lfdr.de>; Mon, 25 Sep 2023 13:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjIYLr3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Sep 2023 07:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIYLr3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Sep 2023 07:47:29 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92E7DA
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2023 04:47:22 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-57b5f0d658dso3294400eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2023 04:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695642442; x=1696247242; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FymRbtwApwrc4PB0+3FfvhkzUy5BTBOpi4eBi/++jUc=;
        b=T4F+YPJZcsx6RUxG9jdxRQjJsRUdi02kxaDzW8Z3FLvXDGBNVkNtq95zERELT7hoPT
         E5Sxj3zmxskniEucRifl8sAdsEkWKvNT/HyTW3MBSFjRz3shPUrclCoznoLZoGMqjzMQ
         7Ccl8RX6N7yoHiNWtX2e1tuTnKN4WzRK6AnUZO5vFoeu/tNQqgdbPNTVH0s1F2OaEhg9
         VaeEjzXdilZd0nMEbEFAdzgIkqmGGLOPUwHjF5Z0XXCi/arAvuLU9VdYXct6zAWhXVFW
         uk/DrWAYOXabW2cR+L3SYBFlIX5spl3fgE1+ABQIcxI5iChId5YjryVo0riiZ4afcfqJ
         fUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695642442; x=1696247242;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FymRbtwApwrc4PB0+3FfvhkzUy5BTBOpi4eBi/++jUc=;
        b=R3GsiwM4pRb7oX2Pa/AHR2986pyQe7JRF4+C3cLYE4/mHY1WFmyDPvkhBkJFVNwUHw
         1xvzstixJiI/jei634CyyP50FNMhWP2UnzyCyJD7B12XoEPjNR2MKNgih54AxTWLOS8F
         MCg9eOEd6BdCOhaR4YwC+fN2LPztELo2gbQ6jX5UXJQAQ27XUwLze+Fkyz8rZ4v04iqD
         hmjQ7TlO/IcyjiAZs7dL30nEvGTmxK0zM1ZN2ZzxVwT/OspDPj/rL+Q8xguj1rHn3q8e
         ourx0zNglYWdz1cvBIM/2lw/VcH550Q1XsDwb7kcHk9isVvAU2YkRVdlV30nbk8etRsA
         ieIA==
X-Gm-Message-State: AOJu0YxfrGOm3FIpVNKS7DcpI7hDJpygi5+MClGH52LgJbSKz7HYsVHh
        NZ7wOjEIynEu/yvCuib/CGIG7Q==
X-Google-Smtp-Source: AGHT+IHXOJ2ZeBHTzFhOhBTGj6IJMZfYB99+igJMz3oUWdZziKPr2UTG76BXovS+evU5SyOH02EI1A==
X-Received: by 2002:a05:6358:78b:b0:143:1063:d1f4 with SMTP id n11-20020a056358078b00b001431063d1f4mr7314805rwj.13.1695642442168;
        Mon, 25 Sep 2023 04:47:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a31-20020a056a001d1f00b0069266a66a6esm7580942pfx.139.2023.09.25.04.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 04:47:21 -0700 (PDT)
Message-ID: <65117349.050a0220.4fae8.ff6b@mx.google.com>
Date:   Mon, 25 Sep 2023 04:47:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.6-rc3-36-g6e2207203652
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 48 runs,
 3 regressions (v6.6-rc3-36-g6e2207203652)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 48 runs, 3 regressions (v6.6-rc3-36-g6e2207203652)

Regressions Summary
-------------------

platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
imx8mp-evk    | arm64 | lab-broonie   | gcc-10   | defconfig | 1          =

r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =

r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.6-rc3=
-36-g6e2207203652/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.6-rc3-36-g6e2207203652
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      6e220720365264d94eccc7916ef936d8d39e3040 =



Test Regressions
---------------- =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
imx8mp-evk    | arm64 | lab-broonie   | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65116943207b11ce868a0ab2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc3-36-g6e2207=
203652/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc3-36-g6e2207=
203652/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65116943207b11ce868a0aba
        failing since 12 days (last pass: pm-6.6-rc1-122-g07b618ec9d7a, fir=
st fail: v6.6-rc1-5-gb5eda4c9c923)

    2023-09-25T11:04:21.980457  + set<8>[   27.213978] <LAVA_SIGNAL_ENDRUN =
0_dmesg 130494_1.5.2.4.1>
    2023-09-25T11:04:21.981103   +x
    2023-09-25T11:04:22.094431  / # #
    2023-09-25T11:04:23.260824  export SHELL=3D/bin/sh
    2023-09-25T11:04:23.266955  #
    2023-09-25T11:04:24.765946  / # export SHELL=3D/bin/sh. /lava-130494/en=
vironment
    2023-09-25T11:04:24.771966  =

    2023-09-25T11:04:27.495043  / # . /lava-130494/environment/lava-130494/=
bin/lava-test-runner /lava-130494/1
    2023-09-25T11:04:27.501852  =

    2023-09-25T11:04:27.518407  / # /lava-130494/bin/lava-test-runner /lava=
-130494/1 =

    ... (12 line(s) more)  =

 =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/651169141f893b6a9d8a0ac7

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc3-36-g6e2207=
203652/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc3-36-g6e2207=
203652/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/651169141f893b6a9d8a0ad0
        failing since 67 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-09-25T11:07:56.533214  / # #

    2023-09-25T11:07:56.635174  export SHELL=3D/bin/sh

    2023-09-25T11:07:56.635856  #

    2023-09-25T11:07:56.737209  / # export SHELL=3D/bin/sh. /lava-11613326/=
environment

    2023-09-25T11:07:56.737790  =


    2023-09-25T11:07:56.839171  / # . /lava-11613326/environment/lava-11613=
326/bin/lava-test-runner /lava-11613326/1

    2023-09-25T11:07:56.840377  =


    2023-09-25T11:07:56.841696  / # /lava-11613326/bin/lava-test-runner /la=
va-11613326/1

    2023-09-25T11:07:56.906317  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-25T11:07:56.906819  + cd /lava-116133<8>[   20.398331] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11613326_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65116947207b11ce868a0ac8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc3-36-g6e2207=
203652/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc3-36-g6e2207=
203652/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65116947207b11ce868a0ad1
        failing since 67 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-09-25T11:06:34.023475  / # #

    2023-09-25T11:06:35.099031  export SHELL=3D/bin/sh

    2023-09-25T11:06:35.100274  #

    2023-09-25T11:06:36.589278  / # export SHELL=3D/bin/sh. /lava-11613331/=
environment

    2023-09-25T11:06:36.591231  =


    2023-09-25T11:06:39.315618  / # . /lava-11613331/environment/lava-11613=
331/bin/lava-test-runner /lava-11613331/1

    2023-09-25T11:06:39.317740  =


    2023-09-25T11:06:39.331724  / # /lava-11613331/bin/lava-test-runner /la=
va-11613331/1

    2023-09-25T11:06:39.347810  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-25T11:06:39.390855  + cd /lava-116133<8>[   29.552012] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11613331_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =20
