Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BF42A7F41
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 13:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbgKEM5f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 07:57:35 -0500
Received: from foss.arm.com ([217.140.110.172]:60060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730829AbgKEM4z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 07:56:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 790FC142F;
        Thu,  5 Nov 2020 04:56:54 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4518C3F719;
        Thu,  5 Nov 2020 04:56:53 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        sudeep.holla@arm.com
Cc:     morten.rasmussen@arm.com, jeremy.linton@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH 8/8] acpi: fix NONE coordination for domain mapping failure
Date:   Thu,  5 Nov 2020 12:55:24 +0000
Message-Id: <20201105125524.4409-9-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201105125524.4409-1-ionela.voinescu@arm.com>
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For errors parsing the _PSD domains, a separate domain is returned for
each CPU in the failed _PSD domain with no coordination (as per previous
comment). But contrary to the intention, the code was setting
CPUFREQ_SHARED_TYPE_ALL as coordination type.

Change shared_type to CPUFREQ_SHARED_TYPE_NONE in case of errors parsing
the domain information. The function still return the error and the caller
is free to bail out the domain initialisation altogether in that case.

Given that both functions return domains with a single CPU, this change
does not affect the functionality, but clarifies the intention.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/acpi/cppc_acpi.c         | 2 +-
 drivers/acpi/processor_perflib.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 75e36b909ae6..e1e46cc66eeb 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -477,7 +477,7 @@ int acpi_get_psd_map(unsigned int cpu, struct psd_data *domain)
 	/* Assume no coordination on any error parsing domain info */
 	cpumask_clear(domain->shared_cpu_map);
 	cpumask_set_cpu(cpu, domain->shared_cpu_map);
-	domain->shared_type = CPUFREQ_SHARED_TYPE_ALL;
+	domain->shared_type = CPUFREQ_SHARED_TYPE_NONE;
 
 	return -EFAULT;
 }
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 5909e8fa4013..5ce638537791 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -710,7 +710,7 @@ int acpi_processor_preregister_performance(
 		if (retval) {
 			cpumask_clear(pr->performance->shared_cpu_map);
 			cpumask_set_cpu(i, pr->performance->shared_cpu_map);
-			pr->performance->shared_type = CPUFREQ_SHARED_TYPE_ALL;
+			pr->performance->shared_type = CPUFREQ_SHARED_TYPE_NONE;
 		}
 		pr->performance = NULL; /* Will be set for real in register */
 	}
-- 
2.17.1

