Return-Path: <linux-pm+bounces-11237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3107E937132
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 01:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97031F22011
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 23:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECEE1474AE;
	Thu, 18 Jul 2024 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="InrzBhHo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195AF145FE3
	for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2024 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721346211; cv=none; b=kZ1TmW1i8AqX0D5WBPcEvJZpPcCf/nSOh0W1FbDGvpeKKFDu5Wnn1mxrjW4SICEkU0u2MgDPHNPXfCjpy+3L7Vxh6zuVWqXh11TZoTTiWXliF2jz5sa1FEKIW7HNfjTX1iME6X3qMBoV2y+UaTVdTquaXGcfFv72eznA3w9v8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721346211; c=relaxed/simple;
	bh=KHxh8gu+LTIzkPIdHss7t+y3pqREJ7xgjz13gbGvcbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H72xLPfu1IclgIXzdtg4Gk4v5tw9cG+ThDDx8kPyBXoagj0+bWTyPQJDJNpYO2xWVojowuBmqC5BsqTInjSz0i4jvTeOqbkhEkGw5C+mpZiT3KH2vHGYyQjHr2TcoMZvCpjkr9ASBL5AORBCkXpJaW0atcd23uc2RDZygwIIj/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=InrzBhHo; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52e9a550e9fso849950e87.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2024 16:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721346207; x=1721951007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0E4K3m18NzNAaiIJOKht8f12lpSSf/q6AadozsUAGZI=;
        b=InrzBhHog1B2qX1IxzVyyOppgqARAS+ZDLpNPYjZR11YkqCa6HliYKPT6PpNi9cR+s
         8AsaY1gi1glRkGhVXfiT4MyZ5vEO4HCscRc2Th0ASOkDnl442efStxDTcxOS/hxNEwiC
         vKZP6ir1+h9gvFCyGJdEOiI5j3H5fwENu9upse5EpBgL2OY24Wu9cmhxGGmi128e8bcY
         FAwoYnu6bbX3wR6FY8H6w5SyEDG3EWZNMBuCim0v5D5/J5UH3EeAqBioQk7BTY4aq0hD
         K+Y3dHDLJYjC6DJTXOg0dfvYfg/kjff46GxMsVo1eO4A72cLqbWj0TsOdX9EszvjoCew
         of3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721346207; x=1721951007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0E4K3m18NzNAaiIJOKht8f12lpSSf/q6AadozsUAGZI=;
        b=hC8K4O/uf8tmabxgok8jKQpJ24GiLTsifeRVDCeylZaY0xhkwoculVS6ZS17woBCGJ
         UEtmlE5F/drEEsTtUeKFAVXD6D/FYcdF8CJ5gF7W6nMqKEystnMA4zgfPz1zjs3aRKyD
         EQGf6cM6g3JljXrVE0XcgWr3LUSF1CvSuotkP0Sn3le4+yx0G+CkQ5QfFsU5uq5YkywU
         vLz0Iz2aZMWikHV4MX4EamLmPzug+XDRmRudsVIhJ0hUZLLLIE2GAMSctMCvfsrSJyFK
         wC/aYZkrw6fhERF+5jPs7zxsltGqnk1+50v3RVWamdYd8TGn25ql/nIEcAwnPlHSegFf
         GwPw==
X-Forwarded-Encrypted: i=1; AJvYcCVc9mu7qyTEbYolojmC0qqbu7COiQwKNyHrkuPClN9y1jq0Art1j2gzfsxz6Vy1gnJDZO/X1hC58Tky58fu4RPwSuQhQco9scA=
X-Gm-Message-State: AOJu0YyxBFre1BB2+E26v3W9h+o3+5Wx1PWZsmC+RNrxbcoK+m4nEGPk
	kf9bbvFLdIeP/MdtTZHwfSqIen3CptiMjAck+IMWHH9S/okbswoJSI6yweaX8LE=
X-Google-Smtp-Source: AGHT+IF4/9i2ZMuh/4tFXo5zf6/+vwOKWzikZWarKDokHXv+3/nfYbGMIJc93vRDdzW6MYNrmK/FGg==
X-Received: by 2002:a05:6512:10c5:b0:52e:7278:a39d with SMTP id 2adb3069b0e04-52ef0875a86mr753924e87.0.1721346207064;
        Thu, 18 Jul 2024 16:43:27 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef556b4fbsm22491e87.139.2024.07.18.16.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 16:43:26 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] OPP: Rework _set_required_devs() to manage a single device per call
