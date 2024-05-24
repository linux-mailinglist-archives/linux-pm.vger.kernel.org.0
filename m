Return-Path: <linux-pm+bounces-8110-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681388CE71C
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 16:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230FA28257C
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 14:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C83012DD8E;
	Fri, 24 May 2024 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZCKTf9DP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7879212D759
	for <linux-pm@vger.kernel.org>; Fri, 24 May 2024 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716561126; cv=none; b=N6Gu0BoQLqOaziexAi/GU6xguMuVdDW2Pmd6kOvYcilBm3ld8Z/Qp2NSTRGNJv32d0OgxI5BA9bT/0k1s1Z3o5n6T9Jc+XkRW2fQA95b/0aZradGM0/hHExBWML8MSVQSL24B7aL+JVJ01XKXU4OO+3csPwi9ynUPhBZ0IfrhQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716561126; c=relaxed/simple;
	bh=7yX2hQotDIGtiorXI3z/x7bEre3XpPfBoX/iqy4G0gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKZOWjRzWkEg5Ty2vO93Pq7i9abuK3sdkNgUge43l1gvfWrriJKy4lqG/FdNdMtgf4zc75gOCJAjkQ1MOyFLqagGbvr5UwThQUpyUproG6hyZX8/NrqKcAABgJToPyyUF4i+P1aLAA6bJt/az6F/FThJHn01OSlRJ5k/rpxj4CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZCKTf9DP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-351b683f2d8so2717924f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 24 May 2024 07:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716561123; x=1717165923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKYQwwXxPgEaUkNb+P0Yo4hvRZxOOz/or0QP5Vm2gcw=;
        b=ZCKTf9DPabArzgp2W3CYxbiW9NJZMq16CHpE42GV+OM2Ljm5rj+oVjv4IGWz3IwEMN
         ExV67TxHZ2vRoY0v1kATZ3WRu86eMgkeGK6xRaVXWUvIjqrj86FrvcArfrHDqB1nZA2q
         kLYXSxNvsRjQL1yUE/TYnWE1uLmCuw8JtmplcskKnz1SHeTVJaBGBz8di0Sm4En2945u
         1NesexzN/NRQgSz9lO5lybbP/IeSi98AtVL1tbQOHq9UZSjVoVSw1j0WYTTvV1Es3jWf
         WgZZOBEtj2ng4P53og3tOXbqKCxnGNbyiFctz41R3d9fqe/xjESyrBkhMjG8pkyGWEPm
         08xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716561123; x=1717165923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKYQwwXxPgEaUkNb+P0Yo4hvRZxOOz/or0QP5Vm2gcw=;
        b=S5la5Yx6eHG1j9cHB/dvAXgzeutbsfCd45zrzpqNqcSIV7C9ojIu3lu34fkxGFasRw
         qvqrW65bE/yF3Qe/B35B9aipgXnNIe31FSKXFPRWdWq0k+xngogPn4QD9NYcsAQD/eQz
         PSpjZXvSXjtfUafF0LnP7ng0PL1YOt948/aByVsJbCYyjpHxoFa/e5Bis+JWWr1y7T6P
         HMqgnU5LAb3VPbuk/F3dWSmyHxZ7JSF10X5I6M90XRTV9aBfZbScpSkIVnCNMX36bekg
         M7ha/ff8S9iMwNMfzpdkkO74MfWfMmQR6/5BbkcYOaciu2IjeIeFmHo5T0AzjTogwMbM
         Ls7w==
X-Forwarded-Encrypted: i=1; AJvYcCWxpeI/aYy67kBpVSYvnBwzxDl4uzALHWZEcQp3wCm2WFhG1yQhbOj6mh2o/TokK1DkwkCmg0KXmVr+bC5zgxbR9xN5n86Ajq4=
X-Gm-Message-State: AOJu0YyVxYWqLFC+FwLbabq0tBX+S4ImV/UVH+Pg1BwNsRa3UeVqEDSM
	ovujaLtlQpcVHmP8s1BBm3804SBO9FQkcRd+uBGDzhstk6wFL3+s9sFbv9IJZhI=
X-Google-Smtp-Source: AGHT+IFMZIFVZcP6PbiZYFp88cxLXoWz0ATJDVN52IQI0qhWieGFreYqoFMkNFKwtIZqf1dIqdbp3g==
X-Received: by 2002:a5d:53d2:0:b0:34d:9d2c:d9e2 with SMTP id ffacd0b85a97d-3552fdf269amr1793217f8f.53.1716561122768;
        Fri, 24 May 2024 07:32:02 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a090c2bsm1719611f8f.59.2024.05.24.07.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:32:01 -0700 (PDT)
From: Alexandre Bailon <abailon@baylibre.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v3 5/6] thermal: of: Parse aggregation property to select the aggegration type
Date: Fri, 24 May 2024 16:31:49 +0200
Message-ID: <20240524143150.610949-6-abailon@baylibre.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240524143150.610949-1-abailon@baylibre.com>
References: <20240524143150.610949-1-abailon@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This updates the driver to parse the aggegration property in DT.
This allows selecting the aggregation function to apply for multi
sensors thermal zone.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/thermal/thermal_of.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 75e3cfb8488a..21c81dc91a41 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -533,6 +533,33 @@ static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
 	thermal_zone_device_unregister(tz);
 }
 
+static const char * const aggr_types[] = {
+	[THERMAL_AGGR_AVG]	= "avg",
+	[THERMAL_AGGR_MAX]	= "max",
+};
+
+static int thermal_of_multi_sensor_get_type(struct device_node *np,
+					    enum thermal_aggregation_type *type)
+{
+	const char *t;
+	int err, i;
+
+	err = of_property_read_string(np, "aggregation", &t);
+	if (err < 0) {
+		*type = THERMAL_AGGR_AVG;
+		return 0;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(aggr_types); i++) {
+		if (!strcasecmp(t, aggr_types[i])) {
+			*type = i;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 static int thermal_of_multi_sensor_validate_coeff(struct device_node *sensor, int id,
 						  struct device_node *tz_np)
 {
@@ -606,6 +633,7 @@ thermal_of_register_multi_tz(struct device_node *sensor, int id, struct device_n
 			     int polling_delay)
 {
 	struct thermal_zone_device *multi_tz, *tz;
+	enum thermal_aggregation_type aggr_type;
 	char name[THERMAL_NAME_LENGTH];
 	u32 coeff;
 	int ret;
@@ -614,6 +642,10 @@ thermal_of_register_multi_tz(struct device_node *sensor, int id, struct device_n
 	if (!multi_tz) {
 		struct thermal_zone_device_ops *multi_ops;
 
+		ret = thermal_of_multi_sensor_get_type(np, &aggr_type);
+		if (ret)
+			return ERR_PTR(ret);
+
 		ret = thermal_of_multi_sensor_validate_coeff(sensor, id, np);
 		if (ret)
 			return ERR_PTR(ret);
-- 
2.44.1


