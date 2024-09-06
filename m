Return-Path: <linux-pm+bounces-13757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C69796EC1D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 09:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC4E1C21119
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 07:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC00153598;
	Fri,  6 Sep 2024 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUEKH9mw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1F814F108
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608208; cv=none; b=A7wrJz8mwAOuNkayIIEXPA5Xyn595BUU1tIloWDVyy6ANhsvR7g9bCIMNg3VVg973q5/SMTEG52uqUeCaKfda1cIOgqADU2Riep/7jLA6bjC4hgKShvuhkWJjBarkEoEE98yc+pjc8cj78Gdl6uUWqvuMMZu3uSf6JUyqJam2Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608208; c=relaxed/simple;
	bh=ky6JEARCdxFnnRF1CRBNkrrQSuzdjffn6C61+FscHu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9EFRfRWlqL8jVdfrnYpVDDV9iGh3KtAF0cI/9NBS5AYVw6lUHXndV0B8ap17Qo2S8c8A3Ir9KLD7j7LBssfG6l+DD1K+4EQKD/x74O3yt2G7AkfJp5GnMD525B96AWrV9OUU/CEGnz8qV8geNDFxkay9C9MD7CQ7jM5F2ozNPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DUEKH9mw; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374bfc395a5so961513f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2024 00:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725608205; x=1726213005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeBSJLjzblBwDv/f5H0VYLzrS3n0MDRjLVWkG4LDN9U=;
        b=DUEKH9mwLppMq9+it4xejpd1VcdPYLDrkAkyp7N84J+0GZUvBdYgq4N/FwNLe6CRmH
         wZu0/1UdVd0B1k22upqjnfohBFebyxttqK5uxsMl6Vr/asj2lR1r6Ph8UWn7vEvl2vEy
         nQP+S5m0revAO77lBgBxhZijsJM2Mt6uNnCZXVQTRWHJog8dXgBNUQiXYUgd/6K5Ryw1
         f7Kd+0oZIkWqIz5XQkxUG7YLQsLGfYgIAJ6ZPiGuAqqwL9cGt4/Cz6AQh2ypoCix+gVq
         Ys5YriWlxI1NqNsBskaQVhfYep1e1+KV9X26icTQTszq7v4Ska9QR/Y5r/bE2mYnud9q
         FDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725608205; x=1726213005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeBSJLjzblBwDv/f5H0VYLzrS3n0MDRjLVWkG4LDN9U=;
        b=BxknbcNLQNnG4WX9AxEPLXM4m1KS72IM65YX0bCB38yhNiTCnbyNbxJx/IfmTAuyg2
         twFs80WVSs5eO16/sI5VaKKlg26Nwy7od9/I6EeMpNU3hM0FenlBsjwVZurxTtCgpson
         4SHA7CpBj8Z3wZtjXc3nPe9d1X+fexYht5NMGeK2w4LYftrz9EpoLv0cRe4viBfeXwsf
         5eIly6P0WVMCBDnYS8y8AOvlDwTa+DBdsdEgHEAI71wsnXDayHmJtqM3x2e5yk9nJH4Z
         UPI6h/FBRL3MTO51u5MqCa+ToIytaHx7H9iIhZS3vPiedA+16oTJbwoxSTyvJQwTTfLb
         M7/A==
X-Gm-Message-State: AOJu0Yzag4lXda9ZmWrYbdrP0lGowUkjkBy25p3StxrwKV1B+xdoNLaG
	ucB9wDTapd9La6HgZEYm0EGa3EGo0vlSju8OjooAlU/qQq0S2YATPX2wKDvQPG0=
X-Google-Smtp-Source: AGHT+IFRTjCzyYCgNt2DmqfwDKCPbN1dH415ddQuY2Lv+/P1L1mWHQfaSUHksxtlV2nI2e8PMHS7ew==
X-Received: by 2002:adf:e802:0:b0:374:ba78:9013 with SMTP id ffacd0b85a97d-378885cfc64mr882167f8f.9.1725608204822;
        Fri, 06 Sep 2024 00:36:44 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-376914bfca1sm8113885f8f.18.2024.09.06.00.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 00:36:44 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v3 6/6] tools/thermal/thermal-engine: Take into account the thresholds API
Date: Fri,  6 Sep 2024 09:36:27 +0200
Message-ID: <20240906073631.1655552-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240906073631.1655552-1-daniel.lezcano@linaro.org>
References: <20240906073631.1655552-1-daniel.lezcano@linaro.org>
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


