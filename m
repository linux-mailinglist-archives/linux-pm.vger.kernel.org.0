Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F007A1006
	for <lists+linux-pm@lfdr.de>; Thu, 14 Sep 2023 23:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjINVtk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Sep 2023 17:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjINVtj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2023 17:49:39 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D473A270B
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 14:49:35 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68fdd5c1bbbso1102408b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2023 14:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694728175; x=1695332975; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nOzi/n2UPLRdkhS5xI3WiVzYA8hqF71Aw0bVDZ4N8hc=;
        b=mabFpsH5yEI+mBRqfWn5qfbKUOvl1fi2vn4mXL5M8/knD3EWTjBriREiBhvczSwGZJ
         lmHIMEEH+M40IiQS14IgERJwlZF5DwOR/ZIZogg1Wa5OTc3Mk6Qs3RExEIsNH5U1V7GZ
         iJQW0qsIMDwOLRf237QP/51otv5djaxh09KxZLF4b8hCUKrB+5wrhYls1ZUyQGaTniV1
         w30dNcAy5753BPGOT8fgF+A9SG8i7f1dYyzDbibftV7rIPyjkOX7qMC1LPlMQ0T3uZ7u
         QGZ7UviAVhgRFeDXTpGDbUJ3DWGfOmP5eA+rRPU0uoIvQyBUUCiy71i1lsz7XYnWXS9T
         tztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694728175; x=1695332975;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nOzi/n2UPLRdkhS5xI3WiVzYA8hqF71Aw0bVDZ4N8hc=;
        b=GCmdRcor8NOmfQy7dPiTLPVHIefStMNN9Kglk5WiWdCDWNy7fJVxqfhtRzGWh/vpbG
         1JzByeAVEacS6XZpgqZKOAX1LfUP5/nQS7DN1/Isx/54kDFjsZve4NtE6l6NI/yBWeC7
         paBNqhbToQxhJ63hGrvxuK+8Qmx2mVVLtRAzqfebku41v8pTo9f4QbQELoUrratumQCB
         uKxwpymvJNLCEZ66Sb4nQoIKuuXe46QUC1Vrz6s/p6fmzdW+hNVewfft27ngBiEV6khg
         qTtBXQC4cfK+nQ+VQZZw/mF+xwOgHZl3EKvs1x2vLQvh0F3p2sbzNdMyvba1gf5rHr43
         krkA==
X-Gm-Message-State: AOJu0Yy3kE8ItmXYcxuLQsZTwdSutzSiW+7g2L+BBTw6JrAy6QtAbgH6
        g8N9T/pcyhJj29ADa1O/NyuZq9/O2MvSUJtxSYvlRw==
X-Google-Smtp-Source: AGHT+IFibDRpQXG3BNE4qa/tZIF9W858Kw/CWcamm3dQFVfHEIaOxmQJp2wO60Pu3w7cZ8XHXAkYIA==
X-Received: by 2002:a05:6a00:3189:b0:68a:4102:e483 with SMTP id bj9-20020a056a00318900b0068a4102e483mr3683946pfb.14.1694728175262;
        Thu, 14 Sep 2023 14:49:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ff16-20020a056a002f5000b0068c65da7b1esm1755023pfb.159.2023.09.14.14.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 14:49:34 -0700 (PDT)
Message-ID: <65037fee.050a0220.f76cc.6d64@mx.google.com>
Date:   Thu, 14 Sep 2023 14:49:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.6-rc1-18-g77717cab92056
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 49 runs,
 3 regressions (v6.6-rc1-18-g77717cab92056)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 49 runs, 3 regressions (v6.6-rc1-18-g77717cab92056)

Regressions Summary
-------------------

platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
imx8mp-evk    | arm64 | lab-broonie   | gcc-10   | defconfig | 1          =

r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =

r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.6-rc1=
-18-g77717cab92056/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.6-rc1-18-g77717cab92056
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      77717cab92056218f16b9fa41af5363b9411f4d6 =



Test Regressions
---------------- =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
imx8mp-evk    | arm64 | lab-broonie   | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6503753aa01cd4719e8a0a53

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc1-18-g77717c=
ab92056/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc1-18-g77717c=
ab92056/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6503753aa01cd4719e8a0a5c
        failing since 2 days (last pass: pm-6.6-rc1-122-g07b618ec9d7a, firs=
t fail: v6.6-rc1-5-gb5eda4c9c923)

    2023-09-14T21:03:31.096919  / # #
    2023-09-14T21:03:32.262622  export SHELL=3D/bin/sh
    2023-09-14T21:03:32.268742  #
    2023-09-14T21:03:33.767738  / # export SHELL=3D/bin/sh. /lava-108371/en=
vironment
    2023-09-14T21:03:33.773804  =

    2023-09-14T21:03:36.496346  / # . /lava-108371/environment/lava-108371/=
bin/lava-test-runner /lava-108371/1
    2023-09-14T21:03:36.503137  =

    2023-09-14T21:03:36.505839  / # /lava-108371/bin/lava-test-runner /lava=
-108371/1
    2023-09-14T21:03:36.535297  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-14T21:03:36.536322  + cd /l<8>[   34.565381] <LAVA_SIGNAL_START=
RUN 1_bootrr 108371_1.5.2.4.5> =

    ... (11 line(s) more)  =

 =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6503750d7d19cfc3ce8a0ad6

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc1-18-g77717c=
ab92056/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc1-18-g77717c=
ab92056/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6503750d7d19cfc3ce8a0adf
        failing since 57 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-09-14T21:07:14.129099  / # #

    2023-09-14T21:07:14.231286  export SHELL=3D/bin/sh

    2023-09-14T21:07:14.231554  #

    2023-09-14T21:07:14.332506  / # export SHELL=3D/bin/sh. /lava-11528247/=
environment

    2023-09-14T21:07:14.333237  =


    2023-09-14T21:07:14.434696  / # . /lava-11528247/environment/lava-11528=
247/bin/lava-test-runner /lava-11528247/1

    2023-09-14T21:07:14.435705  =


    2023-09-14T21:07:14.437909  / # /lava-11528247/bin/lava-test-runner /la=
va-11528247/1

    2023-09-14T21:07:14.501968  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-14T21:07:14.502493  + cd /lav<8>[   20.383781] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11528247_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a779m1-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65037522fb00fac2f08a0a8a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc1-18-g77717c=
ab92056/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc1-18-g77717c=
ab92056/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65037522fb00fac2f08a0a93
        failing since 57 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-09-14T21:05:00.020423  / # #

    2023-09-14T21:05:01.100605  export SHELL=3D/bin/sh

    2023-09-14T21:05:01.102460  #

    2023-09-14T21:05:02.593800  / # export SHELL=3D/bin/sh. /lava-11528241/=
environment

    2023-09-14T21:05:02.595760  =


    2023-09-14T21:05:05.320158  / # . /lava-11528241/environment/lava-11528=
241/bin/lava-test-runner /lava-11528241/1

    2023-09-14T21:05:05.322248  =


    2023-09-14T21:05:05.328344  / # /lava-11528241/bin/lava-test-runner /la=
va-11528241/1

    2023-09-14T21:05:05.391976  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-14T21:05:05.392470  + cd /lava-115282<8>[   28.541945] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11528241_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =20
