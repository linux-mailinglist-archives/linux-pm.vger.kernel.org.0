Return-Path: <linux-pm+bounces-12314-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382199543BA
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD85C285A1E
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 08:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE62212C478;
	Fri, 16 Aug 2024 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QsGyx8kr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134438286F
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795969; cv=none; b=aVnvm6dPUZbFP/rPJp+C+0/hbJUTfkKJCmXvEgX2GrN8s9JXxfdrjxH0x1etq6rTZq9w4wH3sb+i1pxT9r+aw6547TKBVNwm1y7he9Yc64HHjbU1APxYweHUyMpVg2LXxWTFxuMuiQMvgFXu+/GySiUG23B+jY2GR7aYb75VTOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795969; c=relaxed/simple;
	bh=PBpHVon8kWXablpkfiURYXZobURffNuvyiVPOf4XR9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=te2AHSltENaBbtsDKMyx20E4jsVWtAOOWR27Atu3fgwXmFL82JdPUXjEQvgBsoVCRyUHQX5rYk/+60A3l/7CYe8CJ9+K+Xgd8xOg8Hh/Ogw3QNjDWgS96/5esiox5qCO0103btw56nPtGyxZJpMFx0/I/vFbWADE5Lqlc3+oxvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QsGyx8kr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428243f928cso12258345e9.3
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 01:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723795966; x=1724400766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojcZ/dzBavdmLF5+AL/jn2Lr9czX6kpKLqxAXwjrP2Q=;
        b=QsGyx8krkySHxZO+UtLhE86UWlgAcO0vMNgxD73zKpilXucu13a256IJg5AlQJFSf1
         8ZdZ8RrShmcjnBxduPHhDHLsrhmaCar7MM8vl7CrJLmaxbl+m6wpKiY7lo9vnrlvpbio
         C+Pn8yfH7Z5BS9IruSYJe8nOrE1M36Wu1ifQarmJZ7AoRn0y3A8S1efxalu/Y3R/kinP
         A9f4tU5UVty85/AGeMLWa85x6/a3nTL3D5nE4ZqzdcFMP80ui2Ph4FabEcznab25/uUx
         BGpFPLuuJHxY2WL2f0Ur5qvK8+nJLQo0dMp621sG3Py94nBK37aOd7KhkQe3ix0lYZ/X
         XWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723795966; x=1724400766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojcZ/dzBavdmLF5+AL/jn2Lr9czX6kpKLqxAXwjrP2Q=;
        b=enIVkXZTNCu5TDZcWowMSplRI+Zdp3T7TkbpN8hW/4ZAXx1gg2Y7xwkPXm8rndFPP0
         3UICNDQIoj6faC9vsbNJ8yijJzpj+yRYMU1QJmzLGFM2xvqRrnGKkkUpXvIuenIjVAQE
         nKkR74orJWX/spcC26fPp7bR/pVLkCL4j7X+ZGBWFgIzGo/yoHBJGA6SW6VTdia7r4RM
         ZoaMeqbGMpvMljapr5KFHw3A9FGP8y5vZhqhcVIgFLCmtW8kOjfzlKgDuNzCSF8E6N/m
         /xqSbClv6Kv5JktOaBbEgh/qB7q8r05GQTEGNQArv/Tcd0yEvIUAI6yxwQ+q58NzQrS+
         MStg==
X-Gm-Message-State: AOJu0YwVLm/vi5VVD13TDvGUXFS4PGRhW6sPB5F68aAIzk0BwMQ5Du9S
	MjoMLxc3psswzk82COP6OWmBemhxKq4Pekod26HNg+os4y1ohLgzCHBvxiYNyVc=
X-Google-Smtp-Source: AGHT+IFiooSVLGKasJXv5QQqpuG9fGOdqW49NUZw7fb/Sv5/TGuOhq8T4CYzbZGe97Gj0skSrum6Gg==
X-Received: by 2002:a05:600c:46cf:b0:426:64f4:7793 with SMTP id 5b1f17b1804b1-429ed7af3d8mr14557135e9.22.1723795966184;
        Fri, 16 Aug 2024 01:12:46 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed6593casm16021205e9.28.2024.08.16.01.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:12:45 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v2 3/7] thermal/core: Connect the threshold with the core
Date: Fri, 16 Aug 2024 10:12:34 +0200
Message-ID: <20240816081241.1925221-4-daniel.lezcano@linaro.org>
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

Initialize, de-initialize and handle the threshold in the same place
than the trip points.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 166f48071487..0a4d7f6e5cf5 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -591,6 +591,8 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 			high = td->threshold;
 	}
 
+	thermal_thresholds_handle(tz, &low, &high);
+
 	thermal_zone_set_trips(tz, low, high);
 
 	list_sort(NULL, &way_up_list, thermal_trip_notify_cmp);
@@ -1561,6 +1563,10 @@ thermal_zone_device_register_with_trips(const char *type,
 			goto unregister;
 	}
 
+	result = thermal_thresholds_init(tz);
+	if (result)
+		goto remove_hwmon;
+
 	mutex_lock(&thermal_list_lock);
 	mutex_lock(&tz->lock);
 	list_add_tail(&tz->node, &thermal_tz_list);
@@ -1581,6 +1587,8 @@ thermal_zone_device_register_with_trips(const char *type,
 
 	return tz;
 
+remove_hwmon:
+	thermal_remove_hwmon_sysfs(tz);
 unregister:
 	device_del(&tz->device);
 release_device:
@@ -1669,6 +1677,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	thermal_set_governor(tz, NULL);
 
+	thermal_thresholds_exit(tz);
 	thermal_remove_hwmon_sysfs(tz);
 	ida_free(&thermal_tz_ida, tz->id);
 	ida_destroy(&tz->ida);
-- 
2.43.0


