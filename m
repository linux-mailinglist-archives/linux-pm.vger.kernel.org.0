Return-Path: <linux-pm+bounces-27856-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D912AC8C32
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 12:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4401BA5157
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FE42222A0;
	Fri, 30 May 2025 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BdTvHEnM"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2F521D5B6;
	Fri, 30 May 2025 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748601342; cv=none; b=B3ddj2ZpkC6NwRXgRMSBH5TmfqhJI+riNZ7f6EIqQTw6Hn9ePPozJK6za3ao6L5uX3+tGU6KuV1nrVtMfvP3eJKiMCFhbK8jW6ZYa9eL0yaHyoG0A/3IjtpyfBGZCFppgs1Rax1LUTsdKUP81c4vruFzPFZJXckBgagfFfFrao0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748601342; c=relaxed/simple;
	bh=UUCWLF5QlJkGL6aFImtIR5HiycoyUXAnHsMTOOfMZnQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L2LYxyCBfgzT0HLdSviDyX1RWYY0KD9enlMimmeUHHtD5f3rg6ycpaNxYaWz+zNWJzBHF1b7jR4ex/EkRyK7AtJVHAIUY73+cnSDa/wbMzNsf/PV/k2g31WYlpVp3OzIY0Wx/WRASg5LEGiHKDBP4DFWkWZKxrruJH2TcppW7Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BdTvHEnM; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54UAZVxj3765537;
	Fri, 30 May 2025 05:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1748601331;
	bh=tT/U7ULtKLzKCpEKOMNNm5nvTaxFZwdDpBqvlMNie/I=;
	h=From:To:CC:Subject:Date;
	b=BdTvHEnM9dVFcwbJJywBCX9ymRKOZ2amTJIV0aqM9ggWpJdx5q2XRvXtAhk9qIPD1
	 2WiCKx6duFF1xquVplbd9IyHceiXZ5YELJZce1KlMPOuQtydm2wRQHQpAzIcddIQTD
	 bNsQiFf6mUifpQbRTZNv437heun7Yjq6T5qhBO6Q=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54UAZUJ4749463
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 30 May 2025 05:35:31 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 May 2025 05:35:30 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 May 2025 05:35:30 -0500
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54UAZRNE2989964;
	Fri, 30 May 2025 05:35:28 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dhruva Gole <d-gole@ti.com>
Subject: [RFC PATCH] pmdomain: arm: scmi_pm_domain: Do lazy init as part of probe
Date: Fri, 30 May 2025 16:05:27 +0530
Message-ID: <20250530103527.2244951-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Optimize the SCMI power domain driver to only initialize domains that are
actually referenced in the device tree. Previously, the driver would
initialize all possible domains up to the maximum ID, which could lead to
unnecessary firmware calls and longer probe times.

Key changes:
- Scan device tree to identify which power domains are actually referenced
- Use bitmap to track needed domains instead of initializing all
- Only perform state queries and initialization for referenced domains
- Maintain proper array sizing for power domain framework compatibility
- Keep full provider structure to support late binding

This optimization reduces probe time and unnecessary firmware interactions
by only initializing power domains that are actually used in the system.
For example, in a system with 100 possible domains but only 3 referenced
in the device tree, we now only initialize those 3 domains instead of
all 100.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

Hi all,
The approach of doing a lazy init was briefly proposed in this [1] 2024
Embedded Open Source talk. It was also brought up in the monthly ARM
SCMI meetings that take place and it didn't recieve too much opposition.

This greatly helps to improve the boot time, and I have some data to
back this up as well. This[2] experiment was done on a TI AM62L SoC
(which is yet to make it upstream) to measure the time taken in the scmi
pm domain probe function when it does a full 0..N scmi pd init vs just
the ones being used in the device tree.

If you have any feedback on this, please let me know. If not, I will go
ahead and post a "non-RFC" patch assuming everyone is mostly on board
with this. Also request other SCMI consumers to test this out as much as
possible to see if it breaks in any situations.

[1] https://static.sched.com/hosted_files/eoss24/2f/ARM_SCMI_Primer_Dhruva_kamlesh.pdf
[2] https://gist.github.com/DhruvaG2000/75d6a4c31e817f56587537b022761c45

Applies cleanly on top of next-20250530, built and tested on top of the
same

---

 drivers/pmdomain/arm/scmi_pm_domain.c | 88 ++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 22 deletions(-)

diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
index 2a213c218126..8acbfe249ed2 100644
--- a/drivers/pmdomain/arm/scmi_pm_domain.c
+++ b/drivers/pmdomain/arm/scmi_pm_domain.c
@@ -10,6 +10,8 @@
 #include <linux/module.h>
 #include <linux/pm_domain.h>
 #include <linux/scmi_protocol.h>
+#include <linux/of.h>
+
 
 static const struct scmi_power_proto_ops *power_ops;
 
