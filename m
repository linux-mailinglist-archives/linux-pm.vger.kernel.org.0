Return-Path: <linux-pm+bounces-14562-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9975997E933
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 12:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278651F21BF7
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 10:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC23B195FE3;
	Mon, 23 Sep 2024 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kNsl+XPN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBD0195B33
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085616; cv=none; b=qaYLj2qWamhv25pUkTtgHZ5CPS6e05IoH7ulxBJCj7IGIFyVg1caMAEMm/xVch3tRbtKs1n/1ylVIfdU9cz+adsmUu1GPEjjtAXC1m6aqqNHhEvHMNktmtX9OhT9L/23VzLxDgCEPL4B3UbTdIxTpwJLnZnke8VdHtdCyuYvtvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085616; c=relaxed/simple;
	bh=Rv0VNGOpcQAxlJ5c4odKksKY4r5O1Ig5wVCFjmGere8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ll5lAdVB7ply6bDbWigU7GYm3DV8XQwuk1aVQx83VqaWA4rRm6bcaZbw5wk1wXJ6ERVqOp7kisIz51Ey0bXtG27uNCJgHRWmHAnNH8cIbLGvux9r6IB/JUmPTp3DWnhTMjiBKxMyRPqLFPBtUOU6Feq4AAixGNTUSnK6KJ1KIwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kNsl+XPN; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374c3eef39eso2631257f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 03:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727085612; x=1727690412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qHLkBUlT98E1Ag9LPJ+pGTcISoPz6YLSslwp2Fk2Ik=;
        b=kNsl+XPNJ+CXq3rfb7Uq+nIunNs0XKpfuJAbiBhp3ShnIs1ha2eNDzm6drv1xR5zha
         bCddP5UDGOTsISBkd4w1i6vCtZ/jKZ7dWtXfC3Rbbt6TYc/MEyLfBHkA2ayZAUIJeKrg
         Z281eVb4e1NsHhnhRbGY0vp16X7JMcTeYvwvhfFHGPkQwn6CHAKryJJAUiDQGYOAsRv7
         mmzYi6vGdIcxi2pA4C/OxnsyI9ZBga29knOoSjfn0hPvpSmImeiKlfUa3aQaY9HwzYJo
         ICxeNnbkX3lJCxjGBFrNP+BhTucUcRCS0ZLNmg1I/kmFKEcFUlmP4jcXHOaoAAohsI7F
         nMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727085612; x=1727690412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qHLkBUlT98E1Ag9LPJ+pGTcISoPz6YLSslwp2Fk2Ik=;
        b=V3stQMrotBS6KnMJfaU+qEAGuqB3nDmbu8IR+T/eNA4efz2cqAGWBWwfWWrG4ee75D
         OfXNfx3/ysgNS4q16111ILGTuUrC9Q4Fat8oUXZRzp8M53XXeTqu36r+z2ab8OwlhRm0
         XUp+32B8XvrhhyUmbeSGFt8pK+Jy/bZqe87l2I1IZQeJCjWpl2ekqe24xRpGJPtWXAcF
         HAcoPCb7UwrB9SEP+Bdf1BrpxMXk4O0fozUwn82rhEZ32VdnSBElw1CYADuxPEzcnfX9
         7A1pze6z3KQodIEIjgedAZLPg51OVXp1vEiMPo07HxUjb6EwTcfdIyQo+Gica9ea7GHS
         XGrg==
X-Gm-Message-State: AOJu0YxWZavYewcuPjKHskII8o+Cbz/6U8asuko/2CXV1v6V7t5WKNiX
	iDxZ/ddp18EgSa3rD0XLHocKIcFk0Vmoer2zUV8IXqsasQ85Ti8pfW4Ln3cdfF4=
X-Google-Smtp-Source: AGHT+IExl1gs7R0jo+bWaGNcMnhkIHo1JQuGiqUNU/XvsQaTdgnbx6Pf8ul8i+ETwrbUqtTP7AA99g==
X-Received: by 2002:a5d:4c44:0:b0:371:8319:4dcc with SMTP id ffacd0b85a97d-37a422520c3mr6529163f8f.2.1727085612387;
        Mon, 23 Sep 2024 03:00:12 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm23977216f8f.49.2024.09.23.03.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 03:00:12 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	quic_manafm@quicinc.com
Subject: [PATCH v4 3/6] thermal/netlink: Add the commands and the events for the thresholds
Date: Mon, 23 Sep 2024 11:59:59 +0200
Message-ID: <20240923100005.2532430-4-daniel.lezcano@linaro.org>
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
 drivers/thermal/thermal_netlink.h    |  34 ++++
 drivers/thermal/thermal_thresholds.c |  38 +++--
 drivers/thermal/thermal_thresholds.h |   6 +-
 include/uapi/linux/thermal.h         |  28 +++-
 5 files changed, 313 insertions(+), 32 deletions(-)

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
index e01221e8816b..3f85c636029c 100644
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
@@ -139,6 +146,33 @@ static inline int thermal_genl_cpu_capability_event(int count, struct thermal_ge
 	return 0;
 }
 
+static inline int thermal_notify_threshold_add(const struct thermal_zone_device *tz,
+					       int temperature, int direction, pid_t pid)
+{
+	return 0;
+}
+
+static inline int thermal_notify_threshold_delete(const struct thermal_zone_device *tz,
+						  int temperature, int direction, pid_t pid)
+{
+	return 0;
+}
+
+static inline int thermal_notify_threshold_flush(const struct thermal_zone_device *tz, pid_t pid)
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


