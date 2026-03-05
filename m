Return-Path: <linux-pm+bounces-43692-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ/tNAKxqWlXCgEAu9opvQ
	(envelope-from <linux-pm+bounces-43692-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 17:36:18 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 330A0215770
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 17:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5080303326C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 16:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD77B3D3D18;
	Thu,  5 Mar 2026 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="lG7vz/3h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx-relay97-hz2.antispameurope.com (mx-relay97-hz2.antispameurope.com [94.100.136.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEBE3D5654
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.136.197
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772728565; cv=pass; b=AFkT+MHVGm2WghmTOP3ZfY+5PkhoaOnryiZq0Lfqemmi1vptKfokjAPZnxz1ocPR2DsbB0hcq8FIIjnWdPinnjaLpxPXln1kyMSmxX9AWV76Inr7FMou05mU4vc7XE9BiJjSvsgbDbCPEpx8opFxhMahwg5R7Wv2WSy7JbdOEs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772728565; c=relaxed/simple;
	bh=NvQErdnHtNFrGW72s5itTAzkfc4cQF7Kecy85Y6iySU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u0WqmlhtA/GFK6FfPvx1Wg7c7NaSAEabrTlQ6mkYFG/LnFFw6Jv+CAyN0X55O/3ywexg1zPUJ6UC3HKOLDFfvqUabREv11FrVnUDtbfHf8ByKkp7WocXpLRNe3CovNZVK1mDYzR1xc34Yml/UqnmjRQeZoWVFZmMMdxEOweCG8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=lG7vz/3h; arc=pass smtp.client-ip=94.100.136.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate97-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=boMpOpClER/Pmo4en2oqAZK91vRLE5sK8g1DMjatc7k=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1772728517;
 b=Nw3ZVnl/+rGpX/aFlTFJD+jBO/rfs4pGDkfB1ScEfngFw9SUeoB0BbDaxzsu/c/E63Q21/JJ
 WjPCWAvY7i+MyDj+BeWiaYkbYdoMdvb43ZqU030As+30nxsE51LoHVOq2vHzsH/WH1glx1NMPOb
 kRnQUr0rm3lvPgQqpHQcnIFHbFwWTSyDNUAZku1FhOjBAqZP+mH9EQJPgQstEqkoSjIY0smWWHo
 RY4kkipXtQnzseRvuDGuhDiYIEngR1SDsC0vEbsC20eN1bzoBjkL+klrTwWiI6jvdrsOtrUeV3c
 yfUSFWV8NET7Qnnc9Rf1uIWYvUQMW4NGEXennXqfJydJA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1772728517;
 b=DxOIVdlIWb1pBFKYr3aydPjFk2ySQu0k2xON/NbOfPjlGg/GBRhReOtrpcQTSIpsZ1c3H6w5
 AxlPPjnc1CIwh94gHMyKrHVklAHW7/F7wqyASiB7CZ+rAOK6e2UAuVOAj/InJyRUCHAHbAJDuem
 YgTa2rTCAhLHPVh3zkfWRlEAl0IZxF0ZSpi1fBzP87SLR/AO2EzO23uYVfxvESDciRfLi67O/YM
 iTzrjRQ7yICuPNtDzoSVXWNRE2cvDzicVPBa35SViB56EypVclGsl2kCyE9Uz4whIIs3TGtAeq7
 1DnyEWTJrZHMHe98q03NSXp92FtEryFYzy+3mdXjra0eQ==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay97-hz2.antispameurope.com;
 Thu, 05 Mar 2026 17:35:17 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 61D7E2206EE;
	Thu,  5 Mar 2026 17:35:09 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] thermal/of: Add OF node address to output message
Date: Thu,  5 Mar 2026 17:35:07 +0100
Message-ID: <20260305163508.2643106-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-pm@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay97-hz2.antispameurope.com with 4fRZrs5t6Qz1xmlX
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:96a02eb0533148890475f046e0dce904
X-cloud-security:scantime:1.933
DKIM-Signature: a=rsa-sha256;
 bh=boMpOpClER/Pmo4en2oqAZK91vRLE5sK8g1DMjatc7k=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1772728516; v=1;
 b=lG7vz/3hocVVdqnWaSWNpujghDyUuT6cZujzRjXXQFek4vM6FlUS25Y/WI5SxVQ3smVaR0ar
 NXPzSooYhmNrzKjYGEtAjpr608jk7/Ya01jk3G3x3QKMlNIReed5j1ZlVLtshN3C3To13sUwi+u
 immqZwTMDXLcmo97m69lSo726JtiWRupGXbPGwy5Q684PJbGHAXPkhUV0J1OO9GQctdMreigvvS
 nPvsIl3wxo/52SSruMkyXxfHnSzcXyou+KVNRP3cnKMcNQrYVijK7a4lESFVOn/eEhu5c4xeuXH
 B1sYFea0EthX7wmOVqD/5E1qMtwQcCPK8nRvs8FTSMFIA==
