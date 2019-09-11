Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A9EB02F3
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2019 19:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfIKRrg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Sep 2019 13:47:36 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.100]:34350 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbfIKRrg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2019 13:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1568224053;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=mTfwQt8oJzxDFFQXPXctGO1zaD45fIs/3dbhjMrZbX8=;
        b=FtYOP5E1I6NjLShll6AV9JggRqoqS1jfJH1k46M0Yb46LQh9dsjbBqdOIO80g2m3E9
        g1CyanNXxkDNPqCGXJBtE9579r6fv9XovFIVYMVUd0Tg81sCfGqeGAwzfg/JGm/mJaSq
        6L6P8ZaAeLzTG7K057iCfVRHHU4sOkfOzijH4/jw8OkKM/Z02+3kl7KCNp1XUa8208kk
        dvif8kUXc1ffS9gfDWFrBsGigeDo051ZC3i7kakrR2S38DoRud3I9VMQa2CB0MBNGJFj
        JlrgG+7xdYXtk0lYv8p9t+w6uWPuNs9OF9rvUcb2J0PFqJ179GvmMJGDAPzyM0GmvXGU
        +ZGg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M7Nk1d2C6Y"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v8BHlJ8nx
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 11 Sep 2019 19:47:19 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Roger Quadros <rogerq@ti.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 7/8] cpufreq: ti-cpufreq: Add support for AM3517
Date:   Wed, 11 Sep 2019 19:47:13 +0200
Message-Id: <beda9274922c0fdc293a974a707426fac7c77921.1568224033.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1568224032.git.hns@goldelico.com>
References: <cover.1568224032.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

The AM3517 only lists 600MHz @ 1.2V, but the register values for
0x4830A204 = 1b86 802f, it seems like am3517 might be a derivative
of the omap36 which OPPs would be OPP50 (300 MHz) and OPP100
(600 MHz).

This patch simply adds the am3517 to the compatible table
similar to a mix of the omap3430 and omap3430 structure.

Signed-off-by: Adam Ford <aford173@gmail.com>
Tested-by: Adam Ford <aford173@gmail.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/cpufreq/ti-cpufreq.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index f4704f9033e0..cd2f6b87ea3e 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -177,6 +177,21 @@ static struct ti_cpufreq_soc_data omap36xx_soc_data = {
 	.multi_regulator = true,
 };
 
+/*
+ * AM3517 is quite similar to AM/DM37x except that it has no
+ * high speed grade eFuse and no abb ldo
+ */
+
+static struct ti_cpufreq_soc_data am3517_soc_data = {
+	.efuse_xlate = omap3_efuse_xlate,
+	.efuse_offset = OMAP3_CONTROL_DEVICE_STATUS - OMAP3_SYSCON_BASE,
+	.efuse_shift = 0,
+	.efuse_mask = 0,
+	.rev_offset = OMAP3_CONTROL_IDCODE - OMAP3_SYSCON_BASE,
+	.multi_regulator = false,
+};
+
+
 /**
  * ti_cpufreq_get_efuse() - Parse and return efuse value present on SoC
  * @opp_data: pointer to ti_cpufreq_data context
@@ -274,6 +289,7 @@ static int ti_cpufreq_setup_syscon_register(struct ti_cpufreq_data *opp_data)
 
 static const struct of_device_id ti_cpufreq_of_match[] = {
 	{ .compatible = "ti,am33xx", .data = &am3x_soc_data, },
+	{ .compatible = "ti,am3517", .data = &am3517_soc_data, },
 	{ .compatible = "ti,am43", .data = &am4x_soc_data, },
 	{ .compatible = "ti,dra7", .data = &dra7_soc_data },
 	{ .compatible = "ti,omap34xx", .data = &omap34xx_soc_data, },
-- 
2.19.1

