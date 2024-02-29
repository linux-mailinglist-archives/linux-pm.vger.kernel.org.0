Return-Path: <linux-pm+bounces-4533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C75F86BF79
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 04:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70F7287D89
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 03:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291381D6BD;
	Thu, 29 Feb 2024 03:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="iPPN8Hxl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E012376E1
	for <linux-pm@vger.kernel.org>; Thu, 29 Feb 2024 03:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709177375; cv=none; b=j9zxHgPn02QMpJwjFsJBL3+Ke9GTobSAusdy8EV77Ei8Mc1FyO3vEGB5yK0lLEvpSZtgVlDle9g3vZJmdMOnUggJpCl6GyrLHA8QjW0aqg/hLPL3id3qAy2zKlA2E7bxFiFk7S/A1sl/FuP6j3KRX8wDnf5OfORSJjekqE2IiF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709177375; c=relaxed/simple;
	bh=T2sb3ZMT0oknkHPNrU4g9LhOmnggMx25DEPUTts0UDM=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=TEUAMpZrAiEOePYd/ONXo5N5GVIvQSGmKlFw0a7gHWRWDeUrbXwSJpby2gyG+vkBlcGO/CDTDH23Q3fJdZD0l4BKjUtN/dpaW2yPjdEYtVgqZpSQZkmgn14/R6Vpi6BZ2X6ette6q6SHvIkzcWN5ZE60/LxF/Oy7tHBNxN9Yt6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=iPPN8Hxl; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-21fa0ec227eso208064fac.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Feb 2024 19:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709177372; x=1709782172; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RNZRHbU9Ez1z7j6TGoqGVhBjG8A5fcRpAijmZFBCUgQ=;
        b=iPPN8Hxl9aqMR6tg7Yl83GQMQOI4C6jxehbtyQE8a3FieR9jtQIHxtQMBOBSZnZI+w
         GYOdq87J8B9zDBgsGpP/pTCmiXxHB2Wp3HQRzg9l91BfUL5SqkJGeIRIcNjx813nDBXr
         TC5HG8P6PkqxRcNWnHORh+jk/dAr6oV/gpqXoBHdECcTs3DxDkqecK9M1T+GOck5b14c
         Johk1MdfkG04vnaUZUlZaIvmEnxhkge3QhQmMTqle8sYvU7n/dDkGXxaHOj38tprcvf2
         pb86RLCyglj8qn1xIlunLWuizSzNNp75XYS1queYrdtHgNXUBzV3iLNSYGsCdpV7AtI8
         PNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709177372; x=1709782172;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNZRHbU9Ez1z7j6TGoqGVhBjG8A5fcRpAijmZFBCUgQ=;
        b=J77P6VVQEIYyQgCVkXkK2vXJWVVq3YAeT80MlnWE9ddgecQpu+fxWL5rGHejjjvRUM
         EtfdxVH1KwhDCaNslWrrTjNXx/AnfVnt7cTz8qhPF+k9pGwVZJuL5p+nRZQTl96IdWRj
         tSkpYlO9g7Kwf6KwP+ckPTqANTsHVk2SGVZn2R/Cps/pL2DZl1kLd9hhVyu/ZzcoYMUC
         p8gwUNlnKU1UDEgTHeHw5rh/SHfyARmqRzA7ANNakBE6Ae2h55RrioI+iSKSA8SDjG1y
         lkBHu/assVSfGvoKMXum+KVzmJYnf+LXRCHnOe48i7x1aUM7uk2+6ZqTV1LiaHI+p/+t
         qBcA==
X-Forwarded-Encrypted: i=1; AJvYcCW3jfZCGRUdLaHC2piwql+EnvXLPiHmU+V2e5+EOmN1ynVtwc3M2CezWDjYDr8tb744hHBZ0GDAC1tMsQXExp54pNHb2alZl8M=
X-Gm-Message-State: AOJu0YyUSiZA72uZGFzqzTr2vClCflgWlqp8E2gKjpsdvX4Oh5uZUKW7
	MLglSbf07CU1i+CyxPIC+7xCueKibizBfK44eq7KNPDOANkDC2C9Y6JBriXnRVk=
