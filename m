Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C355436BE4
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 22:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhJUUTG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 16:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhJUUTF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 16:19:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276A1C061764
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 13:16:49 -0700 (PDT)
Date:   Thu, 21 Oct 2021 20:16:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634847407;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vEh+WsUdx1loLm9N651HSNlaNF+xqo6/Zx1MsYeD19s=;
        b=hec+Jg1VU6CS8inFbJzlfCdNLt56AxMJkUlzrCZ5YgEbV1dL/0NQyM0TWcDylkC/iW/IGx
        ucbV5Ojs7Cktxkm30fkKh6rEXXqmDewVBSLDLetw0FzJfcusoRUZQlWARYF4aEF2PVhxB2
        H647/sHXwr00szIEJGCEU8k6x8DSbGguGFsC+xRv0puS7BxjCbdNff78mZCV4WHLahfAgi
        Y0780r9iEO4HSBV0LnCXFRbs1MrllmEbxWc/75SAfMN81QAMKSZeQjJ152gRvcMrwpWdSn
        KMkg/14I25j9n622T7CDhHu4Y//1hYNql5kkBqliXTF8JVu1xRSnRlNvj9ucdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634847407;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vEh+WsUdx1loLm9N651HSNlaNF+xqo6/Zx1MsYeD19s=;
        b=Cg9yWOGKrzPgVAzsEhoDYLvyvwebwUCvpiHgkWhrHqc34Eh4/dgN8RlT5rc2kS5AIWya9w
        hqTSI8vJZFlx33DQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Make the userspace governor deprecated
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20211019163506.2831454-1-daniel.lezcano@linaro.org>
References: <20211019163506.2831454-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <163484740669.25758.13185248511204238552.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     0275c9fb0eff3f77d437ab8a95b16e6f8f80b7f2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//0275c9fb0eff3f77d437ab8a95b16e6f8f80b7f2
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Tue, 19 Oct 2021 18:35:05 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 21 Oct 2021 17:35:05 +02:00

thermal/core: Make the userspace governor deprecated

The userspace governor is sending temperature when polling is active
and trip point crossed events. Nothing else.

AFAICT, this governor is used with custom kernels making the userspace
governor co-existing with another governor on the same thermal zone
because there was no notification mechanism, implying a hack in the
framework to support this configuration.

The new netlink thermal notification is able to provide more
information than the userspace governor and give the opportunity to
the users of this governor to replace it by a dedicated notification
framework.

The userspace governor will be removed as its usage is no longer
needed.

Add a warning message to tell the userspace governor is deprecated.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lore.kernel.org/r/20211019163506.2831454-1-daniel.lezcano@linaro.org
---
 drivers/thermal/gov_user_space.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/thermal/gov_user_space.c b/drivers/thermal/gov_user_space.c
index 82a7198..f4fe050 100644
--- a/drivers/thermal/gov_user_space.c
+++ b/drivers/thermal/gov_user_space.c
@@ -15,6 +15,14 @@
 
 #include "thermal_core.h"
 
+static int user_space_bind(struct thermal_zone_device *tz)
+{
+	pr_warn("Userspace governor deprecated: use thermal netlink "	\
+		"notification instead\n");
+
+	return 0;
+}
+
 /**
  * notify_user_space - Notifies user space about thermal events
  * @tz: thermal_zone_device
@@ -43,5 +51,6 @@ static int notify_user_space(struct thermal_zone_device *tz, int trip)
 static struct thermal_governor thermal_gov_user_space = {
 	.name		= "user_space",
 	.throttle	= notify_user_space,
+	.bind_to_tz	= user_space_bind,
 };
 THERMAL_GOVERNOR_DECLARE(thermal_gov_user_space);
