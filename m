Return-Path: <linux-pm+bounces-16247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C82A9AB2C8
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 17:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08997B21EAF
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 15:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E13C1BCA0E;
	Tue, 22 Oct 2024 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhGPpvq/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49B41BCA07
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612323; cv=none; b=Hgq0IJlW1gsqfobaAFMmdFfNxU0Dmia5VtDZ7LBdzVeAMhBV1mwt9WhD0yFvts5bPsOjT8uLh+IcGBv+Lr2OU2pIuTIdN/+MYPtXs5rh9ZcdbjRAJ0nq5Xf8pta53tQVPf5aVSiQSmKsjoES24soMaqwjoU4Q0WfAiVQDQ2LYjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612323; c=relaxed/simple;
	bh=wnuS4jCjWeWaZfA5VKXzBfe1spB2VUFtXbdTIp8fiYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YR659hqGMYT2m9G3jiorrKiinwQ17jlXwenCJDmFNslXsDxzJw1l20cy+ei5F3mqD1W+E2gKSqa+RUT3LKkKKyJblE9Shmud+pvFG4f+JzCFrfmz0tzszOwEAj9fyG+cCz7F69F9kB7MpHxg5q00n4WWnKGthpjsS87W4G21a70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XhGPpvq/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so53553235e9.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729612320; x=1730217120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQdcwI3tFVDhwU2PKpTHQ4+HIG66kx8TPmW1H/qWXJY=;
        b=XhGPpvq/wVV0VB8bjrJ85pGs2rQQ0PvKs57kaMPFR6dUCzinZFQ+xzQDg/6UqRg7e2
         2+bqD5l4iOKLtlERd7iEwpllo7LaEY75+SmCAxMf2+VMVRXp3v996GfkMDWTv5O+rvMi
         tT9T0gVk5j2rhXa21+l+uW6vpykzv+sGOhfMzZzqgbLqEnaqi0GYjYeYKQ5Yw8bEvyRn
         zy3Tw6IfjKziW8zOI5Bmik8LtiTLcMFxLGQ6msreW8ARKTB9pWBJjEYv2uciy9avlQLz
         o++fxSwzcgoiktbTHI3lFCs+V1x4YH5vPjwYWhKkDYra92Q98U3LdGL997kQ90F5dECi
         GqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729612320; x=1730217120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQdcwI3tFVDhwU2PKpTHQ4+HIG66kx8TPmW1H/qWXJY=;
        b=vQ6RUqKKhoz/IW1W5USDmLlpRvTJhxBHpFJvaR7oSj5QjH54nxHYgTG7j88iLIlgP5
         lLp2xv1UDUKqMmJQyU/8OQzZ0PpRubwXPu6QLbkXpWsfS6DH60iKQ1zeIaom9qfRf1eH
         Id+UUhvfoaTEPwh3WfxKa+mxRhuJ6Fft2IfnKwwMP/X5mY/sRpKtAVbaHsc887N2tt+k
         kgzsbh2TW6WxnVtfJIb7+vdG09fyL9KEYWkFfHAtfX5liwKlSCviBdJYmpXAsIvs93PH
         g57mAycAX/awEArUwDZSgqlmzNb4xXFnfbkfLIYhMB48rOkTdfw4GsRYae1B/zmc0Krt
         Lo2w==
X-Gm-Message-State: AOJu0YwBEOmq/9YvBcsxwnNu/u8aTwq5G21GVectP9a9Hp/CZeBRjvZl
	d9qn+fVa6CNXGGV2DjwNnP6yXsAUV3g6bG9dtyiwNjFoopCin++sMmZJ8Ntfdp0=
X-Google-Smtp-Source: AGHT+IFMKTj1MstPZDTv/EAGt+gTUjRxSNkt9qz9uHF5PEwIkPP2/0GWHEjtbQNtbLrxQmNShnoxiQ==
X-Received: by 2002:a05:600c:5493:b0:431:537d:b3b4 with SMTP id 5b1f17b1804b1-43161642331mr126123335e9.11.1729612320145;
        Tue, 22 Oct 2024 08:52:00 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58aef6sm91538075e9.22.2024.10.22.08.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 08:51:59 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	quic_manafm@quicinc.com,
	lukasz.luba@arm.com
Subject: [PATCH v6 5/5] tools/thermal/thermal-engine: Take into account the thresholds API
Date: Tue, 22 Oct 2024 17:51:45 +0200
Message-ID: <20241022155147.463475-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022155147.463475-1-daniel.lezcano@linaro.org>
References: <20241022155147.463475-1-daniel.lezcano@linaro.org>
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
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 tools/thermal/thermal-engine/thermal-engine.c | 105 +++++++++++++++---
 1 file changed, 92 insertions(+), 13 deletions(-)

diff --git a/tools/thermal/thermal-engine/thermal-engine.c b/tools/thermal/thermal-engine/thermal-engine.c
index 9b1476a2680f..0764dc754771 100644
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
@@ -197,20 +231,62 @@ static int gov_change(int tz_id, const char *name, __maybe_unused void *arg)
 	return 0;
 }
 
+static int threshold_add(int tz_id, int temp, int direction, __maybe_unused void *arg)
+{
+	INFO("Threshold added tz_id=%d: temp=%d, direction=%d\n", tz_id, temp, direction);
+
+	return 0;
+}
+
+static int threshold_delete(int tz_id, int temp, int direction, __maybe_unused void *arg)
+{
+	INFO("Threshold deleted tz_id=%d: temp=%d, direction=%d\n", tz_id, temp, direction);
+
+	return 0;
+}
+
+static int threshold_flush(int tz_id, __maybe_unused void *arg)
+{
+	INFO("Thresholds flushed tz_id=%d\n", tz_id);
+
+	return 0;
+}
+
+static int threshold_up(int tz_id, int temp, int prev_temp, __maybe_unused void *arg)
+{
+	INFO("Threshold crossed way up tz_id=%d: temp=%d, prev_temp=%d\n",
+	     tz_id, temp, prev_temp);
+
+	return 0;
+}
+
+static int threshold_down(int tz_id, int temp, int prev_temp, __maybe_unused void *arg)
+{
+	INFO("Threshold crossed way down tz_id=%d: temp=%d, prev_temp=%d\n",
+	     tz_id, temp, prev_temp);
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
@@ -280,6 +356,7 @@ enum {
 	THERMAL_ENGINE_DAEMON_ERROR,
 	THERMAL_ENGINE_LOG_ERROR,
 	THERMAL_ENGINE_THERMAL_ERROR,
+	THERMAL_ENGINE_THRESHOLD_ERROR,
 	THERMAL_ENGINE_MAINLOOP_ERROR,
 };
 
@@ -318,6 +395,8 @@ int main(int argc, char *argv[])
 		return THERMAL_ENGINE_THERMAL_ERROR;
 	}
 
+	for_each_thermal_zone(td.tz, set_threshold, td.th);
+
 	for_each_thermal_zone(td.tz, show_tz, td.th);
 
 	if (mainloop_init()) {
-- 
2.43.0


