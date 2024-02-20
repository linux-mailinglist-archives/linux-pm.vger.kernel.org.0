Return-Path: <linux-pm+bounces-4103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3050385B3D6
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 08:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82AFAB2387A
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 07:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271845A4D5;
	Tue, 20 Feb 2024 07:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="shXeenAW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1AD5A7AE
	for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413743; cv=none; b=M7mX0Db9Yj2khHeVLkILoUe6ZPOFcK+/nmepMp2L9Lbu40y1L5iZzvaMefRDtb7i4O5biFIYge1ByH7w8AfhCH2fQbkZPqMrMYOgQXMOXLG4BRe0x7LyBYluq1DlzpCEmukUHh5Qj5H2vytFjnFvrZ9540rvmxtXEs/wszP5284=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413743; c=relaxed/simple;
	bh=LGEekiMz1MuQlgMUTzt2/pfYsfBxAob5BHRAMdbsDgI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Az4FBjbq7KMev+cj+3EVbQ1Vxc9joz6ihfldT1YNDdCgScBN+QWMkI869hnM+0yA0/ymrGYngvnsZSzxnZiZD8YszU0QSxQpl9CX+LM8u+Gg3AN1TKpZudTB2Gq1xPKi3+CjSt8b0DHPjJPtFw82KybV51UYnCE+9f+su9O17kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=shXeenAW; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4127077ee20so402935e9.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Feb 2024 23:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708413738; x=1709018538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BIo3+G26RYj97IhyrbqNGg5wn0wlq5Qdvj0YBvaCoZM=;
        b=shXeenAWqhQ0Dm97VY8EHi/2doq9IkSZWL8UYDkXF97mD4VeJDSMMgg3KR4DX9S8jB
         5omLtcfQTuFsYrrlU9ST5w6Hi9BENZ0sXd4I4mT5UTjf4MjCltQvhlOaQvIHC/wrY2Ab
         0LfI/HSu6eoGh3A30AzpKbNqiWqf472PrgsqUSvrul9HgcK61z15dXtk6pAy5CGFb81c
         l1OHOtBdfQ0DrrXec0sjBGg5OsPzBbWt3R3YNuvc2HznVRFyt5qeSYzOslVCUsDT3o9S
         LAQc7G3sCtyVWAalfqclB8iedqufD/4ZG67Y3XNYuVgQSdFi4BXPfrVBA8sYrBJ+PflH
         7HMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708413738; x=1709018538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIo3+G26RYj97IhyrbqNGg5wn0wlq5Qdvj0YBvaCoZM=;
        b=lg68a1FMgyavX86NN3VwWI2n6/swuv1HW1K+F0VCh9N/1F5pSZN5BGkjAjL/tZWz1n
         QnfGAwUKjoooSsO38G/W4qrj3kys3vd2ZX7+DT2AJFxvarh4YgZwsaTL6IfW11mYkdyw
         599leQdV9+giF7qIfIi1GiKEvQ2c513etKlaAZjYijAqDYAmBKOQ1WIZw/P/yETkAiWE
         l1UnfJdltjFfZqBpyUyXYhYFiEVcAx7n1NBBikvkBjijcbW0xd6xr0PNQpX0SyNkm1u1
         nwoiGsoa3Uiitrj0Hb4RT5SAXqnvJyVXX+m+my3n5uvTg9M8vacLDdt9Bz0lVfIN2lzH
         TBNA==
X-Forwarded-Encrypted: i=1; AJvYcCVgC2jWWTUKtt32w0LtEMHdNcoay5zk9L14FHXxaLh8fJVQfBI7mcMue5MU1jJ4pAllNTTrCA1QenT7GJQJySM9IWDQBGk3E5A=
X-Gm-Message-State: AOJu0YwC6ILk2oQHIxHB5Z20U9qDOMIeV3nmq5AqIue6ZD22GhjNWZ9A
	57zw4GcDsBtEGIak5+/ZXbVnUtfoTZuukkFQNQJRKRjgk5e/mjNcpzNxiRJPkvg=
