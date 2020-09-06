Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A0C25F10A
	for <lists+linux-pm@lfdr.de>; Mon,  7 Sep 2020 01:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIFXKK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Sep 2020 19:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgIFXKH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Sep 2020 19:10:07 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BE7C061573;
        Sun,  6 Sep 2020 16:10:06 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w3so13925479ljo.5;
        Sun, 06 Sep 2020 16:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fSaghmQzHJjk3kvUtDFN9SKS8X9oTbE2eDrEp3NKXxM=;
        b=riMbjmEOlyWNXfiYpGuR0zQVVyZfGKRhFnjQyEfC/xhGCzWUW2WBUPwj4SUyzL+ZlX
         Pdt0iFdEeSGQ3Ikr7bX4yoXGUH0MR9Cutrl5/IM4bN8ql3zpsNmBWDtzTJfYiyv+VIrm
         SVsbLA4vb+/I13KqEuwJJ/d8+ICyhu8wqOth8RpqLQW3M+XTwzpGFeiaoD5NKhxcoRYu
         ctcbbJsgRsKpaKF7kp6aBakq5BbK1cGvxFvKNbfOL5TkZU5iJcNsjQceOerUvbdGHNim
         ikZv7tNgbjSklO6eVIhhcg6cwtqa9KY2tpvcNa6uVH31nCDyYWHo2EhQXbE1kPzCjPKc
         VlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fSaghmQzHJjk3kvUtDFN9SKS8X9oTbE2eDrEp3NKXxM=;
        b=IrbQBI8twmKwruETgc1oZHe/mYzkTUSXHTrknU01jItTEWLrOWAL+9lC3hUZ/+d8eR
         2TGPR6a3NZL/YiXvzRMEOk8NhEbrvqKwFLf6gDIme5R2i3xEk9oEdW7mY0jm2i1jOSCr
         /Eh2Y07nxvnkZwuHVHq74/6UfTpvMTfOpoZm2xE0Nl/CaowY3xLX2ZIdJM9yoEfm/qHZ
         qEBd4tUh1uosnYP+IXj3EjeG4/ESenwKPjJhwQJvdNZH2Oa98a9l+aRA07v0VxV8l9oY
         Ru6nPg7N42sI/ajf2jj6yM1CvwTmMvt9TcV4iQjCCt6sBr85sjnU8inZad7cp+yoem/p
         uFbw==
X-Gm-Message-State: AOAM531JmyFciRM30WmMB+uvBNBABc4G5BfEV/f9jW3wPQFNZe8jcaoK
        FTeBr3gvlJncNq3gSWnyGq0=
X-Google-Smtp-Source: ABdhPJz6HMRnTs7MAyDfbAQ3Pozg9I5HcG3fQN6y8j86WDa0lCWucGIbq51C25feR4UgpI8QmbP/zg==
X-Received: by 2002:a05:651c:209:: with SMTP id y9mr3567862ljn.398.1599433804629;
        Sun, 06 Sep 2020 16:10:04 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id r17sm1325984ljp.117.2020.09.06.16.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 16:10:03 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 3/3] firmware: arm_scmi: Constify static scmi-ops
Date:   Mon,  7 Sep 2020 01:04:52 +0200
Message-Id: <20200906230452.33410-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906230452.33410-1-rikard.falkeborn@gmail.com>
References: <20200906230452.33410-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These are never modified, so make them const to allow the compiler to
put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/firmware/arm_scmi/clock.c   | 2 +-
 drivers/firmware/arm_scmi/common.h  | 2 +-
 drivers/firmware/arm_scmi/mailbox.c | 2 +-
 drivers/firmware/arm_scmi/notify.c  | 2 +-
 drivers/firmware/arm_scmi/perf.c    | 2 +-
 drivers/firmware/arm_scmi/power.c   | 2 +-
 drivers/firmware/arm_scmi/reset.c   | 2 +-
 drivers/firmware/arm_scmi/sensors.c | 2 +-
 drivers/firmware/arm_scmi/smc.c     | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 75e39882746e..a3b90be28009 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -318,7 +318,7 @@ scmi_clock_info_get(const struct scmi_handle *handle, u32 clk_id)
 	return clk;
 }
 
