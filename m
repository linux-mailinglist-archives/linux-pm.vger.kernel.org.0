Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F6967B8D2
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 18:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbjAYRtl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Jan 2023 12:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbjAYRtf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2023 12:49:35 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF532940F
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 09:49:32 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id m7-20020a17090a71c700b0022c0c070f2eso2147047pjs.4
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 09:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rSnmG0DJAJHX1i218XtinHC0HWdD2Bl/dskPWEpsMeA=;
        b=47QM94OfOjR7lfmPQPlwT5CmPj2ZY+wayIasQPEh/ogJtAAzQbY9Du+av7vUI9dK2v
         G3n7vUcpJFkmJJ7QGBZ/o7FECDg+4Rd+EDDfk7yfsyND6qBBh7OAcw2AWvcr+6h+1EAO
         L5w3sVbw4r1HOawbwx7X0dzcLDQJWDT9ZRZlsVizYvPlxClIrld0aeagzhAJWbWVmPLj
         rvX8ynHyX8ekBq31Micoa/o9Z0vX37HCcjSumBBkudxo5Nm6xQCf39+i4f/bB9XdXIS9
         1rIDqD3wrJHkWa0Fg4ZpKnRFQVSihim0EF1fOgyZwtPWzRq1nP6Ogvq2eM8HwSK21o3Z
         UZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSnmG0DJAJHX1i218XtinHC0HWdD2Bl/dskPWEpsMeA=;
        b=Z6tdbvBJ0pNRjVBxTa/1OnxU58cAP1C2Jw93W2D7GAqR0sCMNpPysGzUkHPwrsOSrN
         B41oX4cL5Dc7dXd+VoK1Hx9NQNcJSHJW4Ob1sR59Cfaoe8idWC1sYL4+2de36UJozbqV
         lOW1gpshkE0vSwvSg4+GprCIvMEAmVLm4vSo3jS3+5r+V/0fEKZB7dqGInmSaj6fLfzl
         6Bu1YK26l0+yccrfmuRBd6rxmCbWxN6DjuBActrBIq+lbbGgDAYTAXlrpzQru1tG8sFO
         36x00H0zhvco+sJoy22B0N/50QATTOMaFiSwmoaBVTkO2QaTZY0SRniGGGDzZVtIm6SJ
         DZ2w==
X-Gm-Message-State: AO0yUKU0+OaXuoZSdRwEucwddIu4Lj73nM5V2WcahNP8uL0cZG/xpBXI
        v1YaI13j2eP/uH0R2N8DfFXnpg==
X-Google-Smtp-Source: AK7set/bWWVlJMeHLhegECDIT5nDebmx5CB5M1GyORPmAW7AHaiMiujV6X+XDK/CAksTg2KG5xfmUg==
X-Received: by 2002:a17:902:dac2:b0:196:1257:3cc5 with SMTP id q2-20020a170902dac200b0019612573cc5mr7930680plx.17.1674668971882;
        Wed, 25 Jan 2023 09:49:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r19-20020a170902be1300b001963bc7bdb8sm10939pls.274.2023.01.25.09.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 09:49:31 -0800 (PST)
Message-ID: <63d16bab.170a0220.feed7.0077@mx.google.com>
Date:   Wed, 25 Jan 2023 09:49:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc5-97-gf108f07918a9
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 72 runs,
 6 regressions (v6.2-rc5-97-gf108f07918a9)
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

pm/testing baseline: 72 runs, 6 regressions (v6.2-rc5-97-gf108f07918a9)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
cubietruck                   | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =

juno-uboot                   | arm64 | lab-broonie  | gcc-10   | defconfig =
         | 1          =

kontron-pitx-imx8m           | arm64 | lab-kontron  | gcc-10   | defconfig =
         | 2          =

sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =

