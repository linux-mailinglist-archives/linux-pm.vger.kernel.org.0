Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798DD672B03
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 23:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjARWCx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 17:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjARWC2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 17:02:28 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE15656D4
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 14:02:25 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c85so31059pfc.8
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 14:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9Xc34/Ogs4Do2fKgOAtFm7wRbe6fVsO2y0sDrXkAYB8=;
        b=K78M7FckpC6MdPjpSZ6EawImDGa0mISpeKVO7QOpBmDavWeq05hujlxXp8BrlxNyAn
         vzlIXPKaoX7cMBtvuuVBXxqdsP474HmaaHJa2D+FGAXItIZZ5uFStKM1q4qMbDMAl5nJ
         +wn39gcIQjWuq8MDC1IErm507LnnkzslBe0APK9ulrMoQ0qSSVA/wR3XPy9USSBTBwCy
         EMYmbG/kd0pRRPq8gNFnZT3NLp6R/TFJXPuiD/saU+v6iDmTmiQoyTTCu+9Wzpd8i1Co
         g9WYMOi24Wd5V1Ym9HFCQ0iUbiz3y/EFc7QANtjXNmJjdVZkJrkUzT9bvS/b/tB+W0rz
         EJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Xc34/Ogs4Do2fKgOAtFm7wRbe6fVsO2y0sDrXkAYB8=;
        b=bT+bodOWm/j7UZHWUAfvDucy1RoiZdWpynNvDJfkFOvEzc9xY8znPuk2iLQ7waakoe
         fzU2Pva3S9G9hLjGvtwKEKQAL0pPZabkGvkELKqn2NmkksBwTtrfSvvUohSQe6bdY9FM
         CnmnvGqUE160bFG1RK4TnOd4zGgZgZIp8aoNwOG8I4Tux8g/JHJ22nzuHlNqkmf+mEA3
         TSlcOk1pVtO9zKMZ7VUlWk9pOG2S5xGncjh+AJBbhpgiBVi702RCUa+TVf3ilPGY4YON
         +up2lWgUVgM6mXp1iWVfJMphfk3lf//kaiFQ1d2qocePT2nkAt8i2Vjno0b/4veLAiNy
         B5qQ==
X-Gm-Message-State: AFqh2kptwdEOwPCBE884fbzRBiAHQRPXdIEL6e/lBvrRj7U0qJUQ199h
        sEGue7D7xA8729w9ibFcnR+fQQ==
X-Google-Smtp-Source: AMrXdXskGe8hKL4wdodVqF5Te9m/SbrP7JDzJUhmnk4fMlj/sUnyolRafcvzJgo1fUOzppo/TS0T/Q==
X-Received: by 2002:a62:1b8a:0:b0:56c:318a:f83b with SMTP id b132-20020a621b8a000000b0056c318af83bmr6805996pfb.13.1674079345416;
        Wed, 18 Jan 2023 14:02:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k197-20020a6284ce000000b00574b86040a4sm22620969pfd.3.2023.01.18.14.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 14:02:24 -0800 (PST)
Message-ID: <63c86c70.620a0220.e944.51d5@mx.google.com>
Date:   Wed, 18 Jan 2023 14:02:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc4-74-g590cffafa8dd
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 60 runs,
 2 regressions (v6.2-rc4-74-g590cffafa8dd)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 60 runs, 2 regressions (v6.2-rc4-74-g590cffafa8dd)

Regressions Summary
-------------------

platform                     | arch | lab          | compiler | defconfig  =
        | regressions
-----------------------------+------+--------------+----------+------------=
--------+------------
sun8i-h2-plus...ch-all-h3-cc | arm  | lab-baylibre | gcc-10   | multi_v7_de=
fconfig | 1          =

sun8i-h3-libretech-all-h3-cc | arm  | lab-baylibre | gcc-10   | multi_v7_de=
fconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.2-rc4=
-74-g590cffafa8dd/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.2-rc4-74-g590cffafa8dd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      590cffafa8ddf08292be10169d5159ba30137371 =



Test Regressions
---------------- =



platform                     | arch | lab          | compiler | defconfig  =
        | regressions
-----------------------------+------+--------------+----------+------------=
--------+------------
sun8i-h2-plus...ch-all-h3-cc | arm  | lab-baylibre | gcc-10   | multi_v7_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63c861398848519873915f02

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc4-74-g590cff=
afa8dd/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-li=
bretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc4-74-g590cff=
afa8dd/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-li=
bretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c861398848519873915f07
        new failure (last pass: v6.1-rc8-224-g02f29b079520)

    2023-01-18T21:13:45.981728  / # #
    2023-01-18T21:13:46.084251  export SHELL=3D/bin/sh
    2023-01-18T21:13:46.085030  #
    2023-01-18T21:13:46.186679  / # export SHELL=3D/bin/sh. /lava-3163293/e=
nvironment
    2023-01-18T21:13:46.187447  =

    2023-01-18T21:13:46.289117  / # . /lava-3163293/environment/lava-316329=
3/bin/lava-test-runner /lava-3163293/1
    2023-01-18T21:13:46.290254  =

    2023-01-18T21:13:46.306293  / # /lava-3163293/bin/lava-test-runner /lav=
a-3163293/1
    2023-01-18T21:13:46.399258  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T21:13:46.399846  + cd /lava-3163293/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch | lab          | compiler | defconfig  =
        | regressions
-----------------------------+------+--------------+----------+------------=
--------+------------
sun8i-h3-libretech-all-h3-cc | arm  | lab-baylibre | gcc-10   | multi_v7_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63c86115e9345fcf96915ec6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc4-74-g590cff=
afa8dd/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-librete=
ch-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc4-74-g590cff=
afa8dd/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-librete=
ch-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c86115e9345fcf96915ecb
        new failure (last pass: v6.1-rc8-224-g02f29b079520)

    2023-01-18T21:13:43.277009  / # #
    2023-01-18T21:13:43.378983  export SHELL=3D/bin/sh
    2023-01-18T21:13:43.379513  #
    2023-01-18T21:13:43.480870  / # export SHELL=3D/bin/sh. /lava-3163301/e=
nvironment
    2023-01-18T21:13:43.481296  =

    2023-01-18T21:13:43.582694  / # . /lava-3163301/environment/lava-316330=
1/bin/lava-test-runner /lava-3163301/1
    2023-01-18T21:13:43.583501  =

    2023-01-18T21:13:43.588093  / # /lava-3163301/bin/lava-test-runner /lav=
a-3163301/1
    2023-01-18T21:13:43.709099  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-18T21:13:43.709705  + cd /lava-3163301/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
