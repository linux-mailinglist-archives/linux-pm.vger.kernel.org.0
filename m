Return-Path: <linux-pm+bounces-3111-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2A48446F6
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 19:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4842911D7
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 18:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C52F12FF8F;
	Wed, 31 Jan 2024 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="O4jXDrjK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA9E12CDB8
	for <linux-pm@vger.kernel.org>; Wed, 31 Jan 2024 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725030; cv=none; b=NtnDeOe17aRRis8POF+0AoqiRgvgbdtOgYFPvyvIWFSkBz759B+TK6e5ITYK/zf6ljf6/YDO5e7D0xn+u4cL6K/ZK5OJV/fCQ7r+1jgxMMPCm/lJqLhIQhurKxsnE44epyICk8jvtLiFCnX0BVJsjrCeg0GwOyzxEbowVBxLN0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725030; c=relaxed/simple;
	bh=z4bITG/vuy7xAzV/BbZWOV6N3SBgX5/7Ct45bJRLZUA=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=gQ5ASTiNJyFrF3Q09u2Vl/F5KVkvrBEG1x7a9iMmPNttIF4+07VztMt1sbPhjENbM44+cEu0kikuVfBpLCyKO6LrABiSJ5zkXYvYFtHvwoFS8we/yc8hZ/M8YlwJ9+UWKl38ksA+SEdfcrTX0nfo8/1jxmjMLYBW3GIY1uEyNBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=O4jXDrjK; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so59090a12.1
        for <linux-pm@vger.kernel.org>; Wed, 31 Jan 2024 10:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706725028; x=1707329828; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QpX3ERye6CYDqnKOpMC5tFgt9430XBUa1oMXgrBBD0I=;
        b=O4jXDrjKe+D33CuVsTKjC4QXi1Z5X0ooqCOI3gsgUhNDzhv/ZtiLZCSTEytCmeajTO
         +1drBI6BULG14WgypE+cYCRuRU4o0nXjBI3FV34OaFCZZ/Br1iAeZqn+1ZbdEMgVJPId
         DYfatw4JBof8+qTodUxl4Ywc4qUuS5vnxyxUz8pifaaA7hK6H9B7tk1ajIWthGqYVUc3
         y2ZA8WHRvB3RuuX039oKUh3PchcZmhOnKlUrEWIgyvYDmUqd43mL9YFGFhNyMOLxa7OB
         QMlCLaIvG8UItIpt8OARurXR0QZEwIkTmZs3fPvDNGZqECNIDUAO49vMs+H7r0t39sPl
         5B6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706725028; x=1707329828;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QpX3ERye6CYDqnKOpMC5tFgt9430XBUa1oMXgrBBD0I=;
        b=LrpeYo9EBLzN97WvP6llS0jYLRTpCwJ4uiIr2vHUXIzF5B+LjtuE+nVPPZOYYYOtYW
         tYOqHpxDhdHndCatvVD8P+6VlHUSBKH3lcfVrJsG9I31fJ3l+61Cgu1/gcLLQwiaFjuD
         /N6dai0eQjALxEQ6L5ZhVCYnd66/jFSCmyy15rmJUe5JFiC9EHfgmaXNGSIS9lSy64bx
         PtYmrZJpGIWrct+k4QIzZNT54tTZV5tH+y5uYnH5MWdA2uRNgUOUiA/S2Y9MS80a5iU5
         qtXbtLuL3c3naj/MeEAa6jDqJKypfghWUgpi6wtqYNhqa55gcFcErLynV1hQJCCD57TY
         +7AQ==
X-Gm-Message-State: AOJu0YwW5ks5dKh+gVVV7Gh3ERN5o/ZEUFtprumyupVqvZfGJsa6AlmZ
	sy5/S5Oj9LhiZZPSHdwz6tG7BlSaCxQOeacFo2BTKuA7l+5Q6DvrMWU1trSy8SNITdC87PuoVAs
	Y
X-Google-Smtp-Source: AGHT+IGNat9cHqnRzkur6DvsDOclcWlplsxYs/fkJCFwAgS3qx7/CkzCdyezUy0bc0eUiRdhsG62kQ==
X-Received: by 2002:a17:90b:e8a:b0:293:f625:1b0b with SMTP id fv10-20020a17090b0e8a00b00293f6251b0bmr2326301pjb.5.1706725027927;
        Wed, 31 Jan 2024 10:17:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWeozersCXTrvFbQl19mtDhs08KP/ZY8Z0DcIexrcfg0XSsL9lHICtrI8nFiCLp/kRbWolNDEvKBtaWDV00r1UMdjDOQAgUp56DI1U6ZcGdTMmuzK5d+3AccBve8iq+63NvCy7MECRLx+Cv4tTjtRYVWoNjadzfkVtz4f2DnjMIqISpWo2K9BnqoNpW
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id so10-20020a17090b1f8a00b00290701c8623sm1755591pjb.28.2024.01.31.10.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 10:17:07 -0800 (PST)
Message-ID: <65ba8ea3.170a0220.f03c1.5cd7@mx.google.com>
Date: Wed, 31 Jan 2024 10:17:07 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc2-7-g7543bfcb6b1a
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 50 runs, 7 regressions (v6.8-rc2-7-g7543bfcb6b1a)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 50 runs, 7 regressions (v6.8-rc2-7-g7543bfcb6b1a)

