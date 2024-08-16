Return-Path: <linux-pm+bounces-12318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4FF9543BE
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C77F1C21CFE
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 08:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25031369BB;
	Fri, 16 Aug 2024 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oiycLYzx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852DE82866
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795972; cv=none; b=lTIjlAFvqHvi6UeWAMdEH6gXf/7rKipw7ZfmrL/TPu18QDR94Ekaiw0AZXlgbeUde5DNp8jCpYO7+SMBq4pUjWOTDxQ8+EWQth3kA00pxRaG2g4vpBuSyCQo+7qJRA4ks092czUywkHFwoR9WTIUOEqeJSOfceGmWKMmHJFg4o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795972; c=relaxed/simple;
	bh=OnYyHrw0OVCt42yLMry7RBzmbTCZJWDc505lUeqSeus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2B16fP6+YCKxoag7h/Zg7rTLt2hDGDpeO2+E28C/a0jn/HL6OyDHtY5hX7eSakpXxICEQ56sqUUvlaud0Bfe81VvjQKgbY3bMs1Bl1y48DXzaYTxZZtIAo1oORE+oQjplkGN4sBOYPzkT1V5RtG7IPKXDq3vIMsNZwcmBRB+/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oiycLYzx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-429ec9f2155so6302575e9.2
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 01:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723795969; x=1724400769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaMSbRq616CiKnWW4VcljfAj49EnVXHHRWjN6wlUnNw=;
        b=oiycLYzxzHF9pbYmPsYjpxVMaHrbCrmgc0fuWe08amTN2yP30XjdUbLA8uSGiIdSM+
         XK2jFzhZW0B14bdjUYegt7X5TRkcI7BZahy0nUZIeGsL4lAka0N2xjRZ20ZHJQkZbxUM
         UVyk1jOYbVZy0WPPixwgWpoJlOWIpvISsqGvT65tVitbh3rZPCNNfXHFXWsb2E4ehXDc
         GBmu7GM+0brXaqzW3nDU9CZ8NR4ZAQbNcSn/ifmZM96RoebbAhxnT/s5Sul1x2D92wbc
         3ol+dJ1vXVTshAZUVNTNgi4bZaHqFpfkEK+lGrRwv4v/0U1kWjUL2bMznboRhXrlVaTb
         C0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723795969; x=1724400769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaMSbRq616CiKnWW4VcljfAj49EnVXHHRWjN6wlUnNw=;
        b=cLo4ix2IXYKC2psbGdrNDUqR2kh9oaUu/ZVivI0IwMyavCsB8IghoM/dYO7kp+4BTv
         /Fe3ZGy3G0EBnDlegCHozox44ui5mIri6tpHhpxqgtvMtXRkbgaVZIuVkuJGK4dRlhV7
         6DqDEpVXQRTVpju3R9Q+zeEvosK6uQ0oya/DhmYXn5XZxNm7YoaUavM1aN+VotbcyiIy
         QthAI5yQTfbRc+UDNBDwSbwse43qurX6mzquAPFvW4at7XvKGPgGDa/JdiH1s1HSlJsy
         m7PxETDODfpDPsHuL/vpdr/yZawvLV2GMygp+gFSXxzOk8ypcj/6JQm4L62Mjno4X1iV
         QkMw==
X-Gm-Message-State: AOJu0YwVguNbZekCRViT5zfyOKfhNMhjNdKwq/TD39U0dHGA//51V8X3
	P+dmGtnprQcGxHkVO3NIR7C5N6azVM/WDBROoFVSGJTH2YLRniaWk+Bcq4bptts=
X-Google-Smtp-Source: AGHT+IES7KJ9/tBJ45yUiYGMzmlY/Au31C6cjofsCckRXuYRh9sELozC2DLieZIFf0NHC1yR6Fhnug==
X-Received: by 2002:a05:600c:4e8c:b0:428:31c:5a52 with SMTP id 5b1f17b1804b1-429ed7cc764mr15624685e9.29.1723795968447;
        Fri, 16 Aug 2024 01:12:48 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed6593casm16021205e9.28.2024.08.16.01.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:12:48 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v2 6/7] tools/lib/thermal: Add the threshold netlink ABI
Date: Fri, 16 Aug 2024 10:12:37 +0200
Message-ID: <20240816081241.1925221-7-daniel.lezcano@linaro.org>
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

The thermal framework supports the thresholds and allows the userspace
to create, delete, flush, get the list of the thresholds as well as
getting the list of the thresholds set for a specific thermal zone.

