Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3587031BC
	for <lists+linux-pm@lfdr.de>; Mon, 15 May 2023 17:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbjEOPkg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 May 2023 11:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbjEOPkf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 May 2023 11:40:35 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1904DF4
        for <linux-pm@vger.kernel.org>; Mon, 15 May 2023 08:40:34 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64ac461af60so4140180b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 15 May 2023 08:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684165233; x=1686757233;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ojSFcWQEZ3SlwmOYUC9Nri0vdKl3n6oWZDtr8tKSv0A=;
        b=uc4IcXg2ImpPy9xWSDS0j+wLezzYafdhL+achv0k+Ts3Zrc2YyhnkVApLTpZDzHJQD
         oWKZrKoaEnEwnQZW/CqO0VA+Cm4PgSJfZ4kzqIX9e1DFnQHOQT7X4PlUS8Gr2r3xvpId
         nVh7RhWjkNDV/X/AklgdJe5y5lbeuPxL95wWZ5K7r2LDSvNSN+blR+TiKANLK7h5YC3W
         e//yt+qrZxKvRBxs7n21+RpU78Ivd6BG8dMh6O55SOWvXVsHsLKbwLOfizKUzFbA2k0U
         OMY2UFjkV+02zf8/0N4iCwiACu0rKLchDT+RZrCfbbsmtEXVw9Ejj1eTI45LZC/h8zX1
         i/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684165233; x=1686757233;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojSFcWQEZ3SlwmOYUC9Nri0vdKl3n6oWZDtr8tKSv0A=;
        b=jtuGQsSa5r/b81mmk3TZ8hEB7U1af62cWOvyWkvR1rhylLKVmPJajb5aNUaBsyZ5Lm
         PsqwNglsher8RwkhNVwI069LzIvBX+28hz4JB1gITqary2N22ceHb3wzIgCGbMvtewza
         ccvrK6sYUzaZIlHUkXe3F98jRvLF3K3UWA8BEJDootyZw8YGXVjBPmzMUSQVzTrsF3R1
         qP97paXhwP9u6DGU1qIbUuFLmet+Ti9O+53yKtjiOvZTRVTeKcTs6vIIBpwbsk3Zbcg9
         TSDFABkNryrPgEmG/5d+U9aIPrpxtfUM5l0vgw7ukAhby+pfwXl4x4gdmPUiydjEH/KA
         z6VQ==
X-Gm-Message-State: AC+VfDwR8LAtf+tiAQM8Jr+o1XHLReuFu3dKpQAQJbJv/6HWbEtAotqx
        vM7bY/NlCccixp9fmRoNgqnA0X/R8aHorToTprULIg==
X-Google-Smtp-Source: ACHHUZ7xD+OcS6la0lvIIZ3O9C9xnaC4QfqxXAwOGtNMb1edZqXoVIVyRnjvMQFnurzEcyCXxKFLrw==
X-Received: by 2002:a05:6a00:1882:b0:643:b8c2:b577 with SMTP id x2-20020a056a00188200b00643b8c2b577mr44736201pfh.22.1684165233519;
        Mon, 15 May 2023 08:40:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 12-20020a63124c000000b00502ecb91940sm11657893pgs.55.2023.05.15.08.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 08:40:32 -0700 (PDT)
Message-ID: <64625270.630a0220.ac2c8.4656@mx.google.com>
Date:   Mon, 15 May 2023 08:40:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.4-rc2
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 54 runs, 3 regressions (v6.4-rc2)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 54 runs, 3 regressions (v6.4-rc2)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
fsl-lx2160a-rdb   | arm64 | lab-nxp       | gcc-10   | defconfig | 1       =
   =

rk3399-rock-pi-4b | arm64 | lab-collabora | gcc-10   | defconfig | 2       =
   =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.4-rc2=
/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.4-rc2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6 =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
fsl-lx2160a-rdb   | arm64 | lab-nxp       | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/646249512f3efe8fc52e85f3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.4-rc2/arm64/defc=
onfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.4-rc2/arm64/defc=
onfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646249512f3efe8fc52e85f6
        failing since 60 days (last pass: v6.1-rc5-55-g60453df62d30, first =
fail: v6.3-rc2-33-g1240ce78c05e)

    2023-05-15T15:00:40.134111  [   21.528047] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1221989_1.5.2.4.1>
    2023-05-15T15:00:40.239835  / # #
    2023-05-15T15:00:40.341740  export SHELL=3D/bin/sh
    2023-05-15T15:00:40.342242  #
    2023-05-15T15:00:40.443664  / # export SHELL=3D/bin/sh. /lava-1221989/e=
nvironment
    2023-05-15T15:00:40.444152  =

    2023-05-15T15:00:40.545590  / # . /lava-1221989/environment/lava-122198=
9/bin/lava-test-runner /lava-1221989/1
    2023-05-15T15:00:40.546380  =

    2023-05-15T15:00:40.548108  / # /lava-1221989/bin/lava-test-runner /lav=
a-1221989/1
    2023-05-15T15:00:40.574966  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
rk3399-rock-pi-4b | arm64 | lab-collabora | gcc-10   | defconfig | 2       =
   =


  Details:     https://kernelci.org/test/plan/id/6462486972f29e6c6f2e8640

  Results:     3 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.4-rc2/arm64/defc=
onfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.4-rc2/arm64/defc=
onfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230421.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/6462486972f29e6=
c6f2e8647
        new failure (last pass: v6.3-rc7-189-g704d7a52a540b)
        2 lines

    2023-05-15T14:57:35.507895  kern  :emerg : Internal error: Oops: 000000=
0096000006 [#1] PREEMPT SMP

    2023-05-15T14:57:35.508415  kern  :emerg : Code: 97fb1510 f9405680 5286=
4a61 72a686c1 (b9400800) =


    2023-05-15T14:57:35.508751  <8>[   23.025412] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>

    2023-05-15T14:57:35.509064  + set +x

    2023-05-15T14:57:35.509389  <8>[   23.027254] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10326050_1.5.2.4.1>
   =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/6462486972f29e6=
c6f2e8648
        new failure (last pass: v6.3-rc7-189-g704d7a52a540b)
        12 lines

    2023-05-15T14:57:35.459247  kern  :alert : Unable to handle kernel NULL=
 pointer dereference at virtual address 0000000000000008

    2023-05-15T14:57:35.459763  kern  :alert : Mem abort info:

    2023-05-15T14:57:35.460095  kern  :alert :   ESR =3D 0x0000000096000006

    2023-05-15T14:57:35.460399  kern  :alert :   EC =3D 0x25: DABT (current=
 EL), IL =3D 32 bits

    2023-05-15T14:57:35.460694  kern  :alert :   SET =3D 0, FnV =3D 0

    2023-05-15T14:57:35.460983  kern  :alert :   EA =3D 0, S1PTW =3D 0

    2023-05-15T14:57:35.461265  kern  :alert :   FSC =3D 0x06: level 2 tran=
slation fault

    2023-05-15T14:57:35.461574  kern  :alert : Data abort info:

    2023-05-15T14:57:35.461850  kern  :alert :   ISV =3D 0, ISS =3D 0x00000=
006

    2023-05-15T14:57:35.462126  kern  :alert :   CM =3D 0, WnR =3D 0
 =

    ... (3 line(s) more)  =

 =20
