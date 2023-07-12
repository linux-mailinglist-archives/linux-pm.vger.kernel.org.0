Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37EF750964
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jul 2023 15:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjGLNQf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jul 2023 09:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjGLNQe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2023 09:16:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC06B1994
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 06:16:33 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6682909acadso3900864b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689167793; x=1691759793;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QGdoVKECxiz1rKe0OBiDdQU665x2VaaVfR9buHHDKik=;
        b=pNEVwlV9O+qfqN9JbHWTuMnM3y930vBAQb6Br351W4w8LcrczHWjmpoqY8Raj2V5v4
         Qrk9PWoZvv9kDMiOaZDXGDLAhFlorju3QqmYs74+SeEFtjmVoQ1ievV7WCMq+DgYqvX8
         TchfRVa4qgNMaTS2n+mg+k3/tqFyfxrF8FGrhU2xaEiADcpZ08r6W0xOJSVmSl9aYXIY
         MFiYSYHebgMjfvdFuZ6O/DzSYGkRArP+6+x5iQ02hNVfi4IZ4YSqFHXDxdzOhJnvbg+o
         T8tTsxDrqUfybxXvmrLSOU0mLIGdnYUI1BKqwCIj1qKiS3jZhdRMD62ffdP1ZJm+ewg6
         IxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689167793; x=1691759793;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QGdoVKECxiz1rKe0OBiDdQU665x2VaaVfR9buHHDKik=;
        b=lJZxY+zZEy6w02nBjMsEZvsGnppOmoJ/hpMAXPvfYXqWeujYoVtRQIjGsCDcPjl65+
         7pMjXfjfV5wEDon4bdWxNWI5N3yTKA7lAjDpxJN+nmHZpuV3UhJzcS1y99CelKa8dSHq
         YD+3ZVroiCrv6+WdL1tntkj0ofNrWCSAv1wa5cWzcAujTpvFLyB7MzpZzToKPOG7HLgx
         J09TzMn6Lza3J88E7jRgs9GFjZnfoQjZvJ7O2ppndvFyhxWZ1OH78KtI2jiXrFnOHhxv
         WX2hQoAH0RQauJRVbe36Y1po8z5/nUwhM+BT60NpfRwf0o1nUMV4FuQva4HFtmV3NnsW
         VFTg==
X-Gm-Message-State: ABy/qLaGbHRHHHS6yU+1XkzAig8KzbXEAEfOdQ+dxqKjG6bvkARojOaf
        AJ5cQkuFLBb3pOy43LpYoC7oeQ==
X-Google-Smtp-Source: APBJJlF3H6YlwE9l+h31kZLoS1RlFDSQPrxoJkEdo3xJb+JP8ba0VM8QjMokYXOD54DPdqQeU6FfSw==
X-Received: by 2002:a05:6a20:a113:b0:132:cd2d:16fd with SMTP id q19-20020a056a20a11300b00132cd2d16fdmr1349174pzk.38.1689167793148;
        Wed, 12 Jul 2023 06:16:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t9-20020a63b709000000b0055be951145csm3206341pgf.36.2023.07.12.06.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 06:16:32 -0700 (PDT)
Message-ID: <64aea7b0.630a0220.5ad52.55b1@mx.google.com>
Date:   Wed, 12 Jul 2023 06:16:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.5-rc1-21-g3c61a03588dd8
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 48 runs,
 3 regressions (v6.5-rc1-21-g3c61a03588dd8)
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

pm/testing baseline: 48 runs, 3 regressions (v6.5-rc1-21-g3c61a03588dd8)

Regressions Summary
-------------------

platform               | arch  | lab           | compiler | defconfig | reg=
ressions
-----------------------+-------+---------------+----------+-----------+----=
--------
bcm2711-rpi-4-b        | arm64 | lab-collabora | gcc-10   | defconfig | 1  =
        =

fsl-lx2160a-rdb        | arm64 | lab-nxp       | gcc-10   | defconfig | 1  =
        =

sun50i-a64-pine64-plus | arm64 | lab-broonie   | gcc-10   | defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.5-rc1=
-21-g3c61a03588dd8/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.5-rc1-21-g3c61a03588dd8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      3c61a03588dd8486041f484e9b6c48b2c9a69b92 =



Test Regressions
---------------- =



platform               | arch  | lab           | compiler | defconfig | reg=
ressions
-----------------------+-------+---------------+----------+-----------+----=
--------
bcm2711-rpi-4-b        | arm64 | lab-collabora | gcc-10   | defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/64ae9def208f295625bb2afe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc1-21-g3c61a0=
3588dd8/arm64/defconfig/gcc-10/lab-collabora/baseline-bcm2711-rpi-4-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc1-21-g3c61a0=
3588dd8/arm64/defconfig/gcc-10/lab-collabora/baseline-bcm2711-rpi-4-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ae9def208f295625bb2=
aff
        new failure (last pass: v6.5-rc1-15-g61ca8e67fe61) =

 =



platform               | arch  | lab           | compiler | defconfig | reg=
ressions
-----------------------+-------+---------------+----------+-----------+----=
--------
fsl-lx2160a-rdb        | arm64 | lab-nxp       | gcc-10   | defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/64ae9e19208f295625bb2b04

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc1-21-g3c61a0=
3588dd8/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc1-21-g3c61a0=
3588dd8/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64ae9e19208f295625bb2b09
        failing since 118 days (last pass: v6.1-rc5-55-g60453df62d30, first=
 fail: v6.3-rc2-33-g1240ce78c05e)

    2023-07-12T12:35:14.565464  [   18.015002] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1235759_1.5.2.4.1>
    2023-07-12T12:35:14.670688  =

    2023-07-12T12:35:14.771866  / # #export SHELL=3D/bin/sh
    2023-07-12T12:35:14.772262  =

    2023-07-12T12:35:14.873198  / # export SHELL=3D/bin/sh. /lava-1235759/e=
nvironment
    2023-07-12T12:35:14.873597  =

    2023-07-12T12:35:14.974561  / # . /lava-1235759/environment/lava-123575=
9/bin/lava-test-runner /lava-1235759/1
    2023-07-12T12:35:14.975234  =

    2023-07-12T12:35:14.979219  / # /lava-1235759/bin/lava-test-runner /lav=
a-1235759/1
    2023-07-12T12:35:15.002508  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform               | arch  | lab           | compiler | defconfig | reg=
ressions
-----------------------+-------+---------------+----------+-----------+----=
--------
sun50i-a64-pine64-plus | arm64 | lab-broonie   | gcc-10   | defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/64ae9e83f71eb5f14abb2a7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.5-rc1-21-g3c61a0=
3588dd8/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.5-rc1-21-g3c61a0=
3588dd8/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64ae9e83f71eb5f14abb2=
a7b
        failing since 0 day (last pass: v6.4-rc7-126-gf28ec6369334, first f=
ail: v6.5-rc1-15-g61ca8e67fe61) =

 =20
