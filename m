Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C5C689E77
	for <lists+linux-pm@lfdr.de>; Fri,  3 Feb 2023 16:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjBCPlP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Feb 2023 10:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjBCPlO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2023 10:41:14 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A024A4213
        for <linux-pm@vger.kernel.org>; Fri,  3 Feb 2023 07:41:13 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id h9so5578322plf.9
        for <linux-pm@vger.kernel.org>; Fri, 03 Feb 2023 07:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z2oxEAo6a2tb7tOni2suT1hPFhORDvlwTdYRMVrouZQ=;
        b=sl03yHV1C0DBU4kCxMNDx6A5dFHHaajlf/2gBbBGknu2WYOuQ2Dhgsm/MrSrgUgdyc
         aXiZRR6Jg7V3eY6s2CG7AbADL7SVbWiqtly5hFYhV6eRGWtUISrr3ToHwjv9rxJwz+9M
         5vSNnQYkWt9pPn5Xq5UdY2rVmdw2aVFxUeZaUWu9tXR1OM2kM3TTSMd8gSv2aRslyMk3
         +WYl7UivB5AnjH+s6KY9/S48I7NEeSm+/glN/wAoYKtOpuU8BA8Yz8bhL/CXBvvjMIAV
         g29DPHSC5ut5M8OfataRAlld5d6COxbWfpQoiflBAltFUOO2Ry7nr/37JyZ/C0cDJxjj
         aQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2oxEAo6a2tb7tOni2suT1hPFhORDvlwTdYRMVrouZQ=;
        b=h0GAn6Vc1xewGBTdkDUGKJjV7f1xfvP/bF3EaFvCVBKjYOf7CoT8wrk840C/PD+Zxs
         2gpq0x77ZhVhsyDtDUDen70mD9Q6aFsPuAjBbOHzYXluCcMJ+fXNsR1XNaHTJsdP0Yxa
         WBYQvjIn9yp9WeAE+aCb1X/iT+m9voV2QH8HzDSdbbm5QIJOcd/tASWB95uvP/sOXT8f
         2PIaw5dmfox6HHgIqohBihiBT5USCQ4VAU6mpiqDYfR+gwLljEaYQU8L4O8+tM+QcyDI
         s/VRWS4FS8vNgtZ6SDGyozJgdNXwIovffMSXfGiDS/Auv+cWsQAqjsJooyHoDL0lDKTz
         SSkA==
X-Gm-Message-State: AO0yUKU8rI9+xd1PIwzP9oi5HvcSuaYeVFazAs+M/8xklXjFlIzR3/hQ
        RoYHnNj2nrkXirxGY7VISYXyCB7sNSCy5oJ4l/yROw==
X-Google-Smtp-Source: AK7set+kLfXjFhXfPR1xLQtDaKen2uOr0gkOp/UMCiQOW5PjvQycv6TQ3KQhmV7qr7nsTtN1EyVSYg==
X-Received: by 2002:a05:6a20:3c8a:b0:bd:f7a:ef06 with SMTP id b10-20020a056a203c8a00b000bd0f7aef06mr13078442pzj.47.1675438873155;
        Fri, 03 Feb 2023 07:41:13 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k14-20020aa792ce000000b00580cc63dce8sm1902314pfa.77.2023.02.03.07.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 07:41:12 -0800 (PST)
Message-ID: <63dd2b18.a70a0220.df42f.3068@mx.google.com>
Date:   Fri, 03 Feb 2023 07:41:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc6-168-ga9dd827a6e77
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 95 runs,
 4 regressions (v6.2-rc6-168-ga9dd827a6e77)
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

pm/testing baseline: 95 runs, 4 regressions (v6.2-rc6-168-ga9dd827a6e77)

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
-168-ga9dd827a6e77/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.2-rc6-168-ga9dd827a6e77
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a9dd827a6e77dec5b861c924206d85b63156df16 =



Test Regressions
---------------- =



platform                     | arch | lab             | compiler | defconfi=
g          | regressions
-----------------------------+------+-----------------+----------+---------=
-----------+------------
cubietruck                   | arm  | lab-baylibre    | gcc-10   | multi_v7=
_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63dd21b9e1b5d075ce915eb9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc6-168-ga9dd8=
27a6e77/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc6-168-ga9dd8=
27a6e77/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63dd21b9e1b5d075ce915ebe
        failing since 15 days (last pass: v6.1-rc8-176-gcb06e36a6532, first=
 fail: v6.2-rc4-74-g590cffafa8dd)

    2023-02-03T15:00:47.198686  + set +x<8>[   13.617863] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 3281726_1.5.2.4.1>
    2023-02-03T15:00:47.199324  =

    2023-02-03T15:00:47.309088  / # #
    2023-02-03T15:00:47.412434  export SHELL=3D/bin/sh
    2023-02-03T15:00:47.413496  #
    2023-02-03T15:00:47.515728  / # export SHELL=3D/bin/sh. /lava-3281726/e=