Add the netlink abstraction in the thermal library to take full
advantage of thresholds for the userspace program.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 tools/lib/thermal/commands.c        | 128 +++++++++++++++++++++++++++-
 tools/lib/thermal/events.c          |  58 ++++++++++---
 tools/lib/thermal/include/thermal.h |  40 +++++++++
 tools/lib/thermal/libthermal.map    |   5 ++
 tools/lib/thermal/thermal.c         |  17 ++++
 tools/thermal/lib/Makefile          |   2 +-
 6 files changed, 235 insertions(+), 15 deletions(-)

diff --git a/tools/lib/thermal/commands.c b/tools/lib/thermal/commands.c
index a9223df91dcf..12539a519b81 100644
--- a/tools/lib/thermal/commands.c
+++ b/tools/lib/thermal/commands.c
@@ -5,6 +5,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <limits.h>
 
 #include <thermal.h>
 #include "thermal_nl.h"
@@ -33,6 +34,11 @@ static struct nla_policy thermal_genl_policy[THERMAL_GENL_ATTR_MAX + 1] = {
 	[THERMAL_GENL_ATTR_CDEV_CUR_STATE]      = { .type = NLA_U32 },
 	[THERMAL_GENL_ATTR_CDEV_MAX_STATE]      = { .type = NLA_U32 },
 	[THERMAL_GENL_ATTR_CDEV_NAME]           = { .type = NLA_STRING },
+
+        /* Thresholds */
+        [THERMAL_GENL_ATTR_THRESHOLD]      	= { .type = NLA_NESTED },
+        [THERMAL_GENL_ATTR_THRESHOLD_TEMP]      = { .type = NLA_U32 },
+        [THERMAL_GENL_ATTR_THRESHOLD_WAY]       = { .type = NLA_U32 },
 };
 
 static int parse_tz_get(struct genl_info *info, struct thermal_zone **tz)
@@ -182,6 +188,38 @@ static int parse_tz_get_gov(struct genl_info *info, struct thermal_zone *tz)
 	return THERMAL_SUCCESS;
 }
 
+static int parse_threshold_get(struct genl_info *info, struct thermal_zone *tz)
+{
+	struct nlattr *attr;
+	struct thermal_threshold *__tt = NULL;
+	size_t size = 0;
+	int rem;
+
+	nla_for_each_nested(attr, info->attrs[THERMAL_GENL_ATTR_THRESHOLD], rem) {
+
+		if (nla_type(attr) == THERMAL_GENL_ATTR_THRESHOLD_TEMP) {
+
+			size++;
+
+			__tt = realloc(__tt, sizeof(*__tt) * (size + 2));
+			if (!__tt)
+				return THERMAL_ERROR;
+
+			__tt[size - 1].temperature = nla_get_u32(attr);
+		}
+
+		if (nla_type(attr) == THERMAL_GENL_ATTR_THRESHOLD_WAY)
+			__tt[size - 1].direction = nla_get_u32(attr);
+	}
+
+	if (__tt)
+		__tt[size].temperature = INT_MAX;
+
+	tz->thresholds = __tt;
+
+	return THERMAL_SUCCESS;
+}
+
 static int handle_netlink(struct nl_cache_ops *unused,
 			  struct genl_cmd *cmd,
 			  struct genl_info *info, void *arg)
@@ -210,6 +248,10 @@ static int handle_netlink(struct nl_cache_ops *unused,
 		ret = parse_tz_get_gov(info, arg);
 		break;
 
+	case THERMAL_GENL_CMD_THRESHOLD_GET:
+		ret = parse_threshold_get(info, arg);
+		break;
+
 	default:
 		return THERMAL_ERROR;
 	}
@@ -253,6 +295,34 @@ static struct genl_cmd thermal_cmds[] = {
 		.c_maxattr	= THERMAL_GENL_ATTR_MAX,
 		.c_attr_policy	= thermal_genl_policy,
 	},
