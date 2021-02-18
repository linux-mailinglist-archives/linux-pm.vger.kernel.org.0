Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E2D31EA51
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 14:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhBRNP1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 08:15:27 -0500
Received: from avasout01.plus.net ([84.93.230.227]:40125 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbhBRMz2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 07:55:28 -0500
Received: from phil.ashbysoft.com ([84.92.108.193])
        by smtp with ESMTP
        id CieHlAvDOg7CTCieJlrOGD; Thu, 18 Feb 2021 12:43:16 +0000
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=cYFJUkLM c=1 sm=1 tr=0
 a=mNb1h91+mXPpuHmvON5IxQ==:117 a=mNb1h91+mXPpuHmvON5IxQ==:17
 a=qa6Q16uM49sA:10 a=OnH6VxcYAAAA:8 a=x1yG70wBZfs4g0Yktm8A:9
 a=1-OEAFRfWZvTOhUKG6v-:22 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
Received: from static-90-251-253-38.vodafonexdsl.co.uk ([90.251.253.38] helo=martin-intelz370.broadband)
        by phil.ashbysoft.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <martin@ashbysoft.com>)
        id 1lCieF-0004ve-Sz; Thu, 18 Feb 2021 12:43:13 +0000
From:   Martin Ashby <martin@ashbysoft.com>
To:     t.schramm@manjaro.org, linux-pm@vger.kernel.org
Cc:     Martin Ashby <martin@ashbysoft.com>
Subject: [PATCH] power: supply: cw2015: Add CHARGE_NOW support
Date:   Thu, 18 Feb 2021 07:42:50 -0500
Message-Id: <20210218124250.128008-1-martin@ashbysoft.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
X-Spam_report: Spam detection software, running on the system "timmy-iii",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  CHARGE_NOW is expected by some user software (such as waybar)
    instead of 'CAPACITY', in order to correctly calculate remaining battery
   life. Signed-off-by: Martin Ashby <martin@ashbysoft.com> --- drivers/power/supply/cw2015_battery.c
    | 6 ++++++ 1 file changed, 6 insertions(+) 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
X-CMAE-Envelope: MS4wfG5iLWssXiWYrzIHG7iFu3CEFgqn1HL5j8yJHKACtZA8vSvUoVdTQWIzPQPFfp0IHf2bJzd4Zf5jJtWfIYdUXCcPWKhhLc+26ExBXp6ZvnLrslhFiK0S
 gsF3VL2vLjvSEn47Cdcdq9ySMaIdTAP8OyaJ+9V8X/Bk5jexe3PKHf2EIGb1+Q4lE56rSDtJ4D6UsQ==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CHARGE_NOW is expected by some user software (such as waybar)
instead of 'CAPACITY', in order to correctly calculate remaining battery
life.

Signed-off-by: Martin Ashby <martin@ashbysoft.com>
---
 drivers/power/supply/cw2015_battery.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index 0146f1bfc..aa1f1771b 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -511,6 +511,11 @@ static int cw_battery_get_property(struct power_supply *psy,
 			val->intval = 0;
 		break;
 
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		val->intval = cw_bat->battery.charge_full_design_uah;
+		val->intval = val->intval * cw_bat->soc / 100;
+		break;
+
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		if (cw_battery_valid_time_to_empty(cw_bat) &&
 		    cw_bat->battery.charge_full_design_uah > 0) {
@@ -542,6 +547,7 @@ static enum power_supply_property cw_battery_properties[] = {
 	POWER_SUPPLY_PROP_CHARGE_COUNTER,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
 
-- 
2.30.0

