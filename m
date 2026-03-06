Return-Path: <linux-pm+bounces-43748-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJqyJRyFqmkdTAEAu9opvQ
	(envelope-from <linux-pm+bounces-43748-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 08:41:16 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DF421C8FF
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 08:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD69D3002B15
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 07:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1653783D4;
	Fri,  6 Mar 2026 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="hPDrhj2k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m15580.qiye.163.com (mail-m15580.qiye.163.com [101.71.155.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24C9254B03;
	Fri,  6 Mar 2026 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772782870; cv=none; b=A6+sV2/mUMFd43Zdn94BEwLiQ+ZL9FAICwwxU/3VfeOIR59ZQnd3aRPOo4NMyO+NmTlo8xcEljHZTE7/pzjez+NotL4THP8q/P2tcrFNpkG9ERJ6Z4T+AFdK2y8SajUTJhWFYxjyWG9HC81KAJ0wo/QSupwM/PnYRGVMtcAjNWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772782870; c=relaxed/simple;
	bh=IuD/a/zMwD8BnlI+E31FdjWLc2jXo2qyFRq92ttlLAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SlSKePRiJf/qnEg8TRMDw+TeNrtMSZl/b/C2fhSses8+Ao7mpMetNpS5AtpnL77y2iGfxTaqdqLe7ePM840LNDpcLoQeqyVXD3wZjV54OKEgv0tbtnWvYLU0XUEsPs+XGLdgrouvP+pFE1XZ8/Kn+gXLvfuBZlqkSywW7ov1JI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=hPDrhj2k; arc=none smtp.client-ip=101.71.155.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 35fcf41f3;
	Fri, 6 Mar 2026 15:40:57 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/3] pmdomain: rockchip: Add pm_shaping support
Date: Fri,  6 Mar 2026 15:40:31 +0800
Message-Id: <1772782832-216867-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1772782832-216867-1-git-send-email-shawn.lin@rock-chips.com>
References: <1772782832-216867-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9cc217ab7f09cckunm7894a4e01405be4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUgZGFYfTxlKHU9MTk1DQ05WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hPDrhj2kW51e/5PoNL1s4sOjXgys/bx1LXWmjgTa2cswiRdWrvT06OyHoHm4UgvmaIo6RYUVgxOJ3sf8Z3xs11vygCCc0uSpIXEJVlWqXEVrMoFg51k50QAln3d8JwOBHtLaOBpz7gE7VNfzokWNrTsNQXA9VkVNbZ5f/R0P0vw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=HjuQ2QVWKDJpfXRvBsSPxPCbwHfU5/qVFwxvjt/vakg=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 81DF421C8FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-43748-lists,linux-pm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawn.lin@rock-chips.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rock-chips.com:dkim,rock-chips.com:email,rock-chips.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

pm_shaping is introduced for some platforms to throttle the outstanding
burst requests of each IP to prevent bus monopolization. In general, they
should be set in firmware but given that powering off pm domain will lose
the configurations, so add it support in pmdomain code.

