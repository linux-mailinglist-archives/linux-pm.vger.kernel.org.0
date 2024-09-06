Return-Path: <linux-pm+bounces-13754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A41B96EC1B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 09:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CE3286DC2
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 07:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30FB14F121;
	Fri,  6 Sep 2024 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ea/0IBS+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A38B14A604
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608206; cv=none; b=WeybxB+v9XS75ynXFcNP8kgIgjseyASgood6/31CtluvUcwVY0MeqZMBkWsCQ/zE6jFhVA2wlG/4qP3aHBGmy6fZgPjqNwyJY9ROO1gZDRm8GzOj9OeketTVcNWBIAaAoQocJ0nTyE64ov0vTf6Fqq4pivd2jnWuwgtRUJsNg9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608206; c=relaxed/simple;
	bh=nqdZNVmViHl2qwVjzAHHF6ULtuTi1y5S1Zor2S5vyL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOSS5zn/1UdlY0LpMXsCb4xU3hL1gKxvskY4TbWG6ElissGQv8UvhVMv48Tv/nJpCFi9Lv76ysj4o2binwliXz1CrO4HWYoWmv453j6ciuI2tkdzMVcoBcXNvkYmp3EvlFgCYsHN0ARpZJ6UgsFNcKjR2a81lwTPBjNKLxcwbME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ea/0IBS+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42c7856ed66so12403205e9.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2024 00:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725608203; x=1726213003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7L14TElurJyMGUddKjRBMMCU27JET34GTXZO40iWvHg=;
        b=ea/0IBS+py5yCwQ3IFmI+EpHliEV0x+5S4j5tAq8VoRuMjX5MbJRfRwhHRfadGqITt
         PdDaBHikpiSrgnJPtQOQPoXvrAHoGxLQFRJHrZEP9i25Y/BqGtKiLzP5SFSZtkuYm5Cy
         8S9r3MAV2sAXxlfK7BdDTqb7Jru8Nvs8Lly07JqtmK7It4pyPkN/JdqemnKbpfYRDx0z
         Jt+2k7JTtAqQY2fDdI0iex29EECHrv75UKBSZrvbGA3UJWqRZG733kemsKENSQbEedUB
         HJrVBNqOUO1AmHWx4k50TED3s/o2pyKsRypR686z2SEgiBt49Mn7ObMQV1T4TsgCyYdC
         sMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725608203; x=1726213003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7L14TElurJyMGUddKjRBMMCU27JET34GTXZO40iWvHg=;
        b=QAieE+QwMvqwfY90dW/xSv5MXscQidWj6N83kKV67HMXNAb+Dl5jW93N7q+CR+V8DC
         xsOSArPHIrqaVEjJs6WO3O39Q6opMr3iK7yRPOBD7Jo/nzXqfGDT0WBAeRllBGXw5JWb
         WYlUNEbPPpWwJ80xNdadnfoiv4D42eVTMhF+LQUwQnLP43Z+LkWsHIGuEr7bHxMa7f8Y
         m6ek/87gLbYwg56TAsTYFqTVBWdQU1TqRSMYe4PmZpV9bILBO55mpdBachZoqDSfjNTY
         ATi8mrmC5SjiMEvxMCEq/LstgjE1FqWqpMLRbth/aElpQd6+KN+lnbFiKs48meNjYco7
         DhaA==
X-Gm-Message-State: AOJu0Yyn0IA+7D4uGGgn2YCGizbMagH898whZgPNPh3PrkSmc/Z+UmvZ
	G9TE9nILLX17BZF2Z5orYdIVeSk3HYCoyggM6EF01R9nEasDDGKb5ijJJNpjl6M=
X-Google-Smtp-Source: AGHT+IFm8YxsFK75E3w2jTnnZngx2VcoAjaIfyBi9XfZOqjMt5ZrR7STYd94RVeiedU4+oe/1fwGiA==
X-Received: by 2002:a5d:42d0:0:b0:374:c07c:a49 with SMTP id ffacd0b85a97d-374c07c0cfamr12057215f8f.28.1725608202698;
        Fri, 06 Sep 2024 00:36:42 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-376914bfca1sm8113885f8f.18.2024.09.06.00.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 00:36:42 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v3 3/6] thermal/netlink: Add the commands and the events for the thresholds
