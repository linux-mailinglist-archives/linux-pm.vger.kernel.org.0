Return-Path: <linux-pm+bounces-15063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8FA98D320
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 14:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9BF283C9B
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 12:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B65A1D0BBA;
	Wed,  2 Oct 2024 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajrdUhGQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8D61D0B9B
	for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2024 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871786; cv=none; b=dCF4P57MGB5sSi3iSokd/E/i0PwMkPmwcBxMa8WdFDr//hYDylmpn1PJo73GioVDhutNPiELYwpYTi4T9ppi/Gm11Ffp0j5WwJUiZUOIaHqhNW2T75P83Mpbo5RWLbCz36b5wokljuQ7Z87PfXfzEJHOrYT9J9M9QXufME3XYIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871786; c=relaxed/simple;
	bh=B+cxcgnBoCbaeNr/2/pJBjD+nouj1vfJ4FbwWfvcU8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f9+R/vhAjGnxqQ8JE/RvtESq5uGxHDRRiZaW9+EXTuLV7Vl6mZl57CtuDEyGAEsd1h/fJP8mm02PlxK139FyxQ4p04GNSw6tFhVYIjGBPFzzAMNv2Fs5DBPGv8pQT8cKei89Pfl8lsVoGnh7sHapFb96DkEPrL6l6afpX1Zlr0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ajrdUhGQ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53993c115cfso4202406e87.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2024 05:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727871782; x=1728476582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/TIVUQtU3PI71l1Gg1zwcb6OPzLgVwsx6x/KydYFvA=;
        b=ajrdUhGQJ4X540cSO3QmFF6ArknkA+VgLOI6S61KDlDibFtYOAkqLgfI7SlpSx1yzS
         N9AFRod+hqZHvbqTyjKoU/Uox9ws0LCe3sCaswc6BcuiEI/14in+EY1lGi9zAVOa5k4u
         dqZEob9D66w4Xj9DrPQMLqnutbl6QH5TEVDoryjO2VbFhr7nD/mRBORxEe0jtSeIjgch
         LG0JcPNhNlECRlPZYADOI0UaCFH4Wx1RvtDx+ciZOl2u8hDvj+JBVZxBcrep/sTpe8Vj
         AOellouJV9FSEpe+Iil/2k88YsO+P6tmsV7U4pEQX/Svuh4IaFXXxisuGS4VAg825x1+
         ROiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727871782; x=1728476582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/TIVUQtU3PI71l1Gg1zwcb6OPzLgVwsx6x/KydYFvA=;
        b=FGo3MEnbuP6o9qHnTLWZi6D1Bs1jES/X4BiyWrmO57qyTVyc11Au+hJB9PUpBLKlCP
         7scqVs7jGtys8/ZNR7Bb4izDGhVGTFItTTOrX1xW2kWRKh8argWkzuJgSkyRc5Q+1oE3
         NgoLNHiaZ6fwpIGkm9um3zG1BOLSPQ+Z4MtYJEaehHYQLxfl9YCcznC0VUi51TxS4QRC
         i6jcuqj0/CZ67Xy3efiy6l6INXCc7jnKMXApy+XTip91mCGSg9gbOH8tM++A14dfv/lE
         mR6+BTuy8sDUPgykt8XJANGZp0X7vcm4m3eVfRJK5vbe/f0XHGUYHbBVp3MbOepgzk/I
         yx5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDLOlcbn18/U7SxlUz6GXW08g/NmejMPkRnxZFV+6pEXa78u+rH1uiNbX5Ue6XIwDVyfyEB8xGDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLtNeEss/CIdATu2U3pFzCFrSLqM0GpgAOFugb3DkGzoKjz0nH
	FZvJr1arbKHu6Ii4qWuQdBhonEGCRZIy5ttbHBWBhePXVNm0wvmhajR4S8mUEVE=
X-Google-Smtp-Source: AGHT+IFawbKX+I8rk+bpYYckI/zcGZtQxnHsS92WEjhwf3PwCQ2ejxH/QFVFPUhojNeLCdjjKr54Vg==
X-Received: by 2002:a05:6512:1393:b0:536:53c2:8179 with SMTP id 2adb3069b0e04-539a079e87fmr1798776e87.37.1727871781914;
        Wed, 02 Oct 2024 05:23:01 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a043204fsm1912659e87.165.2024.10.02.05.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 05:23:01 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Vedang Nagar <quic_vnagar@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ilia Lin <ilia.lin@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v4 11/11] OPP: Drop redundant *_opp_attach|detach_genpd()
