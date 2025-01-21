Return-Path: <linux-pm+bounces-20731-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C503A17623
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 04:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE171686C7
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 03:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB60154BF0;
	Tue, 21 Jan 2025 03:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="aVBEifnJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m3268.qiye.163.com (mail-m3268.qiye.163.com [220.197.32.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F294689;
	Tue, 21 Jan 2025 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737428817; cv=none; b=Md1X9CVtEF4tLu5RNEzT785sodMdvw6QYVd4bf7nyoCVjIMJUIHm74/jPTGADEoKNvpjPcqkstgk0exCxIRJNKxek0KZKN4dSwR8S/hnS1Dt3S/vbnFwjWH5SwClcSL/DOsw/i9k4t9hxy7YsvJd5NIKsgoaD6rbSQKIPv4OsdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737428817; c=relaxed/simple;
	bh=ZB7BhjR1VPn48isHaQ/N0saNPUipY2ULM+EwqIKKZUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QOUX9RS9wgS4CdZl+PrrGKmJpjIV9/QLBmcjxSvXiuBgp1ZnvgIFPXi28I/riXzuKb2KrO2fXLIHwGS5TV3ElqVJQdHlI8Olexc/pYfCKyB8JnBvVGK8qJgJ+dWbCEiS6I9lSM9oQ+xyjdXhBooKIqvVlHyE5VLlLF/eogRTx0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=aVBEifnJ; arc=none smtp.client-ip=220.197.32.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 93fdcf61;
	Tue, 21 Jan 2025 11:01:42 +0800 (GMT+08:00)
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
Subject: [PATCH v6 4/7] pmdomain: rockchip: Add smc call to inform firmware
Date: Tue, 21 Jan 2025 11:00:24 +0800
Message-Id: <1737428427-32393-5-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1737428427-32393-1-git-send-email-shawn.lin@rock-chips.com>
References: <1737428427-32393-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUwdT1ZCHUlPGBlLS0lCTUpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCS0
	NVSktLVUpCWQY+
X-HM-Tid: 0a9486cf092409cckunm93fdcf61
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTo6Mjo4ATIPAjUdDgsQEhlP
	SxYKCjRVSlVKTEhMT0lDTktPSEpJVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpDSEw3Bg++
DKIM-Signature:a=rsa-sha256;
	b=aVBEifnJxZDglXZaFJWi9pirQNHZN2+cgE5G3GnNsZkCP59A91j3EVZiysRkhqsKRE3Qsa5dsIAL7DmPxhXkzTkvsuw9Mer2WWlJ/nr/qnH99zbFYqlfoy2AOHYo6G4U6jx0qbzeo8XeIh0jMX1mAmROtCIZYM7quX80fS94Z78=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=BPKn6QDK8iIrwIO7tK/qjYEl5MJTaeG8SozaG5vr8WI=;
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


