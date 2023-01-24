Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC5B678F30
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jan 2023 05:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjAXEKn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Jan 2023 23:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjAXEKl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Jan 2023 23:10:41 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B085AD1A
        for <linux-pm@vger.kernel.org>; Mon, 23 Jan 2023 20:10:39 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso735202pjj.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Jan 2023 20:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jFWpWa/RrfLpN+jANNH1ETJPUQW7FtFRinhoOJelCWA=;
        b=5FlPrpbWRmw6k4f7nsgsfiHeNN8ejJ/D854r9lkG0zTTK8Lq6RrsB7aDgpXU9KwMbg
         UzxFFtB1yFFoXQ5oVaEdbbVV1tiZFdP4pGYaM/wpDimrqI4leIFyZrFRrEI8/5Hzn4oO
         GTRSjhUPIVMymDzh0+MIgXIvL2yj3I/h2eFIg3bjjAQyeNklEcdsmwPaPS67bkBD/C3K
         LNLkmRPVmb9wtW3tS09XyJIikgQiwy8HFu+q5AsC4hnNcloqU3WoxJ3sZiMXdEHLtwKO
         8Y9GuV8BxUNZiIfhOd8yZaCzMpLtYL9TvwkDl6ygocyV7b6b5AV+KH3t84XpiW8da50b
         n+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFWpWa/RrfLpN+jANNH1ETJPUQW7FtFRinhoOJelCWA=;
        b=31fyazoaUvGdMKKSwhTSb4csto7Ox7K86fHgdda902wyIJgbMMrOFhx5HrjGq/ceny
         5ZprEaM9x9xWV/y66hCIDieY+Y9Fkw4wnTzvNHimdeDEGdZwJ0KgD1J9g61nVlP638U6
         vJmeHuwbAL+61ZYuZ+fe/zAUQ+fkRpfMxa9TCOsTpGqP3agUBNop/j54ukipXTtOw8tn
         88h908sBgaFCugbfYgIS5fPggbKZBnNRx9PqA8MJszCuTIaCc8uAmlC3p1YYYTN/rsxc
         8yuEy1gF9Q7RwIAmiHJhU7BsQzYmeuWNz2F0DIbKwth3bqjIwfZAMXei8qKPHZ82Xm7x
         e8ig==
X-Gm-Message-State: AFqh2krczsx4C6GPXzc/qiV6IMAnvHtiw9hcF8bHxSH4/3fqvvNOAAfX
        RKwf7EsRnRswvsUKOMdGb+UXsA==
X-Google-Smtp-Source: AMrXdXuJR3r7hmlIkqjjNLIZZSEDlgAbnUsjJ0RUL/UZlH6p3C26LrryGv42UURoyhr8bCbyfNWOug==
X-Received: by 2002:a17:902:8493:b0:194:3dce:deb5 with SMTP id c19-20020a170902849300b001943dcedeb5mr28811627plo.27.1674533438960;
        Mon, 23 Jan 2023 20:10:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902e90500b00177f25f8ab3sm510874pld.89.2023.01.23.20.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 20:10:38 -0800 (PST)
Message-ID: <63cf5a3e.170a0220.3a4e2.15f6@mx.google.com>
Date:   Mon, 23 Jan 2023 20:10:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc5-85-gfaa268e6daed
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 80 runs,
 5 regressions (v6.2-rc5-85-gfaa268e6daed)
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

pm/testing baseline: 80 runs, 5 regressions (v6.2-rc5-85-gfaa268e6daed)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
cubietruck                   | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =

kontron-pitx-imx8m           | arm64 | lab-kontron  | gcc-10   | defconfig =
         | 2          =

sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =

