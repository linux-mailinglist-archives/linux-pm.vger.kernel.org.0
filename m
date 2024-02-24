Return-Path: <linux-pm+bounces-4372-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B558625E5
	for <lists+linux-pm@lfdr.de>; Sat, 24 Feb 2024 17:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6F928217E
	for <lists+linux-pm@lfdr.de>; Sat, 24 Feb 2024 16:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE4547A40;
	Sat, 24 Feb 2024 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="dlLJScGN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC854642A
	for <linux-pm@vger.kernel.org>; Sat, 24 Feb 2024 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708790508; cv=none; b=WuDdc4aDml6mOCkEk4e2wRqL3MfCPge8dO0J3ZZR1s3fajRB2DyhWKCbfGtFSyP+0qvuUJs5OxirZi604i1vgM676jz8slIcCGS61GjbxbT3UYlqnETEE+yCmieblSAQI1umCQtxsHPRsyq0aP+h2IZ5UVfEbCS/lqYJ1pvriEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708790508; c=relaxed/simple;
	bh=epXIMQ3XjwyKOoB7fiYCvznsxaDX2d6H4sdGqVmwlWQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=lJRlb6R57puRAaZwdTjqQcUHONBCME4dbowQGPh2jJigQE01ZsmFonCiD6MVMpcP3srWf4ixPWlBFVDedc54iwaZ/wu4AH5eSq8ZW7L+odGAtabccSRXQidyHIkEugYizinoOYAbFPJNN0v23B69TkYkvJ7gZukmoQ/TTAeWUs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=dlLJScGN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dba94f9201so11346795ad.0
        for <linux-pm@vger.kernel.org>; Sat, 24 Feb 2024 08:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708790506; x=1709395306; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+k5pTXtVkP49PIoxU4IpMS6FpZkpKNKMNJ5g671Ly2w=;
        b=dlLJScGNEfNZO0bhe56WLjFNmQrMy18LKeXsrG5c4EBF15appGmNmuvxuBeWapISwJ
         APmVD1VukRNOLZiXkSlxDHtu8LS5OcwiwOQtiJReUDJTDuEr1N2YomxpA6fj0/FjcYKm
         SF2dJdjKqRn1Xpwc+dAiF4mej2csbu41TJmbB+p1YMOJxq6WXHtpQSGxq03ZWFwJR44Q
         524gc76J4rDgHGbFFF26Dz+qYZLfd9/jeGTUvQNO7nqnHGQYOLsx4vl7dllPI4XOFqzd
         P28OO1DF+Qg0ssrsHlYo8xRUgxEeq7w3DJ6LPqYPxbhM477U9r5GyIuYa32S/Y+4eTXA
         dTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708790506; x=1709395306;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+k5pTXtVkP49PIoxU4IpMS6FpZkpKNKMNJ5g671Ly2w=;
        b=rYMZdSSBxp6TlIyBCSOgI97SkoDm6twda9oP4s3++L4BIJz0b1AEo8cBM8oVscpd0R
         ZIiAx1BPa9l6zAf3eOp5HuS4lPlGt2sid1ttmIZ3YrYb7xjQOtU1HPly2j14760aNoHp
         fX7CbHkSDL7Cf79l6pB7g+ZATQPRJkeU7nFe+8uee2gMR2+9cVKlCfATHjFLtRVOYYkG
         jGgdTFii7lgljxUuxaIrXvLuO44RDqeyMJ2rC2rLpxu/VsSAturASG42afHKM+JBVzgI
         qRdn5CyBICkFQ/sR8ubacrppSyresJKLlgBStpHL9IftGxHrfv3i7Z1t7X8q2rJUNi+q
         yusQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBQuLQih8NenicUqNIc6ZeK2g3lRsC1P9gd+nj9YQlCgAzcRMi3IjjkvaUDtfDdjsFi1/kzdtcu0jTKq1ln304X6jzxF3oaos=
X-Gm-Message-State: AOJu0YztZWSwTKR92jQMvqmXWQyPSLmtr+QppItQhPbfiKUdHYAkOmgN
	mnI2tOa1IJ3OvaJvXIK+K7xFKVlwDZsmII2Fi/f1hhHe2sOj756Gccvwbfzzu1KqDQK3EMOLC5I
	h
X-Google-Smtp-Source: AGHT+IFRwR80RRFsoCAn1u78C9iCMy3xoB2UH/HgMIBQiZEN4Gu3ZyXczh4zM1BS9fWco9Gfd0FvCA==
X-Received: by 2002:a17:903:2784:b0:1db:d184:c45a with SMTP id jw4-20020a170903278400b001dbd184c45amr2604145plb.67.1708790506200;
        Sat, 24 Feb 2024 08:01:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b001d5f1005096sm1172108plj.55.2024.02.24.08.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 08:01:45 -0800 (PST)
Message-ID: <65da12e9.170a0220.62874.2a2d@mx.google.com>
Date: Sat, 24 Feb 2024 08:01:45 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc5-120-gb9dcbdb099e4c
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 31 runs,
 9 regressions (v6.8-rc5-120-gb9dcbdb099e4c)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 31 runs, 9 regressions (v6.8-rc5-120-gb9dcbdb099e4c)

