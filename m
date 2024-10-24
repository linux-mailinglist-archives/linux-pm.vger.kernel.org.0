Return-Path: <linux-pm+bounces-16409-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FB09AED4A
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 19:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96B92B22C14
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 17:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE83F1FF024;
	Thu, 24 Oct 2024 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="SyMKLYIk"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D668C1FAF02;
	Thu, 24 Oct 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789793; cv=none; b=oJQF2CHgzawWzFPPuUwxPOYUGAGs1Bfp0Kb6ovAXoNltf2r2RLXrpSpSsOtBhaqf6XVx+9mJtuxjwP/OTWtNfWzttBqXO6yV2Klnur+ljS9y/shR7J7GrndYemk018q/jrLf+EK/6KLogERVQT00sFUKMhmG/vDK3CPCgWkVTsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789793; c=relaxed/simple;
	bh=i9M0xbrAcc2zYjmRWvSGZudanxzGOPy6UtlMgUT0VHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OASY15bt4TpFh4tF4dMNYrAeY17GGr+gvHM8moCiiHfI3nEtVxKEDWtcvPJaSLTHup72jrKsYxhH5Wh83gIx/cqJoft1RjhDBRKs5Uh5dste162FtYjalE2Jy5dw5eewNRk1xj5kHsU+Kn62Fwl1+qrACK2l5ZsmPI/8tYWBgu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=SyMKLYIk; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1729789788;
	bh=i9M0xbrAcc2zYjmRWvSGZudanxzGOPy6UtlMgUT0VHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SyMKLYIkLV4yt/rvAYObv3DEnh9SXBhd82PdHYAMcxFUOhicASPhb3gJrWrSfRWBz
	 O/U6QxXbYc6HPKOFA5QPSfJSQImr49xa9bgMprIcyy7uPVlErv/ofO4gpqqIB36Z7v
	 IvrodmRgzh0xOcmVgYzvukEji0Omi2XYhV8r1mwdLpJlBY5azK4akyhY747tzA41w5
	 rnyDGdomBrHYYGdGGz3hr5RA8YBdIpfozoIV4JoqXp3Cst+dEqbQvU8qD2hBoFTkTY
	 lpCHV7vX5FmdzYrTTH4rE3QRK/r7HB27rDlJfsKR+0U/FdostLHe3aGZuIjzoRiJw1
	 DeQcPUq8p9NbA==
X-Virus-Scanned: by epochal.quest
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-usb@vger.kernel.org,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Cody Eksal <masterr3c0rd@epochal.quest>,
	Andre Przywara <andre.przywara@arm.com>,
	Parthiban <parthiban@linumiz.com>,
	Yangtao Li <frank@allwinnertech.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shuosheng Huang <huangshuosheng@allwinnertech.com>
Subject: [PATCH 12/13] cpufreq: sun50i: add a100 cpufreq support
Date: Thu, 24 Oct 2024 14:05:30 -0300
Message-ID: <20241024170540.2721307-13-masterr3c0rd@epochal.quest>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shuosheng Huang <huangshuosheng@allwinnertech.com>

Let's add cpufreq nvmem based for allwinner a100 soc. It's similar to h6,
let us use efuse_xlate to extract the differentiated part.

Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
[masterr3c0rd@epochal.quest: add A100 to opp_match_list]
Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 293921acec93..3a29c026d364 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -22,6 +22,9 @@
 #define NVMEM_MASK	0x7
 #define NVMEM_SHIFT	5
 
+#define SUN50I_A100_NVMEM_MASK	0xf
+#define SUN50I_A100_NVMEM_SHIFT	12
+
 static struct platform_device *cpufreq_dt_pdev, *sun50i_cpufreq_pdev;
 
 struct sunxi_cpufreq_data {
@@ -45,6 +48,23 @@ static u32 sun50i_h6_efuse_xlate(u32 speedbin)
 		return 0;
 }
 
+static u32 sun50i_a100_efuse_xlate(u32 speedbin)
+{
+	u32 efuse_value;
+
+	efuse_value = (speedbin >> SUN50I_A100_NVMEM_SHIFT) &
+		      SUN50I_A100_NVMEM_MASK;
+
+	switch (efuse_value) {
+	case 0b100:
+		return 2;
+	case 0b010:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
 static int get_soc_id_revision(void)
 {
 #ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
@@ -108,6 +128,10 @@ static struct sunxi_cpufreq_data sun50i_h6_cpufreq_data = {
 	.efuse_xlate = sun50i_h6_efuse_xlate,
 };
 
+static struct sunxi_cpufreq_data sun50i_a100_cpufreq_data = {
+	.efuse_xlate = sun50i_a100_efuse_xlate,
+};
+
 static struct sunxi_cpufreq_data sun50i_h616_cpufreq_data = {
 	.efuse_xlate = sun50i_h616_efuse_xlate,
 };
@@ -116,6 +140,9 @@ static const struct of_device_id cpu_opp_match_list[] = {
 	{ .compatible = "allwinner,sun50i-h6-operating-points",
 	  .data = &sun50i_h6_cpufreq_data,
 	},
+	{ .compatible = "allwinner,sun50i-a100-operating-points",
+	  .data = &sun50i_a100_cpufreq_data,
+	},
 	{ .compatible = "allwinner,sun50i-h616-operating-points",
 	  .data = &sun50i_h616_cpufreq_data,
 	},
@@ -291,6 +318,7 @@ static struct platform_driver sun50i_cpufreq_driver = {
 
 static const struct of_device_id sun50i_cpufreq_match_list[] = {
 	{ .compatible = "allwinner,sun50i-h6" },
+	{ .compatible = "allwinner,sun50i-a100" },
 	{ .compatible = "allwinner,sun50i-h616" },
 	{ .compatible = "allwinner,sun50i-h618" },
 	{ .compatible = "allwinner,sun50i-h700" },
-- 
2.47.0


