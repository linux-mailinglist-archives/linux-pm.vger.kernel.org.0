Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFF7772367
	for <lists+linux-pm@lfdr.de>; Mon,  7 Aug 2023 14:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjHGMGv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Aug 2023 08:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjHGMGu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Aug 2023 08:06:50 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A3A106
        for <linux-pm@vger.kernel.org>; Mon,  7 Aug 2023 05:06:48 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-26854159c05so2358615a91.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Aug 2023 05:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691410008; x=1692014808;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2UNQ06Vltf6ZtuX0hw1wGpv5O2gRCxNY7XUMy+7d+pU=;
        b=zaWHbYPpJK/+IdBLKVffJ2okhRvBLKDeo67pwdZObgkETDuyZf4wXipRn4YUOFEDMQ
         NuyXNQtaysxHP7Zzh/w15WGCK2hGC/qK0u3k0ZhcBYHJc28pjVjZctuNhQWEhoYCedqZ
         jFNTWRRZZobm9RGNC3uPtFkxBtbowGuYNohwRnjlc4Nz3TlwnGdKa2K0bvqlrLDSpj81
         aZjPZkcgHNu5Wo3DhJFnYtuQtl6aVs1O/+BEchsv5X3AbUFpt6VoL2MbYBFrkNxNQVbq
         eOQoil6i0nACpnFxcRE8eA8WccVMCwu9ZbVU+DsUwbDx3VR47c0iMiLZgtC1jljygvJo
         KR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691410008; x=1692014808;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UNQ06Vltf6ZtuX0hw1wGpv5O2gRCxNY7XUMy+7d+pU=;
        b=NLtc+dFpDsal3L9Ov9fM0H2QAwB1o///Qvd/U1FGa2nN2ee/Ceosd/oZb4A04/BPwr
         wMJdENr19dT2NDfZZy/gUxAjg0ikjqfh5MSHtSxOTv7oNjDeDzJGNOqlx/5+RwSvDc/J
         8e3Ggje44OR+rKQr5PE77WIx6EjhDQDr6sXfO0bDquIo/jhcbqL0Wfd0rLxtF5M12AtA
         sAVoubMgR/zaDlTyqz5gu9BOM/NrY3A3KcncuYfpYCx47WtuP0vkPBM/wI793e1kk5mU
         rINrXlxySq6hR4J/Fckl7u80mUZ3rSWdY40ebdxIgO4GnmrUncO+VCsmMJ4Hh34jJEeE
         roAg==
X-Gm-Message-State: AOJu0YxaT+6mJWP8C3LFAqLjS5z0ra9WV7MM57v53ha6hvoV97G8p3E6
        HMVusbGiWQLHB0lXC0pKXf7tQA==
X-Google-Smtp-Source: AGHT+IFDxMlhVj98kGk1Fxf7gAhwJP9me/NIYaE8P6F9gPeHXSAxKs50wBMBCAWGD/315nmA26hjmg==
X-Received: by 2002:a17:90b:33c6:b0:263:1f1c:ef4d with SMTP id lk6-20020a17090b33c600b002631f1cef4dmr6873587pjb.10.1691410007858;
        Mon, 07 Aug 2023 05:06:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h16-20020a17090adb9000b00267eead2f16sm5901596pjv.36.2023.08.07.05.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:06:47 -0700 (PDT)
Message-ID: <64d0de57.170a0220.55002.9da9@mx.google.com>
Date:   Mon, 07 Aug 2023 05:06:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.5-rc5-68-g5fed5528c8fd
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 51 runs,
 5 regressions (v6.5-rc5-68-g5fed5528c8fd)
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

pm/testing baseline: 51 runs, 5 regressions (v6.5-rc5-68-g5fed5528c8fd)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
fsl-ls2088a-rdb    | arm64 | lab-nxp       | gcc-10   | defconfig | 1      =
    =

fsl-lx2160a-rdb    | arm64 | lab-nxp       | gcc-10   | defconfig | 1      =
    =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

r8a779m1-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.5-rc5=
-68-g5fed5528c8fd/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.5-rc5-68-g5fed5528c8fd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5fed5528c8fd31ae431594b5da0b3dfa7642d23d =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
fsl-ls2088a-rdb    | arm64 | lab-nxp       | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64d0d4988a0d91e65635b1ed

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc5-68-g5fed55=
28c8fd/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc5-68-g5fed55=
28c8fd/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0d4988a0d91e65635b1f0
        failing since 24 days (last pass: v6.0-rc3-85-gf6f4c123bfbc, first =
fail: v6.5-rc1-21-g3c61a03588dd8)

    2023-08-07T11:24:50.430027  [   12.578110] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1241367_1.5.2.4.1>
    2023-08-07T11:24:50.535309  =

    2023-08-07T11:24:50.636588  / # #export SHELL=3D/bin/sh
    2023-08-07T11:24:50.636989  =

    2023-08-07T11:24:50.737968  / # export SHELL=3D/bin/sh. /lava-1241367/e=
