Return-Path: <linux-pm+bounces-19150-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7783E9EFC0A
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 20:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7E4188C456
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 19:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA7F198A01;
	Thu, 12 Dec 2024 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lfo7eVSg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E5D189BBB
	for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734030466; cv=none; b=VwHrrP3DzrNej12kNtEFQDCbDCkFhaDbsyVE3o9mvAV9MjRZvZ6+CBulxbyTOlaVhAqyFC7kBB16o068wvcIqsujSHdWQcLBUZ4BCIM9RsQltNNsed5/4sIfCGnCspWvV4aHTAXuSn51hCDuYFq+guwUSXjOAUfmQ7/wgh4exd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734030466; c=relaxed/simple;
	bh=T7EmwOm+5QAq3VwZ2pscSRpuN5xU6tNaMs3NfT8sSFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALwOAhjr9XzA3DvQJavsqWCbFzwp7eC/HJJGmzjxFkkmmSf7pwaeHjkaCKZzRBIIMeDA+dlGEjFDxUy0SlQ8+EqjmYc1+TkEIT2/PBGLYRudMBvhhVWHsuvdrrToX+xxWNExRCUa8R0SbakS8Ngry9Kw3KgbaAVajCh5+amCEo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lfo7eVSg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so676387f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 11:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734030462; x=1734635262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GlbsAVW8lCP//800lKz1P/SW6I5QfvrNa4yDeu8gbJA=;
        b=lfo7eVSgaGgorly8dVbXLz99l3P7dJlsgPRS5KvyCaOFAQxAEetsHrUlMUFF12cERz
         CRacdjdwocknMk/gBPR3p3HHJY7gpqgI6Je+PRqbTNi7YNuYDYkw1Ko5AoTby4bg0SiH
         X3+N3Tj8UzcBqvwyrwVw3P3vPk3O2Oc/jrnJzin1Iue4b+eO+6o9SGIAV1fq3MxZVeP7
         hAJGroOwsnm2d4OpnMEx2atChsUy3/gM9aJaCniaw0l5TQ4LhQrnlw+O/lQDx4iWkaG6
         q4KiWNrYaOtnQDV51O7dt1ifqmCh2/hIVhuz6nsQIT3mMQ0wORPTpGoqNhQ4b42llD2g
         CujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734030462; x=1734635262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GlbsAVW8lCP//800lKz1P/SW6I5QfvrNa4yDeu8gbJA=;
        b=kQS9c2HWBaQLP1M9CHMAdvBaFHLmoyulh2fAj59Mv7WEfUU1GWgJpV8Yx2JPAI7LC9
         dwGf8CXKPOXP1W+m74/2ozsb+OgqzCAU+2lcOtydZzGld9mqFc/5C1aXQzB4ADx52qje
         wzrNvoCE+/LhF/o0QDBTUjfTWILX//o4sYVzdhiZ3tWFVtCGAYTWsU/3Gm9HhniKEvVj
         mBnG8RDXawka0dRe5SZOdcmhiMmbbIZMbtYKNBtqZmKXVPTvH9hsYgm7ZH3JU8WJKQLr
         UdbN6LsWuAXol3TsLRxz33IHDmm8LIRHOdMXg2K246jZj380RFJM1/FTHfGNAdY0UD9S
         pzuA==
X-Forwarded-Encrypted: i=1; AJvYcCW2lm/W/2AcL+b/6VRv553IKxEvyGKjJzTHjvqgtmt0CQie5PLSAxdh+JN7gdChIis8uwr4d4DZUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkeJzSwWjK4j//cxvb7lsZmfHSvncsrLSjfDJeaojF+WI3u8U5
	zkcoTFfmNKwfMbC6BG0jKKyxlZlynOAg1DYqispnj9sfRSS7l9klUEDfelagtS8=
X-Gm-Gg: ASbGncuOqbOsVegVL1rSZF9EEgkKsXWZiYndenxJxXOZBwAiJIHHHRQ8Kjxf2UhksZA
	4/qv7gsqkjG/ffJIzL3j/MqwxTsd7Il9SPd9GIi73s9ZwUwGuV+uugFm0fA2pAmRscYRlKLogJV
	3p14kcqgzLfb6tP/aTAQ2h9jmI4uBzz6jLZEETjlzgIkmyEjahkEGwIUAW4sObABAZlyHHYHzra
	fyYNSAJe0/3C+SAJNFLRxOH3Ff1aAx5QLzt6LTT+yPBwhGxFT1S6W8d2P/M5YVssv39bPDQgFaK
	x1knay4=
X-Google-Smtp-Source: AGHT+IEMmb9t6PGdS5PoKr867mn9VHlZ8lICzDvFeUaKJtxwimOog2NMetPxeIcTVA8sTcncAD35Iw==
X-Received: by 2002:a05:6000:2ae:b0:386:3c93:70ff with SMTP id ffacd0b85a97d-387887df1a0mr3843306f8f.8.1734030462343;
        Thu, 12 Dec 2024 11:07:42 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824bd990sm4834365f8f.46.2024.12.12.11.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 11:07:41 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rafael@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/thresholds: Fix boundaries and detection routine
Date: Thu, 12 Dec 2024 20:07:36 +0100
Message-ID: <20241212190737.4127274-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation does not work if the thermal zone is
interrupt driven only.

The boundaries are not correctly checked and computed as it happens
only when the temperature is increasing or decreasing.

