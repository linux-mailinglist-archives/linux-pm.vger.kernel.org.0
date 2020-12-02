Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D542CC37E
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 18:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389184AbgLBRXD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 12:23:03 -0500
Received: from foss.arm.com ([217.140.110.172]:45670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389183AbgLBRXC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Dec 2020 12:23:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4BC5143B;
        Wed,  2 Dec 2020 09:22:16 -0800 (PST)
Received: from ubuntu.arm.com (unknown [10.57.34.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4E28F3F575;
        Wed,  2 Dec 2020 09:22:14 -0800 (PST)
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com
Cc:     daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com, nicola.mazzucato@arm.com
Subject: [PATCH v4 2/4] opp/of: Allow empty opp-table with opp-shared
Date:   Wed,  2 Dec 2020 17:23:54 +0000
Message-Id: <20201202172356.10508-3-nicola.mazzucato@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201202172356.10508-1-nicola.mazzucato@arm.com>
References: <20201202172356.10508-1-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The opp binding now allows to have an empty opp table and shared-opp to
still describe that devices share v/f lines.

When initialising an empty opp table, allow such case by:
- treating such conditions with warnings in place of errors
- don't fail on empty table

Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
---
 drivers/opp/of.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index ffd937af8089..03cb387236c4 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -170,7 +170,8 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 	/* Traversing the first OPP node is all we need */
 	np = of_get_next_available_child(opp_np, NULL);
 	if (!np) {
-		dev_err(dev, "Empty OPP table\n");
+		dev_warn(dev, "Empty OPP table\n");
+
 		return;
 	}
 
@@ -378,7 +379,9 @@ int dev_pm_opp_of_find_icc_paths(struct device *dev,
 	struct icc_path **paths;
 
 	ret = _bandwidth_supported(dev, opp_table);
-	if (ret <= 0)
+	if (ret == -EINVAL)
+		return 0; /* Empty OPP table is a valid corner-case, let's not fail */
+	else if (ret <= 0)
 		return ret;
 
 	ret = 0;
-- 
2.27.0