Date: Fri, 19 Jul 2024 01:43:15 +0200
Message-Id: <20240718234319.356451-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718234319.356451-1-ulf.hansson@linaro.org>
References: <20240718234319.356451-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At this point there are no consumer drivers that makes use of
_set_required_devs(), hence it should be straightforward to rework the code
to enable it to better integrate with the genpd attach procedure.

During genpd attach, one device is being attached to its PM domain.
Therefore, let's also update the _set_required_devs() to work with this
behaviour and instead trust callers to fill out one required_dev per call.

Moving forward and as shown from a subsequent change, genpd becomes the
first user of the reworked _set_required_dev().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Addressed some comments from Viresh.
	- Drop calls to _add_opp_dev() for required_devs.
---
 drivers/opp/core.c     | 91 +++++++++++++++++++++++++++++-------------
 drivers/opp/opp.h      |  4 +-
 include/linux/pm_opp.h | 10 +++--
 3 files changed, 73 insertions(+), 32 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 494f8860220d..b6a699286aaa 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2473,9 +2473,10 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 
 }
 
-static int _opp_set_required_devs(struct opp_table *opp_table,
-				  struct device *dev,
-				  struct device **required_devs)
+static int _opp_set_required_dev(struct opp_table *opp_table,
+				 struct device *dev,
+				 struct device *required_dev,
+				 struct opp_table *required_opp_table)
 {
 	int i;
 
@@ -2484,36 +2485,70 @@ static int _opp_set_required_devs(struct opp_table *opp_table,
 		return -EINVAL;
 	}
 
-	/* Another device that shares the OPP table has set the required devs ? */
-	if (opp_table->required_devs[0])
-		return 0;
+	/* Genpd core takes care of propagation to parent genpd */
+	if (opp_table->is_genpd) {
+		dev_err(dev, "%s: Operation not supported for genpds\n", __func__);
+		return -EOPNOTSUPP;
+	}
 
 	for (i = 0; i < opp_table->required_opp_count; i++) {
-		/* Genpd core takes care of propagation to parent genpd */
-		if (required_devs[i] && opp_table->is_genpd &&
-		    opp_table->required_opp_tables[i]->is_genpd) {
-			dev_err(dev, "%s: Operation not supported for genpds\n", __func__);
-			return -EOPNOTSUPP;
-		}
+		struct opp_table *table = opp_table->required_opp_tables[i];
+
+		/*
+		 * The OPP table should be available at this point. If not, it's
+		 * not the one we are looking for.
+		 */
+		if (IS_ERR(table))
+			continue;
 
-		opp_table->required_devs[i] = required_devs[i];
+		/* Move to the next available index. */
+		if (opp_table->required_devs[i])
+			continue;
+
+		/*
+		 * We need to compare the nodes for the OPP tables, rather than
+		 * the OPP tables themselves, as we may have separate instances.
+		 */
+		if (required_opp_table->np == table->np) {
+			/*
+			 * The required_opp_tables parsing is not perfect, as
+			 * the OPP core does the parsing solely based on the DT
+			 * node pointers. The core sets the required_opp_tables
+			 * entry to the first OPP table in the "opp_tables"
+			 * list, that matches with the node pointer.
+			 *
+			 * If the target DT OPP table is used by multiple
+			 * devices and they all create separate instances of
+			 * 'struct opp_table' from it, then it is possible that
+			 * the required_opp_tables entry may be set to the
+			 * incorrect sibling device. Cross check it again and
+			 * fix if required.
+			 */
+			if (required_opp_table != table) {
+				dev_pm_opp_put_opp_table(table);
+				_get_opp_table_kref(required_opp_table);
+				opp_table->required_opp_tables[i] = required_opp_table;
+			}
+
+			opp_table->required_devs[i] = required_dev;
+			return i;
+		}
 	}
 
-	return 0;
+	dev_err(dev, "Missing OPP table, unable to set the required dev\n");
+	return -ENODEV;
 }
 
