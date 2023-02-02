Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFA968854E
	for <lists+linux-pm@lfdr.de>; Thu,  2 Feb 2023 18:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjBBRYE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Feb 2023 12:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjBBRYA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2023 12:24:00 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D027C6B355
        for <linux-pm@vger.kernel.org>; Thu,  2 Feb 2023 09:23:58 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so2478035pjb.5
        for <linux-pm@vger.kernel.org>; Thu, 02 Feb 2023 09:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JMsG5cgr2k8CdHXBvB0itS0xKJznuEbp8KK85RAS7j0=;
        b=ZGHohbNLWwdgqsvZakIX74h/Yb4Ip08PG+NMc5TdQATacL8u0satVgTMmolkEZgYck
         zbkjZw/e7lTgvvJGYBP1AyfxMGlwwEdxuL08bN9XbuNk7QHlAbfIYijy1mlAySQ6+m2O
         cODNsoZPBiS3Myv80Al3tPaPWWErTfzZrkMaHeqVYyeHoMisVHmurnSjQbeeZfuFTqvh
         On7EEH5yr/vA8lRD4bWj9ALM1TGPx5p0JbNLW2vTzZv3WNwIfFUY9FEaxsaWBrel40Kj
         SzEB8ip3VYYcnMLuKGxqZSrJxF+GEsQ+QHbcReQKI6nmz7mF9r8U6NMHBCBz/RndBgN9
         28Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMsG5cgr2k8CdHXBvB0itS0xKJznuEbp8KK85RAS7j0=;
        b=hrwWjwHVOWfzpa8P3aRTwJENjhfC3jDYOjiqdW/+1ThSCkgPMOY4mU6Fn0hd9bJvaZ
         payZ4oXPc+MThmuY96ypOrsVl6Kj5ZjmBasr8N9fwnPx03Ix8YFwUOYMdIFsTJczp1Am
         /Fw1rxgLsOcAz/92ON6S/C1NcDP9HWUEYp6e6ff57uRw0v43v3OIrdfxj9i1lol7HAlf
         uJ/0l50zAqbgve7wPImWSp5gz1MPZf2uEIQj7HUjzQuit/N7DjWZEzDvwlKWIrB0lm+u
         B5gbfFydPTQopm8Ri085gn5CA6ooFRx3x24bgx28k6w1i1XG0mF2eNwrDJ/OuKeNRhZ2
         Gq+w==
X-Gm-Message-State: AO0yUKWMvStHWNmDQ/I9fy93C/5CIV/LBMumur7QlxLkrZ7uKu02JsMY
        4GqIkespPihNcJ4DeHMmglabxg==
X-Google-Smtp-Source: AK7set9lHgXQEB7jUiskeYsy+MF9XQmQXUDCBdDUEctuI0TEtge30RftlugEH8Xn2NBecpIvV1Su2Q==
X-Received: by 2002:a17:902:e34a:b0:190:e63a:ea91 with SMTP id p10-20020a170902e34a00b00190e63aea91mr6086976plc.0.1675358638316;
        Thu, 02 Feb 2023 09:23:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ix17-20020a170902f81100b00194b0074b25sm14086855plb.160.2023.02.02.09.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 09:23:57 -0800 (PST)
Message-ID: <63dbf1ad.170a0220.4d8bd.9be7@mx.google.com>
Date:   Thu, 02 Feb 2023 09:23:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc6-147-ge09c4cd57910
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 86 runs,
 4 regressions (v6.2-rc6-147-ge09c4cd57910)
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

pm/testing baseline: 86 runs, 4 regressions (v6.2-rc6-147-ge09c4cd57910)

Regressions Summary
-------------------

platform                     | arch | lab             | compiler | defconfi=
g          | regressions
-----------------------------+------+-----------------+----------+---------=
-----------+------------
cubietruck                   | arm  | lab-baylibre    | gcc-10   | multi_v7=
_defconfig | 1          =

imx53-qsrb                   | arm  | lab-pengutronix | gcc-10   | multi_v7=
_defconfig | 1          =

stm32mp157c-dk2              | arm  | lab-baylibre    | gcc-10   | multi_v7=
_defconfig | 1          =

sun8i-h3-libretech-all-h3-cc | arm  | lab-baylibre    | gcc-10   | multi_v7=
_defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.2-rc6=
-147-ge09c4cd57910/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.2-rc6-147-ge09c4cd57910
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      e09c4cd579105a55d4014420fdf8af20378de87a =



Test Regressions
---------------- =



platform                     | arch | lab             | compiler | defconfi=
g          | regressions
-----------------------------+------+-----------------+----------+---------=
-----------+------------
cubietruck                   | arm  | lab-baylibre    | gcc-10   | multi_v7=
_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63dbe64639811264f8915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc6-147-ge09c4=
cd57910/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc6-147-ge09c4=
cd57910/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63dbe64639811264f8915ebe
        failing since 14 days (last pass: v6.1-rc8-176-gcb06e36a6532, first=
 fail: v6.2-rc4-74-g590cffafa8dd)

    2023-02-02T16:35:04.363993  <8>[   15.210681] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3274169_1.5.2.4.1>
    2023-02-02T16:35:04.473225  / # #
    2023-02-02T16:35:04.576010  export SHELL=3D/bin/sh
    2023-02-02T16:35:04.576876  #
    2023-02-02T16:35:04.678907  / # export SHELL=3D/bin/sh. /lava-3274169/e=
