Return-Path: <linux-pm+bounces-16244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1279AB2C6
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 17:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E655B24E49
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 15:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C411BC9FF;
	Tue, 22 Oct 2024 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iLlr3q7c"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8165C1BC9ED
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612320; cv=none; b=rnGwZUSSyo2QNs9yCZwd9UwIYhhhSVU9zXbmRGlb6ABPFTAPphZGo2Y72pc1R0kez3wUedfg3l1bvpgzjG1isjsrVRsttK5XnIPcUJ/dhFBHpkZ3oN/L9DTWddpWzip+3b4rtji1MVn540vqxmHFoKWlF4B0cxsQOdnYLZbLZLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612320; c=relaxed/simple;
	bh=3uIiBil1p7pHojAjRg7m2RcEZFe5I9UwmtriRifqqzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsoFHtQPzk7XCJTcaE3Ocev5T9dPwAXmBtghOTQ1Zu7PrXDuFv80/CwA4XlJ+lO+pbHPwPYGMFUAluSF9FVhkagP+9kuDf6AFMNQA9q6z/9Ctwlcnwg4jgGDLt57NdrtQ2S1LvI4nQk64nGGLKybzd2fKEV7B/t3XH2OJJrgdnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iLlr3q7c; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315abed18aso54550095e9.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729612317; x=1730217117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jnMMf7dOSPl8d/NWwHZPOLOR1UCqa/eIZGjrkXNUmI=;
        b=iLlr3q7ctxOdI7pW4r5P3UvYy44VFGY3O+5PE0Ww+W9wjGIcCb9U7SPJj1kj6juDAs
         NR4VJok6wcNDixfctqFY2vmQL3IBZKSehrTILQpgc88uOELwJqY6HUGxz9VKGEhmP0A9
         x0ywKhyGYPjQIqkUEKTgK3l0iXefp9Oc6olHy42IvlNjyrV9/vsuiOy8KkoavCSqr391
         +x+gzj7NxoVrCLRz+bcZrUIBdDs3T0eXiajj6mNFgEf0KrWVF38BBjrHMt3b1gFp5Hek
         S3/TfHfwfY+FtNoqEKUCZlgvjIG+hkHZ4ni5bLH7Rk1qdiqTpz8eweUYk7pLvyuTykUA
         hFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729612317; x=1730217117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jnMMf7dOSPl8d/NWwHZPOLOR1UCqa/eIZGjrkXNUmI=;
        b=JEwL/UkPInZIqfNkKSl1Lm35sR02OkKrQYnXwDL0jXuDGNY3LSDH8tWtEE0nx35pUY
         +Qvz+Hmtg7MeOGZLsvEgVSxuzuWF8jh0rCFkMzSjlRCljeHYfPFxqi5UrG+nghIaZALN
         1FNsvpjWuwYv0mzA2NsCpt0OeKpNQKIVa24rvB+oRB9KdLCbc7bv9w4Ehu+sUrj/YjoT
         gVs8nr6RT2UxB2q4xHRN8OiDTLObSU97SgKuphujSj0z4z47niF4z/lEv/aJh9+OlYJ/
         QQ38EzernleufI9rIDG6IBijuHPr8bTClgCX+lHS4TkI8r1UJB/eNpPw6bHmmm6VLeyy
         3o1A==
X-Gm-Message-State: AOJu0Ywms0iff3eakm29mxxOnTMBg8et5JODIcug1f9rvWWSWdE9ZD7E
	u3swEVvWRj51hCVK06yDs4inTu6oc7AXd6hfsyvJ4JtAh+sW/6fK+jaCRbLQTCI=
X-Google-Smtp-Source: AGHT+IGt/jK0Czbwp7vy4DTsX7QPeWI2jL6OxPfXMpPKw/3UgZk+I1+Jkf0e081fRtso3FTVSiX62w==
X-Received: by 2002:a05:600c:4fc4:b0:42c:bf94:f9a6 with SMTP id 5b1f17b1804b1-4316169aa98mr129146235e9.26.1729612316708;
        Tue, 22 Oct 2024 08:51:56 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58aef6sm91538075e9.22.2024.10.22.08.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 08:51:56 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	quic_manafm@quicinc.com,
	lukasz.luba@arm.com
