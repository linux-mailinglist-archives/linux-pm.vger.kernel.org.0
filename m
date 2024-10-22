Return-Path: <linux-pm+bounces-16243-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF32B9AB2C4
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 17:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4371F22AF4
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 15:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C788A1BC07B;
	Tue, 22 Oct 2024 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mriwX4wi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DD819F10A
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612318; cv=none; b=scDl3Leth/2UIKRbeFz4zsyMUXyZsTT9vqvAp8rz+sNdZEIfDmkDBX+CVZ2R9x84uia6x1aqQyrSklFO6/Cbb0Istt/tZRDZUxvbJuZkKDG74MN8miD9UFUCctt+ldCJS9ZfyYiv/a+v6cMrz/2NMkQb93h0TWzjOwe/ty64uag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612318; c=relaxed/simple;
	bh=jYFqmanAtC4z3Xv9g2sjeBSkmmn4JD6BhtS3wjKfxKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9/vjZDnpi8RHcHQ69ahJhpZOiNlN4x+xWvaTVXtInHvaEwFTwGKU3pBYFEEqZI/tPDNRH3SvG9w6Av1dHg9aXZAvLoFubRt9Ol12ZZEb0ToaUyaGXpcumepecguwohDx0uEGV9ZEkVFYsBHTl38IPxbJqkS1PQXgOoyxmHaono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mriwX4wi; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d63a79bb6so4435974f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 08:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729612315; x=1730217115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZE0q2U/Fta68Sa8AGydENIt604JqyWqTTBMJpPleP9s=;
        b=mriwX4wiJ9V+wKXlMxza5JyGQ02dCeY9jA06JO/VEqf4YLoKsKgFbxfAKrb01BJ6XL
         aNVfVbVx5C1gRTNSmA5VO0CiwhxGSmky50TP4ctebPY7ZBoQqZpAz41oZh9DupoOtUQK
         AJqP6npnfo1FYzl/HCvELvSXWLJQov3pyyvn8R3FzBA/gx1PTZNx9Mtnd1EWBT47yjI8
         Gq+IjNGoMSsMR19TE4zb5yMKlMvHtwGfg71riu3CMmHK1j+hvc6CKnufQWLI1Usz8nI/
         cPKhsEDED/0FixcSN0oJ8maVwNuHG5bmmRChlBPCBGWn2l3oiMGNMXucW1FBKC2YO/pW
         4gSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729612315; x=1730217115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZE0q2U/Fta68Sa8AGydENIt604JqyWqTTBMJpPleP9s=;
        b=FapXBVQnIkhEJlITyYlb5It134eZHlL9bB4KWTETex09ELBLh1w8FTvUlf5MVS9KLu
         gwLoazOdCzv3ZQ5CZaBpgtIgk8pTSbNtu4BNot9aHJJDWxETmmkSdH20B41XOgExCZEy
         0sLQNFLswsm38sHf87hZi6tn1kYqBJnKRX9zDIOu/Mt1MHqiE66+4njgXdFjUWtfF6RM
         b40dgOJjfg9NSORBQxmrEkt5ww4WA7Uu9HBiVCHUJc9Ea0TBVZCSXMP4lKgRcEhnIU31
         5wyK5ZrIo1IOuzs8fbwzmkqDAk3vh1UYDoZ++Oor4yZL0vLGiKLr1Poc8iSVKDQ2pMg5
         ufag==
X-Gm-Message-State: AOJu0YzOdJ8klrh9QWYr5ncZoAjv7MfVbaCF255ulu//0hq9xLyWgFDr
	6exPGZDUOMZf6aj+URACuryPqxHk80AKPI7dV4oq2aCn490JGVJnCYZxhqwSeu0=
X-Google-Smtp-Source: AGHT+IEXX673aPeKbBpjqbNortBxM29PyZzCOlSqAG13qbabpBDiFRe6VKrx034Ve9CJ9lCRL4Y41Q==
X-Received: by 2002:a5d:4349:0:b0:37d:5143:c695 with SMTP id ffacd0b85a97d-37ef21bb2femr2164511f8f.53.1729612315323;
        Tue, 22 Oct 2024 08:51:55 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58aef6sm91538075e9.22.2024.10.22.08.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 08:51:55 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	quic_manafm@quicinc.com,
	lukasz.luba@arm.com
Subject: [PATCH v6 1/5] thermal: core: Connect the threshold with the core
Date: Tue, 22 Oct 2024 17:51:41 +0200
Message-ID: <20241022155147.463475-2-daniel.lezcano@linaro.org>
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

Initialize, de-initialize and handle the threshold in the same place
than the trip points.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://patch.msgid.link/20240923100005.2532430-3-daniel.lezcano@linaro.org
[ rjw: Subject edit ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 8f03985f971c..1e87256e86be 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -585,6 +585,8 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 			high = td->threshold;
 	}
 
+	thermal_thresholds_handle(tz, &low, &high);
+
 	thermal_zone_set_trips(tz, low, high);
 
 	list_sort(NULL, &way_up_list, thermal_trip_notify_cmp);
@@ -1491,6 +1493,10 @@ thermal_zone_device_register_with_trips(const char *type,
 			goto unregister;
 	}
 
+	result = thermal_thresholds_init(tz);
+	if (result)
+		goto remove_hwmon;
+
 	mutex_lock(&thermal_list_lock);
 
 	mutex_lock(&tz->lock);
@@ -1514,6 +1520,8 @@ thermal_zone_device_register_with_trips(const char *type,
 
 	return tz;
 
+remove_hwmon:
+	thermal_remove_hwmon_sysfs(tz);
 unregister:
 	device_del(&tz->device);
 release_device:
@@ -1601,6 +1609,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	thermal_set_governor(tz, NULL);
 
+	thermal_thresholds_exit(tz);
 	thermal_remove_hwmon_sysfs(tz);
 	ida_free(&thermal_tz_ida, tz->id);
 	ida_destroy(&tz->ida);
-- 
2.43.0


