Return-Path: <linux-pm+bounces-32430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8A8B27E3F
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 12:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5748C7B8252
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2316D2FF17E;
	Fri, 15 Aug 2025 10:28:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3737B2FF160;
	Fri, 15 Aug 2025 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755253684; cv=none; b=emUatMzyaOnmJiqPTriOr/KYDDjNBlx+1VUyF4HK75etaG3Pi01m9q/wfNEjxHTo/VEkECk92THMsCc2GkZnfsXfJRdssBpJl55nvWEk2/DnwuaGLzJSlullevYWoe0ZtYREo4+905zrKjA0rW3FU0yc29iYceP/byw0JqpoLcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755253684; c=relaxed/simple;
	bh=bYRHPLwM3wscJ9hwkYeWxYXJ1/BNK7y9ISRCt/HdLjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fd3DGF18RzhBWJw0mNU7LNwbFJl78QZGV7lX71UXOq/n6m3XQtuJZ502o1M9qtc5lYfGRpLWHclOEFGFTG+N34wZXw3mDoZZaZxv7Nnh2q0V5g25f+2ZRadOZILeamt2V3l55uVpBny6x9WvM/eaOSyVLAe0vW8OgacRbwVo6Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 561341EA6;
	Fri, 15 Aug 2025 03:27:53 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94F563F738;
	Fri, 15 Aug 2025 03:27:58 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	quic_sibis@quicinc.com,
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	johan+linaro@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	quic_mdtipton@quicinc.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 2/2] [NOT_FOR_UPSTREAM] cpufreq: scmi: Add quirk to disable checks in scmi_dev_used_by_cpus()
Date: Fri, 15 Aug 2025 11:27:36 +0100
Message-ID: <20250815102736.81450-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815102736.81450-1-cristian.marussi@arm.com>
References: <20250815102736.81450-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <florian.fainelli@broadcom.com>

Broadcom STB platforms were early adopters of the SCMI framework and as
a result, not all deployed systems have a Device Tree entry where SCMI
protocol 0x13 (PERFORMANCE) is declared as a clock provider, nor are the
CPU Device Tree node(s) referencing protocol 0x13 as their clock
provider.

Leverage the quirks framework recently introduce to match on the
Broadcom SCMI vendor and in that case, disable the Device Tree
properties checks being done by scmi_dev_used_by_cpus().

Suggested-by: Cristian Marussi <cristian.marussi@arm.com>
Fixes: 6c9bb8692272 ("cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
[Cristian: Moved quirk directly into scmi_dev_used_by_cpus]
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

----
@Florian: I reworked this minimally to avoid the global as I was mentioning.
No change around the version match either...so the NOT_FOR_UPSTREAM tag.
(also the if (true) i smaybe a bit idiotic...)
Please check if it is fine and modify as you see fit.
---
 drivers/cpufreq/scmi-cpufreq.c     | 9 +++++++++
 drivers/firmware/arm_scmi/quirks.c | 2 ++
 include/linux/scmi_quirks.h        | 1 +
 3 files changed, 12 insertions(+)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index ef078426bfd5..9b7cbc4e87d9 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -19,6 +19,7 @@
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/scmi_protocol.h>
+#include <linux/scmi_quirks.h>
 #include <linux/types.h>
 #include <linux/units.h>
 
@@ -393,6 +394,12 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 	.set_boost	= cpufreq_boost_set_sw,
 };
 
+#define QUIRK_SCMI_CPUFREQ_CHECK_DT_PROPS			\
+	({							\
+		if (true)					\
+			return true;				\
+	})
+
 static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
 {
 	struct device_node *scmi_np = dev_of_node(scmi_dev);
@@ -400,6 +407,8 @@ static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
 	struct device *cpu_dev;
 	int cpu, idx;
 
+	SCMI_QUIRK(scmi_cpufreq_no_check_dt_props, QUIRK_SCMI_CPUFREQ_CHECK_DT_PROPS);
+
 	if (!scmi_np)
 		return false;
 
diff --git a/drivers/firmware/arm_scmi/quirks.c b/drivers/firmware/arm_scmi/quirks.c
index 03960aca3610..aafc7b4b3294 100644
--- a/drivers/firmware/arm_scmi/quirks.c
+++ b/drivers/firmware/arm_scmi/quirks.c
@@ -171,6 +171,7 @@ struct scmi_quirk {
 /* Global Quirks Definitions */
 DEFINE_SCMI_QUIRK(clock_rates_triplet_out_of_spec, NULL, NULL, NULL);
 DEFINE_SCMI_QUIRK(perf_level_get_fc_force, "Qualcomm", NULL, "0x20000-");
+DEFINE_SCMI_QUIRK_EXPORTED(scmi_cpufreq_no_check_dt_props, "brcm-scmi", NULL, "0x2");
 
 /*
  * Quirks Pointers Array
@@ -181,6 +182,7 @@ DEFINE_SCMI_QUIRK(perf_level_get_fc_force, "Qualcomm", NULL, "0x20000-");
 static struct scmi_quirk *scmi_quirks_table[] = {
 	__DECLARE_SCMI_QUIRK_ENTRY(clock_rates_triplet_out_of_spec),
 	__DECLARE_SCMI_QUIRK_ENTRY(perf_level_get_fc_force),
+	__DECLARE_SCMI_QUIRK_ENTRY(scmi_cpufreq_no_check_dt_props),
 	NULL
 };
 
diff --git a/include/linux/scmi_quirks.h b/include/linux/scmi_quirks.h
index 11657bd91ffc..ee72a5f6e885 100644
--- a/include/linux/scmi_quirks.h
+++ b/include/linux/scmi_quirks.h
@@ -40,5 +40,6 @@
 /* Quirk delarations */
 DECLARE_SCMI_QUIRK(clock_rates_triplet_out_of_spec);
 DECLARE_SCMI_QUIRK(perf_level_get_fc_force);
+DECLARE_SCMI_QUIRK(scmi_cpufreq_no_check_dt_props);
 
 #endif /* _SCMI_QUIRKS_H */
-- 
2.50.1


