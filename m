Return-Path: <linux-pm+bounces-15610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0E899C61E
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 11:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29519287A6F
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 09:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7172515852F;
	Mon, 14 Oct 2024 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fq9EPuTT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFE7156230
	for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2024 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899001; cv=none; b=tXpXbom38pLsG/przIcLu5ZUx/13WWutnRPqoD5id1dowrw+9ApmugbLOAu8/T6a4XLCqck+i5tcI+Kh3wpPcEjX1jaWaNdmzJ/AdjuTxcxQ6rFFtafi31hAMZbR+GQrMeyL01WAID92M60AdPo8K+sWFcNW4rBKuIMgRFNIJGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899001; c=relaxed/simple;
	bh=CFyUGr+OCOKUEMxGpwHO/7pvPomEJi6ycUUMM14sA78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sb1rxpwFqHgqOVS3CvLjq+TPC5t5hcWIaCUegIRqxJGBR24/zIhK/VNGvIsXmJvS76KyibTFi2s+O+yz/Rj6nEHCBCo94rU4DFGqMRto+010uQjRvNvMT7zPerO6MplDLJpSFXlUtUMbNT5RhjcZJvS3hpysOdAfqDz4ajm99fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fq9EPuTT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so2959137f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2024 02:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728898997; x=1729503797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7xyDcI7TmzPvnMDt6ZfVSppfa8WOze76GT53KeZ51g=;
        b=Fq9EPuTTcp9aLHURAVJap/CNPYdxoG/mUc4TdlsmWA1NQh5lk++oMHMvNPkL/Q67wD
         shZfxoGElzFUYzW+/9K025PbVfwR6HYmYjkuf+JBFfRftNVYocWEsZ8lIgBOUJzT6zJq
         5blYuJ1h1MYm1YclNGNnQR0OsOFfq+/xIFkX1nYhOmalCJ1FESuBeIq7InRD6I1gZhkp
         POm0xfR0aARpiNkl8kdnJlEQGgNyTYgOkZXq6kTY53RKPCihVVfIYI1CcMPzx45FIix6
         hMYuRoebn8QHatIzmZ0RsMPeobFD28XdeCVKHpbSXNg92vct1jbbTsMXkYR6rjOa8808
         d82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728898997; x=1729503797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7xyDcI7TmzPvnMDt6ZfVSppfa8WOze76GT53KeZ51g=;
        b=IjYDMl/qpG7jnXKQSLWaxYYFD1NO0NktQO5oZf+16twM3wCrtgz4M/KRiP+6o9Rq63
         aFGl7NjcjjjX3f30nBx7SfiF6aBTL+7hcWlKPmK2NKMbLwm9NqcRtUhDy3VHdm1XZJII
         J/DZ9mi+5kygiSDFCkEG7ZwV4wmxCZRjiJZCmfzVH/xiVQKUw10r8C+7kH6SXnodPorl
         xSsjc/ldFu7JE/Kvw3h0/lhMZH/cLBfXGplEqTGXDEvEHokQEGcIrxwadR4iQiRKcw7N
         P8qf1aOyPLHKCFOFoF6rfVy3w9XLseh7cpBZ+7TG6X0T0OQX7E9WCHN42Fjc6DevclgF
         zWJQ==
X-Gm-Message-State: AOJu0YxF/VDTacqSFL3qVgY7IVvnt/YIucHOucsS7Q9/OAyMg+QcKBWg
	na2FIS3I6gLr8OD+bSH+NrCaajuIS4T+x+TF+geBSRQJrFLducoKA+Yy+Asv4f0KXEL6ZRQTOUt
	i
X-Google-Smtp-Source: AGHT+IHlrEW88aU8kMJS/u40PpiwL42sJsI7+c534FEiXNyH5y4Oy5A1atYsSynCvof4bBp9f16MNQ==
X-Received: by 2002:a5d:460f:0:b0:37c:d23a:1e4 with SMTP id ffacd0b85a97d-37d551e0644mr7377025f8f.30.1728898996776;
        Mon, 14 Oct 2024 02:43:16 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6d0203sm10935840f8f.57.2024.10.14.02.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 02:43:16 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v5 4/4] tools/thermal/thermal-engine: Take into account the thresholds API
Date: Mon, 14 Oct 2024 11:43:07 +0200
Message-ID: <20241014094309.1430126-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
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


