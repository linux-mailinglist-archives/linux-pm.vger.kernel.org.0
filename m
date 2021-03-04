Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7B832D61C
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 16:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhCDPJI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 10:09:08 -0500
Received: from foss.arm.com ([217.140.110.172]:39668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232265AbhCDPIh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Mar 2021 10:08:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E15EDD6E;
        Thu,  4 Mar 2021 07:07:51 -0800 (PST)
Received: from e113131-lin.cambridge.arm.com (e113131-lin.cambridge.arm.com [10.1.195.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 061853F766;
        Thu,  4 Mar 2021 07:07:50 -0800 (PST)
From:   Beata Michalska <beata.michalska@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        beata.michalska@arm.com
Subject: [PATCH] opp: Invalidate current opp when draining the opp list
Date:   Thu,  4 Mar 2021 15:07:34 +0000
Message-Id: <1614870454-18709-1-git-send-email-beata.michalska@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The current_opp when set, grabs additional reference on the opp,
which is then supposed to be dropped upon releasing the opp table.
Still both dev_pm_opp_remove_table and dev_pm_opp_remove_all_dynamic
will completely drain the OPPs list, including dropping the additional
reference on current_opp. This may lead to an attempt to access
memory that has already been released. Make sure that while draining
the list (in both dynamic and static cases) the current_opp gets
actually invalidated.

Fixes: 81c4d8a3c414 ("opp: Keep track of currently programmed OPP")

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 drivers/opp/core.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c268938..10e65c4 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1502,10 +1502,39 @@ static struct dev_pm_opp *_opp_get_next(struct opp_table *opp_table,
 	return opp;
 }
 
-bool _opp_remove_all_static(struct opp_table *opp_table)
+static int __opp_drain_list(struct opp_table *opp_table, bool dynamic)
 {
 	struct dev_pm_opp *opp;
+	int count = 0;
+
+	/*
+	 * Can't remove the OPP from under the lock, debugfs removal needs to
+	 * happen lock less to avoid circular dependency issues.
+	 */
+	while ((opp = _opp_get_next(opp_table, dynamic))) {
+		/*
+		 * The current_opp has extra hold on the ref count,
+		 * still the draining here will result in all of them
+		 * being dropped completely, so make
+		 * sure no one will try to access the current_opp
+		 * afterwords
+		 */
+		if (opp_table->current_opp == opp &&
+		    !(kref_read(&opp->kref) - 1))
+			opp_table->current_opp = NULL;
+
+		dev_pm_opp_put(opp);
+		/*
+		 * Note: the count here will reflect number of references
+		 * dropped, not the number of opps in the list
+		 */
+		++count;
+	}
+	return count;
+}
 
+bool _opp_remove_all_static(struct opp_table *opp_table)
+{
 	mutex_lock(&opp_table->lock);
 
 	if (!opp_table->parsed_static_opps) {
@@ -1520,13 +1549,7 @@ bool _opp_remove_all_static(struct opp_table *opp_table)
 
 	mutex_unlock(&opp_table->lock);
 
-	/*
-	 * Can't remove the OPP from under the lock, debugfs removal needs to
-	 * happen lock less to avoid circular dependency issues.
-	 */
-	while ((opp = _opp_get_next(opp_table, false)))
-		dev_pm_opp_put(opp);
-
+	__opp_drain_list(opp_table, false);
 	return true;
 }
 
@@ -1539,21 +1562,13 @@ bool _opp_remove_all_static(struct opp_table *opp_table)
 void dev_pm_opp_remove_all_dynamic(struct device *dev)
 {
 	struct opp_table *opp_table;
-	struct dev_pm_opp *opp;
 	int count = 0;
 
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table))
 		return;
 
-	/*
-	 * Can't remove the OPP from under the lock, debugfs removal needs to
-	 * happen lock less to avoid circular dependency issues.
-	 */
-	while ((opp = _opp_get_next(opp_table, true))) {
-		dev_pm_opp_put(opp);
-		count++;
-	}
+	count = __opp_drain_list(opp_table, true);
 
 	/* Drop the references taken by dev_pm_opp_add() */
 	while (count--)
-- 
2.7.4