Subject: [PATCH v6 2/5] thermal/netlink: Add the commands and the events for the thresholds
Date: Tue, 22 Oct 2024 17:51:42 +0200
Message-ID: <20241022155147.463475-3-daniel.lezcano@linaro.org>
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

The thresholds exist but there is no notification neither action code
related to them yet.

These changes implement the netlink for the notifications when the
thresholds are crossed, added, deleted or flushed as well as the
commands which allows to get the list of the thresholds, flush them,
add and delete.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_netlink.c    | 236 ++++++++++++++++++++++++++-
 drivers/thermal/thermal_netlink.h    |  34 ++++
 drivers/thermal/thermal_thresholds.c |  36 ++--
 drivers/thermal/thermal_thresholds.h |   2 +-
 include/uapi/linux/thermal.h         |  27 ++-
 5 files changed, 307 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index f3c58c708969..978cd46c15e8 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/notifier.h>
 #include <linux/kernel.h>
+#include <net/sock.h>
 #include <net/genetlink.h>
 #include <uapi/linux/thermal.h>
 
@@ -49,6 +50,11 @@ static const struct nla_policy thermal_genl_policy[THERMAL_GENL_ATTR_MAX + 1] =
 	[THERMAL_GENL_ATTR_CPU_CAPABILITY_ID]		= { .type = NLA_U32 },
 	[THERMAL_GENL_ATTR_CPU_CAPABILITY_PERFORMANCE]	= { .type = NLA_U32 },
 	[THERMAL_GENL_ATTR_CPU_CAPABILITY_EFFICIENCY]	= { .type = NLA_U32 },
+
+	/* Thresholds */
+	[THERMAL_GENL_ATTR_THRESHOLD]		= { .type = NLA_NESTED },
+	[THERMAL_GENL_ATTR_THRESHOLD_TEMP]	= { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_THRESHOLD_DIRECTION]	= { .type = NLA_U32 },
 };
 
 struct param {
@@ -62,6 +68,8 @@ struct param {
 	int trip_type;
 	int trip_hyst;
 	int temp;
+	int prev_temp;
+	int direction;
 	int cdev_state;
 	int cdev_max_state;
 	struct thermal_genl_cpu_caps *cpu_capabilities;
@@ -234,6 +242,34 @@ static int thermal_genl_event_cpu_capability_change(struct param *p)
 	return -EMSGSIZE;
 }
 
+static int thermal_genl_event_threshold_add(struct param *p)
+{
+	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_THRESHOLD_TEMP, p->temp) ||
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_THRESHOLD_DIRECTION, p->direction))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int thermal_genl_event_threshold_flush(struct param *p)
+{
+	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int thermal_genl_event_threshold_up(struct param *p)
+{
+	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_PREV_TEMP, p->prev_temp) ||
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TEMP, p->temp))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 int thermal_genl_event_tz_delete(struct param *p)
 	__attribute__((alias("thermal_genl_event_tz")));
 
@@ -246,6 +282,12 @@ int thermal_genl_event_tz_disable(struct param *p)
 int thermal_genl_event_tz_trip_down(struct param *p)
 	__attribute__((alias("thermal_genl_event_tz_trip_up")));
 
