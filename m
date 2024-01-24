Return-Path: <linux-pm+bounces-2633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E4483A055
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 05:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B0528A95E
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jan 2024 04:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262856FBB;
	Wed, 24 Jan 2024 04:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="T/mofMYT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3993663AA
	for <linux-pm@vger.kernel.org>; Wed, 24 Jan 2024 04:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706068889; cv=none; b=BPhe0gIx5gwjpL5tFlVn+HWmCtdrTC3xbzI5PpTwK64dPXOdZsqbBD7VxY8rNBL8s/HiDy84fw7H1EyA0vMtI+3J3IXS3umlpyBdpr6ofNr/5Q/5sFBkpzNbyyATMtAQ0J+H/P3RTARHyYMYw3CGBtyPSw1VbyNkPGZdK0x8pfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706068889; c=relaxed/simple;
	bh=k6/zVcPPpv6cVxigNQcvG4pmWV8AeECxhlOCWGCWz2k=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=WleF19f6EwiY5VI24bdIB3RP4QmHEFHADb100VAlTGfo4hm/fOgfy7CGhL6D/FESWfMqgxzepHB69N3ArpkvIde4/HlGn8apRRoWTziBnUo+YnyX32W2xiMMZ7d3gy0TCLOy3ONxRUPUNucvVWV/hoYkKliScQ8ZpTr7/lHPBko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=T/mofMYT; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5997492d71cso1932838eaf.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Jan 2024 20:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706068886; x=1706673686; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YifB4PCuXMCqk4bCIQNI5PsmqT+4zLnzdXgwPfBnDZI=;
        b=T/mofMYTZTzoabkdisctmFIQWsJwopGX3JsqETmps5lGzDaMDRFjdcMoFoy3DEYwmj
         y+4lQJ5/EG9WvmL5QH+INfMT6d61kFflam6LozyoBWVFx6BzJlbqhH+MQmhjkLa6KrCQ
         /0LVFzhwbtMf6pICWfhm3HIopmPwrGtdKyAxUKluCEG4NIim1WecZXlyjvnImO0SwhgC
         Y2lXnLjgEVMrydnQAkULdx4gOnSh+zilXQ18mU59gVph5/a6ZTbwiduZvQwxqd0pi3sm
         Rhw0nBMg6WXcKUyxhlNsLMs0U1UagLEaz0otnrGwHUFa21EqSZ8ga7Uc4AfVPsqxiat9
         grEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706068886; x=1706673686;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YifB4PCuXMCqk4bCIQNI5PsmqT+4zLnzdXgwPfBnDZI=;
        b=RTy9m67xI1x6Tfu9HxN0N5x9hkiDb6a0a7kXHE+a2HJk3u6lZF1uSsE5fGSpidGJ5A
         SKy+v2CxTArLODVy5W2DszRJdEwIF7C3MIv+arKUBVSbTqCyhhz0J7n6p9UIizhoLLbs
         wnJ3Atnd8qump8TBCO/ZaXFkC8KkcD/P7n9UlNtU8hdlmLiR5N+Wzr5S/nXfv/1EHwK3
         zkmqSDf3oRH6oR8VkdKUV4fiDILGw9W8kYHh8kfVj5b3k3RtjcSUFqSHDNz25m4Soyyp
         4TLL5AAxZWYAobA0XKgJlPWuSxEO/vLeA+v/RW1U2YT+cth7+QLedKtB/kGJXeXASLwR
         yX+g==
X-Gm-Message-State: AOJu0YzelGs4F3JbdYpcfew98HrJgKSumTY+29x0yY4KaoPLAGsMXGHP
	NKZpeIP3kiGq77KKrG3oezknkXVV8lu6KOk/H/5W1Nut1OUCD9aVyuvlCXAebOo=
X-Google-Smtp-Source: AGHT+IGzWrQ5Kvd9PfJbZ6ZP0oV+ULebsv5lj0uBtVaWAV4DhfOt6TapZRJ09Ul+ldNK0dnQhkJIPA==
X-Received: by 2002:a05:6358:ee46:b0:175:cd07:937c with SMTP id ik6-20020a056358ee4600b00175cd07937cmr5973707rwb.40.1706068885984;
        Tue, 23 Jan 2024 20:01:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id pd14-20020a17090b1dce00b00290e148dbe1sm1350259pjb.30.2024.01.23.20.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 20:01:25 -0800 (PST)
Message-ID: <65b08b95.170a0220.33c32.69db@mx.google.com>
Date: Tue, 23 Jan 2024 20:01:25 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc1-9-g3d5bdaa27c031
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 47 runs,
 8 regressions (v6.8-rc1-9-g3d5bdaa27c031)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 47 runs, 8 regressions (v6.8-rc1-9-g3d5bdaa27c031)

Regressions Summary
-------------------

