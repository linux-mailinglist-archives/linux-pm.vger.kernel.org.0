Return-Path: <linux-pm+bounces-36340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CFEBE7D8D
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 11:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA661A6027A
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 09:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D432E2D8DB1;
	Fri, 17 Oct 2025 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="W5jp6S/w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m155115.qiye.163.com (mail-m155115.qiye.163.com [101.71.155.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CAF2D948D;
	Fri, 17 Oct 2025 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693941; cv=none; b=a21J8NCdzZj3/byvybcR3DNr7sczJBn77ZscJBuAEi896GQITjOCttk/JaOibHGkQwbwEpe3cggBENhls2TJ0pDoo7/uOayvOBqDyomF8b75b9Tx/K/C8wvX3LvwuW0hJLgoy0KpTljCSpF7x15/S2ThxBlIu1Z5onJjq/X41Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693941; c=relaxed/simple;
	bh=/uMjemFdG4cvjRSuNs5pGHfvA0jJBGs/FFWEj/RfkMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzcwO8cx8QnurPZXR5XJGLncE3hS4xA+qyv8Xwe9Bnf4tIoODYdX+c0tReFNJdBVY+6XipTTqFepzUkBywQUDFCBkjPvny0jvmOrSigNAcS1+FD4p2T+DhKSvIA6R3yzONQFrItuz0dG+KFrQ/w+kH1XLpmF94pMNbGTVVHa3Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=W5jp6S/w; arc=none smtp.client-ip=101.71.155.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from xf.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 264523299;
	Fri, 17 Oct 2025 17:38:48 +0800 (GMT+08:00)
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
	zhangqing@rock-chips.com,
	sugar.zhang@rock-chips.com,
	huangtao@rock-chips.com,
	Finley Xiao <finley.xiao@rock-chips.com>
Subject: [PATCH v4 2/2] pmdomain: rockchip: Add support for RV1126B
Date: Fri, 17 Oct 2025 17:38:34 +0800
Message-ID: <20251017093834.331998-3-finley.xiao@rock-chips.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017093834.331998-1-finley.xiao@rock-chips.com>
References: <20251017093834.331998-1-finley.xiao@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99f189440803a9kunmbe68a2b91699fc
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR4dHVYZGEIdSE8dGklPGh9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=W5jp6S/w9W+mUfWqB06NKlgUMJCpSRRuHfUWlNqXTcHWT4XJAzCN5Q0cIoRdnrfHoEKofNCELI7ej65U0xnP5xOc6B3Sz37UA/DWs7wTDJKLPWRNNrFxLTtMe9dL/wCsuHLli3ul58bBUt16rbr9Ey5Dgu1IILb1z2jMJExyRdM=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=NztC9OMCatTTQwpoZke82j/IOHOT8VkpQXM+0K2ojno=;
	h=date:mime-version:subject:message-id:from;

Add configuration and power domains for RV1126 SoC.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---

Changes in v4:
- update the header after rename

Changes in v3: None

Changes in v2:
- rename AISP to AIISP
- collect review tag

 drivers/pmdomain/rockchip/pm-domains.c | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 1955c6d453e4..4f1336a0f49a 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -25,6 +25,7 @@
 #include <soc/rockchip/rockchip_sip.h>
 #include <dt-bindings/power/px30-power.h>
 #include <dt-bindings/power/rockchip,rv1126-power.h>
+#include <dt-bindings/power/rockchip,rv1126b-power-controller.h>
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
+					      /* name     pwr     req      wakeup */
+	[RV1126B_PD_NPU]	= DOMAIN_RV1126B("npu",   BIT(0), BIT(8),  false),
+	[RV1126B_PD_VDO]	= DOMAIN_RV1126B("vdo",   BIT(1), BIT(9),  false),
+	[RV1126B_PD_AIISP]	= DOMAIN_RV1126B("aiisp", BIT(2), BIT(10), false),
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


