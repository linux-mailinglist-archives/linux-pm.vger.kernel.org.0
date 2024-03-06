Return-Path: <linux-pm+bounces-4721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B302A873177
	for <lists+linux-pm@lfdr.de>; Wed,  6 Mar 2024 09:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367521F22936
	for <lists+linux-pm@lfdr.de>; Wed,  6 Mar 2024 08:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EE15D8EF;
	Wed,  6 Mar 2024 08:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xOoma8gc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EFA23772
	for <linux-pm@vger.kernel.org>; Wed,  6 Mar 2024 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715292; cv=none; b=RNlEH8lbjLxZGzOf6aBD2umycJJRZCcbwU0RmWGsbXmDp56hCp9NWN3m0KAYCk0O1P/V9+YNoK0lT+tYRYUiytUEDdp9szI5m+JcP3DsnGEnI5TTd5py1K5FBF4qxq6jInpGmZrzM2XR0KvbVAQTRJ1UnDG74IoAMWmglURtx1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715292; c=relaxed/simple;
	bh=AHnfFU/ciQmYhYMIVQzkLCBGqeFnJdD975lYVra0ZhE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=q0AsjvxEX8Iomgb8Twpsun8w0dE7cOYGQpmlut4nmZTdq/6coNi1+g8sPv2SB7C54j4+Ef6RhF7idcP3Rqywz9aTKJOviRLQlZIdyJ3Qgn26PRI5P+NeYoON/9O39CQHFA5/uJ7q/bWhOFJP27/ZX+Q7M3guAKIvRjFIAqH5a6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xOoma8gc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412f62ee005so2615375e9.2
        for <linux-pm@vger.kernel.org>; Wed, 06 Mar 2024 00:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709715289; x=1710320089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m47Yif6fknoeZ44AEL0U4rZRKtyEZdovAlUMxK0WbaE=;
        b=xOoma8gcOoi0dHNRPZFa2qJySP0WJCFST15DbYYCqboR65dCMZZPvPH7UNHYIfBZz1
         C8u2bcWxAuMcOiQzW27boP4wghXscUS1SpCNe1bpFTrcVTUZ/wc3hFKQGj1Es3aFuwqA
         is1SfmNh5kIsTa/3pXwri4Lwcg5TT1GLkT2GuNHNdTJfffDY5/j7+IHUxckRGuwyRKRo
         C97y8xpYQBCkWCGahAn5CdgC5QW0cpPxeNruYRAFLEZbKqTRMBGC0u8p+VmjAeNedNHl
         OmGmkFHJ6iPxG+HLDHPrGs8qiyRxaHF3c6GBlGFuC5o6528mozlHpN1WHyaEhqRH/Jnw
         C/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709715289; x=1710320089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m47Yif6fknoeZ44AEL0U4rZRKtyEZdovAlUMxK0WbaE=;
        b=PQXjt1lYpd31t5KsnlRH/oRXtlC6nC3EyJvS/ETjcpMOdQfjYe/WnDhPWH1rZ/4cFH
         Jj43sLYLAXvi9oqlI7D/8S8oTg0DvO5Yy6Qy6a9rG4Sz/UT+/AxUE5tTyMfwFJWI1Glx
         deYFuEE5kRpT+YHAZIc+e7PjNhLFe1iKqBvEHZCf/7BPZuuPGD4yX1GGLskRPKGswR41
         Xkbk0rPqWy8BCXZkHlHJ6oi7KZRUYvnGW0lOaQN09yBfIpcK8064rcqjaJNaF4W9WIxk
         gw+fFHseQ3LzcosAeSoQpYbXy2+LwdObyc5/iAJXxl1EB5Ee5NZm8h3CuSygw8WDQDm5
         R92A==
X-Forwarded-Encrypted: i=1; AJvYcCWVNPhwS3T4z8HQMjApFhQXS2iN1VHE5i9yoPMpnYjuHDUXg/BiyOVjftEvp4q/GYWqkOjjYZfMFmTNhXWSCEUHGEplYJfvzbU=
X-Gm-Message-State: AOJu0YwEY8Y3CiNjwhyqB2kr7yBAj9oIvwA5uOU7gPCzOWkvIxeNxIB5
	cboxA54QN2bq8SYrrU3SenUZQLB/9FwzjDBML0Itn5CroK4kzLR/fuLa+Ij79yQ=