+int thermal_genl_event_threshold_delete(struct param *p)
+	__attribute__((alias("thermal_genl_event_threshold_add")));
+
+int thermal_genl_event_threshold_down(struct param *p)
+	__attribute__((alias("thermal_genl_event_threshold_up")));
+
 static cb_t event_cb[] = {
 	[THERMAL_GENL_EVENT_TZ_CREATE]		= thermal_genl_event_tz_create,
 	[THERMAL_GENL_EVENT_TZ_DELETE]		= thermal_genl_event_tz_delete,
@@ -259,6 +301,11 @@ static cb_t event_cb[] = {
 	[THERMAL_GENL_EVENT_CDEV_STATE_UPDATE]	= thermal_genl_event_cdev_state_update,
 	[THERMAL_GENL_EVENT_TZ_GOV_CHANGE]	= thermal_genl_event_gov_change,
 	[THERMAL_GENL_EVENT_CPU_CAPABILITY_CHANGE] = thermal_genl_event_cpu_capability_change,
+	[THERMAL_GENL_EVENT_THRESHOLD_ADD]	= thermal_genl_event_threshold_add,
+	[THERMAL_GENL_EVENT_THRESHOLD_DELETE]	= thermal_genl_event_threshold_delete,
+	[THERMAL_GENL_EVENT_THRESHOLD_FLUSH]	= thermal_genl_event_threshold_flush,
+	[THERMAL_GENL_EVENT_THRESHOLD_DOWN]	= thermal_genl_event_threshold_down,
+	[THERMAL_GENL_EVENT_THRESHOLD_UP]	= thermal_genl_event_threshold_up,
 };
 
 /*
@@ -401,6 +448,43 @@ int thermal_genl_cpu_capability_event(int count,
 }
 EXPORT_SYMBOL_GPL(thermal_genl_cpu_capability_event);
 
+int thermal_notify_threshold_add(const struct thermal_zone_device *tz,
+				 int temperature, int direction)
+{
+	struct param p = { .tz_id = tz->id, .temp = temperature, .direction = direction };
+
+	return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_ADD, &p);
+}
+
+int thermal_notify_threshold_delete(const struct thermal_zone_device *tz,
+				    int temperature, int direction)
+{
+	struct param p = { .tz_id = tz->id, .temp = temperature, .direction = direction };
+
+	return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_DELETE, &p);
+}
+
+int thermal_notify_threshold_flush(const struct thermal_zone_device *tz)
+{
+	struct param p = { .tz_id = tz->id };
+
+	return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_FLUSH, &p);
+}
+
+int thermal_notify_threshold_down(const struct thermal_zone_device *tz)
+{
+	struct param p = { .tz_id = tz->id, .temp = tz->temperature, .prev_temp = tz->last_temperature };
+
+	return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_DOWN, &p);
+}
+
+int thermal_notify_threshold_up(const struct thermal_zone_device *tz)
+{
+	struct param p = { .tz_id = tz->id, .temp = tz->temperature, .prev_temp = tz->last_temperature };
+
+	return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_UP, &p);
+}
+
 /*************************** Command encoding ********************************/
 
 static int __thermal_genl_cmd_tz_get_id(struct thermal_zone_device *tz,
@@ -572,12 +656,132 @@ static int thermal_genl_cmd_cdev_get(struct param *p)
 	return ret;
 }
 
+static int __thermal_genl_cmd_threshold_get(struct user_threshold *threshold, void *arg)
+{
+	struct sk_buff *msg = arg;
+
+	if (nla_put_u32(msg, THERMAL_GENL_ATTR_THRESHOLD_TEMP, threshold->temperature) ||
+	    nla_put_u32(msg, THERMAL_GENL_ATTR_THRESHOLD_DIRECTION, threshold->direction))
+		return -1;
+
+	return 0;
+}
+
+static int thermal_genl_cmd_threshold_get(struct param *p)
+{
+	struct sk_buff *msg = p->msg;
+	struct nlattr *start_trip;
+	int id, ret;
+
+	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
+		return -EINVAL;
+
+	id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
+
+	CLASS(thermal_zone_get_by_id, tz)(id);
+	if (!tz)
+		return -EINVAL;
+
+	start_trip = nla_nest_start(msg, THERMAL_GENL_ATTR_THRESHOLD);
+	if (!start_trip)
+		return -EMSGSIZE;
+
+	ret = thermal_thresholds_for_each(tz, __thermal_genl_cmd_threshold_get, msg);
+	if (ret)
+		return -EMSGSIZE;
+
+	nla_nest_end(msg, start_trip);
+
+	return 0;
+}
+
+static int thermal_genl_cmd_threshold_add(struct param *p)
+{
+	int id, temp, direction, ret = 0;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID] ||
+	    !p->attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP] ||
+	    !p->attrs[THERMAL_GENL_ATTR_THRESHOLD_DIRECTION])
+		return -EINVAL;
+
+	id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
+	temp = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP]);
+	direction = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_THRESHOLD_DIRECTION]);
+
+	CLASS(thermal_zone_get_by_id, tz)(id);
+	if (!tz)
+		return -EINVAL;
+
+	mutex_lock(&tz->lock);
+	ret = thermal_thresholds_add(tz, temp, direction);
+	mutex_unlock(&tz->lock);
+
+	return ret;
+}
+
+static int thermal_genl_cmd_threshold_delete(struct param *p)
+{
+	int id, temp, direction, ret = 0;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID] ||
+	    !p->attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP] ||
+	    !p->attrs[THERMAL_GENL_ATTR_THRESHOLD_DIRECTION])
+		return -EINVAL;
+
+	id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
+	temp = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP]);
+	direction = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_THRESHOLD_DIRECTION]);
+
+	CLASS(thermal_zone_get_by_id, tz)(id);
+	if (!tz)
+		return -EINVAL;
+
+	mutex_lock(&tz->lock);
+	ret = thermal_thresholds_delete(tz, temp, direction);
+	mutex_unlock(&tz->lock);
+
+	return ret;
+}
+
+static int thermal_genl_cmd_threshold_flush(struct param *p)
+{
+	int id;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
+		return -EINVAL;
+
+	id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
+
+	CLASS(thermal_zone_get_by_id, tz)(id);
+	if (!tz)
+		return -EINVAL;
+
+	mutex_lock(&tz->lock);
+	thermal_thresholds_flush(tz);
+	mutex_unlock(&tz->lock);
+
+	return 0;
+}
+
 static cb_t cmd_cb[] = {
-	[THERMAL_GENL_CMD_TZ_GET_ID]	= thermal_genl_cmd_tz_get_id,
-	[THERMAL_GENL_CMD_TZ_GET_TRIP]	= thermal_genl_cmd_tz_get_trip,
-	[THERMAL_GENL_CMD_TZ_GET_TEMP]	= thermal_genl_cmd_tz_get_temp,
-	[THERMAL_GENL_CMD_TZ_GET_GOV]	= thermal_genl_cmd_tz_get_gov,
-	[THERMAL_GENL_CMD_CDEV_GET]	= thermal_genl_cmd_cdev_get,
+	[THERMAL_GENL_CMD_TZ_GET_ID]		= thermal_genl_cmd_tz_get_id,
+	[THERMAL_GENL_CMD_TZ_GET_TRIP]		= thermal_genl_cmd_tz_get_trip,
+	[THERMAL_GENL_CMD_TZ_GET_TEMP]		= thermal_genl_cmd_tz_get_temp,
+	[THERMAL_GENL_CMD_TZ_GET_GOV]		= thermal_genl_cmd_tz_get_gov,
+	[THERMAL_GENL_CMD_CDEV_GET]		= thermal_genl_cmd_cdev_get,
+	[THERMAL_GENL_CMD_THRESHOLD_GET]	= thermal_genl_cmd_threshold_get,
+	[THERMAL_GENL_CMD_THRESHOLD_ADD]	= thermal_genl_cmd_threshold_add,
+	[THERMAL_GENL_CMD_THRESHOLD_DELETE]	= thermal_genl_cmd_threshold_delete,
+	[THERMAL_GENL_CMD_THRESHOLD_FLUSH]	= thermal_genl_cmd_threshold_flush,
 };
 
 static int thermal_genl_cmd_dumpit(struct sk_buff *skb,
@@ -688,6 +892,26 @@ static const struct genl_small_ops thermal_genl_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.dumpit = thermal_genl_cmd_dumpit,
 	},
