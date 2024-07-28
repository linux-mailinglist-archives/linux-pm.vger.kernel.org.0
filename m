Return-Path: <linux-pm+bounces-11493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8821C93E241
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 03:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0915F1F21AF2
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2024 01:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9EC18E76E;
	Sun, 28 Jul 2024 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXGcAMiO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E761138382;
	Sun, 28 Jul 2024 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127792; cv=none; b=C3TtoKtF+xSke051FsrgTkvX/2x4zZZLEVPIiUtf3uamEfTZVQLEYqSUNMRGf0KwOT0sBfpCfJ8q7Rc39pDtOUsf7dMYW3iQtzoGWZK0GF6A6PQTMs0+Un/3UnMfXjRbvX4aNnyMfDdLZshNXbUF3w4pewBSHXhk9rSLMjWHIe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127792; c=relaxed/simple;
	bh=q2GICK9JU3ujDRUk5aYaltkz5NWuqlEhDQJ3urBVj4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SczTgbpXvO9wPtcR01uk8GO+Dd8/P4oEAwiZ7Q9q5pvEsFKWgFObvrwkmQRquGE14QGsE8+h4S9U9BDIoStRIxdMRG1Sd2pWRT2YppY0PHfdKkhUMxp9kQnROvTpDvZPqwh3hKKnl9Up29JiKT9SNz8BjM2vpT5zVXfoTnFWmQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXGcAMiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04083C4AF09;
	Sun, 28 Jul 2024 00:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127791;
	bh=q2GICK9JU3ujDRUk5aYaltkz5NWuqlEhDQJ3urBVj4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eXGcAMiOX2P8Bpzdc2kXo1T8aaKc0QqrvPCsc926DRaKkNPnt8pXROz98hsYYlWWG
	 R00RYmBGlx/ofxMvB4BII9sbjSpEgRB/w8qcS5N7IkEMf3uEzxNOTv0DHUFifFXJTN
	 pbWdvBssboeyxmPjCAXbQTxj5lNQHMbYIdym7BaehCbPVI8rjY2a7+D62dLGvqRzRH
	 ZYgQyTt7RZElYyktL3+eCCm4+mzqyt+wNLZGnQQQ2OmY84E9wJHfB2gz2932+sM6zG
	 6zUnkC4ys2zSDG7M/fN0G74kY0ixHaiV4ifS1N9TCgFafNElAS66eFLZUf43uovQ/E
	 i0w1hcx0/lq7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	stanislaw.gruszka@linux.intel.com,
	tglx@linutronix.de,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 9/9] thermal: intel: hfi: Give HFI instances package scope
Date: Sat, 27 Jul 2024 20:49:29 -0400
Message-ID: <20240728004934.1706375-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004934.1706375-1-sashal@kernel.org>
References: <20240728004934.1706375-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit b755367602d70deade956cbe0b8a3f5a12f569dc ]

The Intel Software Developer's Manual defines the scope of HFI (registers
and memory buffer) as a package. Use package scope(*) in the software
representation of an HFI instance.

Using die scope in HFI instances has the effect of creating multiple
conflicting instances for the same package: each instance allocates its
own memory buffer and configures the same package-level registers.
Specifically, only one of the allocated memory buffers can be set in the
MSR_IA32_HW_FEEDBACK_PTR register. CPUs get incorrect HFI data from the
table.

The problem does not affect current HFI-capable platforms because they
all have single-die processors.

(*) We used die scope for HFI instances because there had been
    processors with packages enumerated as dies. None of those systems
    supported HFI, though. If such a system emerged, it would need to
    be quirked.

Co-developed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Link: https://patch.msgid.link/20240703055445.125362-1-rui.zhang@intel.com
[ rjw: Changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/intel/intel_hfi.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index a180a98bb9f15..5b18a46a10b06 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -401,10 +401,10 @@ static void hfi_disable(void)
  * intel_hfi_online() - Enable HFI on @cpu
  * @cpu:	CPU in which the HFI will be enabled
  *
- * Enable the HFI to be used in @cpu. The HFI is enabled at the die/package
- * level. The first CPU in the die/package to come online does the full HFI
+ * Enable the HFI to be used in @cpu. The HFI is enabled at the package
+ * level. The first CPU in the package to come online does the full HFI
  * initialization. Subsequent CPUs will just link themselves to the HFI
- * instance of their die/package.
+ * instance of their package.
  *
  * This function is called before enabling the thermal vector in the local APIC
  * in order to ensure that @cpu has an associated HFI instance when it receives
@@ -414,31 +414,31 @@ void intel_hfi_online(unsigned int cpu)
 {
 	struct hfi_instance *hfi_instance;
 	struct hfi_cpu_info *info;
-	u16 die_id;
+	u16 pkg_id;
 
 	/* Nothing to do if hfi_instances are missing. */
 	if (!hfi_instances)
 		return;
 
 	/*
-	 * Link @cpu to the HFI instance of its package/die. It does not
+	 * Link @cpu to the HFI instance of its package. It does not
 	 * matter whether the instance has been initialized.
 	 */
 	info = &per_cpu(hfi_cpu_info, cpu);
-	die_id = topology_logical_die_id(cpu);
+	pkg_id = topology_logical_package_id(cpu);
 	hfi_instance = info->hfi_instance;
 	if (!hfi_instance) {
-		if (die_id >= max_hfi_instances)
+		if (pkg_id >= max_hfi_instances)
 			return;
 
-		hfi_instance = &hfi_instances[die_id];
+		hfi_instance = &hfi_instances[pkg_id];
 		info->hfi_instance = hfi_instance;
 	}
 
 	init_hfi_cpu_index(info);
 
 	/*
-	 * Now check if the HFI instance of the package/die of @cpu has been
+	 * Now check if the HFI instance of the package of @cpu has been
 	 * initialized (by checking its header). In such case, all we have to
 	 * do is to add @cpu to this instance's cpumask and enable the instance
 	 * if needed.
@@ -504,7 +504,7 @@ void intel_hfi_online(unsigned int cpu)
  *
  * On some processors, hardware remembers previous programming settings even
  * after being reprogrammed. Thus, keep HFI enabled even if all CPUs in the
- * die/package of @cpu are offline. See note in intel_hfi_online().
+ * package of @cpu are offline. See note in intel_hfi_online().
  */
 void intel_hfi_offline(unsigned int cpu)
 {
@@ -674,9 +674,13 @@ void __init intel_hfi_init(void)
 	if (hfi_parse_features())
 		return;
 
-	/* There is one HFI instance per die/package. */
-	max_hfi_instances = topology_max_packages() *
-			    topology_max_dies_per_package();
+	/*
+	 * Note: HFI resources are managed at the physical package scope.
+	 * There could be platforms that enumerate packages as Linux dies.
+	 * Special handling would be needed if this happens on an HFI-capable
+	 * platform.
+	 */
+	max_hfi_instances = topology_max_packages();
 
 	/*
 	 * This allocation may fail. CPU hotplug callbacks must check
-- 
2.43.0


