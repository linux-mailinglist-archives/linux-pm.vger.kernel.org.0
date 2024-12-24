Return-Path: <linux-pm+bounces-19735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE52F9FBB68
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2024 10:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 382DC7A34AA
	for <lists+linux-pm@lfdr.de>; Tue, 24 Dec 2024 09:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D7C1B0F2D;
	Tue, 24 Dec 2024 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="AcT/noO3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m12748.qiye.163.com (mail-m12748.qiye.163.com [115.236.127.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109961A8F98;
	Tue, 24 Dec 2024 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033175; cv=none; b=V2XoNOjutGNL06bctaDLvWV9uePqOz0orlsM/IDK0JLKDuAOTVzO0/1ISGtFPph8TgCZsNEcjKHsyLhMqfdVcTFJ/UyHBRTXhcBt73B/ZguE0V96US5vZSPJkAUZsCAVkyAC1I8NQ67W+7ixInqQ78HSe2WmTOO9Po+8fJP2wPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033175; c=relaxed/simple;
	bh=MBINi5IJRThDVfFVd2ZoJWxRN15U708RoKbJSr8140Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f++m55iHwcp93nE1j4O/1tPshrZizpZSOw5uvHMGTeA/rsDE64ehQ7TrUuvf4sW26bEiajcW638zN/Wsv+GVdMBLiRvpCcrdYPuinPN5KohP/f+DFkU6vC5AJg2RBF/X+IwOUco2DfkI48QhJQ+tbxxbXXd9zTdq0+QS/5MNT6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=AcT/noO3; arc=none smtp.client-ip=115.236.127.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 6aa9032d;
	Tue, 24 Dec 2024 17:39:22 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-pm@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 2/2] soc: rockchip: power-domain: add power domain support for rk3562
Date: Tue, 24 Dec 2024 17:39:20 +0800
Message-Id: <20241224093920.3816071-2-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241224093920.3816071-1-kever.yang@rock-chips.com>
References: <20241224093920.3816071-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUkZHlZDGRlJHRhMHx0dH09WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a93f8090cd403afkunm6aa9032d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6My46Tgw6MzIOSUooF0hJECMf
	DkJPCRBVSlVKTEhOS0hISk1PS0JIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPT0pPNwY+
DKIM-Signature:a=rsa-sha256;
	b=AcT/noO30omhJSUYcdP+9+GskAYRxWwkTLmAJrQMt44QQUL/QrtHSIi0fupc03iQhfKLxi0oxg9u9NG0loj4/FFAmdlUJjc6iveCFxE3SEPrgH788VyTtG9Hvk3+I4OOxiX22XBhJzdXuAsvhuzZf/VeILYYPOFXmFlkf2qce2c=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=XleyPgZ/9CM1PcFef+OPgtrYNksdCSgQk5pDrBsSbTY=;
	h=date:mime-version:subject:message-id:from;

This driver is modified to support RK3562 SoC.
Add support to ungate clk.
Add support to shut down memory for rk3562.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v2:
- update the header after rename

 drivers/pmdomain/rockchip/pm-domains.c | 48 +++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index cb0f93800138..d05ec0a009a0 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -2,7 +2,7 @@
 /*
  * Rockchip Generic power domain support.
  *
- * Copyright (c) 2015 ROCKCHIP, Co. Ltd.
+ * Copyright (c) 2015 Rockchip Electronics Co., Ltd.
  */
 
 #include <linux/io.h>
@@ -32,6 +32,7 @@
 #include <dt-bindings/power/rk3366-power.h>
 #include <dt-bindings/power/rk3368-power.h>
 #include <dt-bindings/power/rk3399-power.h>
+#include <dt-bindings/power/rockchip,rk3562-power.h>
 #include <dt-bindings/power/rk3568-power.h>
 #include <dt-bindings/power/rockchip,rk3576-power.h>
 #include <dt-bindings/power/rk3588-power.h>
@@ -129,6 +130,20 @@ struct rockchip_pmu {
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
 #define DOMAIN_M_O_R(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, wakeup)	\
 {							\
 	.name = _name,					\
@@ -194,6 +209,9 @@ struct rockchip_pmu {
 #define DOMAIN_RK3399(name, pwr, status, req, wakeup)		\
 	DOMAIN(name, pwr, status, req, req, req, wakeup)
 
+#define DOMAIN_RK3562(name, pwr, req, g_mask, mem, wakeup)		\
+	DOMAIN_M_G_SD(name, pwr, pwr, req, req, req, g_mask, mem, wakeup, false)
+
 #define DOMAIN_RK3568(name, pwr, req, wakeup)		\
 	DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
 
@@ -1130,6 +1148,18 @@ static const struct rockchip_domain_info rk3399_pm_domains[] = {
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
@@ -1331,6 +1361,18 @@ static const struct rockchip_pmu_info rk3399_pmu = {
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
@@ -1429,6 +1471,10 @@ static const struct of_device_id rockchip_pm_domain_dt_match[] = {
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