Date: Wed,  2 Oct 2024 14:22:32 +0200
Message-Id: <20241002122232.194245-12-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002122232.194245-1-ulf.hansson@linaro.org>
References: <20241002122232.194245-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All users of *_opp_attach|detach_genpd(), have been converted to use
dev|devm_pm_domain_attach|detach_list(), hence let's drop it along with its
corresponding exported functions.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- A plain rebase.

---
 drivers/opp/core.c     | 131 +----------------------------------------
 drivers/opp/opp.h      |   3 +-
 include/linux/pm_opp.h |  38 +-----------
 3 files changed, 3 insertions(+), 169 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 42b7c8f2e71e..55c4c2c39a93 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2360,119 +2360,6 @@ static void _opp_put_config_regulators_helper(struct opp_table *opp_table)
 		opp_table->config_regulators = NULL;
 }
 
-static void _opp_detach_genpd(struct opp_table *opp_table)
-{
-	int index;
-
-	for (index = 0; index < opp_table->required_opp_count; index++) {
-		if (!opp_table->required_devs[index])
-			continue;
-
-		dev_pm_domain_detach(opp_table->required_devs[index], false);
-		opp_table->required_devs[index] = NULL;
-	}
-}
-
-/*
- * Multiple generic power domains for a device are supported with the help of
- * virtual genpd devices, which are created for each consumer device - genpd
- * pair. These are the device structures which are attached to the power domain
- * and are required by the OPP core to set the performance state of the genpd.
- * The same API also works for the case where single genpd is available and so
- * we don't need to support that separately.
- *
- * This helper will normally be called by the consumer driver of the device
- * "dev", as only that has details of the genpd names.
- *
- * This helper needs to be called once with a list of all genpd to attach.
- * Otherwise the original device structure will be used instead by the OPP core.
- *
- * The order of entries in the names array must match the order in which
- * "required-opps" are added in DT.
- */
-static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
-			const char * const *names, struct device ***virt_devs)
-{
-	struct device *virt_dev, *gdev;
-	struct opp_table *genpd_table;
-	int index = 0, ret = -EINVAL;
-	const char * const *name = names;
-
-	if (!opp_table->required_devs) {
-		dev_err(dev, "Required OPPs not available, can't attach genpd\n");
-		return -EINVAL;
-	}
-
-	/* Genpd core takes care of propagation to parent genpd */
-	if (opp_table->is_genpd) {
-		dev_err(dev, "%s: Operation not supported for genpds\n", __func__);
-		return -EOPNOTSUPP;
-	}
-
-	/* Checking only the first one is enough ? */
-	if (opp_table->required_devs[0])
-		return 0;
-
-	while (*name) {
-		if (index >= opp_table->required_opp_count) {
-			dev_err(dev, "Index can't be greater than required-opp-count - 1, %s (%d : %d)\n",
-				*name, opp_table->required_opp_count, index);
-			goto err;
-		}
-
-		virt_dev = dev_pm_domain_attach_by_name(dev, *name);
-		if (IS_ERR_OR_NULL(virt_dev)) {
-			ret = virt_dev ? PTR_ERR(virt_dev) : -ENODEV;
-			dev_err(dev, "Couldn't attach to pm_domain: %d\n", ret);
-			goto err;
-		}
-
-		/*
-		 * The required_opp_tables parsing is not perfect, as the OPP
-		 * core does the parsing solely based on the DT node pointers.
-		 * The core sets the required_opp_tables entry to the first OPP
-		 * table in the "opp_tables" list, that matches with the node
-		 * pointer.
-		 *
-		 * If the target DT OPP table is used by multiple devices and
-		 * they all create separate instances of 'struct opp_table' from
-		 * it, then it is possible that the required_opp_tables entry
-		 * may be set to the incorrect sibling device.
-		 *
-		 * Cross check it again and fix if required.
-		 */
-		gdev = dev_to_genpd_dev(virt_dev);
-		if (IS_ERR(gdev)) {
-			ret = PTR_ERR(gdev);
-			goto err;
-		}
-
-		genpd_table = _find_opp_table(gdev);
-		if (!IS_ERR(genpd_table)) {
-			if (genpd_table != opp_table->required_opp_tables[index]) {
-				dev_pm_opp_put_opp_table(opp_table->required_opp_tables[index]);
-				opp_table->required_opp_tables[index] = genpd_table;
-			} else {
-				dev_pm_opp_put_opp_table(genpd_table);
-			}
-		}
-
-		opp_table->required_devs[index] = virt_dev;
-		index++;
-		name++;
-	}
-
-	if (virt_devs)
-		*virt_devs = opp_table->required_devs;
-
-	return 0;
-
-err:
-	_opp_detach_genpd(opp_table);
-	return ret;
-
-}
-
 static int _opp_set_required_dev(struct opp_table *opp_table,
 				 struct device *dev,
 				 struct device *required_dev,
@@ -2539,9 +2426,6 @@ static void _opp_clear_config(struct opp_config_data *data)
 {
 	if (data->flags & OPP_CONFIG_REQUIRED_DEV)
 		_opp_put_required_dev(data->opp_table, data->index);
-	else if (data->flags & OPP_CONFIG_GENPD)
-		_opp_detach_genpd(data->opp_table);
-
 	if (data->flags & OPP_CONFIG_REGULATOR)
 		_opp_put_regulators(data->opp_table);
 	if (data->flags & OPP_CONFIG_SUPPORTED_HW)
@@ -2653,20 +2537,7 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 		data->flags |= OPP_CONFIG_REGULATOR;
 	}
 
-	/* Attach genpds */
-	if (config->genpd_names) {
-		if (config->required_devs) {
-			ret = -EINVAL;
-			goto err;
-		}
-
-		ret = _opp_attach_genpd(opp_table, dev, config->genpd_names,
-					config->virt_devs);
-		if (ret)
-			goto err;
-
-		data->flags |= OPP_CONFIG_GENPD;
-	} else if (config->required_dev) {
+	if (config->required_dev) {
 		ret = _opp_set_required_dev(opp_table, dev,
 					    config->required_dev,
 					    config->required_dev_index);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 5b5a4bd89c9e..318a4ecbabf1 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -34,8 +34,7 @@ extern struct list_head opp_tables;
 #define OPP_CONFIG_REGULATOR_HELPER	BIT(2)
 #define OPP_CONFIG_PROP_NAME		BIT(3)
 #define OPP_CONFIG_SUPPORTED_HW		BIT(4)
-#define OPP_CONFIG_GENPD		BIT(5)
-#define OPP_CONFIG_REQUIRED_DEV		BIT(6)
+#define OPP_CONFIG_REQUIRED_DEV		BIT(5)
 
 /**
  * struct opp_config_data - data for set config operations
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index bc74bc69107a..568183e3e641 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -62,11 +62,7 @@ typedef int (*config_clks_t)(struct device *dev, struct opp_table *opp_table,
  * @supported_hw: Array of hierarchy of versions to match.
  * @supported_hw_count: Number of elements in the array.
  * @regulator_names: Array of pointers to the names of the regulator, NULL terminated.
- * @genpd_names: Null terminated array of pointers containing names of genpd to
- *		attach. Mutually exclusive with required_dev.
- * @virt_devs: Pointer to return the array of genpd virtual devices. Mutually
- *		exclusive with required_dev.
- * @required_dev: Required OPP device. Mutually exclusive with genpd_names/virt_devs.
+ * @required_dev: The required OPP device.
  * @required_dev_index: The index of the required OPP for the @required_dev.
  *
  * This structure contains platform specific OPP configurations for the device.
@@ -80,8 +76,6 @@ struct dev_pm_opp_config {
 	const unsigned int *supported_hw;
 	unsigned int supported_hw_count;
 	const char * const *regulator_names;
-	const char * const *genpd_names;
-	struct device ***virt_devs;
 	struct device *required_dev;
 	unsigned int required_dev_index;
 };
@@ -677,36 +671,6 @@ static inline void dev_pm_opp_put_config_regulators(int token)
 	dev_pm_opp_clear_config(token);
 }
 
-/* genpd helpers */
-static inline int dev_pm_opp_attach_genpd(struct device *dev,
-					  const char * const *names,
-					  struct device ***virt_devs)
-{
-	struct dev_pm_opp_config config = {
-		.genpd_names = names,
-		.virt_devs = virt_devs,
-	};
-
-	return dev_pm_opp_set_config(dev, &config);
-}
-
-static inline void dev_pm_opp_detach_genpd(int token)
-{
-	dev_pm_opp_clear_config(token);
-}
-
-static inline int devm_pm_opp_attach_genpd(struct device *dev,
-					   const char * const *names,
-					   struct device ***virt_devs)
-{
-	struct dev_pm_opp_config config = {
-		.genpd_names = names,
-		.virt_devs = virt_devs,
-	};
-
-	return devm_pm_opp_set_config(dev, &config);
-}
-
 /* prop-name helpers */
 static inline int dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 {
-- 
2.34.1


