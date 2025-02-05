Return-Path: <linux-pm+bounces-21366-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D629A284A9
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 07:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE7347A1CFF
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 06:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07586227BBA;
	Wed,  5 Feb 2025 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fCXEvJWu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m32106.qiye.163.com (mail-m32106.qiye.163.com [220.197.32.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7CD21517A;
	Wed,  5 Feb 2025 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738738414; cv=none; b=ehmwja7kL6uy5eSeVLsJR6fHDczGZ5FDBDtaJeXUkfegYL3QvgrPtXfNdDBTNGJi3w1zx/Cy2TyHcZ/gSaTjOk1KKLN8oQkYUMzgtGnDrHMtVuly+jpTp9zfjiJDaRk/6EiITFe06L9s7jOdvse1sK/7P2ov700PGvAEwirz+Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738738414; c=relaxed/simple;
	bh=6LfC/+hxkWODSNfdbRXqrV0Uf4eVdmEha4lCh7Eyti4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Py/W9b4xGl1/q1d4r4pcumvnDaHTzZ3AxbFFifaQSxjihJO8kBAXcvrie0pS9yHz6O0NyhBPDjS7xJSk+EnQ3K/HvUlFzoOw49GljBUDnnHSo13w6tPo3cXjY7X/ekIfCA4cVTZ59FUh3un/p4CipFctII20dErgg24fyZqIopI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fCXEvJWu; arc=none smtp.client-ip=220.197.32.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id a34e5276;
	Wed, 5 Feb 2025 14:18:01 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Rob Herring <robh+dt@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	YiFeng Zhao <zyf@rock-chips.com>,
	Liang Chen <cl@rock-chips.com>,
	linux-scsi@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v7 4/7] pmdomain: rockchip: Add smc call to inform firmware
Date: Wed,  5 Feb 2025 14:15:53 +0800
Message-Id: <1738736156-119203-5-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
References: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhpLSlZDGEpDTk1DS0wfTRhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
X-HM-Tid: 0a94d4c2269109cckunma34e5276
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P006DTo6GjIQEgsVAjE2HD1N
	SCEKCR5VSlVKTEhDTEhNSUNJQ05IVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpDTkM3Bg++
DKIM-Signature:a=rsa-sha256;
	b=fCXEvJWuLsvPgrGLGT5ExfBzzHgzCPW3GBov5Ar/NMn7kPdgNthTCDi18PzbwWFjNd7qW/OoTXarDnJxLU9PRUhVJF/nn3solaxeItiETTcfCbEOzN/6UEcgosU5YZQDW+PvcKjFm7oVhodcoYAdDjIJ3o8lRvpEpCxipWkuQ4Q=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Sib3I63BwfnatprSuRo70HccUY+dH3D4nrpYCFtYS2s=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Inform firmware to keep the power domain on or off.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v7: None
Changes in v6: None
Changes in v5:
- fix a compile warning

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pmdomain/rockchip/pm-domains.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index cb0f938..49842f1 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2015 ROCKCHIP, Co. Ltd.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/err.h>
@@ -20,6 +21,7 @@
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 #include <soc/rockchip/pm_domains.h>
+#include <soc/rockchip/rockchip_sip.h>
 #include <dt-bindings/power/px30-power.h>
 #include <dt-bindings/power/rockchip,rv1126-power.h>
 #include <dt-bindings/power/rk3036-power.h>
@@ -540,6 +542,7 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
 	struct generic_pm_domain *genpd = &pd->genpd;
 	u32 pd_pwr_offset = pd->info->pwr_offset;
 	bool is_on, is_mem_on = false;
+	struct arm_smccc_res res;
 
 	if (pd->info->pwr_mask == 0)
 		return;
@@ -567,6 +570,11 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
 			genpd->name, is_on);
 		return;
 	}
+
+	/* Inform firmware to keep this pd on or off */
+	arm_smccc_smc(ROCKCHIP_SIP_SUSPEND_MODE, ROCKCHIP_SLEEP_PD_CONFIG,
+			pmu->info->pwr_offset + pd_pwr_offset,
+			pd->info->pwr_mask, on, 0, 0, 0, &res);
 }
 
 static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
-- 
2.7.4