Date: Fri,  6 Sep 2024 09:36:24 +0200
Message-ID: <20240906073631.1655552-4-daniel.lezcano@linaro.org>
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

The thresholds exist but there is no notification neither action code
related to them yet.

These changes implement the netlink for the notifications when the
thresholds are crossed, added, deleted or flushed as well as the
commands which allows to get the list of the thresholds, flush them,
add and delete.

As different processes in userspace can interact with the thresholds,
the process id responsible of the action (add, delete or flush) will
be added in the notification. This way a thermal engine is able to
detect if another process is interfering with the thresholds. A
process id of zero is the kernel as it is by convention usually.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_netlink.c    | 239 ++++++++++++++++++++++++++-
 drivers/thermal/thermal_netlink.h    |   7 +
 drivers/thermal/thermal_thresholds.c |  38 +++--
 drivers/thermal/thermal_thresholds.h |   6 +-
 include/uapi/linux/thermal.h         |  28 +++-
 5 files changed, 286 insertions(+), 32 deletions(-)

diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index 97157c453630..8d92ebeb72fc 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/notifier.h>
 #include <linux/kernel.h>
+#include <net/sock.h>
 #include <net/genetlink.h>
 #include <uapi/linux/thermal.h>
 
@@ -49,12 +50,19 @@ static const struct nla_policy thermal_genl_policy[THERMAL_GENL_ATTR_MAX + 1] =
 	[THERMAL_GENL_ATTR_CPU_CAPABILITY_ID]		= { .type = NLA_U32 },
 	[THERMAL_GENL_ATTR_CPU_CAPABILITY_PERFORMANCE]	= { .type = NLA_U32 },
 	[THERMAL_GENL_ATTR_CPU_CAPABILITY_EFFICIENCY]	= { .type = NLA_U32 },
+
+	/* Thresholds */
+	[THERMAL_GENL_ATTR_THRESHOLD]		= { .type = NLA_NESTED },
+	[THERMAL_GENL_ATTR_THRESHOLD_TEMP]	= { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_THRESHOLD_WAY]	= { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_THRESHOLD_PID]	= { .type = NLA_U32 },
 };
 
 struct param {
 	struct nlattr **attrs;
 	struct sk_buff *msg;
 	const char *name;
+	pid_t pid;
 	int tz_id;
 	int cdev_id;
 	int trip_id;
@@ -62,6 +70,8 @@ struct param {
 	int trip_type;
 	int trip_hyst;
 	int temp;
+	int last_temp;
+	int direction;
 	int cdev_state;
 	int cdev_max_state;
 	struct thermal_genl_cpu_caps *cpu_capabilities;
@@ -234,6 +244,36 @@ static int thermal_genl_event_cpu_capability_change(struct param *p)
 	return -EMSGSIZE;
 }
 
+static int thermal_genl_event_threshold_add(struct param *p)
+{
+	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_THRESHOLD_TEMP, p->temp) ||
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_THRESHOLD_WAY, p->direction) ||
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_THRESHOLD_PID, p->pid))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int thermal_genl_event_threshold_flush(struct param *p)
+{
+	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id),
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_THRESHOLD_PID, p->pid))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int thermal_genl_event_threshold_up(struct param *p)
+{
+	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_LAST_TEMP, p->last_temp) ||
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TEMP, p->temp))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 int thermal_genl_event_tz_delete(struct param *p)
 	__attribute__((alias("thermal_genl_event_tz")));
 