X-Google-Smtp-Source: AGHT+IH7+y8mB/ySFwd3DGXOk+mzXTsAcOht5KN4nUUDfr7/CtvciRS3jJUdHbrMSWMHjki5dwL3DA==
X-Received: by 2002:a05:6870:207:b0:21e:a976:81d7 with SMTP id j7-20020a056870020700b0021ea97681d7mr834705oad.15.1709177371934;
        Wed, 28 Feb 2024 19:29:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i37-20020a635865000000b005dc5289c4edsm218921pgm.64.2024.02.28.19.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 19:29:31 -0800 (PST)
Message-ID: <65dffa1b.630a0220.1c37a.10e5@mx.google.com>
Date: Wed, 28 Feb 2024 19:29:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.8-rc6-144-g07a90c3d91505
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 49 runs,
 8 regressions (v6.8-rc6-144-g07a90c3d91505)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 49 runs, 8 regressions (v6.8-rc6-144-g07a90c3d91505)

Regressions Summary
-------------------

platform               | arch  | lab             | compiler | defconfig    =
      | regressions
-----------------------+-------+-----------------+----------+--------------=
------+------------
imx53-qsrb             | arm   | lab-pengutronix | gcc-10   | multi_v7_defc=
onfig | 1          =

kontron-kbox-a-230-ls  | arm64 | lab-kontron     | gcc-10   | defconfig    =
      | 5          =

kontron-sl28-var3-ads2 | arm64 | lab-kontron     | gcc-10   | defconfig    =
      | 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.8-rc6=
-144-g07a90c3d91505/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.8-rc6-144-g07a90c3d91505
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      07a90c3d91505e44a38e74e1588b304131ad8028 =



Test Regressions
---------------- =



platform               | arch  | lab             | compiler | defconfig    =
      | regressions
-----------------------+-------+-----------------+----------+--------------=
------+------------
imx53-qsrb             | arm   | lab-pengutronix | gcc-10   | multi_v7_defc=
onfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65dfefd64909c9e46e637088

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc6-144-g07a90=
c3d91505/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc6-144-g07a90=
c3d91505/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65dfefd64909c9e46e63708d
        failing since 397 days (last pass: v6.1-rc8-156-g0a9e32afe717, firs=
t fail: acpi-6.2-rc6-146-g628c61874ffd)

    2024-02-29T02:45:25.933266  + set +x
    2024-02-29T02:45:25.933425  [   13.496139] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1030389_1.5.2.3.1>
    2024-02-29T02:45:26.039687  / # #
    2024-02-29T02:45:26.140955  export SHELL=3D/bin/sh
    2024-02-29T02:45:26.141447  #
    2024-02-29T02:45:26.242254  / # export SHELL=3D/bin/sh. /lava-1030389/e=
nvironment
    2024-02-29T02:45:26.242746  =

    2024-02-29T02:45:26.343599  / # . /lava-1030389/environment/lava-103038=
9/bin/lava-test-runner /lava-1030389/1
    2024-02-29T02:45:26.344250  =

    2024-02-29T02:45:26.347210  / # /lava-1030389/bin/lava-test-runner /lav=
a-1030389/1 =

    ... (13 line(s) more)  =

 =



platform               | arch  | lab             | compiler | defconfig    =
      | regressions
-----------------------+-------+-----------------+----------+--------------=
------+------------
kontron-kbox-a-230-ls  | arm64 | lab-kontron     | gcc-10   | defconfig    =
      | 5          =


  Details:     https://kernelci.org/test/plan/id/65dfefca8eb304fd6d63703d

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc6-144-g07a90=
c3d91505/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc6-144-g07a90=
c3d91505/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65dfefca8eb304fd6d637044
        failing since 35 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-29T02:45:11.238166  <8>[   20.097361] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 436496_1.5.2.4.1>
    2024-02-29T02:45:11.343463  / # #
    2024-02-29T02:45:11.445474  export SHELL=3D/bin/sh
    2024-02-29T02:45:11.446112  #
    2024-02-29T02:45:11.547468  / # export SHELL=3D/bin/sh. /lava-436496/en=
