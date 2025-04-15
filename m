Return-Path: <linux-pm+bounces-25425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC9EA89294
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 05:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4615B173ADE
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 03:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E771021770C;
	Tue, 15 Apr 2025 03:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jwIkThgE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m3296.qiye.163.com (mail-m3296.qiye.163.com [220.197.32.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF70212FAB;
	Tue, 15 Apr 2025 03:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744688332; cv=none; b=mwc9z/eedQdf555Y/fnldlDsp7KuV0PPgx8xlBvUnUDAQBw5oC/F8Td90kD8qmNx/6OxAcUC8PfiQDXzaEQ6F2ckddGjuIXr3/t+AtqOuMWTEBYu+Mef8onIwLhbrU0+rSAvDU8T5VUpbNb5TIp4R44SHGD/LyDw3PvCEqMhBrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744688332; c=relaxed/simple;
	bh=T/+3ypIzba5dTnF0UVr993kp7hY5HHFMl/pmmhXkREI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QclmcDfwcEM2Tyu5QqQ0n2B12xw6EJSpeIN5GRKdYM8vFXSvk1EhRPBGXBsl3C/gJq+5DzHr0jTOv2Cio+/DnsgDU4jRfyOa22tC7l3D2q9ngykKXOdU30q4sWISCWXhL/dGvDLITNROcf0a/GTIYqfvp1SdvY/6bXedx8+SH7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jwIkThgE; arc=none smtp.client-ip=220.197.32.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [103.29.142.67])
	by smtp.qiye.163.com (Hmail) with ESMTP id 11e30c138;
	Tue, 15 Apr 2025 11:23:18 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-pm@vger.kernel.org,
	Detlev Casanova <detlev.casanova@collabora.com>,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Peter Geis <pgwipeout@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v4 2/2] soc: rockchip: power-domain: add power domain support for rk3562
Date: Tue, 15 Apr 2025 11:23:14 +0800
Message-Id: <20250415032314.44997-2-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250415032314.44997-1-kever.yang@rock-chips.com>
References: <20250415032314.44997-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHUJJVk9JTkNDSx5ISk5DS1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+
X-HM-Tid: 0a963779009103afkunm11e30c138
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NC46OSo6NjJDQxouETdPIxUq
	Gg0aCTxVSlVKTE9PTUNMT0tKSk5MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU5NT0k3Bg++
DKIM-Signature:a=rsa-sha256;
	b=jwIkThgEmw8bMh2cJnQw7eNERc667wZ2ihwre1kJ5vztUODhE7tJSA0mriBmtXfJ7PXffqHNuyPXQ0o/IqjmHjDowVac6Nd+o8lo25TNHp3hqnL5Kx6H8wpO4sE3d8SbCxutvlK9CSytRBLgGlpHsiypWCpQTKE11C6I0RunkaE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=GsX/OZ9Y6342jW3iRyyPEkR8Rozlsp5w9FxvAaI8OGU=;
	h=date:mime-version:subject:message-id:from;

From: Finley Xiao <finley.xiao@rock-chips.com>

This driver is modified to support RK3562 SoC.
Add support to ungate clk.
Add support to shut down memory for rk3562.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---

Changes in v4:
- rebase to v6.15-rc1
- update patch author and Collect review tag

Changes in v3: None
Changes in v2:
- update the header after rename

 drivers/pmdomain/rockchip/pm-domains.c | 48 +++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 03bcf79a461f..4cce407bb1eb 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -2,7 +2,7 @@
 /*
  * Rockchip Generic power domain support.
  *
- * Copyright (c) 2015 ROCKCHIP, Co. Ltd.
+ * Copyright (c) 2015 Rockchip Electronics Co., Ltd.
  */
 
 #include <linux/arm-smccc.h>
@@ -35,6 +35,7 @@
 #include <dt-bindings/power/rk3366-power.h>
 #include <dt-bindings/power/rk3368-power.h>
 #include <dt-bindings/power/rk3399-power.h>
+#include <dt-bindings/power/rockchip,rk3562-power.h>
 #include <dt-bindings/power/rk3568-power.h>
 #include <dt-bindings/power/rockchip,rk3576-power.h>
 #include <dt-bindings/power/rk3588-power.h>
@@ -135,6 +136,20 @@ struct rockchip_pmu {
 	.active_wakeup = wakeup,			\
 }
 
