Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC21E63C503
	for <lists+linux-pm@lfdr.de>; Tue, 29 Nov 2022 17:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbiK2QX2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Nov 2022 11:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbiK2QX0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Nov 2022 11:23:26 -0500
X-Greylist: delayed 2623 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Nov 2022 08:23:24 PST
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0A729818;
        Tue, 29 Nov 2022 08:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=38ZO5dcQL7vEBOSehjzd4koG7jc6NaxBkgnbwvWmh2Y=; b=xlk1fVSDvS2IHfd8DdjH/YnlDh
        o/+tEzgh7v2gBMCj862rB3kWujZyesuCtaiypcv0V9Lb1JWEUqFHSIDa/Gm1WrcujHNHiFRlKZyMH
        meq9x6mbCVn8oxAfX9K4OaezgSfwcF1JsYakeak3EW1H8yad0nb3jhaQ3/iMP0rwc1u4kyFYu8f8M
        jEGAENuEeJr3crC9DMwPB+7AYYBMa07v4wyUemABf4FNE7v6aaYn4EbnPtXFQNJXvQpfSG3Gr2BWU
        MjHt+tDyp2gyOSEOtPbchQhQ1mswqXMJvhCl9X8wW0hCGL/loGnY31gEOt9r0o4XsxjQdPfDm02HR
        AQn90mMQ==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1p02hb-00DfaO-Mo; Tue, 29 Nov 2022 17:39:19 +0200
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] thermal: tegra-bpmp: Check if BPMP supports trip points
Date:   Tue, 29 Nov 2022 17:39:14 +0200
Message-Id: <20221129153914.2699041-1-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Check if BPMP supports thermal trip points, and if not,
do not expose the .set_trips callback to the thermal core
framework. This can happen in virtualized environments
where asynchronous communication with VM BPMP drivers is not
available.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/thermal/tegra/tegra-bpmp-thermal.c | 52 +++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/tegra-bpmp-thermal.c b/drivers/thermal/tegra/tegra-bpmp-thermal.c
index 0b7a1a1948cb..c76e1ea62c8a 100644
--- a/drivers/thermal/tegra/tegra-bpmp-thermal.c
+++ b/drivers/thermal/tegra/tegra-bpmp-thermal.c
@@ -163,19 +163,69 @@ static int tegra_bpmp_thermal_get_num_zones(struct tegra_bpmp *bpmp,
 	return 0;
 }
 
+static int tegra_bpmp_thermal_trips_supported(struct tegra_bpmp *bpmp, bool *supported)
+{
+	struct mrq_thermal_host_to_bpmp_request req;
+	union mrq_thermal_bpmp_to_host_response reply;
+	struct tegra_bpmp_message msg;
+	int err;
+
+	memset(&req, 0, sizeof(req));
+	req.type = CMD_THERMAL_QUERY_ABI;
+	req.query_abi.type = CMD_THERMAL_SET_TRIP;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.mrq = MRQ_THERMAL;
+	msg.tx.data = &req;
+	msg.tx.size = sizeof(req);
+	msg.rx.data = &reply;
+	msg.rx.size = sizeof(reply);
+
+	err = tegra_bpmp_transfer(bpmp, &msg);
+	if (err)
+		return err;
+
+	if (msg.rx.ret == 0) {
+		*supported = true;
+		return 0;
+	} else if (msg.rx.ret == -BPMP_ENODEV) {
+		*supported = false;
+		return 0;
+	} else {
+		return -EINVAL;
+	}
+}
+
 static const struct thermal_zone_device_ops tegra_bpmp_of_thermal_ops = {
 	.get_temp = tegra_bpmp_thermal_get_temp,
 	.set_trips = tegra_bpmp_thermal_set_trips,
 };
 
+static const struct thermal_zone_device_ops tegra_bpmp_of_thermal_ops_notrips = {
+	.get_temp = tegra_bpmp_thermal_get_temp,
+};
+
 static int tegra_bpmp_thermal_probe(struct platform_device *pdev)
 {
 	struct tegra_bpmp *bpmp = dev_get_drvdata(pdev->dev.parent);
+	const struct thermal_zone_device_ops *thermal_ops;
 	struct tegra_bpmp_thermal *tegra;
 	struct thermal_zone_device *tzd;
 	unsigned int i, max_num_zones;
+	bool supported;
 	int err;
 
+	err = tegra_bpmp_thermal_trips_supported(bpmp, &supported);
+	if (err) {
+		dev_err(&pdev->dev, "failed to determine if trip points are supported\n");
+		return err;
+	}
+
+	if (supported)
+		thermal_ops = &tegra_bpmp_of_thermal_ops;
+	else
+		thermal_ops = &tegra_bpmp_of_thermal_ops_notrips;
+
 	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
 	if (!tegra)
 		return -ENOMEM;
@@ -213,7 +263,7 @@ static int tegra_bpmp_thermal_probe(struct platform_device *pdev)
 		}
 
 		tzd = devm_thermal_of_zone_register(
-			&pdev->dev, i, zone, &tegra_bpmp_of_thermal_ops);
+			&pdev->dev, i, zone, thermal_ops);
 		if (IS_ERR(tzd)) {
 			if (PTR_ERR(tzd) == -EPROBE_DEFER)
 				return -EPROBE_DEFER;
-- 
2.37.0