Regressions Summary
-------------------

platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =

kontron-kbox-a-230-ls    | arm64 | lab-kontron     | gcc-10   | defconfig |=
 5          =

kontron-sl28-var3-ads2   | arm64 | lab-kontron     | gcc-10   | defconfig |=
 2          =

rk3399-roc-pc            | arm64 | lab-broonie     | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.8-rc5=
-120-gb9dcbdb099e4c/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.8-rc5-120-gb9dcbdb099e4c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      b9dcbdb099e4c025188fd3f9c31ebd5fc6784049 =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/65da01847e0252676463701f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc5-120-gb9dcb=
db099e4c/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb=
15-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc5-120-gb9dcb=
db099e4c/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb=
15-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65da01847e02526764637=
020
        failing since 0 day (last pass: v6.8-rc5-92-g4cb5c331c4dfd, first f=
ail: v6.8-rc5-119-gbc3fe166fc9a9) =

 =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
kontron-kbox-a-230-ls    | arm64 | lab-kontron     | gcc-10   | defconfig |=
 5          =


  Details:     https://kernelci.org/test/plan/id/65da016ef0d089007a63703f

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc5-120-gb9dcb=
db099e4c/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc5-120-gb9dcb=
db099e4c/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65da016ef0d089007a637046
        failing since 31 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-24T14:46:46.811323  / #
    2024-02-24T14:46:46.913897  # #export SHELL=3D/bin/sh
    2024-02-24T14:46:46.914660  =

    2024-02-24T14:46:47.016178  / # export SHELL=3D/bin/sh. /lava-434529/en=
vironment
    2024-02-24T14:46:47.016925  =

    2024-02-24T14:46:47.118129  / # . /lava-434529/environment/lava-434529/=
bin/lava-test-runner /lava-434529/1
    2024-02-24T14:46:47.119262  =

    2024-02-24T14:46:47.137670  / # /lava-434529/bin/lava-test-runner /lava=
-434529/1
    2024-02-24T14:46:47.181480  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-24T14:46:47.181835  + <8>[   20.730255] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 434529_1.5.2.4.5> =

    ... (14 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/65da016ef0d089007a63704a
        failing since 31 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-24T14:46:49.289728  /lava-434529/1/../bin/lava-test-case
    2024-02-24T14:46:49.290192  <8>[   22.838772] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>
    2024-02-24T14:46:49.290491  /lava-434529/1/../bin/lava-test-case   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/65=
da016ef0d089007a63704c
        failing since 31 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-24T14:46:50.349595  /lava-434529/1/../bin/lava-test-case
    2024-02-24T14:46:50.350052  <8>[   23.877280] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65da016ef0d089007a637051
        failing since 31 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-24T14:46:51.425245  /lava-434529/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/65da016ef0d089007a637052
        failing since 31 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-24T14:46:51.428421  <8>[   24.992561] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2024-02-24T14:46:52.482414  /lava-434529/1/../bin/lava-test-case   =

 =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
kontron-sl28-var3-ads2   | arm64 | lab-kontron     | gcc-10   | defconfig |=
 2          =


  Details:     https://kernelci.org/test/plan/id/65da015a31219ef9fb637036

  Results:     101 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc5-120-gb9dcb=
db099e4c/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc5-120-gb9dcb=
db099e4c/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65da015a31219ef9fb63703d
        failing since 31 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-24T14:46:33.853333  / # #
    2024-02-24T14:46:33.955381  export SHELL=3D/bin/sh
    2024-02-24T14:46:33.956096  #
    2024-02-24T14:46:34.057622  / # export SHELL=3D/bin/sh. /lava-434532/en=
vironment
    2024-02-24T14:46:34.058399  =

    2024-02-24T14:46:34.159790  / # . /lava-434532/environment/lava-434532/=
bin/lava-test-runner /lava-434532/1
    2024-02-24T14:46:34.160956  =

    2024-02-24T14:46:34.165283  / # /lava-434532/bin/lava-test-runner /lava=
-434532/1
    2024-02-24T14:46:34.233368  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-24T14:46:34.233794  + <8>[   21.062706] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 434532_1.5.2.4.5> =

    ... (13 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65da015a31219ef9fb637050
        failing since 31 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-24T14:46:36.660873  /lava-434532/1/../bin/lava-test-case
    2024-02-24T14:46:36.661322  <8>[   23.477701] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2024-02-24T14:46:36.661620  /lava-434532/1/../bin/lava-test-case   =

 =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
rk3399-roc-pc            | arm64 | lab-broonie     | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/65da0267326691a86c63701c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc5-120-gb9dcb=
db099e4c/arm64/defconfig/gcc-10/lab-broonie/baseline-rk3399-roc-pc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc5-120-gb9dcb=
db099e4c/arm64/defconfig/gcc-10/lab-broonie/baseline-rk3399-roc-pc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65da0267326691a86c637=
01d
        failing since 18 days (last pass: v6.8-rc2-29-gc24c55a0329d1, first=
 fail: v6.8-rc3-31-g7cfffced6d0e) =

 =20

