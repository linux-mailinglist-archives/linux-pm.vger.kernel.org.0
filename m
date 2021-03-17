Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EAB33F08E
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 13:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhCQMjM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 08:39:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49778 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhCQMjL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 08:39:11 -0400
Date:   Wed, 17 Mar 2021 12:39:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rdb/071E8xu6jSaNi/CKMaYaBVo4fUoLu6Rd8F5QRVg=;
        b=Llqt0JkVa7C7PXhJoXjMBubFVLFjvMs+ce/OVO/AtuaI66gBuWnppxmwppOpWgO2wi5GSg
        qC8XB3Me1fEPJdNoBLy0HTzDG3xxJaHLt5xaNKYXYVL2OfAkGeP4NK1f4oXaodBKtyXCEO
        DWGGQhO5JwBeBg/bXmcUEDsUviM+Gbq2eSKskFlo4OVJe4vvqmmGDddVCTangYVSdW6EqE
        CVL6+GvhfU6hB6Q23Hozi8wi79RDSih4hILJDWcNqWsZQX8JUMTj7+emXi/HOg4uMGH8GH
        v25tbMwRpVVjAOwXn7DBkUm4SN/p7vGlHkYiyhuIKzDLEj104FumI2u5M79Usg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rdb/071E8xu6jSaNi/CKMaYaBVo4fUoLu6Rd8F5QRVg=;
        b=ge0wHQIpE18ubPoyG2Hi75zTc5m6a2zTa1PsO6MUc4GqiDrpPr2ET6jS+bF0fchfi8qDOp
        3kuLeGbB5F0mXJDw==
From:   "thermal-bot for jeson.gao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core/power_allocator: Using round the
 division when re-divvying up power
Cc:     Jeson Gao <jeson.gao@unisoc.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <1615796737-4688-1-git-send-email-gao.yunxiao6@gmail.com>
References: <1615796737-4688-1-git-send-email-gao.yunxiao6@gmail.com>
MIME-Version: 1.0
Message-ID: <161598474937.398.15282452512410818292.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     6e3e14c9385c3cfb35f9da4f495acdd21f9bc25b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//6e3e14c9385c3cfb35f9da4f495acdd21f9bc25b
Author:        jeson.gao <jeson.gao@unisoc.com>
AuthorDate:    Mon, 15 Mar 2021 16:25:37 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 16 Mar 2021 12:44:20 +01:00

thermal/core/power_allocator: Using round the division when re-divvying up power

The division is used directly in re-divvying up power, the decimal part will
be discarded, devices will get less than the extra_actor_power - 1.
if using round the division to make the calculation more accurate.

For example:
actor0 received more than its max_power, it has the extra_power 759
actor1 received less than its max_power, it require extra_actor_power 395
actor2 received less than its max_power, it require extra_actor_power 365
actor1 and actor2 require the total capped_extra_power 760

using division in re-divvying up power
actor1 would actually get the extra_actor_power 394
actor2 would actually get the extra_actor_power 364

if using round the division in re-divvying up power
actor1 would actually get the extra_actor_power 394
actor2 would actually get the extra_actor_power 365

Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1615796737-4688-1-git-send-email-gao.yunxiao6@gmail.com
---
 drivers/thermal/gov_power_allocator.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 92acae5..2802a0e 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -374,9 +374,11 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 	 */
 	extra_power = min(extra_power, capped_extra_power);
 	if (capped_extra_power > 0)
-		for (i = 0; i < num_actors; i++)
-			granted_power[i] += (extra_actor_power[i] *
-					extra_power) / capped_extra_power;
+		for (i = 0; i < num_actors; i++) {
+			u64 extra_range = (u64)extra_actor_power[i] * extra_power;
+			granted_power[i] += DIV_ROUND_CLOSEST_ULL(extra_range,
+							 capped_extra_power);
+		}
 }
 
 static int allocate_power(struct thermal_zone_device *tz,
