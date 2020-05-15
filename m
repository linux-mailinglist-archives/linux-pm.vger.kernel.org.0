Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218EC1D5019
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 16:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgEOOLR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 10:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726016AbgEOOLQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 10:11:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55D5C05BD09
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 07:11:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s8so3700725wrt.9
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 07:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NwWwB2bsHyqVn60WSLg/CHYMAktb7EgM42/i9ZQBRPE=;
        b=FP2Wnh9wGVMLKaXByvxPrD7YPJO+29N6+HcWgfZzXCaKc9Il4nOvXcfcQbaSKHFZEC
         sni0b+tP1p3AYSJaBO7q3X5rbc49qiHYvP43yhCw7LcmTVGoquyR4QH628KhPqVhnRzR
         a+BI6swEWBW5XWCzC6+9pZRzXOIeoYMP740EkWh4cQDh656pQ+xkLXtZqG//B2qz56Ik
         VbGcHCABJX/QLS47G9tOBWAZBU6IPh2+7E7xI2P0wE/nzQx+ZPFp88McFCDFKLl2mrmt
         y5sbZYdrtWZEmIrgUB2i9jYn4eMtHGePQWN9RjA77pdC9op0qB95LLSVkpGv2uzdeqn4
         qsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NwWwB2bsHyqVn60WSLg/CHYMAktb7EgM42/i9ZQBRPE=;
        b=QENvHAOlfD6KG4K1Yo2VvqhaoQG3mwc6j+ZGSrIxFR6BwXceR872bXCAbXmfoelnaF
         WwYJoL3Xxfe25Cn+lHGI4IY5uhFBhqpos0xncjbxhJ+0vXFYrBlPI/r0zekuKelHxJ7d
         JmCrwARbmEX2lAGaPfBK/cQ4xS2SytR/pwFi2uNuEYk6NdMDnSPSCzb0PeFnUEw7FhwA
         FPY+H678/PT5rCaFYd/7ajBYZICQPwcF3N7BYsKClHrD+HlzXRh2mSjw3RWoEeBrp9qK
         kd+ZOvBCCBUBgdbsO9YXbdRKnqg8bZ6LmPobEllqRCrCI4lQ/LjDCUw4qR3NbjBLHyrS
         rqgQ==
X-Gm-Message-State: AOAM530muL0iKV3HGPvPUXjSX8iNEJwZ8iWLgHitQdotIjQB2vvy6gXO
        3nXUtr9uYKArSRx2OQt2Dj1M0g==
X-Google-Smtp-Source: ABdhPJzZaSr/CS0jn60FOy0ip/PqzmU69RIC5/otlAq3G5JqQufI3EWgYLlwR9aQUIX5z0poK9TE0w==
X-Received: by 2002:a05:6000:1187:: with SMTP id g7mr4640035wrx.54.1589551874245;
        Fri, 15 May 2020 07:11:14 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id d6sm4432438wra.63.2020.05.15.07.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 07:11:13 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, srinivas.pandruvada@linux.intel.com,
        arnd@arndb.de, rkumbako@codeaurora.org, ilina@codeaurora.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] thermal: core: genetlink support for events/cmd/sampling
Date:   Fri, 15 May 2020 16:10:33 +0200
Message-Id: <20200515141034.19154-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515141034.19154-1-daniel.lezcano@linaro.org>
References: <20200515141034.19154-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Initially the thermal framework had a very simple notification
mechanism to send generic netlink messages to the userspace.

The notification function was never called from anywhere and the
corresponding dead code was removed. It was probably a first attempt
to introduce the netlink notification.

At LPC2018, the presentation "Linux thermal: User kernel interface",
proposed to create the notifications to the userspace via a kfifo.

The advantage of the kfifo is the performance. It is usually used from
a 1:1 communication channel where a driver captures data and send them
as fast as possible to an userspace process.

