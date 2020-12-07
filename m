Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B8D2D1276
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 14:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgLGNr5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 08:47:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36578 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLGNr4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 08:47:56 -0500
Date:   Mon, 07 Dec 2020 13:47:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607348834;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GtpdxNsWdGGeAQ9k8B9CbaJGh0cIXPitCtqsjtlEYiI=;
        b=hDW5bwUBBRRhEKUB7oATTS+9kO3y8lOQsSaXyRitpQtQZETDmyXxBqE0DZ4t9if5WEmKx8
        Nb0W12S++nZ89A/oZZXPbQyVw4C5ETY4T9RJshA+EXj/qjBRuZ9bn7dG3jY9UPhi87aT2j
        Y8VTvN0f2+BaeiC42bi20tH9/2ZKsA1/GBCJAgDnX8eHgxb3FR27akC6jaTAsfBkGOeVul
        Sz6xWdA3dqHDFu1N8jMKAC/DkG6ArUzK23WA9yR0BUAPS7U9eZa5cigEh7Qk4cebDJj7Qo
        HT28KTu2kh4D37QPZMe4vyBIgHunhuagJCy5Ac4tL0MCoEkRz4yt1YLzb4Sacw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607348834;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GtpdxNsWdGGeAQ9k8B9CbaJGh0cIXPitCtqsjtlEYiI=;
        b=rXIYFyF+rzCa+I0ljXPkrppG5s2ac07z8eRv0Hl66OOv8fwDRu9KvDcBHH0zCJjPBXzCuy
        rCh8pGRlqexG3OAg==
From:   "thermal-bot for Lukasz Luba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: power allocator: change the 'k_i'
 coefficient estimation
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201124161025.27694-2-lukasz.luba@arm.com>
References: <20201124161025.27694-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Message-ID: <160734883397.3364.9771166533666047840.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     e34a7233896928e4e39d3cdb201ce605d5b258c2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//e34a7233896928e4e39d3cdb201ce605d5b258c2
Author:        Lukasz Luba <lukasz.luba@arm.com>
AuthorDate:    Tue, 24 Nov 2020 16:10:23 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 26 Nov 2020 17:11:59 +01:00

thermal: power allocator: change the 'k_i' coefficient estimation

Intelligent Power Allocation (IPA) is built around the PID controller
concept. The initialization code tries to setup the environment based on
the information available in DT or estimate the value based on minimum
power reported by each of the cooling device. The estimation will have an
impact on the PID controller behaviour via the related 'k_po', 'k_pu',
'k_i' coefficients and also on the power budget calculation.

This change prevents the situation when 'k_i' is relatively big compared
to 'k_po' and 'k_pu' values. This might happen when the estimation for
'sustainable_power' returned small value, thus 'k_po' and 'k_pu' are
small.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201124161025.27694-2-lukasz.luba@arm.com
---
 drivers/thermal/gov_power_allocator.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index b29e21c..2e20085 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -134,6 +134,7 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
 	int ret;
 	int switch_on_temp;
 	u32 temperature_threshold;
+	s32 k_i;
 
 	ret = tz->ops->get_trip_temp(tz, trip_switch_on, &switch_on_temp);
 	if (ret)
@@ -159,8 +160,11 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
 		tz->tzp->k_pu = int_to_frac(2 * sustainable_power) /
 			temperature_threshold;
 
-	if (!tz->tzp->k_i || force)
-		tz->tzp->k_i = int_to_frac(10) / 1000;
+	if (!tz->tzp->k_i || force) {
+		k_i = tz->tzp->k_pu / 10;
+		tz->tzp->k_i = k_i > 0 ? k_i : 1;
+	}
+
 	/*
 	 * The default for k_d and integral_cutoff is 0, so we can
 	 * leave them as they are.
