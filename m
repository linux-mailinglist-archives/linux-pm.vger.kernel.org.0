Return-Path: <linux-pm+bounces-15055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FFD98D300
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 14:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E2E28324F
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 12:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473831D0405;
	Wed,  2 Oct 2024 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vCONkas1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B5B1D0151
	for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2024 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871769; cv=none; b=X6rHIWDttmOlsTP/LE3NXCx8gVHcNTfHdR+H8F81fOIuwYrqa4Wf1lA0CQXVILEU6mqQe+k+tEjG24ly1AMcqOk2RWKS7fODNUWjAzWuVvJwcnmgRSczVcIaOpqWC0F6dOl3wFqeBQTwl03Aidv+FIH/BXxB5WYnj6zWrxlDRYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871769; c=relaxed/simple;
	bh=X4NFsCvjfecv5yqdm2M15YFm3XbR+UbiVuUmlYW/wNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iBPQDvXwDkAlteatQPZRbFLCk5R8eCCg/QPGJUGA91gTdrbUbAfH+PgYYoyEiR/bLB4RuC2lFbd+K0A4hmEOerVOQK+nmGkhIw3S9HuCqx4ZsK8s/kjuqmm+ECTwzdPvRpInnk8lLrqrbKhliThXl3i7fp5mJWMj4JT/i0YIjSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vCONkas1; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5389917ef34so7730715e87.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2024 05:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727871765; x=1728476565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=floLT8azXrau0uBiWc2H3i8kWyeGNrZXbzjRyDzZNWA=;
        b=vCONkas15M40x1l4xYWk4yDU5sEmXY7dsNv/vouEfBvEa8QvQMihSZWR2rj5g50M0E
         IiTqWTqETHykkym1/LMONQF86alAVdGjjeG6M6opx3nMAvdiZpoU/jHSSFYzKBzLpmop
         9Hcfe5MMs5NnBv5gadg/w/xAS75oj6z2NXa55zEt7AyEusy9awbkzG9vKR+2JinX7MYr
         EooelARbb+OhsFc27kiZ8hRYAv92uSbsV1IPu1CTvNDP5SkxcWFyyNsMY2qqTEWKsxmq
         7wo8RKNQQVqjlYuN0dSVy7+p4j8wFRDZMBJicxgB1VvHKWtj4q8GOU7lkhivJhoHYDAs
         OC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727871765; x=1728476565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=floLT8azXrau0uBiWc2H3i8kWyeGNrZXbzjRyDzZNWA=;
        b=VrfbeD5szIBaa2jKHyslqkZz+nkdEpMgvkuezac79wVsHjj8mMMc5kCmtQPie+s4R/
         lXa0sdzTIefgo7YYqaEKz1G4CRTv+3RisZetJXrjTEJpAscZURcsHaYNw2jkFdlHjtpT
         I5yZz0XBZhmHYVh/jvsanrrrLH0w5/24m7WcI8H5SehcKhef4pQSngE02HkRGPdVIBVd
         OnUQJxhECHVT9lPq7LtNBAtdUutIxXtWl8yhgMXilI4DhvQwLQ8FZjfdIxrCaCZxkSSN
         H2Tx9CDRpD79Ohr78UCq/2FdAaUdkKNwyvf5LDEXfbJjNmh+n0EktjFiOCi47mcidm27
         +iig==
X-Forwarded-Encrypted: i=1; AJvYcCUyqlYaROZklJaQOI9Cwgwqj9SEuo0FRoTtSLC3HDI2B9Uvl48HsslnQWs6KHjYORXoUZRbG8FrpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXCLNViN0bBhuvhGt9P6ub/POPxohPnDDP65Tycv/ynq/OU9gg
	H4RAtWz1Md88Kx69acjysLa3xCDOiQ1k90FteVhzk0wAhAtMACEEasLko3M3dHc=
X-Google-Smtp-Source: AGHT+IGipWOmvHlQrLglkd+yAung3UQEpC+X/wwP2Q+EER4yzHDfTodUudPaHdOa/Q/fomec/vgvsQ==
X-Received: by 2002:a05:6512:2206:b0:530:aa82:a50a with SMTP id 2adb3069b0e04-539a0793c90mr1578500e87.45.1727871765278;
        Wed, 02 Oct 2024 05:22:45 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a043204fsm1912659e87.165.2024.10.02.05.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 05:22:44 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/11] OPP: Rework _set_required_devs() to manage a single device per call
Date: Wed,  2 Oct 2024 14:22:24 +0200
Message-Id: <20241002122232.194245-4-ulf.hansson@linaro.org>
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

