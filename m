Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8013577B5CA
	for <lists+linux-pm@lfdr.de>; Mon, 14 Aug 2023 11:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjHNJxh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Aug 2023 05:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbjHNJxU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Aug 2023 05:53:20 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D628E63
        for <linux-pm@vger.kernel.org>; Mon, 14 Aug 2023 02:53:19 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bba48b0bd2so26399765ad.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Aug 2023 02:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692006798; x=1692611598;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+CNIP874majVhsUK1Xj81YpaEE3ZMBgzMg09XqpyhA=;
        b=OjwTDexztYAgeE6FB8ZFxPd/YWo4mbIx00VIq8If5QUACFI1GJe/Jt9CZzaTcBKdaO
         1Bro94btcszyeeh1G1ZQbK+oR85aO+qM5VdZIQEDXSsg1IQa/gtKZL6etIoX5U0VD5E7
         J5uKwZGCM4086llxU//aBUlCrXNkA2eU+4UMd56kUtV7d0I5mb1jthq0Vn54mdvEDy3n
         Xgq8XjvwUFrnck4f3J0kQuUTMmn1DZNoIbL2FtRP+EdRu1mGfnCjo+Ouow48ugMGm8n1
         hclYPQ55Ox3h7i4Q8Ra00KM0SHfIjbyjjWprXXc7tBJDn4aSawpblfDULygbprm8/MTn
         Vrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692006798; x=1692611598;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+CNIP874majVhsUK1Xj81YpaEE3ZMBgzMg09XqpyhA=;
        b=YenYsS3ZwEartiRiiLU+7jJX994fwWA6xkSrJOBzCUdEMnBF3HBw5yYqH6vzbKRps1
         DBPEgSDBComCUTYAoU7AwtJpD4rUf5xkKJVBGFUVy88O+8UtxfJKzZBxKplkecY6gyW5
         /DP8EmOO6b3ybun3I+CyRZD6aNPm3dKH/9sp/1vYqPnd6FynE1f9ht72EPv0U/489ito
         oub4becwl5iRtaD9jNhKRntw2GzH/EbihR1wq3PXXQ9Pxuy/HdhdHfF3Q+XrvFEzCIsW
         9P5lJ6MfRGZv2+ombO7tm1w/GFOTCffBUSyLwNRmpEqEqu+LwXGpMuOqpbK6kj42FaST
         7mcw==
X-Gm-Message-State: AOJu0YyYspcjFx+JpLfjEq7bCk+TUct4HicYGm2GPMR+UngX9jWmG39G
        7DU8kEWg7E88emetaXmRgb2TSdOFYHVcLyxd56LtPiZ0
X-Google-Smtp-Source: AGHT+IHSKaRkveuhboOA0tTE2NzXdcUaKuaBVFH0c6ezNrPT2dGlRkTL8Z6MexkDDvNFSXz+mtunAw==
X-Received: by 2002:a17:902:ec8b:b0:1bc:2c79:c6b5 with SMTP id x11-20020a170902ec8b00b001bc2c79c6b5mr10936508plg.4.1692006798351;
        Mon, 14 Aug 2023 02:53:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d19-20020a170902729300b001b8b0ac2258sm8992220pll.174.2023.08.14.02.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 02:53:17 -0700 (PDT)
Message-ID: <64d9f98d.170a0220.f4699.ef87@mx.google.com>
Date:   Mon, 14 Aug 2023 02:53:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.5-rc6-81-ge8cde28ba5123
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 46 runs,
 3 regressions (v6.5-rc6-81-ge8cde28ba5123)
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

pm/testing baseline: 46 runs, 3 regressions (v6.5-rc6-81-ge8cde28ba5123)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
fsl-ls2088a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =

fsl-lx2160a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =

r8a779m1-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.5-rc6=
-81-ge8cde28ba5123/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.5-rc6-81-ge8cde28ba5123
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      e8cde28ba5123d05b6d2639ba8e0a3e0b96b37e0 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
fsl-ls2088a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9efb7d78724754335b1d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc6-81-ge8cde2=
8ba5123/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc6-81-ge8cde2=
8ba5123/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d9efb7d78724754335b1dc
        failing since 31 days (last pass: v6.0-rc3-85-gf6f4c123bfbc, first =
fail: v6.5-rc1-21-g3c61a03588dd8)

    2023-08-14T09:11:02.420330  [   13.295688] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1243513_1.5.2.4.1>
    2023-08-14T09:11:02.526226  =

    2023-08-14T09:11:02.627504  / # #export SHELL=3D/bin/sh
    2023-08-14T09:11:02.628034  =

    2023-08-14T09:11:02.729024  / # export SHELL=3D/bin/sh. /lava-1243513/e=
nvironment
    2023-08-14T09:11:02.729471  =

    2023-08-14T09:11:02.830473  / # . /lava-1243513/environment/lava-124351=
3/bin/lava-test-runner /lava-1243513/1
    2023-08-14T09:11:02.831252  =

    2023-08-14T09:11:02.835220  / # /lava-1243513/bin/lava-test-runner /lav=
a-1243513/1
    2023-08-14T09:11:02.858613  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
fsl-lx2160a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9efb4f15cbc2b1935b1e8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc6-81-ge8cde2=
8ba5123/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc6-81-ge8cde2=
8ba5123/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d9efb4f15cbc2b1935b1eb
        failing since 151 days (last pass: v6.1-rc5-55-g60453df62d30, first=
 fail: v6.3-rc2-33-g1240ce78c05e)

    2023-08-14T09:10:56.470649  [   13.374931] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1243512_1.5.2.4.1>
    2023-08-14T09:10:56.575801  =

    2023-08-14T09:10:56.677005  / # #export SHELL=3D/bin/sh
    2023-08-14T09:10:56.677408  =

    2023-08-14T09:10:56.778353  / # export SHELL=3D/bin/sh. /lava-1243512/e=
nvironment
    2023-08-14T09:10:56.778756  =

    2023-08-14T09:10:56.879702  / # . /lava-1243512/environment/lava-124351=
2/bin/lava-test-runner /lava-1243512/1
    2023-08-14T09:10:56.880367  =

    2023-08-14T09:10:56.884304  / # /lava-1243512/bin/lava-test-runner /lav=
a-1243512/1
    2023-08-14T09:10:56.907576  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9f82b382db9582f35b1f1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc6-81-ge8cde2=
8ba5123/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc6-81-ge8cde2=
8ba5123/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d9f82b382db9582f35b1f6
        failing since 25 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-14T09:47:12.696484  / # #

    2023-08-14T09:47:13.772054  export SHELL=3D/bin/sh

    2023-08-14T09:47:13.773863  #

    2023-08-14T09:47:15.258979  / # export SHELL=3D/bin/sh. /lava-11282763/=
environment

    2023-08-14T09:47:15.260226  =


    2023-08-14T09:47:17.974024  / # . /lava-11282763/environment/lava-11282=
763/bin/lava-test-runner /lava-11282763/1

    2023-08-14T09:47:17.975380  =


    2023-08-14T09:47:17.990979  / # /lava-11282763/bin/lava-test-runner /la=
va-11282763/1

    2023-08-14T09:47:18.007378  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-14T09:47:18.050186  + cd /lava-11282763/<8>[   28.406180] <LAVA=
_SIGNAL_STARTRUN 1_bootrr 11282763_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =20
