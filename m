Return-Path: <linux-pm+bounces-4671-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8984871525
	for <lists+linux-pm@lfdr.de>; Tue,  5 Mar 2024 06:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B071F233DA
	for <lists+linux-pm@lfdr.de>; Tue,  5 Mar 2024 05:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55FF44C77;
	Tue,  5 Mar 2024 05:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="WFSRQuJK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32731F60A
	for <linux-pm@vger.kernel.org>; Tue,  5 Mar 2024 05:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709615288; cv=none; b=WYuFeuLmZve7XyMrIvrK/PUAtSVWUUrIqjFHit8xtyMZtV/4S2nR+ULfduhbQ5S6bdpqoreYFCVYEZRhBS9jFl3nuA288lUzroFeBwtfTPh01V8Ljh45ZrE0+U4fCrft7h0KXfM00NyAJHsmI3YrBUOCS2gdgHaKS51e6C8nODE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709615288; c=relaxed/simple;
	bh=U42aJrRf+V+B4/noLr0FjlbaekdOKpWeF6tfCHj4yvc=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=dovIZLBHM7W0pAEXIh6pw41XWLN+kGExMjJI6qhWQFmJjXaJgxYMv0v4t9HHWEBz1brc9zZPh3FU+CcijaWkZIIdcSabLUvPgVEBzCxfJbRt9Tlkp+bigi70Z+e6mg4ExlkvYr4s6p90wUhg8ZO73EQo5UpHwdnB8wOs6QST7YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=WFSRQuJK; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c1ea425a0fso1079832b6e.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Mar 2024 21:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709615286; x=1710220086; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a23bikeIy9nfY4pkRhr2gbFTUN7GP3RNj8UazfRIHh0=;
        b=WFSRQuJKix2TmmlMWbVWb1aI1YAIbmUGJhtEhzbv9PYmtr15l5sLDMuz1DtyHLacBH
         b+JOK5/Tn+ANY/MrHYyhadewfKXKoiOevT9D10cSc9JiDPzztheieSdhyr77LUHUb+lH
         7JKTMHeDVHg60iX3qbiek4/SjTLKhzTTfHbCnXR7BD+5NISDx8vND1iyldzpgTN0cU4i
         v0ruA2pzeCR/njncelRTug2FSG22bJQs9eVxfcJR7xRjve6z6qjlchwFtTyshqcJ5YCG
         DoDgMtTT8Q1FDv+Ffall7JEvvm7LrN5yLbgg7Vs3+D28wQXaHzQgYcDmdh4grkf6zQiU
         VJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709615286; x=1710220086;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a23bikeIy9nfY4pkRhr2gbFTUN7GP3RNj8UazfRIHh0=;
        b=wc81kv4zG1rhkw/fCobP+xVeD3pxkZSsYK0xfcar0Ji6oy6Luf3O+rIoOJGAdJVFwG
         iMUt7uT2VifS/e6l1O+N7MNHqqlcGfFs7IOUs5Ik2L+PeAXrlMB3ChL29Ogl19a84VnD
         Q6Yba/47UklXXfN6oZaDsfLOoAZSe7cxdgPaK7vYZg0P6Pznwik9eNVDa2UhM08hfhFX
         olUfLiRZt5Glmh9XKi/xkNwM9tfgtrxEscUQ0l0H/leZjPhFt+hNxdP8KixIAFEf0RlD
         UtzdY/MN05ZL74OwCD+wLNJ/iwE0ut+yCx3iXOB4MG//Mar9F6fCBXCTdClTcdRrz6fQ
         cMYg==
X-Forwarded-Encrypted: i=1; AJvYcCXxFjE+N2rMqYf+Q5frOamJEJCWwvddPB7pARMjJ/z+tNIpJCK0fj7Qc4aOZGTtd1Y8DQGAeM47651SX0bFQISZr8LNOjiMHNU=
X-Gm-Message-State: AOJu0YykTCLD5Cpx1/5x7XKN987vD1CuT7Shz++7DZPBi3G1vdHuLyus
	j1/M7SbnguKE6pwQV1WIpxUVn2ATZbjiWPs3c6On6znNHtMCyY/l1CMK96Mt3U8=
X-Google-Smtp-Source: AGHT+IH6NuSWgIYtJk7ktjFf+6ZhADWUv0wM+I5H1ZQ1RGnlGlG+iyQHhynR+lLM/vxz4gRGQ+wdXQ==
X-Received: by 2002:a05:6808:4da:b0:3c1:5c93:7e55 with SMTP id a26-20020a05680804da00b003c15c937e55mr754742oie.19.1709615285827;
        Mon, 04 Mar 2024 21:08:05 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f7-20020a056a00238700b006e5bd2fa867sm6229062pfc.46.2024.03.04.21.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 21:08:05 -0800 (PST)