+        {
+                .c_id           = THERMAL_GENL_CMD_THRESHOLD_GET,
+                .c_name         = (char *)"Get thresholds list",
+                .c_msg_parser   = handle_netlink,
+                .c_maxattr      = THERMAL_GENL_ATTR_MAX,
+                .c_attr_policy  = thermal_genl_policy,
+        },
+        {
+                .c_id           = THERMAL_GENL_CMD_THRESHOLD_ADD,
+                .c_name         = (char *)"Add a threshold",
+                .c_msg_parser   = handle_netlink,
+                .c_maxattr      = THERMAL_GENL_ATTR_MAX,
+                .c_attr_policy  = thermal_genl_policy,
+        },
+        {
+                .c_id           = THERMAL_GENL_CMD_THRESHOLD_DELETE,
+                .c_name         = (char *)"Delete a threshold",
+                .c_msg_parser   = handle_netlink,
+                .c_maxattr      = THERMAL_GENL_ATTR_MAX,
+                .c_attr_policy  = thermal_genl_policy,
+        },
+        {
+                .c_id           = THERMAL_GENL_CMD_THRESHOLD_FLUSH,
+                .c_name         = (char *)"Flush the thresholds",
+                .c_msg_parser   = handle_netlink,
+                .c_maxattr      = THERMAL_GENL_ATTR_MAX,
+                .c_attr_policy  = thermal_genl_policy,
+        },
 };
 
 static struct genl_ops thermal_cmd_ops = {
@@ -263,13 +333,29 @@ static struct genl_ops thermal_cmd_ops = {
 
 struct cmd_param {
 	int tz_id;
+	int temp;
+	int direction;
 };
 
 typedef int (*cmd_cb_t)(struct nl_msg *, struct cmd_param *);
 
 static int thermal_genl_tz_id_encode(struct nl_msg *msg, struct cmd_param *p)
 {
-	if (p->tz_id >= 0 && nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id))
+	if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id))
+		return -1;
+
+	return 0;
+}
+
+static int thermal_genl_threshold_encode(struct nl_msg *msg, struct cmd_param *p)
+{
+	if (thermal_genl_tz_id_encode(msg, p))
+		return -1;
+
+	if (nla_put_u32(msg, THERMAL_GENL_ATTR_THRESHOLD_TEMP, p->temp))
+		return -1;
+
+	if (nla_put_u32(msg, THERMAL_GENL_ATTR_THRESHOLD_WAY, p->direction))
 		return -1;
 
 	return 0;
@@ -338,6 +424,46 @@ thermal_error_t thermal_cmd_get_temp(struct thermal_handler *th, struct thermal_
 				 THERMAL_GENL_CMD_TZ_GET_TEMP, 0, tz);
 }
 
+thermal_error_t thermal_cmd_threshold_get(struct thermal_handler *th,
+                                          struct thermal_zone *tz)
+{
+	struct cmd_param p = { .tz_id = tz->id };
+
+        return thermal_genl_auto(th, thermal_genl_tz_id_encode, &p,
+				 THERMAL_GENL_CMD_THRESHOLD_GET, 0, tz);
+}
+
+thermal_error_t thermal_cmd_threshold_add(struct thermal_handler *th,
+                                          struct thermal_zone *tz,
+                                          int temperature,
+                                          int direction)
+{
+	struct cmd_param p = { .tz_id = tz->id, .temp = temperature, .direction = direction };
+
+        return thermal_genl_auto(th, thermal_genl_threshold_encode, &p,
+				 THERMAL_GENL_CMD_THRESHOLD_ADD, 0, tz);
+}
+
+thermal_error_t thermal_cmd_threshold_delete(struct thermal_handler *th,
+                                             struct thermal_zone *tz,
+                                             int temperature,
+                                             int direction)
+{
+	struct cmd_param p = { .tz_id = tz->id, .temp = temperature, .direction = direction };
+
+        return thermal_genl_auto(th, thermal_genl_threshold_encode, &p,
+				 THERMAL_GENL_CMD_THRESHOLD_DELETE, 0, tz);
+}
+
+thermal_error_t thermal_cmd_threshold_flush(struct thermal_handler *th,
+                                            struct thermal_zone *tz)
+{
+	struct cmd_param p = { .tz_id = tz->id };
+
+        return thermal_genl_auto(th, thermal_genl_tz_id_encode, &p,
+				 THERMAL_GENL_CMD_THRESHOLD_FLUSH, 0, tz);
+}
+
 thermal_error_t thermal_cmd_exit(struct thermal_handler *th)
 {
 	if (genl_unregister_family(&thermal_cmd_ops))
diff --git a/tools/lib/thermal/events.c b/tools/lib/thermal/events.c
index a7a55d1a0c4c..a009381b30ec 100644
--- a/tools/lib/thermal/events.c
+++ b/tools/lib/thermal/events.c
@@ -94,6 +94,33 @@ static int handle_thermal_event(struct nl_msg *n, void *arg)
 	case THERMAL_GENL_EVENT_TZ_GOV_CHANGE:
 		return ops->gov_change(nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_ID]),
 				       nla_get_string(attrs[THERMAL_GENL_ATTR_GOV_NAME]), arg);
