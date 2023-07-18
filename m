Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C521C7588E4
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jul 2023 01:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjGRXHo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jul 2023 19:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjGRXHm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2023 19:07:42 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85A9F1
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2023 16:07:32 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bb119be881so43217715ad.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Jul 2023 16:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689721652; x=1692313652;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0l9VgtNBetGd1ISCNtD/lUOPGpfUweqcmdGhYkca9nk=;
        b=KZ9ksFYkdieOBMpIcq2FqDghDzzeBmiFqU26Ji2x+SfstRbY+HCw4Q8vERl5QStjST
         k0PwGZ7TXubH2Di2jYbI3Fe9QQ0PNkL4XKSV97n9vf8FHeHbdNz4/iaDqLAFzBbVguE0
         zCIpp//cH/ctG4pk0Z7AAWAREdpMk8Ft3j4CGCweuDylW8AcBpHoJ/djxwOq6Jb0ymO7
         rUCVDuF3Qsugvw3U+nrAXnY3TjZj8fkjPCgZVCIZorMaaXSJlyfJErMNubCdkJVukAHG
         U7L7Glu/SIIitkVXBzU9+98bElkdyQS3LRYEeZ3rhWOG9Qefu5YNw7nfE0x8U8XIifoN
         mrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689721652; x=1692313652;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0l9VgtNBetGd1ISCNtD/lUOPGpfUweqcmdGhYkca9nk=;
        b=SxoKn5nT4UGd78cNmTUU/8V7eqcLbqfOPrNcqHFIagYI0l0uE31+vNYVIxMG/+ioAL
         rm5lD7PrVGKZGbazg0n8SKSo5Tab6TjyvXhWXJkobaziQxpFG23r1Pyv6OHpOCdnXgkh
         bWC0inVKRT+dYC/zMDOGwg08baGgq6AxIHrwn3I34Zi5z9WjXp47rOLImLVsapwKUIbg
         vx8OC7n6MKoHlv1l14jK72KOtQxWiG/o72S3HqQ7hECwmgT3kpOdzQiKMFp3Aw5zZWE7
         6IlZJmZVdviAh3YRY112j9t0XPlQX6UhEoIb9rNoe2sEc9l4P6rvWo+iTLHUn4Q+PiMU
         5sug==
X-Gm-Message-State: ABy/qLaFmPnKl59KhifD79bzAfoaIH1vx1rOHNRM/v4C3sN3RQLkUqmr
        7+iWzjpbicyJsCHD9MCusv/yvQ==
X-Google-Smtp-Source: APBJJlHuxOgg2JhTLvDfbykl7e9v2m1vCBofOOnZ/IWDzsy519/EknOWkjh1Qg8M2Hd/uAaTrOVS0w==
X-Received: by 2002:a17:902:ce84:b0:1b8:5aa1:4d10 with SMTP id f4-20020a170902ce8400b001b85aa14d10mr20518845plg.54.1689721652217;
        Tue, 18 Jul 2023 16:07:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709028f8f00b001b5656b0bf9sm2355207plo.286.2023.07.18.16.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 16:07:31 -0700 (PDT)
Message-ID: <64b71b33.170a0220.3caa8.5ecf@mx.google.com>
Date:   Tue, 18 Jul 2023 16:07:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.5-rc2-42-g6e9908abf1d1
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 39 runs,
 4 regressions (v6.5-rc2-42-g6e9908abf1d1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 39 runs, 4 regressions (v6.5-rc2-42-g6e9908abf1d1)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
fsl-ls2088a-rdb              | arm64 | lab-nxp     | gcc-10   | defconfig |=
 1          =

fsl-lx2160a-rdb              | arm64 | lab-nxp     | gcc-10   | defconfig |=
 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.5-rc2=
-42-g6e9908abf1d1/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.5-rc2-42-g6e9908abf1d1
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      6e9908abf1d156c4be5736acfdbd73974b8af772 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
fsl-ls2088a-rdb              | arm64 | lab-nxp     | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64b7116eb4b1ba58bf8ace1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc2-42-g6e9908=
abf1d1/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc2-42-g6e9908=
abf1d1/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b7116eb4b1ba58bf8ace1f
        failing since 4 days (last pass: v6.0-rc3-85-gf6f4c123bfbc, first f=
ail: v6.5-rc1-21-g3c61a03588dd8)

    2023-07-18T22:25:28.260423  + [   12.701678] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1237446_1.5.2.4.1>
    2023-07-18T22:25:28.260670  set +x
    2023-07-18T22:25:28.365724  =

    2023-07-18T22:25:28.466899  / # #export SHELL=3D/bin/sh
    2023-07-18T22:25:28.467357  =

    2023-07-18T22:25:28.568318  / # export SHELL=3D/bin/sh. /lava-1237446/e=
nvironment
    2023-07-18T22:25:28.568736  =

    2023-07-18T22:25:28.669717  / # . /lava-1237446/environment/lava-123744=
6/bin/lava-test-runner /lava-1237446/1
    2023-07-18T22:25:28.670399  =

    2023-07-18T22:25:28.674390  / # /lava-1237446/bin/lava-test-runner /lav=
a-1237446/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
fsl-lx2160a-rdb              | arm64 | lab-nxp     | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64b71171b4b1ba58bf8ace28

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc2-42-g6e9908=
abf1d1/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc2-42-g6e9908=
abf1d1/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b71171b4b1ba58bf8ace2b
        failing since 125 days (last pass: v6.1-rc5-55-g60453df62d30, first=
 fail: v6.3-rc2-33-g1240ce78c05e)

    2023-07-18T22:25:33.801602  [   12.999001] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1237447_1.5.2.4.1>
    2023-07-18T22:25:33.907687  =

    2023-07-18T22:25:34.008875  / # #export SHELL=3D/bin/sh
    2023-07-18T22:25:34.009304  =

    2023-07-18T22:25:34.110229  / # export SHELL=3D/bin/sh. /lava-1237447/e=
nvironment
    2023-07-18T22:25:34.110658  =

    2023-07-18T22:25:34.211661  / # . /lava-1237447/environment/lava-123744=
7/bin/lava-test-runner /lava-1237447/1
    2023-07-18T22:25:34.212377  =

    2023-07-18T22:25:34.215236  / # /lava-1237447/bin/lava-test-runner /lav=
a-1237447/1
    2023-07-18T22:25:34.238169  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64b7136b976f67fe198ace25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc2-42-g6e9908=
abf1d1/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc2-42-g6e9908=
abf1d1/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b7136b976f67fe198ac=
e26
        failing since 7 days (last pass: v6.4-rc7-126-gf28ec6369334, first =
fail: v6.5-rc1-15-g61ca8e67fe61) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64b71176b4b1ba58bf8ace36

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc2-42-g6e9908=
abf1d1/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all-=
h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc2-42-g6e9908=
abf1d1/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all-=
h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b71176b4b1ba58bf8ac=
e37
        new failure (last pass: pm-6.5-rc2-210-ga648a2d354da) =

 =20
