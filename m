Return-Path: <linux-pm+bounces-36816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6335CC08AF0
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 06:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA32B4E8C2A
	for <lists+linux-pm@lfdr.de>; Sat, 25 Oct 2025 04:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252F2274646;
	Sat, 25 Oct 2025 04:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0qv2fnc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FCB262FCB
	for <linux-pm@vger.kernel.org>; Sat, 25 Oct 2025 04:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761366765; cv=none; b=swdO5Tl2SLZ/wz3gH8e1cCBO9HLESGNevxOVmHtCDo7V8qnMctW08EL3/GNCvRl8YreE7vdRS6Ihlth613Hz41yFIIMjts8X0Yq3ysP/2Z+sDiUziPnMW/Ns+xX/w4Ui+QpB37J0YZoDOG+DRYTNKBL5RrtPfKcEoEDoXAw+JKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761366765; c=relaxed/simple;
	bh=JFlSRxXwWBQ3XACpCIXATa+zwXHpyzhtFajoU+nnbIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1Wxk7neqI5R93q/dttmk0sMiyBJiwd2BL19oZaxxYNBbVLkPux3whEO//USMqGSG1xzs9idVXKNkAD01NLG14c36CmVL9Bi+/J94vpJdjq9El1Bhizkw0bsI5qDK9pYeDZjNzl348iy9U6GIzClCeGHQn46ovdeHM7bXwRK4OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0qv2fnc; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-36bf096b092so28391751fa.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 21:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761366761; x=1761971561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3+BmyLOtp7xUTMRQtQMY1TWwM+wvGI7ScMcGnjI6fc=;
        b=d0qv2fncNLrQWksm/Kj+aDzfPcFi280b/vHBqmfbPUYAPe9VIHu5mFSd1EnS6qX50A
         bs09pYFYEWVUvj5VtpQzthJUcX4JvPzxQhdc/TBgTZJAXlCajzzZTae6v38fn6JlYcfE
         o2IbEM19U86R1Jp+cECN/C5YpkIfxc/adSehpNUhVTTqezDgsFv5oUTsF2Q8OJIL2CGy
         eEgFHfN/exVu2ahSsDgSBuLIx82sFDXouAsZEYbSkQ0K8oVK9LI72CYEJr8EOlkhnYx/
         e356HZkn09YG0vnHTDnAudvLEZgpTfGS2LG5zTy45NTfu6Wy/vjKwk04ZswuJmjhQd/Q
         cTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761366761; x=1761971561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3+BmyLOtp7xUTMRQtQMY1TWwM+wvGI7ScMcGnjI6fc=;
        b=miZ2l26Vvyfl7bYjuhETOij1Llazez8BcH+DZAFquxhemS1TJT7FRKY6u7DfH3RAL0
         slHr5nS+eDvrWWtO3Lw26+U++ZVNlDY+vp8cozQQCPwGLeAAjZK/6nAKRTe6kIOLBcq1
         SA7o6HNYFymhp5gX38p0GRD5+UL41vZDVXK9SXI/Zd4ppMbsiKcLkeuYJndnKmoYJ0QA
         zgWC+LiDgGDSuD+pdWPcVO8gQKZoAUpJGzYzEdD8Vpm8n5xtQecsUJ9cJdbfhLDg14Oh
         gsAmbRYZBhRIu8PAN8MRy4tY278okISn4ktlqdzJIcTHdMF52+7PbzI+rOWwcaVz08np
         2nvg==
X-Forwarded-Encrypted: i=1; AJvYcCUEAyRjAzmDzm0W2Uln+3H822bFmbgjNL44fwmX42uMxkodZZy7Vp33/eJ924NMffRXp6hSWE5jwg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7eW+9swgINHa8+M+yr57ZMTJnzjFkAkPWBpBbuQFMaFs7wL71
	V5pvOSHbg1P0GY8tR6Pe97RsKPGAmj0p7tONrt6o8D61xxNTkE/P8DLR
X-Gm-Gg: ASbGnctRUxVFZvcCt2O3g4+MatMGn3bMnbYI+uisPpNVnTuQoJB08Em8uV5jW02b28e
	1/5Z+FFaH2BF2XdF3z/u5b0wIQCPJoum8HJ2jXs1UmSpFIUoRrFbjsxtMbq1UiGbh/pHPVehm7u
	COUyVZ3TLgWHG2nIHKwXYROne0QEUdTETAZQGZxiHEK42eMIiPTzdG+A3MjmUn0Yu9bYnpjziBP
	wV4z4OjHjb/RkvVRAQp0L5jg+uA+s1sDNy1vF07AjE+4cm2+4gUBrs7755sQ/l39KFWAnb5QBj0
	26tbJrx4oDnzzK8+tQPM+PH5OXfYKJXBvtRJRj/DPgPLyomU435YGxa5OgFIrFEW8gQhZtdzDDe
	i7twa/bCSl2/khasFQAw8ar4NUeixGbgPiJicMHrmrDLaDE6oska8qlQcD46i/M5DOg==
X-Google-Smtp-Source: AGHT+IEKvrwo7BMcvdLr8sMnPaVHb2OI/tgnv1kSKzQDgd1sc7jso2BrG2SWkbje2QobtPqCs0yKQw==
X-Received: by 2002:a2e:bd17:0:b0:36c:2367:b3c1 with SMTP id 38308e7fff4ca-37797a58f18mr88205231fa.35.1761366760931;
        Fri, 24 Oct 2025 21:32:40 -0700 (PDT)
Received: from junAIR ([176.106.241.81])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0ca7a0sm3409241fa.33.2025.10.24.21.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 21:32:40 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] thermal/drivers/sun8i: replace devm_reset_control_get  to devm_reset_control_get_shared_deasserted
Date: Sat, 25 Oct 2025 12:31:26 +0800
Message-ID: <20251025043129.160454-4-iuncuim@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025043129.160454-1-iuncuim@gmail.com>
References: <20251025043129.160454-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

The A523 processor has two temperature controllers, but they share a
common reset line. Make it shared with the shared variant of
devm_reset_control_get(), and also simplify the driver by switching to
devm_reset_control_get_shared_deasserted().

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/thermal/sun8i_thermal.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index c02c398b0..aa496e1ba 100644
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
2.51.0


