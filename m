Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB71779A04
	for <lists+linux-pm@lfdr.de>; Fri, 11 Aug 2023 23:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbjHKV5e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Aug 2023 17:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbjHKV5P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 17:57:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA9B3580
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 14:57:14 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-267ffa7e441so1648662a91.1
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 14:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691791034; x=1692395834;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ya7YlFK/hZAPdXzrc2wsK46NfqzB7JlOp2RoQE2MLEk=;
        b=Je8PTPcrzHIVGl8Br/r3yHCe94uP5R5ge1JTKi/g9gh6O+9lufNZb26eieiGOB2Daz
         sgewEDWK6D+l8AvJ6cTqdLoJiXMg08qr3pOajDmUyyBp9FU86L1ybfKcFfHA3TUhG3ed
         vvAF5hweNTTyy+QuJM3tNmMkGKDCV7Ix+Pg82ZMOPU6fl9PvmqnLF2NnRUMHGeCCM1Bs
         t/9HdbCLzX1apoMLAOxYO8yVf3m49UkuOKV02fA12blgpYpSjzvEYcxgXgAtZknBysUx
         pU7t1iQ6K18Rc9NtvFgPtX8lpe9+U47MmZk0NEAXAAvYkIQe5rDlpdQFbk2n/bTMTNg0
         Z8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691791034; x=1692395834;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ya7YlFK/hZAPdXzrc2wsK46NfqzB7JlOp2RoQE2MLEk=;
        b=fo8ten3glzeXSONRgaHbseeLMiEvawtmUNbweu+fFXXg0at6h75hON29aE+8i7kgXe
         FLJRCDRgiLRkVKZzS2Lzw1g7RBuElA+q9Kex9z//OR0jtiP0inlfjoy7E9wMIhCpSzdS
         p5m/voGbo2yT2Y0Xl2AeQS6D16b42wiaqZLNFbD7//kjBVoN5FuAi6jWYdOn94MqGIO9
         pWUQRnlJajxaYU2Km8A5zfdd7aGjiNMa9qwJ4RiIkBPw0R8wHSSB9sjJLf4+LKY060J7
         seu+v4mwpPDjaJayYACrg5UA3ddpPw9MXEOk0PEymfpGvZzcyzH0O1sOOWydi03ySbCk
         cLeg==
X-Gm-Message-State: AOJu0YyXiszgnJgzVuV9v2tGe6X4MGaZxgseiptj7iR8slyzuAd9ShDI
        5f1muPj9Z1OMG4xqNhOJtFxReQ==
X-Google-Smtp-Source: AGHT+IENu5W0ahvB8cumYBKhI9MvQS7GdfRLvz5U9OW7vbv3AbEllk+EPlcaCvotk6aMuDjhegRz7g==
X-Received: by 2002:a17:90a:d515:b0:261:1141:b716 with SMTP id t21-20020a17090ad51500b002611141b716mr2530877pju.33.1691791033768;
        Fri, 11 Aug 2023 14:57:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gd10-20020a17090b0fca00b002635db431a0sm3794757pjb.45.2023.08.11.14.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 14:57:13 -0700 (PDT)