vironment
    2024-02-29T02:45:11.548239  =

    2024-02-29T02:45:11.649648  / # . /lava-436496/environment/lava-436496/=
bin/lava-test-runner /lava-436496/1
    2024-02-29T02:45:11.650828  =

    2024-02-29T02:45:11.670017  / # /lava-436496/bin/lava-test-runner /lava=
-436496/1
    2024-02-29T02:45:11.714189  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (16 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/65dfefca8eb304fd6d637048
        failing since 35 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-29T02:45:13.822148  /lava-436496/1/../bin/lava-test-case   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/65=
dfefca8eb304fd6d63704a
        failing since 35 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-29T02:45:14.880439  /lava-436496/1/../bin/lava-test-case
    2024-02-29T02:45:14.880887  <8>[   23.708496] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2024-02-29T02:45:14.881250  /lava-436496/1/../bin/lava-test-case
    2024-02-29T02:45:14.881531  <8>[   23.726091] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dleds-gpio-driver-present RESULT=3Dpass>
    2024-02-29T02:45:14.881799  /lava-436496/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65dfefca8eb304fd6d63704f
        failing since 35 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-29T02:45:15.958256  /lava-436496/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/65dfefca8eb304fd6d637050
        failing since 35 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-29T02:45:15.961546  <8>[   24.822779] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2024-02-29T02:45:17.019490  /lava-436496/1/../bin/lava-test-case
    2024-02-29T02:45:17.019923  <8>[   25.844574] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>
    2024-02-29T02:45:17.020241  /lava-436496/1/../bin/lava-test-case
    2024-02-29T02:45:17.020466  <8>[   25.861239] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc_mdio-driver-present RESULT=3Dpass>
    2024-02-29T02:45:17.020678  /lava-436496/1/../bin/lava-test-case   =

 =



platform               | arch  | lab             | compiler | defconfig    =
      | regressions
-----------------------+-------+-----------------+----------+--------------=
------+------------
kontron-sl28-var3-ads2 | arm64 | lab-kontron     | gcc-10   | defconfig    =
      | 2          =


  Details:     https://kernelci.org/test/plan/id/65dfefcc4909c9e46e637012

  Results:     101 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc6-144-g07a90=
c3d91505/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc6-144-g07a90=
c3d91505/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65dfefcc4909c9e46e637019
        failing since 35 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-29T02:45:12.586826  / # #
    2024-02-29T02:45:12.688956  export SHELL=3D/bin/sh
    2024-02-29T02:45:12.689732  #
    2024-02-29T02:45:12.791178  / # export SHELL=3D/bin/sh. /lava-436498/en=
vironment
    2024-02-29T02:45:12.791935  =

    2024-02-29T02:45:12.893428  / # . /lava-436498/environment/lava-436498/=
bin/lava-test-runner /lava-436498/1
    2024-02-29T02:45:12.894741  =

    2024-02-29T02:45:12.914288  / # /lava-436498/bin/lava-test-runner /lava=
-436498/1
    2024-02-29T02:45:12.967118  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-29T02:45:12.967545  + <8>[   21.191613] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 436498_1.5.2.4.5> =

    ... (13 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65dfefcc4909c9e46e63702c
        failing since 35 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-29T02:45:14.345593  <8>[   22.594740] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-driver-present RESULT=3Dpass>
    2024-02-29T02:45:15.402149  /lava-436498/1/../bin/lava-test-case
    2024-02-29T02:45:15.402891  <8>[   23.617631] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2024-02-29T02:45:15.403182  /lava-436498/1/../bin/lava-test-case
    2024-02-29T02:45:15.403415  <8>[   23.635409] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc_mdio-driver-present RESULT=3Dpass>
    2024-02-29T02:45:15.403635  /lava-436498/1/../bin/lava-test-case   =

 =20