nvironment
    2023-02-03T15:00:47.516768  =

    2023-02-03T15:00:47.619037  / # . /lava-3281726/environment/lava-328172=
6/bin/lava-test-runner /lava-3281726/1
    2023-02-03T15:00:47.620737  =

    2023-02-03T15:00:47.621162  / # <3>[   13.997878] Bluetooth: hci0: comm=
and 0x0c03 tx timeout =

    ... (13 line(s) more)  =

 =



platform                     | arch | lab             | compiler | defconfi=
g          | regressions
-----------------------------+------+-----------------+----------+---------=
-----------+------------
imx53-qsrb                   | arm  | lab-pengutronix | gcc-10   | multi_v7=
_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63dd1fcceaad3702cd915eec

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc6-168-ga9dd8=
27a6e77/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc6-168-ga9dd8=
27a6e77/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63dd1fcceaad3702cd915ef1
        failing since 6 days (last pass: v6.1-rc8-156-g0a9e32afe717, first =
fail: acpi-6.2-rc6-146-g628c61874ffd)

    2023-02-03T14:52:50.989460  + set +x
    2023-02-03T14:52:50.989628  [   12.892429] <LAVA_SIGNAL_ENDRUN 0_dmesg =
897279_1.5.2.3.1>
    2023-02-03T14:52:51.096753  / # #
    2023-02-03T14:52:51.198266  export SHELL=3D/bin/sh
    2023-02-03T14:52:51.198750  #
    2023-02-03T14:52:51.300162  / # export SHELL=3D/bin/sh. /lava-897279/en=
vironment
    2023-02-03T14:52:51.300758  =

    2023-02-03T14:52:51.402118  / # . /lava-897279/environment/lava-897279/=
bin/lava-test-runner /lava-897279/1
    2023-02-03T14:52:51.402865  =

    2023-02-03T14:52:51.405912  / # /lava-897279/bin/lava-test-runner /lava=
-897279/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch | lab             | compiler | defconfi=
g          | regressions
-----------------------------+------+-----------------+----------+---------=
-----------+------------
stm32mp157c-dk2              | arm  | lab-baylibre    | gcc-10   | multi_v7=
_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63dd1fad3cfb9935dd915f23

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc6-168-ga9dd8=
27a6e77/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm32mp157c-dk2=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc6-168-ga9dd8=
27a6e77/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-stm32mp157c-dk2=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63dd1fad3cfb9935dd915f28
        failing since 0 day (last pass: v5.19-rc6-53-ge71c5921cc50, first f=
ail: v6.2-rc6-147-ge09c4cd57910)

    2023-02-03T14:52:16.780691  <8>[   15.260071] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3281706_1.5.2.4.1>
    2023-02-03T14:52:16.886446  / # #
    2023-02-03T14:52:16.988067  export SHELL=3D/bin/sh
    2023-02-03T14:52:16.988458  #
    2023-02-03T14:52:17.089613  / # export SHELL=3D/bin/sh. /lava-3281706/e=
nvironment
    2023-02-03T14:52:17.090014  =

    2023-02-03T14:52:17.191256  / # . /lava-3281706/environment/lava-328170=
6/bin/lava-test-runner /lava-3281706/1
    2023-02-03T14:52:17.191912  =

    2023-02-03T14:52:17.194860  / # /lava-3281706/bin/lava-test-runner /lav=
a-3281706/1
    2023-02-03T14:52:17.271709  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch | lab             | compiler | defconfi=
g          | regressions
-----------------------------+------+-----------------+----------+---------=
-----------+------------
sun8i-h3-libretech-all-h3-cc | arm  | lab-baylibre    | gcc-10   | multi_v7=
_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63dd1fd91169eb9318915ecf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc6-168-ga9dd8=
27a6e77/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-libret=
ech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc6-168-ga9dd8=
27a6e77/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-sun8i-h3-libret=
ech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230127.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63dd1fd91169eb9318915ed4
        failing since 15 days (last pass: v6.1-rc8-224-g02f29b079520, first=
 fail: v6.2-rc4-74-g590cffafa8dd)

    2023-02-03T14:52:44.795258  / # #
    2023-02-03T14:52:44.896938  export SHELL=3D/bin/sh
    2023-02-03T14:52:44.897291  #
    2023-02-03T14:52:44.998603  / # export SHELL=3D/bin/sh. /lava-3281702/e=
nvironment
    2023-02-03T14:52:44.998956  =

    2023-02-03T14:52:45.100312  / # . /lava-3281702/environment/lava-328170=
2/bin/lava-test-runner /lava-3281702/1
    2023-02-03T14:52:45.100937  =

    2023-02-03T14:52:45.106598  / # /lava-3281702/bin/lava-test-runner /lav=
a-3281702/1
    2023-02-03T14:52:45.211431  + export 'TESTRUN_ID=3D1_bootrr'
    2023-02-03T14:52:45.211922  + cd /lava-3281702/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20