Message-ID: <64d6aeb9.170a0220.e4744.7704@mx.google.com>
Date:   Fri, 11 Aug 2023 14:57:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: acpi-6.5-rc6-79-g9a4efd57c80c
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 50 runs,
 4 regressions (acpi-6.5-rc6-79-g9a4efd57c80c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 50 runs, 4 regressions (acpi-6.5-rc6-79-g9a4efd57c80c)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
fsl-ls2088a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =

fsl-lx2160a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =

r8a77960-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =

r8a779m1-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/acpi-6.5=
-rc6-79-g9a4efd57c80c/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: acpi-6.5-rc6-79-g9a4efd57c80c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      9a4efd57c80c7873d53315cf3d4509ff5dcebb62 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
fsl-ls2088a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64d6a50c3d73a6730f35b1e0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-6.5-rc6-79-g9a=
4efd57c80c/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-6.5-rc6-79-g9a=
4efd57c80c/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls2088a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d6a50c3d73a6730f35b1e3
        failing since 28 days (last pass: v6.0-rc3-85-gf6f4c123bfbc, first =
fail: v6.5-rc1-21-g3c61a03588dd8)

    2023-08-11T21:15:36.474763  [   15.715306] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1243059_1.5.2.4.1>
    2023-08-11T21:15:36.580207  =

    2023-08-11T21:15:36.681403  / # #export SHELL=3D/bin/sh
    2023-08-11T21:15:36.681933  =

    2023-08-11T21:15:36.782933  / # export SHELL=3D/bin/sh. /lava-1243059/e=
nvironment
    2023-08-11T21:15:36.783418  =

    2023-08-11T21:15:36.884421  / # . /lava-1243059/environment/lava-124305=
9/bin/lava-test-runner /lava-1243059/1
    2023-08-11T21:15:36.885132  =

    2023-08-11T21:15:36.889519  / # /lava-1243059/bin/lava-test-runner /lav=
a-1243059/1
    2023-08-11T21:15:36.911791  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
fsl-lx2160a-rdb | arm64 | lab-nxp       | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64d6a50fed7be8398835b1d9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-6.5-rc6-79-g9a=
4efd57c80c/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-6.5-rc6-79-g9a=
4efd57c80c/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d6a50fed7be8398835b1dc
        failing since 148 days (last pass: v6.1-rc5-55-g60453df62d30, first=
 fail: v6.3-rc2-33-g1240ce78c05e)

    2023-08-11T21:15:38.648074  [   13.048398] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1243061_1.5.2.4.1>
    2023-08-11T21:15:38.753326  =

    2023-08-11T21:15:38.854646  / # #export SHELL=3D/bin/sh
    2023-08-11T21:15:38.855052  =

    2023-08-11T21:15:38.956030  / # export SHELL=3D/bin/sh. /lava-1243061/e=
nvironment
    2023-08-11T21:15:38.956433  =

    2023-08-11T21:15:39.057405  / # . /lava-1243061/environment/lava-124306=
1/bin/lava-test-runner /lava-1243061/1
    2023-08-11T21:15:39.058067  =

    2023-08-11T21:15:39.061972  / # /lava-1243061/bin/lava-test-runner /lav=
a-1243061/1
    2023-08-11T21:15:39.085505  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
r8a77960-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64d6a48725094fa7f235b1f4

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-6.5-rc6-79-g9a=
4efd57c80c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-6.5-rc6-79-g9a=
4efd57c80c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d6a48725094fa7f235b1f9
        failing since 23 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-11T21:15:12.938035  / # #

    2023-08-11T21:15:13.040228  export SHELL=3D/bin/sh

    2023-08-11T21:15:13.040955  #

    2023-08-11T21:15:13.142395  / # export SHELL=3D/bin/sh. /lava-11267227/=
environment

    2023-08-11T21:15:13.143102  =


    2023-08-11T21:15:13.244584  / # . /lava-11267227/environment/lava-11267=
227/bin/lava-test-runner /lava-11267227/1

    2023-08-11T21:15:13.245730  =


    2023-08-11T21:15:13.246701  / # /lava-11267227/bin/lava-test-runner /la=
va-11267227/1

    2023-08-11T21:15:13.312583  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-11T21:15:13.313122  + cd /lava-112672<8>[   19.301555] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11267227_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig | regressions
----------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb   | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64d6a4af25094fa7f235b2a7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-6.5-rc6-79-g9a=
4efd57c80c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-6.5-rc6-79-g9a=
4efd57c80c/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64d6a4af25094fa7f235b2ac
        failing since 23 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-08-11T21:14:24.561393  / # #

    2023-08-11T21:14:25.641241  export SHELL=3D/bin/sh

    2023-08-11T21:14:25.642998  #

    2023-08-11T21:14:27.132338  / # export SHELL=3D/bin/sh. /lava-11267236/=
environment

    2023-08-11T21:14:27.134097  =


    2023-08-11T21:14:29.856569  / # . /lava-11267236/environment/lava-11267=
236/bin/lava-test-runner /lava-11267236/1

    2023-08-11T21:14:29.858777  =


    2023-08-11T21:14:29.868436  / # /lava-11267236/bin/lava-test-runner /la=
va-11267236/1

    2023-08-11T21:14:29.928407  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-11T21:14:29.928864  + cd /lava-112672<8>[   28.511291] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11267236_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =20