+
+	case THERMAL_GENL_EVENT_THRESHOLD_ADD:
+		return ops->threshold_add(nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_ID]),
+					  nla_get_u32(attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP]),
+					  nla_get_u32(attrs[THERMAL_GENL_ATTR_THRESHOLD_WAY]),
+					  nla_get_u32(attrs[THERMAL_GENL_ATTR_THRESHOLD_PID]), arg);
+
+	case THERMAL_GENL_EVENT_THRESHOLD_DELETE:
+		return ops->threshold_delete(nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_ID]),
+					     nla_get_u32(attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP]),
+					     nla_get_u32(attrs[THERMAL_GENL_ATTR_THRESHOLD_WAY]),
+					     nla_get_u32(attrs[THERMAL_GENL_ATTR_THRESHOLD_PID]), arg);
+
+	case THERMAL_GENL_EVENT_THRESHOLD_FLUSH:
+		return ops->threshold_flush(nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_ID]),
+					    nla_get_u32(attrs[THERMAL_GENL_ATTR_THRESHOLD_PID]), arg);
+
+	case THERMAL_GENL_EVENT_THRESHOLD_UP:
+		return ops->threshold_up(nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_ID]),
+					 nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_TEMP]),
+					 nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_LAST_TEMP]), arg);
+
+	case THERMAL_GENL_EVENT_THRESHOLD_DOWN:
+		return ops->threshold_down(nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_ID]),
+					   nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_TEMP]),
+					   nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_LAST_TEMP]), arg);
+
 	default:
 		return -1;
 	}
@@ -101,19 +128,24 @@ static int handle_thermal_event(struct nl_msg *n, void *arg)
 
 static void thermal_events_ops_init(struct thermal_events_ops *ops)
 {
-	enabled_ops[THERMAL_GENL_EVENT_TZ_CREATE]	= !!ops->tz_create;
-	enabled_ops[THERMAL_GENL_EVENT_TZ_DELETE]	= !!ops->tz_delete;
-	enabled_ops[THERMAL_GENL_EVENT_TZ_DISABLE]	= !!ops->tz_disable;
-	enabled_ops[THERMAL_GENL_EVENT_TZ_ENABLE]	= !!ops->tz_enable;
-	enabled_ops[THERMAL_GENL_EVENT_TZ_TRIP_UP]	= !!ops->trip_high;
-	enabled_ops[THERMAL_GENL_EVENT_TZ_TRIP_DOWN]	= !!ops->trip_low;
-	enabled_ops[THERMAL_GENL_EVENT_TZ_TRIP_CHANGE]	= !!ops->trip_change;
-	enabled_ops[THERMAL_GENL_EVENT_TZ_TRIP_ADD]	= !!ops->trip_add;
-	enabled_ops[THERMAL_GENL_EVENT_TZ_TRIP_DELETE]	= !!ops->trip_delete;
-	enabled_ops[THERMAL_GENL_EVENT_CDEV_ADD]	= !!ops->cdev_add;
-	enabled_ops[THERMAL_GENL_EVENT_CDEV_DELETE]	= !!ops->cdev_delete;
-	enabled_ops[THERMAL_GENL_EVENT_CDEV_STATE_UPDATE] = !!ops->cdev_update;
-	enabled_ops[THERMAL_GENL_EVENT_TZ_GOV_CHANGE]	= !!ops->gov_change;
+	enabled_ops[THERMAL_GENL_EVENT_TZ_CREATE]		= !!ops->tz_create;
+	enabled_ops[THERMAL_GENL_EVENT_TZ_DELETE]		= !!ops->tz_delete;
+	enabled_ops[THERMAL_GENL_EVENT_TZ_DISABLE]		= !!ops->tz_disable;
+	enabled_ops[THERMAL_GENL_EVENT_TZ_ENABLE]		= !!ops->tz_enable;
+	enabled_ops[THERMAL_GENL_EVENT_TZ_TRIP_UP]		= !!ops->trip_high;
+	enabled_ops[THERMAL_GENL_EVENT_TZ_TRIP_DOWN]		= !!ops->trip_low;
+	enabled_ops[THERMAL_GENL_EVENT_TZ_TRIP_CHANGE]		= !!ops->trip_change;
+	enabled_ops[THERMAL_GENL_EVENT_TZ_TRIP_ADD]		= !!ops->trip_add;
+	enabled_ops[THERMAL_GENL_EVENT_TZ_TRIP_DELETE]		= !!ops->trip_delete;
+	enabled_ops[THERMAL_GENL_EVENT_CDEV_ADD]		= !!ops->cdev_add;
+	enabled_ops[THERMAL_GENL_EVENT_CDEV_DELETE]		= !!ops->cdev_delete;
+	enabled_ops[THERMAL_GENL_EVENT_CDEV_STATE_UPDATE] 	= !!ops->cdev_update;
+	enabled_ops[THERMAL_GENL_EVENT_TZ_GOV_CHANGE]		= !!ops->gov_change;
+	enabled_ops[THERMAL_GENL_EVENT_THRESHOLD_ADD]		= !!ops->threshold_add;
+	enabled_ops[THERMAL_GENL_EVENT_THRESHOLD_DELETE]	= !!ops->threshold_delete;
+	enabled_ops[THERMAL_GENL_EVENT_THRESHOLD_FLUSH]		= !!ops->threshold_flush;
+	enabled_ops[THERMAL_GENL_EVENT_THRESHOLD_UP]		= !!ops->threshold_up;
+	enabled_ops[THERMAL_GENL_EVENT_THRESHOLD_DOWN]		= !!ops->threshold_down;
 }
 
 thermal_error_t thermal_events_handle(struct thermal_handler *th, void *arg)
