Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F44131D103
	for <lists+linux-pm@lfdr.de>; Tue, 16 Feb 2021 20:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhBPTdO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Feb 2021 14:33:14 -0500
Received: from mail.ashbysoft.com ([51.140.81.171]:46814 "EHLO
        mail.ashbysoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBPTdN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2021 14:33:13 -0500
Received: from ashbysoft.plus.com ([84.92.108.193] helo=phil.ashbysoft.com)
        by mail.ashbysoft.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <martin@ashbysoft.com>)
        id 1lC65G-0005lg-N3; Tue, 16 Feb 2021 19:32:30 +0000
Received: from static-90-251-253-38.vodafonexdsl.co.uk ([90.251.253.38] helo=martin-intelz370.broadband)
        by phil.ashbysoft.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <martin@ashbysoft.com>)
        id 1lC65F-0005Mj-OZ; Tue, 16 Feb 2021 19:32:30 +0000
From:   Martin Ashby <martin@ashbysoft.com>
To:     t.schramm@manjaro.org, linux-pm@vger.kernel.org
Cc:     Martin Ashby <martin@ashbysoft.com>
Subject: [PATCH] Add CHARGE_NOW support to cw2015_battery.c
Date:   Tue, 16 Feb 2021 14:32:17 -0500
Message-Id: <20210216193217.144803-1-martin@ashbysoft.com>
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

