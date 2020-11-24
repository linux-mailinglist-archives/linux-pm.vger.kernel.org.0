Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F492C2191
	for <lists+linux-pm@lfdr.de>; Tue, 24 Nov 2020 10:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbgKXJgo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Nov 2020 04:36:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41972 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731310AbgKXJgi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2020 04:36:38 -0500
Date:   Tue, 24 Nov 2020 09:36:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606210595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qLJtI9nAfxpQ241N7feAZU1m7Epn1p0do43IJBH+6tU=;
        b=sy4pMokHHcaYUQMauj+dUeEbQKxSNTcsfaCr5Dn40ZDIJDPfhB3Ar1/yA+Vso3ybq0x26b
        uLqN2oSLE1qWA3wMGf+bBZMwoyLz4Jg3pHfzH3FL0R2nv0MThZpuxr5SmAVqDKOPXpILml
        sJbqJzhrvQ1S/LxwLZRKK4AFtG6CyCVauiRqd8PvKfPa1X3tjuuIGI4njZoiyqWpTqsttt
        552nuFzzS3vpsEL5qrV+vr/BmDuaYZs2hW+Io9b/JpZFu2c4Uclxdapb5pM5EQ1LrxE4vP
        ssgkdxMCouHD4EkhYmI7oM1nXtgpbVmBbz3MASUEfxXU3zptcrTe6EHlnzyylw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606210595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qLJtI9nAfxpQ241N7feAZU1m7Epn1p0do43IJBH+6tU=;
        b=eEZGRxdy5QQQ1XXJC2YRLenW1ZKrW8LufEZvVZr4rhp9EPvvvgqNin5Z4nb6f7lAlGgqRs
        v5mxz6uO5FmNLnAw==
From:   "thermal-bot for Andres Freund" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: intel_pch_thermal: Add PCI ids for
 Lewisburg PCH.
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tushar Dave <tushar.n.dave@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andres Freund <andres@anarazel.de>,
        amitk@kernel.org
In-Reply-To: <20201113204916.1144907-1-andres@anarazel.de>
References: <20201113204916.1144907-1-andres@anarazel.de>
MIME-Version: 1.0
Message-ID: <160621059444.11115.12415047656928422652.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     e78acf7efebff9184ad4add02b62a1f486a8cde8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//e78acf7efebff9184ad4add02b62a1f486a8cde8
Author:        Andres Freund <andres@anarazel.de>
AuthorDate:    Fri, 13 Nov 2020 12:49:16 -08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 14 Nov 2020 19:44:39 +01:00

thermal: intel_pch_thermal: Add PCI ids for Lewisburg PCH.

I noticed that I couldn't read the PCH temperature on my workstation
(C620 series chipset, w/ 2x Xeon Gold 5215 CPUs) directly, but had to go
through IPMI. Looking at the data sheet, it looks to me like the
existing intel PCH thermal driver should work without changes for
Lewisburg.

I suspect there's some other PCI IDs missing. But I hope somebody at
Intel would have an easier time figuring that out than I...

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Tushar Dave <tushar.n.dave@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/lkml/20200115184415.1726953-1-andres@anarazel.de/
Signed-off-by: Andres Freund <andres@anarazel.de>
Reviewed-by: Pandruvada, Srinivas <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201113204916.1144907-1-andres@anarazel.de
---
 drivers/thermal/intel/intel_pch_thermal.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 0a9e445..32e1b28 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -28,6 +28,7 @@
 #define PCH_THERMAL_DID_CNL_H	0xA379 /* CNL-H PCH */
 #define PCH_THERMAL_DID_CNL_LP	0x02F9 /* CNL-LP PCH */
 #define PCH_THERMAL_DID_CML_H	0X06F9 /* CML-H PCH */
+#define PCH_THERMAL_DID_LWB	0xA1B1 /* Lewisburg PCH */
 
 /* Wildcat Point-LP  PCH Thermal registers */
 #define WPT_TEMP	0x0000	/* Temperature */
@@ -340,6 +341,7 @@ enum board_ids {
 	board_skl,
 	board_cnl,
 	board_cml,
+	board_lwb,
 };
 
 static const struct board_info {
@@ -365,7 +367,11 @@ static const struct board_info {
 	[board_cml] = {
 		.name = "pch_cometlake",
 		.ops = &pch_dev_ops_wpt,
-	}
+	},
+	[board_lwb] = {
+		.name = "pch_lewisburg",
+		.ops = &pch_dev_ops_wpt,
+	},
 };
 
 static int intel_pch_thermal_probe(struct pci_dev *pdev,
@@ -479,6 +485,8 @@ static const struct pci_device_id intel_pch_thermal_id[] = {
 		.driver_data = board_cnl, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_CML_H),
 		.driver_data = board_cml, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_LWB),
+		.driver_data = board_lwb, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, intel_pch_thermal_id);