+	{
+		.cmd = THERMAL_GENL_CMD_THRESHOLD_GET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = thermal_genl_cmd_doit,
+	},
+	{
+		.cmd = THERMAL_GENL_CMD_THRESHOLD_ADD,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = thermal_genl_cmd_doit,
+	},
+	{
+		.cmd = THERMAL_GENL_CMD_THRESHOLD_DELETE,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = thermal_genl_cmd_doit,
+	},
+	{
+		.cmd = THERMAL_GENL_CMD_THRESHOLD_FLUSH,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = thermal_genl_cmd_doit,
+	},
 };
 
 static struct genl_family thermal_genl_family __ro_after_init = {
@@ -700,7 +924,7 @@ static struct genl_family thermal_genl_family __ro_after_init = {
 	.unbind		= thermal_genl_unbind,
 	.small_ops	= thermal_genl_ops,
 	.n_small_ops	= ARRAY_SIZE(thermal_genl_ops),
-	.resv_start_op	= THERMAL_GENL_CMD_CDEV_GET + 1,
+	.resv_start_op	= __THERMAL_GENL_CMD_MAX,
 	.mcgrps		= thermal_genl_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(thermal_genl_mcgrps),
 };
diff --git a/drivers/thermal/thermal_netlink.h b/drivers/thermal/thermal_netlink.h
index e01221e8816b..075e9ae85f3d 100644
--- a/drivers/thermal/thermal_netlink.h
+++ b/drivers/thermal/thermal_netlink.h
@@ -53,6 +53,13 @@ int thermal_notify_tz_gov_change(const struct thermal_zone_device *tz,
 int thermal_genl_sampling_temp(int id, int temp);
 int thermal_genl_cpu_capability_event(int count,
 				      struct thermal_genl_cpu_caps *caps);
+int thermal_notify_threshold_add(const struct thermal_zone_device *tz,
+				 int temperature, int direction);
+int thermal_notify_threshold_delete(const struct thermal_zone_device *tz,
+				    int temperature, int direction);
+int thermal_notify_threshold_flush(const struct thermal_zone_device *tz);
+int thermal_notify_threshold_down(const struct thermal_zone_device *tz);
+int thermal_notify_threshold_up(const struct thermal_zone_device *tz);
 #else
 static inline int thermal_netlink_init(void)
 {
@@ -139,6 +146,33 @@ static inline int thermal_genl_cpu_capability_event(int count, struct thermal_ge
 	return 0;
 }
 
+static inline int thermal_notify_threshold_add(const struct thermal_zone_device *tz,
+					       int temperature, int direction)
+{
+	return 0;
+}
+
+static inline int thermal_notify_threshold_delete(const struct thermal_zone_device *tz,
+						  int temperature, int direction)
+{
+	return 0;
+}
+
+static inline int thermal_notify_threshold_flush(const struct thermal_zone_device *tz)
+{
+	return 0;
+}
+
+static inline int thermal_notify_threshold_down(const struct thermal_zone_device *tz)
+{
+	return 0;
+}
+
+static inline int thermal_notify_threshold_up(const struct thermal_zone_device *tz)
+{
+	return 0;
+}
+
 static inline void __init thermal_netlink_exit(void) {}
 
 #endif /* CONFIG_THERMAL_NETLINK */
diff --git a/drivers/thermal/thermal_thresholds.c b/drivers/thermal/thermal_thresholds.c
index f33b6d5474d8..ea4aa5a2e86c 100644
--- a/drivers/thermal/thermal_thresholds.c
+++ b/drivers/thermal/thermal_thresholds.c
@@ -32,6 +32,8 @@ void thermal_thresholds_flush(struct thermal_zone_device *tz)
 		kfree(entry);
 	}
 
+	thermal_notify_threshold_flush(tz);
+
 	__thermal_zone_device_update(tz, THERMAL_TZ_FLUSH_THRESHOLDS);
 }
 
@@ -122,7 +124,6 @@ void thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, int *hi
 
 	int temperature = tz->temperature;
 	int last_temperature = tz->last_temperature;
-	bool notify;
 
 	lockdep_assert_held(&tz->lock);
 
@@ -144,19 +145,19 @@ void thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, int *hi
 	 * - increased : thresholds are crossed the way up
 	 * - decreased : thresholds are crossed the way down
 	 */
-	if (temperature > last_temperature)
-		notify = thermal_thresholds_handle_raising(thresholds, temperature,
-							   last_temperature, low, high);
-	else
-		notify = thermal_thresholds_handle_dropping(thresholds, temperature,
-							    last_temperature, low, high);
-
-	if (notify)
-		pr_debug("A threshold has been crossed the way %s, with a temperature=%d, last_temperature=%d\n",
-			 temperature > last_temperature ? "up" : "down", temperature, last_temperature);
+	if (temperature > last_temperature) {
+		if (thermal_thresholds_handle_raising(thresholds, temperature,
+						      last_temperature, low, high))
+			thermal_notify_threshold_up(tz);
+	} else {
+		if (thermal_thresholds_handle_dropping(thresholds, temperature,
+						       last_temperature, low, high))
+			thermal_notify_threshold_down(tz);
+	}
 }
 
