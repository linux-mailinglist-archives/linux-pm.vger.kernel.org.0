Return-Path: <linux-pm+bounces-26570-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A70BAA7453
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 16:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5F91C0052B
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594DB15A848;
	Fri,  2 May 2025 14:01:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E96A2AF1E
	for <linux-pm@vger.kernel.org>; Fri,  2 May 2025 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746194488; cv=none; b=e/1svpI1Ug88hTfq175FX01jv/+zbncLRzCWBxw9fbq03Vtk5T2+GAXRgt6/RXHiVU1lC6p5fJsB8ca811Vdh/BFRYVIux8QnOw5xTHEmASk5AvK5KByVZZUNsLst1MSutY2oBVwyJ8KIFU7Cx4oBpiCOaksbOA9bFD2hJIFjR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746194488; c=relaxed/simple;
	bh=j5GRskBBoUPwMqjtzydqzK+UCkj1l+gFFwM8iJDjHNE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eqygNc4VL16JdJsw6KYCJaGqzqhjRy/5UhOTMkeKv+CoLE+IdvqnrCm5Rk/DUiaDvSFpKDqe9ytPDmftuBK99zawfAhFQfNHpgmopDJqw7NmAzN9NI3Um2Prvs8Dhw61gs6cmCgcOqxk1GmHQ/ax26sNhe/zQGsczJyqur/qVuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3FC61688;
	Fri,  2 May 2025 07:01:17 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 70D723F673;
	Fri,  2 May 2025 07:01:24 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] cpuidle: psci: Avoid initializing faux device if no DT idle states are present
Date: Fri,  2 May 2025 15:01:19 +0100
Message-Id: <20250502140119.2578909-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit af5376a77e87 ("cpuidle: psci: Transition to the faux device interface")
transitioned the PSCI cpuidle driver from using a platform device to the
faux device framework. However, unlike platform devices, the faux device
infrastructure logs an error when the probe function fails, even if the
failure is intentional or expected.

To prevent unnecessary error logs, we can skip creating the faux device
entirely if there are no PSCI idle states defined in the device tree.
Introduce a check for DT idle states during initialization and avoid
setting up the device if none are found.

This ensures cleaner logs and avoids misleading probe failure messages
when PSCI idle support is intentionally not described in DT.

Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Fixes: af5376a77e87 ("cpuidle: psci: Transition to the faux device interface")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Closes: https://lore.kernel.org/r/cf4e70e4-9fe5-4697-8744-8c12c41b5ff9@nvidia.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpuidle/cpuidle-psci.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index ee35ac816321..40f378c1dc9f 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -438,10 +438,29 @@ static struct faux_device_ops psci_cpuidle_ops = {
 	.probe = psci_cpuidle_probe,
 };
 
+static bool __init dt_idle_state_present(void)
+{
+	struct device_node *cpu_node __free(device_node);
+	struct device_node *state_node __free(device_node);
+
+	cpu_node = of_cpu_device_node_get(cpumask_first(cpu_possible_mask));
+	if (!cpu_node)
+		return false;
+
+	state_node = of_get_cpu_state_node(cpu_node, 0);
+	if (!state_node)
+		return false;
+
+	return !!of_match_node(psci_idle_state_match, state_node);
+}
+
 static int __init psci_idle_init(void)
 {
 	struct faux_device *fdev;
 
+	if (!dt_idle_state_present())
+		return 0;
+
 	fdev = faux_device_create("psci-cpuidle", NULL, &psci_cpuidle_ops);
 	if (!fdev) {
 		pr_err("Failed to create psci-cpuidle device\n");
-- 
2.34.1


