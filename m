Return-Path: <linux-pm+bounces-9584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F249A90EFC1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 16:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5E3B20407
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122151527A0;
	Wed, 19 Jun 2024 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NdSfIRHU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFF5152524
	for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806154; cv=none; b=WjQJtHm8HNCq4gIJItxuFe9N72xkgaczUTS16xbnYm8BzZz629OVN+AaBQjubgLMMclpn4kkJX89GWLFZ0iHaaiSRJiJyWEanwffAXa3I09LodaCD6Hn3UZCP0P6M/MsD0jyOOrMr3BMnGanr+C0a7qb5Lo3tGEKHlrHVjosE/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806154; c=relaxed/simple;
	bh=r7WdFwdIx0SvBrhoxR/qHtGpCRe300sQa3NmHIufVxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q85w/bV5h87fPlo/2Yx03MAMvdEpdUwI/6S29UjU2hoFXoIqHoeour5XV0E2mTf8ujRL9wQc259ciznKjEp2HmAGG5faecJnR82nUkDPas25tS8H65Gj/V+4SKPvCRxVb1MoOlo2eZe3uIfFdcOFL9khF0CHGquEkXDhAKdRIM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NdSfIRHU; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52cc671f170so820087e87.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 07:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718806150; x=1719410950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJlwtJVzi6XNiVK5ZSTOV746RcDL3LF9tmFw5hjmIxo=;
        b=NdSfIRHUQLGX1+aZpgzO59rYyhDd+mNcpsuHilBoqGnXidcoqFfBi2Yg2gzXonqEow
         Dm6SlvTPv/2lu81v7B0F7Xvt43vpX/6v7pbfBO+fnV2MIX7PlCLAT3Vp2CFoNhoSQUB5
         qhLZXlexWocdoUTMysJzcerzGvfU6+YBKOq6oJN6n5LXEn3+mWFN6wLwmyW0F7Q1eEhI
         oaCCBrd4D9QjM2Dhp0NkRIzEGdl+MVFac/ObLbTCQoECae+cf+0ZQQj9N/Eape6U6jJ0
         M7oQOBC5Z7EFi4QtlFwQO3gy0s677IdVXKy5bkkzF9t0Skxw8IxTx2JzVEUVDQ4e6+db
         OKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806150; x=1719410950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJlwtJVzi6XNiVK5ZSTOV746RcDL3LF9tmFw5hjmIxo=;
        b=NITM7o2CXo/tTV4n2AbfTVlCt2UWU8eJnEtzEOnVfxO46bqZub83zgnSxvVc0BmLCg
         E+75j93Jms171rGuPTCmWWkT/pwuSqqiDUNVWwvcvv9QliCYMuJl+vK4QGH1okvItS+Q
         LW6OjzXiuxZgPvAjnZo2dWKPQpQFpfeszysUGM4Z5uVbuNGJ+LaQ6fb41fTXGi8vA9OC
         CNQ6BhHjkEbpRmtB1X4zGdH7KWlk/GIVDdPS9NxYAnZUvm8ftaK1WOGYK6PhRoNqDY+Q
         MRVz0UGuLCkUP2gfIM8LaU91KVcATvcJd+4iSCEpulIyt+6ozteDJtVfJ5q2JOLpsTRD
         o2yA==
X-Forwarded-Encrypted: i=1; AJvYcCWLbSkfpFUP1WLEYE7UuPdGiTjldiX+CL+fVqFAxeOW3qTEmvZ2mN6916ZYc0ubjnd+243LyRvU7rlNgy9Rq55rm+E0+C+SVv8=
X-Gm-Message-State: AOJu0YwP43iNwQSbGNBAoZ3Cj27rDzL1Xmle1VsKdUQoa4OJX69xhysC
	ZkC6PvR6X1FIT+MzUNBPxg3qIbksAV0Wqsz6Z4C24GERBVtWMJgTecEOwMDhAns=
X-Google-Smtp-Source: AGHT+IH8szx+wGfNF7xCKKOXXggxhUc5i6OCYEwmr+61pe4qfUaU6Uy78GSQKKnrYH7d3bzd2PkMRA==
X-Received: by 2002:a05:6512:31d4:b0:52c:c64e:b902 with SMTP id 2adb3069b0e04-52cca1ea264mr869272e87.27.1718806148309;
        Wed, 19 Jun 2024 07:09:08 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2872241sm1787003e87.124.2024.06.19.07.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:09:07 -0700 (PDT)
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
Subject: [PATCH 3/7] OPP: Rework _set_required_devs() to manage a single device per call
Date: Wed, 19 Jun 2024 16:08:45 +0200
Message-Id: <20240619140849.368580-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619140849.368580-1-ulf.hansson@linaro.org>
References: <20240619140849.368580-1-ulf.hansson@linaro.org>
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
 drivers/opp/core.c     | 89 +++++++++++++++++++++++++++++-------------
 drivers/opp/opp.h      |  4 +-
 include/linux/pm_opp.h | 10 +++--
 3 files changed, 71 insertions(+), 32 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 02ba963d11ff..bc1ed1d3d60d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2483,9 +2483,10 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 
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
 
@@ -2494,36 +2495,68 @@ static int _opp_set_required_devs(struct opp_table *opp_table,
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
+
+		/* Move to the next available index. */
+		if (opp_table->required_devs[i])
+			continue;
 
-		opp_table->required_devs[i] = required_devs[i];
+		/*
+		 * We need to compare the nodes for the OPP tables, rather than
+		 * the OPP tables themselves, as we may have separate instances.
+		 */
+		if (required_opp_table->np == table->np) {
+
+			/* Cross check the OPP tables and fix it if needed. */
+			if (required_opp_table != table) {
+				dev_pm_opp_put_opp_table(table);
+				_get_opp_table_kref(required_opp_table);
+				opp_table->required_opp_tables[i] = required_opp_table;
+			}
+
+			opp_table->required_devs[i] = required_dev;
+
+			/*
+			 * Add the required_dev as a user of the OPP table, so
+			 * we can call dev_pm_opp_set_opp() on it directly.
+			 */
+			if (!_add_opp_dev(required_dev, required_opp_table)) {
+				dev_err(dev, "Failed to add the device to the required OPP table\n");
+				return -ENOMEM;
+			}
+
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
 
@@ -2640,7 +2673,7 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 
 	/* Attach genpds */
 	if (config->genpd_names) {
-		if (config->required_devs)
+		if (config->required_dev)
 			goto err;
 
 		ret = _opp_attach_genpd(opp_table, dev, config->genpd_names,
@@ -2649,13 +2682,15 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
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
index dd7c8441af42..2b6599f6037d 100644
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