At this point there are no consumer drivers that makes use of
_set_required_devs(), hence it should be straightforward to rework the code
to enable it to better integrate with the PM domain attach procedure.

During attach, one device at the time is being hooked up to its
corresponding PM domain. Therefore, let's update the _set_required_devs()
to align to this behaviour, allowing callers to fill out one required_dev
per call. Subsequent changes starts making use of this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- Lots of update. A re-review is needed.

---
 drivers/opp/core.c     | 81 ++++++++++++++++++++++++++++--------------
 drivers/opp/opp.h      |  4 ++-
 include/linux/pm_opp.h | 10 +++---
 3 files changed, 63 insertions(+), 32 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 3aa18737470f..42b7c8f2e71e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2473,47 +2473,72 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 
 }
 
-static int _opp_set_required_devs(struct opp_table *opp_table,
-				  struct device *dev,
-				  struct device **required_devs)
+static int _opp_set_required_dev(struct opp_table *opp_table,
+				 struct device *dev,
+				 struct device *required_dev,
+				 unsigned int index)
 {
-	int i;
+	struct opp_table *required_table, *pd_table;
+	struct device *gdev;
 
-	if (!opp_table->required_devs) {
+	/* Genpd core takes care of propagation to parent genpd */
+	if (opp_table->is_genpd) {
+		dev_err(dev, "%s: Operation not supported for genpds\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	if (index >= opp_table->required_opp_count) {
 		dev_err(dev, "Required OPPs not available, can't set required devs\n");
 		return -EINVAL;
 	}
 
-	/* Another device that shares the OPP table has set the required devs ? */
-	if (opp_table->required_devs[0])
-		return 0;
+	required_table = opp_table->required_opp_tables[index];
+	if (IS_ERR(required_table)) {
+		dev_err(dev, "Missing OPP table, unable to set the required devs\n");
+		return -ENODEV;
+	}
 
-	for (i = 0; i < opp_table->required_opp_count; i++) {
-		/* Genpd core takes care of propagation to parent genpd */
-		if (required_devs[i] && opp_table->is_genpd &&
-		    opp_table->required_opp_tables[i]->is_genpd) {
-			dev_err(dev, "%s: Operation not supported for genpds\n", __func__);
-			return -EOPNOTSUPP;
+	/*
+	 * The required_opp_tables parsing is not perfect, as the OPP core does
+	 * the parsing solely based on the DT node pointers. The core sets the
+	 * required_opp_tables entry to the first OPP table in the "opp_tables"
+	 * list, that matches with the node pointer.
+	 *
+	 * If the target DT OPP table is used by multiple devices and they all
+	 * create separate instances of 'struct opp_table' from it, then it is
+	 * possible that the required_opp_tables entry may be set to the
+	 * incorrect sibling device.
+	 *
+	 * Cross check it again and fix if required.
+	 */
+	gdev = dev_to_genpd_dev(required_dev);
+	if (IS_ERR(gdev))
+		return PTR_ERR(gdev);
+
+	pd_table = _find_opp_table(gdev);
+	if (!IS_ERR(pd_table)) {
+		if (pd_table != required_table) {
+			dev_pm_opp_put_opp_table(required_table);
+			opp_table->required_opp_tables[index] = pd_table;
+		} else {
+			dev_pm_opp_put_opp_table(pd_table);
 		}
-
-		opp_table->required_devs[i] = required_devs[i];
 	}
 
+	opp_table->required_devs[index] = required_dev;
 	return 0;
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
 
@@ -2641,13 +2666,15 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 			goto err;
 
 		data->flags |= OPP_CONFIG_GENPD;
-	} else if (config->required_devs) {
-		ret = _opp_set_required_devs(opp_table, dev,
-					     config->required_devs);
+	} else if (config->required_dev) {
+		ret = _opp_set_required_dev(opp_table, dev,
+					    config->required_dev,
+					    config->required_dev_index);
 		if (ret)
 			goto err;
 
-		data->flags |= OPP_CONFIG_REQUIRED_DEVS;
+		data->index = config->required_dev_index;
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
index 6424692c30b7..bc74bc69107a 100644
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
+ * @required_dev_index: The index of the required OPP for the @required_dev.
  *
  * This structure contains platform specific OPP configurations for the device.
  */
@@ -81,7 +82,8 @@ struct dev_pm_opp_config {
 	const char * const *regulator_names;
 	const char * const *genpd_names;
 	struct device ***virt_devs;
-	struct device **required_devs;
+	struct device *required_dev;
+	unsigned int required_dev_index;
 };
 
 #define OPP_LEVEL_UNSET			U32_MAX
-- 
2.34.1