X-Google-Smtp-Source: AGHT+IHpRaA9YTSfOpHeWoIzyjTYnpf7UkUY+q20MAdg98y2Wh9yU7XAywmu45vKlP3/corXblLfrw==
X-Received: by 2002:a05:600c:3146:b0:412:f1cb:b5be with SMTP id h6-20020a05600c314600b00412f1cbb5bemr1394547wmo.3.1709715288811;
        Wed, 06 Mar 2024 00:54:48 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id s14-20020a05600c45ce00b00412f855bc7asm647219wmo.1.2024.03.06.00.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 00:54:48 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [RFC PATCH] thermal/core: Fix trip point crossing events ordering
Date: Wed,  6 Mar 2024 09:54:28 +0100
Message-Id: <20240306085428.88011-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Let's assume the following setup:

 - trip 0 = 65°C
 - trip 1 = 70°C
 - trip 2 = 75°C

The current temperature is 35°C.

The interrupt is setup to fire at 65°C. If the thermal capacity is
saturated it is possible the temperature jumps to 72°c when reading
the temperature after the interrupt fired when 65°C was crossed. That
means we should have two events notified to userspace. The first one
for trip 0 and the second one for trip 1.

When the function thermal_zone_update() is called from the threaded
interrupt, it will read the temperature and then call for_each_trip()
which in turns call handle_trip_point().

This function will check:

     if (tz->last_temperature < trip->temperature &&
     	tz->temperature >= trip->temperature)
			thermal_notify_tz_trip_up()

So here, we will call this function with trip0 followed by trip1. That
will result in an event for each trip point, reflecting the trip point
being crossed the way up with a temperature raising. So far, so good.

Usually the sensors have an interrupt when the temperature is crossed
the way up but not the way down, so there an extra delay corresponding
to the passive polling where the temperature could have dropped and
crossed more than one trip point. This scenario is likely to happen
more often when multiple trip points are specified. So considering the
same setup after crossing the trip 2, we stop the workload responsible
of the heat and the temperature drops suddenly to 62°C. In this case,
the next polling will call thermal_zone_device_update(), then
for_each_trip() and handle_trip_point().

This function will check:

     if (tz->last_temperature >= trip->temperature &&
     	tz->temperature < trip->temperature - trip->hysteresis)
			thermal_notify_tz_trip_down()

The loop for_each_trip() will call trip0, 1 and 2. That will result in
generating the events for trip0, 1 and 2, in the wrong order. That is
not reflecting the thermal dynamic and puzzles the userspace
monitoring the temperature.

Fix this by inspecting the trend of the temperature. If it is raising,
then we browse the trip point in the ascending order, if it is falling
then we browse in the descending order.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 8 ++++++--
 drivers/thermal/thermal_core.h | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index dfaa6341694a..abb8ee5c9afe 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -473,8 +473,12 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 
 	tz->notify_event = event;
 
-	for_each_trip(tz, trip)
-		handle_thermal_trip(tz, trip);
+	if (tz->last_temperature < tz->temperature)
+		for_each_trip(tz, trip)
+			handle_thermal_trip(tz, trip);
+	else
+		for_each_trip_reverse(tz, trip)
+			handle_thermal_trip(tz, trip);
 
 	monitor_thermal_zone(tz);
 }
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index e9c099ecdd0f..0072b3d4039e 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -123,6 +123,9 @@ void thermal_governor_update_tz(struct thermal_zone_device *tz,
 #define for_each_trip(__tz, __trip)	\
 	for (__trip = __tz->trips; __trip - __tz->trips < __tz->num_trips; __trip++)
 
+#define for_each_trip_reverse(__tz, __trip)	\
+	for (__trip = &__tz->trips[__tz->num_trips - 1]; __trip >= __tz->trips ; __trip--)
+
 void __thermal_zone_set_trips(struct thermal_zone_device *tz);
 int thermal_zone_trip_id(const struct thermal_zone_device *tz,
 			 const struct thermal_trip *trip);
-- 
2.34.1


