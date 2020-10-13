Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C809228C981
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 09:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390299AbgJMHmp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 03:42:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:42706 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390040AbgJMHmp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Oct 2020 03:42:45 -0400
IronPort-SDR: BzFmf12O48TMY7w8YvZuBHeeK3yAC/AiD/DIDVj30NnQhU75TIc45PJ2HTwGH3CSSJJ60Aopyw
 nni/mAe/xklA==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165928907"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="165928907"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 00:42:44 -0700
IronPort-SDR: QKCiEY7WQvm9dElnof+tQq5KzEzoBI877a84CVsz7OTo4SK/5S13a0N8v1PqkBuo4oRpF4VgxN
 3eeRQvE7/wPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="318210264"
Received: from lkp-server02.sh.intel.com (HELO inn.sh.intel.com) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Oct 2020 00:42:43 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH 2/2] powercap/intel_rapl: enumerate psys RAPL domain together with package RAPL domain
Date:   Tue, 13 Oct 2020 15:42:41 +0800
Message-Id: <20201013074241.8797-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201013074241.8797-1-rui.zhang@intel.com>
References: <20201013074241.8797-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On multi-package systems, the Psys MSR is only valid for cpus on
specific package (master package). The current code makes the assumption
that package 0 is the master package, but this is not true on new
platforms like SPR.

So fix the problem by emuerating Psys RAPL domain for every package,
thus cpus on slave packages will read 0 for the Psys energy counter, and
only cpus on master packages can get valid reading and register the Psys
RAPL Domain.

The sysfs I/F for the Psys RAPL Domain is not changed.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 80 +++++-----------------------
 drivers/powercap/intel_rapl_msr.c    |  5 +-
 include/linux/intel_rapl.h           |  7 ++-
 3 files changed, 18 insertions(+), 74 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 2651ea6cd6d3..0b2830efc574 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -544,7 +544,14 @@ static void rapl_init_domains(struct rapl_package *rp)
 			continue;
 
 		rd->rp = rp;
-		rd->name = rapl_domain_names[i];
+
+		if (i == RAPL_DOMAIN_PLATFORM && rp->id > 0) {
+			snprintf(rd->name, RAPL_DOMAIN_NAME_LENGTH, "psys-%d",
+				cpu_data(rp->lead_cpu).phys_proc_id);
+		} else
+			snprintf(rd->name, RAPL_DOMAIN_NAME_LENGTH, "%s",
+				rapl_domain_names[i]);
+
 		rd->id = i;
 		rd->rpl[0].prim_id = PL1_ENABLE;
 		rd->rpl[0].name = pl1_name;
@@ -1112,13 +1119,17 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
 	}
 	/* now register domains as children of the socket/package */
 	for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++) {
+		struct powercap_zone *parent = rp->power_zone;
+
 		if (rd->id == RAPL_DOMAIN_PACKAGE)
 			continue;
+		if (rd->id == RAPL_DOMAIN_PLATFORM)
+			parent = NULL;
 		/* number of power limits per domain varies */
 		nr_pl = find_nr_power_limit(rd);
 		power_zone = powercap_register_zone(&rd->power_zone,
 						    rp->priv->control_type,
-						    rd->name, rp->power_zone,
+						    rd->name, parent,
 						    &zone_ops[rd->id], nr_pl,
 						    &constraint_ops);
 
@@ -1145,67 +1156,6 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
 	return ret;
 }
 