They are defined and used the same way of pm_qos in DT but service with
different purposes.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pmdomain/rockchip/pm-domains.c | 97 ++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 490bbb1..56699aa 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -89,14 +89,18 @@ struct rockchip_pmu_info {
 #define QOS_BANDWIDTH		0x10
 #define QOS_SATURATION		0x14
 #define QOS_EXTCONTROL		0x18
+#define SHAPING_NBPKTMAX0	0x0
 
 struct rockchip_pm_domain {
 	struct generic_pm_domain genpd;
 	const struct rockchip_domain_info *info;
 	struct rockchip_pmu *pmu;
 	int num_qos;
+	int num_shaping;
 	struct regmap **qos_regmap;
+	struct regmap **shaping_regmap;
 	u32 *qos_save_regs[MAX_QOS_REGS_NUM];
+	u32 *shaping_save_regs;
 	int num_clks;
 	struct clk_bulk_data *clks;
 	struct device_node *node;
@@ -488,6 +492,28 @@ static int rockchip_pmu_restore_qos(struct rockchip_pm_domain *pd)
 	return 0;
 }
 
+static int rockchip_pmu_save_shaping(struct rockchip_pm_domain *pd)
+{
+	int i;
+
+	for (i = 0; i < pd->num_shaping; i++)
+		regmap_read(pd->shaping_regmap[i], SHAPING_NBPKTMAX0,
+			    &pd->shaping_save_regs[i]);
+
+	return 0;
+}
+
+static int rockchip_pmu_restore_shaping(struct rockchip_pm_domain *pd)
+{
+	int i;
+
+	for (i = 0; i < pd->num_shaping; i++)
+		regmap_write(pd->shaping_regmap[i], SHAPING_NBPKTMAX0,
+			     pd->shaping_save_regs[i]);
+
+	return 0;
+}
+
 static bool rockchip_pmu_domain_is_on(struct rockchip_pm_domain *pd)
 {
 	struct rockchip_pmu *pmu = pd->pmu;
@@ -650,6 +676,7 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 
 	if (!power_on) {
 		rockchip_pmu_save_qos(pd);
+		rockchip_pmu_save_shaping(pd);
 
 		/* if powering down, idle request to NIU first */
 		ret = rockchip_pmu_set_idle_request(pd, true);
@@ -668,6 +695,7 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 			goto out;
 
 		rockchip_pmu_restore_qos(pd);
+		rockchip_pmu_restore_shaping(pd);
 	}
 
 out:
@@ -767,6 +795,71 @@ static void rockchip_pd_detach_dev(struct generic_pm_domain *genpd,
 	pm_clk_destroy(dev);
 }
 
+static int rockchip_pd_of_get_shaping(struct rockchip_pm_domain *pd,
+				      struct device_node *node)
+{
+	struct rockchip_pmu *pmu = pd->pmu;
+	struct device_node *shaping_node;
+	int num_shaping = 0, num_shaping_reg = 0;
+	int error, i;
+
+	num_shaping = of_count_phandle_with_args(node, "pm_shaping", NULL);
+
+	/* Count the real available pm_shaping nodes */
+	for (i = 0; i < num_shaping; i++) {
+		shaping_node = of_parse_phandle(node, "pm_shaping", i);
+		if (shaping_node && of_device_is_available(shaping_node))
+			pd->num_shaping++;
+		of_node_put(shaping_node);
+	}
+
+	if (!pd->num_shaping)
+		return 0;
+
+	/* Allocate memory for them */
+	pd->shaping_regmap = devm_kcalloc(pmu->dev, pd->num_shaping,
+					  sizeof(*pd->shaping_regmap),
+					  GFP_KERNEL);
+	if (!pd->shaping_regmap)
+		return -ENOMEM;
+
+	pd->shaping_save_regs = devm_kmalloc(pmu->dev, sizeof(u32) *
+					     pd->num_shaping,
+					     GFP_KERNEL);
+	if (!pd->shaping_save_regs)
+		return -ENOMEM;
+
+	/* Record the real available pm_shaping nodes */
+	for (i = 0; i < num_shaping; i++) {
+		shaping_node = of_parse_phandle(node, "pm_shaping", i);
+		if (!shaping_node)
+			return -ENODEV;
+
+		if (of_device_is_available(shaping_node)) {
+			if (num_shaping_reg >= pd->num_shaping) {
+				error = -EINVAL;
+				goto err_put_node;
+			}
+
+			pd->shaping_regmap[num_shaping_reg] =
+				syscon_node_to_regmap(shaping_node);
+			if (IS_ERR(pd->shaping_regmap[num_shaping_reg])) {
+				error = -ENODEV;
+				goto err_put_node;
+			}
+
+			num_shaping_reg++;
+		}
+		of_node_put(shaping_node);
+	}
+
+	return 0;
+
+err_put_node:
+	of_node_put(shaping_node);
+	return error;
+}
+
 static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 				      struct device_node *node)
 {
@@ -874,6 +967,10 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 		}
 	}
 
+	error = rockchip_pd_of_get_shaping(pd, node);
+	if (error)
+		dev_warn(pmu->dev, "%pOFn: failed to get shaping\n", node);
+
 	if (pd->info->name)
 		pd->genpd.name = pd->info->name;
 	else
-- 
2.7.4


