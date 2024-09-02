Return-Path: <linux-pm+bounces-13329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE09968310
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 11:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E94E280F1C
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 09:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5183A1C331F;
	Mon,  2 Sep 2024 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dZOv8rbu"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A2C1C2DCE;
	Mon,  2 Sep 2024 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268921; cv=none; b=cPggr6x+0Piga/+WtGEnd1SbXPnuvWnfrQAV3tQhE77UYAHCPvxFSyTT6PpRLTpjMjuC01kL+f6CROpMQVub8P+AOcjmL+Exv8EqvV1FDEODOjwPPaJG9UNJoRj/Z+Gl6chWrJUsXMClbyiBv520VbrT7lZtrsuEkVge6IAycpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268921; c=relaxed/simple;
	bh=Zgwy2BubG1EWnEAVj32BYQf+bJia6D8EG0ogAUOM+4g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=REXQaUpfzOVMpJC6vJTofurwCVgn0TEN99j2tVXQPu7iQvC/x0u1lZ1/23uH/ZY5iXP7LnJQHSKKmbS3zzpO+S2PWoP/O22nh3Nef+c80ZpV0YFfsASdddbWz+rOOg/NuU/utZHOFtE1DsfJbVo2DAP8MA5I2xgPSUZsbpU7TwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dZOv8rbu; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4829LsND010209;
	Mon, 2 Sep 2024 04:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725268914;
	bh=4XY6mWtzGjvu3ZEih9CjkESASisTpY3rzk2pXbnSDOo=;
	h=From:To:CC:Subject:Date;
	b=dZOv8rbunHurN9gclDV48Eg+pRH2pI1Q2X7xN6wxYH8Q/37QGH1A+7UFlyuTbJ+kM
	 zUhhplAtB9XNfHW0Vy9c3T/IKW52x7DBKfPCqySP6PDXStnbXXUSUhorn9FhZ7yGBW
	 LCC8xOWIRgLMer43AbWW8RfpYXvZtLkyEEI2po4g=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4829LsQS031681;
	Mon, 2 Sep 2024 04:21:54 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Sep 2024 04:21:53 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Sep 2024 04:21:54 -0500
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4829Lo2A092500;
	Mon, 2 Sep 2024 04:21:51 -0500
From: Dhruva Gole <d-gole@ti.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dhruva Gole
	<d-gole@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>, Bryan Brattlof
	<bb@ti.com>
Subject: [PATCH] cpufreq: ti-cpufreq: Use socinfo to get revision in AM62 family
Date: Mon, 2 Sep 2024 14:51:35 +0530
Message-ID: <20240902092135.2826470-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

In the AM62x, AM62Ax, and AM62Px devices, we already have the revision
info within the k3-socinfo driver. Hence, re-use this information from
there instead of re using the offset for 2 drivers trying to get the
same information ie. revision.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

Hi,
This patch depends on [1] and if someone wants to test, can use my
github branch [2]. I was able to test this on SK-AM625 [3].

[1] https://lore.kernel.org/linux-arm-kernel/20240828131915.3198081-1-nm@ti.com/
[2] https://github.com/DhruvaG2000/v-linux/tree/ti-cpufreq-revision-fix
[3] https://gist.github.com/DhruvaG2000/d0c360b0bd7e43d0fd28cfe3eab941d2

Cc: Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>
Cc: Bryan Brattlof <bb@ti.com>

---
 drivers/cpufreq/ti-cpufreq.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 804329e81eb8..ba621ce1cdda 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -16,6 +16,7 @@
 #include <linux/pm_opp.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/sys_soc.h>
 
 #define REVISION_MASK				0xF
 #define REVISION_SHIFT				28
@@ -303,6 +304,13 @@ static struct ti_cpufreq_soc_data am3517_soc_data = {
 	.quirks = TI_QUIRK_SYSCON_MAY_BE_MISSING,
 };
 
+static const struct soc_device_attribute k3_cpufreq_soc[] = {
+	{ .family = "AM62X", .revision = "SR1.0" },
+	{ .family = "AM62AX", .revision = "SR1.0" },
+	{ .family = "AM62PX", .revision = "SR1.0" },
+	{ /* sentinel */ }
+};
+
 static struct ti_cpufreq_soc_data am625_soc_data = {
 	.efuse_xlate = am625_efuse_xlate,
 	.efuse_offset = 0x0018,
@@ -384,6 +392,16 @@ static int ti_cpufreq_get_rev(struct ti_cpufreq_data *opp_data,
 	struct device *dev = opp_data->cpu_dev;
 	u32 revision;
 	int ret;
+	if (soc_device_match(k3_cpufreq_soc)) {
+		/*
+		 * Since the SR is 1.0, hard code the revision_value as
+		 * 0x1 here. This way we avoid re using the same register
+		 * that is giving us required information inside socinfo
+		 * anyway.
+		 */
+		*revision_value = 0x1;
+		goto done;
+	}
 
 	ret = regmap_read(opp_data->syscon, opp_data->soc_data->rev_offset,
 			  &revision);
@@ -406,6 +424,7 @@ static int ti_cpufreq_get_rev(struct ti_cpufreq_data *opp_data,
 
 	*revision_value = BIT((revision >> REVISION_SHIFT) & REVISION_MASK);
 
+done:
 	return 0;
 }
 

base-commit: ecc768a84f0b8e631986f9ade3118fa37852fef0
-- 
2.34.1


