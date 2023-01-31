Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794D9682B2F
	for <lists+linux-pm@lfdr.de>; Tue, 31 Jan 2023 12:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjAaLNF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Jan 2023 06:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjAaLNE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2023 06:13:04 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D05025E38
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 03:13:02 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id m11so13928925pji.0
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 03:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jnqVORb2U2t1lwt3658kTO4Y8orJDIPeJqYl6LNCrs0=;
        b=LD9x4mF7JpPpuGpP+rdbUggeuhBYFDnBn5hs4/qwJ4XsQfOB9qEzHnl174QDBT4jBP
         kpg4F5lbOLL06xwnyfUkSGcHGbWG2O5Vsb36S2dcAW7IWgdlFDwhqneTuhRWQnxxJ6BF
         +zWfLMYwJXyrv4d2mQ2h2jgpYAuvfs6WD6xmQXF6KlpktrsKJgEWQ6mM7GTHkVyDLP1Q
         qWZy2cdUN9i+lbvlpvWa6JDhK9EU6VDr57noOlpSJ9PLAhRGZuSpVsHhLK1K71p/I1u3
         +JLZEIFAW7HONkaXaJjkJ5SdNtw2HhR1x0YdJKHBzzAS4CbOeMfKkS1UuErWrRdPCX00
         kjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnqVORb2U2t1lwt3658kTO4Y8orJDIPeJqYl6LNCrs0=;
        b=YLDViTIi4ilelMlk/5jDeJJxWqejBH+SoO3QQ2tPFzl1kn+3ZZOeIQPKYrzruaXxN5
         Z7M3G+wutyc7doDDEocjQdB4YjzCuMSqqE4na7iIO3r6SqkDtwm+DF1RfU+Nc1TnvXY2
         zRWssXquAl3rtqUwsHN5P0UjOJsPiePsFid+0+zjOmmHPlMXrwD/i0WSP6meuA1sGOTU
         hnVUohDJ4j+Vlfu1GQd0sw1cCMCOMWhiSqxcBDxCpAIWRgWjIZojIzpLcd86cIbzKkn4
         Qczix7+ZWFyWL7WbGiMF8ge/46BuYlPnuNupSrqEkC4ITH7vsiv1dTMZpNEHtDZORfaI
         RVAQ==
X-Gm-Message-State: AFqh2koogVOjci9LSUw55I7sNsUKSheF8K2sdyOuqxtPMQBDmAuNf20G
        OZxoHSD7ZbrpVEcGKBTIIPBkzHIsYTJdyaJJyLo8NQ==
X-Google-Smtp-Source: AMrXdXv+2Qom8bqK2mOwLsbctShjvjhMpGQsvQ6RNYaCcgbrSKArZxENo+1a0iQnjH8Elp/YJqruJg==
X-Received: by 2002:a17:903:22c9:b0:194:d4d1:a917 with SMTP id y9-20020a17090322c900b00194d4d1a917mr56819158plg.60.1675163581938;
        Tue, 31 Jan 2023 03:13:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902bc4200b001745662d568sm9430077plz.278.2023.01.31.03.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 03:13:01 -0800 (PST)
Message-ID: <63d8f7bd.170a0220.d8d79.012a@mx.google.com>
Date:   Tue, 31 Jan 2023 03:13:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc6-139-gab970ed365c9
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 50 runs,
 3 regressions (v6.2-rc6-139-gab970ed365c9)
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

pm/testing baseline: 50 runs, 3 regressions (v6.2-rc6-139-gab970ed365c9)

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

sun8i-h3-libretech-all-h3-cc | arm  | lab-baylibre    | gcc-10   | multi_v7=
_defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.2-rc6=
-139-gab970ed365c9/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.2-rc6-139-gab970ed365c9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      ab970ed365c92d08f201e4652270de915f965378 =



Test Regressions
---------------- =



