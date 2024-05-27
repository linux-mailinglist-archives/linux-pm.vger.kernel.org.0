Return-Path: <linux-pm+bounces-8161-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B85C8D003B
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 14:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27891284FB0
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 12:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C171315ECC8;
	Mon, 27 May 2024 12:41:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DB115DBCA
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813690; cv=none; b=j35H4xGHEG8k6RFjagnO3n/GBq/+jXrtPtACEda4yNhbbmvVf9mtYYA3isn3DGa1ci2V0iIrK5LIXR4Vw6Kcjzois1BWki+S7RbM8CDpOnW3Brjr0CYwWT1AVtr0wFV5TiD26XsHrvdiESQzfdFSwPL+4tSy48Orfogoy/1IHYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813690; c=relaxed/simple;
	bh=DKPGT9zCwjT97JfwUeLGsvdXWvcfL2iqAGQFqV9g4PU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ljS74c94XsO9+ZXQ4a9XG2ZZ62kCUys3BWrnVpEJH26xybuynex0CLa7sR2uVchRLJ2kJC9dg1ekdnfw+CNe6YVtA0JnPlzKv55h14Y4wejIiH7SQJZ7dSI8FX9OnMfhPP4AFaBoenHnLQw13CJ5h0ZIT+ceM3VHmk4cLAYOpQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:c993:5573:f894:7353])
	by xavier.telenet-ops.be with bizsmtp
	id UChF2C0052nC7mg01ChFB4; Mon, 27 May 2024 14:41:25 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sBZeD-00CfTf-5D;
	Mon, 27 May 2024 14:41:14 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sBZf8-003hdc-TN;
	Mon, 27 May 2024 14:41:14 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Peng Fan <peng.fan@nxp.com>,
	linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 2/3] pmdomain: core: Avoid earlycon power-down
Date: Mon, 27 May 2024 14:41:12 +0200
Message-Id: <7c5c0c8a10b8f755e5a75c7836b43cac63762eec.1716811405.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716811405.git.geert+renesas@glider.be>
References: <cover.1716811405.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the earlycon serial port's PM Domain is shared with another device,
and that other device is runtime-suspended before the full serial driver
has overtaken earlycon, the serial port's PM Domain will be disabled
inadvertently.  Any subsequent serial console output will cause a crash
or system lock-up.

Avoid this by introducing a new flag to handle a PM domain that must be
kept powered-on during early boot, and by setting this flag if the PM
Domain contains the serial console.

Note that the PM Domain can still be powered off later, when the serial
port's power state agrees, e.g. during s2ram without no_console_suspend.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pmdomain/core.c   | 24 ++++++++++++++++++++++--
 include/linux/pm_domain.h |  4 ++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 342779464c0d7e84..97b9b50257eb354c 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -22,6 +22,7 @@
 #include <linux/export.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
+#include <linux/serial_core.h>
 
 #define GENPD_RETRY_MAX_MS	250		/* Approximate */
 
@@ -129,6 +130,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 #define genpd_is_cpu_domain(genpd)	(genpd->flags & GENPD_FLAG_CPU_DOMAIN)
 #define genpd_is_rpm_always_on(genpd)	(genpd->flags & GENPD_FLAG_RPM_ALWAYS_ON)
 #define genpd_is_opp_table_fw(genpd)	(genpd->flags & GENPD_FLAG_OPP_TABLE_FW)
+#define genpd_is_early_on(genpd)	(genpd->flags & GENPD_FLAG_EARLY_ON)
 
 static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
@@ -725,8 +727,9 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	 * (2) When the domain has a subdomain being powered on.
 	 */
 	if (genpd_is_always_on(genpd) ||
-			genpd_is_rpm_always_on(genpd) ||
-			atomic_read(&genpd->sd_count) > 0)
+	    (genpd_is_early_on(genpd) && system_state < SYSTEM_RUNNING) ||
+	    genpd_is_rpm_always_on(genpd) ||
+	    atomic_read(&genpd->sd_count) > 0)
 		return -EBUSY;
 
 	/*
@@ -2367,6 +2370,10 @@ int of_genpd_add_provider_simple(struct device_node *np,
 
 	genpd->dev.of_node = np;
 
+	if (earlycon_power_domains &&
+	    np->phandle == be32_to_cpup(earlycon_power_domains))
+		genpd->flags |= GENPD_FLAG_EARLY_ON;
+
 	/* Parse genpd OPP table */
 	if (!genpd_is_opp_table_fw(genpd) && genpd->set_performance_state) {
 		ret = dev_pm_opp_of_add_table(&genpd->dev);
@@ -2447,6 +2454,19 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 		genpd->has_provider = true;
 	}
 
+	if (earlycon_power_domains && earlycon_power_domains_ncells == 2 &&
+	    np->phandle == be32_to_cpup(earlycon_power_domains)) {
+		struct of_phandle_args genpdspec = {
+			.np = np,
+			.args_count = 1,
+			.args[0] = be32_to_cpup(earlycon_power_domains + 1),
+		};
+
+		genpd = data->xlate(&genpdspec, data);
+		if (!IS_ERR(genpd))
+			genpd->flags |= GENPD_FLAG_EARLY_ON;
+	}
+
 	ret = genpd_add_provider(np, data->xlate, data);
 	if (ret < 0)
 		goto error;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 772d3280d35fafa2..012d58ffc7059e0d 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -92,6 +92,9 @@ struct dev_pm_domain_list {
  * GENPD_FLAG_OPP_TABLE_FW:	The genpd provider supports performance states,
  *				but its corresponding OPP tables are not
  *				described in DT, but are given directly by FW.
+ *
+ * GENPD_FLAG_EARLY_ON:		Instructs genpd to keep the PM domain powered
+ *				on during early boot.
  */
 #define GENPD_FLAG_PM_CLK	 (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
@@ -101,6 +104,7 @@ struct dev_pm_domain_list {
 #define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
 #define GENPD_FLAG_MIN_RESIDENCY (1U << 6)
 #define GENPD_FLAG_OPP_TABLE_FW	 (1U << 7)
+#define GENPD_FLAG_EARLY_ON	 (1U << 8)
 
 enum gpd_status {
 	GENPD_STATE_ON = 0,	/* PM domain is on */
-- 
2.34.1


