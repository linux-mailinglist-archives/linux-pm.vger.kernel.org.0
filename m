Return-Path: <linux-pm+bounces-3406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4760F84A042
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 18:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F2A2867EE
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 17:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC4A3F8F9;
	Mon,  5 Feb 2024 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ul2v+Ntn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0316C44C78
	for <linux-pm@vger.kernel.org>; Mon,  5 Feb 2024 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153005; cv=none; b=CrB2GB9Ucpauq8wO2ApSx9QkE831XrJUTWy09eouGOrNC6PwnE2G95htjFiOJt2JgfTN0eWG9TeEpdOfNwALf8zjLn1+cKwVJBRUh56g6QtaPdpSfSm/x2RGoaTjp547Mu6VjE5D4IkOFM8EoCv6gyWbMQn7Qw8rNxNgaBsqWYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153005; c=relaxed/simple;
	bh=UujitDgYuJqBST5DP62mleSfVV0DjAp8Ee6zQvQEUA0=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=ae1/h97eMRNszSZNjTg/QzCdMnRjRBv78NttKqjWGtvertu3jfgzWBe07I9Se43eqKIr51AlNnH9OvlLIhkNh40ImKkgUXRI6nfYolc1DoS7JkOakSb2wcGUsdZObq80fn9pxIRibv+blL+lj3qo6ytQJLord+BiXs+5V7YTIFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ul2v+Ntn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d94323d547so37058045ad.3
        for <linux-pm@vger.kernel.org>; Mon, 05 Feb 2024 09:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707153003; x=1707757803; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lOTJ4rUBNPuPQryTwmo7vFTvSsDM8d0AWoAJzV4G3Ec=;
        b=ul2v+Ntnm5MxAaxKCdJBPhY7gmbQly2LS2EP/LE3xXDRI84KNxG06ONUHp0KtRrq99
         NMLw8WyqjF0g8KWyMcaOUCv/hFXeb/SYXC0ztmS7G7tABHLy369Uc+OshjgOC+9sbpPI
         VWZDRyYVXj3ENu0Z1lvGY5rQxYBMtC//rad4/OEOz9adMMBMbcLE8enzB8q8kyiCVLHV
         YLYZDUt5XmZvkDQNxr45D96QVDzHoM57Ib27zYLtD7Cbl5e9utNHK3uE0+mSO24yRGoY
         j2Bl/O0AGfAv7x8RDc6YnVnr9skfocgIOzS4ARBaLZuQYtqY5B7OGOYi5e3xOGyj3VIW
         +7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707153003; x=1707757803;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOTJ4rUBNPuPQryTwmo7vFTvSsDM8d0AWoAJzV4G3Ec=;
        b=bEb9ntWm/Vr4rdSZpnb5pF/cIjXFcZ7hfwpfz3/j2NNt2x0HNXjMom4netPdj0tHfb
         1RLGW9Db1o/ZKzzB+Al2D0xwyMOsI/6UtTOWP/5RLuFMigSXzdCmy22ozGw6sHIaTflb
         lxh0VQMIuhwqc4S5k4Oqs2ykHt8LLTzOqNJLA31KgPiOHTQVpsbKDDLcLwhSkrwH6T4s
         8kco4G5EXGzKj6aUnYXsDcU5xy9iXMcXixzqqJedEzjx4PkOHcXfEXLRMFz3wmCAVW3l
         +IJ/3/FpcfYw+9NB5O4LhtJ9MUigLJ3L7029yfpSelAdOMB/CM/DqTtzqxOYV4ZAWYyo
         CI+w==
X-Gm-Message-State: AOJu0YyOd3YNZPbuD8gYZHPAnJCukxQ+vknHosLY0HBK7TB9lfJLrWRW
	yOhqYHzvzTzVYqZU0nqSEA2xaqCJ6fPMtQ4N/nxLXshS7lAf8kJ1C3PWOdDoNKmiZF+3Ps4y6ks
	q
X-Google-Smtp-Source: AGHT+IEo9Sve4gXQiivUF4ZBTJ8b3PduSRmY9eK/okYEoZDJz1o7NdgITJLSYFLiEt2RD47ZFPtUFA==
X-Received: by 2002:a17:90a:6c25:b0:296:20ed:f71a with SMTP id x34-20020a17090a6c2500b0029620edf71amr37044pjj.21.1707153003139;
        Mon, 05 Feb 2024 09:10:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUxJXtWXiQJ303KFPBbV3Qq1vSUDqlQx8O2joVq7Q6G++zDX+03aEqCLczZOOj1kQJgUBLGBcQoauwPHiKwNsEOPWf1ADt2TdidqYPui/pkjHhonBUFGM58awjhmCp/Izny7JfQ3EvFVV+37XXD8XehKlBHcOfmh6p2WEvFoEt1yS6ugQZUBy/TES3i
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id oh7-20020a17090b3a4700b002961d809272sm222846pjb.14.2024.02.05.09.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:10:02 -0800 (PST)
Message-ID: <65c1166a.170a0220.b5a71.1aa3@mx.google.com>
Date: Mon, 05 Feb 2024 09:10:02 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc3-31-g7cfffced6d0e
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 48 runs,
 8 regressions (v6.8-rc3-31-g7cfffced6d0e)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 48 runs, 8 regressions (v6.8-rc3-31-g7cfffced6d0e)

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

