Return-Path: <linux-pm+bounces-22569-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA19A3E48E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 20:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9040E7A9251
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 19:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725B0268C55;
	Thu, 20 Feb 2025 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KB/uRddy"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5890267704;
	Thu, 20 Feb 2025 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077921; cv=none; b=f+QB97CtbqMdn7/pjbJ3clLg7mkbZvA+tR5At+d0Lx/0cpW0+0iBVrfAI7/8FT7/2/+FuasnasYlbwFz2ixYgKtXHdQfAEVmB3kE2x5y+8K/CpPxTcL1NT1+4RMhM0HVhva156FSJMQfaZ7Lm5y9MQqNvqeeKxoLn6O7lXejuG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077921; c=relaxed/simple;
	bh=Mg2GTkVRD8YT/hNJBelVSdS3Wk0hJ4aYbAmjeZFXLYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fjD/q+ZAvkrTM5CBLlRQg59C0SRqDeVEmFR9Ck3X/mV1jMxWZC0+RcXtZUVnnFjDg8LPBR9YX4guOR3QSJ3hbVvVrVM62WB2ZU9+u6ohkg4AaJXVp6YbT/56/L0ot6icv93LfYwS0HSsh/Fc9HUaq1pct7QhSF8xPHWFHS7fEew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KB/uRddy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740077913;
	bh=Mg2GTkVRD8YT/hNJBelVSdS3Wk0hJ4aYbAmjeZFXLYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KB/uRddyxC4mRYx8uCmiDhvnNOwMYFHYSFWjglXROUgLnIDWM23ll4hS6fLrpNqKt
	 V2qHjId8kYrD/J1SxbEzSuIBsQ0Sl6FgO2ImnEO7nU16BZS7m/LymBb/qX6nLX7Ln5
	 xvlPt8vZ2lMVqeZlroA/G6z0Fz+2dmBh11NytBG+IZFb6MLWeTIMvBw4B3KT9j/QLm
	 qWyQVcYoqRPZ2zZ0y5gsV7S9qxayB/Z7F2N6tgILDD5P9HOHO9Ucavgy3SL1QBH2ev
	 3qEo2dpIJ+F04P+JaoQBAxtmyYpFEtKkSmrDlgcMGv5W87lL/MwY5C1tAv5rF/AguI
	 /YZAZVFGkHldA==
