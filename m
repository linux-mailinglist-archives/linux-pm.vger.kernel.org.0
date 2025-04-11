Return-Path: <linux-pm+bounces-25193-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 105C1A8509D
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 02:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6443C3BDE36
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 00:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B865C96;
	Fri, 11 Apr 2025 00:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmKyogul"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD34CDDC3;
	Fri, 11 Apr 2025 00:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744331970; cv=none; b=BP2p1WY9GZ22nSOWT8jiDYZKAO9H8Q8kbWEqpfH5VNW9JsMolDTEM7C9ZACXLqLDQ63ukmaXSCjjkVpHemYxGubaF5554sWg6/ncaZg7pUVALGtmW2slpGYRLXodyfbbrEb/DNgZYQDnqHuuDbi/GoApSc6ptG3weUpYlki98CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744331970; c=relaxed/simple;
	bh=4drhvRp1v2mp/1rw3RlittyMG3A82PQwVLHy+wmOHKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIyt+ImgHwG7DNNG3w8PDtmNX1TusRyspjaGJptb+BD2Npb0lmIHtaki3IkLAteUk1rCDrq/Ghs7nNKbw3J20E2X6TNj/ezr7k9NycYcCuK8v3VPa+NVeHb+2gKuzrpcbRyI+je/Oc/V08ggL33VXI8ncaUDEx3YlrCMzMxkO+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmKyogul; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30c2d427194so13622561fa.0;
        Thu, 10 Apr 2025 17:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744331967; x=1744936767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgLz+wxMK3cB0CjJ97zDR/iMoodve9Fd9p0FjX989r0=;
        b=JmKyogulJ6TkMf3PKjeSQc2fj0WZ4EokmeuHpH4SZLAcUio/JLti2WMMI9XYSul7mc
         W/h65i7/8cJySo28Whrt6BtnouD/+S1GoN7hD57YHrZ5/9qOmJ0ag82GxdI7OfHIPttV
         QOaDHf4gSyGK54gQC7tZxn19znFDcDdihmJzfHxRud6s6Z+HV5q2L1A1jVOxtMdjlCV4
         qDBO/weJ8YRXYNUAHVSw/7htWipI7zQh4MMiHDURYrvsR/P479F11E2xmsceJQ41wUQU
         L934zFBAle2N8EZz7UiexhT9CtMgFGeH+oLuNBTnwrO8Eq8mWAOuJ4T1veWGlKkeC358
         C1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744331967; x=1744936767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgLz+wxMK3cB0CjJ97zDR/iMoodve9Fd9p0FjX989r0=;
        b=R/gQGIVNC1YH98LczFg64BDG3xJGp7uBe5tEGdfHMNgAYahK+B1mCzbJLdZyFOZYDu
         l+mhoeHxJsmHAXCwdh2jzP1923bKGq0Tcg0e2Ow0DxpiKiVujZyqiWDQzD5kNIj7Vlkc
         6S7O13ElynXXyAPJQHUPrtLnFW6Hpzipsd1EKpAGcNQ6ol3oISgGsJdSlkdB1W7hA4tY
         kMA9nNUyhDb74adCBUS9F+48NEU53Daz2ac389S4nQ1SI21E1f4S4es7An3ctvuw/yyy
         brDXp/pypzuKFYKSDIzxSXuP4K/qOF+ysqqRvQfFJP2svVmYdQ5NjtBueNDt/uyboORT
         dEtA==
X-Forwarded-Encrypted: i=1; AJvYcCVL0bdTMtpwPpJDgNcG3apaQ6lqoKEd7z34GZoFYEwZVMQj9+Vs9pWVyYsL18QshvOVwoRxbjYHJ3E=@vger.kernel.org, AJvYcCWVzEsXYe59c4vrTbhQF1XhfGIH1KR6hAvhI63kbyxtm/dZlHoO2wP+rpy62VRDxm/BSBuSf7Qe5Vcq@vger.kernel.org, AJvYcCWuIzdCkd0FS6Bo+67yO67qs/fUEI7u1Yrdtg0RkIFty7HnRPCJVRG078Kl94T/q3SA4VCleJrW73kVklne@vger.kernel.org
X-Gm-Message-State: AOJu0YzctInb94qeflj3k/s+JAj72bCT2ASfTl9zo0nFDWcmdI0ZRiK6
	P1hwCOt8pBIKXN1K9/gwIIqrd9tUrXqmcNfV750uiwSFgnAyO6pM
X-Gm-Gg: ASbGncuEmMT6kFyftMmxZkPqNlsIXafnE+ksv1M1GP0u6vwfecCmUVlSluWVmpzn/YK
	qHbetLMNXkWzxvgrq0hd4ugLgFZVSfXrAtB6gXWuJJIlQclFRdONa5CAVTb4PcFEzrGUriaAUas
	MyNhTQ/bZGnXkL0F5Ny10btANGmyc1JV/Y9y0dCSyre9gJNKlrng6BRUftIUAeOayLgVsIC0rhl
	V89m8lHKpGBJ8KXUg82FYU4QATjd+KflezYd95kW0NVPTWtL7kuX9AcrUXAyP8GcgsRLH3Y8iZ8
	Qiu4eJnABE7F9mXpGBBPh06sL3Hnuv3ISDyYIqi9KV5QyslE0PVjGsO5xAle
X-Google-Smtp-Source: AGHT+IFsLLiiBQI5ZLGY7lfwqEqas7w6lvcmymmKeoSRpIy/66PmWCqCbglM7RpgOnvLMZAozSYyIg==
X-Received: by 2002:a05:651c:905:b0:30b:ecfc:78bf with SMTP id 38308e7fff4ca-310499d40fdmr2095651fa.5.1744331966765;
        Thu, 10 Apr 2025 17:39:26 -0700 (PDT)
Received: from localhost.localdomain ([176.106.241.81])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f464ea5c6sm6344251fa.62.2025.04.10.17.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 17:39:26 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Subject: [PATCH 1/6] thermal/drivers/sun8i: add gpadc clock
Date: Fri, 11 Apr 2025 08:38:21 +0800
Message-ID: <20250411003827.782544-2-iuncuim@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411003827.782544-1-iuncuim@gmail.com>
References: <20250411003827.782544-1-iuncuim@gmail.com>
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
 drivers/thermal/sun8i_thermal.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 226747906..1f3908a60 100644
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
 
@@ -417,6 +419,16 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 	if (ret)
 		return ret;
 
+	if (tmdev->chip->has_gpadc_clk) {
+		tmdev->gpadc_clk = devm_clk_get_enabled(&pdev->dev, "gpadc");
+		if (IS_ERR(tmdev->gpadc_clk))
+			return PTR_ERR(tmdev->gpadc_clk);
+	}
+
+	ret = clk_prepare_enable(tmdev->gpadc_clk);
+	if (ret)
+		return ret;
+
 	if (tmdev->chip->needs_sram) {
 		struct regmap *regmap;
 
-- 
2.49.0


