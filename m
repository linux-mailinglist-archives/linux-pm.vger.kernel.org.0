Return-Path: <linux-pm+bounces-3722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4581984FBE8
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 19:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B801F2BA5F
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 18:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4C65A787;
	Fri,  9 Feb 2024 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="wOtkVhM4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229F55465C
	for <linux-pm@vger.kernel.org>; Fri,  9 Feb 2024 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707503591; cv=none; b=kir7BTSvl3mF8ZbdXlDYdp2Ezc7ESy5itIHHntFx5if3ZvokPPCNPJtJv5iThQJSmNJtlx7l0Fh322/KLTecWYaV4Edu1o/Ey5+iO/ehVjOYG+MLBdGyQiFCmJrhveW9cvfvoOwYh/q+T9nvgRlDqYzu7icYM0T1GHg6rrEWZIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707503591; c=relaxed/simple;
	bh=je7p7yv38NJB9AiISi9x2kiu3qO1peIlrEk2oeHBp/I=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=cW7Km4isYANnJm//B/obJmg8EI+2eVSbfRc/9ASj7CzDuqAjFRU8rH6A0uQOAPtsbIkv1KIfvstkHWTtGJ1NaKrrVjeilSknpLBWiftDa1MvfRfjfNU88NF6+ANp/LVbp/L1p0xnpsKnl5fFdPYgqSjgzUne+dwIGrw2IsJff0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=wOtkVhM4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e0a25bb226so174732b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Feb 2024 10:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707503589; x=1708108389; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wg9P8C1Yfifv18yhk01WTWRY4Ruz8wODkVTP/V3u/pc=;
        b=wOtkVhM4P8jh4TqlP/BfY7y/t7hpgepzn2jaNVz1ffhgOL+h7I3fHaor3nW/afvyE+
         hrajKUIza0AJ0fDToGBZw9/gUyaCEj1JjD4gPUFQos2L+OcjZP6bIHhXgXv50NcKpL2t
         F6HuDwpT7o5YC+zm+BNKO0oZxBRhtQOJqS3Ckk+1Xsq/vnfm4XRzeGYVvWHFZxBO9Jaw
         2EZOlNM6u+hFi8dmKYkhu4cskFw02UWwPYGYOJi29Ip7GKhaR6GMGySoz16lrlbkVWP8
         nlx9F8tCXm33U+A95J76257m+ZZdaTYFMpBpOKXRYYP5nJfCMjan4XYnE0ttYCQRzhNU
         hAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707503589; x=1708108389;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wg9P8C1Yfifv18yhk01WTWRY4Ruz8wODkVTP/V3u/pc=;
        b=bujwlVJqoN1WrIzXwfo2LlCnsulzz9GdXt8aPwaEqWKdGDdzr8iIVRuJ+Qgx69eCWW
         ME3xbTP5KXnt8jOv925qlNplW31ieYxJQkZWEdbW5fLaUt+D3kW9wES/NivLYRJMoDIl
         UiNDsFkSk+Yh6xSGHOBmp0dlOzyO713THSp955Fp5dArD3rLoYpIGe2YfR7tKYbvG3QH
         EMuifzeKcehHvq3mKLS6At+N8OPEsFL7tQ5HHAwH5G6kLkppEoCn0+m9FvUUgq60BX80
         qC60glft3dAAkQNekLEZacbpgvea+TJCEUYQ6Ws0HIbjRQNFUEajHTlErnS5AYCajPbR
         LXzA==
X-Forwarded-Encrypted: i=1; AJvYcCWeuAKLi4MKg/dYsLjD3xVHLdPMTcui01tjgXhdQc4Et9syiRToC1bECBaP++fzf9tIn4NOni+pI15z3FX/BZSAoS8Rk4GY6QA=
X-Gm-Message-State: AOJu0YyyXNj8xbJxbZNN5PUgdrglma4pEN2lWWk4b3kRbeO55ZPeZCRl
	qSu8ZZk4LoFHu1wFDouUyHOqwLeH3F3Sr+fpF/zD/vndqY6bfjsNjepC6dW7gwk=
X-Google-Smtp-Source: AGHT+IEw7pAfpJ1IfRZhdOGc5Ze+hkZYAOQ98Yl2ew2tbzR4XiBWQTVAOkvheZMdQ+II6wBJ0XHarA==
X-Received: by 2002:a05:6a00:990:b0:6e0:6c89:e30b with SMTP id u16-20020a056a00099000b006e06c89e30bmr98308pfg.19.1707503587903;
        Fri, 09 Feb 2024 10:33:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjuihMRokDYDMZxCeekY4FF6sKEQse5DEr7AOuZBJseoCW1oor0cJamN7mJ/KzXWZtMdvPrbiTsr/wEpfIHlKXfEXyoTrFdK7RwE8uicoX/LYhDkQ43y03ysLxSRtCQEqWVyTN1T3M/VY6w3RbjOwI68mWxPyrPB6SF5KxlIMap5BozxRzNwwnkboC
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id kr3-20020a056a004b4300b006e07523e5f4sm838635pfb.201.2024.02.09.10.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 10:33:07 -0800 (PST)
Message-ID: <65c66fe3.050a0220.ffd26.40c8@mx.google.com>
Date: Fri, 09 Feb 2024 10:33:07 -0800 (PST)
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
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.8-rc3-61-gc3c4923f2082
Subject: pm/testing baseline: 46 runs,
 8 regressions (v6.8-rc3-61-gc3c4923f2082)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 46 runs, 8 regressions (v6.8-rc3-61-gc3c4923f2082)

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


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.8-rc3=
-61-gc3c4923f2082/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.8-rc3-61-gc3c4923f2082
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      c3c4923f2082353762e8f46dec6e3b0f165a1606 =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/65c665aa953b8abd978e1e7f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc3-61-gc3c492=
3f2082/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb15=
-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc3-61-gc3c492=
3f2082/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb15=
-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c665aa953b8abd978e1=
e80
        new failure (last pass: v6.8-rc3-33-gda60429b5e6b) =

 =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