The inconvenient is the process uses the notification channel
exclusively, thus no other process is allowed to use the channel to
get temperature or notifications.

The purpose of this series is to provide a fully netlink featured
thermal management.

This patch is defining a generic netlink API to discover the current
thermal setup, get events and temperature sampling. As any genetlink
protocol, it can evolve and the versionning allows to keep the backward
compatibility.

In order to not flood the user with a single channel data, there are
two multicast channels, one for the temperature sampling when the
thermal zone is updated and another one for the events, so the user
can get the events only without the thermal zone temperature
sampling. All these events are from the ones presented at the LPC2018.

Also, a list of commands to discover the thermal setup is given and
can be extended on purpose.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Makefile          |   2 +-
 drivers/thermal/thermal_core.h    |  13 +
 drivers/thermal/thermal_netlink.c | 612 ++++++++++++++++++++++++++++++
 include/linux/thermal.h           |  12 -
 include/uapi/linux/thermal.h      |  80 +++-
 5 files changed, 699 insertions(+), 20 deletions(-)
 create mode 100644 drivers/thermal/thermal_netlink.c

diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 8c8ed7b79915..80fddb02cb32 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_THERMAL)		+= thermal_sys.o
 thermal_sys-y			+= thermal_core.o thermal_sysfs.o \
-					thermal_helpers.o
+					thermal_helpers.o thermal_netlink.o
 
 # interface to/from other layers providing sensors
 thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 7e8f45db6bbf..4c98d398c301 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -52,6 +52,19 @@ int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
 
 struct thermal_zone_device *thermal_zone_get_by_id(int id);
 
