Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540746CDB25
	for <lists+linux-pm@lfdr.de>; Wed, 29 Mar 2023 15:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjC2Nt4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Mar 2023 09:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjC2Nty (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2023 09:49:54 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121C0C4
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2023 06:49:54 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o2so14979220plg.4
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2023 06:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680097793;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gywp/4Pxe13qs9/EkS1AkvkzObHF8Qdep+vZxwK6/GM=;
        b=hltWBLqV3gIlVQF5ShZ+0gXYnB65WUKmPAU2K0UT4cTx3UVTNdUFJpI7TBdU+XjKDP
         k4BQXDxPg+taIjxuni+dScGv5rF4B8d4U3jYMqcKH209pd3NtLAfJbtSBRSiFMKysF+b
         Pn+d/ZM23Q+8dwv6Sb6MVOG1+nfUpYiBwSCd4Io2bl3RPyR/TWYNVH5dH0vf+/y2X2gi
         p2F3Z2ePc6ukjJTv8+gLINDk1WGpKHdMzewWRI50QsYjKbM12uvlWqqwET7Nf+cysk0f
         0yp2CFEkcCW5syYO2zHF7dcpczZULnIBSvZMFzLKKixJyYawv7H8LN6KaGjNk24eLcNG
         3llA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680097793;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gywp/4Pxe13qs9/EkS1AkvkzObHF8Qdep+vZxwK6/GM=;
        b=KSS5s/2xwUyo1LSCdug4AYq03tGLXc15BH7dQ6Rd9+Aop1h4Q1HxM6D6aEXQbtHmcj
         RqeszpFt7c3CsT2gRkKR5147VqCcDwqL8TPaJosDc7tutpYv68XOvtyecFrOv0VT+p/s
         +WfOIIFQvvl5yORWBeHKiSCCHgkSqFqe6w2hrIJNwdZUtw4RWFC+Xlpwnccoe4sv9WcJ
         DabD9FjwqKscKueKXCHt0QyjEooi+ioswv+wEEa6s20aqGJ0fBVaYf63qfA0cvuMTHPZ
         Hq8xmUQBLmejI55izQLSsdA2sopnHsTB9MEFgnJ/bmpcnuV2eoQoMgxOpNqwtrHuUB5D
         LYOA==
X-Gm-Message-State: AAQBX9d9OXrjPdBMSlCliJJ2kFM18cKpY9GQqL5bLENW+TqFqFo/qyLG
        3BON5xkM3zVNl9+SBsj43wU6QA==
X-Google-Smtp-Source: AKy350ZL/UgswThpoIWd0tM/GtKwYKVQX/IujhcNIIGLdqR1uXZ+G6eaSA6NvI7yEwlF/1XizxYG1g==
X-Received: by 2002:a17:902:e80f:b0:19d:af20:3fe8 with SMTP id u15-20020a170902e80f00b0019daf203fe8mr22986742plg.21.1680097793601;
        Wed, 29 Mar 2023 06:49:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902eb4600b001a076025715sm22946942pli.117.2023.03.29.06.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 06:49:53 -0700 (PDT)
Message-ID: <64244201.170a0220.14d28.a432@mx.google.com>
Date:   Wed, 29 Mar 2023 06:49:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.3-rc4-57-g2a0bc4026820
Subject: pm/testing baseline: 58 runs,
 1 regressions (v6.3-rc4-57-g2a0bc4026820)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 58 runs, 1 regressions (v6.3-rc4-57-g2a0bc4026820)

Regressions Summary
-------------------

platform        | arch  | lab     | compiler | defconfig | regressions
----------------+-------+---------+----------+-----------+------------
fsl-lx2160a-rdb | arm64 | lab-nxp | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.3-rc4=
-57-g2a0bc4026820/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.3-rc4-57-g2a0bc4026820
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      2a0bc402682085328f33e102245b49ffc51ca4a4 =



Test Regressions
---------------- =



platform        | arch  | lab     | compiler | defconfig | regressions
----------------+-------+---------+----------+-----------+------------
fsl-lx2160a-rdb | arm64 | lab-nxp | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6424380133aeb34ed562f793

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.3-rc4-57-g2a0bc4=
026820/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.3-rc4-57-g2a0bc4=
026820/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6424380133aeb34ed562f796
        failing since 13 days (last pass: v6.1-rc5-55-g60453df62d30, first =
fail: v6.3-rc2-33-g1240ce78c05e)

    2023-03-29T13:06:50.098092  [   13.570029] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1189237_1.5.2.4.1>
    2023-03-29T13:06:50.201959  / # #
    2023-03-29T13:06:50.303752  export SHELL=3D/bin/sh
    2023-03-29T13:06:50.304198  #
    2023-03-29T13:06:50.405264  / # export SHELL=3D/bin/sh. /lava-1189237/e=
nvironment
    2023-03-29T13:06:50.405713  =

    2023-03-29T13:06:50.506916  / # . /lava-1189237/environment/lava-118923=
7/bin/lava-test-runner /lava-1189237/1
    2023-03-29T13:06:50.507621  =

    2023-03-29T13:06:50.509276  / # /lava-1189237/bin/lava-test-runner /lav=
a-1189237/1
    2023-03-29T13:06:50.533344  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
