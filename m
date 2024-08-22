Return-Path: <linux-pm+bounces-12787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C0695C11A
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 00:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29F15B24998
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 22:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01331D417D;
	Thu, 22 Aug 2024 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9Y8KOdX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B41D4143
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366782; cv=none; b=MbelgxA06MPLh2abOkvZmVfq7i0eYySXZOBOPWlh1GFgjBCZAz5xVb3kXvvQaA7xajpLK4/iyAsIRHEvVzzM8KXmdL1ZZV6oUiK69HkHfb7AegEsjiDpfLGpSZeiR5VlYUpMKGjJlTyPiIQtKRBsZn+gJhbUMG+JHmWeiHFXUsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366782; c=relaxed/simple;
	bh=B+QYo/05J+LjG9pa7GZRM+j5LasnoK0b6yQeAZz29bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o9eszDm0ENXTdkxt+DDpXN5VLUdDEVl3cGZP6KeOrLdOJq1uis8rdJ/5zKV1mpp+eJN1IEZBdAgKmmptqNiX4JR0nvkVWPnej/gW/vBfgJO3X0dWtUM109CrDpnDtmIBJFPTemhxYFdi6IPCKPaPzfCzmdIhGYwtsiQTQGd+zpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b9Y8KOdX; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53349d3071eso1671254e87.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 15:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724366778; x=1724971578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VphURB1Gan/55uptQu3RfCpWor8wG0jCnNbpjQVr+aE=;
        b=b9Y8KOdXYy2tEkdyjH9tI726n/QiCiErvdulB+h9r6tYpFzkWrGEm5JvLYEL95snBH
         tpmbdy4zvRZbswbjoFvBCRUVgTY5wRidF6050EHmVNzLWZlDIpZnNIn3tSwpGMSKzUKj
         0tWuAKQo7LJo3tlCz70VOdrTyo8fw+rNmZbDl/KWQSfGIkqq4MKT0VPah4g3ysxu2Rml
         S9x6VRR6/jh/vU4fptgo5LDTAiSwslYwvUsR7+MBkL/iZHf/FA1mGoS6u27LhkpH2dTg
         MEUY/OvUEdBDkfGeT7Fe9RtZMMwdTy+dX4Vxtf+AG+4PG9Q8jWQ1+nbyvzjRawlaG4yI
         2ivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724366778; x=1724971578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VphURB1Gan/55uptQu3RfCpWor8wG0jCnNbpjQVr+aE=;
        b=DuHOBbUvNZyo+DAh6CHnRqyDP51TBYsu0xjPD1vD+hN664FchxhYyQVCM6Ogs/yi5e
         2fqhq7f3bpkWhrt6SVUwq0IjXg/8qBkkmYJ3dSRRULpk1OT5vTssinc76V+4VXwvJEy6
         O0sRRa9S2p6gEbAuxNcEGrxVFEoTctB6DXi6htOGZLFvD+/IXpIXTBI1Du00IBQuPMcO
         5+vqEWJ1mf15rj/3MI240nQudrTvpKgoOpDwPhHusCKlBCsQJn4QOxc1bKqYZpdiLs8Z
         sMcHb09uAOc0Cm4qyeG/T0vvCk6cjerHSYaCQp9RqnmU7CMOjPw1CIogBOb9Fh4d3vE5
         aQqA==
X-Forwarded-Encrypted: i=1; AJvYcCVEq2j5T59nD+dxrQrtdAnjMkUDgejCeFJPvXlAwIJiNi8vXs6L1amVz3hht1R426X5NZY4rZv95A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjhGgXlcwqMhpLWbbafjNS3Orr9+UPxjheDl/4jUIDRF6FVmC0
	+zWHGnIjo7xrXRNzEcg88W0pV6grhHqdRDgGeIQheF1WygevGotUtFfoMJ3HaPM=
X-Google-Smtp-Source: AGHT+IFXpNYl8qtj2IvlPSDp3CA4+6RBm9vf/UbMJ3jZi+owQVOFOxqR3Yik2fhh9EMH6VdRLWKJ4g==
X-Received: by 2002:a05:6512:31c4:b0:52e:f950:31f3 with SMTP id 2adb3069b0e04-53438785441mr234491e87.35.1724366778108;
        Thu, 22 Aug 2024 15:46:18 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea362a4sm379443e87.66.2024.08.22.15.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 15:46:17 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/10] OPP: Drop redundant _opp_attach|detach_genpd()
Date: Fri, 23 Aug 2024 00:45:47 +0200
Message-Id: <20240822224547.385095-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822224547.385095-1-ulf.hansson@linaro.org>
References: <20240822224547.385095-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All users of _opp_attach|detach_genpd(), have been converted to use
dev|devm_pm_domain_attach|detach_list(), hence let's drop it along with its
corresponding exported functions.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- None.

---
 drivers/opp/core.c     | 96 +-----------------------------------------
 drivers/opp/opp.h      |  3 +-
 include/linux/pm_opp.h | 38 +----------------
 3 files changed, 3 insertions(+), 134 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index cad7e84c9ad3..66cac7a1d9db 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2360,86 +2360,6 @@ static void _opp_put_config_regulators_helper(struct opp_table *opp_table)
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
-	struct device *virt_dev;
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
@@ -2516,9 +2436,6 @@ static void _opp_clear_config(struct opp_config_data *data)
 {
 	if (data->flags & OPP_CONFIG_REQUIRED_DEV)
 		_opp_put_required_dev(data->opp_table, data->index);
-	else if (data->flags & OPP_CONFIG_GENPD)
-		_opp_detach_genpd(data->opp_table);
-
 	if (data->flags & OPP_CONFIG_REGULATOR)
 		_opp_put_regulators(data->opp_table);
 	if (data->flags & OPP_CONFIG_SUPPORTED_HW)
@@ -2630,18 +2547,7 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 		data->flags |= OPP_CONFIG_REGULATOR;
 	}
 
-	/* Attach genpds */
-	if (config->genpd_names) {
-		if (config->required_dev)
-			goto err;
-
-		ret = _opp_attach_genpd(opp_table, dev, config->genpd_names,
-					config->virt_devs);
-		if (ret)
-			goto err;
-
-		data->flags |= OPP_CONFIG_GENPD;
-	} else if (config->required_dev && config->required_opp_table) {
+	if (config->required_dev && config->required_opp_table) {
 		ret = _opp_set_required_dev(opp_table, dev,
 					    config->required_dev,
 					    config->required_opp_table);
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
index 5fade5c4de40..451a7465a605 100644
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
+ * @required_dev: Required OPP device.
  * @required_opp_table: The corresponding required OPP table for @required_dev.
  *
  * This structure contains platform specific OPP configurations for the device.
@@ -80,8 +76,6 @@ struct dev_pm_opp_config {
 	const unsigned int *supported_hw;
 	unsigned int supported_hw_count;
 	const char * const *regulator_names;
-	const char * const *genpd_names;
-	struct device ***virt_devs;
 	struct device *required_dev;
 	struct opp_table *required_opp_table;
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