X-Google-Smtp-Source: AGHT+IFsiqErb4YdGF8aE7+74ruUZ+0bGR7/Jcn7dJsjwREy1wAfV5T5SYZ5Qe7idjSIi0rak2+F+g==
X-Received: by 2002:a5d:62cc:0:b0:33d:3ad2:67ae with SMTP id o12-20020a5d62cc000000b0033d3ad267aemr5015404wrv.57.1708413738557;
        Mon, 19 Feb 2024 23:22:18 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id m17-20020a5d4a11000000b0033cf4e47496sm12424045wrq.51.2024.02.19.23.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 23:22:18 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Georgi Djakov <djakov@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	=?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org
Cc: Thierry Reding <treding@nvidia.com>
Subject: [PATCH v2] interconnect: constify of_phandle_args in xlate
Date: Tue, 20 Feb 2024 08:22:13 +0100
Message-Id: <20240220072213.35779-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xlate callbacks are supposed to translate of_phandle_args to proper
provider without modifying the of_phandle_args.  Make the argument
pointer to const for code safety and readability.

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Thierry Reding <treding@nvidia.com> # Tegra
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Drop unrelated gpiolib changes (Konrad, Thierry).
2. Add tags.
---
 drivers/interconnect/core.c            |  4 ++--
 drivers/interconnect/qcom/icc-common.c |  3 ++-
 drivers/interconnect/qcom/icc-common.h |  3 ++-
 drivers/interconnect/samsung/exynos.c  |  2 +-
 drivers/memory/tegra/mc.c              |  2 +-
 drivers/memory/tegra/tegra124-emc.c    |  2 +-
 drivers/memory/tegra/tegra124.c        |  2 +-
 drivers/memory/tegra/tegra186-emc.c    |  2 +-
 drivers/memory/tegra/tegra20-emc.c     |  2 +-
 drivers/memory/tegra/tegra20.c         |  2 +-
 drivers/memory/tegra/tegra30-emc.c     |  2 +-
 drivers/memory/tegra/tegra30.c         |  2 +-
 include/linux/interconnect-provider.h  | 11 ++++++-----
 include/soc/tegra/mc.h                 |  7 ++++---
 14 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 50bac2d79d9b..5d1010cafed8 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -343,7 +343,7 @@ EXPORT_SYMBOL_GPL(icc_std_aggregate);
  * an array of icc nodes specified in the icc_onecell_data struct when
  * registering the provider.
  */
-struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
+struct icc_node *of_icc_xlate_onecell(const struct of_phandle_args *spec,
 				      void *data)
 {
 	struct icc_onecell_data *icc_data = data;
@@ -368,7 +368,7 @@ EXPORT_SYMBOL_GPL(of_icc_xlate_onecell);
  * Returns a valid pointer to struct icc_node_data on success or ERR_PTR()
  * on failure.
  */
-struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec)
+struct icc_node_data *of_icc_get_from_provider(const struct of_phandle_args *spec)
 {
 	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
 	struct icc_node_data *data = NULL;
diff --git a/drivers/interconnect/qcom/icc-common.c b/drivers/interconnect/qcom/icc-common.c
index f27f4fdc4531..9b9ee113f172 100644
--- a/drivers/interconnect/qcom/icc-common.c
+++ b/drivers/interconnect/qcom/icc-common.c
@@ -9,7 +9,8 @@
 
 #include "icc-common.h"
 
-struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data)
+struct icc_node_data *qcom_icc_xlate_extended(const struct of_phandle_args *spec,
+					      void *data)
 {
 	struct icc_node_data *ndata;
 	struct icc_node *node;
diff --git a/drivers/interconnect/qcom/icc-common.h b/drivers/interconnect/qcom/icc-common.h
index 33bb2c38dff3..21c39b163948 100644
--- a/drivers/interconnect/qcom/icc-common.h
+++ b/drivers/interconnect/qcom/icc-common.h
@@ -8,6 +8,7 @@
 
 #include <linux/interconnect-provider.h>
 
-struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data);
+struct icc_node_data *qcom_icc_xlate_extended(const struct of_phandle_args *spec,
+					      void *data);
 
 #endif
