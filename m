Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431872EF4B4
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jan 2021 16:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbhAHPUd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jan 2021 10:20:33 -0500
Received: from foss.arm.com ([217.140.110.172]:52996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbhAHPUd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Jan 2021 10:20:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41474113E;
        Fri,  8 Jan 2021 07:19:48 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0B29C3F70D;
        Fri,  8 Jan 2021 07:19:46 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        manivannan.sadhasivam@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@arm.com>
Subject: [PATCH] cpufreq: Revert "cpufreq: qcom-hw: Use devm_platform_ioremap_resource() to simplify code"
Date:   Fri,  8 Jan 2021 15:14:06 +0000
Message-Id: <20210108151406.23595-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This reverts commit f17b3e44320b4079e69135c63d1e416b0703a21e.

This commit introduces a regression on platforms using the driver,
by failing to initialise a policy, when one is created post hotplug.

When all the CPUs of a policy are hoptplugged out, the call to .exit()
and later to devm_iounmap() does not release the memory region that was
requested during devm_platform_ioremap_resource().

Therefore, a subsequent call to .init() will result in the following
error, which will prevent a new policy to be initialised:

qcom-cpufreq-hw 17d43000.cpufreq: can't request region for resource
[mem 0x17d43000-0x17d443ff]

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
---

Hi guys,

I noticed the issue described in the commit message on DB845c platforms
on 5.11-rc2.

I tried to fix this, rather than revert it, but I did not find any
better way to fix this, other than possibly calling
devm_release_mem_region() directly in the cpufreq driver or reworking
some of the resource management functions. But in comparison, reverting
the patch still seemed the cleaner solution to me.

Hope it helps,
Ionela.

 drivers/cpufreq/qcom-cpufreq-hw.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 9ed5341dc515..79e637616856 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -280,6 +280,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 	struct of_phandle_args args;
 	struct device_node *cpu_np;
 	struct device *cpu_dev;
+	struct resource *res;
 	void __iomem *base;
 	struct qcom_cpufreq_data *data;
 	int ret, index;
@@ -303,9 +304,13 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	index = args.args[0];
 
-	base = devm_platform_ioremap_resource(pdev, index);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
+	if (!res)
+		return -ENODEV;
+
+	base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!base)
+		return -ENOMEM;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data) {

base-commit: e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
prerequisite-patch-id: a6b26dcf2cc7750362150ced269bc05a6cbd0a05
-- 
2.29.2.dirty

