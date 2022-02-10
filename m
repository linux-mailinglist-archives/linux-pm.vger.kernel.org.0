Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDBF4B043F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Feb 2022 05:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiBJEJv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Feb 2022 23:09:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiBJEJv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Feb 2022 23:09:51 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB351E7E0
        for <linux-pm@vger.kernel.org>; Wed,  9 Feb 2022 20:09:52 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id a39so7163100pfx.7
        for <linux-pm@vger.kernel.org>; Wed, 09 Feb 2022 20:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ocQkgWz16OGsPtCXfvSLu6APV/OjWzlzS7O9cY9GdPI=;
        b=PquaVwDK+a2jd8fRTK9IDm7qcWQ6wzhQDjGjojB9gXJYcryCTMarunup0tI8IPFQLb
         fCRHu7oL8Y1abm17pT2ZU0FtkVT4PiaItKqCQ2FrQ4XfmXLlpZfR9qwrdfl7wCR6fkLX
         GGOpfv4srQ1TNboHIIxBQjRKIQEPbfwVuuIqzkcoFzKfDWo9o0FPLeBI1bq1ojDAY8d3
         Bv/ddSyr6kbEZx4SKEHgCHCHl81x9qdInv72seOzEfA0yAD5Pz5m7+3EvkN8GW6gS0BT
         1Z92ithmBSEc1PMI/1kUc8iNsPT9k2nbSbr+4By2RBe4iGd8AaEkC8V+55uS3zg1iPsA
         qKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ocQkgWz16OGsPtCXfvSLu6APV/OjWzlzS7O9cY9GdPI=;
        b=wZBAVbqUmeMdnFfPtse2nphYK0Uh0SnntON2+C08hBrrJXtM7RNDJn6rwrakOLQcHw
         nuy+b/cW1J8xmkw1VGR9ACywj1SZ+Jhct4fatzq13LcIqzO3Ayp6efbtM2hzQmQ4L/dq
         J4bFoAIbspP8bsxT+ON3rWTnOaBrh0k5y8aBgjCX48+2LJ8a1WL2zytBrM00FaVWNyVY
         VSq/y24Ra574FvcjewD+qHVqDpEF9PQCP/W1QBukHcT5dTTpK5yYS3Yg54bpsVxHNujx
         +Ko7Xqcl+uNeQ9Y8RD3SIgwzrc+w+RxK0L7ImeZYNRT9neOhzEVe4G34XE1+HI2zwHM8
         y2hw==
X-Gm-Message-State: AOAM532v2pAivZOESrduxBp5JDqwiFr/DKQkhk4K3OE3mdCTWeqZoYim
        1wkkcsFyjkKszk0cBcb1Tb6QuQ==
X-Google-Smtp-Source: ABdhPJwEjkNMeMO4jrDpEAFZpJmwxO3jdkN8HCn/Eu9ziMGCCAg6FsFPevY9l2sZwYPbKexif2hd9Q==
X-Received: by 2002:a05:6a00:1a90:: with SMTP id e16mr5651196pfv.35.1644466192396;
        Wed, 09 Feb 2022 20:09:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h19sm21014385pfh.40.2022.02.09.20.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 20:09:52 -0800 (PST)
Message-ID: <62049010.1c69fb81.cdd41.4ef2@mx.google.com>
Date:   Wed, 09 Feb 2022 20:09:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc3-37-gf2edd5978acc
Subject: pm/testing baseline: 58 runs,
 14 regressions (v5.17-rc3-37-gf2edd5978acc)
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

pm/testing baseline: 58 runs, 14 regressions (v5.17-rc3-37-gf2edd5978acc)

Regressions Summary
-------------------

platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
kontron-kbox-a-230-ls      | arm64 | lab-kontron  | gcc-10   | defconfig | =
2          =

kontron-sl28-var3-ads2     | arm64 | lab-kontron  | gcc-10   | defconfig | =
2          =

meson-g12b-odroid-n2       | arm64 | lab-baylibre | gcc-10   | defconfig | =
2          =

qemu_arm64-virt-gicv2      | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv2      | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv3      | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv3      | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =

qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.17-rc=
3-37-gf2edd5978acc/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.17-rc3-37-gf2edd5978acc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      f2edd5978accce27c47f14e94f420b7fc5922266 =



Test Regressions
---------------- =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
kontron-kbox-a-230-ls      | arm64 | lab-kontron  | gcc-10   | defconfig | =
2          =


  Details:     https://kernelci.org/test/plan/id/62048585e505424825c6297d

  Results:     91 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/62048585e505424825c629c2
        failing since 15 days (last pass: v5.16-rc8-171-gf099fd60c342, firs=
t fail: v5.17-rc1)

    2022-02-10T03:24:40.579372  /lava-86324/1/../bin/lava-test-case   =


  * baseline.bootrr.ftm-alarm-probed: https://kernelci.org/test/case/id/620=
