Return-Path: <linux-pm+bounces-13189-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245BE9650C1
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 22:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D386E284C93
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 20:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1192B1BB691;
	Thu, 29 Aug 2024 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="i3l7IouF"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7211BA88F;
	Thu, 29 Aug 2024 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724963171; cv=none; b=fqypdcj1moHN7ly50faPiM2cvwNGPLHXQQQCe4CfexxODrY1Z2gj6mqIkXM++q1dZfatkiFcaufsUDIREKFTtx1dlj2/sNpW+AA54o7BodZWF5EARi3JbfHf6/ftxgiWcLowNjm0z4wmWkzHSrO1dgeaV4fnLX+tiayzrTWIQpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724963171; c=relaxed/simple;
	bh=RlsFXO6KatDsM7/49cx/GSZQ9BgWcaXezSg0o3At/h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJ2dhMW6CK0f3+z7WuN+OLXIJ4GHZG+eWrbfhMKIceHeTE7k6NKICuJTUqTAuPRSYlRJ+hChpBp6JxJIABZkQXd4GtFLeo1hF3O0EZ8w0LCEUoa9re4x6FphZM6N8T3c2ttcsWcEZ7qi2vAYvk4VZX7gLb05oxcvSvembdNIsfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=i3l7IouF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1724963167;
	bh=RlsFXO6KatDsM7/49cx/GSZQ9BgWcaXezSg0o3At/h0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3l7IouF+s1UpEa2L7+qaXO296mVBKobWHSB2ihmSLDlW2UVpNIOkXxBEZWyvPenV
	 itpTBBTmLqX+ABwHw0ap3KDWbkzx/U7dpuP1rYv5VU3Lv+B/jqI+gaR05zEeNmtloC
	 ZKvXZDNlnxsPxfKudSGgrj0nSNYx3f+4IR+BA19iw3nfqDUlUYxSNkFBI6gsRmJO93
	 FJXy6oloTGPXSPJpDwKVxsLUiwuSxUWx/ZnEKrSP1upHgxaa08JZ8KX4+f21iVzmW9
	 UiZZ8Z1JG3b9PdE+LgouZm6w8XpNhr4HRUAMewg3nvmFEqiEnxpI9vW0FRquhsEFGQ
	 kps7fiY8614Gg==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C2A0317E0FF5;
	Thu, 29 Aug 2024 22:26:05 +0200 (CEST)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Rob Herring <robh@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 1/2] pmdomain: rockchip: Add gating support
Date: Thu, 29 Aug 2024 16:20:47 -0400
Message-ID: <20240829202732.75961-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829202732.75961-1-detlev.casanova@collabora.com>
References: <20240829202732.75961-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some rockchip SoC need to ungate power domains before their power status
can be changed.

Each power domain has a gate mask that is set to 1 to ungate it when
manipulating power status, then set back to 0 to gate it again.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 64b4d7120d832..5b601efadd2e0 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -46,6 +46,7 @@ struct rockchip_domain_info {
 	bool active_wakeup;
 	int pwr_w_mask;
 	int req_w_mask;
+	int clk_ungate_mask;
 	int mem_status_mask;
 	int repair_status_mask;
 	u32 pwr_offset;
@@ -63,6 +64,7 @@ struct rockchip_pmu_info {
 	u32 chain_status_offset;
 	u32 mem_status_offset;
 	u32 repair_status_offset;
+	u32 clk_ungate_offset;
 
 	u32 core_pwrcnt_offset;
 	u32 gpu_pwrcnt_offset;
@@ -303,6 +305,26 @@ static unsigned int rockchip_pmu_read_ack(struct rockchip_pmu *pmu)
 	return val;
 }
 
+static int rockchip_pmu_ungate_clk(struct rockchip_pm_domain *pd, bool ungate)
+{
+	const struct rockchip_domain_info *pd_info = pd->info;
+	struct rockchip_pmu *pmu = pd->pmu;
+	unsigned int val;
+	int clk_ungate_w_mask = pd_info->clk_ungate_mask << 16;
+
+	if (!pd_info->clk_ungate_mask)
+		return 0;
+
+	if (!pmu->info->clk_ungate_offset)
+		return 0;
+
+	val = ungate ? (pd_info->clk_ungate_mask | clk_ungate_w_mask) :
+			clk_ungate_w_mask;
+	regmap_write(pmu->regmap, pmu->info->clk_ungate_offset, val);
+
+	return 0;
+}
+
 static int rockchip_pmu_set_idle_request(struct rockchip_pm_domain *pd,
 					 bool idle)
 {
@@ -543,6 +565,8 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 			return ret;
 		}
 
+		rockchip_pmu_ungate_clk(pd, true);
+
 		if (!power_on) {
 			rockchip_pmu_save_qos(pd);
 
@@ -559,6 +583,7 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 			rockchip_pmu_restore_qos(pd);
 		}
 
+		rockchip_pmu_ungate_clk(pd, false);
 		clk_bulk_disable(pd->num_clks, pd->clks);
 	}
 
-- 
2.46.0


