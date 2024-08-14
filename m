Return-Path: <linux-pm+bounces-12226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3489952300
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 21:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E2A1C21F4D
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 19:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B16A1C2320;
	Wed, 14 Aug 2024 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tBxC7puM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768C31C0DC7
	for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665514; cv=none; b=X8jgzpp/Ga9FQkAUuhLO+mId4Pc7fqE4gAWNFYjrG1LJESDgw3spl/0pFWi7lJT/sqKhzeY2ko2J9LG1va9wmXRmLy/FNK2lcjz0JPIWwTjYd1kw70srfCM1P0ZKTnqipk6T+JHzH8wDeidNhSlx8wxp7gAo6SWGLDWNwT3bBQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665514; c=relaxed/simple;
	bh=mMyEb0aqCda54qwh073Rn7++7QwzrUQlVi0xlbd0UY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tC4XdYJzi4MMEcEnHrwrX6JZ+DdopxHweNX6i+huPNgRUJOU/VYwiqx72tqK8DCf2dsp7kFvS5dnKlmEJ/Lb+dvUlammFTq5tTVgzp3LPMI/rRMK9JelLMVVpn3n4p0U9AGchKvTq/fTlL6mzk319Unk8YFvHzRXzD6Cs6aNGdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tBxC7puM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so954755e9.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723665511; x=1724270311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+R8NVOLOXBT5QSEMY/JOLRg5p8mbpf+sRpuYCIgm3Y=;
        b=tBxC7puMlYOz8w2NNpp9C87Gsbku3Mdq0tyD2HlAmMYYlP637LtAxLzTz+iDAPLNEw
         ACf20Ts84Pv6Rh+9JhFCmT881YFCKcTqvTqMrdMpJTt6G+j839buwMlYu08GAKCB7pct
         pt/ssg9aLYPbtwI710WOzfbvuAtPvNizIMXNraJVxOmOL8pVJApwquxSssFKm6e4gney
         G1p6nzgfdJjoM9ll0hBdF4yowPCUY3p+ZKb8pQ+OkntysvybmHuLA8CTkxAHv8QozEkX
         1x0z8vZDTizs4LWrK19rLXnTMJPuvdbOi1C/rlgaAPtgh1ykxmjCaCVeu3wtZGNzjPsA
         +MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723665511; x=1724270311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+R8NVOLOXBT5QSEMY/JOLRg5p8mbpf+sRpuYCIgm3Y=;
        b=P6SaHO90Y1ZO/1IlmR2u7tvYuG43vsasF8CreXCd2G7snMPqv8sauQAF7h5eVld9EP
         a7EE7sf1yev5cfSq86fL7GqG6meKs6FCBLE5CkfOCNi55KRxMBJD7AvWXahNHG2hQuWy
         uIzczDdF5KFLQbvfBjDCc94L7X+AW8bdaslN59iTBjn7w+4kDyceqr6k6iHaAKvlSquc
         bRfKkOIE8koAY8p5zhpikayUX+EKU9Pf4ypwWiTQilCfM5eH2zv/2V/F4hX4rd0nPBO9
         YrbbQVhm+cIm+dV6xO3DgHdlfVhkEwKcFD+5dauqZxf5ZFmsmaYmObZwW3esylmpCI+T
         r+Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXRQELoynrJz4Dhwu8Knfhn7Jq1fCiJLvvOFxEkuwmdan7WCzeGXhI+acRyVsuJN+VO7rGdMjHEEJ+caAdS4BTEhOO5ITyDXpY=
X-Gm-Message-State: AOJu0YxUoG4iDNxLLvVjXxRml4iqTdgneffr8uO09RxzZaFcRQUYlAFy
	JdiEL2pMzddcnORFrwCDH0ao8WKlWi7OahGIhxzjeNuT5K1DbIMtrfwByTgK1w4=
X-Google-Smtp-Source: AGHT+IF7/aGVxXhF2RySsqAiYYS1dDcsua5Tgb5FyRD6ODYvExfEBCQAP8YxA2bFkOZsnio1gLRMdw==
X-Received: by 2002:adf:ef0b:0:b0:367:8a3b:2098 with SMTP id ffacd0b85a97d-37177768eb3mr2492404f8f.3.1723665510787;
        Wed, 14 Aug 2024 12:58:30 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfeef76sm13482263f8f.59.2024.08.14.12.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 12:58:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] thermal: of: Fix OF node leak in of_thermal_zone_find() error paths
Date: Wed, 14 Aug 2024 21:58:23 +0200
Message-ID: <20240814195823.437597-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
References: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Terminating for_each_available_child_of_node() loop requires dropping OF
node reference, so bailing out on errors misses this.  Solve the OF node
reference leak with scoped for_each_available_child_of_node_scoped().

Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/thermal_of.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index b08a9b64718d..1f252692815a 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -184,14 +184,14 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 	 * Search for each thermal zone, a defined sensor
 	 * corresponding to the one passed as parameter
 	 */
-	for_each_available_child_of_node(np, tz) {
+	for_each_available_child_of_node_scoped(np, child) {
 
 		int count, i;
 
-		count = of_count_phandle_with_args(tz, "thermal-sensors",
+		count = of_count_phandle_with_args(child, "thermal-sensors",
 						   "#thermal-sensor-cells");
 		if (count <= 0) {
-			pr_err("%pOFn: missing thermal sensor\n", tz);
+			pr_err("%pOFn: missing thermal sensor\n", child);
 			tz = ERR_PTR(-EINVAL);
 			goto out;
 		}
@@ -200,18 +200,19 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 
 			int ret;
 
-			ret = of_parse_phandle_with_args(tz, "thermal-sensors",
+			ret = of_parse_phandle_with_args(child, "thermal-sensors",
 							 "#thermal-sensor-cells",
 							 i, &sensor_specs);
 			if (ret < 0) {
-				pr_err("%pOFn: Failed to read thermal-sensors cells: %d\n", tz, ret);
+				pr_err("%pOFn: Failed to read thermal-sensors cells: %d\n", child, ret);
 				tz = ERR_PTR(ret);
 				goto out;
 			}
 
 			if ((sensor == sensor_specs.np) && id == (sensor_specs.args_count ?
 								  sensor_specs.args[0] : 0)) {
-				pr_debug("sensor %pOFn id=%d belongs to %pOFn\n", sensor, id, tz);
+				pr_debug("sensor %pOFn id=%d belongs to %pOFn\n", sensor, id, child);
+				tz = no_free_ptr(child);
 				goto out;
 			}
 		}
-- 
2.43.0