-int rapl_add_platform_domain(struct rapl_if_priv *priv)
-{
-	struct rapl_domain *rd;
-	struct powercap_zone *power_zone;
-	struct reg_action ra;
-	int ret;
-
-	ra.reg = priv->regs[RAPL_DOMAIN_PLATFORM][RAPL_DOMAIN_REG_STATUS];
-	ra.mask = ~0;
-	ret = priv->read_raw(0, &ra);
-	if (ret || !ra.value)
-		return -ENODEV;
-
-	ra.reg = priv->regs[RAPL_DOMAIN_PLATFORM][RAPL_DOMAIN_REG_LIMIT];
-	ra.mask = ~0;
-	ret = priv->read_raw(0, &ra);
-	if (ret || !ra.value)
-		return -ENODEV;
-
-	rd = kzalloc(sizeof(*rd), GFP_KERNEL);
-	if (!rd)
-		return -ENOMEM;
-
-	rd->name = rapl_domain_names[RAPL_DOMAIN_PLATFORM];
-	rd->id = RAPL_DOMAIN_PLATFORM;
-	rd->regs[RAPL_DOMAIN_REG_LIMIT] =
-	    priv->regs[RAPL_DOMAIN_PLATFORM][RAPL_DOMAIN_REG_LIMIT];
-	rd->regs[RAPL_DOMAIN_REG_STATUS] =
-	    priv->regs[RAPL_DOMAIN_PLATFORM][RAPL_DOMAIN_REG_STATUS];
-	rd->rpl[0].prim_id = PL1_ENABLE;
-	rd->rpl[0].name = pl1_name;
-	rd->rpl[1].prim_id = PL2_ENABLE;
-	rd->rpl[1].name = pl2_name;
-	rd->rp = rapl_find_package_domain(0, priv);
-
-	power_zone = powercap_register_zone(&rd->power_zone, priv->control_type,
-					    "psys", NULL,
-					    &zone_ops[RAPL_DOMAIN_PLATFORM],
-					    2, &constraint_ops);
-
-	if (IS_ERR(power_zone)) {
-		kfree(rd);
-		return PTR_ERR(power_zone);
-	}
-
-	priv->platform_rapl_domain = rd;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(rapl_add_platform_domain);
-
-void rapl_remove_platform_domain(struct rapl_if_priv *priv)
-{
-	if (priv->platform_rapl_domain) {
-		powercap_unregister_zone(priv->control_type,
-				 &priv->platform_rapl_domain->power_zone);
-		kfree(priv->platform_rapl_domain);
-	}
-}
-EXPORT_SYMBOL_GPL(rapl_remove_platform_domain);
-
 static int rapl_check_domain(int cpu, int domain, struct rapl_package *rp)
 {
 	struct reg_action ra;
@@ -1215,11 +1165,9 @@ static int rapl_check_domain(int cpu, int domain, struct rapl_package *rp)
 	case RAPL_DOMAIN_PP0:
 	case RAPL_DOMAIN_PP1:
 	case RAPL_DOMAIN_DRAM:
+	case RAPL_DOMAIN_PLATFORM:
 		ra.reg = rp->priv->regs[domain][RAPL_DOMAIN_REG_STATUS];
 		break;
-	case RAPL_DOMAIN_PLATFORM:
-		/* PSYS(PLATFORM) is not a CPU domain, so avoid printng error */
-		return -EINVAL;
 	default:
 		pr_err("invalid domain id %d\n", domain);
 		return -EINVAL;
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index d2a2627507a9..1646808d354c 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -44,6 +44,7 @@ static struct rapl_if_priv rapl_msr_priv = {
 	.regs[RAPL_DOMAIN_PLATFORM] = {
 		MSR_PLATFORM_POWER_LIMIT, MSR_PLATFORM_ENERGY_STATUS, 0, 0, 0},
 	.limits[RAPL_DOMAIN_PACKAGE] = 2,
+	.limits[RAPL_DOMAIN_PLATFORM] = 2,
 };
 
 /* Handles CPU hotplug on multi-socket systems.
@@ -157,9 +158,6 @@ static int rapl_msr_probe(struct platform_device *pdev)
 		goto out;
 	rapl_msr_priv.pcap_rapl_online = ret;
 
-	/* Don't bail out if PSys is not supported */
-	rapl_add_platform_domain(&rapl_msr_priv);
-
 	return 0;
 
 out:
@@ -171,7 +169,6 @@ static int rapl_msr_probe(struct platform_device *pdev)
 static int rapl_msr_remove(struct platform_device *pdev)
 {
 	cpuhp_remove_state(rapl_msr_priv.pcap_rapl_online);
-	rapl_remove_platform_domain(&rapl_msr_priv);
 	powercap_unregister_control_type(rapl_msr_priv.control_type);
 	return 0;
 }
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index 3582176a1eca..50b8398ffd21 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -79,8 +79,10 @@ struct rapl_power_limit {
 
 struct rapl_package;
 
+#define RAPL_DOMAIN_NAME_LENGTH 16
+
 struct rapl_domain {
-	const char *name;
+	char name[RAPL_DOMAIN_NAME_LENGTH];
 	enum rapl_domain_type id;
 	u64 regs[RAPL_DOMAIN_REG_MAX];
 	struct powercap_zone power_zone;
@@ -152,7 +154,4 @@ struct rapl_package *rapl_find_package_domain(int cpu, struct rapl_if_priv *priv
 struct rapl_package *rapl_add_package(int cpu, struct rapl_if_priv *priv);
 void rapl_remove_package(struct rapl_package *rp);
 
-int rapl_add_platform_domain(struct rapl_if_priv *priv);
-void rapl_remove_platform_domain(struct rapl_if_priv *priv);
-
 #endif /* __INTEL_RAPL_H__ */
-- 
2.17.1

