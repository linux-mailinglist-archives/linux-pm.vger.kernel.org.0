Return-Path: <linux-pm+bounces-14563-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C956497E937
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 12:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9A11F21EF4
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 10:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188A2196450;
	Mon, 23 Sep 2024 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kzgWksDB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0CC1940BE
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085618; cv=none; b=fTbKLMIs4auldeYIT/ToQ1bSho9dZPxyNE76TD/UQ3A3WZVgiKEdZn54qHxxo0ypKA7eST52yj79ZPFGX297m75qLV2TI7UuI6OPilmSc+Wt4tOIX6YnbVTM8puhi18tWKrbxznBCyVjEPZTtWnhuZ4AfRZvOegc89sQI2wS4I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085618; c=relaxed/simple;
	bh=OnYyHrw0OVCt42yLMry7RBzmbTCZJWDc505lUeqSeus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNRcYglu4mUPp1dihaJGkblVLQ8HzLU2FNrG9XhAJC2E1+rOKY/oovXT1Srars/Tig+Do3qU1xVRINVjAFY/xsKKqs/ToayDGrFwOTJLKW3/caJ+L1ZYaeerU2ku+wER4H4tR7D5AnrBWhdEM35enmcmUfiMQbTXUuDgFn/3Kus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kzgWksDB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3780c8d689aso2875130f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 03:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727085614; x=1727690414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaMSbRq616CiKnWW4VcljfAj49EnVXHHRWjN6wlUnNw=;
        b=kzgWksDB2WrRwlQvkND9/GeTZSMX3+dTpH1VMdSPe7D4ZsbewjWXoyMQcFWw+iSHWJ
         BJvpFG0rbWTy9hijgcZr77Y54Eq9EEHGd2WzJ47VQzwt6bpa1YyLH+2SWhqMunJi6EZ8
         daXVZinByS7YNxel3Pjj6GIS87MkGi5lAyDgvJa7ogJ2MizvGRSFGqo2vpt6Fx44V9zE
         ScQRweto0gGe7u6i/gHGeOwAL1PPHvogcFon8R45Kp5b5wDo63via0jApJFH1+OxJH6b
         VG3ad7x9qch08BazFNbUt00dWa3HsUem+3u2EajqsLamCf5ps9I6bYM3Ly7VUUH+8wmm
         GaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727085614; x=1727690414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaMSbRq616CiKnWW4VcljfAj49EnVXHHRWjN6wlUnNw=;
        b=u8XDMFtH3JjPKbX3rm5DtJY4bVtwgZK4pmu761kidPE8MQaBFe9nGU0YeY5Er70YBc
         74ThsDMPnwhRqjj6zLVDXF3ht89YUywNy60lm9UsgKKC977H5Cm4jQv54oWSFy24kM80
         e+klxAqcY0P2UnladQliiZDMfmJh+iavDbepQekpNmH+bMDJHRKNjv9/kVKnjyskOH+5
         N+HjP4/iCsyYlaH4Z6620PBXxc20ujZLwXJHB2bX7T/ja3AmDfSAeGD3fgi+1esh7Hlb
         yxb1OHnKTXN5+zBvLdt7wrqpAZpLCIrvg+bP6+O8nfs+yopIYy5nVguxbd8MyEI3apnz
         hyxg==
X-Gm-Message-State: AOJu0YwzkihROQ2GAWCYkFcFWr1rP9Sd/RjXFVwxToLPHNJSrEI98TNP
	VLEwTtYo1vAkdqRWO7njl8YA2sLPWoEK2er2nQjt4lyfJ6c7jSXVFZBvxGOoQB8=
X-Google-Smtp-Source: AGHT+IF5A/tvXP5rG8+CvxHy/s/Dwj1z0zH99f79+xrSK/6AvxkQp0URvWfVI5LLTtuhdIth8Mz4qg==
X-Received: by 2002:a05:6000:e85:b0:374:d26d:c02a with SMTP id ffacd0b85a97d-37a431583bemr6950258f8f.34.1727085613874;
        Mon, 23 Sep 2024 03:00:13 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm23977216f8f.49.2024.09.23.03.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 03:00:13 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v4 5/6] tools/lib/thermal: Add the threshold netlink ABI
Date: Mon, 23 Sep 2024 12:00:01 +0200
Message-ID: <20240923100005.2532430-6-daniel.lezcano@linaro.org>
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


