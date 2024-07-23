Return-Path: <linux-pm+bounces-11345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A833393A32A
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 16:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0061FB228EB
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7C215748C;
	Tue, 23 Jul 2024 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hBS8UFdO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5EF156F46
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721746001; cv=none; b=JCaTmJosmdcfugCkJ5QNOp3FWM3u/103GLBauaX/8hPt/2vcCzsZ2nVUBaTLOmDuKlRlcJtgkMb8v8S+dEucIUGBT56Teapf5tmMkDKdKGcVtMpD5PaHhWgCAH4KfcIU9aNNvHNavmrbTlMlbMCD5vOgXg5m1eHYYHFYjpKFCFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721746001; c=relaxed/simple;
	bh=amoWYev3rPnJKUB49T3A+2z9/9V8qrykIM/9P/sEwf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j8OZtokllyyob6hXbOVDwtMY3gVdQ0TZdtwktoeC2ktTVgCELUNB8+DEedTrYDZxEarECptpPNZqZkIqf1p8Iycb2ivK7ScdkP7MfTTsKmrreFhJ2PGLCraiv/ufbT08Vvh0yE18JzUn2O4zdlRvkg1tBKm4IC4ZJnsSOoZ4rWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hBS8UFdO; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ef2cce8c08so27803441fa.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 07:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721745998; x=1722350798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1r6mQjxdA5Ycu1o4JlXvEuFhP6RdDyjqQdXSFbqbnuk=;
        b=hBS8UFdORXpGI3k46tFgQrT3aM1Fk1lpwdkD379kK96tJ7pmpIEIzdjUqRO9VB8L0s
         7wpd2ta0ru9PjSSU0f8PpGvyf2eZKCa2Xp6D8XWPfi8lFgj/oVSpr8nFYO9QQBTVBYuI
         dUbLirW/cbRL/Fr1+TbkaP8aDX2kky0mE06WesQK8lHzVRdP8Qp0RQ9ECjW3rDzHKAxp
         TmVwh5cTfwdocDOyANbBNQCEg+Gkx6pHBJv1x6HPYY5lH6Px1tJQm1fMQUEf6GMzwpCb
         k/NwaZ9H4goXkJsxpdR22zvK0VzS/zdmplTgGyGM5zd0+0mnIbFC8K72oVKmNjqeG17m
         PIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745998; x=1722350798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1r6mQjxdA5Ycu1o4JlXvEuFhP6RdDyjqQdXSFbqbnuk=;
        b=I8tGWW2Fj7BZxKmrnIp8GhUC+T2uBIThmDkmTJY4EdqwchJLDsbNjLg5HX4zzbA84P
         m88u4DByRmNsiZEgG6pHdPCfq6O0amm3FP27Vpg2iekJQ/E7yqyAlYE7JdBDtMP43nQZ
         Pb9TE9vd2TgNQCb4+c9Gl6rbs53k3Y93iRnd2f+JErtOYsfrtoi4HWjjt2kX1dVy3e6+
         g6PrsfjLhNAaNRsic60my6GyAHf5efLUBk7vvanpMbLtCIMmPuPmcKWLX0k2EcnoXfOC
         ejBECV4fzZD401EN+xxNk1mJioKAR9dMdCdc9eB7jAYPQzMHvuaG055qdgLT8rv5ywjr
         EtkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUs9Jx8YXfDjDbi06m33vABITTs0wo7pquZL65OzLmuNuyH9uqxkyQCcIGhQaV3GMBhRQaBBcFZ41ve0bRBoJQKLDa/BDQ/LQ=
X-Gm-Message-State: AOJu0Yxj//uBgOh4V1RPEbkRnHBfPIdx3e5hH3e4kiy1Djm78mFs7asr
	wuNVOFgM+T8pJYWdMo91QavSIGpnQhdvQYYRmJ8HCtBZIP1tWaKUE0l6HFkr0Xg=
X-Google-Smtp-Source: AGHT+IF4JXt63g3aJOtD34L0D3D22CnPoBsXJUr8hYUB/3dr0SeT1SQm94wxj0Gjpxn1WXB5Y5YwJw==
X-Received: by 2002:a05:6512:1048:b0:52f:c3c9:1691 with SMTP id 2adb3069b0e04-52fc404d27bmr2282609e87.32.1721745997599;
        Tue, 23 Jul 2024 07:46:37 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52f0415eb08sm774540e87.9.2024.07.23.07.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:46:37 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] OPP: Drop redundant _opp_attach|detach_genpd()
Date: Tue, 23 Jul 2024 16:46:10 +0200
Message-Id: <20240723144610.564273-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723144610.564273-1-ulf.hansson@linaro.org>
References: <20240723144610.564273-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There no longer any users of _opp_attach|detach_genpd(), hence let's drop
it along with the corresponding exported functions.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
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