@@ -246,6 +286,12 @@ int thermal_genl_event_tz_disable(struct param *p)
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
@@ -259,6 +305,11 @@ static cb_t event_cb[] = {
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
@@ -401,6 +452,43 @@ int thermal_genl_cpu_capability_event(int count,
 }
 EXPORT_SYMBOL_GPL(thermal_genl_cpu_capability_event);
 
+int thermal_notify_threshold_add(const struct thermal_zone_device *tz,
+				 int temperature, int direction, int pid)
+{
+	struct param p = { .tz_id = tz->id, .temp = temperature, .direction = direction, .pid = pid };
+
+	return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_ADD, &p);
+}
+
+int thermal_notify_threshold_delete(const struct thermal_zone_device *tz,
+				    int temperature, int direction, int pid)
+{
+	struct param p = { .tz_id = tz->id, .temp = temperature, .direction = direction, .pid = pid };
+
+	return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_DELETE, &p);
+}
+
+int thermal_notify_threshold_flush(const struct thermal_zone_device *tz, int pid)
+{
+	struct param p = { .tz_id = tz->id, .pid = pid };
+
+	return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_FLUSH, &p);
+}
+
+int thermal_notify_threshold_down(const struct thermal_zone_device *tz)
+{
+	struct param p = { .tz_id = tz->id, .temp = tz->temperature, .last_temp = tz->last_temperature };
+
+	return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_DOWN, &p);
+}
+
+int thermal_notify_threshold_up(const struct thermal_zone_device *tz)
+{
+	struct param p = { .tz_id = tz->id, .temp = tz->temperature, .last_temp = tz->last_temperature };
+
+	return thermal_genl_send_event(THERMAL_GENL_EVENT_THRESHOLD_UP, &p);
+}
+
 /*************************** Command encoding ********************************/
 
 static int __thermal_genl_cmd_tz_get_id(struct thermal_zone_device *tz,
@@ -575,12 +663,130 @@ static int thermal_genl_cmd_cdev_get(struct param *p)
 	return ret;
 }
 