-int thermal_thresholds_add(struct thermal_zone_device *tz, int temperature, int direction)
+int thermal_thresholds_add(struct thermal_zone_device *tz,
+			   int temperature, int direction)
 {
 	struct list_head *thresholds = &tz->user_thresholds;
 	struct user_threshold *t;
@@ -182,12 +183,15 @@ int thermal_thresholds_add(struct thermal_zone_device *tz, int temperature, int
 		list_sort(NULL, thresholds, __thermal_thresholds_cmp);
 	}
 
+	thermal_notify_threshold_add(tz, temperature, direction);
+
 	__thermal_zone_device_update(tz, THERMAL_TZ_ADD_THRESHOLD);
 
 	return 0;
 }
 
-int thermal_thresholds_delete(struct thermal_zone_device *tz, int temperature, int direction)
+int thermal_thresholds_delete(struct thermal_zone_device *tz,
+			      int temperature, int direction)
 {
 	struct list_head *thresholds = &tz->user_thresholds;
 	struct user_threshold *t;
@@ -205,6 +209,8 @@ int thermal_thresholds_delete(struct thermal_zone_device *tz, int temperature, i
 		t->direction &= ~direction;
 	}
 
+	thermal_notify_threshold_delete(tz, temperature, direction);
+
 	__thermal_zone_device_update(tz, THERMAL_TZ_DEL_THRESHOLD);
 
 	return 0;
@@ -217,7 +223,7 @@ int thermal_thresholds_for_each(struct thermal_zone_device *tz,
 	struct user_threshold *entry;
 	int ret;
 
-	lockdep_assert_held(&tz->lock);
+	mutex_lock(&tz->lock);
 
 	list_for_each_entry(entry, thresholds, list_node) {
 		ret = cb(entry, arg);
@@ -225,5 +231,7 @@ int thermal_thresholds_for_each(struct thermal_zone_device *tz,
 			return ret;
 	}
 
+	mutex_unlock(&tz->lock);
+
 	return 0;
 }
diff --git a/drivers/thermal/thermal_thresholds.h b/drivers/thermal/thermal_thresholds.h
index 232f4e8089af..cb372659a20d 100644
--- a/drivers/thermal/thermal_thresholds.h
+++ b/drivers/thermal/thermal_thresholds.h
@@ -10,8 +10,8 @@ struct user_threshold {
 
 int thermal_thresholds_init(struct thermal_zone_device *tz);
 void thermal_thresholds_exit(struct thermal_zone_device *tz);
-void thermal_thresholds_flush(struct thermal_zone_device *tz);
 void thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, int *high);
+void thermal_thresholds_flush(struct thermal_zone_device *tz);
 int thermal_thresholds_add(struct thermal_zone_device *tz, int temperature, int direction);
 int thermal_thresholds_delete(struct thermal_zone_device *tz, int temperature, int direction);
 int thermal_thresholds_for_each(struct thermal_zone_device *tz,
diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
index 2e6f60a36173..ba8604bdf206 100644
--- a/include/uapi/linux/thermal.h
+++ b/include/uapi/linux/thermal.h
@@ -20,7 +20,7 @@ enum thermal_trip_type {
 
 /* Adding event notification support elements */
 #define THERMAL_GENL_FAMILY_NAME		"thermal"
-#define THERMAL_GENL_VERSION			0x01
+#define THERMAL_GENL_VERSION			0x02
 #define THERMAL_GENL_SAMPLING_GROUP_NAME	"sampling"
 #define THERMAL_GENL_EVENT_GROUP_NAME		"event"
 
@@ -30,6 +30,7 @@ enum thermal_genl_attr {
 	THERMAL_GENL_ATTR_TZ,
 	THERMAL_GENL_ATTR_TZ_ID,
 	THERMAL_GENL_ATTR_TZ_TEMP,
+	THERMAL_GENL_ATTR_TZ_PREV_TEMP,
 	THERMAL_GENL_ATTR_TZ_TRIP,
 	THERMAL_GENL_ATTR_TZ_TRIP_ID,
 	THERMAL_GENL_ATTR_TZ_TRIP_TYPE,
@@ -50,6 +51,9 @@ enum thermal_genl_attr {
 	THERMAL_GENL_ATTR_CPU_CAPABILITY_ID,
 	THERMAL_GENL_ATTR_CPU_CAPABILITY_PERFORMANCE,
 	THERMAL_GENL_ATTR_CPU_CAPABILITY_EFFICIENCY,
+	THERMAL_GENL_ATTR_THRESHOLD,
+	THERMAL_GENL_ATTR_THRESHOLD_TEMP,
+	THERMAL_GENL_ATTR_THRESHOLD_DIRECTION,
 	__THERMAL_GENL_ATTR_MAX,
 };
 #define THERMAL_GENL_ATTR_MAX (__THERMAL_GENL_ATTR_MAX - 1)
@@ -77,6 +81,11 @@ enum thermal_genl_event {
 	THERMAL_GENL_EVENT_CDEV_STATE_UPDATE,	/* Cdev state updated */
 	THERMAL_GENL_EVENT_TZ_GOV_CHANGE,	/* Governor policy changed  */
 	THERMAL_GENL_EVENT_CPU_CAPABILITY_CHANGE,	/* CPU capability changed */
+	THERMAL_GENL_EVENT_THRESHOLD_ADD,	/* A thresold has been added */
+	THERMAL_GENL_EVENT_THRESHOLD_DELETE,	/* A thresold has been deleted */
+	THERMAL_GENL_EVENT_THRESHOLD_FLUSH,	/* All thresolds have been deleted */
+	THERMAL_GENL_EVENT_THRESHOLD_UP,	/* A thresold has been crossed the way up */
+	THERMAL_GENL_EVENT_THRESHOLD_DOWN,	/* A thresold has been crossed the way down */
 	__THERMAL_GENL_EVENT_MAX,
 };
 #define THERMAL_GENL_EVENT_MAX (__THERMAL_GENL_EVENT_MAX - 1)
@@ -84,12 +93,16 @@ enum thermal_genl_event {
 /* Commands supported by the thermal_genl_family */
 enum thermal_genl_cmd {
 	THERMAL_GENL_CMD_UNSPEC,
-	THERMAL_GENL_CMD_TZ_GET_ID,	/* List of thermal zones id */
-	THERMAL_GENL_CMD_TZ_GET_TRIP,	/* List of thermal trips */
-	THERMAL_GENL_CMD_TZ_GET_TEMP,	/* Get the thermal zone temperature */
-	THERMAL_GENL_CMD_TZ_GET_GOV,	/* Get the thermal zone governor */
-	THERMAL_GENL_CMD_TZ_GET_MODE,	/* Get the thermal zone mode */
-	THERMAL_GENL_CMD_CDEV_GET,	/* List of cdev id */
+	THERMAL_GENL_CMD_TZ_GET_ID,		/* List of thermal zones id */
+	THERMAL_GENL_CMD_TZ_GET_TRIP,		/* List of thermal trips */
+	THERMAL_GENL_CMD_TZ_GET_TEMP,		/* Get the thermal zone temperature */
+	THERMAL_GENL_CMD_TZ_GET_GOV,		/* Get the thermal zone governor */
+	THERMAL_GENL_CMD_TZ_GET_MODE,		/* Get the thermal zone mode */
+	THERMAL_GENL_CMD_CDEV_GET,		/* List of cdev id */
+	THERMAL_GENL_CMD_THRESHOLD_GET,		/* List of thresholds */
+	THERMAL_GENL_CMD_THRESHOLD_ADD,		/* Add a threshold */
+	THERMAL_GENL_CMD_THRESHOLD_DELETE,	/* Delete a threshold */
+	THERMAL_GENL_CMD_THRESHOLD_FLUSH,	/* Flush all the thresholds */
 	__THERMAL_GENL_CMD_MAX,
 };
 #define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
-- 
2.43.0


