Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0449F436BE3
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 22:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhJUUTF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 16:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhJUUTF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 16:19:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2781CC0613B9
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 13:16:49 -0700 (PDT)
Date:   Thu, 21 Oct 2021 20:16:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634847406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dXJBugjrAr9RywylaTWd01fX2olQ2Q9ubsjyqst93bo=;
        b=q1fgWawg/WLTvPzQ2fvs8+WhzG/Q0wls6YDUybop5vj2wOfWDXPfdR1pXLEAIhW/4SAWJv
        9Il7PE0YlGpQGMQkIkDuc38zzW72LjqqOM/7OeS9Vg1wGbZVIvuKIaxSo4gtVZeCiUOBjQ
        Y0X6+hU0KVY1s1d4NlhmLS+Q5PvWF8MOQcew4klkSXTKkVGE2dwBbD5xjBbMrjB15T1ZNy
        d43SGk7KI6X5wVyk5tGhENjHgTEgqTM4FoRjyQ88tn5s11O1k4LMOIfMWiboKG8c+A+Lmo
        bu2HhNPAORaJTeAXOM5tX8ZMjpX5xvbONXH+ZoDh68Tq64hrnMJIIk8S+wBYnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634847406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dXJBugjrAr9RywylaTWd01fX2olQ2Q9ubsjyqst93bo=;
        b=UvjBtxkudcLmhVFIHPfsmSRQhPeTHt/6NXdn96B+GGsEyrtOOgeVFkBccol7n+AXF0agqP
        KixJDjOC4t9hcnCQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Deprecate changing cooling
 device state from userspace
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20211019163506.2831454-2-daniel.lezcano@linaro.org>
References: <20211019163506.2831454-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <163484740592.25758.10288562624422443960.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     a67a46af4ad6342378e332b7420c1d1a2818c53f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//a67a46af4ad6342378e332b7420c1d1a2818c53f
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Tue, 19 Oct 2021 18:35:06 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 21 Oct 2021 17:35:11 +02:00

thermal/core: Deprecate changing cooling device state from userspace

The cooling devices have their cooling device set_cur_state
read-writable all the time in the sysfs directory, thus allowing the
userspace to act on it.

The thermal framework is wrongly used by userspace as a power capping
framework by acting on the cooling device opaque state. This one then
competes with the in-kernel governor decision.

We have seen in out-of-tree kernels, a big number of devices which are
abusely declaring themselves as cooling device just to act on their
power.

The role of the thermal framework is to protect the junction
temperature of the silicon. Letting the userspace to play with a
cooling device is invalid and potentially dangerous.

The powercap framework is the right framework to do power capping and
moreover it deals with the aggregation via the dev pm qos.

As the userspace governor is marked deprecated and about to be
removed, there is no point to keep this file writable also in the
future.

Emit a warning and deprecate the interface.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://lore.kernel.org/r/20211019163506.2831454-2-daniel.lezcano@linaro.org
---
 drivers/thermal/thermal_sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 1c4aac8..f154bad 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -610,6 +610,9 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
 	unsigned long state;
 	int result;
 
+	dev_warn_once(&cdev->device,
+		      "Setting cooling device state is deprecated\n");
+	
 	if (sscanf(buf, "%ld\n", &state) != 1)
 		return -EINVAL;
 