+static int __thermal_genl_cmd_threshold_get(struct user_threshold *threshold, void *arg)
+{
+	struct sk_buff *msg = arg;
+
+	if (nla_put_u32(msg, THERMAL_GENL_ATTR_THRESHOLD_TEMP, threshold->temperature) ||
+	    nla_put_u32(msg, THERMAL_GENL_ATTR_THRESHOLD_WAY, threshold->direction))
+		return -1;
+
+	return 0;
+}
+
+static int thermal_genl_cmd_threshold_get(struct param *p)
+{
+	struct thermal_zone_device *tz;
+	struct sk_buff *msg = p->msg;
+	struct nlattr *start_trip;
+	int id, ret;
+
+	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
+		return -EINVAL;
+
+	id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
+
+	tz = thermal_zone_get_by_id(id);
+	if (!tz)
+		return -EINVAL;
+
+	start_trip = nla_nest_start(msg, THERMAL_GENL_ATTR_THRESHOLD);
+	if (!start_trip)
+		return -EMSGSIZE;
+
+	mutex_lock(&tz->lock);
+	ret = thermal_thresholds_for_each(tz, __thermal_genl_cmd_threshold_get, msg);
+	mutex_unlock(&tz->lock);
+
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
+	struct thermal_zone_device *tz;
+	int id, temp, direction, ret = 0;
+
+	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID] ||
+	    !p->attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP] ||
+	    !p->attrs[THERMAL_GENL_ATTR_THRESHOLD_WAY])
+		return -EINVAL;
+
+	id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
+	temp = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP]);
+	direction = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_THRESHOLD_WAY]);
+
+	tz = thermal_zone_get_by_id(id);
+	if (!tz)
+		return -EINVAL;
+
+	mutex_lock(&tz->lock);
+	ret = thermal_thresholds_add(tz, temp, direction, p->pid);
+	mutex_unlock(&tz->lock);
+
+	return ret;
+}
+
+static int thermal_genl_cmd_threshold_delete(struct param *p)
+{
+	struct thermal_zone_device *tz;
+	int id, temp, direction, ret = 0;
+
+	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID] ||
+	    !p->attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP] ||
+	    !p->attrs[THERMAL_GENL_ATTR_THRESHOLD_WAY])
+		return -EINVAL;
+
+	id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
+	temp = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_THRESHOLD_TEMP]);
+	direction = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_THRESHOLD_WAY]);
+
+	tz = thermal_zone_get_by_id(id);
+	if (!tz)
+		return -EINVAL;
+
+	mutex_lock(&tz->lock);
+	ret = thermal_thresholds_delete(tz, temp, direction, p->pid);
+	mutex_unlock(&tz->lock);
+
+	return ret;
+}
+
+static int thermal_genl_cmd_threshold_flush(struct param *p)
+{
+	struct thermal_zone_device *tz;
+	int id;
+
+	if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
+		return -EINVAL;
+
+	id = nla_get_u32(p->attrs[THERMAL_GENL_ATTR_TZ_ID]);
+
+	tz = thermal_zone_get_by_id(id);
+	if (!tz)
+		return -EINVAL;
+
+	mutex_lock(&tz->lock);
+	thermal_thresholds_flush(tz, p->pid);
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
@@ -623,6 +829,7 @@ static int thermal_genl_cmd_doit(struct sk_buff *skb,
 	if (!msg)
 		return -ENOMEM;
 	p.msg = msg;
+	p.pid = task_tgid_vnr(current);
 
 	hdr = genlmsg_put_reply(msg, info, &thermal_genl_family, 0, cmd);
 	if (!hdr)
@@ -691,6 +898,26 @@ static const struct genl_small_ops thermal_genl_ops[] = {
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
@@ -703,7 +930,7 @@ static struct genl_family thermal_genl_family __ro_after_init = {
 	.unbind		= thermal_genl_unbind,
 	.small_ops	= thermal_genl_ops,
 	.n_small_ops	= ARRAY_SIZE(thermal_genl_ops),
-	.resv_start_op	= THERMAL_GENL_CMD_CDEV_GET + 1,
+	.resv_start_op	= __THERMAL_GENL_CMD_MAX,
 	.mcgrps		= thermal_genl_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(thermal_genl_mcgrps),
 };
diff --git a/drivers/thermal/thermal_netlink.h b/drivers/thermal/thermal_netlink.h
index e01221e8816b..715acee04f31 100644
--- a/drivers/thermal/thermal_netlink.h
+++ b/drivers/thermal/thermal_netlink.h
@@ -53,6 +53,13 @@ int thermal_notify_tz_gov_change(const struct thermal_zone_device *tz,
 int thermal_genl_sampling_temp(int id, int temp);
 int thermal_genl_cpu_capability_event(int count,
 				      struct thermal_genl_cpu_caps *caps);
+int thermal_notify_threshold_add(const struct thermal_zone_device *tz,
+				 int temperature, int direction, pid_t pid);
+int thermal_notify_threshold_delete(const struct thermal_zone_device *tz,
+				    int temperature, int direction, pid_t pid);
+int thermal_notify_threshold_flush(const struct thermal_zone_device *tz, pid_t pid);
+int thermal_notify_threshold_down(const struct thermal_zone_device *tz);
+int thermal_notify_threshold_up(const struct thermal_zone_device *tz);
 #else
 static inline int thermal_netlink_init(void)
 {
diff --git a/drivers/thermal/thermal_thresholds.c b/drivers/thermal/thermal_thresholds.c
index f33b6d5474d8..6d9a0cf8031f 100644
--- a/drivers/thermal/thermal_thresholds.c
+++ b/drivers/thermal/thermal_thresholds.c
@@ -20,7 +20,7 @@ int thermal_thresholds_init(struct thermal_zone_device *tz)
 	return 0;
 }
 
-void thermal_thresholds_flush(struct thermal_zone_device *tz)
+void thermal_thresholds_flush(struct thermal_zone_device *tz, pid_t pid)
 {
 	struct list_head *thresholds = &tz->user_thresholds;
 	struct user_threshold *entry, *tmp;
@@ -32,12 +32,14 @@ void thermal_thresholds_flush(struct thermal_zone_device *tz)
 		kfree(entry);
 	}
 
+	thermal_notify_threshold_flush(tz, pid);
+
 	__thermal_zone_device_update(tz, THERMAL_TZ_FLUSH_THRESHOLDS);
 }
 
 void thermal_thresholds_exit(struct thermal_zone_device *tz)
 {
-	thermal_thresholds_flush(tz);
+	thermal_thresholds_flush(tz, 0);
 }
 
 static int __thermal_thresholds_cmp(void *data,
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
+			   int temperature, int direction, pid_t pid)
 {
 	struct list_head *thresholds = &tz->user_thresholds;
 	struct user_threshold *t;
@@ -182,12 +183,15 @@ int thermal_thresholds_add(struct thermal_zone_device *tz, int temperature, int
 		list_sort(NULL, thresholds, __thermal_thresholds_cmp);
 	}
 
+	thermal_notify_threshold_add(tz, temperature, direction, pid);
+
 	__thermal_zone_device_update(tz, THERMAL_TZ_ADD_THRESHOLD);
 
 	return 0;
 }
 
-int thermal_thresholds_delete(struct thermal_zone_device *tz, int temperature, int direction)
+int thermal_thresholds_delete(struct thermal_zone_device *tz,
+			      int temperature, int direction, pid_t pid)
 {
 	struct list_head *thresholds = &tz->user_thresholds;
 	struct user_threshold *t;
@@ -205,8 +209,10 @@ int thermal_thresholds_delete(struct thermal_zone_device *tz, int temperature, i
 		t->direction &= ~direction;
 	}
 
-	__thermal_zone_device_update(tz, THERMAL_TZ_DEL_THRESHOLD);
+	thermal_notify_threshold_delete(tz, temperature, direction, pid);
 
+	__thermal_zone_device_update(tz, THERMAL_TZ_DEL_THRESHOLD);
+	
 	return 0;
 }
 
diff --git a/drivers/thermal/thermal_thresholds.h b/drivers/thermal/thermal_thresholds.h
index 232f4e8089af..f97ffb715d2e 100644
--- a/drivers/thermal/thermal_thresholds.h
+++ b/drivers/thermal/thermal_thresholds.h
@@ -10,10 +10,10 @@ struct user_threshold {
 
 int thermal_thresholds_init(struct thermal_zone_device *tz);
 void thermal_thresholds_exit(struct thermal_zone_device *tz);
-void thermal_thresholds_flush(struct thermal_zone_device *tz);
 void thermal_thresholds_handle(struct thermal_zone_device *tz, int *low, int *high);
-int thermal_thresholds_add(struct thermal_zone_device *tz, int temperature, int direction);
-int thermal_thresholds_delete(struct thermal_zone_device *tz, int temperature, int direction);
+void thermal_thresholds_flush(struct thermal_zone_device *tz, pid_t pid);
+int thermal_thresholds_add(struct thermal_zone_device *tz, int temperature, int direction, pid_t pid);
+int thermal_thresholds_delete(struct thermal_zone_device *tz, int temperature, int direction, pid_t pid);
 int thermal_thresholds_for_each(struct thermal_zone_device *tz,
 				int (*cb)(struct user_threshold *, void *arg), void *arg);
 #endif
diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
index 3e7c1c2e71a7..bcbaf62a1727 100644
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
+	THERMAL_GENL_ATTR_TZ_LAST_TEMP,
 	THERMAL_GENL_ATTR_TZ_TRIP,
 	THERMAL_GENL_ATTR_TZ_TRIP_ID,
 	THERMAL_GENL_ATTR_TZ_TRIP_TYPE,
@@ -50,6 +51,10 @@ enum thermal_genl_attr {
 	THERMAL_GENL_ATTR_CPU_CAPABILITY_ID,
 	THERMAL_GENL_ATTR_CPU_CAPABILITY_PERFORMANCE,
 	THERMAL_GENL_ATTR_CPU_CAPABILITY_EFFICIENCY,
+	THERMAL_GENL_ATTR_THRESHOLD,
+	THERMAL_GENL_ATTR_THRESHOLD_TEMP,
+	THERMAL_GENL_ATTR_THRESHOLD_WAY,
+	THERMAL_GENL_ATTR_THRESHOLD_PID,
 	__THERMAL_GENL_ATTR_MAX,
 };
 #define THERMAL_GENL_ATTR_MAX (__THERMAL_GENL_ATTR_MAX - 1)
@@ -77,6 +82,11 @@ enum thermal_genl_event {
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
@@ -84,12 +94,16 @@ enum thermal_genl_event {
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


