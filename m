Return-Path: <linux-pm+bounces-14564-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B8C97E93B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 12:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7413B21277
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 10:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753CC1974F4;
	Mon, 23 Sep 2024 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AmM+0mNQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB1F195F3B
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085618; cv=none; b=JVlE+h3mkASFoh9xdqHbl7AddNx66AVZpLY1nb7DCgU+pZ9HNUKkdp2wVXkoMvgiaaqpGg0pkwpYalI4OG2tG5DvZGJ35wQdy/extyHivb2oJdL0Mv1DW4qXfJFpD5d3c37/WoaxJPXQJ0A5q2rMCV38Qcr12Nf7rvv3KkZDORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085618; c=relaxed/simple;
	bh=ky6JEARCdxFnnRF1CRBNkrrQSuzdjffn6C61+FscHu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nc00VQDLrr3p7P9mraUaKUVnHxo6cljy2RcKtz+hMRrFN3otAXAh7EpqKwg7+7KpdtdTpIjQPi9wwjOPvht+NlrKCVJd59GJtA+JnR13mSprdPCBpk91JNWVUyo8wxsyP/lNHg5i3lny4ji8nDe20ITvBRAJ3rXXNJetQLVKeKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AmM+0mNQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374c84dcc90so2428730f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 03:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727085615; x=1727690415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeBSJLjzblBwDv/f5H0VYLzrS3n0MDRjLVWkG4LDN9U=;
        b=AmM+0mNQ1nAAdwPvVuznqZFUX7jfapIs0bMbS0TpfHOjsxZ+8ivl8nAffDPOkwLp1k
         XV/j2Ux4fFRGUYeSg73KJhkDIwPq4CQ6iI4LMOl4ytu7HKdJEHThbXuuTrbTlybYlnI7
         su2TjsLEcEdPGE8MpanxpBcxHIvGRKgtaMqYpld7GBV5XorHiGdxgb677xLJClS6L3oN
         xO6ZHKQZbRnF/ezh0yukXQQ5vwszNuRuMU6ta6cPkv+hIGaVrFfrjfhp0e+juqPZruYd
         cU3un9XzGo8GZKj4jS+0KRcT780sFAc7vNaIt47ee+qU7vEOTSeg8FCAG2v72xSctLoW
         0E5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727085615; x=1727690415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeBSJLjzblBwDv/f5H0VYLzrS3n0MDRjLVWkG4LDN9U=;
        b=UJpgwtPuTRkmZIzLPHgYVUmbz3hGZFBAKN4QAfl1oQgwNWviak5J0QqvBDFFbiPtuU
         tOd1QBGTY9K+U88dwUVPW+WJPks0ATUBYB6eRvhrf2MSnM7bt7UuRBiKTKJG0IikWoj+
         7UcQxl0RWJK7Ny9q682+ldnsxmFCe/J+EBVXCj0pmY0/eRQ8QasOFbYl7YL8QXB/jr/u
         hNMvb/69Bd1Kjxd4Vw38SBexD6l9WIDpb8kGHHAzH7mQTfRPiS5ziGZYB0BGQLzk2fxA
         sJSu4Kh7qGR4l1N3V41ejxX+21GpBeI84qUlp4ElX58E3b5sAIRVsEUuNrjonniVsiRq
         b+AQ==
X-Gm-Message-State: AOJu0YwStLIcyK6az9rByv1x+BOtbr+EE9wjZn/at4/Qt5erfOhFmg9K
	8nKT3oztSsgkGsHOI2PPUFVAGXBW2ur+uvBQkNZHgB/+R4ZHg9i73gY/+B5ImWY=
X-Google-Smtp-Source: AGHT+IF4VXPL/ThmTL57Et0BgvkGBqRtEv/S9jvgNhO6y4sE7wH8kdsQxEZoRSfINBHmEWWrddJZmQ==
X-Received: by 2002:adf:e0d1:0:b0:371:c51a:3b2a with SMTP id ffacd0b85a97d-37a422520b5mr5950291f8f.4.1727085614539;
        Mon, 23 Sep 2024 03:00:14 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm23977216f8f.49.2024.09.23.03.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 03:00:14 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v4 6/6] tools/thermal/thermal-engine: Take into account the thresholds API
Date: Mon, 23 Sep 2024 12:00:02 +0200
Message-ID: <20240923100005.2532430-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240923100005.2532430-1-daniel.lezcano@linaro.org>
References: <20240923100005.2532430-1-daniel.lezcano@linaro.org>
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


