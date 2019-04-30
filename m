Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB6E310141
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 22:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfD3U4a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 16:56:30 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38394 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfD3U43 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 16:56:29 -0400
Received: by mail-io1-f65.google.com with SMTP id y6so13456528ior.5;
        Tue, 30 Apr 2019 13:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=ROo2mEOaZoS8Oj0lfCLj/EE9ivwrxNSCdoSlWp9ZnaE=;
        b=QkPM7Zc/RMsVp8vnKI9tA4uY2PTmlvB+7I7/bWa5WDKvt5xOgYokrAqIznZ+MCRsPe
         iinV2wLdyjADf0Y5rog9NEimP6AzqdPr9N5xkd6c+4PE+ai78TRZ+Qzw8Uh4svIP4U7a
         QsgH64o4Ez4AZO4YKrIwNAZKx0fN7ZPufhluf6XU1nVcFDZCrCDj1d7OzSbZE0Jz9TV0
         9I5r1fVmfYT/jrspbv+gIDqCKCBsiQy0qQUvGC2OiMW2SF3AM6PJi9msG3mE23j2bk0H
         cn4MNmXAWePMmWlSd6z0Eb8sOFm8sSL4UQlWTSTu2LtXKCjVEpH6SzR7C2bdHpBNUuN8
         iuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=ROo2mEOaZoS8Oj0lfCLj/EE9ivwrxNSCdoSlWp9ZnaE=;
        b=PLCgZcdIax8rMVu9HWHBUXRxwUPxftU4gC0uRseMnTNMcj8LaUJOgShYH5Lbg+B8kV
         4GsPocqX/UFUVQVtPcFIc5CDuG2XRiktXj806EykoV6FBjOhmoaMbycJUgYVEcVuQhBg
         C4b0OgYsoItR4pxNH0pc4MXSZMEUlCn6AfMoHID/4/kmz8lwJvl419hwGwVVGITer6ns
         ur50zRKb2N7wK4tc9slUoOBKqh2J/xpdaFqRIjOzpFlWp+Y8kh79xpMax9iNk6Z7t4tG
         lhJJsJ4IWVh8RhSI7r9yNIFt2bKm8dksj3u8B4Qz6rwcYNyBZqHdbQ2NuhBbE1SbFHrK
         8I/g==
X-Gm-Message-State: APjAAAVL8VSaAFLQIn2lPFxeKqSAOM95ReI1Mx0utVGeQ58kEeyGfPWZ
        NjGisBEBfn44sbJVbxqt1Cc=
X-Google-Smtp-Source: APXvYqwBwbmbaPsfHN+w4uZj+X/nrqzlTn8MFQEtc1rGP8dthOerSxRODMr+x/FR9hltcYHiDN1yYA==
X-Received: by 2002:a6b:e20e:: with SMTP id z14mr1460352ioc.169.1556657788437;
        Tue, 30 Apr 2019 13:56:28 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id s7sm9799349ioo.17.2019.04.30.13.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 13:56:27 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH 11/14] powercap/intel_rapl: update rapl domain name and debug messages
Date:   Tue, 30 Apr 2019 16:55:56 -0400
Message-Id: <80fb3b7e0cc9daaacb583e9bb2914e490a3ee7b2.1553624867.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <75386dff62ee869eb7357dff1e60dfd9b3e68023.1553624867.git.len.brown@intel.com>
References: <75386dff62ee869eb7357dff1e60dfd9b3e68023.1553624867.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

The RAPL domain "name" attribute contains "Package-N",
which is ambiguous on multi-die per-package systems.

Update the name to "package-X-die-Y" on those systems.

No change on systems without multi-die.

