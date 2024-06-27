Return-Path: <linux-pm+bounces-10101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AA591A1F1
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 10:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C51028283B
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 08:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646E012F59C;
	Thu, 27 Jun 2024 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C4yNgCQQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DEF1BF3A
	for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719478511; cv=none; b=NAyWwJfnRWb4jgPc/VQO8a3xxHd+1vkB6svMlvcJNrJpd+PFyHDB8Yqcokap70H8N/b2ges0uDJt5gPrek9a2/+/8EWojxEe1F84xLr4ltOFZpAK8UYEzDFWeyCFZ9cmPZCPiXfjnE4X/nL2mxNrEmTYvmkYxhenr+4CFor+M+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719478511; c=relaxed/simple;
	bh=SI2NAcJ6q+eLkk/ZtOIC2QQh9qcIfBfjVIAfw9BpKPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cRLmB+ukCuXbf8NzpGWjWHE7VhYxdFf547mlhG4kAC5MI8czXXO2RaJxpzCL5hLOqq2eKIb0F+94i5q3RNjZAJUw6MKxAZLotQlCMBcE5QDXT0ix9VIf2wuz7mtWJ4lGfQ11sKt4+1kzxA4tnz1BMfsmgnw8DT6ZU+WrKnFc2G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C4yNgCQQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3658197cdbbso4109029f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2024 01:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719478508; x=1720083308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vKY1wHGd2jQTX6s0Vwl5LhsVj1svO/w7qYtrjohC76E=;
        b=C4yNgCQQcqwK8sYUN+inyelMWAvifdIvOUc4qrfbDoP1PpbqnlOwCqoZUItl9WwE8v
         0u5yjd9HqJ9JceERD65hiU6VX8T0dODaxI262VV2u6CHndgEgDcAu+lcz9aoarItc8NK
         RPqG6EECZCCoevIWVGVx/2268d82LYm1OzxZIhN5JlPzbncJzbaD0IZ2FwvVhSeLLL9u
         0MzGQ857N7PJM9SGfhv+0uKemFJC6d7alZwZ9xih/lZLkuqU328JVEO/lEe3NW0vq4xE
         iieL8+ihkJi2Rwk1XPYXHLf9zUj0hQ2tT6fKkb681Q02MT37eNw6gr6uSnfGhI7e6YDG
         lQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719478508; x=1720083308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKY1wHGd2jQTX6s0Vwl5LhsVj1svO/w7qYtrjohC76E=;
        b=h7KYgxfPd4r21kRfDuefulpM/aq5oLDav3cKBqPiKgcwwxJFmJguXe0RKxgsa6H/43
         e5+eCaOc5CiybElioGlnQGyVhFJ1epCjSxedGt4tOpVfFUx+rvGCHao6s3StBqnK773v
         ivXatuPfGt7RuIQBMwwXKZ6eqTfxiQF84I1MqXFZX2lE/wB1mGGeg66Ex4Rr17YtPIzw
         z7yV1KFw4WBsSvVET081hPKQntpErlyALQiQtv2S64OAWzyTvtdrvoxEUICi/ZbSdfdx
         Bk7vE1yYriyCr7vAHNVjyHhlud43EngbdVQHEIV0Xui3OAf+vCXxcr0k9SgCYB8k1SGz
         farg==
X-Gm-Message-State: AOJu0YzslbqGg10JjlfieZ7aq6U3RIa7n2K8LDgutXkb9qC9rgZ7n4Vn
	VrRTMDv/25A/J/blKN+mIn3a9H2+Ke4w0z4h4krYo6RhK5CiM6NoAnorC+N1P0Q=
X-Google-Smtp-Source: AGHT+IHEWMZlrh+0IzebfjKN3mv79RoRRsGd5oIJLnGSgpvqNtF686X76HGwtDXthWglJFJExrD3Xw==
X-Received: by 2002:a5d:4c86:0:b0:360:727b:8b47 with SMTP id ffacd0b85a97d-366e9629df0mr9071070f8f.63.1719478507878;
        Thu, 27 Jun 2024 01:55:07 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36743699a70sm1138883f8f.82.2024.06.27.01.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 01:55:07 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/core: Introduce user trip points
Date: Thu, 27 Jun 2024 10:54:50 +0200
Message-ID: <20240627085451.3813989-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently the thermal framework has 4 trip point types:

- active : basically for fans (or anything requiring energy to cool
  down)

- passive : a performance limiter

- hot : for a last action before reaching critical

- critical : a without return threshold leading to a system shutdown

A thermal zone monitors the temperature regarding these trip
points. The old way to do that is actively polling the temperature
which is very bad for embedded systems, especially mobile and it is
even worse today as we can have more than fifty thermal zones. The
modern way is to rely on the driver to send an interrupt when the trip
points are crossed, so the system can sleep while the temperature
monitoring is offloaded to a dedicated hardware.