+/* Netlink notification function */
+int thermal_notify_tz_create(int tz_id, const char *name);
+int thermal_notify_tz_delete(int tz_id);
+int thermal_notify_tz_enable(int tz_id);
+int thermal_notify_tz_disable(int tz_id);
+int thermal_notify_tz_trip_low(int tz_id, int id);
+int thermal_notify_tz_trip_high(int tz_id, int id);
+int thermal_notify_tz_trip_delete(int tz_id, int id);
+int thermal_notify_tz_trip_add(int tz_id, int id, int type,
+			       int temp, int hyst);
+int thermal_notify_tz_trip_change(int tz_id, int id, int type,
+				  int temp, int hyst);
+
 struct thermal_attr {
 	struct device_attribute attr;
 	char name[THERMAL_NAME_LENGTH];
diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
new file mode 100644
index 000000000000..a2bce846771e
--- /dev/null
+++ b/drivers/thermal/thermal_netlink.c
@@ -0,0 +1,612 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * Generic netlink for thermal management framework
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <net/genetlink.h>
+#include <uapi/linux/thermal.h>
+
+#include "thermal_core.h"
+
+static const struct genl_multicast_group thermal_genl_mcgrps[] = {
+	{ .name = THERMAL_GENL_SAMPLING_GROUP_NAME, },
+	{ .name = THERMAL_GENL_EVENT_GROUP_NAME,  },
+};
+
+static const struct nla_policy thermal_genl_policy[THERMAL_GENL_ATTR_MAX + 1] = {
+	/* Thermal zone */
+	[THERMAL_GENL_ATTR_TZ]			= { .type = NLA_NESTED },
+	[THERMAL_GENL_ATTR_TZ_ID]		= { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_TZ_TEMP]		= { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_TZ_TRIP]		= { .type = NLA_NESTED },
+	[THERMAL_GENL_ATTR_TZ_TRIP_ID]		= { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_TZ_TRIP_TEMP]	= { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_TZ_TRIP_TYPE]	= { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_TZ_TRIP_HYST]	= { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_TZ_MODE]		= { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_TZ_CDEV_WEIGHT]	= { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_TZ_NAME]		= { .type = NLA_STRING,
+						    .len = THERMAL_NAME_LENGTH },
+	/* Governor(s) */
+	[THERMAL_GENL_ATTR_TZ_GOV]		= { .type = NLA_NESTED },
+	[THERMAL_GENL_ATTR_TZ_GOV_NAME]		= { .type = NLA_STRING,
+						    .len = THERMAL_NAME_LENGTH },
+	/* Cooling devices */
+	[THERMAL_GENL_ATTR_CDEV]		= { .type = NLA_NESTED },
+	[THERMAL_GENL_ATTR_CDEV_ID]		= { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_CDEV_CUR_STATE]	= { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_CDEV_MAX_STATE]	= { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_CDEV_MIN_STATE]	= { .type = NLA_U32 },
+	[THERMAL_GENL_ATTR_CDEV_NAME]		= { .type = NLA_STRING,
+						    .len = THERMAL_NAME_LENGTH },
+};
+
+struct param {
+	struct nlattr ** attrs;
+	struct sk_buff *msg;
+	const char *name;
+	int tz_id;
+	int id;
+	int temp;
+	int type;
+	int hyst;
+	int state;
+	int min_state;
+	int max_state;
+};
+
+typedef int (*cb_t)(struct param *);
+
+static struct genl_family thermal_gnl_family;
+
+/************************** Sampling encoding *******************************/
+
+int thermal_genl_sampling_temp(int id, int temp)
+{
+	struct sk_buff *skb;
+	void *hdr;
+
+	skb = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(skb, 0, 0, &thermal_gnl_family, 0,
+			  THERMAL_GENL_SAMPLING_TEMP);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(skb, THERMAL_GENL_ATTR_TZ_ID, id))
+		goto out_cancel;
+
+	if (nla_put_u32(skb, THERMAL_GENL_ATTR_TZ_TEMP, temp))
+		goto out_cancel;
+
+	genlmsg_end(skb, hdr);
+
+	genlmsg_multicast(&thermal_gnl_family, skb, 0, 0, GFP_KERNEL);
+
+	return 0;
+out_cancel:
+	genlmsg_cancel(skb, hdr);
+	nlmsg_free(skb);
+
+	return -EMSGSIZE;
+}
+
+/**************************** Event encoding *********************************/
+
+static int thermal_genl_event_tz_create(struct param *p)
+{
+	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
+	    nla_put_string(p->msg, THERMAL_GENL_ATTR_TZ_NAME, p->name))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int thermal_genl_event_tz(struct param *p)
+{
+	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int thermal_genl_event_tz_trip_high(struct param *p)
+{
+	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p->id))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int thermal_genl_event_tz_trip_add(struct param *p)
+{
+	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p->id) ||
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_TYPE, p->type) ||
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_TEMP, p->temp) ||
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_HYST, p->hyst))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int thermal_genl_event_tz_trip_delete(struct param *p)
+{
+	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_ID, p->tz_id) ||
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, p->id))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int thermal_genl_event_cdev_add(struct param *p)
+{
+	if (nla_put_string(p->msg, THERMAL_GENL_ATTR_CDEV_NAME,
+			   p->name) ||
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_ID,
+			p->id) ||
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_MIN_STATE,
+			p->min_state) ||
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_MAX_STATE,
+			p->max_state))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int thermal_genl_event_cdev_delete(struct param *p)
+{
+	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_ID, p->id))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int thermal_genl_event_cdev_update(struct param *p)
+{
+	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_ID, p->id) ||
+	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_CUR_STATE, p->state))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int thermal_genl_event_gov_change(struct param *p)
+{
+	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_ID, p->id) ||
+	    nla_put_string(p->msg, THERMAL_GENL_ATTR_GOV_NAME, p->name))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+int thermal_genl_event_tz_delete(struct param *p)
+	__attribute__((alias("thermal_genl_event_tz")));
+
+int thermal_genl_event_tz_enable(struct param *p)
+	__attribute__((alias("thermal_genl_event_tz")));
+
+int thermal_genl_event_tz_disable(struct param *p)
+	__attribute__((alias("thermal_genl_event_tz")));
+
+int thermal_genl_event_tz_trip_low(struct param *p)
+	__attribute__((alias("thermal_genl_event_tz_trip_high")));
+
+int thermal_genl_event_tz_trip_change(struct param *)
+	__attribute__((alias("thermal_genl_event_tz_trip_add")));
+
+static cb_t event_cb[] = {
+	[THERMAL_GENL_EVENT_TZ_CREATE]		= thermal_genl_event_tz_create,
+	[THERMAL_GENL_EVENT_TZ_DELETE]		= thermal_genl_event_tz_delete,
+	[THERMAL_GENL_EVENT_TZ_ENABLE]		= thermal_genl_event_tz_enable,
+	[THERMAL_GENL_EVENT_TZ_DISABLE]		= thermal_genl_event_tz_disable,
+	[THERMAL_GENL_EVENT_TZ_TRIP_HIGH]	= thermal_genl_event_tz_trip_high,
+	[THERMAL_GENL_EVENT_TZ_TRIP_LOW]	= thermal_genl_event_tz_trip_low,
+	[THERMAL_GENL_EVENT_TZ_TRIP_CHANGE]	= thermal_genl_event_tz_trip_change,
+	[THERMAL_GENL_EVENT_TZ_TRIP_ADD]	= thermal_genl_event_tz_trip_add,
+	[THERMAL_GENL_EVENT_TZ_TRIP_DELETE]	= thermal_genl_event_tz_trip_delete,
+	[THERMAL_GENL_EVENT_TZ_CDEV_ADD]	= thermal_genl_event_cdev_add,
+	[THERMAL_GENL_EVENT_TZ_CDEV_DELETE]	= thermal_genl_event_cdev_delete,
+	[THERMAL_GENL_EVENT_TZ_CDEV_UPDATE]	= thermal_genl_event_cdev_update,
+	[THERMAL_GENL_EVENT_TZ_GOV_CHANGE]	= thermal_genl_event_gov_change,
+};
+
+/*
+ * Generic netlink event encoding
+ */
+static int thermal_genl_send_event(enum thermal_genl_event event,
+				   struct param *p)
+{
+	struct sk_buff *msg;
+	int ret = -EMSGSIZE;
+	void *hdr;
+
+        msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+	p->msg = msg;
+
+	hdr = genlmsg_put(msg, 0, 0, &thermal_gnl_family, 0, event);
+	if (!hdr)
+		goto out_free_msg;
+
+	ret = event_cb[event](p);
+	if (ret)
+		goto out_cancel_msg;
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast(&thermal_gnl_family, msg, 0, 1, GFP_KERNEL);
+
+	return 0;
+
+out_cancel_msg:
+	genlmsg_cancel(msg, hdr);
+out_free_msg:
+	nlmsg_free(msg);
+
+	return ret;
+}
+
+int thermal_notify_tz_create(int tz_id, const char *name)
+{
+	struct param p = { .tz_id = tz_id, .name = name };
+
+	return 	thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_CREATE, &p);
+}
+
+int thermal_notify_tz_delete(int tz_id)
+{
+	struct param p = { .tz_id = tz_id };
+
+	return 	thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_DELETE, &p);
+}
+
+int thermal_notify_tz_enable(int tz_id)
+{
+	struct param p = { .tz_id = tz_id };
+
+	return 	thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_ENABLE, &p);
+}
+
+int thermal_notify_tz_disable(int tz_id)
+{
+	struct param p = { .tz_id = tz_id };
+
+	return 	thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_DISABLE, &p);
+}
+
+int thermal_notify_tz_trip_low(int tz_id, int id)
+{
+	struct param p = { .tz_id = tz_id, .id = id };
+
+	return 	thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_LOW, &p);
+}
+
+int thermal_notify_tz_trip_high(int tz_id, int id)
+{
+	struct param p = { .tz_id = tz_id, .id = id };
+
+	return 	thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_HIGH, &p);
+}
+
+int thermal_notify_tz_trip_add(int tz_id, int id, int type, int temp, int hyst)
+{
+	struct param p = { .tz_id = tz_id, .id = id, .type = type,
+			   .temp = temp, .hyst = hyst };
+
+	return 	thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_ADD, &p);
+}
+
+int thermal_notify_tz_trip_delete(int tz_id, int id)
+{
+	struct param p = { .tz_id = tz_id, .id = id };
+
+	return 	thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_DELETE, &p);
+}
+
+int thermal_notify_tz_trip_change(int tz_id, int id, int type, int temp, int hyst)
+{
+	struct param p = { .tz_id = tz_id, .id = id, .type = type,
+			   .temp = temp, .hyst = hyst };
+
+	return 	thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_CHANGE, &p);
+}
+
+/*************************** Command encoding ********************************/
+
+static int __thermal_genl_cmd_tz_get(struct thermal_zone_device *tz, void *data)
+{
+	struct sk_buff *msg = data;
+
+	if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_ID, tz->id) ||
+	    nla_put_string(msg, THERMAL_GENL_ATTR_TZ_NAME, tz->type))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int thermal_genl_cmd_tz_get(struct param *p)
+{
+	struct sk_buff *msg = p->msg;
+	struct nlattr *start_tz;
+	int ret;
+
+	start_tz = nla_nest_start(msg, THERMAL_GENL_ATTR_TZ);
+	if (!start_tz)
+		return -EMSGSIZE;
+
+	ret = for_each_thermal_zone(__thermal_genl_cmd_tz_get, msg);
+	if (ret)
+		goto out_cancel_nest;
+
+	nla_nest_end(msg, start_tz);
+
+	return 0;
+
+out_cancel_nest:
+	nla_nest_cancel(msg, start_tz);
+
+	return ret;
+}
+
+static int thermal_genl_cmd_tz_get_trip(struct param *p)
+{
+	struct sk_buff *msg = p->msg;
+	struct thermal_zone_device *tz;
+	struct nlattr *start_trip;
+	int i, id;
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
+	start_trip = nla_nest_start(msg, THERMAL_GENL_ATTR_TZ_TRIP);
+	if (!start_trip)
+		return -EMSGSIZE;
+
+	mutex_lock(&tz->lock);
+
+	for (i = 0; i < tz->trips; i++) {
+
+		enum thermal_trip_type type;
+		int temp, hyst;
+
+		tz->ops->get_trip_type(tz, i, &type);
+		tz->ops->get_trip_temp(tz, i, &temp);
+		tz->ops->get_trip_hyst(tz, i, &hyst);
+
+		if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, i) ||
+		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TYPE, type) ||
+		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TEMP, temp) ||
+		    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_HYST, hyst))
+			goto out_cancel_nest;
+	}
+
+	mutex_unlock(&tz->lock);
+
+	nla_nest_end(msg, start_trip);
+
+	return 0;
+
+out_cancel_nest:
+	mutex_unlock(&tz->lock);
+
+	return -EMSGSIZE;
+}
+
+static int thermal_genl_cmd_tz_get_temp(struct param *p)
+{
+	struct sk_buff *msg = p->msg;
+	struct thermal_zone_device *tz;
+	int temp, ret, id;
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
+	ret = thermal_zone_get_temp(tz, &temp);
+	if (ret)
+		return ret;
+
+	if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_ID, id) ||
+	    nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TEMP, temp))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int thermal_genl_cmd_tz_get_gov(struct param *p)
+{
+	struct sk_buff *msg = p->msg;
+	struct thermal_zone_device *tz;
+	int id, ret = 0;
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
+
+	if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_ID, id) ||
+	    nla_put_string(msg, THERMAL_GENL_ATTR_TZ_GOV_NAME,
+			   tz->governor->name))
+		ret = -EMSGSIZE;
+
+	mutex_unlock(&tz->lock);
+
+	return ret;
+}
+
+static int __thermal_genl_cmd_cdev_get(struct thermal_cooling_device *cdev,
+				       void *data)
+{
+	struct sk_buff *msg = data;
+
+	if (nla_put_u32(msg, THERMAL_GENL_ATTR_CDEV_ID, cdev->id))
+		return -EMSGSIZE;
+
+	if (nla_put_string(msg, THERMAL_GENL_ATTR_CDEV_NAME, cdev->type))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int thermal_genl_cmd_cdev_get(struct param *p)
+{
+	struct sk_buff *msg = p->msg;
+	struct nlattr *start_cdev;
+	int ret;
+
+	start_cdev = nla_nest_start(msg, THERMAL_GENL_ATTR_CDEV);
+	if (!start_cdev)
+		return -EMSGSIZE;
+
+	ret = for_each_thermal_cooling_device(__thermal_genl_cmd_cdev_get, msg);
+	if (ret)
+		goto out_cancel_nest;
+
+	nla_nest_end(msg, start_cdev);
+
+	return 0;
+out_cancel_nest:
+	nla_nest_cancel(msg, start_cdev);
+
+	return ret;
+}
+
+static cb_t cmd_cb[] = {
+	[THERMAL_GENL_CMD_TZ_GET]	= thermal_genl_cmd_tz_get,
+	[THERMAL_GENL_CMD_TZ_GET_TRIP]	= thermal_genl_cmd_tz_get_trip,
+	[THERMAL_GENL_CMD_TZ_GET_TEMP]	= thermal_genl_cmd_tz_get_temp,
+	[THERMAL_GENL_CMD_TZ_GET_GOV]	= thermal_genl_cmd_tz_get_gov,
+	[THERMAL_GENL_CMD_CDEV_GET]	= thermal_genl_cmd_cdev_get,
+};
+
+int thermal_genl_cmd_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct param p = { .msg = skb };
+	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
+	int cmd = info->ops->cmd;
+	int ret = -EMSGSIZE;
+	void *hdr;
+
+	hdr = genlmsg_put(skb, 0, 0, &thermal_gnl_family, 0, cmd);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	ret = cmd_cb[cmd](&p);
+	if (ret)
+		goto out_cancel_msg;
+
+	genlmsg_end(skb, hdr);
+
+	return 0;
+
+out_cancel_msg:
+	genlmsg_cancel(skb, hdr);
+
+	return ret;
+}
+
+int thermal_genl_cmd_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct param p = { .attrs = info->attrs };
+	struct sk_buff *msg;
+	void *hdr;
+	int cmd = info->genlhdr->cmd;
+	int ret = -EMSGSIZE;
+
+        msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+	p.msg = msg;
+
+        hdr = genlmsg_put_reply(msg, info, &thermal_gnl_family, 0, cmd);
+	if (!hdr)
+		goto out_free_msg;
+
+	ret = cmd_cb[cmd](&p);
+	if (ret)
+		goto out_cancel_msg;
+
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_reply(msg, info);
+
+out_cancel_msg:
+	genlmsg_cancel(msg, hdr);
+out_free_msg:
+	nlmsg_free(msg);
+
+	return ret;
+}
+
+static const struct genl_ops thermal_genl_ops[] = {
+	{
+		.cmd = THERMAL_GENL_CMD_TZ_GET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.dumpit = thermal_genl_cmd_dumpit,
+	},
+	{
+		.cmd = THERMAL_GENL_CMD_TZ_GET_TRIP,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = thermal_genl_cmd_doit,
+	},
+	{
+		.cmd = THERMAL_GENL_CMD_TZ_GET_TEMP,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = thermal_genl_cmd_doit,
+	},
+	{
+		.cmd = THERMAL_GENL_CMD_TZ_GET_GOV,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = thermal_genl_cmd_doit,
+	},
+	{
+		.cmd = THERMAL_GENL_CMD_CDEV_GET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.dumpit = thermal_genl_cmd_dumpit,
+	},
+};
+
+static struct genl_family thermal_gnl_family __ro_after_init = {
+	.hdrsize	= 0,
+	.name		= THERMAL_GENL_FAMILY_NAME,
+	.version	= THERMAL_GENL_VERSION,
+	.maxattr	= THERMAL_GENL_ATTR_MAX,
+	.policy		= thermal_genl_policy,
+	.ops		= thermal_genl_ops,
+	.n_ops 		= ARRAY_SIZE(thermal_genl_ops),
+	.mcgrps		= thermal_genl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(thermal_genl_mcgrps),
+};
+
+static int __init thermal_netlink_init(void)
+{
+	return genl_register_family(&thermal_gnl_family);
+}
+core_initcall(thermal_netlink_init);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index fc93a6348082..d92643e310e2 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -37,18 +37,6 @@ struct thermal_cooling_device;
 struct thermal_instance;
 struct thermal_attr;
 
