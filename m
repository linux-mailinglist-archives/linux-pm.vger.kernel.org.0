Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4274294F0
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 18:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhJKRAB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 13:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbhJKQ77 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 12:59:59 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AB8C06161C;
        Mon, 11 Oct 2021 09:57:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5CA0E42499;
        Mon, 11 Oct 2021 16:57:52 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/9] PM: domains: Add of_genpd_add_provider_simple_noclk()
Date:   Tue, 12 Oct 2021 01:57:03 +0900
Message-Id: <20211011165707.138157-6-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011165707.138157-1-marcan@marcan.st>
References: <20211011165707.138157-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is analogous to of_genpd_add_provider_simple(), but calls
dev_pm_opp_of_add_table_noclk() instead of dev_pm_opp_of_add_table().

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/base/power/domain.c | 39 +++++++++++++++++++++++++++++--------
 include/linux/pm_domain.h   |  8 ++++++++
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5db704f02e71..3377b9dd514c 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2227,13 +2227,9 @@ static bool genpd_present(const struct generic_pm_domain *genpd)
 	return ret;
 }
 
-/**
- * of_genpd_add_provider_simple() - Register a simple PM domain provider
- * @np: Device node pointer associated with the PM domain provider.
- * @genpd: Pointer to PM domain associated with the PM domain provider.
- */
-int of_genpd_add_provider_simple(struct device_node *np,
-				 struct generic_pm_domain *genpd)
+static int _of_genpd_add_provider_simple(struct device_node *np,
+					 struct generic_pm_domain *genpd,
+					 bool getclk)
 {
 	int ret;
 
@@ -2247,7 +2243,10 @@ int of_genpd_add_provider_simple(struct device_node *np,
 
 	/* Parse genpd OPP table */
 	if (genpd->set_performance_state) {
-		ret = dev_pm_opp_of_add_table(&genpd->dev);
+		if (getclk)
+			ret = dev_pm_opp_of_add_table(&genpd->dev);
+		else
+			ret = dev_pm_opp_of_add_table_noclk(&genpd->dev, 0);
 		if (ret) {
 			if (ret != -EPROBE_DEFER)
 				dev_err(&genpd->dev, "Failed to add OPP table: %d\n",
@@ -2278,8 +2277,32 @@ int of_genpd_add_provider_simple(struct device_node *np,
 
 	return 0;
 }
+
+/**
+ * of_genpd_add_provider_simple() - Register a simple PM domain provider
+ * @np: Device node pointer associated with the PM domain provider.
+ * @genpd: Pointer to PM domain associated with the PM domain provider.
+ */
+int of_genpd_add_provider_simple(struct device_node *np,
+				 struct generic_pm_domain *genpd)
+{
+	return _of_genpd_add_provider_simple(np, genpd, true);
+}
 EXPORT_SYMBOL_GPL(of_genpd_add_provider_simple);
 
+/**
+ * of_genpd_add_provider_simple_noclk() - Register a simple clockless
+ *   PM domain provider
+ * @np: Device node pointer associated with the PM domain provider.
+ * @genpd: Pointer to PM domain associated with the PM domain provider.
+ */
+int of_genpd_add_provider_simple_noclk(struct device_node *np,
+				       struct generic_pm_domain *genpd)
+{
+	return _of_genpd_add_provider_simple(np, genpd, false);
+}
+EXPORT_SYMBOL_GPL(of_genpd_add_provider_simple_noclk);
+
 /**
  * of_genpd_add_provider_onecell() - Register a onecell PM domain provider
  * @np: Device node pointer associated with the PM domain provider.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 67017c9390c8..db3f75612512 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -316,6 +316,8 @@ struct genpd_onecell_data {
 #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
 int of_genpd_add_provider_simple(struct device_node *np,
 				 struct generic_pm_domain *genpd);
+int of_genpd_add_provider_simple_noclk(struct device_node *np,
+				       struct generic_pm_domain *genpd);
 int of_genpd_add_provider_onecell(struct device_node *np,
 				  struct genpd_onecell_data *data);
 void of_genpd_del_provider(struct device_node *np);
@@ -342,6 +344,12 @@ static inline int of_genpd_add_provider_simple(struct device_node *np,
 	return -EOPNOTSUPP;
 }
 
+static inline int of_genpd_add_provider_simple_noclk(struct device_node *np,
+					struct generic_pm_domain *genpd)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int of_genpd_add_provider_onecell(struct device_node *np,
 					struct genpd_onecell_data *data)
 {
-- 
2.33.0