diff --git a/drivers/interconnect/samsung/exynos.c b/drivers/interconnect/samsung/exynos.c
index 1ba14cb45d5a..c9e5361e17c5 100644
--- a/drivers/interconnect/samsung/exynos.c
+++ b/drivers/interconnect/samsung/exynos.c
@@ -82,7 +82,7 @@ static int exynos_generic_icc_set(struct icc_node *src, struct icc_node *dst)
 	return 0;
 }
 
-static struct icc_node *exynos_generic_icc_xlate(struct of_phandle_args *spec,
+static struct icc_node *exynos_generic_icc_xlate(const struct of_phandle_args *spec,
 						 void *data)
 {
 	struct exynos_icc_priv *priv = data;
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index a083921a8968..224b488794e5 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -755,7 +755,7 @@ const char *const tegra_mc_error_names[8] = {
 	[6] = "SMMU translation error",
 };
 
-struct icc_node *tegra_mc_icc_xlate(struct of_phandle_args *spec, void *data)
+struct icc_node *tegra_mc_icc_xlate(const struct of_phandle_args *spec, void *data)
 {
 	struct tegra_mc *mc = icc_provider_to_tegra_mc(data);
 	struct icc_node *node;
diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 00ed2b6a0d1b..47c0c19e13fd 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -1285,7 +1285,7 @@ to_tegra_emc_provider(struct icc_provider *provider)
 }
 
 static struct icc_node_data *
-emc_of_icc_xlate_extended(struct of_phandle_args *spec, void *data)
+emc_of_icc_xlate_extended(const struct of_phandle_args *spec, void *data)
 {
 	struct icc_provider *provider = data;
 	struct icc_node_data *ndata;
diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index 470b7dbab2c2..9d7393e19f12 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -1170,7 +1170,7 @@ static int tegra124_mc_icc_aggreate(struct icc_node *node, u32 tag, u32 avg_bw,
 }
 
 static struct icc_node_data *
-tegra124_mc_of_icc_xlate_extended(struct of_phandle_args *spec, void *data)
+tegra124_mc_of_icc_xlate_extended(const struct of_phandle_args *spec, void *data)
 {
 	struct tegra_mc *mc = icc_provider_to_tegra_mc(data);
 	const struct tegra_mc_client *client;
diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index fcd4aea48bda..57d9ae12fcfe 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -236,7 +236,7 @@ static int tegra_emc_icc_set_bw(struct icc_node *src, struct icc_node *dst)
 }
 
 static struct icc_node *
-tegra_emc_of_icc_xlate(struct of_phandle_args *spec, void *data)
+tegra_emc_of_icc_xlate(const struct of_phandle_args *spec, void *data)
 {
 	struct icc_provider *provider = data;
 	struct icc_node *node;
diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index fd595c851a27..97cf59523b0b 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -950,7 +950,7 @@ to_tegra_emc_provider(struct icc_provider *provider)
 }
 
 static struct icc_node_data *
-emc_of_icc_xlate_extended(struct of_phandle_args *spec, void *data)
+emc_of_icc_xlate_extended(const struct of_phandle_args *spec, void *data)
 {
 	struct icc_provider *provider = data;
 	struct icc_node_data *ndata;
diff --git a/drivers/memory/tegra/tegra20.c b/drivers/memory/tegra/tegra20.c
index aa4b97d5e732..a3022e715dee 100644
--- a/drivers/memory/tegra/tegra20.c
+++ b/drivers/memory/tegra/tegra20.c
@@ -390,7 +390,7 @@ static int tegra20_mc_icc_aggreate(struct icc_node *node, u32 tag, u32 avg_bw,
 }
 
 static struct icc_node_data *
-tegra20_mc_of_icc_xlate_extended(struct of_phandle_args *spec, void *data)
+tegra20_mc_of_icc_xlate_extended(const struct of_phandle_args *spec, void *data)
 {
 	struct tegra_mc *mc = icc_provider_to_tegra_mc(data);
 	unsigned int i, idx = spec->args[0];
diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 9eae25c57ec6..d7b0a23c2d7d 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -1468,7 +1468,7 @@ to_tegra_emc_provider(struct icc_provider *provider)
 }
 
 static struct icc_node_data *
-emc_of_icc_xlate_extended(struct of_phandle_args *spec, void *data)
+emc_of_icc_xlate_extended(const struct of_phandle_args *spec, void *data)
 {
 	struct icc_provider *provider = data;
 	struct icc_node_data *ndata;
diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index 06f8b35e0a14..d3e685c8431f 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -1332,7 +1332,7 @@ static int tegra30_mc_icc_aggreate(struct icc_node *node, u32 tag, u32 avg_bw,
 }
 
 static struct icc_node_data *
-tegra30_mc_of_icc_xlate_extended(struct of_phandle_args *spec, void *data)
+tegra30_mc_of_icc_xlate_extended(const struct of_phandle_args *spec, void *data)
 {
 	struct tegra_mc *mc = icc_provider_to_tegra_mc(data);
 	const struct tegra_mc_client *client;
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 7ba183f221f1..f5aef8784692 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -36,7 +36,7 @@ struct icc_onecell_data {
 	struct icc_node *nodes[] __counted_by(num_nodes);
 };
 
-struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
+struct icc_node *of_icc_xlate_onecell(const struct of_phandle_args *spec,
 				      void *data);
 
 /**
@@ -65,8 +65,9 @@ struct icc_provider {
 			 u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
 	void (*pre_aggregate)(struct icc_node *node);
 	int (*get_bw)(struct icc_node *node, u32 *avg, u32 *peak);
-	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
-	struct icc_node_data* (*xlate_extended)(struct of_phandle_args *spec, void *data);
+	struct icc_node* (*xlate)(const struct of_phandle_args *spec, void *data);
+	struct icc_node_data* (*xlate_extended)(const struct of_phandle_args *spec,
+						void *data);
 	struct device		*dev;
 	int			users;
 	bool			inter_set;
@@ -124,7 +125,7 @@ int icc_nodes_remove(struct icc_provider *provider);
 void icc_provider_init(struct icc_provider *provider);
 int icc_provider_register(struct icc_provider *provider);
 void icc_provider_deregister(struct icc_provider *provider);
-struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec);
+struct icc_node_data *of_icc_get_from_provider(const struct of_phandle_args *spec);
 void icc_sync_state(struct device *dev);
 
 #else
@@ -171,7 +172,7 @@ static inline int icc_provider_register(struct icc_provider *provider)
 
 static inline void icc_provider_deregister(struct icc_provider *provider) { }
 
-static inline struct icc_node_data *of_icc_get_from_provider(struct of_phandle_args *spec)
+static inline struct icc_node_data *of_icc_get_from_provider(const struct of_phandle_args *spec)
 {
 	return ERR_PTR(-ENOTSUPP);
 }
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index af1d73a7f0cd..6ee4c59db620 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -146,13 +146,14 @@ struct tegra_mc_icc_ops {
 	int (*set)(struct icc_node *src, struct icc_node *dst);
 	int (*aggregate)(struct icc_node *node, u32 tag, u32 avg_bw,
 			 u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
-	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
-	struct icc_node_data *(*xlate_extended)(struct of_phandle_args *spec,
+	struct icc_node* (*xlate)(const struct of_phandle_args *spec, void *data);
+	struct icc_node_data *(*xlate_extended)(const struct of_phandle_args *spec,
 						void *data);
 	int (*get_bw)(struct icc_node *node, u32 *avg, u32 *peak);
 };
 
-struct icc_node *tegra_mc_icc_xlate(struct of_phandle_args *spec, void *data);
+struct icc_node *tegra_mc_icc_xlate(const struct of_phandle_args *spec,
+				    void *data);
 extern const struct tegra_mc_icc_ops tegra_mc_icc_ops;
 
 struct tegra_mc_ops {
-- 
2.34.1


