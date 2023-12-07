Return-Path: <linux-pm+bounces-810-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC514809678
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 00:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822471F21065
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 23:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519044F8B1;
	Thu,  7 Dec 2023 23:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="skPhoOyS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622B41712
	for <linux-pm@vger.kernel.org>; Thu,  7 Dec 2023 15:14:37 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-58d08497aa1so716201eaf.0
        for <linux-pm@vger.kernel.org>; Thu, 07 Dec 2023 15:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701990876; x=1702595676; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W/RKYA7JUwK1pOOc+EoaVNKfJ/ekaKtWXaxmfkEjX4k=;
        b=skPhoOySNoqxmYe9nvJDbgloFeE4N94EekX8UgsYu5JRvCgpL4amlRe/8ULlmWtCOD
         IWwbUQTh3pHt4W1Toaxj0UTETZzAnicRnRbI1o8KsG/FKUjaG4Ewvaoj0KRTmMUMTuWZ
         cpVcKsF7OwlifcOjB/fs03gEAWHVxn/j2bcWrAFshrXIeZzXu7a0uV02/7RKkUwxYPYh
         W2Jt98f66zR0CSF6uoeHuZmVWt5QT3sBQDbJimw/9MP6MukoPFrQWi7NraCdY6v5Sxxv
         F4dAL+nmLtZ9dWO7ZTTWkIPPz2ymhv83xPibA+6TyxbhV/EiGXaJAnruyiW5P7VClAJN
         /D4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701990876; x=1702595676;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/RKYA7JUwK1pOOc+EoaVNKfJ/ekaKtWXaxmfkEjX4k=;
        b=uraM9ChDSUqua94xbKcgw1qrZQ1FAJ65tdv+HocMq8mujcMylRNE0GTx8wBwfLfDCT
         pUXPtAfXs0nKBYJKoAIrNH93Lj/5ozKxiEBHa6q6C0jR/EACKaKCBuLzkGn26an2aP9S
         qTJQf/USw1pNPket2jyie1C+BBkerQHajGWrzwMBzDVdAH+pimnr7tfzGNqp1M7e4Cj5
         7KX+92eVSTrrR848v1xYih4+Xbsk0dpMNLXpS1NQ8YaMBrrTMVUpKmqvxV8tTSGerwD+
         94/B3Kr1C7KvEgf6e43f+vFqLB0ktMoreC5hjPsqudw3hucZMAMGzdOr+lq6fNv35XDa
         oyEA==
X-Gm-Message-State: AOJu0YyCDezTn/cRgUPj3t5zvnE1PbbFDR9kh5ACyhC7x2gD6Gj1uaEb
	0aEHOXzsGlsZwYh4CYe3h02GIspF1hpgQ1Bm9ynPIw==
X-Google-Smtp-Source: AGHT+IFeNrlB6puw70UatpyPhyzAb0RNTTm1vTX8bhI6CzZS0qB/ehPh9a5oyTQm6iuVtFBP2BC5XQ==
X-Received: by 2002:a05:6358:9101:b0:170:5522:597b with SMTP id q1-20020a056358910100b001705522597bmr3598656rwq.56.1701990876607;
        Thu, 07 Dec 2023 15:14:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f1-20020a6547c1000000b005c68da96d7dsm256500pgs.38.2023.12.07.15.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 15:14:35 -0800 (PST)
Message-ID: <657251db.650a0220.6e325.15fa@mx.google.com>
Date: Thu, 07 Dec 2023 15:14:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.7-rc4-67-g169769cb3761a
Subject: pm/testing baseline: 59 runs,
 3 regressions (v6.7-rc4-67-g169769cb3761a)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 59 runs, 3 regressions (v6.7-rc4-67-g169769cb3761a)

Regressions Summary
-------------------

platform           | arch  | lab             | compiler | defconfig        =
  | regressions
