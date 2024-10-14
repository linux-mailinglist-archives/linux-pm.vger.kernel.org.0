Return-Path: <linux-pm+bounces-15618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B593999C8E4
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 13:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A2E29128A
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 11:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B2C18A6A0;
	Mon, 14 Oct 2024 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="1GwqD3NT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D11633998
	for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2024 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728905377; cv=none; b=qCxC9x2kMTqudh1LdZjzmtlAwL4vnb6KxLnLw8oBSASQnMvVE6miKp2per1LdJJy0qGXcLmZ5CkFkQLIslTRfQ1ZNJ8k6ZJCOkvRVew1XjeOf4eEltUYanWbkXL/AYWjKYYXhrQUyzxwV1byPaf5iS8FyzKuI2vHU2zt+7ey7sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728905377; c=relaxed/simple;
	bh=ks8/fOYfMDxkydrHmFLeBApwuoib/XPJpWAmhBcvjsM=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=WjXEegRHEj0+yvUa3L0FT7ROBM/J26NBpuBO0rqMC0s8jlgRzUCoDNUv+QCcopyR/gtya0qSc7u4/Z4d+6obipYHNDabEUaxwFxNzYnuzDVDZUx9msuTNjsKrkXYa9oWqNukeajw3KSaWoYFQYJmTdWxkivNFjOco2G60y4VWwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=1GwqD3NT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c70abba48so26328765ad.0
        for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2024 04:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1728905375; x=1729510175; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xx5tq6bIQoFcnp3rcYZF0ORIZLg97qHcP5OOE0i+yR8=;
        b=1GwqD3NTy/vWbNrQoifRq0AonY9BOIT6JF1eE6txmoWFlGD+t+iaFQ0uUtoNBi442O
         vRjzy1DZZodf/Eo1baA4J9aCypZhG2u4a+em0C1Wd5hR0A9R9vnSWXvpXzicgBx3K9Pl
         On9AOYgW1w3RH+j0692EaGKPABLzcXHNyfhioYnU865WIecLqEGZESBqCtpNDo3k/Q3U
         vZQvpKI/eVrIUO4cPT4kyOHOMaKrrJNn/NzOJds54bTCes/oTb0nlcjqmALViz6o7cO4
         2aAr4aanBetq8q0Fm9CCPMdR8xIudJETJa6s6feexvaogs5+/aOc2S/WWoqFDfOU3CUB
         O+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728905375; x=1729510175;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xx5tq6bIQoFcnp3rcYZF0ORIZLg97qHcP5OOE0i+yR8=;
        b=V6sUX7KChv9Wi1r4qBmMD35PkCHegpikhrxy4OBomZcvxO0IiwDzfKgBHpxKHn4vuq
         QFj62vN2QKaZIM++xUIhr2owH4pM/hnPYWG3vQOXQOujWlyFYEMX3uJDjH4EOu2cLayS
         82+EW2r2c3DKUYLCH++a7P3Wej/QsRSPz6yzFIbBlei+mPd0ubMBc/tmbuZT81c63beC
         dTdiBn4Oe2yesJq1RzHWCzWQZgdxwHxMkVswOmA4dBrWq3nE7zqCieBu99wDxoPgc/1H
         rjPcUfE1PrGzpeYBMMTRWyQ0upJZRW4lIUzLyxwv7SClOLUjp+cOy7XQ15h6JdpY4LMs
         Sd3w==
X-Forwarded-Encrypted: i=1; AJvYcCXmIId4hboKG3W8DfoQWZrvJusn8NPs0WgApQSQDQVLpQIS3WVkC81uYEE8VlhSvYm26VXtf8GctA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyodHfcuMYha3MUle54uSowX3C/xVyk1wsK9gYEIDqHpcJyCDTJ
	XYBimyZYaAJQsPB0fLB/CshIREoUg2Cx3enVaRRd3gcBFbVSHozfhDO//JfJwhw=
X-Google-Smtp-Source: AGHT+IHGx/jEK8kUgBh1QCxKxRreqpqASoFCobCfG9qOgAZ+WyxbnMc9qShfaGtIHoPbSnE1W3xo9w==
X-Received: by 2002:a17:902:e852:b0:20c:61a2:5ca4 with SMTP id d9443c01a7336-20cbb18357emr114029775ad.10.1728905375631;
        Mon, 14 Oct 2024 04:29:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad33cbsm63853485ad.25.2024.10.14.04.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 04:29:35 -0700 (PDT)
Message-ID: <670d009f.170a0220.e27fb.1fa9@mx.google.com>
Date: Mon, 14 Oct 2024 04:29:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.12-rc2-33-g54ad5ae82ff89
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 30 runs,
 1 regressions (v6.12-rc2-33-g54ad5ae82ff89)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing baseline: 30 runs, 1 regressions (v6.12-rc2-33-g54ad5ae82ff89)

Regressions Summary
-------------------

platform                    | arch | lab         | compiler | defconfig    =
      | regressions
----------------------------+------+-------------+----------+--------------=
------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.12-rc=
2-33-g54ad5ae82ff89/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.12-rc2-33-g54ad5ae82ff89
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      54ad5ae82ff8916c2277fada38327efe7892e401 =



Test Regressions
---------------- =



platform                    | arch | lab         | compiler | defconfig    =
      | regressions
----------------------------+------+-------------+----------+--------------=
------+------------
stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defc=
onfig | 1          =


  Details:     https://kernelci.org/test/plan/id/670cf4f3d72eac39f3c8685e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.12-rc2-33-g54ad5=
ae82ff89/arm/multi_v7_defconfig/gcc-12/lab-broonie/baseline-stm32mp157a-dhc=
or-avenger96.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.12-rc2-33-g54ad5=
ae82ff89/arm/multi_v7_defconfig/gcc-12/lab-broonie/baseline-stm32mp157a-dhc=
or-avenger96.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230703.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/670cf4f3d72eac39f3c86=
85f
        new failure (last pass: v6.12-rc2-21-g04fe2b1b0ff57) =

 =20

