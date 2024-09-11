Return-Path: <linux-pm+bounces-14006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BF6974D78
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCDAE1C220CA
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9D019EEC8;
	Wed, 11 Sep 2024 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SELzJjzQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218F519E996;
	Wed, 11 Sep 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044518; cv=none; b=oClQ0scTJI8PtfMbPaoZacaxUw3Ia5iqmDZidFfIJ4deI57RAX8WfipK6B8gkMFggjRHUJCWVH2Gx/yu5O5qqxe4RP2c81jJsjw/LdvL7d6KT15izX6P/iFheJw/urD8grVkOVL6zxyjeSYBVK2/V+TrJpE1JuJtL9OR44M5LWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044518; c=relaxed/simple;
	bh=IlwfpKeYG1A6lmRpl2J8Js+0dUrkM33rNMIVVPeLcso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iukc8IvS0Q/VEz+PMWfmY18yGk3wBhC92wlKjB3D7monpaqL1VK8Vh+/Hd8FmyB2IQ4epb4TAhMfsQJY2DCyDMiNBd3uFO0u4TKbY3TonOhMUJnr4E2fMzsaGWxCgcXEk3n/HK3Ua7GRRsZ0YzjUIguhX84nhpiGEbozt99i8Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SELzJjzQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71781f42f75so5188059b3a.1;
        Wed, 11 Sep 2024 01:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044516; x=1726649316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy0C2tn+S+ad9UGMaUozuLH5nIPIOY9VH2lYfYG3DPM=;
        b=SELzJjzQRJIJxRVXaRARykQkhwroJK283xwl4eIwbQUTffdcYb0/l0GAl4hnYzMjFt
         y5KwXDeq7WnpnSHdSTGqqMkvFXMI5C/oWk/lcKwdX6hPf6XREZWRc8y9Abd4mU+7i71D
         ild4sZbaikqvOKg4Kz+VN9+CTKZFyiDTAQYhbiyWtn0ANi5pjuHeR3sumcbg8AlyE22y
         WeIX4STn3DYZ0QpGmxEFK7qa7RHhyJZljSVpfCd3h2S672IPxefpFWm/r7fKA+jc1Gz5
         /xz/wBkr+6sBCIPbNByEoCM/hYb9Rlb/cSUpKiC6PS6x3IQ8tdI957odc36CBomlTnbT
         HoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044516; x=1726649316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy0C2tn+S+ad9UGMaUozuLH5nIPIOY9VH2lYfYG3DPM=;
        b=V3DyqsjOzUUCruUM0hgWKPp+tV0nIM+FnF0gbF3PdJcIUYacHg7zn4zL2+KW1W8pcg
         4Nevid9rpqUITt47c2yu086KBGiNkf1n2NIi6SmSlpq37S3l/1KHZf/69/S8Zlt9BNzJ
         1ZUdKmBrNIiTHVr0DmSTb401KFiZMLhHdBSiKeugKok/yFMJvePGHpkY1cPh/shqFlXP
         2YdMFQOwEa8MpqJFCYyRxL+fFfe5/RYS50FRQF7dsrAJWVbXuVNh4x+OwwEEQPekBpyJ
         awl+mInZ2q3MBqrABe/WNHqwLkV3aXKjeB3Gj6nLIFONhFZ60JqGD+fihqt2Fb+6SbGx
         jl4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU49cM36hX0Bpg7SFnHlDCnTmSXbs0/vv/wYnvvm6YX1AuVWC7AO2QgcS++EPrp5n/AMud8cN/tuJtULOvvZiM=@vger.kernel.org, AJvYcCUSEmsgRY+hvnFoLQ08GdYTYTaYjXDF9y31lvaKb00cqgyqa++EbM9KRrBSGfaClSbcL87Sc9mBmRWL1A==@vger.kernel.org, AJvYcCUe5m4b3qmfzfxT/M/D9F9ei5nxzIOITtrw8L7dXSeX9Dzmd6724QAhwrWbUOX72FxiSxm17yYX3jE1EiK0@vger.kernel.org, AJvYcCWCYGZ6hzE2OMawugdksF1jG1od/1oZtHS4LNzqn+k4BW7XkTV95X/4p0O6UNV00mkz07KsdbxnkhY2@vger.kernel.org, AJvYcCWS1bkMbSPWEkcM0KVksC6Z0Fk1fcITs2LNNlsHVtLPzxF32zAJxi1neUV+7oMe9cXDuckL77QWbIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrEnrUOHif1ImnThTjsX9BDYbdbO9DsGlhKxcCD/VR5+L6CKa2
	sXLEgzVhEkSL9GasCL+Bef0DPx1fSRbLSgJ4rJCxPOWQUCMOXeAq
X-Google-Smtp-Source: AGHT+IEIz5d//17WPnMDgMVDUYvH7+sxfpmlvAoBsrI8xaC6pMBmCRrAzLDUicf2j5d88qL+NqMcTg==
X-Received: by 2002:a05:6a00:886:b0:70d:22b5:5420 with SMTP id d2e1a72fcca58-718d5e5476fmr26897235b3a.15.1726044516437;
        Wed, 11 Sep 2024 01:48:36 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:48:35 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 22/22] arm64: Kconfig: Update help text for CONFIG_ARCH_APPLE
Date: Wed, 11 Sep 2024 16:41:12 +0800
Message-ID: <20240911084353.28888-24-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911084353.28888-2-towinchenmi@gmail.com>
References: <20240911084353.28888-2-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apple's A7-A11 SoC is now supported, so the original help text is no longer
accurate.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/Kconfig.platforms | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6c6d11536b42..370a9d2b6919 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -37,8 +37,8 @@ config ARCH_APPLE
 	bool "Apple Silicon SoC family"
 	select APPLE_AIC
 	help
-	  This enables support for Apple's in-house ARM SoC family, starting
-	  with the Apple M1.
+	  This enables support for Apple's in-house ARM SoC family, such
+	  as the Apple M1.
 
 menuconfig ARCH_BCM
 	bool "Broadcom SoC Support"
-- 
2.46.0