48585e505424825c629c3
        failing since 15 days (last pass: v5.16-rc8-171-gf099fd60c342, firs=
t fail: v5.17-rc1)

    2022-02-10T03:24:40.582525  <8>[   13.826656] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>
    2022-02-10T03:24:41.628698  /lava-86324/1/../bin/lava-test-case
    2022-02-10T03:24:41.632392  <8>[   14.845441] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-probed RESULT=3Dfail>
    2022-02-10T03:24:41.632705  /lava-86324/1/../bin/lava-test-case
    2022-02-10T03:24:41.634583  <8>[   14.861382] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsimple-mfd-i2c-driver-present RESULT=3Dpass>
    2022-02-10T03:24:41.634833  /lava-86324/1/../bin/lava-test-case
    2022-02-10T03:24:41.635061  <8>[   14.877369] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dsimple-mfd-i2c-probed RESULT=3Dpass>
    2022-02-10T03:24:41.635290  /lava-86324/1/../bin/lava-test-case   =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
kontron-sl28-var3-ads2     | arm64 | lab-kontron  | gcc-10   | defconfig | =
2          =


  Details:     https://kernelci.org/test/plan/id/6204859917cec44bacc62969

  Results:     99 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.ftm-alarm-driver-present: https://kernelci.org/test/cas=
e/id/6204859a17cec44bacc629b5
        failing since 14 days (last pass: v5.16-rc8-171-gf099fd60c342, firs=
t fail: v5.17-rc1-9-g52d883c7bbae)

    2022-02-10T03:25:07.844795  /lava-86321/1/../bin/lava-test-case   =


  * baseline.bootrr.ftm-alarm-probed: https://kernelci.org/test/case/id/620=
4859a17cec44bacc629b6
        failing since 14 days (last pass: v5.16-rc8-171-gf099fd60c342, firs=
t fail: v5.17-rc1-9-g52d883c7bbae)

    2022-02-10T03:25:07.848305  <8>[   13.418186] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-driver-present RESULT=3Dfail>
    2022-02-10T03:25:08.894168  /lava-86321/1/../bin/lava-test-case
    2022-02-10T03:25:08.894581  <8>[   14.436769] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dftm-alarm-probed RESULT=3Dfail>   =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
meson-g12b-odroid-n2       | arm64 | lab-baylibre | gcc-10   | defconfig | =
2          =


  Details:     https://kernelci.org/test/plan/id/62048511eb55dffa72c62969

  Results:     4 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12b-odroid-n2.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-baylibre/baseline-meson-g12b-odroid-n2.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/62048511eb55dffa=
72c6296c
        new failure (last pass: v5.17-rc3-35-g1e2d75f89fc7)
        1 lines

    2022-02-10T03:22:39.215805  / # #
    2022-02-10T03:22:39.319634  #
    2022-02-10T03:22:39.320309  =

    2022-02-10T03:22:39.320462  / # =

    2022-02-10T03:22:39.421836  / # #export SHELL=3D/bin/sh
    2022-02-10T03:22:39.523022  . /lava-1531732/environment
    2022-02-10T03:22:39.523501  =

    2022-02-10T03:22:39.523699  / # export SHELL=3D/bin/sh
    2022-02-10T03:22:39.624793  / # . /lava-1531732/environment/lava-153173=
2/bin/lava-test-runner /lava-1531732/0
    2022-02-10T03:22:39.625778   =

    ... (10 line(s) more)  =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/62048511eb55dff=
a72c6296e
        new failure (last pass: v5.17-rc3-35-g1e2d75f89fc7)
        2 lines =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2      | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/620484dc397862ff96c62998

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620484dc397862ff96c62=
999
        failing since 1 day (last pass: v5.17-rc3-33-g4e3e936b36f6, first f=
ail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2      | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/620484ba1ae2eca57ac6296e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620484ba1ae2eca57ac62=
96f
        failing since 1 day (last pass: v5.17-rc3-33-g4e3e936b36f6, first f=
ail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/620484ee7a93042208c62974

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-=
uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2-=
uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620484ee7a93042208c62=
975
        failing since 1 day (last pass: v5.17-rc3-33-g4e3e936b36f6, first f=
ail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv2-uefi | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/620484e186e5f2cb91c62974

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-u=
efi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv2-u=
efi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620484e186e5f2cb91c62=
975
        failing since 1 day (last pass: v5.17-rc3-33-g4e3e936b36f6, first f=
ail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv3      | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/620484b57cb7defeaac62a3e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620484b57cb7defeaac62=
a3f
        failing since 1 day (last pass: v5.17-rc3-33-g4e3e936b36f6, first f=
ail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv3      | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/620484b85e90760d27c6296b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620484b85e90760d27c62=
96c
        failing since 1 day (last pass: v5.17-rc3-33-g4e3e936b36f6, first f=
ail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-baylibre | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/620484b7670b76e0f5c629fa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-=
uefi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3-=
uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620484b7670b76e0f5c62=
9fb
        failing since 1 day (last pass: v5.17-rc3-33-g4e3e936b36f6, first f=
ail: v5.17-rc3-35-g1e2d75f89fc7) =

 =



platform                   | arch  | lab          | compiler | defconfig | =
regressions
---------------------------+-------+--------------+----------+-----------+-=
-----------
qemu_arm64-virt-gicv3-uefi | arm64 | lab-broonie  | gcc-10   | defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/620484b91ae2eca57ac62969

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-u=
efi.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.17-rc3-37-gf2edd=
5978acc/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gicv3-u=
efi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220121.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/620484b91ae2eca57ac62=
96a
        failing since 1 day (last pass: v5.17-rc3-33-g4e3e936b36f6, first f=
ail: v5.17-rc3-35-g1e2d75f89fc7) =

 =20