sun8i-h3-libretech-all-h3-cc | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.2-rc5=
-85-gfaa268e6daed/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.2-rc5-85-gfaa268e6daed
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      faa268e6daed6058e936eadcafe41f47507a02d2 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
cubietruck                   | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf51a125ee9f4f99915f10

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-85-gfaa268=
e6daed/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-85-gfaa268=
e6daed/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cf51a125ee9f4f99915f15
        failing since 4 days (last pass: v6.1-rc8-176-gcb06e36a6532, first =
fail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-24T03:33:39.130311  <8>[   15.187375] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3195044_1.5.2.4.1>
    2023-01-24T03:33:39.241703  / # #
    2023-01-24T03:33:39.345073  export SHELL=3D/bin/sh
    2023-01-24T03:33:39.346156  #
    2023-01-24T03:33:39.346862  / # export SHELL=3D/bin/sh<3>[   15.368243]=
 Bluetooth: hci0: command 0xfc18 tx timeout
    2023-01-24T03:33:39.449813  . /lava-3195044/environment
    2023-01-24T03:33:39.450750  =

    2023-01-24T03:33:39.553020  / # . /lava-3195044/environment/lava-319504=
4/bin/lava-test-runner /lava-3195044/1
    2023-01-24T03:33:39.554797  =

    2023-01-24T03:33:39.559606  / # /lava-3195044/bin/lava-test-runner /lav=
a-3195044/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
kontron-pitx-imx8m           | arm64 | lab-kontron  | gcc-10   | defconfig =
         | 2          =


  Details:     https://kernelci.org/test/plan/id/63cf4e1be2218396fb915ed9

  Results:     51 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-85-gfaa268=
e6daed/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-85-gfaa268=
e6daed/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cf4e1be2218396fb915edc
        new failure (last pass: v6.2-rc4-80-gafd822f01cda)

    2023-01-24T03:18:30.252124  / # #
    2023-01-24T03:18:30.357341  export SHELL=3D/bin/sh
    2023-01-24T03:18:30.357882  #
    2023-01-24T03:18:30.459239  / # export SHELL=3D/bin/sh. /lava-253626/en=
vironment
    2023-01-24T03:18:30.460427  =

    2023-01-24T03:18:30.565291  / # . /lava-253626/environment/lava-253626/=
bin/lava-test-runner /lava-253626/1
    2023-01-24T03:18:30.566059  =

    2023-01-24T03:18:30.576062  / # /lava-253626/bin/lava-test-runner /lava=
-253626/1
    2023-01-24T03:18:30.636031  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-24T03:18:30.636437  + cd /l<8>[   15.876630] <LAVA_SIGNAL_START=
RUN 1_bootrr 253626_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/63c=
f4e1be2218396fb915eec
        new failure (last pass: v6.2-rc4-80-gafd822f01cda)

    2023-01-24T03:18:34.696762  /lava-253626/1/../bin/lava-test-case
    2023-01-24T03:18:34.697068  <8>[   20.101668] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-01-24T03:18:34.697221  /lava-253626/1/../bin/lava-test-case   =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf506552422d1f28915ed5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-85-gfaa268=
e6daed/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-li=
bretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-85-gfaa268=
e6daed/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-li=
bretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cf506552422d1f28915eda
        failing since 5 days (last pass: v6.1-rc8-224-g02f29b079520, first =
fail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-24T03:28:12.198498  / # #
    2023-01-24T03:28:12.300223  export SHELL=3D/bin/sh
    2023-01-24T03:28:12.300574  #
    2023-01-24T03:28:12.401891  / # export SHELL=3D/bin/sh. /lava-3195045/e=
nvironment
    2023-01-24T03:28:12.402260  =

    2023-01-24T03:28:12.503599  / # . /lava-3195045/environment/lava-319504=
5/bin/lava-test-runner /lava-3195045/1
    2023-01-24T03:28:12.504216  =

    2023-01-24T03:28:12.510830  / # /lava-3195045/bin/lava-test-runner /lav=
a-3195045/1
    2023-01-24T03:28:12.613590  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-24T03:28:12.613855  + cd /lava-3195045/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
sun8i-h3-libretech-all-h3-cc | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63cf500c6cd991cf0e915f3c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-85-gfaa268=
e6daed/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-librete=
ch-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-85-gfaa268=
e6daed/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-librete=
ch-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63cf500c6cd991cf0e915f41
        failing since 5 days (last pass: v6.1-rc8-224-g02f29b079520, first =
fail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-24T03:26:48.919542  / # #
    2023-01-24T03:26:49.021224  export SHELL=3D/bin/sh
    2023-01-24T03:26:49.021573  #
    2023-01-24T03:26:49.122961  / # export SHELL=3D/bin/sh. /lava-3195034/e=
nvironment
    2023-01-24T03:26:49.123551  =

    2023-01-24T03:26:49.225015  / # . /lava-3195034/environment/lava-319503=
4/bin/lava-test-runner /lava-3195034/1
    2023-01-24T03:26:49.225867  =

    2023-01-24T03:26:49.230895  / # /lava-3195034/bin/lava-test-runner /lav=
a-3195034/1
    2023-01-24T03:26:49.335846  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-24T03:26:49.336219  + cd /lava-3195034/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