Driver debug messages are also updated.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/powercap/intel_rapl.c | 57 ++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 38c89db15150..f2c097c15afb 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -178,12 +178,15 @@ struct rapl_domain {
 #define power_zone_to_rapl_domain(_zone) \
 	container_of(_zone, struct rapl_domain, power_zone)
 
+/* maximum rapl package domain name: package-%d-die-%d */
+#define PACKAGE_DOMAIN_NAME_LENGTH 30
 
-/* Each physical package contains multiple domains, these are the common
+
+/* Each rapl package contains multiple domains, these are the common
  * data across RAPL domains within a package.
  */
 struct rapl_package {
-	unsigned int id; /* physical package/socket id */
+	unsigned int id; /* logical die id, equals physical 1-die systems */
 	unsigned int nr_domains;
 	unsigned long domain_map; /* bit map of active domains */
 	unsigned int power_unit;
@@ -198,6 +201,7 @@ struct rapl_package {
 	int lead_cpu; /* one active cpu per package for access */
 	/* Track active cpus */
 	struct cpumask cpumask;
+	char name[PACKAGE_DOMAIN_NAME_LENGTH];
 };
 
 struct rapl_defaults {
@@ -926,8 +930,8 @@ static int rapl_check_unit_core(struct rapl_package *rp, int cpu)
 	value = (msr_val & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
 	rp->time_unit = 1000000 / (1 << value);
 
-	pr_debug("Core CPU package %d energy=%dpJ, time=%dus, power=%duW\n",
-		rp->id, rp->energy_unit, rp->time_unit, rp->power_unit);
+	pr_debug("Core CPU %s energy=%dpJ, time=%dus, power=%duW\n",
+		rp->name, rp->energy_unit, rp->time_unit, rp->power_unit);
 
 	return 0;
 }
@@ -951,8 +955,8 @@ static int rapl_check_unit_atom(struct rapl_package *rp, int cpu)
 	value = (msr_val & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
 	rp->time_unit = 1000000 / (1 << value);
 
-	pr_debug("Atom package %d energy=%dpJ, time=%dus, power=%duW\n",
-		rp->id, rp->energy_unit, rp->time_unit, rp->power_unit);
+	pr_debug("Atom %s energy=%dpJ, time=%dus, power=%duW\n",
+		rp->name, rp->energy_unit, rp->time_unit, rp->power_unit);
 
 	return 0;
 }
@@ -1179,7 +1183,7 @@ static void rapl_update_domain_data(struct rapl_package *rp)
 	u64 val;
 
 	for (dmn = 0; dmn < rp->nr_domains; dmn++) {
-		pr_debug("update package %d domain %s data\n", rp->id,
+		pr_debug("update %s domain %s data\n", rp->name,
 			 rp->domains[dmn].name);
 		/* exclude non-raw primitives */
 		for (prim = 0; prim < NR_RAW_PRIMITIVES; prim++) {
@@ -1204,7 +1208,6 @@ static void rapl_unregister_powercap(void)
 static int rapl_package_register_powercap(struct rapl_package *rp)
 {
 	struct rapl_domain *rd;
-	char dev_name[17]; /* max domain name = 7 + 1 + 8 for int + 1 for null*/
 	struct powercap_zone *power_zone = NULL;
 	int nr_pl, ret;
 
@@ -1215,20 +1218,16 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
 	for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++) {
 		if (rd->id == RAPL_DOMAIN_PACKAGE) {
 			nr_pl = find_nr_power_limit(rd);
-			pr_debug("register socket %d package domain %s\n",
-				rp->id, rd->name);
-			memset(dev_name, 0, sizeof(dev_name));
-			snprintf(dev_name, sizeof(dev_name), "%s-%d",
-				rd->name, rp->id);
+			pr_debug("register package domain %s\n", rp->name);
 			power_zone = powercap_register_zone(&rd->power_zone,
 							control_type,
-							dev_name, NULL,
+							rp->name, NULL,
 							&zone_ops[rd->id],
 							nr_pl,
 							&constraint_ops);
 			if (IS_ERR(power_zone)) {
-				pr_debug("failed to register package, %d\n",
-					rp->id);
+				pr_debug("failed to register power zone %s\n",
+					rp->name);
 				return PTR_ERR(power_zone);
 			}
 			/* track parent zone in per package/socket data */
@@ -1254,8 +1253,8 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
 						&constraint_ops);
 
 		if (IS_ERR(power_zone)) {
-			pr_debug("failed to register power_zone, %d:%s:%s\n",
-				rp->id, rd->name, dev_name);
+			pr_debug("failed to register power_zone, %s:%s\n",
+				rp->name, rd->name);
 			ret = PTR_ERR(power_zone);
 			goto err_cleanup;
 		}
@@ -1268,7 +1267,7 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
 	 * failed after the first domain setup.
 	 */
 	while (--rd >= rp->domains) {
-		pr_debug("unregister package %d domain %s\n", rp->id, rd->name);
+		pr_debug("unregister %s domain %s\n", rp->name, rd->name);
 		powercap_unregister_zone(control_type, &rd->power_zone);
 	}
 
@@ -1378,8 +1377,8 @@ static void rapl_detect_powerlimit(struct rapl_domain *rd)
 	/* check if the domain is locked by BIOS, ignore if MSR doesn't exist */
 	if (!rapl_read_data_raw(rd, FW_LOCK, false, &val64)) {
 		if (val64) {
-			pr_info("RAPL package %d domain %s locked by BIOS\n",
-				rd->rp->id, rd->name);
+			pr_info("RAPL %s domain %s locked by BIOS\n",
+				rd->rp->name, rd->name);
 			rd->state |= DOMAIN_STATE_BIOS_LOCKED;
 		}
 	}
@@ -1408,10 +1407,10 @@ static int rapl_detect_domains(struct rapl_package *rp, int cpu)
 	}
 	rp->nr_domains = bitmap_weight(&rp->domain_map,	RAPL_DOMAIN_MAX);
 	if (!rp->nr_domains) {
-		pr_debug("no valid rapl domains found in package %d\n", rp->id);
+		pr_debug("no valid rapl domains found in %s\n", rp->name);
 		return -ENODEV;
 	}
-	pr_debug("found %d domains on package %d\n", rp->nr_domains, rp->id);
+	pr_debug("found %d domains on %s\n", rp->nr_domains, rp->name);
 
 	rp->domains = kcalloc(rp->nr_domains + 1, sizeof(struct rapl_domain),
 			GFP_KERNEL);
@@ -1444,8 +1443,8 @@ static void rapl_remove_package(struct rapl_package *rp)
 			rd_package = rd;
 			continue;
 		}
-		pr_debug("remove package, undo power limit on %d: %s\n",
-			 rp->id, rd->name);
+		pr_debug("remove package, undo power limit on %s: %s\n",
+			 rp->name, rd->name);
 		powercap_unregister_zone(control_type, &rd->power_zone);
 	}
 	/* do parent zone last */
@@ -1459,6 +1458,7 @@ static struct rapl_package *rapl_add_package(int cpu)
 {
 	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	int ret;
 
 	rp = kzalloc(sizeof(struct rapl_package), GFP_KERNEL);
@@ -1469,6 +1469,13 @@ static struct rapl_package *rapl_add_package(int cpu)
 	rp->id = id;
 	rp->lead_cpu = cpu;
 
+	if (c->x86_max_dies > 1)
+		snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH,
+			"package-%d-die-%d", c->phys_proc_id, c->cpu_die_id);
+	else
+		snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d",
+			c->phys_proc_id);
+
 	/* check if the package contains valid domains */
 	if (rapl_detect_domains(rp, cpu) ||
 		rapl_defaults->check_unit(rp, cpu)) {
-- 
2.18.0-rc0

