Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F597546FB
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jul 2023 08:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjGOGJL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Jul 2023 02:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOGJK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Jul 2023 02:09:10 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240A730DE
        for <linux-pm@vger.kernel.org>; Fri, 14 Jul 2023 23:09:09 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666edfc50deso1660784b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Jul 2023 23:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689401348; x=1691993348;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UrVczgEckb//b8dLY/HKQOgiHvRBF5M1CWYZGGlUTsk=;
        b=V2MZ6lWyk0wgAV9btlvXG/bCnnWwPMQ1nvDOqtx9+Erspp7KXt3du5+VqUHkOHH3RC
         ZbSeVv8xfwdjJPLs00+56G4v61FBsA+yz4WOLXnXLbdBFMMge86vyItxfpifB6iVmr5w
         HR3qbFCfflVhno3uVvuJICKBT9WIkuX2NNrYBENxM0zRqAqTJ3QESFvHg8YzadckluV2
         F3vh9ale2RvfV6Nx/J0b4Ws4XmMacgWnja+TIf3bqYIBKWox8qnd1DvkrqTaD4cn2go0
         4KBYI8fOBr8xvShiVQrk4GCGdeTcI3JcoUHyAJJ++ZxkKLRQMyX4eOM0gQDQb7QBM57r
         lsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689401348; x=1691993348;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UrVczgEckb//b8dLY/HKQOgiHvRBF5M1CWYZGGlUTsk=;
        b=U3CaOnsO6qZubqaH3moTMEaeI7PktTtTtKRLcpGYHHsos2le2/X22l0eIBvMJoOxjC
         HOQjXtbgkUNdn24BvPMVLBTB1jdL5d+2y/FPJWE7zwlIQ+zWT58Vk2qmGMTiVAU3UaaY
         XL77d/0qzsLNt8nXCuYPb1hjzgHuCoToWSpmUKKAxmlAlSPdQ79V/yIk+eU8eBhKUhw5
         U48gwrCGTm9luNJZLHWqZVCjeyfm7Z8xcYoFnKmHeW8iwjxWgg+dKDdQFDrB/qDJev8S
         3AnuBiFlB1LBtpDMVayvla7PWNBjNkbhc6yeJWwY/0is3h+mTXq8eCjbfpzPxXhBHZh0
         XGFQ==
X-Gm-Message-State: ABy/qLZ/pidW86D4AvzdiCOOZytqgJhnRgWHq8aNqspxN6KSnKtyxTZw
        3RHv0UZJlY0QoJevEpYNvgeTerRahbwLK/+ES+9mrQ==
X-Google-Smtp-Source: APBJJlHeyCoyGIks1CZRH9ICRhDC/heLhzYYMOcH5FlKqrq5Dfa+zjiKcM6VZm9VSNnLY/0RxLtXRA==
X-Received: by 2002:a05:6a00:8ce:b0:681:919f:bf69 with SMTP id s14-20020a056a0008ce00b00681919fbf69mr6683890pfu.0.1689401348577;
        Fri, 14 Jul 2023 23:09:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j5-20020a62e905000000b0068338b6667asm5244880pfh.212.2023.07.14.23.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 23:09:07 -0700 (PDT)
Message-ID: <64b23803.620a0220.b7186.c54d@mx.google.com>
Date:   Fri, 14 Jul 2023 23:09:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: pm-6.5-rc2-210-ga648a2d354da
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 47 runs,
 2 regressions (pm-6.5-rc2-210-ga648a2d354da)
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

pm/testing baseline: 47 runs, 2 regressions (pm-6.5-rc2-210-ga648a2d354da)

Regressions Summary
-------------------

platform        | arch  | lab     | compiler | defconfig | regressions
----------------+-------+---------+----------+-----------+------------
fsl-ls2088a-rdb | arm64 | lab-nxp | gcc-10   | defconfig | 1          =

fsl-lx2160a-rdb | arm64 | lab-nxp | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-6.5-r=
c2-210-ga648a2d354da/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: pm-6.5-rc2-210-ga648a2d354da
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a648a2d354dadbc6ccd5336fc81df66c06d80d87 =



Test Regressions
---------------- =



platform        | arch  | lab     | compiler | defconfig | regressions
----------------+-------+---------+----------+-----------+------------
fsl-ls2088a-rdb | arm64 | lab-nxp | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64b22e56478783378d8ace1c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-6.5-rc2-210-ga64=
8a2d354da/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-6.5-rc2-210-ga64=
8a2d354da/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b22e56478783378d8ace21
        failing since 0 day (last pass: v6.0-rc3-85-gf6f4c123bfbc, first fa=
il: v6.5-rc1-21-g3c61a03588dd8)

    2023-07-15T05:27:32.822889  + [   12.114938] <LAVA_SIGNAL_ENDRUN 0_dmes=
g 1236758_1.5.2.4.1>
    2023-07-15T05:27:32.823199  set +x
    2023-07-15T05:27:32.928220  =

    2023-07-15T05:27:33.029358  / # #export SHELL=3D/bin/sh
    2023-07-15T05:27:33.029753  =

    2023-07-15T05:27:33.130702  / # export SHELL=3D/bin/sh. /lava-1236758/e=
nvironment
    2023-07-15T05:27:33.131130  =

    2023-07-15T05:27:33.232106  / # . /lava-1236758/environment/lava-123675=
8/bin/lava-test-runner /lava-1236758/1
    2023-07-15T05:27:33.232778  =

    2023-07-15T05:27:33.236801  / # /lava-1236758/bin/lava-test-runner /lav=
a-1236758/1 =

    ... (12 line(s) more)  =

 =



platform        | arch  | lab     | compiler | defconfig | regressions
----------------+-------+---------+----------+-----------+------------
fsl-lx2160a-rdb | arm64 | lab-nxp | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64b22e540e56e94c2f8ace22

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-6.5-rc2-210-ga64=
8a2d354da/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-6.5-rc2-210-ga64=
8a2d354da/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b22e540e56e94c2f8ace27
        failing since 121 days (last pass: v6.1-rc5-55-g60453df62d30, first=
 fail: v6.3-rc2-33-g1240ce78c05e)

    2023-07-15T05:27:27.907359  [   16.650616] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1236756_1.5.2.4.1>
    2023-07-15T05:27:28.012656  =

    2023-07-15T05:27:28.113917  / # #export SHELL=3D/bin/sh
    2023-07-15T05:27:28.114329  =

    2023-07-15T05:27:28.215314  / # export SHELL=3D/bin/sh. /lava-1236756/e=
nvironment
    2023-07-15T05:27:28.215728  =

    2023-07-15T05:27:28.316730  / # . /lava-1236756/environment/lava-123675=
6/bin/lava-test-runner /lava-1236756/1
    2023-07-15T05:27:28.317431  =

    2023-07-15T05:27:28.321299  / # /lava-1236756/bin/lava-test-runner /lav=
a-1236756/1
    2023-07-15T05:27:28.344514  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