-static void _opp_put_required_devs(struct opp_table *opp_table)
+static void _opp_put_required_dev(struct opp_table *opp_table,
+				  unsigned int index)
 {
-	int i;
-
-	for (i = 0; i < opp_table->required_opp_count; i++)
-		opp_table->required_devs[i] = NULL;
+	opp_table->required_devs[index] = NULL;
 }
 
 static void _opp_clear_config(struct opp_config_data *data)
 {
-	if (data->flags & OPP_CONFIG_REQUIRED_DEVS)
-		_opp_put_required_devs(data->opp_table);
+	if (data->flags & OPP_CONFIG_REQUIRED_DEV)
+		_opp_put_required_dev(data->opp_table, data->index);
 	else if (data->flags & OPP_CONFIG_GENPD)
 		_opp_detach_genpd(data->opp_table);
 
@@ -2630,7 +2665,7 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 
 	/* Attach genpds */
 	if (config->genpd_names) {
-		if (config->required_devs)
+		if (config->required_dev)
 			goto err;
 
 		ret = _opp_attach_genpd(opp_table, dev, config->genpd_names,
@@ -2639,13 +2674,15 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 			goto err;
 
 		data->flags |= OPP_CONFIG_GENPD;
-	} else if (config->required_devs) {
-		ret = _opp_set_required_devs(opp_table, dev,
-					     config->required_devs);
-		if (ret)
+	} else if (config->required_dev && config->required_opp_table) {
+		ret = _opp_set_required_dev(opp_table, dev,
+					    config->required_dev,
+					    config->required_opp_table);
+		if (ret < 0)
 			goto err;
 
-		data->flags |= OPP_CONFIG_REQUIRED_DEVS;
+		data->index = ret;
+		data->flags |= OPP_CONFIG_REQUIRED_DEV;
 	}
 
 	ret = xa_alloc(&opp_configs, &id, data, XA_LIMIT(1, INT_MAX),
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index cff1fabd1ae3..5b5a4bd89c9e 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -35,12 +35,13 @@ extern struct list_head opp_tables;
 #define OPP_CONFIG_PROP_NAME		BIT(3)
 #define OPP_CONFIG_SUPPORTED_HW		BIT(4)
 #define OPP_CONFIG_GENPD		BIT(5)
-#define OPP_CONFIG_REQUIRED_DEVS	BIT(6)
+#define OPP_CONFIG_REQUIRED_DEV		BIT(6)
 
 /**
  * struct opp_config_data - data for set config operations
  * @opp_table: OPP table
  * @flags: OPP config flags
+ * @index: The position in the array of required_devs
  *
  * This structure stores the OPP config information for each OPP table
  * configuration by the callers.
@@ -48,6 +49,7 @@ extern struct list_head opp_tables;
 struct opp_config_data {
 	struct opp_table *opp_table;
 	unsigned int flags;
+	unsigned int index;
 };
 
 /**
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 6424692c30b7..5fade5c4de40 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -63,10 +63,11 @@ typedef int (*config_clks_t)(struct device *dev, struct opp_table *opp_table,
  * @supported_hw_count: Number of elements in the array.
  * @regulator_names: Array of pointers to the names of the regulator, NULL terminated.
  * @genpd_names: Null terminated array of pointers containing names of genpd to
- *		attach. Mutually exclusive with required_devs.
+ *		attach. Mutually exclusive with required_dev.
  * @virt_devs: Pointer to return the array of genpd virtual devices. Mutually
- *		exclusive with required_devs.
- * @required_devs: Required OPP devices. Mutually exclusive with genpd_names/virt_devs.
+ *		exclusive with required_dev.
+ * @required_dev: Required OPP device. Mutually exclusive with genpd_names/virt_devs.
+ * @required_opp_table: The corresponding required OPP table for @required_dev.
  *
  * This structure contains platform specific OPP configurations for the device.
  */
@@ -81,7 +82,8 @@ struct dev_pm_opp_config {
 	const char * const *regulator_names;
 	const char * const *genpd_names;
 	struct device ***virt_devs;
-	struct device **required_devs;
+	struct device *required_dev;
+	struct opp_table *required_opp_table;
 };
 
 #define OPP_LEVEL_UNSET			U32_MAX
-- 
2.34.1


