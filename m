Return-Path: <linux-pm+bounces-8096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA298CE2E7
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 11:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D6F2830E1
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 09:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CD712AAD6;
	Fri, 24 May 2024 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y4H1Z7hB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7535127E2A
	for <linux-pm@vger.kernel.org>; Fri, 24 May 2024 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541489; cv=none; b=FMjDJvlg1a/dWWYWruWBd1m6S2fsxOFHndDdrlbXpy1CwS2ksPRW4YjFAnyHbU4qOB3QP7Ph/IrX+I7WT1pqjdoUXHrRU9zky9rDrqK+37pi00C4TVik2jIHcdPPQ69AmPKNIJxSAbVLa0h25hAD0OiJH30DAR2WwaLLFcrNJyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541489; c=relaxed/simple;
	bh=qOE+NwNH35rMZqPs630S3yw6fUABDjCAXs0E4TU/Lto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G3zb3TzIq7hyPj2gqdqOAvQEpKeACed0LfvietDc57Cyx2PGQ1N58hnz47Y1+JZ+o/SjZoX4KrXIzEATUu64IqIW/dhWVEUcJi2zN/mSEY3gtRNqtxEKR+n/RUpKiqY1Br7+G8vnZz1oxA4eX3zGmv/c5T4t+o9AU3HNgJCcWfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=y4H1Z7hB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4202ca70318so60088475e9.1
        for <linux-pm@vger.kernel.org>; Fri, 24 May 2024 02:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716541485; x=1717146285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5J/C+IDybR4omqOS9SfWx1Ek6B9bW0Uauk6Wgutzds=;
        b=y4H1Z7hBUr8irdDF4WBCPuU9I6MSp9/2UHm10V9v3Xe8w5WSFnYCEdVxX3BaqbJch2
         a9ad7aJ+O5D4Vg5xqc3zp54tw7NfpFchP/CTc7QD2z74vqclpptgDdOdxx/wReoToNUk
         91nsKjgW0rL9WniY1+OFIXY1H/GFEYScTP54O1ObY1dF1iomHGG1H/zr1khWocil2jeG
         +U2y37/sPKnHpKKpk3xrVmR+zbyLu7BXyAZ4AGZTBRgKQESrtbSr+KJQpenlek7wbGZ4
         gC93KIqkV9hRsWWPRgFIT5bBYncXrNrpV2EOWIxMxAhIOpv/vFchyMiGvsUL9CVwwgxV
         Ci1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716541485; x=1717146285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5J/C+IDybR4omqOS9SfWx1Ek6B9bW0Uauk6Wgutzds=;
        b=LURpQyLpr0HKpXllTQGEKdGejVRrxyB6/EcdrhKd6MICKmpjzfnGjI4yZ+xOlKEr5T
         5u7gP9vnM6CdN0tfoEQQUD3/PsLhz6YOXJF2Luw72joFLXIKckManXFTBNnSNQgWWMkg
         ICoHGZfiZGhVarlX1k5U7o9fQ7gzxYwxvJa11XUna4fLaNW3RxglmoEzLfs8vL0wQ0vu
         i0jcdVCWkig1b7Ui9qC3LXWIr/yr6QnKcYthpouQWGX4PSZWTqU0R9FRez1EZHtVxr6J
         DvIpp730CnDp6Fu+ckJxLAGhjwHp8VeUbzpftt/zMojTOnBRbuXA1BhsrydjupwALyJT
         drIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7bzI3U+N7ETm+IXpS9JIBYFXHjmgXuXhELyL6TS66LFadnI6FF7sTAOz22qbJQw8PO9v6xGtkvTfkFeLR1rHALmrUhmpFabc=
X-Gm-Message-State: AOJu0YzAhX0g0oltBin1kXC72GJqKOLlGQb7bYeFLGuJY2ZbCg0hgX8T
	WFISBt+a4EtUrW58FT26job0Unw3K9UeOWJEpNGAllpMPAa45Mzb2yyxikHppH8=
X-Google-Smtp-Source: AGHT+IHUDDoW9rQJTdAgLqeGcCRmeKf1PaVW4qpC2XoxgoR1WBGP9ozRpfaWZIwylY04deonHSWDDg==
X-Received: by 2002:a05:600c:19ca:b0:41a:3b7e:2235 with SMTP id 5b1f17b1804b1-421089b1b42mr12560065e9.5.1716541485147;
        Fri, 24 May 2024 02:04:45 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f163a8sm47273045e9.13.2024.05.24.02.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:04:44 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Fri, 24 May 2024 11:04:35 +0200
Subject: [PATCH v5 2/6] thermal/drivers/mediatek/lvts_thermal: Use renamed
 thermal zone definitions for MT8186 and MT8188
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-mtk-thermal-mt818x-dtsi-v5-2-56f8579820e7@baylibre.com>
References: <20240524-mtk-thermal-mt818x-dtsi-v5-0-56f8579820e7@baylibre.com>
In-Reply-To: <20240524-mtk-thermal-mt818x-dtsi-v5-0-56f8579820e7@baylibre.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716541478; l=1639;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=qOE+NwNH35rMZqPs630S3yw6fUABDjCAXs0E4TU/Lto=;
 b=rwZi7ol8l4OofuhfkYL6KEqAIXdExwo2d+8HZov5y+dHbOYu64V5flumGoI5gw4dW+mdzQGtM
 FSxO+nrBjttB8WDBGhUChWjc+R9hv8Vp/Oe7chcgm12gNpeN7Szpxay
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

Use thermal zone names that make more sense.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 0bb3a495b56e..89fb92666b81 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1436,7 +1436,7 @@ static const struct lvts_ctrl_data mt8186_lvts_data_ctrl[] = {
 			  .cal_offsets = { 29, 30, 31 } },
 			{ .dt_id = MT8186_ADSP,
 			  .cal_offsets = { 34, 35, 28 } },
-			{ .dt_id = MT8186_MFG,
+			{ .dt_id = MT8186_GPU,
 			  .cal_offsets = { 39, 32, 33 } }
 		},
 		VALID_SENSOR_MAP(1, 1, 1, 0),
@@ -1487,11 +1487,11 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
 	},
 	{
 		.lvts_sensor = {
-			{ .dt_id = MT8188_AP_GPU1,
+			{ .dt_id = MT8188_AP_GPU0,
 			  .cal_offsets = { 43, 44, 45 } },
-			{ .dt_id = MT8188_AP_GPU2,
+			{ .dt_id = MT8188_AP_GPU1,
 			  .cal_offsets = { 46, 47, 48 } },
-			{ .dt_id = MT8188_AP_SOC1,
+			{ .dt_id = MT8188_AP_ADSP,
 			  .cal_offsets = { 49, 50, 51 } },
 		},
 		VALID_SENSOR_MAP(1, 1, 1, 0),
@@ -1500,9 +1500,9 @@ static const struct lvts_ctrl_data mt8188_lvts_ap_data_ctrl[] = {
 	},
 	{
 		.lvts_sensor = {
-			{ .dt_id = MT8188_AP_SOC2,
+			{ .dt_id = MT8188_AP_VDO,
 			  .cal_offsets = { 52, 53, 54 } },
-			{ .dt_id = MT8188_AP_SOC3,
+			{ .dt_id = MT8188_AP_INFRA,
 			  .cal_offsets = { 55, 56, 57 } },
 		},
 		VALID_SENSOR_MAP(1, 1, 0, 0),

-- 
2.37.3