X-Rspamd-Queue-Id: 330A0215770
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=hse1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43692-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.stein@ew.tq-group.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tq-group.com:email,ew.tq-group.com:dkim,ew.tq-group.com:mid,1c:email,sensor_specs.np:url]
X-Rspamd-Action: no action

Temperature sensors are supposed to have the DT node name
temperature-sensors. Having multiple ones the node name alone isn't very
helpful. Add the node address to make them more distinguishable.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Old error messages:
thermal_sys: Failed to find thermal zone for temperature-sensor id=0
thermal_sys: Failed to find thermal zone for temperature-sensor id=0

New error messages:
thermal_sys: Failed to find thermal zone for temperature-sensor@1c id=0
thermal_sys: Failed to find thermal zone for temperature-sensor@1b id=0

 drivers/thermal/thermal_of.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 6ebb83cb70b2f..99085c806a1f6 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -144,7 +144,7 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 		count = of_count_phandle_with_args(child, "thermal-sensors",
 						   "#thermal-sensor-cells");
 		if (count <= 0) {
-			pr_err("%pOFn: missing thermal sensor\n", child);
+			pr_err("%pOFP: missing thermal sensor\n", child);
 			return ERR_PTR(-EINVAL);
 		}
 
@@ -156,14 +156,14 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 							 "#thermal-sensor-cells",
 							 i, &sensor_specs);
 			if (ret < 0) {
-				pr_err("%pOFn: Failed to read thermal-sensors cells: %d\n", child, ret);
+				pr_err("%pOFP: Failed to read thermal-sensors cells: %d\n", child, ret);
 				return ERR_PTR(ret);
 			}
 
 			of_node_put(sensor_specs.np);
 			if ((sensor == sensor_specs.np) && id == (sensor_specs.args_count ?
 								  sensor_specs.args[0] : 0)) {
-				pr_debug("sensor %pOFn id=%d belongs to %pOFn\n", sensor, id, child);
+				pr_debug("sensor %pOFP id=%d belongs to %pOFP\n", sensor, id, child);
 				return no_free_ptr(child);
 			}
 		}
@@ -180,7 +180,7 @@ static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdel
 	if (ret == -EINVAL) {
 		*pdelay = 0;
 	} else if (ret < 0) {
-		pr_err("%pOFn: Couldn't get polling-delay-passive: %d\n", np, ret);
+		pr_err("%pOFP: Couldn't get polling-delay-passive: %d\n", np, ret);
 		return ret;
 	}
 
@@ -188,7 +188,7 @@ static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdel
 	if (ret == -EINVAL) {
 		*delay = 0;
 	} else if (ret < 0) {
-		pr_err("%pOFn: Couldn't get polling-delay: %d\n", np, ret);
+		pr_err("%pOFP: Couldn't get polling-delay: %d\n", np, ret);
 		return ret;
 	}
 
@@ -380,23 +380,23 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 	np = of_thermal_zone_find(sensor, id);
 	if (IS_ERR(np)) {
 		if (PTR_ERR(np) != -ENODEV)
-			pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
+			pr_err("Failed to find thermal zone for %pOFP id=%d\n", sensor, id);
 		return ERR_CAST(np);
 	}
 
 	trips = thermal_of_trips_init(np, &ntrips);
 	if (IS_ERR(trips)) {
-		pr_err("Failed to parse trip points for %pOFn id=%d\n", sensor, id);
+		pr_err("Failed to parse trip points for %pOFP id=%d\n", sensor, id);
 		ret = PTR_ERR(trips);
 		goto out_of_node_put;
 	}
 
 	if (!trips)
-		pr_info("No trip points found for %pOFn id=%d\n", sensor, id);
+		pr_info("No trip points found for %pOFP id=%d\n", sensor, id);
 
 	ret = thermal_of_monitor_init(np, &delay, &pdelay);
 	if (ret) {
-		pr_err("Failed to initialize monitoring delays from %pOFn\n", np);
+		pr_err("Failed to initialize monitoring delays from %pOFP\n", np);
 		goto out_kfree_trips;
 	}
 
@@ -417,7 +417,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 						     pdelay, delay);
 	if (IS_ERR(tz)) {
 		ret = PTR_ERR(tz);
-		pr_err("Failed to register thermal zone %pOFn: %d\n", np, ret);
+		pr_err("Failed to register thermal zone %pOFP: %d\n", np, ret);
 		goto out_kfree_trips;
 	}
 
-- 
2.43.0


