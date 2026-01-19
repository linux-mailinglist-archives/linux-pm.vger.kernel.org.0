Return-Path: <linux-pm+bounces-41093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E56FFD3A83F
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 13:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D064930C9C91
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 12:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE67835BDAB;
	Mon, 19 Jan 2026 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZb3CUCH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A5D3596E4
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768824543; cv=none; b=llqx9yWjkuJEoSpX7qzfosw1ZOXab0Sy6DXaOkYymCWeW3WcMv8+C7rW/SUxFopKJ1B/7scfn3jDq84FruJ0uPOtpnhrV9T/UjzANsGgAN0bNk7hMRv6JXNMTEJq1qBXPjVBRDM6HpGTG+VpA+m1tIaBsRAqLsIo/WAAxbCZon0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768824543; c=relaxed/simple;
	bh=glFQ4Oo7aFXvg4qCxUzDyhw63Eric2ZNI22jQtPmJhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oz8jEsAqHIMDD31WtlnBPXXIhLjJWxWU+gm74J1aw/pQwRli/WoJsfQese3p+StV5Z0VxTKHIpMsifXzKXEeYnIGKFijhdIL54dS7o29J8fGt3hjAUUOINa6FwzGpzQEi/2hjKUwmrZtyrXYEDHC99ymRM5FdpsPhO+xJJal+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RZb3CUCH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-432d256c2a9so4188360f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 04:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768824538; x=1769429338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lathu7eoQ9hnN88L9AXE9/ZDnozq7El9GXLKl/+ubdI=;
        b=RZb3CUCHS8XY/w6prvniPZsJeLa0F3ecDqlXKS5V18u1ARwlecbTcvfkMSSNc4zo2e
         UufpYWCk8WYq83Icb5O9z6Ilv47FMH77Q+RTgM6IusnK+ht1cE+t7wwyS07BtmIMQNEY
         zI+xu/b3CCv8fxsv9Z3+vLTeBwyKifeuKRg+4pct0sYuqz2X4NTmsPhitNF82Kg1auTn
         zbQZC1CBLDmCSrh9hR0uhM9xC2D/0whgDNNNeDOz7NOf+FCh1Nai1DFMHvbQ7dJem49c
         kdswX6eFkJ6Ek5/OZ9Vi1JYIQlkgLIgTaY5ktp53Rx7wdG+TdEXrHFmml+idHlmiyUnQ
         yk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768824538; x=1769429338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lathu7eoQ9hnN88L9AXE9/ZDnozq7El9GXLKl/+ubdI=;
        b=TiSc6uPdFkfJyMm1H8Fjqr0Jtcl2vPJ0EC2l5mbDV/Ut2tEgyfdjVV2rn4ygbAsl5h
         DLM5fsEC03TyNRFdT+lX2DbL2Mgs3QFzEWpdWK+OKszMILxcjvRck8qL77lhf8meCr2J
         kKFm970m9qtvT9WFQti17D44nLQ/uJQnUosUAXQOn98iYs5rwZqcqPVtBvEJK8ykrLqp
         XkwX/IjjP4sAfPS4ynTmh8X7Uzxj2aZejxVIRO+IfFxpDUq2eVKsZ+dJH6QDGx8jC4VS
         UvgnwGQtr1ZbUwS/UOjKNHfLd4sxvSPsWFG7IoYRZRtOZ7leT8j25GN7ti3ypim4IwPb
         BpLw==
X-Forwarded-Encrypted: i=1; AJvYcCV4Wr57Bn0l/felPtXJETUuj/vlzWQ+Y8/9rjpNJB+P13MZdD8uYLZ5v1KfZC5eVKZ7Z0EbanSHHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRdh+B4B3QSWvsV63m+tuyDrX9RuXFxcCYsKSUaSlmWDiOmbuK
	6oeSpLiyr6s3nQ5aGlsJeAoa4nW/c7dGd3s2kIyozKMOfQhikPg2kU1gZMpz0ET9JGg=
X-Gm-Gg: AZuq6aJ3oL1EK0gLOS4cZ8lEh6sKHMyUfoqKQeAUGE9E4dxgw4NUwJObbt6jrUCoNk7
	wX1kpU9p+F6YqZiSygTsM4qNB/rCk7xTknbDkBmGlgsrtLQTYcEBhaZGZomWO3DmBUWH91faz8D
	Hn+1irnklCMdjnYGHKsmxV6qa0/Ud6fEeSIVes6WJq2C6Xil1eAWZtGyv1bGeDQEOtIJ8w3O32F
	7NLwS0HvuASCHRr3I1Xu+2xLxuQABoekxMJo937IAulo2FNUREetH8jKZrZ9yspoGSioADIo6kC
	Iy4dcUnLjOKlKKbGIkb6ORRSRPnCAMQQuLXjKG20gzxpjLLSnKLvlq6mDTsu9DtMh+FxqZmnrs5
	UcplHcpEnU3UEvnUv3rSP66ID0K833JfuX7pQV3/PTNvPuOrueSal0bCt8Ue5mvNTL/DC7+qvty
	Kex2mEwZaNtDvg7HEms1ssqAKUHiJF3lyK9bj86gw8LVuhvp128kua0TcVNN06BcbMnSWXew==
X-Received: by 2002:a05:6000:144b:b0:431:8f8:7f2f with SMTP id ffacd0b85a97d-4356a07743emr11227404f8f.34.1768824538122;
        Mon, 19 Jan 2026 04:08:58 -0800 (PST)
Received: from ta2.c.googlers.com (164.102.240.35.bc.googleusercontent.com. [35.240.102.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e664sm20698421f8f.30.2026.01.19.04.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 04:08:57 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 19 Jan 2026 12:08:53 +0000
Subject: [PATCH v2 7/7] arm64: defconfig: enable Exynos ACPM thermal
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-acpm-tmu-v2-7-e02a834f04c6@linaro.org>
References: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
In-Reply-To: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768824532; l=868;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=glFQ4Oo7aFXvg4qCxUzDyhw63Eric2ZNI22jQtPmJhg=;
 b=jGWmIQ3VJe/OIr58mGBQinzVZCX659HJK8MtuuaHM01fhgkcacEuB8bWVtLq4hLL7aAt8CY7o
 ND/UZrRnDGbDYAMpf2MIYS7MwKUlOKLihzJnMnIfQ6vWHwzkx5s2HTQ
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Enable the Exynos ACPM thermal driver (CONFIG_EXYNOS_ACPM_THERMAL)
to allow temperature monitoring and thermal management on Samsung
Exynos SoCs that use the Alive Clock and Power Manager (ACPM)
protocol.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 45288ec9eaf7365427d98195c48e2f8065a8bb1b..68fefe4bf49501500362fcb0b490a684ea469b26 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -752,6 +752,7 @@ CONFIG_BCM2711_THERMAL=m
 CONFIG_BCM2835_THERMAL=m
 CONFIG_BRCMSTB_THERMAL=m
 CONFIG_EXYNOS_THERMAL=y
+CONFIG_EXYNOS_ACPM_THERMAL=m
 CONFIG_TEGRA_SOCTHERM=m
 CONFIG_TEGRA_BPMP_THERMAL=m
 CONFIG_GENERIC_ADC_THERMAL=m

-- 
2.52.0.457.g6b5491de43-goog


