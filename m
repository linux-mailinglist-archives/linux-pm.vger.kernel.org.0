Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DD629E1C8
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 03:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgJ1Vsd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 17:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgJ1Vs0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 17:48:26 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE758C0613D1
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 14:48:26 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b12so291840plr.4
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 14:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=3+FSVhYlJ6B/jHAupqQ6MojArU0FUMiXORXXRXS0hw8=;
        b=eJjtYDc6O0DJ2+9ytk4ghhFEhUJ/pgE9Wd0bVJAurqopo1skNwFk/M/cqGvKzF+ES8
         z52uTpZms1P2pRpFmQFetMvJQZSLfr0SnzjpTHwsmLC7+Lyip6j60idhtmD+9dzobkgN
         ItBPpw0B1BkSUu9Mx6rbrmam81ULUXM4oSOKPuB2EgV/VuxLOLHwB4owlRduAuGvy25U
         g8TCc60mm1X/O8IERKYaYSaTEL8hO3sVMZhVxvxEKq431cL14HEYJN3UTZsxzFUsn72r
         zAtIVI1wafTSHrKlXsEJjY+ABNAVbtpfA2cE15w/Ig3oV5CG3OJBeXRUbBiYfG/xnndk
         mVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=3+FSVhYlJ6B/jHAupqQ6MojArU0FUMiXORXXRXS0hw8=;
        b=eyzV2KfIpj7h8v4AfYPdpgfCh9CV3GEhnexYMNJTxp/5T3bEYsyP5fMA8z30PJcPy5
         FKAb7mYM2qOkuNI2B7y3kfL066R15gBQIqpwiKjApFgVfoekbtmxQf6qvredJ4VsHc70
         avzTbFQJFj0XTx7EsfPeH2hqkLuORzFeYiEsqmizJXXhKbXUqWchKtnoMbf/lgw+NEAb
         tv7Suzz36TJezp9/kj4O7DoAh8I7WHzX48pER6Co3bQIskcQlF/hUDCEx2sDGr4JGyRA
         33HEXjeusgLVv6rCsiQNmKx56PyDQyvapVnlVgbRueUogUed+fptErudt22e5bEDi4/j
         Cg+Q==
X-Gm-Message-State: AOAM532SR2vRX1gGntMKSSyQfyMO93k+oiQb0KCze5BQAJ89QTmUsd/3
        LTeBe4c4ckgQ148EdcKsxwn0BhZWZRGwCA==
X-Google-Smtp-Source: ABdhPJyepq/FyxwaHlVAPJztiyOHbye8RvQ4vZOUFJ0ohMvVA1rfz7tIumePHE2zpTvbmousvLcXzA==
X-Received: by 2002:a17:902:10a:b029:d2:6379:ab8a with SMTP id 10-20020a170902010ab02900d26379ab8amr365038plb.66.1603911381664;
        Wed, 28 Oct 2020 11:56:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 38sm107425pgx.43.2020.10.28.11.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 11:56:20 -0700 (PDT)
Message-ID: <5f99bed4.1c69fb81.93419.0478@mx.google.com>
Date:   Wed, 28 Oct 2020 11:56:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10-rc1-19-gd1cd1a35b7d5
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 117 runs,
 3 regressions (v5.10-rc1-19-gd1cd1a35b7d5)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 117 runs, 3 regressions (v5.10-rc1-19-gd1cd1a35b7d5)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig          | r=
egressions
----------------+-------+---------------+----------+--------------------+--=
----------
bcm2837-rpi-3-b | arm64 | lab-baylibre  | gcc-8    | defconfig          | 1=
          =

mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig          | 1=
          =

panda           | arm   | lab-collabora | gcc-8    | multi_v7_defconfig | 1=
          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.10-rc=
1-19-gd1cd1a35b7d5/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.10-rc1-19-gd1cd1a35b7d5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d1cd1a35b7d5e318b69f75237ca91f6b0eebfa27 =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig          | r=
egressions
----------------+-------+---------------+----------+--------------------+--=
----------
bcm2837-rpi-3-b | arm64 | lab-baylibre  | gcc-8    | defconfig          | 1=
          =


  Details:     https://kernelci.org/test/plan/id/5f99b02ef0eeaeeb3a381021

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc1-19-gd1cd1=
a35b7d5/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc1-19-gd1cd1=
a35b7d5/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/5f99b02ef0eeaeeb=
3a381026
        failing since 0 day (last pass: v5.9-rc8-160-g91e0225c546b, first f=
ail: v5.10-rc1-4-ge213cd8f175c)
        2 lines

    2020-10-28 17:51:36.617000+00:00  Connected to bcm2837-rpi-3-b console =
[channel connected] (~$quit to exit)
    2020-10-28 17:51:36.620000+00:00  (user:khilman) is already connected
    2020-10-28 17:51:52.265000+00:00  =00
    2020-10-28 17:51:52.266000+00:00  =

    2020-10-28 17:51:52.266000+00:00  U-Boot 2018.11 (Dec 04 2018 - 10:54:3=
2 -0800)
    2020-10-28 17:51:52.266000+00:00  =

    2020-10-28 17:51:52.266000+00:00  DRAM:  948 MiB
    2020-10-28 17:51:52.281000+00:00  RPI 3 Model B (0xa02082)
    2020-10-28 17:51:52.369000+00:00  MMC:   mmc@7e202000: 0, sdhci@7e30000=
0: 1
    2020-10-28 17:51:52.401000+00:00  Loading Environment from FAT... *** W=
arning - bad CRC, using default environment =

    ... (383 line(s) more)  =

 =



platform        | arch  | lab           | compiler | defconfig          | r=
egressions
----------------+-------+---------------+----------+--------------------+--=
----------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig          | 1=
          =


  Details:     https://kernelci.org/test/plan/id/5f99b0edb67db2241e381018

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc1-19-gd1cd1=
a35b7d5/arm64/defconfig/gcc-8/lab-collabora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc1-19-gd1cd1=
a35b7d5/arm64/defconfig/gcc-8/lab-collabora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5f99b0edb67db2241e381=
019
        new failure (last pass: v5.10-rc1-4-ge213cd8f175c) =

 =



platform        | arch  | lab           | compiler | defconfig          | r=
egressions
----------------+-------+---------------+----------+--------------------+--=
----------
panda           | arm   | lab-collabora | gcc-8    | multi_v7_defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/5f99b698c113ec7b62381018

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.10-rc1-19-gd1cd1=
a35b7d5/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.10-rc1-19-gd1cd1=
a35b7d5/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/5f99b698c113ec7=
b6238101e
        failing since 69 days (last pass: v5.8-107-gb72b3ea38c81, first fai=
l: v5.9-rc1-4-g1f08d51cd57f)
        60 lines

    2020-10-28 18:21:06.594000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c802
    2020-10-28 18:21:06.599000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c803
    2020-10-28 18:21:06.605000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c804
    2020-10-28 18:21:06.611000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c805
    2020-10-28 18:21:06.617000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c806
    2020-10-28 18:21:06.623000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c807
    2020-10-28 18:21:06.629000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c808
    2020-10-28 18:21:06.635000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c809
    2020-10-28 18:21:06.641000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c80a
    2020-10-28 18:21:06.647000+00:00  kern  :alert : BUG: Bad page state in=
 process swapper/0  pfn:9c80b =

    ... (49 line(s) more)  =

 =20
