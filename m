Return-Path: <linux-pm+bounces-14927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59780989C8F
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 10:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15EAB283169
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 08:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8786317E8E2;
	Mon, 30 Sep 2024 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lp0KZKQa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D639317AE1D;
	Mon, 30 Sep 2024 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684390; cv=none; b=BVLYa+UtvJ35wI0d067PhmMyELXn9uCEYrLbdkeMV3ut7aLNzHDHp+k9gEk4rIpjWkS/Ggn5d04LORaHEdpieWa400I2WXbEiaxptoBMWvawcgvzrWMZKqhgF4BLoQwXAQtnw8PEZzoI0l8ty90/jYUfxWahQhVXVaNL0FRpy7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684390; c=relaxed/simple;
	bh=Pg3w5FOZSG04AWbAHQDiz4yGvhlJGQ//2Ie7F9VCl2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MDPJOe1AyZ33jhpkwixIIWIGIgtg5NJMA+kbIRqPSOuG2eOk8+fBGpf2ethLZr1w66mDmBNTe4EUecHlQu/85T72du4tRtyYLdI7q92HIx06YAkmJiHLY6DC79zHOJC8vG3bfHzjfbHIcVJL3dzSW2jVVQm+VHJP9IoN2c6ria0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lp0KZKQa; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727684388; x=1759220388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pg3w5FOZSG04AWbAHQDiz4yGvhlJGQ//2Ie7F9VCl2Y=;
  b=Lp0KZKQaaf5bvndJljqHnQuohWBmTQy4DtxSb/e5rh3XZ9wZzx7GPkdP
   oL2W42NOCmc2jOOYypSk1kf96q25LTDiJL35CvGQap4ENPpMsgWvGVmj1
   NRkteEm+Mwra4IhuKvyV7mQ2mCec/Cz4se+O7sT64oOATIRvGFA0fJ8V/
   JC73grON18ShsMPWBvZsq4PwhtaXcvchMB+pECzEgorTOYnOzV6dEHzTa
   1xGsKgQkNp0EvU+9BNaWz9FSouTPwMpKx/PE2yreLgHSWKAw6DIQ8mY7l
   ZUmx/z/TD/DyhkphyeBc3/4rqPnfzWQxM/DP32cfputtuQwHBZJdTCc+9
   g==;
X-CSE-ConnectionGUID: vrrArpIbQUaz/0KqNLx8eg==
X-CSE-MsgGUID: E+I2Z7BuSYybglYXTddsxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26638973"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26638973"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 01:18:34 -0700
X-CSE-ConnectionGUID: KSxrVQWvTJuFKLFxPDAxgQ==
X-CSE-MsgGUID: cbAntR62SGe55lu/iYRlow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="96549472"
Received: from unknown (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.245.243.126])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 01:18:31 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@intel.com
Subject: [PATCH 5/6] thermal: proc_thermal: Remove MMIO RAPL cpu hotplug support
Date: Mon, 30 Sep 2024 16:18:00 +0800
Message-Id: <20240930081801.28502-6-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930081801.28502-1-rui.zhang@intel.com>
References: <20240930081801.28502-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CPU0/package0 is always online and the MMIO RAPL driver runs on single
package systems only, so there is no need to handle CPU hotplug.

Always register a RAPL package device for package 0 and remove the
unnecessary cpu hotplug support.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../int340x_thermal/processor_thermal_rapl.c  | 66 +++++++------------
 1 file changed, 22 insertions(+), 44 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
index e9aa9e23aab9..769510e748c0 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
@@ -19,42 +19,6 @@ static const struct rapl_mmio_regs rapl_mmio_default = {
 	.limits[RAPL_DOMAIN_DRAM] = BIT(POWER_LIMIT2),
 };
 
-static int rapl_mmio_cpu_online(unsigned int cpu)
-{
-	struct rapl_package *rp;
-
-	/* mmio rapl supports package 0 only for now */
-	if (topology_physical_package_id(cpu))
-		return 0;
-
-	rp = rapl_find_package_domain_cpuslocked(cpu, &rapl_mmio_priv, true);
-	if (!rp) {
-		rp = rapl_add_package_cpuslocked(cpu, &rapl_mmio_priv, true);
-		if (IS_ERR(rp))
-			return PTR_ERR(rp);
-	}
-	cpumask_set_cpu(cpu, &rp->cpumask);
-	return 0;
-}
-
-static int rapl_mmio_cpu_down_prep(unsigned int cpu)
-{
-	struct rapl_package *rp;
-	int lead_cpu;
-
-	rp = rapl_find_package_domain_cpuslocked(cpu, &rapl_mmio_priv, true);
-	if (!rp)
-		return 0;
-
-	cpumask_clear_cpu(cpu, &rp->cpumask);
-	lead_cpu = cpumask_first(&rp->cpumask);
-	if (lead_cpu >= nr_cpu_ids)
-		rapl_remove_package_cpuslocked(rp);
-	else if (rp->lead_cpu == cpu)
-		rp->lead_cpu = lead_cpu;
-	return 0;
-}
-
 static int rapl_mmio_read_raw(int cpu, struct reg_action *ra)
 {
 	if (!ra->reg.mmio)
@@ -82,6 +46,7 @@ static int rapl_mmio_write_raw(int cpu, struct reg_action *ra)
 int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc_priv)
 {
 	const struct rapl_mmio_regs *rapl_regs = &rapl_mmio_default;
+	struct rapl_package *rp;
 	enum rapl_domain_reg_id reg;
 	enum rapl_domain_type domain;
 	int ret;
@@ -109,25 +74,38 @@ int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc
 		return PTR_ERR(rapl_mmio_priv.control_type);
 	}
 
-	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "powercap/rapl:online",
-				rapl_mmio_cpu_online, rapl_mmio_cpu_down_prep);
-	if (ret < 0) {
-		powercap_unregister_control_type(rapl_mmio_priv.control_type);
-		rapl_mmio_priv.control_type = NULL;
-		return ret;
+	/* Register a RAPL package device for package 0 which is always online */
+	rp = rapl_find_package_domain(0, &rapl_mmio_priv, false);
+	if (rp) {
+		ret = -EEXIST;
+		goto err;
+	}
+
+	rp = rapl_add_package(0, &rapl_mmio_priv, false);
+	if (IS_ERR(rp)) {
+		ret = PTR_ERR(rp);
+		goto err;
 	}
-	rapl_mmio_priv.pcap_rapl_online = ret;
 
 	return 0;
+
+err:
+	powercap_unregister_control_type(rapl_mmio_priv.control_type);
+	rapl_mmio_priv.control_type = NULL;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(proc_thermal_rapl_add);
 
 void proc_thermal_rapl_remove(void)
 {
+	struct rapl_package *rp;
+
 	if (IS_ERR_OR_NULL(rapl_mmio_priv.control_type))
 		return;
 
-	cpuhp_remove_state(rapl_mmio_priv.pcap_rapl_online);
+	rp = rapl_find_package_domain(0, &rapl_mmio_priv, false);
+	if (rp)
+		rapl_remove_package(rp);
 	powercap_unregister_control_type(rapl_mmio_priv.control_type);
 }
 EXPORT_SYMBOL_GPL(proc_thermal_rapl_remove);
-- 
2.34.1


