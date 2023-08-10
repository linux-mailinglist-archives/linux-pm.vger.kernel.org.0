Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FED77836A
	for <lists+linux-pm@lfdr.de>; Fri, 11 Aug 2023 00:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjHJWDR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Aug 2023 18:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjHJWDN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2023 18:03:13 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1310B26B2
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 15:03:09 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bc6624623cso12295565ad.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2023 15:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691704988; x=1692309788;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pem43z0D3qwmX7WyK6b/Y8TvgGaInUh4KKPXeSDZex4=;
        b=pL1iKIpKMn96FmRogWmbDU84S2zQm0W43ljxbakMw+x6kdpVnU3AEWIIl2HaMYOPlt
         0SMbliw6nzsQwVqGp0LNco7AgmvM9Ffc7oweM4pLaJiu0WB18kr0H5RUuNSNI0Q6h4I1
         guw2DjcoAfgfF/YyDjeq7tGwwql/rXHEH3ITASEpM2ZPnKw8qDtXyqRFkk34ugpYsqgE
         9COp67q2UJIqN6+lOxXSQt/RNgwv6dqqtsO8joubyVhElZIOhysj8YNQlnKRGaRbJYhe
         zAgeAUP9wNcT0KsF/Lt972UjQUeEQngR4s2OcyOHQD0cj+jWVlBEaBTt8Rr25s5NAiSG
         opSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691704988; x=1692309788;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pem43z0D3qwmX7WyK6b/Y8TvgGaInUh4KKPXeSDZex4=;
        b=d7fkhD8JB045plID5ttCW5D7xWXbl9AUn84Hmp0m1GsjSX/e3bz/+dq6523PEG1Mfb
         T6pbz4zdidIxF/AAZtNDIApkpX1ik4VzB6o/nrN7k8H4PzM24k9/S6PHpA6G2h8k1lz7
         POGc4Te/2Qp+GvtGVKotTmc8Jb1LuM9sLxmYAg+BttT/e/4pcq8l6+3GpmlagGYkeib5
         9vDiK+skRDz4rZEY5ihFCpk32Ed6mSdZiHQqd9xJtS5aEb+5BxmQA6ubprXHPXtTuLOH
         LKCr4lqa5fke3w/qCeBCkjxzkk0M7QXIV66r2Dyjqo5qQmerEqsKCrPmNvhNuizcG+Sg
         48xg==
X-Gm-Message-State: AOJu0YzImLIkP5Vy8HnRO88z2OTjKK4+FSxQA6ybbhcVzt0GAXq2sJfX
        lb21D5G/dIstXbP4505lXbf/ycP7G3vG6WRDT7gb+g==
X-Google-Smtp-Source: AGHT+IEFaAze6NVQXxBHBZ9CWPckxz5nHp0o6IAaDiPyRmqxqltwLuPsT+JTEqbgjwfTMLgerTfztA==
X-Received: by 2002:a17:903:230a:b0:1bc:671d:6d28 with SMTP id d10-20020a170903230a00b001bc671d6d28mr107123plh.10.1691704988405;
        Thu, 10 Aug 2023 15:03:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b001bb28b9a40dsm2278091plh.11.2023.08.10.15.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 15:03:07 -0700 (PDT)