Message-ID: <65e6a8b5.050a0220.1ed3a.7348@mx.google.com>
Date: Mon, 04 Mar 2024 21:08:05 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc7-146-gd720e67268b7
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 46 runs,
 7 regressions (v6.8-rc7-146-gd720e67268b7)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 46 runs, 7 regressions (v6.8-rc7-146-gd720e67268b7)

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


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.8-rc7=
-146-gd720e67268b7/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.8-rc7-146-gd720e67268b7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d720e67268b76a4e663ac8df7c6e9c397d0cdc6a =



Test Regressions
---------------- =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-kbox-a-230-ls  | arm64 | lab-kontron | gcc-10   | defconfig | 5    =
      =


  Details:     https://kernelci.org/test/plan/id/65e69e77ed04f27eed4c431c

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc7-146-gd720e=
67268b7/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc7-146-gd720e=
67268b7/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e69e77ed04f27eed4c4323
        failing since 41 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-05T04:23:56.611626  + <8>[   20.227980] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 438719_1.5.2.4.1>
    2024-03-05T04:23:56.611938  set +x
    2024-03-05T04:23:56.717118  / # #
    2024-03-05T04:23:56.819435  export SHELL=3D/bin/sh
    2024-03-05T04:23:56.820151  #
    2024-03-05T04:23:56.921533  / # export SHELL=3D/bin/sh. /lava-438719/en=
vironment
    2024-03-05T04:23:56.922281  =

    2024-03-05T04:23:57.023607  / # . /lava-438719/environment/lava-438719/=
bin/lava-test-runner /lava-438719/1
    2024-03-05T04:23:57.024743  =

    2024-03-05T04:23:57.043329  / # /lava-438719/bin/lava-test-runner /lava=
-438719/1 =

    ... (17 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/65e69e77ed04f27eed4c4327
        failing since 41 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-05T04:23:59.194550  /lava-438719/1/../bin/lava-test-case
    2024-03-05T04:23:59.194975  <8>[   22.798391] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>
    2024-03-05T04:23:59.195273  /lava-438719/1/../bin/lava-test-case   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/65=
e69e77ed04f27eed4c4329
        failing since 41 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-05T04:24:00.253219  /lava-438719/1/../bin/lava-test-case
    2024-03-05T04:24:00.253715  <8>[   23.837062] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2024-03-05T04:24:00.254044  /lava-438719/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65e69e77ed04f27eed4c432e
        failing since 41 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-05T04:24:01.327648  /lava-438719/1/../bin/lava-test-case   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/65e69e77ed04f27eed4c432f
        failing since 41 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-05T04:24:01.330810  <8>[   24.948661] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2024-03-05T04:24:02.388489  /lava-438719/1/../bin/lava-test-case
    2024-03-05T04:24:02.388956  <8>[   25.969957] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>
    2024-03-05T04:24:02.389249  /lava-438719/1/../bin/lava-test-case   =

 =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-sl28-var3-ads2 | arm64 | lab-kontron | gcc-10   | defconfig | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/65e69e7642b92a12e74c4310

  Results:     101 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc7-146-gd720e=
67268b7/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc7-146-gd720e=
67268b7/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e69e7642b92a12e74c4317
        failing since 41 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-05T04:23:58.245485  / # #
    2024-03-05T04:23:58.347237  export SHELL=3D/bin/sh
    2024-03-05T04:23:58.347524  #
    2024-03-05T04:23:58.448139  / # export SHELL=3D/bin/sh. /lava-438717/en=
vironment
    2024-03-05T04:23:58.448444  =

    2024-03-05T04:23:58.549387  / # . /lava-438717/environment/lava-438717/=
bin/lava-test-runner /lava-438717/1
    2024-03-05T04:23:58.550624  =

    2024-03-05T04:23:58.557690  / # /lava-438717/bin/lava-test-runner /lava=
-438717/1
    2024-03-05T04:23:58.623627  + export 'TESTRUN_ID=3D1_bootrr'
    2024-03-05T04:23:58.624069  + <8>[   20.991632] <LAVA_SIGNAL_STARTRUN 1=
_bootrr 438717_1.5.2.4.5> =

    ... (11 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65e69e7642b92a12e74c432a
        failing since 41 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-03-05T04:24:01.053324  /lava-438717/1/../bin/lava-test-case
    2024-03-05T04:24:01.053735  <8>[   23.414013] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>
    2024-03-05T04:24:01.054078  /lava-438717/1/../bin/lava-test-case   =

 =20

