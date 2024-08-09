Return-Path: <linux-pm+bounces-12053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A38A94D55E
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 19:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF15A282988
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 17:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707B649630;
	Fri,  9 Aug 2024 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgNvtuVK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D59314F70;
	Fri,  9 Aug 2024 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224305; cv=none; b=sgTNzPzSln7CMhyGzwUQBgu4rlXKrBJqDT+7MLt4q1EVJ71RjL+GGILSJ0sWc5BgFU7Nu1nOEjSN1uf1w5vQgbiW/+YxYf6mcu6K0DLYhR6EwDEykhy739lpAVpZmwJ4O250CWaMDlbzNKk+DQepldPTH00AGnaj8VCX+Cni51Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224305; c=relaxed/simple;
	bh=DQOfsEX2Un26oH82FuDvvRuhCP7yObI46puLbuELVbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfqH9Cdx7xqHH0SJ7d4fLx9XNWInDRIrzF1KUSQSfbMhThPt6d4P5L2nxILR2Nu+Yq0mb1ojlN+24FaDWoB2zFWr7LsnGOlHNmujaFgJG5U71luVrdDtQQPBEChA1wXXu49GGpLQMOg0Nscps/pLBRs6TrZC0N9Pd0maI4gB8C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgNvtuVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A1EC32782;
	Fri,  9 Aug 2024 17:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723224304;
	bh=DQOfsEX2Un26oH82FuDvvRuhCP7yObI46puLbuELVbM=;
	h=From:To:Cc:Subject:Date:From;
	b=mgNvtuVKUSAfv0qDsgFw5zpF4qa/SHt9d46Cn+Dex9ZbyCZobtBu20hrgCTcXP1Oh
	 5f3TSPq+B9BV0tANf+kVX8GAgnNoh+tyO7uDENg+84hXQe/A4ULz6hsIKA14/CM5nC
	 XeUNoQSs1epcqsKPlMJq1+7YQckrOBKAGq6/lazvfVOIr5YAs5UWfhG+OnF488RkX6
	 2XCicRtbZiACB5iVayJbUT4tHlCSYS9mINdW86lu1COE4PqF12d0DLEyFjL3y/iFXo
	 MKJuRL8hk6aPzShQSJsWy3OkM26QjlzlMCyMYZRvZ1iJcDb/n+8ySx7ZXnRRh8m+j2
	 4meU19r7S0VQA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ilia Lin <ilia.lin@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel test robot <lkp@intel.com>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] cpufreq: Fix warning on unused of_device_id tables for !CONFIG_OF
Date: Fri,  9 Aug 2024 11:24:38 -0600
Message-ID: <20240809172439.908092-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

!CONFIG_OF builds cause warnings on unused of_device_id tables. This is
due to of_match_node() being a macro rather than static inline function.
Add a __maybe_unused annotation to the of_device_id tables.

Fixes: c7582ec85342 ("cpufreq: Drop CONFIG_ARM and CONFIG_ARM64 dependency on Arm drivers")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408090714.wcrqU6Pk-lkp@intel.com/
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Note that 0-day only reported 1 warning, but x86 W=1 build gave me these
4.
---
 drivers/cpufreq/apple-soc-cpufreq.c  | 2 +-
 drivers/cpufreq/mediatek-cpufreq.c   | 2 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 2 +-
 drivers/cpufreq/ti-cpufreq.c         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index af34c22fa273..4dcacab9b4bf 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -85,7 +85,7 @@ static const struct apple_soc_cpufreq_info soc_default_info = {
 	.cur_pstate_mask = 0, /* fallback */
 };
 
-static const struct of_device_id apple_soc_cpufreq_of_match[] = {
+static const struct of_device_id apple_soc_cpufreq_of_match[] __maybe_unused = {
 	{
 		.compatible = "apple,t8103-cluster-cpufreq",
 		.data = &soc_t8103_info,
diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 3a1aadaa723c..663f61565cf7 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -738,7 +738,7 @@ static const struct mtk_cpufreq_platform_data mt8516_platform_data = {
 };
 
 /* List of machines supported by this driver */
-static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
+static const struct of_device_id mtk_cpufreq_machines[] __initconst __maybe_unused = {
 	{ .compatible = "mediatek,mt2701", .data = &mt2701_platform_data },
 	{ .compatible = "mediatek,mt2712", .data = &mt2701_platform_data },
 	{ .compatible = "mediatek,mt7622", .data = &mt7622_platform_data },
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 939702dfa73f..703308fb891a 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -611,7 +611,7 @@ static struct platform_driver qcom_cpufreq_driver = {
 	},
 };
 
-static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
+static const struct of_device_id qcom_cpufreq_match_list[] __initconst __maybe_unused = {
 	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
 	{ .compatible = "qcom,msm8909", .data = &match_data_msm8909 },
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 4d3f27958fbd..220fff7a302e 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -419,7 +419,7 @@ static int ti_cpufreq_setup_syscon_register(struct ti_cpufreq_data *opp_data)
 	return 0;
 }
 
-static const struct of_device_id ti_cpufreq_of_match[] = {
+static const struct of_device_id ti_cpufreq_of_match[]  __maybe_unused = {
 	{ .compatible = "ti,am33xx", .data = &am3x_soc_data, },
 	{ .compatible = "ti,am3517", .data = &am3517_soc_data, },
 	{ .compatible = "ti,am43", .data = &am4x_soc_data, },
-- 
2.43.0


