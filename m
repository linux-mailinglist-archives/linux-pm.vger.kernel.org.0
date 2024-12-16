Return-Path: <linux-pm+bounces-19349-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA3B9F3CC3
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 22:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754D318826FA
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 21:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F121D47A2;
	Mon, 16 Dec 2024 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wRhM6CQK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B7F1D2F50
	for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734384423; cv=none; b=adfSASWaXZLfxfBg89UTETQutyxYq04lBoM8Ha/qaXdvqVAj+MTfrYxzvqNf9cRdeh1SpFCnxgbdZGewVssrKPbBj+paSws535UtB0X7kI3SJQkVX9Lci1IakS6WtMSFkcycAZWA57OIQNT3a/5lAZ7Wq/Ci26NMcD/fJ++qIqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734384423; c=relaxed/simple;
	bh=7gtt4gGt+C9ZyoMeBsZyad3EOLU85ulXp337SNzEloI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TbU3IKvwDa31tvqUuOhqk+9TXuibGLQHfV5pHMT/J5llXj69sp57xX2jgajxr6FaXFhliVYJZaVJ6vdu4yDO+3nIgg1/Kx7SFDrBoUJLjnDrGVHLI5s4IbIAsYAUMlQYoL03kXdo/rxJlyNJzF+vfnswRH6iD7YdVTxM1vfhky4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wRhM6CQK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43635796b48so16554125e9.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 13:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734384419; x=1734989219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n5G559HpLt4aEfWtIVUG4rXUzdjY8b0oIHa1lhrQ+pY=;
        b=wRhM6CQKARSDB3d+S/dYY3o1WFZ1Rs+/2Wp9aNAFL+guLgV4qdbA25BM0Nk0QvBCjv
         MGJsRhEP66FsQdn5un4CwqsteElewC2R2W8SlqTssVrU7idQRL1K3yapqkRSp7ibulD9
         DZlGwk5wkp84W9iIC5Kst+ZsWzeJi4ZKTg1+jgYjBg4cxEimN3oaxInm0e0GnGJFxxZ/
         dhJOkKhvBXkmHseJwe+6ObwW0Yu0XYZtrlRB2+o41Mra3j9qxDjB5XKVyRz3R+loLlXn
         pGZkGWtOBt7sKGR4DRxXW4iXFLO5JMiSGcuZLVpA3wxlIXKzZlOedN0aLY+jRHLqffIE
         7mvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734384419; x=1734989219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5G559HpLt4aEfWtIVUG4rXUzdjY8b0oIHa1lhrQ+pY=;
        b=m3CaulDMo1fGA1gZ0nAXAl6Ws0G2/qLoqqIzrGNr3Lr2RLXsUoEbBviIeVKWrwydB3
         PGf7m2bxq7mpMRyg1zsEhX+qPLqjhAaVSovVmRCtc/U/zg5ik/y+kypEHVuX+dlXb2wv
         +DiFzKOGhZ7SUh9XZ+YfYPQY3+nn4Xjalfpv7LEwNzbqSMLxUe6nFJ89ftvoJ9Pu8fAT
         ZAdIXIwCMj1gn/mqfUDe/W0vwi6GvCmEMgd2D7mQAA338PRPJLWLP6B6gyO7NGe2nAMU
         NVXIBW1GDE5F8xbDfYAXwjsyxdWJIQ25qDJI4yAhmV0d9rQEz2tUA+FyHEXZ1ePkiVwC
         SU5A==
X-Forwarded-Encrypted: i=1; AJvYcCV28/3GTfhIpPm+JPilOqLoOuPeTTot4hhBvPQPqdFzTL9k/8vW+ohXv8motLuYeQeoJF5Hb8NhlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9CABTJBAih3HwCudKZOcPLVMeOmaZFUXFiVY/zAR3zSo7HPwA
	y5E6eQjmIIRTGxzT6zCmSZRY9AeQnOM1BqmIA44aya6sEbrW/p7QzTTXd6L8McY=
X-Gm-Gg: ASbGnctVR5gHTanNANXupiTZQsisNxi2Bi16wI7gg6Q2VcIH4qIbkIcw596FOkfZtuO
	ysJtgqvg6HGwJGzEa+H+aEl1zeYGIpmbb9epo/bJLIyBwFOhd2LBOKnkUPWlr5f2ep2JdUBSnnG
	iYmHHeF2srbW0ECpe+7JgzmCLudT5PTGTpqaPZAHdVv3I5DRvSdanbj1UfjU6QS+0lO212Za99l
	NiY9SVioLXWostCOypxymG3YHzNu34+8UBksyVZIZ3GKcBW7OHIvn7mm1hwsoGriZKvnwRVz1EX
	XkhM39Y=
X-Google-Smtp-Source: AGHT+IEo1bL0cfkP7m6UyQbfRWvP2WxrjuK8walOVADJ4MIniSUmVjsXs95FJf4lPsfPKATFiweskg==
X-Received: by 2002:a05:600c:1ca4:b0:434:ff08:202e with SMTP id 5b1f17b1804b1-4364816a219mr7698535e9.8.1734384418665;
        Mon, 16 Dec 2024 13:26:58 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706c82sm151057485e9.35.2024.12.16.13.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:26:57 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rafael@kernel.org
Cc: quic_manafm@quicinc.com,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] thermal/thresholds: Fix boundaries and detection routine
Date: Mon, 16 Dec 2024 22:26:44 +0100
Message-ID: <20241216212644.1145122-1-daniel.lezcano@linaro.org>
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
  -V2: Fix the conditions for the temperature crossing the way down
---
 drivers/thermal/thermal_thresholds.c | 68 +++++++++++++++-------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/thermal/thermal_thresholds.c b/drivers/thermal/thermal_thresholds.c
index d9b2a0bb44fc..38f5fd0e8930 100644
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
+		if (temperature <= t->temperature &&
+		    last_temperature > t->temperature)
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