-------------------+-------+-----------------+----------+------------------=
--+------------
imx6dl-riotboard   | arm   | lab-pengutronix | gcc-10   | multi_v7_defconfi=
g | 1          =

kontron-pitx-imx8m | arm64 | lab-kontron     | gcc-10   | defconfig        =
  | 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.7-rc4=
-67-g169769cb3761a/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.7-rc4-67-g169769cb3761a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      169769cb3761a9d80809ad64ed85e9b1f5b3a810 =



Test Regressions
---------------- =



platform           | arch  | lab             | compiler | defconfig        =
  | regressions
-------------------+-------+-----------------+----------+------------------=
--+------------
imx6dl-riotboard   | arm   | lab-pengutronix | gcc-10   | multi_v7_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/6572477642270e2471e134a4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.7-rc4-67-g169769=
cb3761a/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6dl-riotb=
oard.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.7-rc4-67-g169769=
cb3761a/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6dl-riotb=
oard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6572477642270e2471e134ad
        new failure (last pass: v6.7-rc4-46-g358f5a2a7f791)

    2023-12-07T22:29:55.718072  + set[   15.088528] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1015429_1.5.2.3.1>
    2023-12-07T22:29:55.718347   +x
    2023-12-07T22:29:55.823695  / # #
    2023-12-07T22:29:55.924828  export SHELL=3D/bin/sh
    2023-12-07T22:29:55.925209  #
    2023-12-07T22:29:56.025953  / # export SHELL=3D/bin/sh. /lava-1015429/e=
nvironment
    2023-12-07T22:29:56.026367  =

    2023-12-07T22:29:56.127113  / # . /lava-1015429/environment/lava-101542=
9/bin/lava-test-runner /lava-1015429/1
    2023-12-07T22:29:56.127711  =

    2023-12-07T22:29:56.130785  / # /lava-1015429/bin/lava-test-runner /lav=
a-1015429/1 =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab             | compiler | defconfig        =
  | regressions
-------------------+-------+-----------------+----------+------------------=
--+------------
kontron-pitx-imx8m | arm64 | lab-kontron     | gcc-10   | defconfig        =
  | 2          =


  Details:     https://kernelci.org/test/plan/id/657247b041c3999feae134bf

  Results:     51 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.7-rc4-67-g169769=
cb3761a/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.7-rc4-67-g169769=
cb3761a/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657247b041c3999feae134c2
        new failure (last pass: v6.7-rc4-65-g4a0bf67f43421)

    2023-12-07T22:30:48.118506  / # #
    2023-12-07T22:30:48.220743  export SHELL=3D/bin/sh
    2023-12-07T22:30:48.221471  #
    2023-12-07T22:30:48.322894  / # export SHELL=3D/bin/sh. /lava-403062/en=
vironment
    2023-12-07T22:30:48.323632  =

    2023-12-07T22:30:48.424969  / # . /lava-403062/environment/lava-403062/=
bin/lava-test-runner /lava-403062/1
    2023-12-07T22:30:48.425924  =

    2023-12-07T22:30:48.446181  / # /lava-403062/bin/lava-test-runner /lava=
-403062/1
    2023-12-07T22:30:48.496132  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-07T22:30:48.496558  + cd /l<8>[   15.737703] <LAVA_SIGNAL_START=
RUN 1_bootrr 403062_1.5.2.4.5> =

    ... (10 line(s) more)  =


  * baseline.bootrr.dwc3-usb1-probed: https://kernelci.org/test/case/id/657=
247b041c3999feae134d2
        new failure (last pass: v6.7-rc4-65-g4a0bf67f43421)

    2023-12-07T22:30:50.881159  /lava-403062/1/../bin/lava-test-case
    2023-12-07T22:30:50.881576  <8>[   18.217466] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwc3-usb1-probed RESULT=3Dfail>
    2023-12-07T22:30:50.881879  /lava-403062/1/../bin/lava-test-case   =

 =20

