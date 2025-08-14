Return-Path: <linux-pm+bounces-32416-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 506BDB272B3
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 00:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05E514E5420
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 22:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655D52836BE;
	Thu, 14 Aug 2025 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iS3nV2To"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33CB274FC1;
	Thu, 14 Aug 2025 22:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212283; cv=none; b=u+J61bMp2QY7k3QS/MFFbnvKPLG5A0KFIqy+sfFbqqUSiOD4VoYDYou1XtAIuGsy9yFdI/nkvImyaIgf2lQJEZazOi3e1YaENiUoettwsoAFHyLamrrVTKTZ3EqLSx5J2QdvRq+Px3gsM1W23JJUgTmlS56BuUDiLnRwlDq9hWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212283; c=relaxed/simple;
	bh=v6sq3o9BJiULKoiDIE8D7omTK29z5q2no/7JhhhhtSE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y2+WKVw1+Q0bQf/YmxuTxbGmu+F71cmMPkb/X7hZ1fVxQKgfcfWOLp+qOo/d2Sg/ccpGUJlcEtACAoMe5iCdN65Lv1dIkw6HwAfnZjhyT5Q3ECfwGzyTPlm1R9G/TFP4hzlIl/8e6bO4p47G+P1EbCoCnuaMkJbB/zvIBgFn/is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iS3nV2To; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 72489C0429D7;
	Thu, 14 Aug 2025 15:52:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 72489C0429D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1755211947;
	bh=v6sq3o9BJiULKoiDIE8D7omTK29z5q2no/7JhhhhtSE=;
	h=From:To:Cc:Subject:Date:From;
	b=iS3nV2Tor4uJI2rBygWdOBNAsFghb0Lba6BXBA0lzogf80dA/ffrGS0zbGPawRcZq
	 H9hE9gqBeZaAEJSuEFa4195osXErq87OwVKOuFMSk+lIjVB0Sx3VtUo0sRuSaYGG+V
	 D42r13zVm4TtFOSXsskbXpH6qS8io1SkLTf3TFGs=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 468901800051E;
	Thu, 14 Aug 2025 15:52:27 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: james.quinlan@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Peng Fan <peng.fan@nxp.com>,
	Mike Tipton <quic_mdtipton@quicinc.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: scmi: Add quirk to disable checks in scmi_dev_used_by_cpus()
Date: Thu, 14 Aug 2025 15:51:55 -0700
Message-Id: <20250814225155.3519000-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/cpufreq/scmi-cpufreq.c     | 13 +++++++++++++
 drivers/firmware/arm_scmi/quirks.c |  2 ++
 drivers/firmware/arm_scmi/quirks.h |  1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index ef078426bfd5..80647511d3c3 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -22,6 +22,8 @@
 #include <linux/types.h>
 #include <linux/units.h>
 
+#include "../drivers/firmware/arm_scmi/quirks.h"
+
 struct scmi_data {
 	int domain_id;
 	int nr_opp;
@@ -34,6 +36,7 @@ struct scmi_data {
 static struct scmi_protocol_handle *ph;
 static const struct scmi_perf_proto_ops *perf_ops;
 static struct cpufreq_driver scmi_cpufreq_driver;
+static bool __maybe_unused scmi_cpufreq_dt_props_check_disable;
 
 static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
 {
@@ -400,6 +403,9 @@ static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
 	struct device *cpu_dev;
 	int cpu, idx;
 
+	if (scmi_cpufreq_dt_props_check_disable)
+		return true;
+
 	if (!scmi_np)
 		return false;
 
@@ -427,12 +433,19 @@ static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
 	return false;
 }
 
+#define QUIRK_SCMI_CPUFREQ_CHECK_DT_PROPS			\
+	({							\
+		scmi_cpufreq_dt_props_check_disable = true;	\
+	})
+
 static int scmi_cpufreq_probe(struct scmi_device *sdev)
 {
 	int ret;
 	struct device *dev = &sdev->dev;
 	const struct scmi_handle *handle;
 
+	SCMI_QUIRK(scmi_cpufreq_no_check_dt_props, QUIRK_SCMI_CPUFREQ_CHECK_DT_PROPS);
+
 	handle = sdev->handle;
 
 	if (!handle || !scmi_dev_used_by_cpus(dev))
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
 
diff --git a/drivers/firmware/arm_scmi/quirks.h b/drivers/firmware/arm_scmi/quirks.h
index a71fde85a527..64ac1f05d0d3 100644
--- a/drivers/firmware/arm_scmi/quirks.h
+++ b/drivers/firmware/arm_scmi/quirks.h
@@ -48,5 +48,6 @@ static inline void scmi_quirks_enable(struct device *dev, const char *vend,
 /* Quirk delarations */
 DECLARE_SCMI_QUIRK(clock_rates_triplet_out_of_spec);
 DECLARE_SCMI_QUIRK(perf_level_get_fc_force);
+DECLARE_SCMI_QUIRK(scmi_cpufreq_no_check_dt_props);
 
 #endif /* _SCMI_QUIRKS_H */
-- 
2.34.1