kontron-kbox-a-230-ls    | arm64 | lab-kontron     | gcc-10   | defconfig |=
 5          =


  Details:     https://kernelci.org/test/plan/id/65c665be953b8abd978e1e98

  Results:     90 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc3-61-gc3c492=
3f2082/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc3-61-gc3c492=
3f2082/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c665be953b8abd978e1e9b
        failing since 16 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-09T17:49:34.837042  / # #
    2024-02-09T17:49:34.937731  export SHELL=3D/bin/sh
    2024-02-09T17:49:34.937972  #
    2024-02-09T17:49:35.038434  / # export SHELL=3D/bin/sh. /lava-427892/en=
vironment
    2024-02-09T17:49:35.038653  =

    2024-02-09T17:49:35.139197  / # . /lava-427892/environment/lava-427892/=
bin/lava-test-runner /lava-427892/1
    2024-02-09T17:49:35.139528  =

    2024-02-09T17:49:35.151692  / # /lava-427892/bin/lava-test-runner /lava=
-427892/1
    2024-02-09T17:49:35.244618  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-09T17:49:35.244753  + cd /lava-427892/1/tests/1_bootrr =

    ... (14 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc2-probed: https://kernelci.org/test/case=
/id/65c665be953b8abd978e1e9f
        failing since 16 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-09T17:49:37.459634  /lava-427892/1/../bin/lava-test-case
    2024-02-09T17:49:37.486629  <8>[   26.281932] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc2-probed RESULT=3Dfail>   =


  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/65=
c665be953b8abd978e1ea1
        failing since 16 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-09T17:49:38.548061  /lava-427892/1/../bin/lava-test-case
    2024-02-09T17:49:38.576100  <8>[   27.370809] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65c665be953b8abd978e1ea6
        failing since 16 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-09T17:49:39.809567  /lava-427892/1/../bin/lava-test-case
    2024-02-09T17:49:39.836538  <8>[   28.632325] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =


  * baseline.bootrr.fsl_enetc-enetc1-probed: https://kernelci.org/test/case=
/id/65c665be953b8abd978e1ea7
        failing since 16 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-09T17:49:40.860143  /lava-427892/1/../bin/lava-test-case
    2024-02-09T17:49:40.887994  <8>[   29.682798] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc1-probed RESULT=3Dfail>   =

 =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
kontron-sl28-var3-ads2   | arm64 | lab-kontron     | gcc-10   | defconfig |=
 2          =


  Details:     https://kernelci.org/test/plan/id/65c665e6a727c022488e1e9b

  Results:     101 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.8-rc3-61-gc3c492=
3f2082/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.8-rc3-61-gc3c492=
3f2082/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c665e6a727c022488e1e9e
        failing since 16 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-09T17:50:13.592801  / # #
    2024-02-09T17:50:13.694444  export SHELL=3D/bin/sh
    2024-02-09T17:50:13.695090  #
    2024-02-09T17:50:13.796081  / # export SHELL=3D/bin/sh. /lava-427891/en=
vironment
    2024-02-09T17:50:13.796336  =

    2024-02-09T17:50:13.896914  / # . /lava-427891/environment/lava-427891/=
bin/lava-test-runner /lava-427891/1
    2024-02-09T17:50:13.897810  =

    2024-02-09T17:50:13.903978  / # /lava-427891/bin/lava-test-runner /lava=
-427891/1
    2024-02-09T17:50:13.968358  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-09T17:50:14.002055  + cd /lava-427891/1/tests/1_bootrr =

    ... (10 line(s) more)  =


  * baseline.bootrr.fsl_enetc-enetc0-probed: https://kernelci.org/test/case=
/id/65c665e6a727c022488e1eb1
        failing since 16 days (last pass: acpi-6.8-rc1-2-8775-gd8e6ba025f5e=
4, first fail: v6.8-rc1-9-g3d5bdaa27c031)

    2024-02-09T17:50:16.936689  /lava-427891/1/../bin/lava-test-case
    2024-02-09T17:50:16.964710  <8>[   27.101349] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dfsl_enetc-enetc0-probed RESULT=3Dfail>   =

 =20