platform               | arch  | lab           | compiler | defconfig | reg=
ressions
-----------------------+-------+---------------+----------+-----------+----=
--------
kontron-kbox-a-230-ls  | arm64 | lab-kontron   | gcc-10   | defconfig | 5  =
        =

kontron-sl28-var3-ads2 | arm64 | lab-kontron   | gcc-10   | defconfig | 2  =
        =

rk3399-rock-pi-4b      | arm64 | lab-collabora | gcc-10   | defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.8-rc1=
-9-g3d5bdaa27c031/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.8-rc1-9-g3d5bdaa27c031
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      3d5bdaa27c031adcd79e46503159fa720ff8535f =



Test Regressions
---------------- =



platform               | arch  | lab           | compiler | defconfig | reg=
ressions
-----------------------+-------+---------------+----------+-----------+----=
--------
kontron-kbox-a-230-ls  | arm64 | lab-kontron   | gcc-10   | defconfig | 5  =
        =


  Details:     https://kernelci.org/test/plan/id/65b080ac5416376bda52a439

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc1-9-g3d5bdaa=
27c031/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc1-9-g3d5bdaa=
27c031/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65b080ac5416376bda52a440
        new failure (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4)

    2024-01-24T03:14:39.082756  / # #
    2024-01-24T03:14:39.184867  export SHELL=3D/bin/sh
    2024-01-24T03:14:39.185675  #
    2024-01-24T03:14:39.287131  / # export SHELL=3D/bin/sh. /lava-421386/en=
vironment
    2024-01-24T03:14:39.287910  =

    2024-01-24T03:14:39.389269  / # . /lava-421386/environment/lava-421386/=
bin/lava-test-runner /lava-421386/1
    2024-01-24T03:14:39.390368  =

    2024-01-24T03:14:39.434295  / # /lava-421386/bin/lava-test-runner /lava=
-421386/1
    2024-01-24T03:14:39.457354  + export 'TESTRUN_ID=3D1_bootrr'
    2024-01-24T03:14:39.498246  + cd /lava-421386/1/tests/1_bootrr =

    ... (14 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/65b080ac5416376bda52a444
        new failure (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4)

    2024-01-24T03:14:41.708652  /lava-421386/1/../bin/lava-test-case
    2024-01-24T03:14:41.735383  <8>[   26.133685] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/65=
b080ac5416376bda52a446
        new failure (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4)

    2024-01-24T03:14:42.795839  /lava-421386/1/../bin/lava-test-case
    2024-01-24T03:14:42.823349  <8>[   27.221442] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65b080ac5416376bda52a44b
        new failure (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4)

    2024-01-24T03:14:44.054377  /lava-421386/1/../bin/lava-test-case
    2024-01-24T03:14:44.082528  <8>[   28.480052] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/65b080ac5416376bda52a44c
        new failure (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4)

    2024-01-24T03:14:45.104518  /lava-421386/1/../bin/lava-test-case
    2024-01-24T03:14:45.132587  <8>[   29.530264] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab           | compiler | defconfig | reg=
ressions
-----------------------+-------+---------------+----------+-----------+----=
--------
kontron-sl28-var3-ads2 | arm64 | lab-kontron   | gcc-10   | defconfig | 2  =
        =


  Details:     https://kernelci.org/test/plan/id/65b080ae228d320cfc52a3f1

  Results:     101 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc1-9-g3d5bdaa=
27c031/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc1-9-g3d5bdaa=
27c031/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65b080ae228d320cfc52a3f8
        new failure (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4)

    2024-01-24T03:14:33.767688  / # #
    2024-01-24T03:14:33.869890  export SHELL=3D/bin/sh
    2024-01-24T03:14:33.870705  #
    2024-01-24T03:14:33.972110  / # export SHELL=3D/bin/sh. /lava-421390/en=
vironment
    2024-01-24T03:14:33.972871  =

    2024-01-24T03:14:34.074264  / # . /lava-421390/environment/lava-421390/=
bin/lava-test-runner /lava-421390/1
    2024-01-24T03:14:34.075540  =

    2024-01-24T03:14:34.094688  / # /lava-421390/bin/lava-test-runner /lava=
-421390/1
    2024-01-24T03:14:34.182639  + export 'TESTRUN_ID=3D1_bootrr'
    2024-01-24T03:14:34.183075  + cd /lava-421390/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65b080ae228d320cfc52a40b
        new failure (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4)

    2024-01-24T03:14:37.108282  /lava-421390/1/../bin/lava-test-case
    2024-01-24T03:14:37.136439  <8>[   27.125218] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab           | compiler | defconfig | reg=
ressions
-----------------------+-------+---------------+----------+-----------+----=
--------
rk3399-rock-pi-4b      | arm64 | lab-collabora | gcc-10   | defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/65b081a57607c6cfa052a426

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc1-9-g3d5bdaa=
27c031/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc1-9-g3d5bdaa=
27c031/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65b081a57607c6cfa052a=
427
        new failure (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4) =

 =20

