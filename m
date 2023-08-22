Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA2478493C
	for <lists+linux-pm@lfdr.de>; Tue, 22 Aug 2023 20:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjHVSG4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Aug 2023 14:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHVSG4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2023 14:06:56 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B933B10EF
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2023 11:06:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68a3b66f350so2663939b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2023 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692727581; x=1693332381;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eAX2Wn+0wfD5l7H+In69JOkLyyFzmKeFV1SSfjBJXLM=;
        b=SF1mvAUa1CfA2hxaYJbEjJDdJ5Ti6/uyQtrPAeIoXIhjda7QdcobAHldHWEGYLjyou
         9FLTQ10fTJqi7bhSELidG+i6e2Etyq+m4ztPIVKLAb3dHWHiNg/8VIT7Oxg5NsdT0hcu
         PeJcd6v3rsbQtQ36K4YfjjUEw0HPkauMS3uS2rauWRnW6h+/yDSKmPwF0Y2knSxzrm/w
         mPKo8MDjRBnKYAjghEcMM9KURAKsU89B5Lv9qkF9q57NYIf6yEDDpRO10hjMJW3U9S7Y
         1Hg3iI9v5qUp/lAXqFywcVLSrY/L77MNfIvUkc8PtY84NfM7Si2gpZvyQr9n7V/M1/uy
         mbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692727581; x=1693332381;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAX2Wn+0wfD5l7H+In69JOkLyyFzmKeFV1SSfjBJXLM=;
        b=EHH2YQZGs2llxxlJoLa46KyLfOTgTT05fK6uMwWquiIo4pR3fgf3HCPiE5dBhNCOZC
         ++kq8B40x6XJJFeqyXVAYw+y1IDkkVeGqngpmOA1fbc+uUk+EloiXWK4IdokJGYQ1NGF
         i60r4zasfrqrR4/BL8NF/ghtVN4dQoYtJK5QU2CiB12AOS1lfL1AeF8TNboV9PWShv/P
         MOtBuYE58Ff72v7h7Qluvi3O7UJYSVK6XlRzFjZZpLAm1SQz6Ae4VIKYCndQ2v7eYmT1
         8sGNYx7t4yvUsbHM5gARQKbeSTRDG7rGFevZDlqt8kpZNBKOfjwjB6lWR/tf2dN2SfVI
         SreA==
X-Gm-Message-State: AOJu0YwLImOM+y4YCh+VkfcOZwwQyf/Ksi+1/0nBDPPh/3PnRYtBtBmb
        ZXzdCuIuQOgEaHEqGc7/ONWYkg==
X-Google-Smtp-Source: AGHT+IHPFFuctPqxfJsq1FMZxLpWbOU/pj9mZcdXnIpda00OI0MCVKRsmoTQmbtOOkVXL4J1qmBQtw==
X-Received: by 2002:a05:6a00:2190:b0:667:e17e:85b7 with SMTP id h16-20020a056a00219000b00667e17e85b7mr12684833pfi.1.1692727581093;
        Tue, 22 Aug 2023 11:06:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j25-20020aa78019000000b0068842ebfd10sm3270189pfi.160.2023.08.22.11.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 11:06:20 -0700 (PDT)
Message-ID: <64e4f91c.a70a0220.a148c.7453@mx.google.com>
Date:   Tue, 22 Aug 2023 11:06:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.5-rc7-123-g85ad73d0eb586
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 50 runs,
 4 regressions (v6.5-rc7-123-g85ad73d0eb586)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 50 runs, 4 regressions (v6.5-rc7-123-g85ad73d0eb586)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
fsl-ls2088a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =

fsl-lx2160a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =

r8a77960-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =

r8a779m1-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.5-rc7=
-123-g85ad73d0eb586/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.5-rc7-123-g85ad73d0eb586
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      85ad73d0eb5866c72af45341e30533e3066b3d9c =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
fsl-ls2088a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4ef5e3c8f89daecb1e3b8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc7-123-g85ad7=
3d0eb586/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc7-123-g85ad7=
3d0eb586/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4ef5e3c8f89daecb1e3bb
        failing since 39 days (last pass: v6.0-rc3-85-gf6f4c123bfbc, first =
fail: v6.5-rc1-21-g3c61a03588dd8)

    2023-08-22T17:24:26.933399  + [   13.331862] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1244921_1.5.2.4.1>
    2023-08-22T17:24:26.933717  set +x
    2023-08-22T17:24:27.039586  =

    2023-08-22T17:24:27.140845  / # #export SHELL=3D/bin/sh
    2023-08-22T17:24:27.141287  =

    2023-08-22T17:24:27.242273  / # export SHELL=3D/bin/sh. /lava-1244921/e=