rk3399-roc-pc          | arm64 | lab-broonie | gcc-10   | defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.8-rc3=
-31-g7cfffced6d0e/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.8-rc3-31-g7cfffced6d0e
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      7cfffced6d0e76fdc265b75f28903142b3b0ecc9 =



Test Regressions
---------------- =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-kbox-a-230-ls  | arm64 | lab-kontron | gcc-10   | defconfig | 5    =
      =


  Details:     https://kernelci.org/test/plan/id/65c10c5091da9639c100a039

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc3-31-g7cfffc=
ed6d0e/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc3-31-g7cfffc=
ed6d0e/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c10c5091da9639c100a040
        failing since 12 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-05T16:26:31.778524  / # #
    2024-02-05T16:26:31.880619  export SHELL=3D/bin/sh
    2024-02-05T16:26:31.881317  #
    2024-02-05T16:26:31.982838  / # export SHELL=3D/bin/sh. /lava-426191/en=
vironment
    2024-02-05T16:26:31.983544  =

    2024-02-05T16:26:32.085036  / # . /lava-426191/environment/lava-426191/=
bin/lava-test-runner /lava-426191/1
    2024-02-05T16:26:32.086273  =

    2024-02-05T16:26:32.105662  / # /lava-426191/bin/lava-test-runner /lava=
-426191/1
    2024-02-05T16:26:32.193574  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-05T16:26:32.194036  + cd /lava-426191/1/tests/1_bootrr =

    ... (14 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/65c10c5091da9639c100a044
        failing since 12 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-05T16:26:34.405984  /lava-426191/1/../bin/lava-test-case
    2024-02-05T16:26:34.434121  <8>[   26.183982] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/65=
c10c5091da9639c100a046
        failing since 12 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-05T16:26:35.493413  /lava-426191/1/../bin/lava-test-case
    2024-02-05T16:26:35.521984  <8>[   27.272392] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65c10c5091da9639c100a04b
        failing since 12 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-05T16:26:36.753773  /lava-426191/1/../bin/lava-test-case
    2024-02-05T16:26:36.782939  <8>[   28.532186] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/65c10c5091da9639c100a04c
        failing since 12 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-05T16:26:37.804546  /lava-426191/1/../bin/lava-test-case
    2024-02-05T16:26:37.833658  <8>[   29.582598] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-sl28-var3-ads2 | arm64 | lab-kontron | gcc-10   | defconfig | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/65c10c3ee18bc8004c00a043

  Results:     101 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc3-31-g7cfffc=
ed6d0e/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc3-31-g7cfffc=
ed6d0e/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c10c3ee18bc8004c00a04a
        failing since 12 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-05T16:26:15.255518  / # #
    2024-02-05T16:26:15.357433  export SHELL=3D/bin/sh
    2024-02-05T16:26:15.358193  #
    2024-02-05T16:26:15.459595  / # export SHELL=3D/bin/sh. /lava-426193/en=
vironment
    2024-02-05T16:26:15.460316  =

    2024-02-05T16:26:15.561753  / # . /lava-426193/environment/lava-426193/=
bin/lava-test-runner /lava-426193/1
    2024-02-05T16:26:15.563078  =

    2024-02-05T16:26:15.582782  / # /lava-426193/bin/lava-test-runner /lava=
-426193/1
    2024-02-05T16:26:15.670731  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-05T16:26:15.671158  + cd /lava-426193/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65c10c3ee18bc8004c00a05d
        failing since 12 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-05T16:26:18.602602  /lava-426193/1/../bin/lava-test-case
    2024-02-05T16:26:18.630343  <8>[   27.148962] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
rk3399-roc-pc          | arm64 | lab-broonie | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/65c10e0cc6f984825e00a039

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc3-31-g7cfffc=
ed6d0e/arm64/defconfig/gcc-10/lab-broonie/baseline-rk3399-roc-pc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc3-31-g7cfffc=
ed6d0e/arm64/defconfig/gcc-10/lab-broonie/baseline-rk3399-roc-pc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c10e0cc6f984825e00a=
03a
        new failure (last pass: v6.8-rc2-29-gc24c55a0329d1) =

 =20

