Return-Path: <linux-pm+bounces-33515-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7BEB3D76C
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 05:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D2E3B1ADF
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 03:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEF3237707;
	Mon,  1 Sep 2025 03:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDJTAjwa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B572B223DD0;
	Mon,  1 Sep 2025 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756697664; cv=none; b=XBwysyvXVUvjBGtqX27tmmmVzLADX+KynjpDPDB1xkou58ozFdwoFpAy2OBqHmaid9b1Cbaq0ewwoQ3hVXfKowiHSHcvr7K3osHZQWRZj0UAv9/yi5XlV2xg/FhhhKasqSu6GnDk8nrn7oT1dVnxLa4fZjB9LcvGO+t2A6bmalY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756697664; c=relaxed/simple;
	bh=BKe3rw3YctsLXqkrtMOW6fQhzekowbwuSEaXRAbhv5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DwgXpUsV3YKC2xNZ9I/N45JO7RGFEPIXMzkgtNhapB3SnhThVpjnSG/WaepE1yoNovFzstyMB5aMPDPVJy2x3rIg9/xayvWjmX2L6MEh88qGBEKoJpR16Q5JJxnRzoleai6BU4woX8FLvrc+8htTvGtuQiX6Az5min6kOi+wjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDJTAjwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AEC3C4CEFA;
	Mon,  1 Sep 2025 03:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756697664;
	bh=BKe3rw3YctsLXqkrtMOW6fQhzekowbwuSEaXRAbhv5A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IDJTAjwajYPt2DmW4RZAqbH78RE8SWLsRB1gXLpiYAZfOotJbKyPBm9xo3zlIcN4L
	 pB9m0c4Oh7zod1apULUsUobpRZjzvZIMZr9Xd5iRPLowPiCIIpXr60oxhLBJ3gmrdN
	 r9HW6KaBE/3Lnxm/1In4tgQJ1I9gFjQncmAteHUSd4jWoWQF3icZ3XYMKNHtHa7ujd
	 v445oFKa9CF+PDu12hWeCkYJwUJxYaIAbYdsMOVkWxWLFb4BpO5DnQWxq4Ia9/ses0
	 KmBNbDiUpZELVIN0qdnjU7PBuVPN4t8IrbyiOI3kGY4mY+oQxjCzClsCwr9pkzpa9Y
	 xsdYoszUpbo2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A205CA1000;
	Mon,  1 Sep 2025 03:34:24 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 31 Aug 2025 22:33:52 -0500
Subject: [PATCH 4/8] memory: tegra186-emc: Support non-bpmp icc scaling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250831-tegra186-icc-v1-4-607ddc53b507@gmail.com>
References: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
In-Reply-To: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756697663; l=5749;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=nugNxNxYRHTU1Ah7DRFanUlqmkAHHZfFkwW/lWONkrk=;
 b=S5TROv7iE9e0xCzpglyFSafpRM359kRHrBmko4f7rDzF2zGDVLCfYmdWa79hINg41ke5qKmMS
 ZhearxNVvp0Djkg3KApdc3ME2s8gD0lTFEMy922IArF0Z+BaoCCqhBX
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

This adds support for dynamic frequency scaling of external memory on
devices with bpmp firmware that does not support bwmgr.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/memory/tegra/tegra186-emc.c | 132 +++++++++++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index d6cd90c7ad5380a9ff9052a60f62c9bcc4fdac5f..1711f2e85ad07692feb8f6f14c8c2b10ea42fde5 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -18,6 +18,17 @@ struct tegra186_emc_dvfs {
 	unsigned long rate;
 };
 
+enum emc_rate_request_type {
+	EMC_RATE_DEBUG,
+	EMC_RATE_ICC,
+	EMC_RATE_TYPE_MAX,
+};
+
+struct emc_rate_request {
+	unsigned long min_rate;
+	unsigned long max_rate;
+};
+
 struct tegra186_emc {
 	struct tegra_bpmp *bpmp;
 	struct device *dev;
@@ -33,8 +44,90 @@ struct tegra186_emc {
 	} debugfs;
 
 	struct icc_provider provider;
+
+	/*
+	 * There are multiple sources in the EMC driver which could request
+	 * a min/max clock rate, these rates are contained in this array.
+	 */
+	struct emc_rate_request requested_rate[EMC_RATE_TYPE_MAX];
+
+	/* protect shared rate-change code path */
+	struct mutex rate_lock;
 };
 
