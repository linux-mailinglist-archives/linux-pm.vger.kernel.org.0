Return-Path: <linux-pm+bounces-15588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C3399BE88
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 06:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931561F2122E
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 04:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93827155391;
	Mon, 14 Oct 2024 03:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A144pSAS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686371547C9;
	Mon, 14 Oct 2024 03:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878277; cv=none; b=Epmvqez7Ihd7tsJmpDKdTKIeDLY3Og4PmotT0VCYGIcsDC7w49+LaU6dtr5Fpedexdwg5rLrFsKj2GfYRj0F2pe2HHw6upgRlA9R0HrQ4dHq5hyskEAxVc2wYdIgPQlvSCENW3VKyGXktaBXfYS+N23E0tM7wuWyTTpjHVowcXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878277; c=relaxed/simple;
	bh=PjYuNwKj3o0foFb9Oq3NZ81Ag0ApJR+yRZ6CJTOP25M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rb7DBUJ7TdT1k+a6tNB+kW7D+xL3cifGv8uCkpKJFA9YKEv0ozApuyHrvY3a4/ue4FmOwc/DhuCH1/DkKXpM1XsNn7P04rUqVqKzHSU98Kc8rLHtgpQfSH9fMifFKtfd7NgFDgrHRlccibyzHJTUuMjgGdD0JncCCnHAvXJcgKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A144pSAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1889FC4CED0;
	Mon, 14 Oct 2024 03:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878277;
	bh=PjYuNwKj3o0foFb9Oq3NZ81Ag0ApJR+yRZ6CJTOP25M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A144pSAS70AeH952pkofECXg1wFciwFGfW0IYHePInUJMDVDwhNjBrjh1/oC/vk7p
	 aQ3EQhqPze6AUIeh03UgUxGixjHFi+JaPh45HuHY8wYGABO6wXatOgzVT53G9UmNQO
	 WPNfbb53yeGPKxjsncdnr9EZtPv+xkq4V8ownBtx9hILUMyzRD7G5fegjoAusbNqSZ
	 oXzhGTEdxFrUFfYi7W8c0/Dnop8r/d5hXKemexJxROC8F3/JUP6Mm6emVYNl36EeIO
	 sMqCbcqlDql8PetrICrBDX1M0ZxFLxzNQOsrAHFuonEEW2Hl0AhG4bFHEC68yYLRiQ
	 q0pb3Il7Qm6OA==
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
Subject: [PATCH AUTOSEL 6.11 16/20] thermal: intel: int340x: processor: Remove MMIO RAPL CPU hotplug support
Date: Sun, 13 Oct 2024 23:57:18 -0400
Message-ID: <20241014035731.2246632-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035731.2246632-1-sashal@kernel.org>
References: <20241014035731.2246632-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
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
index e9aa9e23aab9e..769510e748c0b 100644
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


