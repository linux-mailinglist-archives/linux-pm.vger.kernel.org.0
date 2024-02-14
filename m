Return-Path: <linux-pm+bounces-3922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EF08550BA
	for <lists+linux-pm@lfdr.de>; Wed, 14 Feb 2024 18:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0AA1C20A4C
	for <lists+linux-pm@lfdr.de>; Wed, 14 Feb 2024 17:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E46B8662D;
	Wed, 14 Feb 2024 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="gO+7WtYn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A7284A3E
	for <linux-pm@vger.kernel.org>; Wed, 14 Feb 2024 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932932; cv=none; b=qxMw00qRa0x9KtNJKE+iPvbC32sQ9mhPZys87EXLAb+fBxPJPTh28pUWw0afqq8/rzIcTuutz1D4FUpkw71iWe6B2hM44kapJibcuQSpks5DkiRx58EsvJs0+hMrem3I5zuGrG0zuMJ9BMWuOLwJEBNaaVEOOjyucQq2cV4C3SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932932; c=relaxed/simple;
	bh=8VgeSIaE8JFN9y6WY9P9dStBOVHOGG18DTClNWkBEuk=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=fe3G4xyyfdkYIlfdAWiNKWm8MocXnJN0fAhNv2HYibQ64hNnlejtQc18JD+7t81LNFeKtF6x9sNDLxdMjuY+e1NHzQT5Em9QutfVetJvsXOGsYQ9ohGmT96nwOKZ77dUPJf5lUQXKZwPetOZZL6F9L8BW1vqTiIG4TYL2U3nOco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=gO+7WtYn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d932f6ccfaso43200445ad.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Feb 2024 09:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707932930; x=1708537730; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gg2xI7YGVIpB2d0Q82VaF1Fu+Gw8E/g7oGgtdsJmOUA=;
        b=gO+7WtYnI6iCuJSNAILrY6yH/Z9faVkSow3mNZMiCyOd6RKd4IBnrIkAxRu9QPUgr8
         dI4kZO5PM+lDQLSdTYff24RltHkVwIcBiXLr9IN/GZ/BJ4LgDqm0NCI1raptyjYhOhcG
         rnOLdt9Fnfm5C1B0Umyhmxcs59JJ0UB5NFe7MbWC7iQuFu+OiwMvD+8oIpHGAManIlBp
         G6gYNDnQNTAhRvbTqhyDH6rKAoLJ6F4ExGkjUQ4k9KQtR+WdgTR5vYW9auOMwhUoxbUm
         Br2vKzTtXsUlg4ABaN5/8Y027ZnKC7Rd6AZaTHmqEJpLvVWyXudr5RIUhAHuozDHOKjb
         JObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707932930; x=1708537730;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gg2xI7YGVIpB2d0Q82VaF1Fu+Gw8E/g7oGgtdsJmOUA=;
        b=Hhw8TZ+7VnsWUMFDS2RaMvE1Qmiq9pyemjxOE6E9TI3HntoQbE8PHskLug4BZnc+PU
         irhk1D3TCkPdFu8netdaEBdZ/mMjgWPE9ZoVioqwA9yPvaqoH4I89i9mq0jTOMj7JYQP
         20HUkzAKKSoT6UT6JNs/2UiNfVmktxg+wQeh0sMC+es3CPyzlLipjRXfWUK0sWwhq6tI
         nGoA39lJGepfaiRZUiO4Go3zwjWnneOpTEv+aQZa+hUh+Wv/Ko5MccgM59cKW8wDcVe9
         ieMsMlep5NlD1Fyxi69796U7AaYoa0laXcqyJ8GMI/c5TUjCkzU8XhOxD42AtaMPM1KF
         8pBg==
X-Forwarded-Encrypted: i=1; AJvYcCXd+TLgsTDsu3ok1Wn0J86lcjE1cWfaSD1K3QBuvEfnMcEKhnvqajsDUc7r6g6Aa8Se680KrgrTjr3w8Jnf6FAUM7SVdxi4U80=
X-Gm-Message-State: AOJu0YxrYsMg4cAGwUBe/nwRGwPyADOHcoiPJJ+LzNh7/42XXFtvGGv8
	4e3+zdzpDLSEzJjDiRh79M+7pPq21ak7MXHL3JmNbQsHrKV8vJ6D5LCsOdz7FQU=
X-Google-Smtp-Source: AGHT+IFGy4jXzvLbYnElK5s43ufSZ5ScDtq7TdAwYBG3ZetpAwYWoKQZuDXWOoTUV2nOhKBSzbokcA==
X-Received: by 2002:a17:90b:218:b0:298:b6ec:b023 with SMTP id fy24-20020a17090b021800b00298b6ecb023mr3180922pjb.16.1707932929986;
        Wed, 14 Feb 2024 09:48:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id su8-20020a17090b534800b0029552a03219sm1761851pjb.29.2024.02.14.09.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 09:48:49 -0800 (PST)