-enum thermal_device_mode {
-	THERMAL_DEVICE_DISABLED = 0,
-	THERMAL_DEVICE_ENABLED,
-};
-
-enum thermal_trip_type {
-	THERMAL_TRIP_ACTIVE = 0,
-	THERMAL_TRIP_PASSIVE,
-	THERMAL_TRIP_HOT,
-	THERMAL_TRIP_CRITICAL,
-};
-
 enum thermal_trend {
 	THERMAL_TREND_STABLE, /* temperature is stable */
 	THERMAL_TREND_RAISING, /* temperature is raising */
diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
index 22df67ed9e9c..3ee7515c7aea 100644
--- a/include/uapi/linux/thermal.h
+++ b/include/uapi/linux/thermal.h
@@ -4,21 +4,87 @@
 
 #define THERMAL_NAME_LENGTH	20
 
+enum thermal_device_mode {
+	THERMAL_DEVICE_DISABLED = 0,
+	THERMAL_DEVICE_ENABLED,
+};
+
+enum thermal_trip_type {
+	THERMAL_TRIP_ACTIVE = 0,
+	THERMAL_TRIP_PASSIVE,
+	THERMAL_TRIP_HOT,
+	THERMAL_TRIP_CRITICAL,
+};
+
 /* Adding event notification support elements */
-#define THERMAL_GENL_FAMILY_NAME                "thermal_event"
-#define THERMAL_GENL_VERSION                    0x02
-#define THERMAL_GENL_MCAST_GROUP_NAME           "thermal_mc_grp"
+#define THERMAL_GENL_FAMILY_NAME		"thermal"
+#define THERMAL_GENL_VERSION			0x01
+#define THERMAL_GENL_SAMPLING_GROUP_NAME	"sampling"
+#define THERMAL_GENL_EVENT_GROUP_NAME		"event"
 
-/* attributes of thermal_genl_family */
-enum {
+/* Attributes of thermal_genl_family */
+enum thermal_genl_attr {
 	THERMAL_GENL_ATTR_UNSPEC,
+	THERMAL_GENL_ATTR_TZ,
+	THERMAL_GENL_ATTR_TZ_ID,
+	THERMAL_GENL_ATTR_TZ_TEMP,
+	THERMAL_GENL_ATTR_TZ_TRIP,
+	THERMAL_GENL_ATTR_TZ_TRIP_ID,
+	THERMAL_GENL_ATTR_TZ_TRIP_TYPE,
+	THERMAL_GENL_ATTR_TZ_TRIP_TEMP,
+	THERMAL_GENL_ATTR_TZ_TRIP_HYST,
+	THERMAL_GENL_ATTR_TZ_MODE,
+	THERMAL_GENL_ATTR_TZ_NAME,
+	THERMAL_GENL_ATTR_TZ_CDEV_WEIGHT,
+	THERMAL_GENL_ATTR_TZ_GOV,
+	THERMAL_GENL_ATTR_TZ_GOV_NAME,
+	THERMAL_GENL_ATTR_CDEV,
+	THERMAL_GENL_ATTR_CDEV_ID,
+	THERMAL_GENL_ATTR_CDEV_CUR_STATE,
+	THERMAL_GENL_ATTR_CDEV_MAX_STATE,
+	THERMAL_GENL_ATTR_CDEV_MIN_STATE,
+	THERMAL_GENL_ATTR_CDEV_NAME,
+	THERMAL_GENL_ATTR_GOV_NAME,
+
 	__THERMAL_GENL_ATTR_MAX,
 };
 #define THERMAL_GENL_ATTR_MAX (__THERMAL_GENL_ATTR_MAX - 1)
 
-/* commands supported by the thermal_genl_family */
-enum {
+enum thermal_genl_sampling {
+	THERMAL_GENL_SAMPLING_TEMP,
+	__THERMAL_GENL_SAMPLING_MAX,
+};
+#define THERMAL_GENL_SAMPLING_MAX (__THERMAL_GENL_SAMPLING_MAX - 1)
+
+/* Events of thermal_genl_family */
+enum thermal_genl_event {
+	THERMAL_GENL_EVENT_UNSPEC,
+	THERMAL_GENL_EVENT_TZ_CREATE,		/* Thermal zone creation */
+	THERMAL_GENL_EVENT_TZ_DELETE,		/* Thermal zone deletion */
+	THERMAL_GENL_EVENT_TZ_DISABLE,		/* Thermal zone disabed */
+	THERMAL_GENL_EVENT_TZ_ENABLE,		/* Thermal zone enabled */
+	THERMAL_GENL_EVENT_TZ_TRIP_HIGH,	/* Trip point crossed the way up */
+	THERMAL_GENL_EVENT_TZ_TRIP_LOW,		/* Trip point crossed the way down */
+	THERMAL_GENL_EVENT_TZ_TRIP_CHANGE,	/* Trip point changed */
+	THERMAL_GENL_EVENT_TZ_TRIP_ADD,		/* Trip point added */
+	THERMAL_GENL_EVENT_TZ_TRIP_DELETE,	/* Trip point deleted */
+	THERMAL_GENL_EVENT_TZ_CDEV_ADD,		/* Cdev bound to the thermal zone */
+	THERMAL_GENL_EVENT_TZ_CDEV_DELETE,	/* Cdev unbound */
+	THERMAL_GENL_EVENT_TZ_CDEV_UPDATE,	/* Cdev state updated */
+	THERMAL_GENL_EVENT_TZ_GOV_CHANGE,	/* Governor policy changed  */
+	__THERMAL_GENL_EVENT_MAX,
+};
+#define THERMAL_GENL_EVENT_MAX (__THERMAL_GENL_EVENT_MAX - 1)
+
+/* Commands supported by the thermal_genl_family */
+enum thermal_genl_cmd {
 	THERMAL_GENL_CMD_UNSPEC,
+	THERMAL_GENL_CMD_TZ_GET,	/* List thermal zones id */
+	THERMAL_GENL_CMD_TZ_GET_TRIP,	/* List of thermal trips */
+	THERMAL_GENL_CMD_TZ_GET_TEMP,	/* Get the thermal zone temperature */
+	THERMAL_GENL_CMD_TZ_GET_GOV,	/* Get the thermal zone governor */
+	THERMAL_GENL_CMD_TZ_GET_MODE,	/* Get the thermal zone mode */
+	THERMAL_GENL_CMD_CDEV_GET,	/* List of cdev id */
 	__THERMAL_GENL_CMD_MAX,
 };
 #define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
-- 
2.17.1