+static void tegra_emc_rate_requests_init(struct tegra186_emc *emc)
+{
+	unsigned int i;
+
+	for (i = 0; i < EMC_RATE_TYPE_MAX; i++) {
+		emc->requested_rate[i].min_rate = 0;
+		emc->requested_rate[i].max_rate = ULONG_MAX;
+	}
+}
+
+static int emc_request_rate(struct tegra186_emc *emc,
+			    unsigned long new_min_rate,
+			    unsigned long new_max_rate,
+			    enum emc_rate_request_type type)
+{
+	struct emc_rate_request *req = emc->requested_rate;
+	unsigned long min_rate = 0, max_rate = ULONG_MAX;
+	unsigned int i;
+	int err;
+
+	/* select minimum and maximum rates among the requested rates */
+	for (i = 0; i < EMC_RATE_TYPE_MAX; i++, req++) {
+		if (i == type) {
+			min_rate = max(new_min_rate, min_rate);
+			max_rate = min(new_max_rate, max_rate);
+		} else {
+			min_rate = max(req->min_rate, min_rate);
+			max_rate = min(req->max_rate, max_rate);
+		}
+	}
+
+	if (min_rate > max_rate) {
+		dev_err_ratelimited(emc->dev, "%s: type %u: out of range: %lu %lu\n",
+				    __func__, type, min_rate, max_rate);
+		return -ERANGE;
+	}
+
+	err = clk_set_rate(emc->clk, min_rate);
+	if (err)
+		return err;
+
+	emc->requested_rate[type].min_rate = new_min_rate;
+	emc->requested_rate[type].max_rate = new_max_rate;
+
+	return 0;
+}
+
+static int emc_set_min_rate(struct tegra186_emc *emc, unsigned long rate,
+			    enum emc_rate_request_type type)
+{
+	struct emc_rate_request *req = &emc->requested_rate[type];
+	int ret;
+
+	mutex_lock(&emc->rate_lock);
+	ret = emc_request_rate(emc, rate, req->max_rate, type);
+	mutex_unlock(&emc->rate_lock);
+
+	return ret;
+}
+
+static int emc_set_max_rate(struct tegra186_emc *emc, unsigned long rate,
+			    enum emc_rate_request_type type)
+{
+	struct emc_rate_request *req = &emc->requested_rate[type];
+	int ret;
+
+	mutex_lock(&emc->rate_lock);
+	ret = emc_request_rate(emc, req->min_rate, rate, type);
+	mutex_unlock(&emc->rate_lock);
+
+	return ret;
+}
+
 /*
  * debugfs interface
  *
@@ -107,7 +200,7 @@ static int tegra186_emc_debug_min_rate_set(void *data, u64 rate)
 	if (!tegra186_emc_validate_rate(emc, rate))
 		return -EINVAL;
 
-	err = clk_set_min_rate(emc->clk, rate);
+	err = emc_set_min_rate(emc, rate, EMC_RATE_DEBUG);
 	if (err < 0)
 		return err;
 
@@ -137,7 +230,7 @@ static int tegra186_emc_debug_max_rate_set(void *data, u64 rate)
 	if (!tegra186_emc_validate_rate(emc, rate))
 		return -EINVAL;
 
-	err = clk_set_max_rate(emc->clk, rate);
+	err = emc_set_max_rate(emc, rate, EMC_RATE_DEBUG);
 	if (err < 0)
 		return err;
 
@@ -217,6 +310,12 @@ static int tegra186_emc_get_emc_dvfs_latency(struct tegra186_emc *emc)
 	return 0;
 }
 
+static inline struct tegra186_emc *
+to_tegra186_emc_provider(struct icc_provider *provider)
+{
+	return container_of(provider, struct tegra186_emc, provider);
+}
+
 /*
  * tegra_emc_icc_set_bw() - Set BW api for EMC provider
  * @src: ICC node for External Memory Controller (EMC)
@@ -227,6 +326,33 @@ static int tegra186_emc_get_emc_dvfs_latency(struct tegra186_emc *emc)
  */
 static int tegra_emc_icc_set_bw(struct icc_node *src, struct icc_node *dst)
 {
+	struct tegra186_emc *emc = to_tegra186_emc_provider(dst->provider);
+	struct tegra_mc *mc = dev_get_drvdata(emc->dev->parent);
+	unsigned long long peak_bw = icc_units_to_bps(dst->peak_bw);
+	unsigned long long avg_bw = icc_units_to_bps(dst->avg_bw);
+	unsigned long long rate = max(avg_bw, peak_bw);
+	const unsigned int ddr = 2;
+	int err;
+
+	/*
+	 * Do nothing here if bwmgr is supported in BPMP-FW. BPMP-FW sets the final
+	 * Freq based on the passed values.
+	 */
+	if (mc->bwmgr_mrq_supported)
+		return 0;
+
+	/*
+	 * Tegra186 EMC runs on a clock rate of SDRAM bus. This means that
+	 * EMC clock rate is twice smaller than the peak data rate because
+	 * data is sampled on both EMC clock edges.
+	 */
+	do_div(rate, ddr);
+	rate = min_t(u64, rate, U32_MAX);
+
+	err = emc_set_min_rate(emc, rate, EMC_RATE_ICC);
+	if (err)
+		return err;
+
 	return 0;
 }
 
@@ -334,6 +460,8 @@ static int tegra186_emc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, emc);
 	emc->dev = &pdev->dev;
 
+	tegra_emc_rate_requests_init(emc);
+
 	if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_EMC_DVFS_LATENCY)) {
 		err = tegra186_emc_get_emc_dvfs_latency(emc);
 		if (err)

-- 
2.50.1



