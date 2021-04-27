Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DCD36CBD8
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 21:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbhD0TpJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 15:45:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43102 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238671AbhD0TpJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 15:45:09 -0400
Date:   Tue, 27 Apr 2021 19:44:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552664;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tIxlk68aC4urLTPiSTvo5AdSsi9sTTCgeHolb8GgVXQ=;
        b=33eK7L2H5AYc10YYfWeqbd0JI4xMBEYSD1hK9QQP+z99R/3/oaErA22k9cWft72RIsNiYR
        3F0ZBPcOX5iIp7vvrHqAX9o/WKc5hsgLegaf9NnJSSKzm3RdfwsjbEVC+RXyKSWRi+wIgj
        q1l3qgPY4JVHoxCPYu5+0nyRhuYOWr4R48EcH5wvtxCqjhq0XxEznGbzyGlyxdA94uadxi
        U3ZqGqcZ6ZmN8OPtEEGGCzl4ROTLkADUYPehmsywP1pmEATDQE0wyVXw9GaYNLHYCUbQCv
        ef8MQrBNDi0ePNyC3IE2wGTH3wO3ZamAr179njc3flSfJJYFMCUfSTjhRxtfNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552664;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tIxlk68aC4urLTPiSTvo5AdSsi9sTTCgeHolb8GgVXQ=;
        b=WK+rsJW42Xwgoh3OAA+B2im+0kEUaqOdHC3tjylP2g6hoHCKxGw11B+CaZ0OugqOEqQjFK
        pbiDDUQHn2BGpXCw==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core/fair share: Lock the thermal
 zone while looping over instances
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210422153624.6074-2-lukasz.luba@arm.com>
References: <20210422153624.6074-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <161955266404.29796.3022344955506629348.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     fef05776eb02238dcad8d5514e666a42572c3f32
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//fef05776eb02238dcad8d5514e666a42572c3f32
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Thu, 22 Apr 2021 16:36:22 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 22 Apr 2021 23:51:32 +02:00

thermal/core/fair share: Lock the thermal zone while looping over instances

The tz->lock must be hold during the looping over the instances in that
thermal zone. This lock was missing in the governor code since the
beginning, so it's hard to point into a particular commit.

CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210422153624.6074-2-lukasz.luba@arm.com
---
 drivers/thermal/gov_fair_share.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index aaa0718..645432c 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -82,6 +82,8 @@ static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
 	int total_instance = 0;
 	int cur_trip_level = get_trip_level(tz);
 
+	mutex_lock(&tz->lock);
+
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if (instance->trip != trip)
 			continue;
@@ -110,6 +112,8 @@ static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
 		mutex_unlock(&instance->cdev->lock);
 		thermal_cdev_update(cdev);
 	}
+
+	mutex_unlock(&tz->lock);
 	return 0;
 }
 
