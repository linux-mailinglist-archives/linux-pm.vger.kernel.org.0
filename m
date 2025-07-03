Return-Path: <linux-pm+bounces-30066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 084B3AF7B00
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 17:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8103586958
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 15:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27712F235C;
	Thu,  3 Jul 2025 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKrZZbkX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C66A2EBB8D;
	Thu,  3 Jul 2025 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555604; cv=none; b=TdDAIKk37iGKRXfiyeL1ofdUdjFEQ8pebBdFUlVYZ9ntrqmJtlnIQ0e83yrIjyspyfUXMKsLa0RjmATMG3Ctc4YMZ/pp5aVeLCX8C/Ae6aPYPf19Vu2/v6H+rRnskYCc/S7np36APfcdqUYB5gRKuJ5fmgKNeUlgVauwt2uGhPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555604; c=relaxed/simple;
	bh=nv9OK1L0UQMxg74LXR+ORBLR37vlz1npBtTJKz/DTXg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQDHFR8FzcdVWKIhaDxnF5BJIzoUtv9s+2ukOnLItfv3b5VLdNZ6Nlehiinp9R/8l7VjEeIHNA9LCChExMNAtB394Z62jUOecNZRaXy4JVw32bbQphsdYx2pB7Lrj5BeTqmM2hwqX7OE2WeS7dwmyzcuhsruHOplypOWMiWq6xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKrZZbkX; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b8134ef6aso352911fa.0;
        Thu, 03 Jul 2025 08:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751555601; x=1752160401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/HlbY0O85zcixYzgYTA8H0Mdv+GR5C9KDIOJVQIiKc=;
        b=bKrZZbkXGULAT/YkPMxe2h0qjI/AJLTssJYM99eRc0LSJONCQ5KLYsIFHQ+Xm384t2
         /9UvJtZ/wp6VSP4pXev6kaEFk1hT5bwDy6HVFKwzTd2BRl+iyrXiqL1cQrMg5L2667pC
         vYSeTwax3EsKYQiReaL8Sha1HESONBy6Rgntc2HUooCN6n+opciZvke8R1wWDZXgcGEm
         ODecxFi+ay9WUxvHUlLBh6YahUj5zbJAyuDUY5iqcHYs2j1JcuqJOsRjHKYhLw7rIbL/
         HupGG1pG4wmU8nLRu0PV1ZuPg3n/NYiQKegZBuAW9kdRVQniot+fvslARgLqaLJBHebP
         IAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751555601; x=1752160401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/HlbY0O85zcixYzgYTA8H0Mdv+GR5C9KDIOJVQIiKc=;
        b=EkI+ZD8BmqTpGsvVFoiwhn/JHXAJW1+2/PtAwQ8nNEI5kMW1lYFt17roRGceAgXNH4
         TF7L0uhiWDD0ikT9d7ZCkQ8WNkvP17BMIU2G/62uad4i1Y4cdCaalmoEnNbH41Qrtej5
         XBIlULbMZi0s+AwLDU3mZuiVRZgyoVNhCUTOZbH05wkCZBuMVyJeD3WaZMvTYgG89vct
         KtbGfp5Efr0SHNce3W4LZK0bJlDori5jNGq2YMcqzepjz20hkwPfL6C4cy8TBAzgUvU/
         GJyvRGL7qSqn8yGKADAW6JCIuX0hzwB9XDYdc4PCeBN571WddroagRI4eVB22AbSB6nH
         vDuw==
X-Forwarded-Encrypted: i=1; AJvYcCWEWLtf+GRZnAH1oC9OiOsc4tPCIrnUHyCLjcHXY5mHP11iJ2rnBNsdYKfJo9HSekjKvzUdc/2S8UdQoqFE@vger.kernel.org, AJvYcCX98cZ9z8cMC8uw0su0UlDvjdPVpj801MSr4QCHI+HDpnwURYN02CD0Bh5JNGA5AEhHdGm00D5MSjQ=@vger.kernel.org, AJvYcCXQCq8A1qmnZaUKK0pSW5JyhQylhdoDjKL2AIsmvQmbx/nawKWmHTYdsjwalAmXjXZ5fHJROBte2FTP@vger.kernel.org
X-Gm-Message-State: AOJu0YwnaiCnC/9kurYU+kAJYc6hTjQBwFWWKuWaVmSe+DfkuxTkGZ0k
	uvmKrz1Ne/sIusi175VdU1MhmRHJ0ge+yabIJStSyjtJz/bjHJVYoXSL
X-Gm-Gg: ASbGncs04LdfQYzhnuObzlKSRj1a7VSqGTELSyYW4u4UG3gYTjSBPNUkp/a+tLxeL3x
	dlCwXU4Mt5FIBlrkNhE2Z6OCww5ekNbrLomtBFzoSFMX9PfEGPuJLs8+z9/95Brmn9XmQmTSWCI
	A2N9/RyEed96kyafxoubWHOxvz3fqArRQvQo507k1aaTDLiqC7axWoOHKCSkqPLmchzYX9bwTQ8
	fmxgf09nC1sBpAQwfaYx0ZMkzpJUBTy8/dRc0T/BOOMvavUfgqK/ByZPZOhrjdwvIDBYcOWOBY7
	c0JgoESUuXnv1K6twFvKr9q7KGryoCUEfWmt3Ox4JDdvbnrP3U6xx5D9I6FTZ/okR7ZM1Qw=
X-Google-Smtp-Source: AGHT+IFizivHRCGbn2xa6qy5KahETw6sFgoEVp5+fipVdvBjkYyulTltzT89w8oz7cos8x+uQdLuBg==
X-Received: by 2002:a05:6512:aca:b0:553:25e4:274b with SMTP id 2adb3069b0e04-55628344003mr2815796e87.41.1751555601020;
        Thu, 03 Jul 2025 08:13:21 -0700 (PDT)
Received: from localhost.localdomain ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384ae15esm725e87.178.2025.07.03.08.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 08:13:20 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 4/8] thermal/drivers/sun8i: replace devm_reset_control_get to devm_reset_control_get_shared_deasserted
Date: Thu,  3 Jul 2025 23:11:28 +0800
Message-ID: <20250703151132.2642378-5-iuncuim@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703151132.2642378-1-iuncuim@gmail.com>
References: <20250703151132.2642378-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

The A523 processor has two temperature controllers, but they share a common
reset line. We can to use devm_reset_control_get_shared_deasserted() instead
of devm_reset_control_get(). This will simplify the driver.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 45aaf5348..bdd15ee45 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -344,11 +344,6 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
 	return ret;
 }
 
-static void sun8i_ths_reset_control_assert(void *data)
-{
-	reset_control_assert(data);
-}
-
 static struct regmap *sun8i_ths_get_sram_regmap(struct device_node *node)
 {
 	struct platform_device *sram_pdev;
@@ -391,19 +386,10 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 		return PTR_ERR(tmdev->regmap);
 
 	if (tmdev->chip->has_bus_clk_reset) {
-		tmdev->reset = devm_reset_control_get(dev, NULL);
+		tmdev->reset = devm_reset_control_get_shared_deasserted(dev, NULL);
 		if (IS_ERR(tmdev->reset))
 			return PTR_ERR(tmdev->reset);
 
-		ret = reset_control_deassert(tmdev->reset);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(dev, sun8i_ths_reset_control_assert,
-					       tmdev->reset);
-		if (ret)
-			return ret;
-
 		tmdev->bus_clk = devm_clk_get_enabled(&pdev->dev, "bus");
 		if (IS_ERR(tmdev->bus_clk))
 			return PTR_ERR(tmdev->bus_clk);
-- 
2.49.0


