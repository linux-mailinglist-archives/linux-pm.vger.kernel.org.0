Return-Path: <linux-pm+bounces-14931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902BF989E68
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 11:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C805B20392
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 09:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C3D1885B9;
	Mon, 30 Sep 2024 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bu8KFRKC"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FD8186E39;
	Mon, 30 Sep 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688771; cv=none; b=m1NEJTO/OReNO5TsDGEXHxJKhWrh0SKMZQZGrf23GXRWXAXPAsISY2MC2TGk9nAjma2SVQCLel2pCzt+pGiPUUo6F5BPpNW+fgu8rv6x/iEP2Msu4O7HPmu0wo15vpy1aLG/nyMumyZ5T+EttuFDg1t8t/mPO521VxncHjuyQTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688771; c=relaxed/simple;
	bh=hKcPQZ9QKW/4Ct9ay+psYCygKDSfJ1VBcEhEWjpP3ZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=d4rGZKbzqBphbeAcikCdgtI+kob+YHiDuFayE+t0QB9+vDxMNG8AOL/PusUnbLdEqpb/x0uaTZ3p0jcM4emKapTNtLccY6BjUP0OFBCA0+5fVLwMo37imGGpYbTAbGagY75UTbaBzRvopu8YMKQVNEgsk1rQjf3cvtmMrW1cy10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bu8KFRKC; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48U9Wiht112873;
	Mon, 30 Sep 2024 04:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727688764;
	bh=A669c3bVbFMDVyx44DfUvaicChB8YijXim3cmihVDGs=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=bu8KFRKCV0yyx9Fp9hi4U/Bp+BfUndbrCDkeqHdg8+mxofQz5R8bNHMnfIRnDZ994
	 NEhaAnxjgr1DyV4+qO163J0/JVI2X3UOZfXeN3xNgnO8QoxHsi3gdq2fXL11d+efkG
	 rlRq+bqCyogaX92qGaR+3UG32ViNF1gjOzx88XsA=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48U9Wid6081887
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Sep 2024 04:32:44 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 30
 Sep 2024 04:32:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 30 Sep 2024 04:32:43 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48U9WcvA021643;
	Mon, 30 Sep 2024 04:32:41 -0500
From: Dhruva Gole <d-gole@ti.com>
Date: Mon, 30 Sep 2024 15:02:09 +0530
Subject: [PATCH 1/2] cpufreq: ti-cpufreq: Allow backward compatibility for
 efuse syscon
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240930-b4-ti-cpufreq-am62-quirk-v1-1-b5e04f0f899b@ti.com>
References: <20240930-b4-ti-cpufreq-am62-quirk-v1-0-b5e04f0f899b@ti.com>
In-Reply-To: <20240930-b4-ti-cpufreq-am62-quirk-v1-0-b5e04f0f899b@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bryan Brattlof
	<bb@ti.com>, Nishanth Menon <nm@ti.com>,
        Andrew Davis <afd@ti.com>, Dhruva
 Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727688758; l=1968;
 i=d-gole@ti.com; s=20240919; h=from:subject:message-id;
 bh=hKcPQZ9QKW/4Ct9ay+psYCygKDSfJ1VBcEhEWjpP3ZM=;
 b=1OBx1oHuSJtuOsD4aPoUrMyK5PptXJOecrzebu3uR4exev77TZElFDVncPBV1rRTzBdCDV8Yx
 mjm5yalLCYTC51kOvF4rV92JeBoXlpeFpUmvAs0V1p3NlH6CfelFjZE
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The AM625 syscon for efuse was being taken earlier from the wkup_conf node
where the entire wkup_conf was marked as "syscon". This is wrong and will
be fixed in the devicetree. However, whenever that does happen will end up
breaking this driver for that device because of the change in efuse offset.

Hence, to avoid breaking any sort of backward compatibility of devicetrees
use a quirk to distinguish and accordingly use 0x0 offset for the new
syscon node.

Suggested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index ba621ce1cdda694c98867422dbb7f10c0df2afef..7014cebb41e3490cadd14834e0c3e057419f2abb 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -93,6 +93,8 @@ struct ti_cpufreq_soc_data {
 	bool multi_regulator;
 /* Backward compatibility hack: Might have missing syscon */
 #define TI_QUIRK_SYSCON_MAY_BE_MISSING	0x1
+/* Backward compatibility hack: new syscon size is 1 register wide */
+#define TI_QUIRK_SYSCON_IS_SINGLE_REG	0x2
 	u8 quirks;
 };
 
@@ -318,6 +320,7 @@ static struct ti_cpufreq_soc_data am625_soc_data = {
 	.efuse_shift = 0x6,
 	.rev_offset = 0x0014,
 	.multi_regulator = false,
+	.quirks = TI_QUIRK_SYSCON_IS_SINGLE_REG,
 };
 
 static struct ti_cpufreq_soc_data am62a7_soc_data = {
@@ -354,6 +357,10 @@ static int ti_cpufreq_get_efuse(struct ti_cpufreq_data *opp_data,
 
 	ret = regmap_read(opp_data->syscon, opp_data->soc_data->efuse_offset,
 			  &efuse);
+
+	if (opp_data->soc_data->quirks & TI_QUIRK_SYSCON_IS_SINGLE_REG && ret == -EIO)
+		ret = regmap_read(opp_data->syscon, 0x0, &efuse);
+
 	if (opp_data->soc_data->quirks & TI_QUIRK_SYSCON_MAY_BE_MISSING && ret == -EIO) {
 		/* not a syscon register! */
 		void __iomem *regs = ioremap(OMAP3_SYSCON_BASE +

-- 
2.34.1


