Return-Path: <linux-pm+bounces-3487-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE4684B8A5
	for <lists+linux-pm@lfdr.de>; Tue,  6 Feb 2024 15:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3AB1F260D1
	for <lists+linux-pm@lfdr.de>; Tue,  6 Feb 2024 14:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4555133995;
	Tue,  6 Feb 2024 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bm/23kc0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4A6133290
	for <linux-pm@vger.kernel.org>; Tue,  6 Feb 2024 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231458; cv=none; b=k+0NRIe+lFrcB6WJ2c/Q4mXHbedwDcGPk3Pv10Q+7+CJ488O7qkL5Vqx+anEt6U0YUbqCH+SxAh36IvRQ9euvYTAJIBBEdfv7uRVluL0DPOe4VDYEf4ePzV+M97agzKTJ/NLCnN1KyVsdwZYXTap4vl2P+Dr0n3x1arExf9/O4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231458; c=relaxed/simple;
	bh=SkFzRVizX3/7zSePWgBSFxKQK0lRv7CXVzyQ0OMy4qY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vo9XGnOOOscONfMqvSXdOR2cfPAS4hZqmd4zWlsbMCk/x2VQrmjAsk7EDZXlslBfYUjyP/A+SLu9+mKga5PK5ovaFbTDpx1Ybr8kfhgsJ0iAwY8i8mVDtfQ9Tuh0r6IYGUnJbueN/opBlzVgK7Wbj1Jzy1pcKjUSu+y+lr68FDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Bm/23kc0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fe2ed8746so6173135e9.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Feb 2024 06:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707231454; x=1707836254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qd/yin5VMysEvNts0gZadD23DoOM8LUOgcjY6AROhAY=;
        b=Bm/23kc0Ms5YB0lnK6BhEjO/Lt3vff9S1kuSA5ZCvTENQtNQEOOktHyIl/DbLQb/ze
         4oxMjBqZNweCp2xuwvoeJI1uoKnBGCUISbI1bqpsjH9msGcsLOV+vKRHBoG6G1XgLHGS
         hrFurQm6XHePcqMD0cqgdEHxKLChbohAGxtYW71A24GIQsigKSNZtuiRtQCouY7JK69l
         HD9Q2Ux7l66w5XlcpsbewAiXbAHJw6EDo9C0m77xQaam/zUzi7laarPuw6k5TWfUWV4Q
         P1p+vVvKYE8r2BSuoiik978DI8APmwXv2mEiCyaaEXBEKM86A7ZlKAJCs/PrHcIPDpEJ
         v7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231454; x=1707836254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qd/yin5VMysEvNts0gZadD23DoOM8LUOgcjY6AROhAY=;
        b=AyZ8JwI1MnTXJHWoOe3m0vd9vnMN67KSLLpeRGT1n+B6M1N8P+qfSCjNojPykzdqOM
         XHPf3+uZBGkv71FLPrckJYhFysAkw4poAMeTvmMAcNYAWcWK4q5WXkpcrhN2bVnyRHyq
         wUDsHj2d4P+G6HGHMewijoBOs20l9U9iuvBX9ktESwE8ZiOM6Lz0Ui35Drrn96YnbrlR
         YDCjuszjBz1/CjFjeXFkKrWJFAwwOEOyVM5/u6C6guhf8z/V1laY6jFdGXNbaNEdc7OT
         UtrDCkuqxCh5zaewiGqvo2KHmZpItHTECbdeWI0k9HXgLxTHyLDXXiKENkIx7az/Bd/5
         CDHw==
X-Gm-Message-State: AOJu0YzS5JO1CV6VHF5/Wmi+lfSIz8NVFVDnde7pB3UFRCLrs1+3JZPH
	e1uuWD6RtmrcVk6FpCovxbVhBEq3dank0MtAw0Ojqq93TpXr+zAx1RFyaUMUq9I=
X-Google-Smtp-Source: AGHT+IGQAjkFsWB4DNjFdqrRY+U7gGoLrMoTyFlzTYIuD0QGQzbOklYF2gaPKPrCIgrg26cl+/kWmg==
X-Received: by 2002:a05:600c:1990:b0:40e:b0fd:3c09 with SMTP id t16-20020a05600c199000b0040eb0fd3c09mr2173252wmq.9.1707231454609;
        Tue, 06 Feb 2024 06:57:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVT2HGPPh7VxjWsMbUaOVrJSYCzgoyTXQ2+KTDlQ5a49yS8VdgV9HXjUVlPEY3cJ5iR3QQsmBMolekOX0OYwPBywCZ/U0VnmcW3WkdEytqBfEQHzkW55XVabAFDEbYvjuevDWfEzdA1cGYxU9ImFBWd8cgRWEdET/N3ZUZtmx3j6gGl7X8X5pAyuxfg0WHU/iq99R08xQF3NoaqtRl8JiJMvP7MiZbPDxHnAQCKNU741W93qle/IQzwQB8sEb7KIfuTDZxwZS9VkHST2Bmf4ansRptnISA5rtVGBQY3I2flGxy9QupXZC4RUknVO6cnpI8WUK6tvBPPgKxNn8QPNGFbb+jeiyA5dFBPSwKlPCU8ELl8ud0aa7xEnXj+ENM0lx3y4wd5mi5wnjD8g0i1B2iTTaw9xSGhnY4QXfJGgk5lzCa24YgrJKgGwkYLa+5A/u7ckc+nGjDJ+FvMaGZYIAu9MknZ4PHSTRFt
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c4f0e00b0040fc56712e8sm2257896wmq.17.2024.02.06.06.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:57:34 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Andrew Davis <afd@ti.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 0/3] arm64: am62: Use nvmem for chip information in opp table
Date: Tue,  6 Feb 2024 15:57:18 +0100
Message-ID: <20240206145721.2418893-1-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

the OPP table on am625 currently uses a syscon node to get required
information from efuse registers. As efuse registers contain many
different information, this series adds nvmem support for the TI OPP
table and cpufreq driver. This way just the specific information can be
referenced in the devicetree without the need to use a syscon reference.

The nvmem layout is added in my previous series, links are below.

This series is based on
  https://lore.kernel.org/linux-arm-kernel/20240206143711.2410135-1-msp@baylibre.com/
Which is also available on my public git:
  https://gitlab.baylibre.com/msp8/linux/-/tree/topic/ti-chipid-nvmem/v6.8?ref_type=heads

This series is available on git as well:
  https://gitlab.baylibre.com/msp8/linux/-/tree/topic/ti-cpufreq-nvmem/v6.8?ref_type=heads

Best,
Markus

Markus Schneider-Pargmann (3):
  dt-bindings: cpufreq: Add nvmem-cells for chip information
  cpufreq: ti-cpufreq: Support nvmem for chip version
  arm64: dts: ti: k3-am625: Use nvmem-cells for opp

 .../opp/operating-points-v2-ti-cpu.yaml       |  16 ++-
 arch/arm64/boot/dts/ti/k3-am625.dtsi          |   2 +
 drivers/cpufreq/ti-cpufreq.c                  | 105 +++++++++++-------
 3 files changed, 83 insertions(+), 40 deletions(-)

-- 
2.43.0


