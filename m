Return-Path: <linux-pm+bounces-11550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1607D93F903
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 17:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04FE51C220A1
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 15:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2233158A3C;
	Mon, 29 Jul 2024 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hm9C/hYL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DF5155342
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265422; cv=none; b=DCPFxxo7sdh1sZfdeQPFDeZFExdt2q8SUZIzJS9sPEvY1VIGEUcOUluxUSf/QH8An/WiH6j85vr7djbH2VDRGg6tWz9zzGI0TQ4On3T/8oRAzox7KwQxrGxKDbUmHF7CjVlZ9TT9ejQMhMDhD8fT6alqir+MnQQjr8nDYSq1QC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265422; c=relaxed/simple;
	bh=ky6JEARCdxFnnRF1CRBNkrrQSuzdjffn6C61+FscHu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUxf48T34EBVRd0C/9pdiedbA0KSGnXjqPA3A5tPkuP5bGkBwLizOd3lMSBQlNLmUwA/GZM4KRQD4XegqgQm8Aao5yLzHzYLC42Yje5C8NGraa2GRK9qy5oeOpGZmyXA1dttfh78cwqV10aomr9ZaQhbNzv4DPlkqmMUyTUzf0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hm9C/hYL; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3685a564bafso1491618f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 08:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722265419; x=1722870219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeBSJLjzblBwDv/f5H0VYLzrS3n0MDRjLVWkG4LDN9U=;
        b=hm9C/hYLAGj0XthrtISQsl5bmVc42QpoL4zTEegjObsfakaf0vTHq0mDfONlhj7xLR
         0zKgszwv0pBJL5oGVR2+iqD6ZT2LdqBkvvViSSRylfgSmZH56EiRHZ2LvIPnxV5qsNvp
         3InhCq6JDGk36z2sADRYJqLhZqneM6IAGpPifJlpK3BPJt5Akssd1IAHClNEyIjdvznk
         aZHu1yXa5IzdX68YPTv4qZ7TSk+u9R/i8xJfQeOmFcWZ3ZSqwBXMxpnbHfZBB1pfVrif
         wniqJp+2G1PuNl3mQ5L2Tps/4gzzM5bRNKNWKfwtgNzeaAhnc/xyDYMwhfcQGekgcDdx
         fs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722265419; x=1722870219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeBSJLjzblBwDv/f5H0VYLzrS3n0MDRjLVWkG4LDN9U=;
        b=O8D6DWAnIZx37RoaN928nJbeaGmamiMnmEqslM14EH4hEyjZjrKN0l1dTgRPd1NEcc
         NGrk8a0AZslQPimSyWHz7x7Dv3BVKq7p/ij52tCD/aOB/ZNFo1THAugKFn0xgYn1ddx1
         79qvYLogcBCpQFle7fnr7Y2dCbmf3Flylahfo+LzhoTlq/NvngOX68FWrQvKBUgJVcvn
         0nJEfkPuZhPWIqMrrhl+P87pvOo6IlVgrnA7V8YN16uHjKG3C5ltUvy2MaJKP2jDhn4Q
         8JmuTEKGTWrjjbMaOGtdaAZU3uukM1XjLUYwJncKiAF60cHUknTjkpH3vfAb1a/HrzwP
         xm7w==
X-Gm-Message-State: AOJu0YwOX1IgdXiDFG2aO1msx9rXugeT2WsO1/2pOeoMiEGu+dBc0kp7
	LPaKkWojmHXprb2RA0vmledeHA6X4/i6j0ZOyE2sBVCXjlMC2MnKTDz/zlVc9TGlDTcLAfMVvV+
	m
X-Google-Smtp-Source: AGHT+IHqIJgjk3jL9V4RDISPZydZ+xvjHDq1sce1iOjDz57vMSmA8TBzY8lWzxl4+fvgWJ8XzoxBKw==
X-Received: by 2002:a5d:45cb:0:b0:368:4634:c419 with SMTP id ffacd0b85a97d-36b5d09e40emr4715993f8f.58.1722265419085;
        Mon, 29 Jul 2024 08:03:39 -0700 (PDT)
Received: from mai.box.freepro.com (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863b45sm12652803f8f.107.2024.07.29.08.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 08:03:38 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v1 7/7] tools/thermal/thermal-engine: Take into account the thresholds API
Date: Mon, 29 Jul 2024 17:02:56 +0200
Message-ID: <20240729150259.1089814-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729150259.1089814-1-daniel.lezcano@linaro.org>
References: <20240729150259.1089814-1-daniel.lezcano@linaro.org>
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