-static struct scmi_clk_ops clk_ops = {
+static const struct scmi_clk_ops clk_ops = {
 	.count_get = scmi_clock_count_get,
 	.info_get = scmi_clock_info_get,
 	.rate_get = scmi_clock_rate_get,
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index c113e578cc6c..233700a42bff 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -210,7 +210,7 @@ struct scmi_transport_ops {
  * @max_msg_size: Maximum size of data per message that can be handled.
  */
 struct scmi_desc {
-	struct scmi_transport_ops *ops;
+	const struct scmi_transport_ops *ops;
 	int max_rx_timeout_ms;
 	int max_msg;
 	int max_msg_size;
diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index 6998dc86b5ce..cc2de207fe10 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -181,7 +181,7 @@ mailbox_poll_done(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer)
 	return shmem_poll_done(smbox->shmem, xfer);
 }
 
-static struct scmi_transport_ops scmi_mailbox_ops = {
+static const struct scmi_transport_ops scmi_mailbox_ops = {
 	.chan_available = mailbox_chan_available,
 	.chan_setup = mailbox_chan_setup,
 	.chan_free = mailbox_chan_free,
diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 4731daaacd19..2754f9d01636 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -1421,7 +1421,7 @@ static void scmi_protocols_late_init(struct work_struct *work)
  * notify_ops are attached to the handle so that can be accessed
  * directly from an scmi_driver to register its own notifiers.
  */
-static struct scmi_notify_ops notify_ops = {
+static const struct scmi_notify_ops notify_ops = {
 	.register_event_notifier = scmi_register_notifier,
 	.unregister_event_notifier = scmi_unregister_notifier,
 };
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 3e1e87012c95..a3e7b1bfab00 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -748,7 +748,7 @@ static bool scmi_fast_switch_possible(const struct scmi_handle *handle,
 	return dom->fc_info && dom->fc_info->level_set_addr;
 }
 
-static struct scmi_perf_ops perf_ops = {
+static const struct scmi_perf_ops perf_ops = {
 	.limits_set = scmi_perf_limits_set,
 	.limits_get = scmi_perf_limits_get,
 	.level_set = scmi_perf_level_set,
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 46f213644c49..32bcf5821ea9 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -184,7 +184,7 @@ static char *scmi_power_name_get(const struct scmi_handle *handle, u32 domain)
 	return dom->name;
 }
 
-static struct scmi_power_ops power_ops = {
+static const struct scmi_power_ops power_ops = {
 	.num_domains_get = scmi_power_num_domains_get,
 	.name_get = scmi_power_name_get,
 	.state_set = scmi_power_state_set,
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index 3691bafca057..4e2dc5fc43d9 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -194,7 +194,7 @@ scmi_reset_domain_deassert(const struct scmi_handle *handle, u32 domain)
 	return scmi_domain_reset(handle, domain, 0, ARCH_COLD_RESET);
 }
 
-static struct scmi_reset_ops reset_ops = {
+static const struct scmi_reset_ops reset_ops = {
 	.num_domains_get = scmi_reset_num_domains_get,
 	.name_get = scmi_reset_name_get,
 	.latency_get = scmi_reset_latency_get,
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 1af0ad362e82..7d83680198de 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -275,7 +275,7 @@ static int scmi_sensor_count_get(const struct scmi_handle *handle)
 	return si->num_sensors;
 }
 
-static struct scmi_sensor_ops sensor_ops = {
+static const struct scmi_sensor_ops sensor_ops = {
 	.count_get = scmi_sensor_count_get,
 	.info_get = scmi_sensor_info_get,
 	.trip_point_config = scmi_sensor_trip_point_config,
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index a1537d123e38..1a03c3ec0230 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -137,7 +137,7 @@ smc_poll_done(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer)
 	return shmem_poll_done(scmi_info->shmem, xfer);
 }
 
-static struct scmi_transport_ops scmi_smc_ops = {
+static const struct scmi_transport_ops scmi_smc_ops = {
 	.chan_available = smc_chan_available,
 	.chan_setup = smc_chan_setup,
 	.chan_free = smc_chan_free,
-- 
2.28.0