Message-ID: <64d55e9b.170a0220.89806.4a1b@mx.google.com>
Date:   Thu, 10 Aug 2023 15:03:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.5-rc5-81-gfac64c1cae9e
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 51 runs,
 4 regressions (v6.5-rc5-81-gfac64c1cae9e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 51 runs, 4 regressions (v6.5-rc5-81-gfac64c1cae9e)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
fsl-ls2088a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =

fsl-lx2160a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =

r8a77960-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =

r8a779m1-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.5-rc5=
-81-gfac64c1cae9e/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.5-rc5-81-gfac64c1cae9e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      fac64c1cae9e3d53eb271e93c51639565dca406c =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
fsl-ls2088a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64d554f19d1c64694635b1d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc5-81-gfac64c=
1cae9e/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc5-81-gfac64c=
1cae9e/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d554f19d1c64694635b1dc
        failing since 27 days (last pass: v6.0-rc3-85-gf6f4c123bfbc, first =
fail: v6.5-rc1-21-g3c61a03588dd8)

    2023-08-10T21:21:41.166832  [   16.871360] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1242598_1.5.2.4.1>
    2023-08-10T21:21:41.272058  =

    2023-08-10T21:21:41.373333  / # #export SHELL=3D/bin/sh
    2023-08-10T21:21:41.373777  =

    2023-08-10T21:21:41.474719  / # export SHELL=3D/bin/sh. /lava-1242598/e=
nvironment
    2023-08-10T21:21:41.475121  =

    2023-08-10T21:21:41.576082  / # . /lava-1242598/environment/lava-124259=
8/bin/lava-test-runner /lava-1242598/1
    2023-08-10T21:21:41.576751  =

    2023-08-10T21:21:41.580697  / # /lava-1242598/bin/lava-test-runner /lav=
a-1242598/1
    2023-08-10T21:21:41.602982  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
fsl-lx2160a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64d554eeb33a12fe3f35b1e1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc5-81-gfac64c=
1cae9e/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc5-81-gfac64c=
1cae9e/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d554eeb33a12fe3f35b1e4
        failing since 147 days (last pass: v6.1-rc5-55-g60453df62d30, first=
 fail: v6.3-rc2-33-g1240ce78c05e)

    2023-08-10T21:21:25.711953  [   13.304772] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1242596_1.5.2.4.1>
    2023-08-10T21:21:25.817598  =

    2023-08-10T21:21:25.918799  / # #export SHELL=3D/bin/sh
    2023-08-10T21:21:25.919351  =

    2023-08-10T21:21:26.020379  / # export SHELL=3D/bin/sh. /lava-1242596/e=
nvironment
    2023-08-10T21:21:26.020781  =

    2023-08-10T21:21:26.121730  / # . /lava-1242596/environment/lava-124259=
6/bin/lava-test-runner /lava-1242596/1
    2023-08-10T21:21:26.122390  =

    2023-08-10T21:21:26.126320  / # /lava-1242596/bin/lava-test-runner /lav=
a-1242596/1
    2023-08-10T21:21:26.148367  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
r8a77960-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64d5546fcfb2d7f91435b1f0

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc5-81-gfac64c=
1cae9e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc5-81-gfac64c=
1cae9e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d5546fcfb2d7f91435b1f5
        failing since 22 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-10T21:21:00.818543  / # #

    2023-08-10T21:21:00.920635  export SHELL=3D/bin/sh

    2023-08-10T21:21:00.921364  #

    2023-08-10T21:21:01.022601  / # export SHELL=3D/bin/sh. /lava-11257325/=
environment

    2023-08-10T21:21:01.023258  =


    2023-08-10T21:21:01.124605  / # . /lava-11257325/environment/lava-11257=
325/bin/lava-test-runner /lava-11257325/1

    2023-08-10T21:21:01.125749  =


    2023-08-10T21:21:01.127432  / # /lava-11257325/bin/lava-test-runner /la=
va-11257325/1

    2023-08-10T21:21:01.192455  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-10T21:21:01.193003  + cd /lav<8>[   19.373830] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11257325_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64d554902d86015f5735b414

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc5-81-gfac64c=
1cae9e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc5-81-gfac64c=
1cae9e/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d554902d86015f5735b419
        failing since 22 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-10T21:20:36.470807  / # #

    2023-08-10T21:20:37.551540  export SHELL=3D/bin/sh

    2023-08-10T21:20:37.553526  #

    2023-08-10T21:20:39.044636  / # export SHELL=3D/bin/sh. /lava-11257322/=
environment

    2023-08-10T21:20:39.046481  =


    2023-08-10T21:20:41.772029  / # . /lava-11257322/environment/lava-11257=
322/bin/lava-test-runner /lava-11257322/1

    2023-08-10T21:20:41.774543  =


    2023-08-10T21:20:41.777521  / # /lava-11257322/bin/lava-test-runner /la=
va-11257322/1

    2023-08-10T21:20:41.844170  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-10T21:20:41.844683  + cd /lava-112573<8>[   28.530343] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11257322_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =20
