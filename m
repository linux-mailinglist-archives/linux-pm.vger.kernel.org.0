Return-Path: <linux-pm+bounces-14560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5575A97E932
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 12:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786021C21134
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 10:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3572A195F17;
	Mon, 23 Sep 2024 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nI/dlvaZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69252195809
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085615; cv=none; b=VqAT6IGr6cXy5u+XSGibCDhCF5NO9GTS85vxle1zgGbnTPJM8m6z4UDAq7JsoRc8HNaa1Es32DtbvNkPYK5h4ACdf1jVaf7dlFX1wOOdnx8du+rj79LGovNvc5KdqqQYhk+hDjJ5wbB9xT6NKuil6vAPjME0FUiOiIWgG2n3SrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085615; c=relaxed/simple;
	bh=5zx5SBZJcmnV5Ww3N8DuiCrm7wd+D9uGvjo4cHTJ8B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gofH6oslIU2vsJXlABLDr5tUWXK6VNl7S9z0GRSkP95a0OXj8/koF3FZfvydor4McE1beCc2RuLw3n1SDBZ5qi85GRqcdrMmT15WYBTAOjjtwjuMsYkGSSjTBUBXCPp+vxHvnYeL96NcarNaeW3DkGlLUjRvqxgu6ci1FcM9smM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nI/dlvaZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37a33e55d01so3083278f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 03:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727085612; x=1727690412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doGqzwUQ5AL+SIN7Jttrlpj9/AQawzQ14twkeztHlAw=;
        b=nI/dlvaZyy1gRyQpCCzckzbJW++S8l1SFKPEDA2EDnvLvr+NAjrl3W5URGWCAXxWTE
         H3e6ityCg8oiEcTYH8oAotVUeB1ODAU4zTdd22Ra7HtNCC+ZmSSYlxo6ISzBDjQcpOIB
         MreI7Dg2d/6yyCUzEHHsPsdsffh6fg0IJDByvd1SYqfE6B8i64y92LOURO4U/smUORTf
         Cm5VzVMZ8UywbocoQ0Ul5o0kWKqa+mtwvb7IeHJZs+dOdxN0kKBfnNXIxBMoVRUV0TxL
         UjUXmq6oh6EJSZRiybEmRERRPi4rHEMfNPfFShGVXvtWHyTY893R+XVIwdtwMc/rWHty
         niJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727085612; x=1727690412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doGqzwUQ5AL+SIN7Jttrlpj9/AQawzQ14twkeztHlAw=;
        b=ZYljRKcyeHlAyB31k4jV4PQKEAhnvWcLmRL8Pr6oVH2HyVwGyPBs1OERSSgZ8Rtd9M
         3arEWlVXR3r6R0px3OBt4oAic4PicME44uqVET84VrGy/gyh9E/KpaM8cC6k/PEau0Mw
         5Qm+wshSbA90d925+6ZGotXbunHpGBoqaSoCiS0yps/J2uUF1l17Ugn+KmiiEK/Z8OfS
         Vuho8RylAqJQQUQFzRsjVrFa1u/cHrodnC6CskPkuWs08JlLH1fMeYxCuRcIYsgYVXop
         b/udD3T9TtRzLpEUE3HuM1ZcCrj3akGyjmQoQKo9BYdGvQHwubbR909lak/djLcOJLEX
         175Q==
X-Gm-Message-State: AOJu0YzwE3HxERq/MaH80Z3Q2nd6beRZ9iN4jH+pHxrBu0LUgLE5ki/i
	Y2YLrflp2b9895Y0KDtrDLUuSJFbXQLmz7oYPGIcqY6AjxhOpJ/oIc+l41XExBo=
X-Google-Smtp-Source: AGHT+IEMtJTwrzRrBHiug8tyrxnaFF3H2kZLZMAjErCgO4lIpu0ZIojNqOA0sfk+zMhawyBCzkEdSA==
X-Received: by 2002:a5d:6284:0:b0:374:d25f:101 with SMTP id ffacd0b85a97d-37a4315803fmr5703114f8f.18.1727085611622;
        Mon, 23 Sep 2024 03:00:11 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm23977216f8f.49.2024.09.23.03.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 03:00:11 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v4 2/6] thermal/core: Connect the threshold with the core
Date: Mon, 23 Sep 2024 11:59:58 +0200
Message-ID: <20240923100005.2532430-3-daniel.lezcano@linaro.org>
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

Initialize, de-initialize and handle the threshold in the same place
than the trip points.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 073d02e21352..90937c23b0e6 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -585,6 +585,8 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 			high = td->threshold;
 	}
 
+	thermal_thresholds_handle(tz, &low, &high);
+
 	thermal_zone_set_trips(tz, low, high);
 
 	list_sort(NULL, &way_up_list, thermal_trip_notify_cmp);
@@ -1490,6 +1492,10 @@ thermal_zone_device_register_with_trips(const char *type,
 			goto unregister;
 	}
 
+	result = thermal_thresholds_init(tz);
+	if (result)
+		goto remove_hwmon;
+
 	mutex_lock(&thermal_list_lock);
 
 	mutex_lock(&tz->lock);
@@ -1513,6 +1519,8 @@ thermal_zone_device_register_with_trips(const char *type,
 
 	return tz;
 
+remove_hwmon:
+	thermal_remove_hwmon_sysfs(tz);
 unregister:
 	device_del(&tz->device);
 release_device:
@@ -1600,6 +1608,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	thermal_set_governor(tz, NULL);
 
+	thermal_thresholds_exit(tz);
 	thermal_remove_hwmon_sysfs(tz);
 	ida_free(&thermal_tz_ida, tz->id);
 	ida_destroy(&tz->ida);
-- 
2.43.0