However, the thermal aspect is also managed from userspace to protect
the user, especially tracking down the skin temperature sensor. The
logic is more complex than what we found in the kernel because it
needs multiple sources indicating the thermal situation of the entire
system.

For this reason it needs to setup trip points at different levels in
order to get informed about what is going on with some thermal zones
when running some specific application.

For instance, the skin temperature must be limited to 43°C on a long
run but can go to 48°C for 10 minutes, or 60°C for 1 minute.

The thermal engine must then rely on trip points to monitor those
temperatures. Unfortunately, today there is only 'active' and
'passive' trip points which has a specific meaning for the kernel, not
the userspace. That leads to hacks in different platforms for mobile
and embedded systems where 'active' trip points are used to send
notification to the userspace. This is obviously not right because
these trip are handled by the kernel.

This patch introduces the 'user' trip point type where its semantic is
simple: do nothing at the kernel level, just send a notification to
the user space.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../devicetree/bindings/thermal/thermal-zones.yaml        | 1 +
 drivers/thermal/thermal_core.c                            | 8 ++++++++
 drivers/thermal/thermal_of.c                              | 1 +
 drivers/thermal/thermal_trace.h                           | 4 +++-
 drivers/thermal/thermal_trip.c                            | 1 +
 include/uapi/linux/thermal.h                              | 1 +
 6 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 68398e7e8655..cb9ea54a192e 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -153,6 +153,7 @@ patternProperties:
               type:
                 $ref: /schemas/types.yaml#/definitions/string
                 enum:
+                  - user     # enable user notification
                   - active   # enable active cooling e.g. fans
                   - passive  # enable passive cooling e.g. throttling cpu
                   - hot      # send notification to driver
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2aa04c46a425..506f880d9aa9 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -734,6 +734,14 @@ int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
 	if (tz != pos1 || cdev != pos2)
 		return -EINVAL;
 
+	/*
+	 * It is not allowed to bind a cooling device with a trip
+	 * point user type because no mitigation should happen from
+	 * the kernel with these trip points
+	 */
+	if (trip->type == THERMAL_TRIP_USER)
+		return -EINVAL;
+
 	/* lower default 0, upper default max_state */
 	lower = lower == THERMAL_NO_LIMIT ? 0 : lower;
 
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index aa34b6e82e26..f6daf921a136 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -60,6 +60,7 @@ static const char * const trip_types[] = {
 	[THERMAL_TRIP_PASSIVE]	= "passive",
 	[THERMAL_TRIP_HOT]	= "hot",
 	[THERMAL_TRIP_CRITICAL]	= "critical",
+	[THERMAL_TRIP_USER]	= "user",
 };
 
 /**
diff --git a/drivers/thermal/thermal_trace.h b/drivers/thermal/thermal_trace.h
index df8f4edd6068..739228ecc2e2 100644
--- a/drivers/thermal/thermal_trace.h
+++ b/drivers/thermal/thermal_trace.h
@@ -15,13 +15,15 @@ TRACE_DEFINE_ENUM(THERMAL_TRIP_CRITICAL);
 TRACE_DEFINE_ENUM(THERMAL_TRIP_HOT);
 TRACE_DEFINE_ENUM(THERMAL_TRIP_PASSIVE);
 TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
+TRACE_DEFINE_ENUM(THERMAL_TRIP_USER);
 
 #define show_tzt_type(type)					\
 	__print_symbolic(type,					\
 			 { THERMAL_TRIP_CRITICAL, "CRITICAL"},	\
 			 { THERMAL_TRIP_HOT,      "HOT"},	\
 			 { THERMAL_TRIP_PASSIVE,  "PASSIVE"},	\
-			 { THERMAL_TRIP_ACTIVE,   "ACTIVE"})
+			 { THERMAL_TRIP_ACTIVE,   "ACTIVE"}),	\
+			 { THERMAL_TRIP_USER,     "USER"})
 
 TRACE_EVENT(thermal_temperature,
 
diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
index 2a876d3b93aa..a0780bb4ff0d 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -10,6 +10,7 @@
 #include "thermal_core.h"
 
 static const char *trip_type_names[] = {
+	[THERMAL_TRIP_USER] = "user",
 	[THERMAL_TRIP_ACTIVE] = "active",
 	[THERMAL_TRIP_PASSIVE] = "passive",
 	[THERMAL_TRIP_HOT] = "hot",
diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
index fc78bf3aead7..84e556ace5f5 100644
--- a/include/uapi/linux/thermal.h
+++ b/include/uapi/linux/thermal.h
@@ -14,6 +14,7 @@ enum thermal_trip_type {
 	THERMAL_TRIP_PASSIVE,
 	THERMAL_TRIP_HOT,
 	THERMAL_TRIP_CRITICAL,
+	THERMAL_TRIP_USER,
 };
 
 /* Adding event notification support elements */
-- 
2.43.0