nvironment
    2023-02-02T16:35:04.679767  =

    2023-02-02T16:35:04.680276  / # <3>[   15.437893] Bluetooth: hci0: comm=
and 0x0c03 tx timeout
    2023-02-02T16:35:04.782077  . /lava-3274169/environment/lava-3274169/bi=
n/lava-test-runner /lava-3274169/1
    2023-02-02T16:35:04.782709  =

    2023-02-02T16:35:04.787472  / # /lava-3274169/bin/lava-test-runner /lav=
a-3274169/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch | lab             | compiler | defconfi=
g          | regressions
-----------------------------+------+-----------------+----------+---------=
-----------+------------
imx53-qsrb                   | arm  | lab-pengutronix | gcc-10   | multi_v7=
_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63dbe4eb3b508c6f4c915f15

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc6-147-ge09c4=
cd57910/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc6-147-ge09c4=
cd57910/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63dbe4eb3b508c6f4c915f1a
        failing since 5 days (last pass: v6.1-rc8-156-g0a9e32afe717, first =
fail: acpi-6.2-rc6-146-g628c61874ffd)

    2023-02-02T16:29:09.644153  + set +x
    2023-02-02T16:29:09.644563  [   12.968979] <LAVA_SIGNAL_ENDRUN 0_dmesg =
896186_1.5.2.3.1>
    2023-02-02T16:29:09.752328  / # #
    2023-02-02T16:29:09.854312  export SHELL=3D/bin/sh
    2023-02-02T16:29:09.854902  #
    2023-02-02T16:29:09.955975  / # export SHELL=3D/bin/sh. /lava-896186/en=
vironment
    2023-02-02T16:29:09.956581  =

    2023-02-02T16:29:10.057965  / # . /lava-896186/environment/lava-896186/=
bin/lava-test-runner /lava-896186/1
    2023-02-02T16:29:10.058617  =

    2023-02-02T16:29:10.062205  / # /lava-896186/bin/lava-test-runner /lava=
-896186/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch | lab             | compiler | defconfi=
g          | regressions
-----------------------------+------+-----------------+----------+---------=
-----------+------------
stm32mp157c-dk2              | arm  | lab-baylibre    | gcc-10   | multi_v7=
_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63dbe47373ca9730bc915ee7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc6-147-ge09c4=
cd57910/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm32mp157c-dk2=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc6-147-ge09c4=
cd57910/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm32mp157c-dk2=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63dbe47373ca9730bc915eec
        new failure (last pass: v5.19-rc6-53-ge71c5921cc50)

    2023-02-02T16:27:06.379745  <8>[   13.872137] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3274177_1.5.2.4.1>
    2023-02-02T16:27:06.484450  / # #
    2023-02-02T16:27:06.586371  export SHELL=3D/bin/sh
    2023-02-02T16:27:06.586913  #
    2023-02-02T16:27:06.688338  / # export SHELL=3D/bin/sh. /lava-3274177/e=
nvironment
    2023-02-02T16:27:06.688853  =

    2023-02-02T16:27:06.790197  / # . /lava-3274177/environment/lava-327417=
7/bin/lava-test-runner /lava-3274177/1
    2023-02-02T16:27:06.791088  =

    2023-02-02T16:27:06.793906  / # /lava-3274177/bin/lava-test-runner /lav=
a-3274177/1
    2023-02-02T16:27:06.870830  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch | lab             | compiler | defconfi=
g          | regressions
-----------------------------+------+-----------------+----------+---------=
-----------+------------
sun8i-h3-libretech-all-h3-cc | arm  | lab-baylibre    | gcc-10   | multi_v7=
_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63dbe49a23edb06a18915ec2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc6-147-ge09c4=
cd57910/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-libret=
ech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc6-147-ge09c4=
cd57910/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-libret=
ech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63dbe49a23edb06a18915ec7
        failing since 14 days (last pass: v6.1-rc8-224-g02f29b079520, first=
 fail: v6.2-rc4-74-g590cffafa8dd)

    2023-02-02T16:27:47.594297  / # #
    2023-02-02T16:27:47.696602  export SHELL=3D/bin/sh
    2023-02-02T16:27:47.697252  #
    2023-02-02T16:27:47.798855  / # export SHELL=3D/bin/sh. /lava-3274164/e=
nvironment
    2023-02-02T16:27:47.799517  =

    2023-02-02T16:27:47.901065  / # . /lava-3274164/environment/lava-327416=
4/bin/lava-test-runner /lava-3274164/1
    2023-02-02T16:27:47.902034  =

    2023-02-02T16:27:47.918837  / # /lava-3274164/bin/lava-test-runner /lav=
a-3274164/1
    2023-02-02T16:27:48.014733  + export 'TESTRUN_ID=3D1_bootrr'
    2023-02-02T16:27:48.015094  + cd /lava-3274164/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
