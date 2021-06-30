Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FD53B7FFF
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 11:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbhF3Jde (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 05:33:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59574 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbhF3Jdd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 05:33:33 -0400
Date:   Wed, 30 Jun 2021 09:31:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625045464;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c4HOgI0EG35RaMExzUUqKktRFZ/tyzlA015m9m41XA8=;
        b=bx4VNncXRskQMrph3LJ2bSju5r7UXuithLZXiras/DQBYRXatVaDaVZtnEIcuWkn2SVC2g
        VnaXDhbA8Rrjcrl1U6BvZvNkA8rIV4JBGgKATK/KE1mTJVEWTzTt4ExAKEEza4lkOiQK2v
        ll63cIrMqJQFmsElcsjdc+v24gfGYooG9smelpIDpyRWxt3Kl+sriAuJ8e1L/iDtbY/5hY
        DI4DVoDtJLKMJRhZfBLYR+jvZhJmr0JS2BnqXhFBs5WJQzZhdVIp5UQWtk/2ZTCCLjxn+b
        aDnXHF+NYHX87Md8l7BjWeUHAJS+gnbiXpEu959WpQwgDOENByzxk0seyFH8DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625045464;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c4HOgI0EG35RaMExzUUqKktRFZ/tyzlA015m9m41XA8=;
        b=aDDYjoRK+VnQeWHdNf8wMhGRCuhxKDWxgJ4IGLfP6E7Cmr/hjpD5Ku0kEesZsxtdrlLiG7
        7u6Hg10agOWqzLAA==
From:   "thermal-bot for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/intel/intel_soc_dts_iosf:
 Switch to use find_first_zero_bit()
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210618153451.89246-1-andriy.shevchenko@linux.intel.com>
References: <20210618153451.89246-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162504546362.395.17933701592353332670.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     58d353c888a04efaac04547702ff05d16c43f9b3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//58d353c888a04efaac04547702ff05d16c43f9b3
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 18 Jun 2021 18:34:51 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 21 Jun 2021 15:50:54 +02:00

thermal/drivers/intel/intel_soc_dts_iosf: Switch to use find_first_zero_bit()

Switch to use find_first_zero_bit() instead of open-coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210618153451.89246-1-andriy.shevchenko@linux.intel.com
---
 drivers/thermal/intel/intel_soc_dts_iosf.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
index 4f1a2f7..342b0bb 100644
--- a/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -350,13 +350,14 @@ int intel_soc_dts_iosf_add_read_only_critical_trip(
 	int i, j;
 
 	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
-		for (j = 0; j < sensors->soc_dts[i].trip_count; ++j) {
-			if (!(sensors->soc_dts[i].trip_mask & BIT(j))) {
-				return update_trip_temp(&sensors->soc_dts[i], j,
-					sensors->tj_max - critical_offset,
-					THERMAL_TRIP_CRITICAL);
-			}
-		}
+		struct intel_soc_dts_sensor_entry *entry = &sensors->soc_dts[i];
+		int temp = sensors->tj_max - critical_offset;
+		unsigned long count = entry->trip_count;
+		unsigned long mask = entry->trip_mask;
+
+		j = find_first_zero_bit(&mask, count);
+		if (j < count)
+			return update_trip_temp(entry, j, temp, THERMAL_TRIP_CRITICAL);
 	}
 
 	return -EINVAL;
