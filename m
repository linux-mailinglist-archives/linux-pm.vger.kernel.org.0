Return-Path: <linux-pm+bounces-16922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A9A9BADB5
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 09:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E139A1F22707
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 08:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431CA19ADA2;
	Mon,  4 Nov 2024 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="KOc/V3TO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m254101.xmail.ntesmail.com (mail-m254101.xmail.ntesmail.com [103.129.254.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8691018C038;
	Mon,  4 Nov 2024 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.129.254.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707753; cv=none; b=NrFLruIkS+dfMvoJ4p4/GIgP9kBqLftdh8n3HE7a+ZfzaqzHCocZJGJlDNmRwQhyrPGpXm+Eo/kxDOBbNKTt+Npo8X1aazjYZZ1e9qkUonW3VpYRpWybfpi8aDrBMNxjlLaKoav1u63Xi0svXS4rAGtlIKNNtBl+qv/5Ny9yFWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707753; c=relaxed/simple;
	bh=lfnrQPol+C2Z7HuPeo25dXqYb+63uR1PrYZQiUu0njo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qEDP0F8yAOmwsHngeIBiH/IhaUp2Y/vNrnMTXnl+AVdrClUgsqveS5hcfYXJxWDo3qfJeG4hH9nuu5p+zgymcLOY/wqwah2KrqEiLhpUV1/MZHHXcus9383QgOPXhxjSaoILHn4iJylI3XMqRSAF7ifc1r9Ns68L3JEuxWnNaHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=KOc/V3TO; arc=none smtp.client-ip=103.129.254.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1b5f869f;
	Mon, 4 Nov 2024 15:33:40 +0800 (GMT+08:00)
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
Subject: [PATCH v4 5/7] pmdomain: rockchip: Add smc call to inform firmware
Date: Mon,  4 Nov 2024 15:31:59 +0800
Message-Id: <1730705521-23081-6-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1730705521-23081-1-git-send-email-shawn.lin@rock-chips.com>
References: <1730705521-23081-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGktJGVZJT0hMS0IfSx1JH0tWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a92f617feb709cckunm1b5f869f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nxw6Vgw4PzIqKDpNDiM8NQ04
	KgMwCwJVSlVKTEhLTEtOTUlJSE9PVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpPTEo3Bg++
DKIM-Signature:a=rsa-sha256;
	b=KOc/V3TOi9CZ+bjGn0XBxZzJxc1ucrWpUkLu9Mto0M5wPnRkMSSVRTi+r+4YrC75jwQAy6JCr0KHm7eTX7ADwMMdsZja1RtfkDAYJnCDDSCN0mCrk6hnh0K57xKUAj7XfnNGO3o2hU0vZUP7xggLECJhVAthb43p1aovPmW919A=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=5bC3QYHOjJ3/vZ0+0nCR2up4r8RzKDUexJly/sw7L6Y=;
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

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pmdomain/rockchip/pm-domains.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index cb0f938..8b5dd7f 100644
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
@@ -567,6 +569,11 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
 			genpd->name, is_on);
 		return;
 	}
+
+	/* Inform firmware to keep this pd on or off */
+	arm_smccc_smc(ROCKCHIP_SIP_SUSPEND_MODE, ROCKCHIP_SLEEP_PD_CONFIG,
+			pmu->info->pwr_offset + pd_pwr_offset,
+			pd->info->pwr_mask, on, 0, 0, 0, NULL);
 }
 
 static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
-- 
2.7.4


