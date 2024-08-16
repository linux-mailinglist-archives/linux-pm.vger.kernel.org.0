Return-Path: <linux-pm+bounces-12319-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1169543BF
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D882836D4
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 08:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DB8137775;
	Fri, 16 Aug 2024 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kaZTLUiJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B6812D74F
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795973; cv=none; b=Jr8/V3mi8aCfI62298k6L6bW3SwqjRU7z4bHbf4LYUNM8mwkYEQ8rNoaUg7ywvat681vd6JEWkLJ1dw7vmWtctogvuU7hbK8yQFcrjzPTWxfV2knlYbFcKMVf0ae59KDYUdPomaSRDLdjMvyDiMn2bSWiWbJ9vyu3odwAPp7K8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795973; c=relaxed/simple;
	bh=ky6JEARCdxFnnRF1CRBNkrrQSuzdjffn6C61+FscHu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiT9TqkQSlda6ENOLuMEUnGFhFLchHUS5DBE41CfN8T2AQmofYrN6KhzmQH6uTJIDWkg1HH7WrAQ5gT+8HLvk6U4HPwnrEPJsRBdg6l0hXXlPt2NL6+pVH+bNd5H83uep0K6TEJ79rpjXzU8p0GUkJj0idGQ09RdtSZzSr1vCYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kaZTLUiJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281c164408so11798545e9.1
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 01:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723795969; x=1724400769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeBSJLjzblBwDv/f5H0VYLzrS3n0MDRjLVWkG4LDN9U=;
        b=kaZTLUiJ3/b7D/RBZDUTJTMbbch5G3MyeZ2OwNcFslZNNmgSQ2g7RjSULmo9US4ett
         suz9U6N5zVlttOlf4ZnUp3cMMkb3WVEOziywOZc5W5N+y6fi7YNRa3w8BZfi/e8usC1X
         IElgjwcl6SWcIJzBWL1v/VBYz6VVyhOxFI6wUfskfsy1gmj8mYq41OE7mW8Ml2mE039W
         lspVj1mufa+yCCs7JZoIxJNMt0JauolgYRXThDL0CIK2b26rRcwOnmqdkzcYDteiHJfY
         WU4SW1pifdHrE/lcGiElZzezX8cEdPe2CYzXm+/a6TNZ2hEgBntdp5/J7ZqyVmNE/H5v
         0ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723795969; x=1724400769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeBSJLjzblBwDv/f5H0VYLzrS3n0MDRjLVWkG4LDN9U=;
        b=SMaPVfgqZ/aF79InARdJTTMrXGHBEa7Cy6utejLkhogxXDyFDzfD1AsnwY6FNKiiBS
         5QKmwvWlL0uvd6/+sa1/0dzGGg/2fjZ/R0Q9TIR3bC09wuici969lqLpfVVJuoBMdz3w
         JoyOSJD3hyGXJ8f6j8bXF9QKPoubvWkmK4MKwOZKtTC6JhlFmPj7yIoPk+zx07dvGNS3
         w83qQEQvdos8HBE/BTyMkEbgAqki+87rq2MPeFcPOKmXpRLzoMt8wwJKOnDHtp180GSp
         HD5BrfdXJyebaaFNzSo8Upo1A62ZR8uw4nIezeye7a0FtnloyEy789De1wV0r1PgKirP
         fzoA==
X-Gm-Message-State: AOJu0YywLuDEzTmHtu9SacY/+KYAN41XTeF0INRKm2/BMFQYRM91l8IO
	qihRHhzyeiihRA2zRoK1gNVzGvqQv0e35Zaz6vhmDTVQy302lwxbbAGhx2NSRnDI0dxEc5eUCFT
	3gUE=
X-Google-Smtp-Source: AGHT+IEcFUpF4dK5sJM0SASYxFYhaCZF3rTBwGU1mb454T9JCdmb1bBkmfii0fT/R1mZ/tMrUlkHYg==
X-Received: by 2002:a05:600c:5108:b0:426:6618:146a with SMTP id 5b1f17b1804b1-429ed777266mr11866535e9.2.1723795969097;
        Fri, 16 Aug 2024 01:12:49 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed6593casm16021205e9.28.2024.08.16.01.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:12:48 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v2 7/7] tools/thermal/thermal-engine: Take into account the thresholds API
Date: Fri, 16 Aug 2024 10:12:38 +0200
Message-ID: <20240816081241.1925221-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enhance the thermal-engine skeleton with the thresholds added in the
kernel and use the API exported by the thermal library.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 tools/thermal/thermal-engine/thermal-engine.c | 109 +++++++++++++++---
 1 file changed, 96 insertions(+), 13 deletions(-)

diff --git a/tools/thermal/thermal-engine/thermal-engine.c b/tools/thermal/thermal-engine/thermal-engine.c
index 9b1476a2680f..ddc30a27acda 100644
--- a/tools/thermal/thermal-engine/thermal-engine.c
+++ b/tools/thermal/thermal-engine/thermal-engine.c
@@ -38,6 +38,14 @@ struct thermal_data {
 	struct thermal_handler *th;
 };
 
