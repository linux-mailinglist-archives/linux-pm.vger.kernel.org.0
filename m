Return-Path: <linux-pm+bounces-24950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63FEA81017
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 17:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B0E1B6332F
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 15:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B75229B21;
	Tue,  8 Apr 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="RxpER7NL"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D967229B0E;
	Tue,  8 Apr 2025 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126097; cv=pass; b=fg8I9UczjfG0+B5D5PeVokOgWdeVChboAPPTLhXiwaek0oBdLPYzXzEHdJbOEQCDlK22XRpY4uz4cczBI5AWr4GFgaBZLrmlM4R0IcNA4YWYC/Umd4XVCU/t9BWncIpqCg8D9LdTEzmCYkNuSgZcPQwn0NfYpDwh3eofnfA1aD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126097; c=relaxed/simple;
	bh=LfDuHZhyQMnq6p04/ZVlHuZD2GEXNqvywnJ3zYqMRVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RqKuy89h9U0dCPfo2+c+Vj3OwgXqVoP1QA0LifBfOUJoJmn6CACUzLlWPqJ7FcLaLAgHgjbQ0/if3bbdyJYzG98oaHnjkgiq1EICH+XLb49Bh4czCGkoRITGgqO21E8rkVPJxYcmld8/ZREjfTVSm36ONFYJ7iEVLxxD/YTVOig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=RxpER7NL; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744126071; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Clq1p2ElUtXuJl0mcuE/6qBe736x7qHLqEUOi+K2KDAMXFOzO/N8/Pv5gfgTqcSXZrVrAk77la8+eAx7JSnWdJnAaVQaNN+pmi7xqidaYEV5FbW3Lq4eZCKAkeDjORWj8AEVdr0CNTrH257bY1oDyhuXeLFz6PK3VJq1A5gn5tU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744126071; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mR1vtbmwt5QaC5nynO+8PlhkL6P8DxSsCm16ycxu7/E=; 
	b=TexdogQOJne1PjO/V9ACajg3CwQUX6tRTy53BzRK3AHjuPS8TgFgi0BO4xSajCiiwv14ICFlbX2E+Idle06VKw4xqorlLR59IzBMZH/n/uUPiZfNGx4JpVLfx0P6ctVoslZqXJ0qxjgkTHv5zuiYEyGcXvwQF0UYRM/RuxZ/F4Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744126071;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=mR1vtbmwt5QaC5nynO+8PlhkL6P8DxSsCm16ycxu7/E=;
	b=RxpER7NLYCcUf00ifcNz5XOXD7MWBS3srvR/3Ig2/Go4XkHz3jIuYsM2mq0kzOkp
	Lk7FygTNMrE8kVVWPP7Yq3e1ddGgFhHsH0PlSVBBSfhpnqMkw1Vpuc9lGJc1JVA7c+3
	s/HsezfV8tRE8tVMDKYOa2Hc2qPA10UvKwIBsJpw=
Received: by mx.zohomail.com with SMTPS id 1744126070257421.07626011841296;
	Tue, 8 Apr 2025 08:27:50 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 08 Apr 2025 17:27:01 +0200
Subject: [PATCH RESEND] pmdomain: rockchip: keep PD_NVM on RK3576 always on
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-rk3576-emmc-fix-v1-1-3009828b1b31@collabora.com>
X-B4-Tracking: v=1; b=H4sIAERA9WcC/3VOuw6CMBT9FXJnL+EWCsrkIKuDjoahlCKNQLVFo
 iH8uw26Op73mcEpq5WDPJjBqkk7bQYPaBOAbMVwVahrj4FFjEcxZWhvMc9SVH0vsdEvzGq5JZG
 yLGEMfOpulafXxgucinNxPED55a16PP3A+BMr4RRK0/d6zIMpDYmjlbSaW+1GY9/rq4lW998DE
 yFhzeOkTnYioYbvpek6URkrQt8O5bIsH8X091jnAAAA
X-Change-ID: 20250317-rk3576-emmc-fix-7dc81a627422
To: Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Detlev Casanova <detlev.casanova@collabora.com>, kernel@collabora.com, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

Due to what seemingly is a hardware bug, PD_NVM never comes up quite the
same after being turned off once. The result is that the sdhci
controller will lock up the entire SoC when it's accessing its CQHCI
registers.

The downstream kernel hacks around this by setting
GENPD_FLAG_RPM_ALWAYS_ON in the mmc host driver, which does not seem
like the right place for this.

Set GENPD_FLAG_ALWAYS_ON in the pmdomain driver for PD_NVM. I'm using
the non-RPM version of the flag here because I have my doubts a
suspend-resume cycle will fix it. Suspend-resume currently seems busted,
so I couldn't test this.

