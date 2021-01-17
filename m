Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8122F959B
	for <lists+linux-pm@lfdr.de>; Sun, 17 Jan 2021 22:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbhAQVsU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 16:48:20 -0500
Received: from sender11-of-o51.zoho.eu ([31.186.226.237]:21109 "EHLO
        sender11-of-o51.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbhAQVsR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 16:48:17 -0500
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jan 2021 16:48:16 EST
ARC-Seal: i=1; a=rsa-sha256; t=1610920000; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=P+H6nnM+FZeWXf0MXvP4oVecdDTXhjY5XD32pfmLSKEzzXf2SblMhA3zoEIVLPaQbi8BsPXE+ZEMM+mc/1GWt3b0MWax0DFWcO0IZxSePYxfkQMOlcIEpwBjK81A77Pfh3jdMFJEyYTek96AHfL1PEjfcUEHyZxgy0GPi5tMiB4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1610920000; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=Wnte+4AlAVGi6rAOeWTfm7Nsc593X5q+3gShAhPDrqw=; 
        b=NBVsPC1GiSViiEe790BSbU4Cc0MogeUhrHexpPXHeW1y93bZmeUuERIB4MlP1cY0HZY4ToaNWeVZpFEhmtdVRt2iq5ceQnl/iXOE1dST+OHdJGw4d+fTobW+oudnIU5/cNxYY+A4U151jMENoCNl+EMIy4vqKowTSC/KkXkoL40=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=philipp@uvos.xyz;
        dmarc=pass header.from=<philipp@uvos.xyz> header.from=<philipp@uvos.xyz>
Received: from localhost.localdomain (ip-95-222-215-9.hsi15.unitymediagroup.de [95.222.215.9]) by mx.zoho.eu
        with SMTPS id 1610919998920388.4063998988232; Sun, 17 Jan 2021 22:46:38 +0100 (CET)
Date:   Sun, 17 Jan 2021 22:46:38 +0100
From:   Carl Philipp Klemm <philipp@uvos.xyz>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 3/5] power: supply: cpcap-battery: invalidate
 empty->counter_uah and charge_full when they are grossly wrong
Message-Id: <20210117224638.10c9d9aee7c0144fafd70520@uvos.xyz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This invalidates empty->counter_uah and charge_full when charge_now indicates
that they are grossly wrong and adds some tolerance to
POWER_SUPPLY_PROP_CHARGE_FULL to allow for inaccuracies in the charge counter
and manufacturing tolerances in the battery.

Signed-off-by: Carl Philipp Klemm <philipp@uvos.xyz>
---
 drivers/power/supply/cpcap-battery.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 86ed41d9627f..8ae0c9c7ebcb 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -667,10 +667,22 @@ static int cpcap_battery_get_property(struct power_supply *psy,
 		if (!empty->voltage)
 			return -ENODATA;
 		val->intval = empty->counter_uah - latest->counter_uah;
-		if (val->intval < 0)
+		if (val->intval < 0) {
+			if (ddata->charge_full && abs(val->intval) > ddata->charge_full/5) {
+				empty->voltage = 0;
+				ddata->charge_full = 0;
+				return -ENODATA;
+			}
 			val->intval = 0;
-		else if (ddata->charge_full && ddata->charge_full < val->intval)
+		}
+		else if (ddata->charge_full && ddata->charge_full < val->intval) {
+			if (val->intval > (6*ddata->charge_full)/5) {
+				empty->voltage = 0;
+				ddata->charge_full = 0;
+				return -ENODATA;
+			}
 			val->intval = ddata->charge_full;
+		}
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		if (!ddata->charge_full)
@@ -747,7 +759,7 @@ static int cpcap_battery_set_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		if (val->intval < 0)
 			return -EINVAL;
-		if (val->intval > ddata->config.info.charge_full_design)
+		if (val->intval > (6*ddata->config.info.charge_full_design)/5)
 			return -EINVAL;
 
 		ddata->charge_full = val->intval;
-- 
2.29.2


