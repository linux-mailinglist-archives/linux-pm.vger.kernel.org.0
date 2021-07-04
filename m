Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5339D3BAE2E
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jul 2021 20:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhGDSFG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 14:05:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55814 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhGDSFF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 14:05:05 -0400
Date:   Sun, 04 Jul 2021 18:02:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625421749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d/HImNbJUcjRjIZ5Wy83G0WcbOwxIZMO3BEBMLa40GI=;
        b=HHYdLCdoqyYHed/ICIrkWFNNzdT1nDi+aX9nSLEdQdk3ktBmqL/+NHz6MPSV+oaTfGAZNV
        mHGfTQ8nBAx2SvZMNSYYdWXxLHnhd6pL/4s3Ay/q1kKWuCMxER+SH8bnXglBSwnQYbEm3/
        j3A8HlflC9cDy/Xu82H7+yYgdGVHkQyNOBW1F7oJYtOo248tzBE0FGGIqgwGzGa0x4NyLC
        T6t84xS4yYeX04amQLzDFzSK8Qq4kLp3hzwP6l21ZH3ca4PN+rAKfZSfWYO2821z8WZCGe
        MGTMjPH0mZHYWiu9VyNLhnZN9dXh0vA6NZ5a/AvXt6vknFnorlvJpcEhCAfcBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625421749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d/HImNbJUcjRjIZ5Wy83G0WcbOwxIZMO3BEBMLa40GI=;
        b=0DtnAqwxRs2NKFkFnEitsJOoi7eGmG0MzbPVgRaIn8BEi8iH+LMrP4OZpuig2GEueR/DNL
        akoiieypAQm0ndAA==
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
Message-ID: <162542174830.395.4029542627225796827.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     da5e562fbc5676902d9007db4b05af9de7a890d5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//da5e562fbc5676902d9007db4b05af9de7a890d5
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 18 Jun 2021 18:34:51 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 04 Jul 2021 18:28:04 +02:00

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
