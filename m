Return-Path: <linux-pm+bounces-36259-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80580BE3C59
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 15:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931231A66D8E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 13:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB6233CEA8;
	Thu, 16 Oct 2025 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="TbM0Hawm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m1973173.qiye.163.com (mail-m1973173.qiye.163.com [220.197.31.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D1033A00E;
	Thu, 16 Oct 2025 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622121; cv=none; b=SRxLxENrxpk3D78YiaEbY9VtMZXrvbT5cbhLV6H+PGDpsVvNybTXdlPQT/49YzrfTP58/Sd6+gcx+sY4u+uzyYZxBONVSMlqELyeYXSgt6KoAPA99wa6mZoiF/7/iPi91NEIDUEdg69jS/e+TGx/twRWJ8Y4oZoEUWGMJc9qhuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622121; c=relaxed/simple;
	bh=aR1eaDNIrPulkBL1DXPC20FxSUB27nGElMJ7szUod6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+nBIFqWrp5P7VGzSifJ2uivwYJaCMEVijb5v06Qezmu/rPlIzu277G89aANurXAC9Te+p54BhMILY9ZVWvmRUO/epuW9BraZlPUCSmJLP06PXzZ7TS8gE4ZnE/KkSeANlC5ZLAlUj7RoZhxO8Eey6Z6vSyverRNV52XMJoVMU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=TbM0Hawm; arc=none smtp.client-ip=220.197.31.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from xf.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26283fe3a;
	Thu, 16 Oct 2025 21:41:48 +0800 (GMT+08:00)
From: Finley Xiao <finley.xiao@rock-chips.com>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	finley.xiao@rock-chips.com,
	zhangqing@rock-chips.com,
	sugar.zhang@rock-chips.com,
	huangtao@rock-chips.com
Subject: [PATCH v1 2/2] pmdomain: rockchip: Add support for RV1126B
Date: Thu, 16 Oct 2025 21:41:03 +0800
Message-ID: <20251016134103.294636-3-finley.xiao@rock-chips.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016134103.294636-1-finley.xiao@rock-chips.com>
References: <20251016134103.294636-1-finley.xiao@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99ed415f1503a9kunm0a0c6b9d2865e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU0ZSlZMH0sZQkhLGk8eQh5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=TbM0Hawm5HzQvXbp+O5LAOEpKQ+D84rvrZ+39BZ+GY4SfM1sMQWUELFfVF6Sblh+ihxiTzaxDWKTEQq5/BB+hGHv/x6kB6KQDqDPLlTrG8XAghhcIED031ObiBE2h9KQTrlIulc6wUzu7rSbDYsRtGT57mGFuNN6jeosKoDIqEA=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=DTh7gctk5AI3bDTEHZSUWiFdhA+fv7NuK/ICIUrV96g=;
	h=date:mime-version:subject:message-id:from;

Add configuration and power domains for RV1126 SoC.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 1955c6d453e4..49a01261d13d 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -25,6 +25,7 @@
 #include <soc/rockchip/rockchip_sip.h>
 #include <dt-bindings/power/px30-power.h>
 #include <dt-bindings/power/rockchip,rv1126-power.h>
+#include <dt-bindings/power/rockchip,rv1126b-power.h>
 #include <dt-bindings/power/rk3036-power.h>
 #include <dt-bindings/power/rk3066-power.h>
 #include <dt-bindings/power/rk3128-power.h>
@@ -137,6 +138,20 @@ struct rockchip_pmu {
 	.active_wakeup = wakeup,			\
 }
 
+#define DOMAIN_M_G(_name, pwr, status, req, idle, ack, g_mask, wakeup, keepon)	\
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
 #define DOMAIN_M_G_SD(_name, pwr, status, req, idle, ack, g_mask, mem, wakeup, keepon)	\
 {							\
 	.name = _name,					\
@@ -205,6 +220,9 @@ struct rockchip_pmu {
 #define DOMAIN_RV1126(name, pwr, req, idle, wakeup)		\
 	DOMAIN_M(name, pwr, pwr, req, idle, idle, wakeup)
 
+#define DOMAIN_RV1126B(name, pwr, req, wakeup)			\
+	DOMAIN_M_G(name, pwr, pwr, req, req, req, req, wakeup, true)
+
 #define DOMAIN_RK3288(name, pwr, status, req, wakeup)		\
 	DOMAIN(name, pwr, status, req, req, (req) << 16, wakeup)
 
@@ -1104,6 +1122,13 @@ static const struct rockchip_domain_info rv1126_pm_domains[] = {
 	[RV1126_PD_USB]		= DOMAIN_RV1126("usb", BIT(9), BIT(15), BIT(15),  false),
 };
 
+static const struct rockchip_domain_info rv1126b_pm_domains[] = {
+					      /* name    pwr     req      wakeup */
+	[RV1126B_PD_NPU]	= DOMAIN_RV1126B("npu",  BIT(0), BIT(8),  false),
+	[RV1126B_PD_VDO]	= DOMAIN_RV1126B("vdo",  BIT(1), BIT(9),  false),
+	[RV1126B_PD_AISP]	= DOMAIN_RV1126B("aisp", BIT(2), BIT(10), false),
+};
+
 static const struct rockchip_domain_info rk3036_pm_domains[] = {
 	[RK3036_PD_MSCH]	= DOMAIN_RK3036("msch", BIT(14), BIT(23), BIT(30), true),
 	[RK3036_PD_CORE]	= DOMAIN_RK3036("core", BIT(13), BIT(17), BIT(24), false),
@@ -1516,6 +1541,18 @@ static const struct rockchip_pmu_info rv1126_pmu = {
 	.domain_info = rv1126_pm_domains,
 };
 
+static const struct rockchip_pmu_info rv1126b_pmu = {
+	.pwr_offset = 0x210,
+	.status_offset = 0x230,
+	.req_offset = 0x110,
+	.idle_offset = 0x128,
+	.ack_offset = 0x120,
+	.clk_ungate_offset = 0x140,
+
+	.num_domains = ARRAY_SIZE(rv1126b_pm_domains),
+	.domain_info = rv1126b_pm_domains,
+};
+
 static const struct of_device_id rockchip_pm_domain_dt_match[] = {
 	{
 		.compatible = "rockchip,px30-power-controller",
@@ -1585,6 +1622,10 @@ static const struct of_device_id rockchip_pm_domain_dt_match[] = {
 		.compatible = "rockchip,rv1126-power-controller",
 		.data = (void *)&rv1126_pmu,
 	},
+	{
+		.compatible = "rockchip,rv1126b-power-controller",
+		.data = (void *)&rv1126b_pmu,
+	},
 	{ /* sentinel */ },
 };
 
-- 
2.43.0


