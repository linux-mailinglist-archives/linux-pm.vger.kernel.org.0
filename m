Return-Path: <linux-pm+bounces-30065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5188CAF7B14
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 17:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1316A3A3CA9
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 15:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620942F0E5F;
	Thu,  3 Jul 2025 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFQDyUm/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840172F0C6C;
	Thu,  3 Jul 2025 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555585; cv=none; b=n0xiyWwuwNFihNm7TcOA5DKQ5fIT5AoeYYQAHe8VOnHlRUzJtsHhUgAMBP6IOj68SNUs1dWiav58UyddpGyrIU6xWsSltEDozgN/0DMNInkVVM2zaSdl1mnMPa1vvw1XPtkP5qwyyU8Zv1aQbv83xKQWGaqMjXH+P0ywwtcEKAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555585; c=relaxed/simple;
	bh=iboJ0KlMSWJGY+VsG4+b/czJxm0Le+jeHStxvFchug8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1YNavgYEtZb1P/D2xesXEp27t1gzlgX0+8VZ6Lx0hd35mMdArSl8cUO2WlIKDeJfC8GkjSjfMa9GOu8C4MwVhxNGXU/f2oadk4hhhUFXePREWELR5eGMvktvbqKs2BkECG7INeohh/3Dwxp81wo3QJQBqB/RqK1MWq0nbTmd9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFQDyUm/; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5562838ce68so22052e87.2;
        Thu, 03 Jul 2025 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751555582; x=1752160382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSM5+fYnMtOsm8GdwVjstZSV2NM3rH5RSvo+XZzua+E=;
        b=bFQDyUm/6JeBXkdpFozvJ2Nr3IntK44oTUUMpbklH/dE8XCmcYufpBNSAyBchBzrw7
         vda/N7bWDzp8JCT3zUF5h6wwDaG9rmN8UW/1QbNmDnAPjlMnZlRX6TtrZyayd7VAePVH
         k8tD8NKpUNfNotG+Jb3wAbS8urSuy3XoCWybqXdNkDFKofyTUkshje1pDBENzrgRPexU
         sUNlFQCvB6bVh27DqrbNq3xBlaLgmsN53IGWnEtetf4kNKK6cUIIaW14dVuOy7sXNx/g
         aZ/0OW7tR1YAQ9AQynOOa4taJAmsQ3WIPUtBoG4xXb3EnWHyysJZlentdIMSg5dU2WEi
         8foQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751555582; x=1752160382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSM5+fYnMtOsm8GdwVjstZSV2NM3rH5RSvo+XZzua+E=;
        b=t0ZaC31ce7dY0PZq++Em6khXtWZo6UgsGkS1YoPe44XocpeT8X7uW7q0vQsl5TaEro
         VRRwSlHs/dSgF/YofcU8cFWN3ArJp+xInebQRJfJzDltJw5A/St1jLRmdzaQin+jdoYr
         OGCQQW5G/FOMAi/YefFhuURi810tx+YsBe+pVo7lgKymyyolv6P+P4cDzHwo7Rm+YjE5
         HXFUFn7pr2043rPIGlymIERPvJqrb8fVIG4bLhdMPzJBMmqXr0s6DrFohd0Vlk8TETCD
         ZNi18gczo9ZxOOGDpZjUAbz6CfFb2UW1Pr9eBF3M5j61VBc/UhhqAOHVDICQuPkmYi7r
         BKCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkbzgq2NT6fbOndr5IA24UFvGbKstVz8Yec7DZsSXVksZASlFrHnQ/Oil6m4dVfdMvVkc8Yg+TbK0=@vger.kernel.org, AJvYcCUrTEIhFz3UAzZo5xRljnM4HzyWtoIjgYa4M3DFTG21O1nvVjcqbi53pQ01jUHoB783MmRfUbLb9ZTY@vger.kernel.org, AJvYcCWq09WOeoDluV0+eYubN5ncBmGHs5oDFzee79lmQJhyXMvj8nFIobGHuGXi+M4zqi/6zCV5XY4NQrZ8svfc@vger.kernel.org
X-Gm-Message-State: AOJu0YwJqGfEYC4M9AH0Vl35BA7g7EJtw9l5JBlgJndYDDyd04Pl8DR2
	Nd1NSIMxiX9x1UZ0ytz3oqpSX7RGrpE5Ky1tNUgq0XgPKbAxOF41V/ef
X-Gm-Gg: ASbGncvQg8/XNjClzNMlXsLylFT6CXr0eeCshZ85j1KCGZy2yPA4RiX7zVJjgyaOMNr
	P4yN1xaNgKz+ErYPaP8GjZbDT0fWrWMjCBl1/lvPD+NlNYzq8xFwARLbJEmWoOsG5KQa9iUPSkp
	yZ2yXgktSpNpURPSjo3PW+VK3dOGWRh6KWzI+x28eBCltpoP/Hn3kXeZUsnPPZF5Jhzzjwi+YTd
	MuM6MieeGOmc4lbt1HDqeXnJE9jgoluxJy5sp+h0iNBKHKXTamTGOQczV2Z445KO5o9bgdyJNqS
	3uoCT5qupYeGmyNGPFzb14CKg5TaEiRQfmDKPhjHjVe0ghQ4Jequ0t60NUQy8QT6kO+rsag=
X-Google-Smtp-Source: AGHT+IHcwagZ0bz8urHkgSxiQduhEhToNj/qwjiDIvUuGgoplh+L+oS4JKl6ajnw+KxoaxGfavI79w==
X-Received: by 2002:a05:6512:1390:b0:553:252f:adf3 with SMTP id 2adb3069b0e04-5562ee3f0e3mr1589090e87.16.1751555581341;
        Thu, 03 Jul 2025 08:13:01 -0700 (PDT)
Received: from localhost.localdomain ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384ae15esm725e87.178.2025.07.03.08.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 08:13:00 -0700 (PDT)
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
Subject: [PATCH v2 3/8] thermal/drivers/sun8i: add gpadc clock
Date: Thu,  3 Jul 2025 23:11:27 +0800
Message-ID: <20250703151132.2642378-4-iuncuim@gmail.com>
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

Some processors (e.g. Allwinner A523) require GPADC clocking activation for
temperature sensors to work. So let's add support for enabling it.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 226747906..45aaf5348 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -66,8 +66,9 @@ struct tsensor {
 };
 
 struct ths_thermal_chip {
-	bool            has_mod_clk;
-	bool            has_bus_clk_reset;
+	bool		has_gpadc_clk;
+	bool		has_mod_clk;
+	bool		has_bus_clk_reset;
 	bool		needs_sram;
 	int		sensor_num;
 	int		offset;
@@ -89,7 +90,8 @@ struct ths_device {
 	struct regmap_field			*sram_regmap_field;
 	struct reset_control			*reset;
 	struct clk				*bus_clk;
-	struct clk                              *mod_clk;
+	struct clk				*mod_clk;
+	struct clk				*gpadc_clk;
 	struct tsensor				sensor[MAX_SENSOR_NUM];
 };
 
@@ -417,6 +419,12 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 	if (ret)
 		return ret;
 
+	if (tmdev->chip->has_gpadc_clk) {
+		tmdev->gpadc_clk = devm_clk_get_enabled(&pdev->dev, "gpadc");
+		if (IS_ERR(tmdev->gpadc_clk))
+			return PTR_ERR(tmdev->gpadc_clk);
+	}
+
 	if (tmdev->chip->needs_sram) {
 		struct regmap *regmap;
 
-- 
2.49.0


