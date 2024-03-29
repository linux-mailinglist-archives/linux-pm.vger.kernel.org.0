Return-Path: <linux-pm+bounces-5680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2599891FC2
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 16:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACCF1C290D7
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 15:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F865147C7B;
	Fri, 29 Mar 2024 14:13:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C6A14535D;
	Fri, 29 Mar 2024 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711721626; cv=none; b=IKuaxttpNPbXagWc0W7p3QKlNPJh4A4R+4UooPEpVS9nNeiO0D6B9qY1oU7hTlW6DbZnlE6yk5MVwPDlnFXymGiNp+5DrRqla8zbSKt+sZ8iFHVZIsYwX08NmNp3sK9XjZO9aDqSRZLkfKd1FRm3yGzxG28w9+q9cQw71TVA8yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711721626; c=relaxed/simple;
	bh=V5EfAGVMatRRvCklDoNVscaV3R+2YHXbvf9Cf2lW/HA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=awaAUupOUy2FQdaLzcDjcljAYrSElTqv1DEw/E6/ybqGVvbivZynG3BUnWAT9tPEp5J31xD4ivLh3w3+dwKfFi3vsFNVpuBVS3LfEa+A6g0a1OixJ11mSWsMw+aiQfxeaQrDkUWAiKBDmMRvwBaoQbOPlZW2IpKV6RksI4O7ot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9645612FC;
	Fri, 29 Mar 2024 07:14:17 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B43FF3F64C;
	Fri, 29 Mar 2024 07:13:41 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	Martin Botka <martin.botka@somainline.org>,
	Martin Botka <martin.botka1@gmail.com>,
	Chris Morgan <macroalpha82@gmail.com>,
	Ryan Walklin <ryan@testtoast.com>
Subject: [PATCH v4 4/8] cpufreq: sun50i: Refactor speed bin decoding
Date: Fri, 29 Mar 2024 14:13:07 +0000
Message-Id: <20240329141311.27158-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240329141311.27158-1-andre.przywara@arm.com>
References: <20240329141311.27158-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brandon Cheo Fusi <fusibrandon13@gmail.com>

Make converting the speed bin value into a speed grade generic and
determined by a platform specific callback. Also change the prototypes
involved to encode the speed bin directly in the return value.

This allows to extend the driver more easily to support more SoCs.

Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
[Andre: merge output into return value]
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 74 +++++++++++++++++---------
 1 file changed, 49 insertions(+), 25 deletions(-)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 32a9c88f8ff6d..45c56e23346e9 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -25,19 +25,52 @@
 
 static struct platform_device *cpufreq_dt_pdev, *sun50i_cpufreq_pdev;
 
+struct sunxi_cpufreq_data {
+	u32 (*efuse_xlate)(u32 speedbin);
+};
+
+static u32 sun50i_h6_efuse_xlate(u32 speedbin)
+{
+	u32 efuse_value;
+
+	efuse_value = (speedbin >> NVMEM_SHIFT) & NVMEM_MASK;
+
+	/*
+	 * We treat unexpected efuse values as if the SoC was from
+	 * the slowest bin. Expected efuse values are 1-3, slowest
+	 * to fastest.
+	 */
+	if (efuse_value >= 1 && efuse_value <= 3)
+		return efuse_value - 1;
+	else
+		return 0;
+}
+
+static struct sunxi_cpufreq_data sun50i_h6_cpufreq_data = {
+	.efuse_xlate = sun50i_h6_efuse_xlate,
+};
+
+static const struct of_device_id cpu_opp_match_list[] = {
+	{ .compatible = "allwinner,sun50i-h6-operating-points",
+	  .data = &sun50i_h6_cpufreq_data,
+	},
+	{}
+};
+
 /**
  * sun50i_cpufreq_get_efuse() - Determine speed grade from efuse value
- * @versions: Set to the value parsed from efuse
  *
- * Returns 0 if success.
+ * Returns non-negative speed bin index on success, a negative error
+ * value otherwise.
  */
-static int sun50i_cpufreq_get_efuse(u32 *versions)
+static int sun50i_cpufreq_get_efuse(void)
 {
+	const struct sunxi_cpufreq_data *opp_data;
 	struct nvmem_cell *speedbin_nvmem;
+	const struct of_device_id *match;
 	struct device_node *np;
 	struct device *cpu_dev;
-	u32 *speedbin, efuse_value;
-	size_t len;
+	u32 *speedbin;
 	int ret;
 
 	cpu_dev = get_cpu_device(0);
@@ -48,12 +81,12 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
 	if (!np)
 		return -ENOENT;
 
-	ret = of_device_is_compatible(np,
-				      "allwinner,sun50i-h6-operating-points");
-	if (!ret) {
+	match = of_match_node(cpu_opp_match_list, np);
+	if (!match) {
 		of_node_put(np);
 		return -ENOENT;
 	}
+	opp_data = match->data;
 
 	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
 	of_node_put(np);
@@ -61,25 +94,16 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
 		return dev_err_probe(cpu_dev, PTR_ERR(speedbin_nvmem),
 				     "Could not get nvmem cell\n");
 
-	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+	speedbin = nvmem_cell_read(speedbin_nvmem, NULL);
 	nvmem_cell_put(speedbin_nvmem);
 	if (IS_ERR(speedbin))
 		return PTR_ERR(speedbin);
 
-	efuse_value = (*speedbin >> NVMEM_SHIFT) & NVMEM_MASK;
-
-	/*
-	 * We treat unexpected efuse values as if the SoC was from
-	 * the slowest bin. Expected efuse values are 1-3, slowest
-	 * to fastest.
-	 */
-	if (efuse_value >= 1 && efuse_value <= 3)
-		*versions = efuse_value - 1;
-	else
-		*versions = 0;
+	ret = opp_data->efuse_xlate(*speedbin);
 
 	kfree(speedbin);
-	return 0;
+
+	return ret;
 };
 
 static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
@@ -87,7 +111,7 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 	int *opp_tokens;
 	char name[MAX_NAME_LEN];
 	unsigned int cpu;
-	u32 speed = 0;
+	int speed;
 	int ret;
 
 	opp_tokens = kcalloc(num_possible_cpus(), sizeof(*opp_tokens),
@@ -95,10 +119,10 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 	if (!opp_tokens)
 		return -ENOMEM;
 
-	ret = sun50i_cpufreq_get_efuse(&speed);
-	if (ret) {
+	speed = sun50i_cpufreq_get_efuse();
+	if (speed < 0) {
 		kfree(opp_tokens);
-		return ret;
+		return speed;
 	}
 
 	snprintf(name, MAX_NAME_LEN, "speed%d", speed);
-- 
2.35.8


