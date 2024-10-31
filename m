Return-Path: <linux-pm+bounces-16800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9EF9B74FA
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 08:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20698286873
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 07:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13392178370;
	Thu, 31 Oct 2024 07:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="f5aonTIP"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38E314EC5B;
	Thu, 31 Oct 2024 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730358217; cv=none; b=eFPFq74pDhJl7qjLUQzxIrGTe5Zk2APc4YUxOybpS+gPUCuxuAEdkxDZavhYvHqGRI/+dTY2DichtPjwMyiF8n0xphTrP6kpdxlopE+c2J0cEg+GgF0dCo/TE+13yhylor+PNhsWyNJf+PDXy0s872aLZ0JagXuywtrrwjAf8j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730358217; c=relaxed/simple;
	bh=nnLK7vdS2Jw3tJYIfQcazeyvsSONfvWoJ57ZBLGoLRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKteF0TY8ZvVopgX58Hu08olmNJZjxlu/YgXWYibsmYQEnpyMSxFoodRe6deTOHH7t8JBGQgC0jMPXi53JvRxMZpACoz67OBePZkTnYIdY3Qcz5BH0vdYYG6nT5Yc7Xo0usNkqtkuj0upj2hfyeP9mNXMEQIKvzmpOOxs3/qets=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=f5aonTIP; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1730358206;
	bh=nnLK7vdS2Jw3tJYIfQcazeyvsSONfvWoJ57ZBLGoLRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f5aonTIPZ3ov2mqf1MwtR3Qr76H/P4hBfDCBhiFGIGCsImTtOkadF8sG5nshiBAgy
	 B6UVyG9+LxOyfUTB4HB0hcoKh/DzxpMoLt6feRx0Q4hAB+34m2oAQVrbxVJprDK+VO
	 4wRk0PDmR8S5GozMQblFlj72xT3f/642Q00Uqja+mraD8wtr5eXEzmy4qkACkRe8a4
	 T3I30aeN5eQ2C7fagPFslHgg+kANBhOaOQ2F3AgWChoYOz8IMHV5jqWMxeYzL11+Pa
	 tNdJ+imtc2baPScXVlYR5AJp00NHn5rKQhNz9J/RLnajsFwUqy9PPo8s6ZiPL5dKrX
	 vuALB5l9Hw/qQ==
X-Virus-Scanned: by epochal.quest
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Nishanth Menon <nm@ti.com>,
	Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Parthiban <parthiban@linumiz.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Cody Eksal <masterr3c0rd@epochal.quest>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v2 12/13] cpufreq: sun50i: add a100 cpufreq support
Date: Thu, 31 Oct 2024 04:02:25 -0300
Message-ID: <20241031070232.1793078-13-masterr3c0rd@epochal.quest>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
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
Changes in V2:
 - Add the A100 to the cpufreq-dt-platdev blacklist.

 drivers/cpufreq/cpufreq-dt-platdev.c   |  1 +
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 28 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 18942bfe9c95..2a3e8bd317c9 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -103,6 +103,7 @@ static const struct of_device_id allowlist[] __initconst = {
  * platforms using "operating-points-v2" property.
  */
 static const struct of_device_id blocklist[] __initconst = {
+	{ .compatible = "allwinner,sun50i-a100" },
 	{ .compatible = "allwinner,sun50i-h6", },
 	{ .compatible = "allwinner,sun50i-h616", },
 	{ .compatible = "allwinner,sun50i-h618", },
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


