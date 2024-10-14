Return-Path: <linux-pm+bounces-15590-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40F599BEB1
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 06:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F431C24C23
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 04:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68291991A9;
	Mon, 14 Oct 2024 03:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUrQVwiB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0D7140E2E;
	Mon, 14 Oct 2024 03:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878315; cv=none; b=dgJ+NR0K8BYlFI021ykp8jsj4Nqsr7QtQRKcU8up9EyyNMxyXGB8xCkrkehbSrbLg7RQs9uWkI1nHGOReNUo36Q2+SChlPptnDDAaKFGQ046WXcBS6vOCCEybwP/v0ocW9WL4EgnO8sUBPYSyS9geckYQLuRdHTmtTOlWd66yRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878315; c=relaxed/simple;
	bh=qjIweZIyjqfSWl56QAii3lnWpJPfAs3rhgS59rshOv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rk/F4UZvXIhpUsHMuHzNS/kmYz/SCQynOMaoOxHt3Ej+NuG7CXvhyVlU5ge5R8usM8Q1bOpBzv4RzaawB/hsrDuNzAI096//RuSAiZck+tC+KKxqYq4RLHHLQHn1pdl+AN9LarFhdZoVu2zZZ1cIfSkBT15XfIYpmW7EQkIClxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUrQVwiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302E3C4CED2;
	Mon, 14 Oct 2024 03:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878315;
	bh=qjIweZIyjqfSWl56QAii3lnWpJPfAs3rhgS59rshOv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZUrQVwiBLmGsb7XY4q/4apM2iOrgaNegX3mdKH3E7eOttuKCJZynauaBoLOr/j54u
	 54pbkU4xZ49SpFoHUdZXiDMkd4RJhn1B401PGuZe1spnUVPgdQqhE9lvRRNbi9X5SY
	 JGX5K+xegkwluDcEFtVzZLK4AyCA4kO4fp3/zkKkzLLF38jZvpcU1Pqg1R5LhfdgiC
	 BQDDDZftwUtdCJyvjdCVqYiALrg+UKNCPcE9eCLfBuExCV4n/EhP4jEf3onxEZnj/7
	 2anEju9nbLCq4IJJhV30vl2JsDa/nre/I6cvDPfwoNS6SkrwZzG1UFjDLjquXU7Un8
	 itf7K6Xj+8ekg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	andriy.shevchenko@linux.intel.com,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 13/17] thermal: intel: int340x: processor: Remove MMIO RAPL CPU hotplug support
Date: Sun, 13 Oct 2024 23:58:03 -0400
Message-ID: <20241014035815.2247153-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035815.2247153-1-sashal@kernel.org>
References: <20241014035815.2247153-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit bfc6819e4bf56a55df6178f93241b5845ad672eb ]

CPU0/package0 is always online and the MMIO RAPL driver runs on single
package systems only, so there is no need to handle CPU hotplug in it.

Always register a RAPL package device for package 0 and remove the
unnecessary CPU hotplug support.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20240930081801.28502-6-rui.zhang@intel.com
[ rjw: Subject edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../int340x_thermal/processor_thermal_rapl.c  | 66 +++++++------------
 1 file changed, 22 insertions(+), 44 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
index e964a9375722a..f7ab1f47ca7a6 100644
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
2.43.0


