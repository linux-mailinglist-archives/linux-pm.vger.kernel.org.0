Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2C112FD1D
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2020 20:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgACTgX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jan 2020 14:36:23 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:60729 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbgACTgW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Jan 2020 14:36:22 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47qFWm2pbWzGW;
        Fri,  3 Jan 2020 20:36:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578080180; bh=VyRZ0woKa5nUH9vcXSMRuDeYWl1RDXs9EIlAHgOsp5s=;
        h=Date:From:Subject:To:Cc:From;
        b=kS8dJ/JrAVOWxQXVBQIuMv7na0R3QsPb70Ka4iRyXek7E3XDGV2pxp6HTdfBtunDd
         Ekeq8Xe2S1CP7A/jkgNbdwDrjTWPEoCgY0bixAhLsyyAzHVmD67GJEH7Gn5M7tKhfD
         BRA8weEDS0700d/PzgvmeAfFeD9V6aDipr2GFGXmmDmHX1q4NzpZgPi/kFlePv+2OQ
         t8OgEHJ6H2tNi+NCgz4Bm/ZloZHMbVAUP6KjCjGVTQ8uJfjro13N2y7FaHFNW4tH6K
         glYegntUjKwjT3ucTpks2q/ELYoBjeI7gblo+Yj3xY8qaXgCveTYwYzrhuW65Lzajo
         rup0fqgjhbmJA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Fri, 03 Jan 2020 20:36:20 +0100
Message-Id: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/2] opp: fix of_node leak for unsupported entries
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

When parsing OPP v2 table, unsupported entries return NULL from
_opp_add_static_v2(). In this case node reference is leaked.
Make _opp_add_static_v2() always assume ownership of the reference
to fix this.

Commit 7978db344719 ("PM / OPP: Add missing of_node_put(np)") already
fixed this for the error returns. The leak remained for filtered-out
entries from the initial code commit. The Fixes-tagged commit is just
a last one that altered the code around.

Fixes: 11e1a1648298 ("opp: Don't decrement uninitialized list_kref")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/opp/of.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 1cbb58240b80..fba515e432a4 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -555,8 +555,10 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	bool rate_not_available = false;
 
 	new_opp = _opp_allocate(opp_table);
-	if (!new_opp)
-		return ERR_PTR(-ENOMEM);
+	if (!new_opp) {
+		ret = -ENOMEM;
+		goto free_node;
+	}
 
 	ret = of_property_read_u64(np, "opp-hz", &rate);
 	if (ret < 0) {
@@ -646,6 +648,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	_of_opp_free_required_opps(opp_table, new_opp);
 free_opp:
 	_opp_free(new_opp);
+free_node:
+	of_node_put(np);
 
 	return ERR_PTR(ret);
 }
@@ -677,7 +681,6 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 			ret = PTR_ERR(opp);
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
-			of_node_put(np);
 			return ret;
 		} else if (opp) {
 			count++;
-- 
2.20.1