Received: from jupiter.universe (dyndsl-091-248-085-196.ewe-ip-backbone.de [91.248.85.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C0C7817E1574;
	Thu, 20 Feb 2025 19:58:33 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 131BC48003E; Thu, 20 Feb 2025 19:58:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 20 Feb 2025 19:58:10 +0100
Subject: [PATCH v6 7/8] pmdomain: rockchip: add regulator support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-rk3588-gpu-pwr-domain-regulator-v6-7-a4f9c24e5b81@kernel.org>
References: <20250220-rk3588-gpu-pwr-domain-regulator-v6-0-a4f9c24e5b81@kernel.org>
In-Reply-To: <20250220-rk3588-gpu-pwr-domain-regulator-v6-0-a4f9c24e5b81@kernel.org>
To: Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 =?utf-8?q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?= <adrian.larumbe@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Peter Geis <pgwipeout@gmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 Vignesh Raman <vignesh.raman@collabora.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13105; i=sre@kernel.org;
 h=from:subject:message-id; bh=Mg2GTkVRD8YT/hNJBelVSdS3Wk0hJ4aYbAmjeZFXLYA=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGe3e1hFpSKCOI16SXBqHcAmV1FCWWFiQL1uQ
 hiiGSwXh/MFaIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJnt3tYAAoJENju1/PI
 O/qa3SAP+wcBV23j/bXt1J9SqD+Xc/1mwG85HakJqbQ0SBTsTmnRkfjlNNeCsYI+9J1ABbA2vcj
 ia0OgYp233KZANC7XwIwH/s9IbKTR00oUFGP9w6EtIHHIZHDInNSV94fGqSL2QMDdSnI8XKJj7X
 i1fPeRC5K7Y3Wp0N3CC6MX7ihQUEgviaNjE4bZmXfeenb/59ydjazwdfvCy0Udd5Uoq2JppSX8I
 +yXkc+CHoXfCRIIlEj4U9/sDiGiINmwc2N1LKBrnITbUwHSEc7PhSCOb/b+dUCGkFnLpm12Nv8b
 Y+srM0XqTgSBInhoK4PStRvotKaeS8a2gZvGUnxd8deOY+9hGgwd7A5GJifKeO6FJsR5paqPcee
 nlGuy8SMMAHmiXqOB1WsYveDoR6fgPU9jhT54bGYAMEoVibFM7f+0pSW97GGv2UeM1YOlUsaCmi
 LyUuW/SNa72p1/qeySap8mNA9UWnayC6T8745kxp5oVGNMcsCkFJ7G2iysCMOI4J9kqLxr+iAmr
 gHzFdErL3XUhUj22AWkUKat/bKwSq5g9CHxDrkJQgmjivfRs1U6dgTuGRGKMRsf9R4691nUHkAi
 FfQU3tnfhN2zNtcBEekG605lifXTo9CnP4S1kKlh1dWsLUTN280R8Fce3JZ0wzR4RU7UkRxUgCL
 FKJ3O1xbiZOAkgHOp/wQ1BA==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Some power domains require extra voltages to be applied. For example
trying to enable the GPU power domain on RK3588 fails when the SoC
does not have VDD GPU enabled. The same is expected to happen for
the NPU, which also has a dedicated supply line.

We get the regulator using devm_of_regulator_get(), so a missing
dependency in the devicetree is handled gracefully by printing a warning
and creating a dummy regulator. This is necessary, since existing DTs do
not have the regulator described. They might still work if the regulator
is marked as always-on. It is also working if the regulator is enabled
at boot time and the GPU driver is probed before the kernel disables
unused regulators.

The regulator itself is not acquired at driver probe time, since that
creates an unsolvable circular dependency. The power domain driver must
be probed early, since SoC peripherals need it. Regulators on the other
hand depend on SoC peripherals like SPI, I2C or GPIO. MediaTek does not
run into this, since they have two power domain drivers.

Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 113 +++++++++++++++++++++++----------
 1 file changed, 79 insertions(+), 34 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index ac3f6e2080d1c3aa3d0b6fa60949c22a7d256bde..9f6640063fda623ad985283c8c637581247764f0 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -18,6 +18,7 @@
 #include <linux/of_clk.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/mfd/syscon.h>
 #include <soc/rockchip/pm_domains.h>
 #include <dt-bindings/power/px30-power.h>
@@ -44,6 +45,7 @@ struct rockchip_domain_info {
 	int idle_mask;
 	int ack_mask;
 	bool active_wakeup;
+	bool need_regulator;
 	int pwr_w_mask;
 	int req_w_mask;
 	int clk_ungate_mask;
@@ -92,6 +94,8 @@ struct rockchip_pm_domain {
 	u32 *qos_save_regs[MAX_QOS_REGS_NUM];
 	int num_clks;
 	struct clk_bulk_data *clks;
+	struct device_node *node;
+	struct regulator *supply;
 };
 
 struct rockchip_pmu {
@@ -129,7 +133,7 @@ struct rockchip_pmu {
 	.active_wakeup = wakeup,			\
 }
 
-#define DOMAIN_M_O_R(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, wakeup)	\
+#define DOMAIN_M_O_R(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, wakeup, regulator)	\
 {							\
 	.name = _name,					\
 	.pwr_offset = p_offset,				\
@@ -145,6 +149,7 @@ struct rockchip_pmu {
 	.idle_mask = (idle),				\
 	.ack_mask = (ack),				\
 	.active_wakeup = wakeup,			\
+	.need_regulator = regulator,			\
 }
 
 #define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, g_mask, wakeup)	\
@@ -303,8 +308,8 @@ void rockchip_pmu_unblock(void)
 }
 EXPORT_SYMBOL_GPL(rockchip_pmu_unblock);
 
-#define DOMAIN_RK3588(name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, wakeup)	\
-	DOMAIN_M_O_R(name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, idle, wakeup)
+#define DOMAIN_RK3588(name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, wakeup, regulator)	\
+	DOMAIN_M_O_R(name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, idle, wakeup, regulator)
 
 static bool rockchip_pmu_domain_is_idle(struct rockchip_pm_domain *pd)
 {
@@ -622,18 +627,57 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 	return ret;
 }
 
+static int rockchip_pd_regulator_disable(struct rockchip_pm_domain *pd)
+{
+	return IS_ERR_OR_NULL(pd->supply) ? 0 : regulator_disable(pd->supply);
+}
+
+static int rockchip_pd_regulator_enable(struct rockchip_pm_domain *pd)
+{
+	struct rockchip_pmu *pmu = pd->pmu;
+
+	if (!pd->info->need_regulator)
+		return 0;
+
+	if (IS_ERR_OR_NULL(pd->supply)) {
+		pd->supply = devm_of_regulator_get(pmu->dev, pd->node, "domain");
+
+		if (IS_ERR(pd->supply))
+			return PTR_ERR(pd->supply);
+	}
+
+	return regulator_enable(pd->supply);
+}
+
 static int rockchip_pd_power_on(struct generic_pm_domain *domain)
 {
 	struct rockchip_pm_domain *pd = to_rockchip_pd(domain);
+	int ret;
+
+	ret = rockchip_pd_regulator_enable(pd);
+	if (ret) {
+		dev_err(pd->pmu->dev, "Failed to enable supply: %d\n", ret);
+		return ret;
+	}
 
-	return rockchip_pd_power(pd, true);
+	ret = rockchip_pd_power(pd, true);
+	if (ret)
+		rockchip_pd_regulator_disable(pd);
+
+	return ret;
 }
 
 static int rockchip_pd_power_off(struct generic_pm_domain *domain)
 {
 	struct rockchip_pm_domain *pd = to_rockchip_pd(domain);
+	int ret;
 
-	return rockchip_pd_power(pd, false);
+	ret = rockchip_pd_power(pd, false);
+	if (ret)
+		return ret;
+
+	rockchip_pd_regulator_disable(pd);
+	return ret;
 }
 
 static int rockchip_pd_attach_dev(struct generic_pm_domain *genpd,
@@ -714,6 +758,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 
 	pd->info = pd_info;
 	pd->pmu = pmu;
+	pd->node = node;
 
 	pd->num_clks = of_clk_get_parent_count(node);
 	if (pd->num_clks > 0) {
@@ -1177,35 +1222,35 @@ static const struct rockchip_domain_info rk3576_pm_domains[] = {
 };
 
 static const struct rockchip_domain_info rk3588_pm_domains[] = {
-	[RK3588_PD_GPU]		= DOMAIN_RK3588("gpu",     0x0, BIT(0),  0,       0x0, 0,       BIT(1),  0x0, BIT(0),  BIT(0),  false),
-	[RK3588_PD_NPU]		= DOMAIN_RK3588("npu",     0x0, BIT(1),  BIT(1),  0x0, 0,       0,       0x0, 0,       0,       false),
-	[RK3588_PD_VCODEC]	= DOMAIN_RK3588("vcodec",  0x0, BIT(2),  BIT(2),  0x0, 0,       0,       0x0, 0,       0,       false),
-	[RK3588_PD_NPUTOP]	= DOMAIN_RK3588("nputop",  0x0, BIT(3),  0,       0x0, BIT(11), BIT(2),  0x0, BIT(1),  BIT(1),  false),
-	[RK3588_PD_NPU1]	= DOMAIN_RK3588("npu1",    0x0, BIT(4),  0,       0x0, BIT(12), BIT(3),  0x0, BIT(2),  BIT(2),  false),
-	[RK3588_PD_NPU2]	= DOMAIN_RK3588("npu2",    0x0, BIT(5),  0,       0x0, BIT(13), BIT(4),  0x0, BIT(3),  BIT(3),  false),
-	[RK3588_PD_VENC0]	= DOMAIN_RK3588("venc0",   0x0, BIT(6),  0,       0x0, BIT(14), BIT(5),  0x0, BIT(4),  BIT(4),  false),
-	[RK3588_PD_VENC1]	= DOMAIN_RK3588("venc1",   0x0, BIT(7),  0,       0x0, BIT(15), BIT(6),  0x0, BIT(5),  BIT(5),  false),
-	[RK3588_PD_RKVDEC0]	= DOMAIN_RK3588("rkvdec0", 0x0, BIT(8),  0,       0x0, BIT(16), BIT(7),  0x0, BIT(6),  BIT(6),  false),
-	[RK3588_PD_RKVDEC1]	= DOMAIN_RK3588("rkvdec1", 0x0, BIT(9),  0,       0x0, BIT(17), BIT(8),  0x0, BIT(7),  BIT(7),  false),
-	[RK3588_PD_VDPU]	= DOMAIN_RK3588("vdpu",    0x0, BIT(10), 0,       0x0, BIT(18), BIT(9),  0x0, BIT(8),  BIT(8),  false),
-	[RK3588_PD_RGA30]	= DOMAIN_RK3588("rga30",   0x0, BIT(11), 0,       0x0, BIT(19), BIT(10), 0x0, 0,       0,       false),
-	[RK3588_PD_AV1]		= DOMAIN_RK3588("av1",     0x0, BIT(12), 0,       0x0, BIT(20), BIT(11), 0x0, BIT(9),  BIT(9),  false),
-	[RK3588_PD_VI]		= DOMAIN_RK3588("vi",      0x0, BIT(13), 0,       0x0, BIT(21), BIT(12), 0x0, BIT(10), BIT(10), false),
-	[RK3588_PD_FEC]		= DOMAIN_RK3588("fec",     0x0, BIT(14), 0,       0x0, BIT(22), BIT(13), 0x0, 0,       0,       false),
-	[RK3588_PD_ISP1]	= DOMAIN_RK3588("isp1",    0x0, BIT(15), 0,       0x0, BIT(23), BIT(14), 0x0, BIT(11), BIT(11), false),
-	[RK3588_PD_RGA31]	= DOMAIN_RK3588("rga31",   0x4, BIT(0),  0,       0x0, BIT(24), BIT(15), 0x0, BIT(12), BIT(12), false),
-	[RK3588_PD_VOP]		= DOMAIN_RK3588("vop",     0x4, BIT(1),  0,       0x0, BIT(25), BIT(16), 0x0, BIT(13) | BIT(14), BIT(13) | BIT(14), false),
-	[RK3588_PD_VO0]		= DOMAIN_RK3588("vo0",     0x4, BIT(2),  0,       0x0, BIT(26), BIT(17), 0x0, BIT(15), BIT(15), false),
-	[RK3588_PD_VO1]		= DOMAIN_RK3588("vo1",     0x4, BIT(3),  0,       0x0, BIT(27), BIT(18), 0x4, BIT(0),  BIT(16), false),
-	[RK3588_PD_AUDIO]	= DOMAIN_RK3588("audio",   0x4, BIT(4),  0,       0x0, BIT(28), BIT(19), 0x4, BIT(1),  BIT(17), false),
-	[RK3588_PD_PHP]		= DOMAIN_RK3588("php",     0x4, BIT(5),  0,       0x0, BIT(29), BIT(20), 0x4, BIT(5),  BIT(21), false),
-	[RK3588_PD_GMAC]	= DOMAIN_RK3588("gmac",    0x4, BIT(6),  0,       0x0, BIT(30), BIT(21), 0x0, 0,       0,       false),
-	[RK3588_PD_PCIE]	= DOMAIN_RK3588("pcie",    0x4, BIT(7),  0,       0x0, BIT(31), BIT(22), 0x0, 0,       0,       true),
-	[RK3588_PD_NVM]		= DOMAIN_RK3588("nvm",     0x4, BIT(8),  BIT(24), 0x4, 0,       0,       0x4, BIT(2),  BIT(18), false),
-	[RK3588_PD_NVM0]	= DOMAIN_RK3588("nvm0",    0x4, BIT(9),  0,       0x4, BIT(1),  BIT(23), 0x0, 0,       0,       false),
-	[RK3588_PD_SDIO]	= DOMAIN_RK3588("sdio",    0x4, BIT(10), 0,       0x4, BIT(2),  BIT(24), 0x4, BIT(3),  BIT(19), false),
-	[RK3588_PD_USB]		= DOMAIN_RK3588("usb",     0x4, BIT(11), 0,       0x4, BIT(3),  BIT(25), 0x4, BIT(4),  BIT(20), true),
-	[RK3588_PD_SDMMC]	= DOMAIN_RK3588("sdmmc",   0x4, BIT(13), 0,       0x4, BIT(5),  BIT(26), 0x0, 0,       0,       false),
+	[RK3588_PD_GPU]		= DOMAIN_RK3588("gpu",     0x0, BIT(0),  0,       0x0, 0,       BIT(1),  0x0, BIT(0),  BIT(0),  false, true),
+	[RK3588_PD_NPU]		= DOMAIN_RK3588("npu",     0x0, BIT(1),  BIT(1),  0x0, 0,       0,       0x0, 0,       0,       false, true),
+	[RK3588_PD_VCODEC]	= DOMAIN_RK3588("vcodec",  0x0, BIT(2),  BIT(2),  0x0, 0,       0,       0x0, 0,       0,       false, false),
+	[RK3588_PD_NPUTOP]	= DOMAIN_RK3588("nputop",  0x0, BIT(3),  0,       0x0, BIT(11), BIT(2),  0x0, BIT(1),  BIT(1),  false, false),
+	[RK3588_PD_NPU1]	= DOMAIN_RK3588("npu1",    0x0, BIT(4),  0,       0x0, BIT(12), BIT(3),  0x0, BIT(2),  BIT(2),  false, false),
+	[RK3588_PD_NPU2]	= DOMAIN_RK3588("npu2",    0x0, BIT(5),  0,       0x0, BIT(13), BIT(4),  0x0, BIT(3),  BIT(3),  false, false),
+	[RK3588_PD_VENC0]	= DOMAIN_RK3588("venc0",   0x0, BIT(6),  0,       0x0, BIT(14), BIT(5),  0x0, BIT(4),  BIT(4),  false, false),
+	[RK3588_PD_VENC1]	= DOMAIN_RK3588("venc1",   0x0, BIT(7),  0,       0x0, BIT(15), BIT(6),  0x0, BIT(5),  BIT(5),  false, false),
+	[RK3588_PD_RKVDEC0]	= DOMAIN_RK3588("rkvdec0", 0x0, BIT(8),  0,       0x0, BIT(16), BIT(7),  0x0, BIT(6),  BIT(6),  false, false),
+	[RK3588_PD_RKVDEC1]	= DOMAIN_RK3588("rkvdec1", 0x0, BIT(9),  0,       0x0, BIT(17), BIT(8),  0x0, BIT(7),  BIT(7),  false, false),
+	[RK3588_PD_VDPU]	= DOMAIN_RK3588("vdpu",    0x0, BIT(10), 0,       0x0, BIT(18), BIT(9),  0x0, BIT(8),  BIT(8),  false, false),
+	[RK3588_PD_RGA30]	= DOMAIN_RK3588("rga30",   0x0, BIT(11), 0,       0x0, BIT(19), BIT(10), 0x0, 0,       0,       false, false),
+	[RK3588_PD_AV1]		= DOMAIN_RK3588("av1",     0x0, BIT(12), 0,       0x0, BIT(20), BIT(11), 0x0, BIT(9),  BIT(9),  false, false),
+	[RK3588_PD_VI]		= DOMAIN_RK3588("vi",      0x0, BIT(13), 0,       0x0, BIT(21), BIT(12), 0x0, BIT(10), BIT(10), false, false),
+	[RK3588_PD_FEC]		= DOMAIN_RK3588("fec",     0x0, BIT(14), 0,       0x0, BIT(22), BIT(13), 0x0, 0,       0,       false, false),
+	[RK3588_PD_ISP1]	= DOMAIN_RK3588("isp1",    0x0, BIT(15), 0,       0x0, BIT(23), BIT(14), 0x0, BIT(11), BIT(11), false, false),
+	[RK3588_PD_RGA31]	= DOMAIN_RK3588("rga31",   0x4, BIT(0),  0,       0x0, BIT(24), BIT(15), 0x0, BIT(12), BIT(12), false, false),
+	[RK3588_PD_VOP]		= DOMAIN_RK3588("vop",     0x4, BIT(1),  0,       0x0, BIT(25), BIT(16), 0x0, BIT(13) | BIT(14), BIT(13) | BIT(14), false, false),
+	[RK3588_PD_VO0]		= DOMAIN_RK3588("vo0",     0x4, BIT(2),  0,       0x0, BIT(26), BIT(17), 0x0, BIT(15), BIT(15), false, false),
+	[RK3588_PD_VO1]		= DOMAIN_RK3588("vo1",     0x4, BIT(3),  0,       0x0, BIT(27), BIT(18), 0x4, BIT(0),  BIT(16), false, false),
+	[RK3588_PD_AUDIO]	= DOMAIN_RK3588("audio",   0x4, BIT(4),  0,       0x0, BIT(28), BIT(19), 0x4, BIT(1),  BIT(17), false, false),
+	[RK3588_PD_PHP]		= DOMAIN_RK3588("php",     0x4, BIT(5),  0,       0x0, BIT(29), BIT(20), 0x4, BIT(5),  BIT(21), false, false),
+	[RK3588_PD_GMAC]	= DOMAIN_RK3588("gmac",    0x4, BIT(6),  0,       0x0, BIT(30), BIT(21), 0x0, 0,       0,       false, false),
+	[RK3588_PD_PCIE]	= DOMAIN_RK3588("pcie",    0x4, BIT(7),  0,       0x0, BIT(31), BIT(22), 0x0, 0,       0,       true, false),
+	[RK3588_PD_NVM]		= DOMAIN_RK3588("nvm",     0x4, BIT(8),  BIT(24), 0x4, 0,       0,       0x4, BIT(2),  BIT(18), false, false),
+	[RK3588_PD_NVM0]	= DOMAIN_RK3588("nvm0",    0x4, BIT(9),  0,       0x4, BIT(1),  BIT(23), 0x0, 0,       0,       false, false),
+	[RK3588_PD_SDIO]	= DOMAIN_RK3588("sdio",    0x4, BIT(10), 0,       0x4, BIT(2),  BIT(24), 0x4, BIT(3),  BIT(19), false, false),
+	[RK3588_PD_USB]		= DOMAIN_RK3588("usb",     0x4, BIT(11), 0,       0x4, BIT(3),  BIT(25), 0x4, BIT(4),  BIT(20), true, false),
+	[RK3588_PD_SDMMC]	= DOMAIN_RK3588("sdmmc",   0x4, BIT(13), 0,       0x4, BIT(5),  BIT(26), 0x0, 0,       0,       false, false),
 };
 
 static const struct rockchip_pmu_info px30_pmu = {

-- 
2.47.2


