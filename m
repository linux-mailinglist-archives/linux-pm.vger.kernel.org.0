Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8501304E96
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 02:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732059AbhA0AmQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 19:42:16 -0500
Received: from mail.ashbysoft.com ([51.140.81.171]:52142 "EHLO
        mail.ashbysoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbhAZWOq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jan 2021 17:14:46 -0500
X-Greylist: delayed 2051 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jan 2021 17:14:43 EST
Received: from ashbysoft.plus.com ([84.92.108.193] helo=phil.ashbysoft.com)
        by mail.ashbysoft.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <martin@ashbysoft.com>)
        id 1l4W3s-0003XA-Fu; Tue, 26 Jan 2021 21:39:44 +0000
Received: from static-90-251-253-38.vodafonexdsl.co.uk ([90.251.253.38] helo=martin-desktop.pkbinternal.com)
        by phil.ashbysoft.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <martin@ashbysoft.com>)
        id 1l4W3r-00023d-QP; Tue, 26 Jan 2021 21:39:44 +0000
From:   Martin Ashby <martin@ashbysoft.com>
To:     t.schramm@manjaro.org, linux-pm@vger.kernel.org
Cc:     Martin Ashby <martin@ashbysoft.com>
Subject: [PATCH] Add CHARGE_NOW support to cw2015_battery.c
Date:   Tue, 26 Jan 2021 21:39:28 +0000
Message-Id: <20210126213928.136561-1-martin@ashbysoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Signed-Off-By: Martin Ashby <martin@ashbysoft.com>
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
   life. --- drivers/power/supply/cw2015_battery.c | 6 ++++++ 1 file changed,
    6 insertions(+) 
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
instead of 'CAPACITY', in order to correctly calculate 
remaining battery life.

---
 drivers/power/supply/cw2015_battery.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index 0146f1bfc..d11059774 100644
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

