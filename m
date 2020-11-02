Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD81D2A2A4B
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 13:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgKBMCD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 07:02:03 -0500
Received: from foss.arm.com ([217.140.110.172]:58586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728631AbgKBMCD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Nov 2020 07:02:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 341E030E;
        Mon,  2 Nov 2020 04:02:02 -0800 (PST)
Received: from ubuntu.arm.com (unknown [10.57.53.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF3683F66E;
        Mon,  2 Nov 2020 04:01:59 -0800 (PST)
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org
Cc:     morten.rasmussen@arm.com, chris.redpath@arm.com,
        nicola.mazzucato@arm.com
Subject: [PATCH v3 2/3] opp/of: Allow empty opp-table with opp-shared
Date:   Mon,  2 Nov 2020 12:01:14 +0000
Message-Id: <20201102120115.29993-3-nicola.mazzucato@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201102120115.29993-1-nicola.mazzucato@arm.com>
References: <20201102120115.29993-1-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The opp binding now allows to have an empty opp table and shared-opp to
merely describe a hw connection among devices (f/v lines).

When initialising an opp table, allow such case by:
- treating some errors as warnings
- do not mark empty tables as shared
- don't fail on empty table

Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
---
 drivers/opp/of.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 874b58756220..b0230490bb31 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -157,6 +157,11 @@ static void _opp_table_free_required_tables(struct opp_table *opp_table)
 /*
  * Populate all devices and opp tables which are part of "required-opps" list.
  * Checking only the first OPP node should be enough.
+ *
+ * Corner case: empty opp table and opp-shared found. In this case we set
+ * unconditionally the opp table access to exclusive, as the opp-shared property
+ * is used purely to describe hw connections. Such information will be retrieved
+ * via dev_pm_opp_of_get_sharing_cpus().
  */
 static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 					     struct device *dev,
@@ -169,7 +174,9 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 	/* Traversing the first OPP node is all we need */
 	np = of_get_next_available_child(opp_np, NULL);
 	if (!np) {
-		dev_err(dev, "Empty OPP table\n");
+		dev_warn(dev, "Empty OPP table\n");
+
+		opp_table->shared_opp = OPP_TABLE_ACCESS_EXCLUSIVE;
 		return;
 	}
 
@@ -377,7 +384,9 @@ int dev_pm_opp_of_find_icc_paths(struct device *dev,
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