sun8i-h3-libretech-all-h3-cc | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.2-rc5=
-97-gf108f07918a9/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.2-rc5-97-gf108f07918a9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      f108f07918a97e350e08b923311657f0fcf70b0b =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
cubietruck                   | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d16239979eef9c29915ed5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-97-gf108f0=
7918a9/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-97-gf108f0=
7918a9/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d16239979eef9c29915eda
        failing since 6 days (last pass: v6.1-rc8-176-gcb06e36a6532, first =
fail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-25T17:08:53.754424  + set +x<8>[   15.038648] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3211188_1.5.2.4.1>
    2023-01-25T17:08:53.755232  =

    2023-01-25T17:08:53.863182  / # #
    2023-01-25T17:08:53.966888  export SHELL=3D/bin/sh
    2023-01-25T17:08:53.967806  #
    2023-01-25T17:08:54.069922  / # export SHELL=3D/bin/sh. /lava-3211188/e=
nvironment
    2023-01-25T17:08:54.070864  =

    2023-01-25T17:08:54.173139  / # . /lava-3211188/environment/lava-321118=
8/bin/lava-test-runner /lava-3211188/1
    2023-01-25T17:08:54.174871  =

    2023-01-25T17:08:54.179530  / # /lava-3211188/bin/lava-test-runner /lav=
a-3211188/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
juno-uboot                   | arm64 | lab-broonie  | gcc-10   | defconfig =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/63d162a49489fba1d0915eb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-97-gf108f0=
7918a9/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-97-gf108f0=
7918a9/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63d162a49489fba1d0915=
eba
        new failure (last pass: v6.2-rc5-92-g2f9e90528ee7) =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
kontron-pitx-imx8m           | arm64 | lab-kontron  | gcc-10   | defconfig =
         | 2          =


  Details:     https://kernelci.org/test/plan/id/63d16171aaa2eafcbf915ee9

  Results:     51 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-97-gf108f0=
7918a9/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-97-gf108f0=
7918a9/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d16171aaa2eafcbf915eec
        new failure (last pass: v6.2-rc5-92-g2f9e90528ee7)

    2023-01-25T17:05:41.972889  / # #
    2023-01-25T17:05:42.075104  export SHELL=3D/bin/sh
    2023-01-25T17:05:42.075832  #
    2023-01-25T17:05:42.177269  / # export SHELL=3D/bin/sh. /lava-255608/en=
vironment
    2023-01-25T17:05:42.177843  =

    2023-01-25T17:05:42.279342  / # . /lava-255608/environment/lava-255608/=
bin/lava-test-runner /lava-255608/1
    2023-01-25T17:05:42.280088  =

    2023-01-25T17:05:42.284717  / # /lava-255608/bin/lava-test-runner /lava=
-255608/1
    2023-01-25T17:05:42.350612  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-25T17:05:42.350944  + cd /l<8>[   16.201353] <LAVA_SIGNAL_START=
RUN 1_bootrr 255608_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/63d=
16171aaa2eafcbf915efc
        new failure (last pass: v6.2-rc5-92-g2f9e90528ee7)

    2023-01-25T17:05:46.410135  /lava-255608/1/../bin/lava-test-case
    2023-01-25T17:05:46.410541  <8>[   20.425551] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-01-25T17:05:46.410783  /lava-255608/1/../bin/lava-test-case   =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
sun8i-h2-plus...ch-all-h3-cc | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d1609f9a033d65c2915f02

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-97-gf108f0=
7918a9/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-li=
bretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-97-gf108f0=
7918a9/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h2-plus-li=
bretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d1609f9a033d65c2915f07
        failing since 6 days (last pass: v6.1-rc8-224-g02f29b079520, first =
fail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-25T17:02:07.040537  / # #
    2023-01-25T17:02:07.142265  export SHELL=3D/bin/sh
    2023-01-25T17:02:07.142750  #
    2023-01-25T17:02:07.244119  / # export SHELL=3D/bin/sh. /lava-3211176/e=
nvironment
    2023-01-25T17:02:07.244475  =

    2023-01-25T17:02:07.345823  / # . /lava-3211176/environment/lava-321117=
6/bin/lava-test-runner /lava-3211176/1
    2023-01-25T17:02:07.346472  =

    2023-01-25T17:02:07.351310  / # /lava-3211176/bin/lava-test-runner /lav=
a-3211176/1
    2023-01-25T17:02:07.455300  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-25T17:02:07.455783  + cd /lava-3211176/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
sun8i-h3-libretech-all-h3-cc | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d160b69a033d65c2915f3a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc5-97-gf108f0=
7918a9/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-librete=
ch-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc5-97-gf108f0=
7918a9/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-librete=
ch-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63d160b69a033d65c2915f3f
        failing since 6 days (last pass: v6.1-rc8-224-g02f29b079520, first =
fail: v6.2-rc4-74-g590cffafa8dd)

    2023-01-25T17:02:25.158695  / # #
    2023-01-25T17:02:25.260663  export SHELL=3D/bin/sh
    2023-01-25T17:02:25.261238  #
    2023-01-25T17:02:25.362621  / # export SHELL=3D/bin/sh. /lava-3211187/e=
nvironment
    2023-01-25T17:02:25.363169  =

    2023-01-25T17:02:25.464603  / # . /lava-3211187/environment/lava-321118=
7/bin/lava-test-runner /lava-3211187/1
    2023-01-25T17:02:25.465383  =

    2023-01-25T17:02:25.469754  / # /lava-3211187/bin/lava-test-runner /lav=
a-3211187/1
    2023-01-25T17:02:25.591780  + export 'TESTRUN_ID=3D1_bootrr'
    2023-01-25T17:02:25.592401  + cd /lava-3211187/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