nvironment
    2023-08-07T11:24:50.738371  =

    2023-08-07T11:24:50.839392  / # . /lava-1241367/environment/lava-124136=
7/bin/lava-test-runner /lava-1241367/1
    2023-08-07T11:24:50.840101  =

    2023-08-07T11:24:50.844103  / # /lava-1241367/bin/lava-test-runner /lav=
a-1241367/1
    2023-08-07T11:24:50.867843  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
fsl-lx2160a-rdb    | arm64 | lab-nxp       | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64d0d4827f95c9e7bb35b244

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc5-68-g5fed55=
28c8fd/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc5-68-g5fed55=
28c8fd/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0d4827f95c9e7bb35b247
        failing since 144 days (last pass: v6.1-rc5-55-g60453df62d30, first=
 fail: v6.3-rc2-33-g1240ce78c05e)

    2023-08-07T11:24:37.983076  [   18.564058] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1241365_1.5.2.4.1>
    2023-08-07T11:24:38.088893  =

    2023-08-07T11:24:38.190138  / # #export SHELL=3D/bin/sh
    2023-08-07T11:24:38.190554  =

    2023-08-07T11:24:38.291566  / # export SHELL=3D/bin/sh. /lava-1241365/e=
nvironment
    2023-08-07T11:24:38.291973  =

    2023-08-07T11:24:38.392980  / # . /lava-1241365/environment/lava-124136=
5/bin/lava-test-runner /lava-1241365/1
    2023-08-07T11:24:38.393683  =

    2023-08-07T11:24:38.396400  / # /lava-1241365/bin/lava-test-runner /lav=
a-1241365/1
    2023-08-07T11:24:38.418933  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64d0d41f792fc1892c35b282

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc5-68-g5fed55=
28c8fd/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc5-68-g5fed55=
28c8fd/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0d41f792fc1892c35b287
        failing since 18 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-07T11:24:41.630198  / # #

    2023-08-07T11:24:41.732307  export SHELL=3D/bin/sh

    2023-08-07T11:24:41.733051  #

    2023-08-07T11:24:41.834509  / # export SHELL=3D/bin/sh. /lava-11221843/=
environment

    2023-08-07T11:24:41.835210  =


    2023-08-07T11:24:41.936659  / # . /lava-11221843/environment/lava-11221=
843/bin/lava-test-runner /lava-11221843/1

    2023-08-07T11:24:41.937840  =


    2023-08-07T11:24:41.954209  / # /lava-11221843/bin/lava-test-runner /la=
va-11221843/1

    2023-08-07T11:24:42.004809  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-07T11:24:42.005365  + cd /lava-112218<8>[   19.307844] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11221843_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a779m1-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64d0d45e7f95c9e7bb35b1da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc5-68-g5fed55=
28c8fd/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc5-68-g5fed55=
28c8fd/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d0d45e7f95c9e7bb35b1df
        failing since 18 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-07T11:24:20.205133  / # #

    2023-08-07T11:24:21.283895  export SHELL=3D/bin/sh

    2023-08-07T11:24:21.285812  #

    2023-08-07T11:24:22.776665  / # export SHELL=3D/bin/sh. /lava-11221850/=
environment

    2023-08-07T11:24:22.778548  =


    2023-08-07T11:24:25.497740  / # . /lava-11221850/environment/lava-11221=
850/bin/lava-test-runner /lava-11221850/1

    2023-08-07T11:24:25.499785  =


    2023-08-07T11:24:25.500089  / # /lava-11221850/bin/lava-test-runner /la=
va-11221850/1

    2023-08-07T11:24:25.569663  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-07T11:24:25.570153  + cd /lava-112218<8>[   28.497072] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11221850_1.5.2.4.5>
 =

    ... (44 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/64d0d52317ba91502335b1d9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc5-68-g5fed55=
28c8fd/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc5-68-g5fed55=
28c8fd/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d0d52317ba91502335b=
1da
        new failure (last pass: v6.5-rc4-68-g8a3c19975d99) =

 =20