+#define DOMAIN_M_G_SD(_name, pwr, status, req, idle, ack, g_mask, mem, wakeup, keepon)	\
+{							\
+	.name = _name,					\
+	.pwr_w_mask = (pwr) << 16,			\
+	.pwr_mask = (pwr),				\
+	.status_mask = (status),			\
+	.req_w_mask = (req) << 16,			\
+	.req_mask = (req),				\
+	.idle_mask = (idle),				\
+	.ack_mask = (ack),				\
+	.clk_ungate_mask = (g_mask),			\
+	.active_wakeup = wakeup,			\
+}
+
 #define DOMAIN_M_O_R(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, wakeup, regulator)	\
 {							\
 	.name = _name,					\
@@ -201,6 +216,9 @@ struct rockchip_pmu {
 #define DOMAIN_RK3399(name, pwr, status, req, wakeup)		\
 	DOMAIN(name, pwr, status, req, req, req, wakeup)
 
+#define DOMAIN_RK3562(name, pwr, req, g_mask, mem, wakeup)		\
+	DOMAIN_M_G_SD(name, pwr, pwr, req, req, req, g_mask, mem, wakeup, false)
+
 #define DOMAIN_RK3568(name, pwr, req, wakeup)		\
 	DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
 
@@ -1197,6 +1215,18 @@ static const struct rockchip_domain_info rk3399_pm_domains[] = {
 	[RK3399_PD_SDIOAUDIO]	= DOMAIN_RK3399("sdioaudio", BIT(31), BIT(31), BIT(29), true),
 };
 
+static const struct rockchip_domain_info rk3562_pm_domains[] = {
+					     /* name           pwr     req     g_mask  mem wakeup */
+	[RK3562_PD_GPU]		= DOMAIN_RK3562("gpu",         BIT(0), BIT(1), BIT(1), 0, false),
+	[RK3562_PD_NPU]		= DOMAIN_RK3562("npu",         BIT(1), BIT(2), BIT(2), 0, false),
+	[RK3562_PD_VDPU]	= DOMAIN_RK3562("vdpu",        BIT(2), BIT(6), BIT(6), 0, false),
+	[RK3562_PD_VEPU]	= DOMAIN_RK3562("vepu",        BIT(3), BIT(7), BIT(7) | BIT(3), 0, false),
+	[RK3562_PD_RGA]		= DOMAIN_RK3562("rga",         BIT(4), BIT(5), BIT(5) | BIT(4), 0, false),
+	[RK3562_PD_VI]		= DOMAIN_RK3562("vi",          BIT(5), BIT(3), BIT(3), 0, false),
+	[RK3562_PD_VO]		= DOMAIN_RK3562("vo",  BIT(6), BIT(4), BIT(4), 16, false),
+	[RK3562_PD_PHP]		= DOMAIN_RK3562("php",         BIT(7), BIT(8), BIT(8), 0, false),
+};
+
 static const struct rockchip_domain_info rk3568_pm_domains[] = {
 	[RK3568_PD_NPU]		= DOMAIN_RK3568("npu",  BIT(1), BIT(2),  false),
 	[RK3568_PD_GPU]		= DOMAIN_RK3568("gpu",  BIT(0), BIT(1),  false),
@@ -1398,6 +1428,18 @@ static const struct rockchip_pmu_info rk3399_pmu = {
 	.domain_info = rk3399_pm_domains,
 };
 
+static const struct rockchip_pmu_info rk3562_pmu = {
+	.pwr_offset = 0x210,
+	.status_offset = 0x230,
+	.req_offset = 0x110,
+	.idle_offset = 0x128,
+	.ack_offset = 0x120,
+	.clk_ungate_offset = 0x140,
+
+	.num_domains = ARRAY_SIZE(rk3562_pm_domains),
+	.domain_info = rk3562_pm_domains,
+};
+
 static const struct rockchip_pmu_info rk3568_pmu = {
 	.pwr_offset = 0xa0,
 	.status_offset = 0x98,
@@ -1496,6 +1538,10 @@ static const struct of_device_id rockchip_pm_domain_dt_match[] = {
 		.compatible = "rockchip,rk3399-power-controller",
 		.data = (void *)&rk3399_pmu,
 	},
+	{
+		.compatible = "rockchip,rk3562-power-controller",
+		.data = (void *)&rk3562_pmu,
+	},
 	{
 		.compatible = "rockchip,rk3568-power-controller",
 		.data = (void *)&rk3568_pmu,
-- 
2.25.1