nvironment
    2023-08-22T17:24:27.242715  =

    2023-08-22T17:24:27.343715  / # . /lava-1244921/environment/lava-124492=
1/bin/lava-test-runner /lava-1244921/1
    2023-08-22T17:24:27.344481  =

    2023-08-22T17:24:27.348749  / # /lava-1244921/bin/lava-test-runner /lav=
a-1244921/1 =

    ... (12 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
fsl-lx2160a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4ef727f767b91f3b1e3be

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc7-123-g85ad7=
3d0eb586/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc7-123-g85ad7=
3d0eb586/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4ef727f767b91f3b1e3c1
        failing since 159 days (last pass: v6.1-rc5-55-g60453df62d30, first=
 fail: v6.3-rc2-33-g1240ce78c05e)

    2023-08-22T17:24:45.622355  [   15.784209] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1244920_1.5.2.4.1>
    2023-08-22T17:24:45.727359  =

    2023-08-22T17:24:45.828755  / # #export SHELL=3D/bin/sh
    2023-08-22T17:24:45.829231  =

    2023-08-22T17:24:45.930208  / # export SHELL=3D/bin/sh. /lava-1244920/e=
nvironment
    2023-08-22T17:24:45.930868  =

    2023-08-22T17:24:46.032117  / # . /lava-1244920/environment/lava-124492=
0/bin/lava-test-runner /lava-1244920/1
    2023-08-22T17:24:46.033102  =

    2023-08-22T17:24:46.036950  / # /lava-1244920/bin/lava-test-runner /lav=
a-1244920/1
    2023-08-22T17:24:46.058991  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
r8a77960-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4eeeca1988f7cd6b1e3b8

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc7-123-g85ad7=
3d0eb586/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc7-123-g85ad7=
3d0eb586/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4eeeca1988f7cd6b1e3bd
        failing since 33 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-22T17:24:15.814390  / # #

    2023-08-22T17:24:15.916528  export SHELL=3D/bin/sh

    2023-08-22T17:24:15.917281  #

    2023-08-22T17:24:16.018620  / # export SHELL=3D/bin/sh. /lava-11331917/=
environment

    2023-08-22T17:24:16.019318  =


    2023-08-22T17:24:16.120458  / # . /lava-11331917/environment/lava-11331=
917/bin/lava-test-runner /lava-11331917/1

    2023-08-22T17:24:16.120785  =


    2023-08-22T17:24:16.122128  / # /lava-11331917/bin/lava-test-runner /la=
va-11331917/1

    2023-08-22T17:24:16.187480  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-22T17:24:16.187662  + cd /lava-1133191<8>[   19.297852] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11331917_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64e4eef71628b2a7d1b1e3c5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc7-123-g85ad7=
3d0eb586/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc7-123-g85ad7=
3d0eb586/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64e4eef71628b2a7d1b1e3ca
        failing since 33 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-22T17:22:58.254425  / # #

    2023-08-22T17:22:59.334224  export SHELL=3D/bin/sh

    2023-08-22T17:22:59.336157  #

    2023-08-22T17:23:00.826461  / # export SHELL=3D/bin/sh. /lava-11331916/=
environment

    2023-08-22T17:23:00.828257  =


    2023-08-22T17:23:03.551614  / # . /lava-11331916/environment/lava-11331=
916/bin/lava-test-runner /lava-11331916/1

    2023-08-22T17:23:03.553975  =


    2023-08-22T17:23:03.562815  / # /lava-11331916/bin/lava-test-runner /la=
va-11331916/1

    2023-08-22T17:23:03.623955  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-22T17:23:03.624491  + cd /lava-113319<8>[   28.483104] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11331916_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =20