Regressions Summary
-------------------

platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-kbox-a-230-ls  | arm64 | lab-kontron | gcc-10   | defconfig | 5    =
      =

kontron-sl28-var3-ads2 | arm64 | lab-kontron | gcc-10   | defconfig | 2    =
      =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.8-rc2=
-7-g7543bfcb6b1a/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.8-rc2-7-g7543bfcb6b1a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      7543bfcb6b1a6cecb3e1df9a1bf864d916e8b40b =



Test Regressions
---------------- =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-kbox-a-230-ls  | arm64 | lab-kontron | gcc-10   | defconfig | 5    =
      =


  Details:     https://kernelci.org/test/plan/id/65ba847ce39c79018300a04b

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc2-7-g7543bfc=
b6b1a/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc2-7-g7543bfc=
b6b1a/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65ba847ce39c79018300a052
        failing since 7 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4=
, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-01-31T17:33:23.406244  / # #
    2024-01-31T17:33:23.508190  export SHELL=3D/bin/sh
    2024-01-31T17:33:23.508932  #
    2024-01-31T17:33:23.610465  / # export SHELL=3D/bin/sh. /lava-424636/en=
vironment
    2024-01-31T17:33:23.610947  =

    2024-01-31T17:33:23.712245  / # . /lava-424636/environment/lava-424636/=
bin/lava-test-runner /lava-424636/1
    2024-01-31T17:33:23.713455  =

    2024-01-31T17:33:23.758231  / # /lava-424636/bin/lava-test-runner /lava=
-424636/1
    2024-01-31T17:33:23.782706  + export 'TESTRUN_ID=3D1_bootrr'
    2024-01-31T17:33:23.816688  + cd /lava-424636/1/tests/1_bootrr =

    ... (14 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/65ba847ce39c79018300a056
        failing since 7 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4=
, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-01-31T17:33:26.032827  /lava-424636/1/../bin/lava-test-case
    2024-01-31T17:33:26.059690  <8>[   26.317383] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/65=
ba847ce39c79018300a058
        failing since 7 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4=
, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-01-31T17:33:27.121341  /lava-424636/1/../bin/lava-test-case
    2024-01-31T17:33:27.147845  <8>[   27.405531] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65ba847ce39c79018300a05d
        failing since 7 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4=
, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-01-31T17:33:28.380688  /lava-424636/1/../bin/lava-test-case
    2024-01-31T17:33:28.407807  <8>[   28.665167] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/65ba847ce39c79018300a05e
        failing since 7 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4=
, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-01-31T17:33:29.431189  /lava-424636/1/../bin/lava-test-case
    2024-01-31T17:33:29.458323  <8>[   29.715652] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-sl28-var3-ads2 | arm64 | lab-kontron | gcc-10   | defconfig | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/65ba8468f298ef56bf00a047

  Results:     101 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc2-7-g7543bfc=
b6b1a/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc2-7-g7543bfc=
b6b1a/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65ba8468f298ef56bf00a04e
        failing since 7 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4=
, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-01-31T17:33:14.766213  / # #
    2024-01-31T17:33:14.868030  export SHELL=3D/bin/sh
    2024-01-31T17:33:14.868400  #
    2024-01-31T17:33:14.969130  / # export SHELL=3D/bin/sh. /lava-424633/en=
vironment
    2024-01-31T17:33:14.969492  =

    2024-01-31T17:33:15.070321  / # . /lava-424633/environment/lava-424633/=
bin/lava-test-runner /lava-424633/1
    2024-01-31T17:33:15.071512  =

    2024-01-31T17:33:15.078508  / # /lava-424633/bin/lava-test-runner /lava=
-424633/1
    2024-01-31T17:33:15.142135  + export 'TESTRUN_ID=3D1_bootrr'
    2024-01-31T17:33:15.176385  + cd /lava-424633/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65ba8468f298ef56bf00a061
        failing since 7 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e4=
, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-01-31T17:33:18.104952  /lava-424633/1/../bin/lava-test-case
    2024-01-31T17:33:18.132924  <8>[   27.210095] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =

 =20

