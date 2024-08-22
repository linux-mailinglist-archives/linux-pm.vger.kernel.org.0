Return-Path: <linux-pm+bounces-12780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B3F95C10A
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 00:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 367EAB21511
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 22:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF001D2F47;
	Thu, 22 Aug 2024 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uRcgXjBa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949EA1D1F68
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366772; cv=none; b=k+E1aGGHrlMHPnwXWiMx3OqPlmHfPxiLlpTbbXHV2UTQo4dCUVx3/NpLYgO63Xi/UYknAQ/d9Bemp1L8mv2zvO7XrzIhWQ0xTBOQ2sJEKkvAmArKBiXUoHXl0jx3oa9QeI+XHmhTn0qy1UEj+IjIQtrkngrgCv2/Zeu1TqCioag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366772; c=relaxed/simple;
	bh=WdnHFE8/V90EQ5qUO1bLdMKKNLwX5wtnv0epXeooAd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GgPuOXm0VpE5pzgZ5F0ltxekwum3GVbb+7clRmDQTPbFY/yK14M/QyK0Et1hkykhumkTfD0CP+YS8b/oHGXCSVGKN0Jno9nlLmW/IAKO60QNMZGhqEJc0XjmkhnWFwfb+fDkj5i/GJAIwPudscyzQ+GPLCyTxGkGclCifD/+qqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uRcgXjBa; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso1630694e87.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 15:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724366767; x=1724971567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvx3dtDyuaLtWvQBN1ccLzAdA+uGExJd6lwl1p/+zuE=;
        b=uRcgXjBanJMDcZ8Y9zmj6If03scUGabH/lyycgOnSa3PC7UecrHRxlu97fbbfdfCQ4
         NZC9gcx2quEbEDmqtlgl9m3znp1tOosYHsGewBFYTF7TbXwxPTcZfSLFwls1z28SE0Rs
         eeKIG7kJPsNT0NNALN0FvsosOzqeUHpJF5UWPcC9McpkCQY53W6xgUa0rRv/UlU8r5f8
         cafTx3etf7N5Fb0FSvB5YUCiOxo3BCf3jZ1vYGc9VkljQGjzaRL4zBOrkznOK+1Ibqfw
         qFiuI0vxp8VOaLGKMK66fMeFbX1gL+iPdQopwrWyitpmuQsjOICDcQEYavIu7bSKUSdV
         kYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724366767; x=1724971567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvx3dtDyuaLtWvQBN1ccLzAdA+uGExJd6lwl1p/+zuE=;
        b=HcmVK6Sv1LED6DKnKLnNb3jbHVQLkIAJsW6l+aZ2Am70IuMSAQ7k4G1av0Fbbe5kQE
         OfpSqDwamsDedr8LKCc0v3WjA8k5bHvxnk+RWehOvwHgiFUbu/mrIRPX51T7q31eF0WE
         wRKMr7X2pU3l4meTJh21fClsGO7xiCu54bQ1oyAgDfwhcZNvflyt5ONp9Js00mCr8s5H
         te777PEtNa0GSiP4YvcUFmR++jQ7SCgHBaV6ie8juoZbk/dgMcYY9qUH/EEG9L0JcshP
         DquCEPKcf0PIK23T+1yJZ8eGCvmPf3bPMRTAN+8rHK6zGYMIUZVNxY7FHBB+jktrXh6B
         rGXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqIJawO1a9FpWxWVp+wDqsW0nJsUtmF2eTIUXDs1cSXW5JH4Y4oIXPYtT5ej+l7Gk4sxKbKqPQ+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxKnhUzFE1f23TPRG8xCrGTZFZ3TPsbFwn/sf9oj1SZHdv6yLp
	3jGZ5oICLM28a+85ATqOdOmtpzI/qj0NQz2lA9soHiMalmU6JlRbR7aSUA/zZGE=
X-Google-Smtp-Source: AGHT+IGxvA4Uq9Y8lvyO5rIqpEo5VlzIQ99oKaiGIrLuFmsy7/2BQLTwlcgbwEWVVwymuZXSfzR59g==
X-Received: by 2002:ac2:4e09:0:b0:52e:941d:7039 with SMTP id 2adb3069b0e04-5343886c9bdmr183956e87.59.1724366767061;
        Thu, 22 Aug 2024 15:46:07 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea362a4sm379443e87.66.2024.08.22.15.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 15:46:06 -0700 (PDT)
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
Subject: [PATCH v3 02/10] OPP: Rework _set_required_devs() to manage a single device per call
Date: Fri, 23 Aug 2024 00:45:39 +0200
Message-Id: <20240822224547.385095-3-ulf.hansson@linaro.org>
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

At this point there are no consumer drivers that makes use of
_set_required_devs(), hence it should be straightforward to rework the code
to enable it to better integrate with the genpd attach procedure.

During attach, one device at the time is being hooked up to its
corresponding PM domain. Therefore, let's update the _set_required_devs()
to align to this behaviour, allowing callers to fill out one required_dev
per call.

As shown from a subsequent change, genpd becomes the first user of the
reworked _set_required_dev().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Clarified the commitmsg.

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


