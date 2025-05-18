Return-Path: <linux-pm+bounces-27287-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A46ABB223
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 00:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D5E2173FCC
	for <lists+linux-pm@lfdr.de>; Sun, 18 May 2025 22:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AE020ADEE;
	Sun, 18 May 2025 22:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="owaqLK3H"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D52D1DC98B
	for <linux-pm@vger.kernel.org>; Sun, 18 May 2025 22:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747606697; cv=none; b=Q2NkubovIr9kAmYBqTiNMRtnwyY0axdv6JFHnyNv0u5weSRowTIAAcr8hFUbDvP254PJczcAqPGv37Yvq0DpkSseqH0MWCIii3Q39486xv/3oCKWxf2mdsGjk9Hk9WNOyEs+8pNqVUB0UWacrvGk6ai8V8bBgA4zosyJeVai4jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747606697; c=relaxed/simple;
	bh=5x3UGZaZlxXjWW89yIp7LGaERQKkHUjp8KDII8XBuQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DbNGE09F+xoYwEfwUxtHIBvPcTfb2q/Us6yRnckjJjHPOE1rvxhJcLhclP9wz5+exQ+ihVphMAhRo0w/8OK+YV+JioAdd32gRmwR39SIRMJYGvRlFuU17IPAxxH450s7mMBdUoT1HfayRM5irijaF6Mdn36hJlElAwAoQmpf07U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=owaqLK3H; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1747606694; bh=XdJ8idrCkjaMANhXmNVJs+MC4XORO5o90qIWLcWpGNw=;
 b=owaqLK3HDGa2NPwwv4+REoyhknt8M36o0Vu9zeRTOeR+NC9DEtV8ikBrMlTcyUX71TRVzxJIM
 DCkDD+Kjbo49ejOoAJ3Nz9jiDlHnu+Jtjojg2K2hAAxaHgoYJ4hKgx/9d/qyTB3dX7L8LcUl+Y1
 neUsBHPC/tFp94vNZ0UCtx83THzX5rGqMwIuasGP3qESXcZEiF9zC7C4qyAag8MvkaI5Ht4V3nE
 Z8WjIQBmx4L3GPmgjHVa9QQD86i80xQLFwYMY8EVjptvLhvXd8s3/2IMQc7Ay6aenU7oUV6uZOn
 plQLLkafoCIdO8Jw7RwtTmuiRwYZlOLBTwM5/e11+SBw==
X-Forward-Email-ID: 682a5a1a78cae75fbd8d4697
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] pmdomain: rockchip: Add support for RK3528
Date: Sun, 18 May 2025 22:06:49 +0000
Message-ID: <20250518220707.669515-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250518220707.669515-1-jonas@kwiboo.se>
References: <20250518220707.669515-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add configuration and power domains for RK3528 SoC.

Only PD_GPU can fully be powered down. PD_RKVDEC, PD_RKVENC, PD_VO and
PD_VPU are used by miscellaneous devices in RK3528.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/pmdomain/rockchip/pm-domains.c | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 4cce407bb1eb..242570c505fb 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -35,6 +35,7 @@
 #include <dt-bindings/power/rk3366-power.h>
 #include <dt-bindings/power/rk3368-power.h>
 #include <dt-bindings/power/rk3399-power.h>
+#include <dt-bindings/power/rockchip,rk3528-power.h>
 #include <dt-bindings/power/rockchip,rk3562-power.h>
 #include <dt-bindings/power/rk3568-power.h>
 #include <dt-bindings/power/rockchip,rk3576-power.h>
@@ -216,6 +217,9 @@ struct rockchip_pmu {
 #define DOMAIN_RK3399(name, pwr, status, req, wakeup)		\
 	DOMAIN(name, pwr, status, req, req, req, wakeup)
 
+#define DOMAIN_RK3528(name, pwr, req)		\
+	DOMAIN_M(name, pwr, pwr, req, req, req, false)
+
 #define DOMAIN_RK3562(name, pwr, req, g_mask, mem, wakeup)		\
 	DOMAIN_M_G_SD(name, pwr, pwr, req, req, req, g_mask, mem, wakeup, false)
 
@@ -1215,6 +1219,14 @@ static const struct rockchip_domain_info rk3399_pm_domains[] = {
 	[RK3399_PD_SDIOAUDIO]	= DOMAIN_RK3399("sdioaudio", BIT(31), BIT(31), BIT(29), true),
 };
 
+static const struct rockchip_domain_info rk3528_pm_domains[] = {
+	[RK3528_PD_GPU]		= DOMAIN_RK3528("gpu",  BIT(0), BIT(4)),
+	[RK3528_PD_RKVDEC]	= DOMAIN_RK3528("vdec",      0, BIT(5)),
+	[RK3528_PD_RKVENC]	= DOMAIN_RK3528("venc",      0, BIT(6)),
+	[RK3528_PD_VO]		= DOMAIN_RK3528("vo",        0, BIT(7)),
+	[RK3528_PD_VPU]		= DOMAIN_RK3528("vpu",       0, BIT(8)),
+};
+
 static const struct rockchip_domain_info rk3562_pm_domains[] = {
 					     /* name           pwr     req     g_mask  mem wakeup */
 	[RK3562_PD_GPU]		= DOMAIN_RK3562("gpu",         BIT(0), BIT(1), BIT(1), 0, false),
@@ -1428,6 +1440,17 @@ static const struct rockchip_pmu_info rk3399_pmu = {
 	.domain_info = rk3399_pm_domains,
 };
 
+static const struct rockchip_pmu_info rk3528_pmu = {
+	.pwr_offset = 0x1210,
+	.status_offset = 0x1230,
+	.req_offset = 0x1110,
+	.idle_offset = 0x1128,
+	.ack_offset = 0x1120,
+
+	.num_domains = ARRAY_SIZE(rk3528_pm_domains),
+	.domain_info = rk3528_pm_domains,
+};
+
 static const struct rockchip_pmu_info rk3562_pmu = {
 	.pwr_offset = 0x210,
 	.status_offset = 0x230,
@@ -1538,6 +1561,10 @@ static const struct of_device_id rockchip_pm_domain_dt_match[] = {
 		.compatible = "rockchip,rk3399-power-controller",
 		.data = (void *)&rk3399_pmu,
 	},
+	{
+		.compatible = "rockchip,rk3528-power-controller",
+		.data = (void *)&rk3528_pmu,
+	},
 	{
 		.compatible = "rockchip,rk3562-power-controller",
 		.data = (void *)&rk3562_pmu,
-- 
2.49.0