Message-ID: <65ccfd01.170a0220.8c608.5880@mx.google.com>
Date: Wed, 14 Feb 2024 09:48:49 -0800 (PST)
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
X-Kernelci-Kernel: v6.8-rc4-86-g0adb9b4f4415
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 50 runs,
 8 regressions (v6.8-rc4-86-g0adb9b4f4415)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 50 runs, 8 regressions (v6.8-rc4-86-g0adb9b4f4415)

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


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.8-rc4=
-86-g0adb9b4f4415/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.8-rc4-86-g0adb9b4f4415
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      0adb9b4f4415af0f0e7dda5b54ce1b67b6bcb63b =



Test Regressions
---------------- =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-kbox-a-230-ls  | arm64 | lab-kontron | gcc-10   | defconfig | 5    =
      =


  Details:     https://kernelci.org/test/plan/id/65ccf309903d1fcc17637017

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc4-86-g0adb9b=
4f4415/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc4-86-g0adb9b=
4f4415/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65ccf309903d1fcc1763701e
        failing since 21 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-14T17:05:58.022959  / # #
    2024-02-14T17:05:58.124478  export SHELL=3D/bin/sh
    2024-02-14T17:05:58.125297  #
    2024-02-14T17:05:58.226496  / # export SHELL=3D/bin/sh. /lava-429701/en=
vironment
    2024-02-14T17:05:58.227059  =

    2024-02-14T17:05:58.328142  / # . /lava-429701/environment/lava-429701/=
bin/lava-test-runner /lava-429701/1
    2024-02-14T17:05:58.329152  =

    2024-02-14T17:05:58.345983  / # /lava-429701/bin/lava-test-runner /lava=
-429701/1
    2024-02-14T17:05:58.433688  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-14T17:05:58.434012  + cd /lava-429701/1/tests/1_bootrr =

    ... (14 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/65ccf309903d1fcc17637022
        failing since 21 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-14T17:06:00.648217  /lava-429701/1/../bin/lava-test-case
    2024-02-14T17:06:00.677161  <8>[   26.147932] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/65=
ccf309903d1fcc17637024
        failing since 21 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-14T17:06:01.736942  /lava-429701/1/../bin/lava-test-case
    2024-02-14T17:06:01.765733  <8>[   27.236395] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65ccf309903d1fcc17637029
        failing since 21 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-14T17:06:02.998346  /lava-429701/1/../bin/lava-test-case
    2024-02-14T17:06:03.026468  <8>[   28.497056] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/65ccf309903d1fcc1763702a
        failing since 21 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-14T17:06:04.048131  /lava-429701/1/../bin/lava-test-case
    2024-02-14T17:06:04.077013  <8>[   29.547466] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
kontron-sl28-var3-ads2 | arm64 | lab-kontron | gcc-10   | defconfig | 2    =
      =


  Details:     https://kernelci.org/test/plan/id/65ccf2b96b939419af637046

  Results:     101 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc4-86-g0adb9b=
4f4415/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc4-86-g0adb9b=
4f4415/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65ccf2b96b939419af63704d
        failing since 21 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-14T17:04:40.033840  / # #
    2024-02-14T17:04:40.136130  export SHELL=3D/bin/sh
    2024-02-14T17:04:40.136876  #
    2024-02-14T17:04:40.238073  / # export SHELL=3D/bin/sh. /lava-429705/en=
vironment
    2024-02-14T17:04:40.238820  =

    2024-02-14T17:04:40.340270  / # . /lava-429705/environment/lava-429705/=
bin/lava-test-runner /lava-429705/1
    2024-02-14T17:04:40.341535  =

    2024-02-14T17:04:40.382392  / # /lava-429705/bin/lava-test-runner /lava=
-429705/1
    2024-02-14T17:04:40.408915  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-14T17:04:40.449928  + cd /lava-429705/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65ccf2b96b939419af637060
        failing since 21 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-14T17:04:43.378871  /lava-429705/1/../bin/lava-test-case
    2024-02-14T17:04:43.406981  <8>[   27.293835] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =

 =



platform               | arch  | lab         | compiler | defconfig | regre=
ssions
-----------------------+-------+-------------+----------+-----------+------=
------
rk3399-roc-pc          | arm64 | lab-broonie | gcc-10   | defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/65ccf3bd999d20f95963703f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc4-86-g0adb9b=
4f4415/arm64/defconfig/gcc-10/lab-broonie/baseline-rk3399-roc-pc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc4-86-g0adb9b=
4f4415/arm64/defconfig/gcc-10/lab-broonie/baseline-rk3399-roc-pc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65ccf3bd999d20f959637=
040
        failing since 9 days (last pass: v6.8-rc2-29-gc24c55a0329d1, first =
fail: v6.8-rc3-31-g7cfffced6d0e) =

 =20

