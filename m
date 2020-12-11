Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9A32D7645
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 14:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436585AbgLKNKI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 08:10:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34830 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390550AbgLKNJo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 08:09:44 -0500
Date:   Fri, 11 Dec 2020 13:09:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607692142;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2yF9QdVow+sGfVcMHdcTJw4cPcqkbFVT6L/Xk1ZxQE=;
        b=Vsn93EtbZjCfd1SJxOC1T8Ocbewaxsq63tXD5lqMr/BYFM7Y8n86Q4LNDKJs6HTXSzxCaW
        N+M91p6EUe+Pb8UITIm4XmNztCp6Vd0hjkCkENeFpfzi+Bg/Y83G7AFlSw9zP4dd5ZKA7G
        EOoZ1Mof/wwM3d2v3IJCeZdjZ3isxM0hJGFMtnCZEZo6IBGRn1N13MX28S1blKweWxqMnj
        pdLu9ka9K8iehRDe5suFdUN6S9mWb30buzCMKmuSQ0NaoFtZI3pwcdZZTyoaZAtnb9Q8R/
        I7lIVJSosdbaEO4Bsj7YuQcc2EhrZSXbyXZEiu24NDMZjdcMuSIkI6rZUF63EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607692142;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2yF9QdVow+sGfVcMHdcTJw4cPcqkbFVT6L/Xk1ZxQE=;
        b=vTzhpspc0oIwrklobeIfuB31HPfQqE4QJR/Bg/RNBsQQ4foyMJZKD1Fti33RMpKQSU5CuT
        pt3FBPFYcDmh35DQ==
From:   "thermal-bot for Sumeet Pawnikar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: intel: pch: use macro for
 temperature calculation
Cc:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org
In-Reply-To: <20201210124801.13850-1-sumeet.r.pawnikar@intel.com>
References: <20201210124801.13850-1-sumeet.r.pawnikar@intel.com>
MIME-Version: 1.0
Message-ID: <160769214151.3364.6439448666977965097.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     8639ff4194c98c78536f6e8941a79a3a966a71f1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//8639ff4194c98c78536f6e8941a79a3a966a71f1
Author:        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
AuthorDate:    Thu, 10 Dec 2020 18:18:01 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 10 Dec 2020 14:30:44 +01:00

thermal: intel: pch: use macro for temperature calculation

Use macro for temperature calculation

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201210124801.13850-1-sumeet.r.pawnikar@intel.com
---
 drivers/thermal/intel/intel_pch_thermal.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index d7c05c0..41723c6 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -167,8 +167,7 @@ read_trips:
 	trip_temp = readw(ptd->hw_base + WPT_CTT);
 	trip_temp &= 0x1FF;
 	if (trip_temp) {
-		/* Resolution of 1/2 degree C and an offset of -50C */
-		ptd->crt_temp = trip_temp * 1000 / 2 - 50000;
+		ptd->crt_temp = GET_WPT_TEMP(trip_temp);
 		ptd->crt_trip_id = 0;
 		++(*nr_trips);
 	}
@@ -177,8 +176,7 @@ read_trips:
 	trip_temp = readw(ptd->hw_base + WPT_PHL);
 	trip_temp &= 0x1FF;
 	if (trip_temp) {
-		/* Resolution of 1/2 degree C and an offset of -50C */
-		ptd->hot_temp = trip_temp * 1000 / 2 - 50000;
+		ptd->hot_temp = GET_WPT_TEMP(trip_temp);
 		ptd->hot_trip_id = *nr_trips;
 		++(*nr_trips);
 	}
@@ -190,12 +188,7 @@ read_trips:
 
 static int pch_wpt_get_temp(struct pch_thermal_device *ptd, int *temp)
 {
-	u16 wpt_temp;
-
-	wpt_temp = WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TEMP);
-
-	/* Resolution of 1/2 degree C and an offset of -50C */
-	*temp = (wpt_temp * 1000 / 2 - 50000);
+	*temp = GET_WPT_TEMP(WPT_TEMP_TSR & readw(ptd->hw_base + WPT_TEMP));
 
 	return 0;
 }