platform                     | arch | lab             | compiler | defconfi=
g          | regressions
-----------------------------+------+-----------------+----------+---------=
-----------+------------
cubietruck                   | arm  | lab-baylibre    | gcc-10   | multi_v7=
_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d8e8d1c02e2c7507915f5a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc6-139-gab970=
ed365c9/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc6-139-gab970=
ed365c9/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d8e8d1c02e2c7507915f5f
        failing since 11 days (last pass: v6.1-rc8-176-gcb06e36a6532, first=
 fail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-31T10:09:07.652774  <8>[   15.075496] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3250700_1.5.2.4.1>
    2023-01-31T10:09:07.763312  / # #
    2023-01-31T10:09:07.866842  export SHELL=3D/bin/sh
    2023-01-31T10:09:07.867995  #
    2023-01-31T10:09:07.970309  / # export SHELL=3D/bin/sh. /lava-3250700/e=
nvironment
    2023-01-31T10:09:07.971329  =

    2023-01-31T10:09:07.971824  / # . /lava-3250700/environment<3>[   15.36=
7962] Bluetooth: hci0: command 0x0c03 tx timeout
    2023-01-31T10:09:08.073854  /lava-3250700/bin/lava-test-runner /lava-32=
50700/1
    2023-01-31T10:09:08.075073  =

    2023-01-31T10:09:08.080171  / # /lava-3250700/bin/lava-test-runner /lav=
a-3250700/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch | lab             | compiler | defconfi=
g          | regressions
-----------------------------+------+-----------------+----------+---------=
-----------+------------
imx53-qsrb                   | arm  | lab-pengutronix | gcc-10   | multi_v7=
_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d8e7a050ea17146e915edd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc6-139-gab970=
ed365c9/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc6-139-gab970=
ed365c9/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d8e7a050ea17146e915ee2
        failing since 3 days (last pass: v6.1-rc8-156-g0a9e32afe717, first =
fail: acpi-6.2-rc6-146-g628c61874ffd)

    2023-01-31T10:03:58.644127  + set +x
    2023-01-31T10:03:58.644418  [   12.893845] <LAVA_SIGNAL_ENDRUN 0_dmesg =
892609_1.5.2.3.1>
    2023-01-31T10:03:58.752362  / # #
    2023-01-31T10:03:58.854037  export SHELL=3D/bin/sh
    2023-01-31T10:03:58.854448  #
    2023-01-31T10:03:58.955674  / # export SHELL=3D/bin/sh. /lava-892609/en=
vironment
    2023-01-31T10:03:58.956097  =

    2023-01-31T10:03:59.057294  / # . /lava-892609/environment/lava-892609/=
bin/lava-test-runner /lava-892609/1
    2023-01-31T10:03:59.057843  =

    2023-01-31T10:03:59.061041  / # /lava-892609/bin/lava-test-runner /lava=
-892609/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch | lab             | compiler | defconfi=
g          | regressions
-----------------------------+------+-----------------+----------+---------=
-----------+------------
sun8i-h3-libretech-all-h3-cc | arm  | lab-baylibre    | gcc-10   | multi_v7=
_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d8e7d6b1b29bcd9f915ef3

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc6-139-gab970=
ed365c9/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-libret=
ech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc6-139-gab970=
ed365c9/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-libret=
ech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d8e7d6b1b29bcd9f915ef8
        failing since 12 days (last pass: v6.1-rc8-224-g02f29b079520, first=
 fail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-31T10:04:42.255155  / # #
    2023-01-31T10:04:42.357074  export SHELL=3D/bin/sh
    2023-01-31T10:04:42.357572  #
    2023-01-31T10:04:42.458929  / # export SHELL=3D/bin/sh. /lava-3250710/e=
nvironment
    2023-01-31T10:04:42.459627  =

    2023-01-31T10:04:42.561128  / # . /lava-3250710/environment/lava-325071=
0/bin/lava-test-runner /lava-3250710/1
    2023-01-31T10:04:42.562077  =

    2023-01-31T10:04:42.580416  / # /lava-3250710/bin/lava-test-runner /lav=
a-3250710/1
    2023-01-31T10:04:42.673287  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-31T10:04:42.673925  + cd /lava-3250710/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