@@ -47,14 +49,20 @@ static int scmi_pd_power_off(struct generic_pm_domain *domain)
 
 static int scmi_pm_domain_probe(struct scmi_device *sdev)
 {
-	int num_domains, i;
 	struct device *dev = &sdev->dev;
-	struct device_node *np = dev->of_node;
+	struct device_node *np;
 	struct scmi_pm_domain *scmi_pd;
-	struct genpd_onecell_data *scmi_pd_data;
-	struct generic_pm_domain **domains;
+	struct of_phandle_args args;
 	const struct scmi_handle *handle = sdev->handle;
 	struct scmi_protocol_handle *ph;
+	struct genpd_onecell_data *scmi_pd_data;
+	struct generic_pm_domain **domains;
+	int max_id = -1;
+	int index, num_domains;
+	ktime_t start_time = ktime_get();
+	unsigned long *domain_ids;
+
+	dev_err(dev, "Starting optimized SCMI power domain probe\n");
 
 	if (!handle)
 		return -ENODEV;
@@ -69,54 +77,90 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 		return num_domains;
 	}
 
-	scmi_pd = devm_kcalloc(dev, num_domains, sizeof(*scmi_pd), GFP_KERNEL);
-	if (!scmi_pd)
+	domain_ids = devm_bitmap_zalloc(dev, num_domains, GFP_KERNEL);
+	if (!domain_ids)
 		return -ENOMEM;
 
+	/* Find referenced domain IDs and mark them in bitmap */
+	for_each_node_with_property(np, "power-domains") {
+		index = 0;
+		while (!of_parse_phandle_with_args(np, "power-domains",
+					"#power-domain-cells",
+					index, &args)) {
+			if (args.args_count >= 1 && args.np == dev->of_node) {
+				int id = args.args[0];
+				if (id < num_domains) {
+					set_bit(id, domain_ids);
+					max_id = max(max_id, id);
+					dev_dbg(dev, "Found power domain reference %d from node %pOF\n",
+							id, np);
+				}
+			}
+			of_node_put(args.np);
+			index++;
+		}
+	}
+
+	if (max_id < 0) {
+		dev_warn(dev, "No power domains referenced in device tree\n");
+		/* Create provider anyway as domains might be referenced later */
+		max_id = 0;
+	}
+
+	dev_warn(dev, "Highest referenced domain ID: %d\n", max_id);
+
 	scmi_pd_data = devm_kzalloc(dev, sizeof(*scmi_pd_data), GFP_KERNEL);
 	if (!scmi_pd_data)
 		return -ENOMEM;
 
-	domains = devm_kcalloc(dev, num_domains, sizeof(*domains), GFP_KERNEL);
+	domains = devm_kcalloc(dev, max_id + 1, sizeof(*domains), GFP_KERNEL);
 	if (!domains)
 		return -ENOMEM;
 
-	for (i = 0; i < num_domains; i++, scmi_pd++) {
+	scmi_pd = devm_kcalloc(dev, max_id + 1, sizeof(*scmi_pd), GFP_KERNEL);
+	if (!scmi_pd)
+		return -ENOMEM;
+
+	/* Initialize only referenced domains */
+	for_each_set_bit(index, domain_ids, num_domains) {
 		u32 state;
 
-		if (power_ops->state_get(ph, i, &state)) {
-			dev_warn(dev, "failed to get state for domain %d\n", i);
+		if (power_ops->state_get(ph, index, &state)) {
+			dev_err(dev, "Domain %d not available\n", index);
 			continue;
 		}
 
-		/*
-		 * Register the explicit power on request to the firmware so
-		 * that it is tracked as used by OSPM agent and not
-		 * accidentally turned off with OSPM's knowledge
-		 */
-		if (state == SCMI_POWER_STATE_GENERIC_ON)
-			power_ops->state_set(ph, i, state);
+		dev_warn(dev, "Initializing referenced domain %d\n", index);
 
-		scmi_pd->domain = i;
+		scmi_pd->domain = index;
 		scmi_pd->ph = ph;
-		scmi_pd->name = power_ops->name_get(ph, i);
+		scmi_pd->name = power_ops->name_get(ph, index);
 		scmi_pd->genpd.name = scmi_pd->name;
 		scmi_pd->genpd.power_off = scmi_pd_power_off;
 		scmi_pd->genpd.power_on = scmi_pd_power_on;
 		scmi_pd->genpd.flags = GENPD_FLAG_ACTIVE_WAKEUP;
 
+		if (state == SCMI_POWER_STATE_GENERIC_ON) {
+			dev_warn(dev, "Domain %d is ON, registering state\n", index);
+			power_ops->state_set(ph, index, state);
+		}
+
 		pm_genpd_init(&scmi_pd->genpd, NULL,
 			      state == SCMI_POWER_STATE_GENERIC_OFF);
 
-		domains[i] = &scmi_pd->genpd;
+		domains[index] = &scmi_pd->genpd;
+		scmi_pd++;
 	}
 
 	scmi_pd_data->domains = domains;
-	scmi_pd_data->num_domains = num_domains;
+	scmi_pd_data->num_domains = max_id + 1;
 
 	dev_set_drvdata(dev, scmi_pd_data);
 
-	return of_genpd_add_provider_onecell(np, scmi_pd_data);
+	dev_err(dev, "SCMI power domains probe completed in %lld us\n",
+			ktime_us_delta(ktime_get(), start_time));
+
+	return of_genpd_add_provider_onecell(dev->of_node, scmi_pd_data);
 }
 
 static void scmi_pm_domain_remove(struct scmi_device *sdev)
-- 
2.34.1