+static int show_threshold(struct thermal_threshold *th, __maybe_unused void *arg)
+{
+	INFO("threshold temp=%d, direction=%d\n",
+	     th->temperature, th->direction);
+
+	return 0;
+}
+
 static int show_trip(struct thermal_trip *tt, __maybe_unused void *arg)
 {
 	INFO("trip id=%d, type=%d, temp=%d, hyst=%d\n",
@@ -70,6 +78,8 @@ static int show_tz(struct thermal_zone *tz, __maybe_unused void *arg)
 
 	for_each_thermal_trip(tz->trip, show_trip, NULL);
 
+	for_each_thermal_threshold(tz->thresholds, show_threshold, NULL);
+	
 	show_temp(tz, arg);
 
 	show_governor(tz, arg);
@@ -77,6 +87,30 @@ static int show_tz(struct thermal_zone *tz, __maybe_unused void *arg)
 	return 0;
 }
 
+static int set_threshold(struct thermal_zone *tz, __maybe_unused void *arg)
+{
+	struct thermal_handler *th = arg;
+	int thresholds[] = { 43000, 65000, 49000, 55000, 57000 };
+	size_t i;
+
+	INFO("Setting threshold for thermal zone '%s', id=%d\n", tz->name, tz->id);
+
+	if (thermal_cmd_threshold_flush(th, tz)) {
+		ERROR("Failed to flush all previous thresholds\n");
+		return -1;
+	}
+
+	for (i = 0; i < sizeof(thresholds) / sizeof(thresholds[0]); i++)
+		if (thermal_cmd_threshold_add(th, tz, thresholds[i],
+					      THERMAL_THRESHOLD_WAY_UP |
+					      THERMAL_THRESHOLD_WAY_DOWN)) {
+			ERROR("Failed to set threshold\n");
+			return -1;
+		}
+
+	return 0;
+}
+
 static int tz_create(const char *name, int tz_id, __maybe_unused void *arg)
 {
 	INFO("Thermal zone '%s'/%d created\n", name, tz_id);
@@ -197,20 +231,66 @@ static int gov_change(int tz_id, const char *name, __maybe_unused void *arg)
 	return 0;
 }
 
+static int threshold_add(int tz_id, int temp, int direction,
+			 pid_t pid, __maybe_unused void *arg)
+{
+	INFO("Threshold added by pid=%d, tz_id=%d: temp=%d, direction=%d\n",
+	     pid, tz_id, temp, direction);
+
+	return 0;
+}
+
+static int threshold_delete(int tz_id, int temp, int direction,
+			    pid_t pid, __maybe_unused void *arg)
+{
+	INFO("Threshold deleted by pid=%d, tz_id=%d: temp=%d, direction=%d\n",
+	     pid, tz_id, temp, direction);
+
+	return 0;
+}
+
+static int threshold_flush(int tz_id, pid_t pid, __maybe_unused void *arg)
+{
+	INFO("Thresholds flushed by pid=%d, tz_id=%d\n", pid, tz_id);
+
+	return 0;
+}
+
+static int threshold_up(int tz_id, int temp, int last_temp, __maybe_unused void *arg)
+{
+	INFO("Threshold crossed way up tz_id=%d: temp=%d, last_temp=%d\n",
+	     tz_id, temp, last_temp);
+
+	return 0;
+}
+
+static int threshold_down(int tz_id, int temp, int last_temp, __maybe_unused void *arg)
+{
+	INFO("Threshold crossed way down tz_id=%d: temp=%d, last_temp=%d\n",
+	     tz_id, temp, last_temp);
+
+	return 0;
+}
+
 static struct thermal_ops ops = {
-	.events.tz_create	= tz_create,
-	.events.tz_delete	= tz_delete,
-	.events.tz_disable	= tz_disable,
-	.events.tz_enable	= tz_enable,
-	.events.trip_high	= trip_high,
-	.events.trip_low	= trip_low,
-	.events.trip_add	= trip_add,
-	.events.trip_delete	= trip_delete,
-	.events.trip_change	= trip_change,
-	.events.cdev_add	= cdev_add,
-	.events.cdev_delete	= cdev_delete,
-	.events.cdev_update	= cdev_update,
-	.events.gov_change	= gov_change
+	.events.tz_create		= tz_create,
+	.events.tz_delete		= tz_delete,
+	.events.tz_disable		= tz_disable,
+	.events.tz_enable		= tz_enable,
+	.events.trip_high		= trip_high,
+	.events.trip_low		= trip_low,
+	.events.trip_add		= trip_add,
+	.events.trip_delete		= trip_delete,
+	.events.trip_change		= trip_change,
+	.events.cdev_add		= cdev_add,
+	.events.cdev_delete		= cdev_delete,
+	.events.cdev_update		= cdev_update,
+	.events.gov_change		= gov_change,
+	.events.threshold_add		= threshold_add,
+	.events.threshold_delete	= threshold_delete,
+	.events.threshold_flush		= threshold_flush,
+	.events.threshold_up		= threshold_up,
+	.events.threshold_down		= threshold_down,
 };
 
 static int thermal_event(__maybe_unused int fd, __maybe_unused void *arg)
@@ -280,6 +360,7 @@ enum {
 	THERMAL_ENGINE_DAEMON_ERROR,
 	THERMAL_ENGINE_LOG_ERROR,
 	THERMAL_ENGINE_THERMAL_ERROR,
+	THERMAL_ENGINE_THRESHOLD_ERROR,	
 	THERMAL_ENGINE_MAINLOOP_ERROR,
 };
 
@@ -318,6 +399,8 @@ int main(int argc, char *argv[])
 		return THERMAL_ENGINE_THERMAL_ERROR;
 	}
 
+	for_each_thermal_zone(td.tz, set_threshold, td.th);
+
 	for_each_thermal_zone(td.tz, show_tz, td.th);
 
 	if (mainloop_init()) {
-- 
2.43.0