The problem arises because the routine to detect when we cross a
threshold is correlated with the computation of the boundaries. We
assume we have to recompute the boundaries when a threshold is crossed
but actually we should do that even if the it is not the case.

Mixing the boundaries computation and the threshold detection for the
sake of optimizing the routine is much more complex as it appears
intuitively and prone to errors.

This fix separates the boundaries computation and the threshold
crossing detection into different routines. The result is a code much
more simple to understand, thus easier to maintain.

The drawback is we browse the thresholds list several time but we can
consider that as neglictible because that happens when the temperature
is updated. There are certainly some aeras to improve in the
temperature update routine but it would be not adequate as this change
aims to fix the thresholds for v6.13.

Fixes: 445936f9e258 ("thermal: core: Add user thresholds support")
Tested-by: Daniel Lezcano <daniel.lezcano@linaro.org> # rock5b, Lenovo x13s
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_thresholds.c | 68 +++++++++++++++-------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/thermal/thermal_thresholds.c b/drivers/thermal/thermal_thresholds.c
index d9b2a0bb44fc..dc2852721151 100644
--- a/drivers/thermal/thermal_thresholds.c
+++ b/drivers/thermal/thermal_thresholds.c
@@ -69,58 +69,60 @@ static struct user_threshold *__thermal_thresholds_find(const struct list_head *
 	return NULL;
 }
 
-static bool __thermal_threshold_is_crossed(struct user_threshold *threshold, int temperature,
-					   int last_temperature, int direction,
-					   int *low, int *high)
+static bool thermal_thresholds_handle_raising(struct list_head *thresholds, int temperature,
+					      int last_temperature)
 {
+	struct user_threshold *t;
 
-	if (temperature >= threshold->temperature) {
-		if (threshold->temperature > *low &&
-		    THERMAL_THRESHOLD_WAY_DOWN & threshold->direction)
-			*low = threshold->temperature;
+	list_for_each_entry(t, thresholds, list_node) {
 
-		if (last_temperature < threshold->temperature &&
-		    threshold->direction & direction)
-			return true;
-	} else {
-		if (threshold->temperature < *high && THERMAL_THRESHOLD_WAY_UP
-		    & threshold->direction)
-			*high = threshold->temperature;
+		if (!(t->direction & THERMAL_THRESHOLD_WAY_UP))
+		    continue;
 
-		if (last_temperature >= threshold->temperature &&
-		    threshold->direction & direction)
+		if (temperature >= t->temperature &&
+		    last_temperature < t->temperature)
 			return true;
 	}
 
 	return false;
 }
 
-static bool thermal_thresholds_handle_raising(struct list_head *thresholds, int temperature,
-					      int last_temperature, int *low, int *high)
+static bool thermal_thresholds_handle_dropping(struct list_head *thresholds, int temperature,
+					       int last_temperature)
 {
 	struct user_threshold *t;
 
-	list_for_each_entry(t, thresholds, list_node) {
-		if (__thermal_threshold_is_crossed(t, temperature, last_temperature,
-						   THERMAL_THRESHOLD_WAY_UP, low, high))
+	list_for_each_entry_reverse(t, thresholds, list_node) {
+
+		if (!(t->direction & THERMAL_THRESHOLD_WAY_DOWN))
+		    continue;
+
+		if (temperature < t->temperature &&
+		    last_temperature >= t->temperature)
 			return true;
 	}
 
 	return false;
 }
 
-static bool thermal_thresholds_handle_dropping(struct list_head *thresholds, int temperature,
-					       int last_temperature, int *low, int *high)
+static void thermal_threshold_find_boundaries(struct list_head *thresholds, int temperature,
+					      int *low, int *high)
 {
 	struct user_threshold *t;
 
-	list_for_each_entry_reverse(t, thresholds, list_node) {
-		if (__thermal_threshold_is_crossed(t, temperature, last_temperature,
-						   THERMAL_THRESHOLD_WAY_DOWN, low, high))
-			return true;
+	list_for_each_entry(t, thresholds, list_node) {
+		if (temperature < t->temperature &&
+		    (t->direction & THERMAL_THRESHOLD_WAY_UP) &&
+		    *high > t->temperature)
+			*high = t->temperature;
 	}
 
-	return false;
+	list_for_each_entry_reverse(t, thresholds, list_node) {
+		if (temperature > t->temperature &&
+		    (t->direction & THERMAL_THRESHOLD_WAY_DOWN) &&
+		    *low < t->temperature)
+			*low = t->temperature;
+	}
 }
 
 void thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, int *high)
@@ -132,6 +134,8 @@ void thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, int *hi
 
 	lockdep_assert_held(&tz->lock);
 
+	thermal_threshold_find_boundaries(thresholds, temperature, low, high);
+
 	/*
 	 * We need a second update in order to detect a threshold being crossed
 	 */
@@ -151,12 +155,12 @@ void thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, int *hi
 	 * - decreased : thresholds are crossed the way down
 	 */
 	if (temperature > last_temperature) {
-		if (thermal_thresholds_handle_raising(thresholds, temperature,
-						      last_temperature, low, high))
+		if (thermal_thresholds_handle_raising(thresholds,
+						      temperature, last_temperature))
 			thermal_notify_threshold_up(tz);
 	} else {
-		if (thermal_thresholds_handle_dropping(thresholds, temperature,
-						       last_temperature, low, high))
+		if (thermal_thresholds_handle_dropping(thresholds,
+						       temperature, last_temperature))
 			thermal_notify_threshold_down(tz);
 	}
 }
-- 
2.43.0


