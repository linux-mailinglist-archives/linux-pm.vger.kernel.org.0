Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35A8912FD20
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2020 20:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgACTg0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jan 2020 14:36:26 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:14131 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728488AbgACTgX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Jan 2020 14:36:23 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47qFWn074BzJf;
        Fri,  3 Jan 2020 20:36:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578080181; bh=WlFGQ9P8prWFa6CvEQ+uJYVkZQz0/FIh1Zkijr+EcIw=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Ylp4VpqJCIcbkxk/NePZyFq9GAuIM/miWnraMy0CIBf3Gjobl56vY5VprhAAUmF3G
         9cdWHtm6N3kf0M7Hvy/7q8sv1DeIj4/lc+6acXNlrDS3vosq27NdvD/rVlNOkRx20Z
         WPj51r+d07qC1TV4634m0ILyi5aVS+SSX7Qfa8Mr5C9bSwJdPd1AQQ4DmbvYBDTzuc
         Lk/FuqJjSMLXtRlHOu1w6ZHK0IYu1i18e7NfMFnugy5MuRQLcGBFMA6GKJeqP39fMD
         Cjcl/nhZS2FMjPHArZE+AWBa65ETPJ+NRMRo7PBDUSWQo+eF9bnP7XDm3Ho1C9GiYK
         Oy3+1LyKfguAA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Fri, 03 Jan 2020 20:36:20 +0100
Message-Id: <5c2d6548aef35c690535fd8c985b980316745e91.1578077228.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
References: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/2] opp: quiet down WARN when no valid OPPs remain
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Per CPU screenful of backtraces is not really that useful. Replace
WARN with a diagnostic discriminating common causes of empty OPP table.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/opp/of.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index fba515e432a4..59d7667b56f0 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -534,12 +534,13 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
  * Return:
  * Valid OPP pointer:
  *		On success
- * NULL:
+ * ERR_PTR(-EBUSY):
  *		Duplicate OPPs (both freq and volt are same) and opp->available
- *		OR if the OPP is not supported by hardware.
  * ERR_PTR(-EEXIST):
  *		Freq are same and volt are different OR
  *		Duplicate OPPs (both freq and volt are same) and !opp->available
+ * ERR_PTR(-ENODEV):
+ *		The OPP is not supported by hardware.
  * ERR_PTR(-ENOMEM):
  *		Memory allocation failure
  * ERR_PTR(-EINVAL):
@@ -583,6 +584,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	/* Check if the OPP supports hardware's hierarchy of versions or not */
 	if (!_opp_is_supported(dev, opp_table, np)) {
 		dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
+		ret = -ENODEV;
 		goto free_opp;
 	}
 
@@ -607,12 +609,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 		new_opp->pstate = pm_genpd_opp_to_performance_state(dev, new_opp);
 
 	ret = _opp_add(dev, new_opp, opp_table, rate_not_available);
-	if (ret) {
-		/* Don't return error for duplicate OPPs */
-		if (ret == -EBUSY)
-			ret = 0;
+	if (ret)
 		goto free_required_opps;
-	}
 
 	/* OPP to select on device suspend */
 	if (of_property_read_bool(np, "opp-suspend")) {
@@ -658,7 +656,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 {
 	struct device_node *np;
-	int ret, count = 0, pstate_count = 0;
+	int ret, count = 0, filtered = 0, pstate_count = 0;
 	struct dev_pm_opp *opp;
 
 	/* OPP table is already initialized for the device */
@@ -677,19 +675,32 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 	/* We have opp-table node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_table->np, np) {
 		opp = _opp_add_static_v2(opp_table, dev, np);
-		if (IS_ERR(opp)) {
-			ret = PTR_ERR(opp);
+		ret = PTR_ERR_OR_ZERO(opp);
+		if (!ret) {
+			count++;
+		} else if (ret == -ENODEV) {
+			filtered++;
+		} else if (ret != -EBUSY) {
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
 			return ret;
-		} else if (opp) {
-			count++;
 		}
 	}
 
-	/* There should be one of more OPP defined */
-	if (WARN_ON(!count))
+	/* There should be one or more OPPs defined */
+	if (!count) {
+		if (!filtered)
+			/* all can't be duplicates, so there must be none */
+			dev_err(dev, "%s: OPP table empty", __func__);
+		else if (!opp_table->supported_hw)
+			dev_err(dev,
+				"%s: all OPPs match hw version, but platform did not provide it",
+				__func__);
+		else
+			dev_err(dev, "%s: no supported OPPs", __func__);
+
 		return -ENOENT;
+	}
 
 	list_for_each_entry(opp, &opp_table->opp_list, node)
 		pstate_count += !!opp->pstate;
-- 
2.20.1