diff --git a/tools/lib/thermal/include/thermal.h b/tools/lib/thermal/include/thermal.h
index 1abc560602cf..0571ec0bf438 100644
--- a/tools/lib/thermal/include/thermal.h
+++ b/tools/lib/thermal/include/thermal.h
@@ -4,11 +4,20 @@
 #define __LIBTHERMAL_H
 
 #include <linux/thermal.h>
+#include <sys/types.h>
 
 #ifndef LIBTHERMAL_API
 #define LIBTHERMAL_API __attribute__((visibility("default")))
 #endif
 
+#ifndef THERMAL_THRESHOLD_WAY_UP
+#define THERMAL_THRESHOLD_WAY_UP 0x1
+#endif
+
+#ifndef THERMAL_THRESHOLD_WAY_DOWN
+#define THERMAL_THRESHOLD_WAY_DOWN 0x2
+#endif
+
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -31,6 +40,11 @@ struct thermal_events_ops {
 	int (*cdev_delete)(int cdev_id, void *arg);
 	int (*cdev_update)(int cdev_id, int cur_state, void *arg);
 	int (*gov_change)(int tz_id, const char *gov_name, void *arg);
+	int (*threshold_add)(int tz_id, int temperature, int direction, pid_t pid, void *arg);
+	int (*threshold_delete)(int tz_id, int temperature, int direction, pid_t pid, void *arg);
+	int (*threshold_flush)(int tz_id, pid_t pid, void *arg);
+	int (*threshold_up)(int tz_id, int temp, int last_temp, void *arg);
+	int (*threshold_down)(int tz_id, int temp, int last_temp, void *arg);
 };
 
 struct thermal_ops {
@@ -45,12 +59,18 @@ struct thermal_trip {
 	int hyst;
 };
 
+struct thermal_threshold {
+	int temperature;
+	int direction;
+};
+	
 struct thermal_zone {
 	int id;
 	int temp;
 	char name[THERMAL_NAME_LENGTH];
 	char governor[THERMAL_NAME_LENGTH];
 	struct thermal_trip *trip;
+	struct thermal_threshold *thresholds;
 };
 
 struct thermal_cdev {
@@ -74,12 +94,16 @@ typedef int (*cb_tt_t)(struct thermal_trip *, void *);
 
 typedef int (*cb_tc_t)(struct thermal_cdev *, void *);
 
+typedef int (*cb_th_t)(struct thermal_threshold *, void *);
+
 LIBTHERMAL_API int for_each_thermal_zone(struct thermal_zone *tz, cb_tz_t cb, void *arg);
 
 LIBTHERMAL_API int for_each_thermal_trip(struct thermal_trip *tt, cb_tt_t cb, void *arg);
 
 LIBTHERMAL_API int for_each_thermal_cdev(struct thermal_cdev *cdev, cb_tc_t cb, void *arg);
 
+LIBTHERMAL_API int for_each_thermal_threshold(struct thermal_threshold *th, cb_th_t cb, void *arg);
+
 LIBTHERMAL_API struct thermal_zone *thermal_zone_find_by_name(struct thermal_zone *tz,
 							      const char *name);
 
@@ -124,6 +148,22 @@ LIBTHERMAL_API thermal_error_t thermal_cmd_get_governor(struct thermal_handler *
 LIBTHERMAL_API thermal_error_t thermal_cmd_get_temp(struct thermal_handler *th,
 						    struct thermal_zone *tz);
 
+LIBTHERMAL_API thermal_error_t thermal_cmd_threshold_get(struct thermal_handler *th,
+							 struct thermal_zone *tz);
+
+LIBTHERMAL_API thermal_error_t thermal_cmd_threshold_add(struct thermal_handler *th,
+                                                         struct thermal_zone *tz,
+                                                         int temperature,
+                                                         int direction);
+
+LIBTHERMAL_API thermal_error_t thermal_cmd_threshold_delete(struct thermal_handler *th,
+                                                            struct thermal_zone *tz,
+                                                            int temperature,
+                                                            int direction);
+
+LIBTHERMAL_API thermal_error_t thermal_cmd_threshold_flush(struct thermal_handler *th,
+                                                           struct thermal_zone *tz);
+
 /*
  * Netlink thermal samples
  */
diff --git a/tools/lib/thermal/libthermal.map b/tools/lib/thermal/libthermal.map
index d5e77738c7a4..d657176aa47f 100644
--- a/tools/lib/thermal/libthermal.map
+++ b/tools/lib/thermal/libthermal.map
@@ -4,6 +4,7 @@ LIBTHERMAL_0.0.1 {
 		for_each_thermal_zone;
 		for_each_thermal_trip;
 		for_each_thermal_cdev;
+		for_each_thermal_threshold;
 		thermal_zone_find_by_name;
 		thermal_zone_find_by_id;
 		thermal_zone_discover;
@@ -17,6 +18,10 @@ LIBTHERMAL_0.0.1 {
 		thermal_cmd_get_trip;
 		thermal_cmd_get_governor;
 		thermal_cmd_get_temp;
+		thermal_cmd_threshold_get;
+		thermal_cmd_threshold_add;
+		thermal_cmd_threshold_delete;
+		thermal_cmd_threshold_flush;
 		thermal_sampling_init;
 		thermal_sampling_handle;
 		thermal_sampling_fd;
diff --git a/tools/lib/thermal/thermal.c b/tools/lib/thermal/thermal.c
index 72a76dc205bc..4851744d482e 100644
--- a/tools/lib/thermal/thermal.c
+++ b/tools/lib/thermal/thermal.c
@@ -1,10 +1,24 @@
 // SPDX-License-Identifier: LGPL-2.1+
 // Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
 #include <stdio.h>
+#include <limits.h>
 #include <thermal.h>
 
 #include "thermal_nl.h"
 
+int for_each_thermal_threshold(struct thermal_threshold *th, cb_th_t cb, void *arg)
+{
+	int i, ret = 0;
+
+	if (!th)
+		return 0;
+
+	for (i = 0; th[i].temperature != INT_MAX; i++)
+		ret |= cb(&th[i], arg);
+
+	return ret;
+}
+	
 int for_each_thermal_cdev(struct thermal_cdev *cdev, cb_tc_t cb, void *arg)
 {
 	int i, ret = 0;
@@ -80,6 +94,9 @@ static int __thermal_zone_discover(struct thermal_zone *tz, void *th)
 	if (thermal_cmd_get_trip(th, tz) < 0)
 		return -1;
 
+	if (thermal_cmd_threshold_get(th, tz) < 0)
+		return -1;
+	
 	if (thermal_cmd_get_governor(th, tz))
 		return -1;
 
diff --git a/tools/thermal/lib/Makefile b/tools/thermal/lib/Makefile
index 82db451935c5..f2552f73a64c 100644
--- a/tools/thermal/lib/Makefile
+++ b/tools/thermal/lib/Makefile
@@ -3,7 +3,7 @@
 
 LIBTHERMAL_TOOLS_VERSION = 0
 LIBTHERMAL_TOOLS_PATCHLEVEL = 0
-LIBTHERMAL_TOOLS_EXTRAVERSION = 1
+LIBTHERMAL_TOOLS_EXTRAVERSION = 2
 
 MAKEFLAGS += --no-print-directory
 
-- 
2.43.0


