Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFAC21557F
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 23:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfEFV0l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 17:26:41 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36810 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfEFV0l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2019 17:26:41 -0400
Received: by mail-it1-f193.google.com with SMTP id o190so5226535itc.1;
        Mon, 06 May 2019 14:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=7fof8gmlqFrlN3tjmdJFzcPdOK3UTzw80TgmMMhQvqE=;
        b=gTH/lEGh82vXO1uYay+5xgNbMYVx5HCMYqBEkggsBNHT8HXvSdCQo6sGPM5ao9DP8d
         qAAgQUStLDOn9UdX9WyzUGYla5zZY6GKdLs5L05isArmxmBCdL2rzazavrBHS8LAEq/A
         uEUXQlPf5H5oRHz9F6Japx5hK94TaQRUYf5RDXwYy8bErXKaU4uvUVFjusW5cw/umNWE
         WH2/YClU0KZHRrtrxlgk/HOnVNi+Z7rwF+wRasDlGvD6hXsKz6rOwIERLw7vZNdbC7+z
         1qrddGory7uQtPeerY+JIOIQVsHk11xUkjbPAANU0ASBPLsZKFZ8Fb9HjuZbf3yP7oor
         HhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=7fof8gmlqFrlN3tjmdJFzcPdOK3UTzw80TgmMMhQvqE=;
        b=j8mXikygT1TGygZKlcjDmctbwmlx+BpP5P9dYWvWCF3l8oqUCM1uTanrlR1psUK2Ro
         3J2uK8Hn7OzjIf6eA7euTtyqUzE1IjqmkquGTsipJNWcqLoNzTTgo+VPcn4zi4+R6WKt
         7K5FpweZfebyv50Rsrb7bHYaubnycRKmv9ABab1fOxtC8l4tINMjAIV1xAyXxxZfCvUX
         jm6D9uf8GX1G3ugNAzd+PLNS1WlO1sctOEC9K50wT0s13iTlO1mMhgRqDmgw7BdpERPX
         7kQqU8FTTZKzFyq7eC7/wS180URFJ77+daY9uB2HXkURZ522Z4JhZMSY4S1N5sFGC3/u
         OL0g==
X-Gm-Message-State: APjAAAW+WQER9LI758g3ksgmWXVejFcMab0pltg9pmxxnGW4YV26xmlI
        SvOG97Kga/zOMl8MID2atx8eHDMd
X-Google-Smtp-Source: APXvYqwkEuAZA85xkUvd4cRsMsyo4MPtvYYgbRKu1IWXws4weWTH6BL7ZXOzEavwOHhTVGYWFSQdxA==
X-Received: by 2002:a02:52c9:: with SMTP id d192mr20648795jab.53.1557178000303;
        Mon, 06 May 2019 14:26:40 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id v25sm4268009ioh.81.2019.05.06.14.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:26:39 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH 12/22] powercap/intel_rapl: update rapl domain name and debug messages
Date:   Mon,  6 May 2019 17:26:07 -0400
Message-Id: <0274c268be3c15d5e6e199b1de46e83a550247bc.1557177585.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
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

No change on systems without multi-die/package.

Update driver debug messages.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/powercap/intel_rapl.c | 57 ++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 9202dbcef96d..ad78c1d08260 100644
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
@@ -1181,7 +1185,7 @@ static void rapl_update_domain_data(struct rapl_package *rp)
 	u64 val;
 
 	for (dmn = 0; dmn < rp->nr_domains; dmn++) {
-		pr_debug("update package %d domain %s data\n", rp->id,
+		pr_debug("update %s domain %s data\n", rp->name,
 			 rp->domains[dmn].name);
 		/* exclude non-raw primitives */
 		for (prim = 0; prim < NR_RAW_PRIMITIVES; prim++) {
@@ -1206,7 +1210,6 @@ static void rapl_unregister_powercap(void)
 static int rapl_package_register_powercap(struct rapl_package *rp)
 {
 	struct rapl_domain *rd;
-	char dev_name[17]; /* max domain name = 7 + 1 + 8 for int + 1 for null*/
 	struct powercap_zone *power_zone = NULL;
 	int nr_pl, ret;
 
@@ -1217,20 +1220,16 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
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
@@ -1256,8 +1255,8 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
 						&constraint_ops);
 
 		if (IS_ERR(power_zone)) {
-			pr_debug("failed to register power_zone, %d:%s:%s\n",
-				rp->id, rd->name, dev_name);
+			pr_debug("failed to register power_zone, %s:%s\n",
+				rp->name, rd->name);
 			ret = PTR_ERR(power_zone);
 			goto err_cleanup;
 		}
@@ -1270,7 +1269,7 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
 	 * failed after the first domain setup.
 	 */
 	while (--rd >= rp->domains) {
-		pr_debug("unregister package %d domain %s\n", rp->id, rd->name);
+		pr_debug("unregister %s domain %s\n", rp->name, rd->name);
 		powercap_unregister_zone(control_type, &rd->power_zone);
 	}
 
@@ -1380,8 +1379,8 @@ static void rapl_detect_powerlimit(struct rapl_domain *rd)
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
@@ -1410,10 +1409,10 @@ static int rapl_detect_domains(struct rapl_package *rp, int cpu)
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
@@ -1446,8 +1445,8 @@ static void rapl_remove_package(struct rapl_package *rp)
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
@@ -1461,6 +1460,7 @@ static struct rapl_package *rapl_add_package(int cpu)
 {
 	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	int ret;
 
 	rp = kzalloc(sizeof(struct rapl_package), GFP_KERNEL);
@@ -1471,6 +1471,13 @@ static struct rapl_package *rapl_add_package(int cpu)
 	rp->id = id;
 	rp->lead_cpu = cpu;
 
+	if (topology_max_die_per_package() > 1)
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