Fixes: cfee1b507758 ("pmdomain: rockchip: Add support for RK3576 SoC")
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 48 ++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 03bcf79a461f5db14173b35c0d110541e6d3f760..2b220b7c77b3d292f49cbc60338d3925146fb211 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -48,6 +48,7 @@ struct rockchip_domain_info {
 	int ack_mask;
 	bool active_wakeup;
 	bool need_regulator;
+	bool always_on;
 	int pwr_w_mask;
 	int req_w_mask;
 	int clk_ungate_mask;
@@ -154,7 +155,7 @@ struct rockchip_pmu {
 	.need_regulator = regulator,			\
 }
 
-#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, g_mask, wakeup)	\
+#define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, g_mask, wakeup, _always_on)	\
 {							\
 	.name = _name,					\
 	.pwr_offset = p_offset,				\
@@ -171,6 +172,7 @@ struct rockchip_pmu {
 	.clk_ungate_mask = (g_mask),			\
 	.ack_mask = (ack),				\
 	.active_wakeup = wakeup,			\
+	.always_on = _always_on,			\
 }
 
 #define DOMAIN_RK3036(_name, req, ack, idle, wakeup)		\
@@ -204,8 +206,8 @@ struct rockchip_pmu {
 #define DOMAIN_RK3568(name, pwr, req, wakeup)		\
 	DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
 
-#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, wakeup)	\
-	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, wakeup)
+#define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, req, idle, g_mask, wakeup, always_on)	\
+	DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status, r_offset, req, idle, idle, g_mask, wakeup, always_on)
 
 /*
  * Dynamic Memory Controller may need to coordinate with us -- see
@@ -846,6 +848,8 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	pd->genpd.flags = GENPD_FLAG_PM_CLK;
 	if (pd_info->active_wakeup)
 		pd->genpd.flags |= GENPD_FLAG_ACTIVE_WAKEUP;
+	if (pd_info->always_on)
+		pd->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
 	pm_genpd_init(&pd->genpd, NULL,
 		      !rockchip_pmu_domain_is_on(pd) ||
 		      (pd->info->mem_status_mask && !rockchip_pmu_domain_is_mem_on(pd)));
@@ -1210,25 +1214,25 @@ static const struct rockchip_domain_info rk3568_pm_domains[] = {
 };
 
 static const struct rockchip_domain_info rk3576_pm_domains[] = {
-	[RK3576_PD_NPU]		= DOMAIN_RK3576("npu",    0x0, BIT(0),  BIT(0), 0,       0x0, 0,       0,       0,       false),
-	[RK3576_PD_NVM]		= DOMAIN_RK3576("nvm",    0x0, BIT(6),  0,      BIT(6),  0x4, BIT(2),  BIT(18), BIT(2),  false),
-	[RK3576_PD_SDGMAC]	= DOMAIN_RK3576("sdgmac", 0x0, BIT(7),  0,      BIT(7),  0x4, BIT(1),  BIT(17), 0x6,     false),
-	[RK3576_PD_AUDIO]	= DOMAIN_RK3576("audio",  0x0, BIT(8),  0,      BIT(8),  0x4, BIT(0),  BIT(16), BIT(0),  false),
-	[RK3576_PD_PHP]		= DOMAIN_RK3576("php",    0x0, BIT(9),  0,      BIT(9),  0x0, BIT(15), BIT(15), BIT(15), false),
-	[RK3576_PD_SUBPHP]	= DOMAIN_RK3576("subphp", 0x0, BIT(10), 0,      BIT(10), 0x0, 0,       0,       0,       false),
-	[RK3576_PD_VOP]		= DOMAIN_RK3576("vop",    0x0, BIT(11), 0,      BIT(11), 0x0, 0x6000,  0x6000,  0x6000,  false),
-	[RK3576_PD_VO1]		= DOMAIN_RK3576("vo1",    0x0, BIT(14), 0,      BIT(14), 0x0, BIT(12), BIT(12), 0x7000,  false),
-	[RK3576_PD_VO0]		= DOMAIN_RK3576("vo0",    0x0, BIT(15), 0,      BIT(15), 0x0, BIT(11), BIT(11), 0x6800,  false),
-	[RK3576_PD_USB]		= DOMAIN_RK3576("usb",    0x4, BIT(0),  0,      BIT(16), 0x0, BIT(10), BIT(10), 0x6400,  true),
-	[RK3576_PD_VI]		= DOMAIN_RK3576("vi",     0x4, BIT(1),  0,      BIT(17), 0x0, BIT(9),  BIT(9),  BIT(9),  false),
-	[RK3576_PD_VEPU0]	= DOMAIN_RK3576("vepu0",  0x4, BIT(2),  0,      BIT(18), 0x0, BIT(7),  BIT(7),  0x280,   false),
-	[RK3576_PD_VEPU1]	= DOMAIN_RK3576("vepu1",  0x4, BIT(3),  0,      BIT(19), 0x0, BIT(8),  BIT(8),  BIT(8),  false),
-	[RK3576_PD_VDEC]	= DOMAIN_RK3576("vdec",   0x4, BIT(4),  0,      BIT(20), 0x0, BIT(6),  BIT(6),  BIT(6),  false),
-	[RK3576_PD_VPU]		= DOMAIN_RK3576("vpu",    0x4, BIT(5),  0,      BIT(21), 0x0, BIT(5),  BIT(5),  BIT(5),  false),
-	[RK3576_PD_NPUTOP]	= DOMAIN_RK3576("nputop", 0x4, BIT(6),  0,      BIT(22), 0x0, 0x18,    0x18,    0x18,    false),
-	[RK3576_PD_NPU0]	= DOMAIN_RK3576("npu0",   0x4, BIT(7),  0,      BIT(23), 0x0, BIT(1),  BIT(1),  0x1a,    false),
-	[RK3576_PD_NPU1]	= DOMAIN_RK3576("npu1",   0x4, BIT(8),  0,      BIT(24), 0x0, BIT(2),  BIT(2),  0x1c,    false),
-	[RK3576_PD_GPU]		= DOMAIN_RK3576("gpu",    0x4, BIT(9),  0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  false),
+	[RK3576_PD_NPU]		= DOMAIN_RK3576("npu",    0x0, BIT(0),  BIT(0), 0,       0x0, 0,       0,       0,       false, false),
+	[RK3576_PD_NVM]		= DOMAIN_RK3576("nvm",    0x0, BIT(6),  0,      BIT(6),  0x4, BIT(2),  BIT(18), BIT(2),  false, true),
+	[RK3576_PD_SDGMAC]	= DOMAIN_RK3576("sdgmac", 0x0, BIT(7),  0,      BIT(7),  0x4, BIT(1),  BIT(17), 0x6,     false, false),
+	[RK3576_PD_AUDIO]	= DOMAIN_RK3576("audio",  0x0, BIT(8),  0,      BIT(8),  0x4, BIT(0),  BIT(16), BIT(0),  false, false),
+	[RK3576_PD_PHP]		= DOMAIN_RK3576("php",    0x0, BIT(9),  0,      BIT(9),  0x0, BIT(15), BIT(15), BIT(15), false, false),
+	[RK3576_PD_SUBPHP]	= DOMAIN_RK3576("subphp", 0x0, BIT(10), 0,      BIT(10), 0x0, 0,       0,       0,       false, false),
+	[RK3576_PD_VOP]		= DOMAIN_RK3576("vop",    0x0, BIT(11), 0,      BIT(11), 0x0, 0x6000,  0x6000,  0x6000,  false, false),
+	[RK3576_PD_VO1]		= DOMAIN_RK3576("vo1",    0x0, BIT(14), 0,      BIT(14), 0x0, BIT(12), BIT(12), 0x7000,  false, false),
+	[RK3576_PD_VO0]		= DOMAIN_RK3576("vo0",    0x0, BIT(15), 0,      BIT(15), 0x0, BIT(11), BIT(11), 0x6800,  false, false),
+	[RK3576_PD_USB]		= DOMAIN_RK3576("usb",    0x4, BIT(0),  0,      BIT(16), 0x0, BIT(10), BIT(10), 0x6400,  true,  false),
+	[RK3576_PD_VI]		= DOMAIN_RK3576("vi",     0x4, BIT(1),  0,      BIT(17), 0x0, BIT(9),  BIT(9),  BIT(9),  false, false),
+	[RK3576_PD_VEPU0]	= DOMAIN_RK3576("vepu0",  0x4, BIT(2),  0,      BIT(18), 0x0, BIT(7),  BIT(7),  0x280,   false, false),
+	[RK3576_PD_VEPU1]	= DOMAIN_RK3576("vepu1",  0x4, BIT(3),  0,      BIT(19), 0x0, BIT(8),  BIT(8),  BIT(8),  false, false),
+	[RK3576_PD_VDEC]	= DOMAIN_RK3576("vdec",   0x4, BIT(4),  0,      BIT(20), 0x0, BIT(6),  BIT(6),  BIT(6),  false, false),
+	[RK3576_PD_VPU]		= DOMAIN_RK3576("vpu",    0x4, BIT(5),  0,      BIT(21), 0x0, BIT(5),  BIT(5),  BIT(5),  false, false),
+	[RK3576_PD_NPUTOP]	= DOMAIN_RK3576("nputop", 0x4, BIT(6),  0,      BIT(22), 0x0, 0x18,    0x18,    0x18,    false, false),
+	[RK3576_PD_NPU0]	= DOMAIN_RK3576("npu0",   0x4, BIT(7),  0,      BIT(23), 0x0, BIT(1),  BIT(1),  0x1a,    false, false),
+	[RK3576_PD_NPU1]	= DOMAIN_RK3576("npu1",   0x4, BIT(8),  0,      BIT(24), 0x0, BIT(2),  BIT(2),  0x1c,    false, false),
+	[RK3576_PD_GPU]		= DOMAIN_RK3576("gpu",    0x4, BIT(9),  0,      BIT(25), 0x0, BIT(0),  BIT(0),  BIT(0),  false, false),
 };
 
 static const struct rockchip_domain_info rk3588_pm_domains[] = {

---
base-commit: 64e9fdfc89a76fed38d8ddeed72d42ec71957ed9
change-id: 20250317-rk3576-emmc-fix-7dc81a627422

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


