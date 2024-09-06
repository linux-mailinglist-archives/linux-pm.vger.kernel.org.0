Return-Path: <linux-pm+bounces-13753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183A996EC1A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 09:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA27286D43
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 07:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8E014D71E;
	Fri,  6 Sep 2024 07:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CmResphr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84FD14A4F9
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 07:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608205; cv=none; b=ES4VHw1BfzmJ2cd3XrZPNit+/6JFAyAS+kKPFEhHqiYIhWSdWI+PGLJV4Mdjr82risF5Xk0TCU3y9Uqbuxb7M/MSFxOGqyH/idArIzq2IjZfllf8xocmREWVkJQZ4yufRqzRpj20YoYi/zXWs2OSnrtW/3k/eWAnz4c1aHO0WvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608205; c=relaxed/simple;
	bh=hRHUZWNBRBBBhXG2LassEoFnbO4yYqxjMwt+KYdVz8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2JxbGqwJtSP4vHpgl724Cwi9cwsgEaE3N3HY2qxeVEYuTe6L6entjHTkpNYWWCYSzgYaJ6wovkV5WT4GJ12QcDqt1NidNaHmyVc/VFwKvgew9FIIPA6fglwaESfqBgA0MHT/TSIzzWRlrGqHCtSuD4reVqsx1GaWh1b+FWTu84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CmResphr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42c2e50ec13so12800305e9.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2024 00:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725608202; x=1726213002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tpN2Nl13nfZC4C+6DjPUyufSNI/4p/GtcJP4T20sd4=;
        b=CmResphrdHGv7SL4oBEbs6RqMVyIOHCYXsFPiy7BZDw7u8Lna0pKyOf6HROLYKbUw6
         Q6PQxNWtmMrVIgK8IU235fUgowTrB2b8NovehthWokUi4YmkkX+YtVFtU9BiH+YICqDG
         MUHIaBNnYIqYyRvBg4kkd0Ae3sOQ13UBlrFxwLZowhCEKKGpH0Eei5QYOdRP4a296C0k
         J/aiJcdb1Ude8KYm/jul6FUKgA+d6PB2V/2LIHxVtnzqxgTo3qBQBkznoKymVzg99VMC
         +bybkuActNE+6gQv1TiZXtF9WH4+8iAefbzp4NNx+mxyEO9FMohSOr20MyQ/axsMYN1f
         Gmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725608202; x=1726213002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tpN2Nl13nfZC4C+6DjPUyufSNI/4p/GtcJP4T20sd4=;
        b=mYlkWrVu9iUt6enTi18fxKcDFso6ehFc+oRPtvNBEkc8dJVDgvKoHokDPLrZezb2YC
         42rvlDpJYA8n1vOGk7aiJZ8eWEa1A36sgkosV384VaFhoThIY+HycWYVrzsbQtz2um2F
         y6js/9GcEqRV5aFmw7LGvwLIiZbmdDlwpI8+ppxt5sCuZ3XYzHEXsT+mTQu0pTdAeodU
         4kubpNwhfBni06p0DU5jAmTM7O7A2Pg8/o6Fo39KfM5PsWrkuKhtR6kSUJJ/M+6aDSfJ
         uRLadMeeO9bVzPT/8LhOW7Jx/WsY89e1Uk8yVF45mQIaoGKbUrcidzNJonhYAmSvOkkw
         kusw==
X-Gm-Message-State: AOJu0YxWofisvHqzxjcnWGngz75ZjLoQHcMttkaf0fMDDA2v2b0YyQM4
	/aOWL7jm99R9cO9CqpzMW3AFR0tdV74nj8UQtS5rfaiRza55R+T5K1ZFJ00cLWE=
X-Google-Smtp-Source: AGHT+IF0ypQrWt/Fz8gfKUvkWvIFqJz1YPbvF5q1iiQkHF7Dd6StLbciz0qKuUmhyCz7ZPefXXt36A==
X-Received: by 2002:a5d:6905:0:b0:374:c454:dbb3 with SMTP id ffacd0b85a97d-378896a00b4mr760938f8f.55.1725608201963;
        Fri, 06 Sep 2024 00:36:41 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-376914bfca1sm8113885f8f.18.2024.09.06.00.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 00:36:41 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v3 2/6] thermal/core: Connect the threshold with the core
Date: Fri,  6 Sep 2024 09:36:23 +0200
Message-ID: <20240906073631.1655552-3-daniel.lezcano@linaro.org>
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

Initialize, de-initialize and handle the threshold in the same place
than the trip points.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 4187f207bce9..74db689dc78a 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -595,6 +595,8 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 			high = td->threshold;
 	}
 
+	thermal_thresholds_handle(tz, &low, &high);
+
 	thermal_zone_set_trips(tz, low, high);
 
 	list_sort(NULL, &way_up_list, thermal_trip_notify_cmp);
@@ -1514,6 +1516,10 @@ thermal_zone_device_register_with_trips(const char *type,
 			goto unregister;
 	}
 
+	result = thermal_thresholds_init(tz);
+	if (result)
+		goto remove_hwmon;
+
 	mutex_lock(&thermal_list_lock);
 
 	mutex_lock(&tz->lock);
@@ -1537,6 +1543,8 @@ thermal_zone_device_register_with_trips(const char *type,
 
 	return tz;
 
+remove_hwmon:
+	thermal_remove_hwmon_sysfs(tz);
 unregister:
 	device_del(&tz->device);
 release_device:
@@ -1624,6 +1632,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	thermal_set_governor(tz, NULL);
 
+	thermal_thresholds_exit(tz);
 	thermal_remove_hwmon_sysfs(tz);
 	ida_free(&thermal_tz_ida, tz->id);
 	ida_destroy(&tz->ida);
-- 
2.43.0


