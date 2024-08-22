Return-Path: <linux-pm+bounces-12781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EB895C10C
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 00:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F271F24813
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 22:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3945B1D2F6C;
	Thu, 22 Aug 2024 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VD/yZl27"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A4817E006
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366774; cv=none; b=hx7TtSc7OzsVFYTvcQDczG3/eyLjxzuHEchvQXz+WxLJWgPbBYv0w43AXFYsFf862d7vY/hHR9HQnoROD02b+EwpyjKC872E7ropMHrus2JN+RUwAI933I7vWjdmdQRngCR96cT+chvIvre3aHXlAoXNb8LS/E0yNoQBX7+YKl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366774; c=relaxed/simple;
	bh=kYws5feVcAp5TCTiYhNwS/JM4enNtl/LEnARtxGFF3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YWtb8h8XIWlOrX6dqHFxD8cW8yPVO+0YXYIPudmnaZOfnubTTGQCeVhDr3CHPs/D3C2vqal7UnDjp09sK6+DJ/r3L51HVQBEfOWe3OTlBPx1wYQYYYwlwooOEkBoVxRBqHfxn6LaKZXtVHuTG5D6gv0to3fBjaosXZFW00mkjyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VD/yZl27; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f40a1a2c1aso8748361fa.3
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 15:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724366770; x=1724971570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StJQRqCUVSSiSwu+3Mjs57fSdgGfFXaPCc1PsB3TzNQ=;
        b=VD/yZl27SA6t5R3fvsyAkDGFePeZjZkAaHB6oGxUqMf1e+cVsbGowljG8SHPVuDVO3
         wS6x0hZn8UBY/DC5dTwrxpjusVuZqdJmPKexhbFPsymxhIzi/4muepCF+gMrVqTtUQqD
         c5ItPaFhnp85U7LSl56vpNu0TwGilTZaQHDDJM+Hbm/ix1lnhoPQWZW4PE6uKyFfJnv6
         0FAxUBuZnmOd8pHlZpl3rALWslBBZWVo6xeFJohQSGQeRI6v5CPpVY1UCzNpkP1Uvb9D
         2HXDgXQubOSr4OM5kyLr+JBJf3AyrkPefetOiQ+CM5TDbq2yoUgjl6okZi80LZTE/JG2
         iPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724366770; x=1724971570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StJQRqCUVSSiSwu+3Mjs57fSdgGfFXaPCc1PsB3TzNQ=;
        b=MZRiNqPFwTZEP+yBQmG/kwf+p7t/WBUpR27e43c53xfJRH99ycH5TY8T9/rzyaiPAM
         zDMYA1JlyV3Hn+NmDl6916WguQ4eiHIMaZwzkZRvEYx4JEXgnXZFGVMAt+WJyVEVeZFO
         xH6KfCfxiE0IqBj/4SFMnh8IVQgCo1DFBYX9Pz/na4OC8HQrOkxHGX01MMTZGwxdb7/N
         J+QvfbXKGLYqdAgB3RU55LV5tPEc8AbKJT9JdnxR/z93OpIxO7MU/AHI/kpDIV7eEJbj
         5NZonv3vyCuNwlv/p+VWM8bLJWVM6r5on705snV/Yjd9V3bwcYk8KffmXLt0SlFQ/xXg
         biTg==
X-Forwarded-Encrypted: i=1; AJvYcCXNtT+FM4vlHXt9NaVZWkXjyJG6FChL/Oeirq74PtypCeudKStUJoU00W6MtOBt31YMtHRJhJt4+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOB/HTjT5OSAyTtqXgHlJ+i4jJOKtiFkN8jd+yz5BhDVM2xvjp
	2D5TwFu3Sae7ZTq/Spv6ogNmr4fVsOmk2o6WbhesUeduRQNn2cEnSynQPLRtRC4=
X-Google-Smtp-Source: AGHT+IGZamYSbygv3IkTZMVDGmekn9pjg+mdj2f5WolkNXH5KSnZ+vzYw3XXkDNayrwgkV2Bn3eurg==
X-Received: by 2002:a05:6512:3b88:b0:532:c197:393e with SMTP id 2adb3069b0e04-5343882d172mr169993e87.11.1724366770078;
        Thu, 22 Aug 2024 15:46:10 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea362a4sm379443e87.66.2024.08.22.15.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 15:46:09 -0700 (PDT)
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
Subject: [PATCH v3 04/10] OPP/pmdomain: Set the required_dev for a required OPP during genpd attach
Date: Fri, 23 Aug 2024 00:45:41 +0200
Message-Id: <20240822224547.385095-5-ulf.hansson@linaro.org>
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

Through dev_pm_opp_set_config() the _opp_attach_genpd() allows consumer
drivers to attach a device to its PM domains. Their corresponding virtual
devices that are created by genpd during attach, are later being assigned
as the required_devs for the corresponding required OPPs. In principle,
using dev_pm_opp_set_config() for this works fine.

However, attaching a device to its PM domains is in general better done
with dev_pm_domain_attach|detach_list(). To avoid having two different ways
to manage this, let's prepare for the removal of _opp_attach_genpd().

More precisely, let's assign the required_devs during device attach in
genpd, by using _opp_set_required_dev(). In this way, the consumer driver
can rely solely on dev_pm_domain_attach|detach_list() to attach its device
to its PM domains.

Note that, we still need to allow existing users of _opp_attach_genpd(),
which makes this change slightly more complicated. On the other hand, once
we have migrated those users to dev_pm_domain_attach|detach_list(), the
entire _opp_attach_genpd() can be removed.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Clarified the commitmsg.
Changes in v2:
	- Clarified the commitmsg.
	- Add a check for #power-domain-cells in genpd to avoid assigning the
	required-devs for non-genpd-providers.
---
 drivers/opp/core.c      | 35 +-----------------------
 drivers/pmdomain/core.c | 59 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 34 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index b6a699286aaa..cad7e84c9ad3 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2369,7 +2369,6 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
 			continue;
 
 		dev_pm_domain_detach(opp_table->required_devs[index], false);
-		opp_table->required_devs[index] = NULL;
 	}
 }
 
@@ -2393,8 +2392,7 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
 static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 			const char * const *names, struct device ***virt_devs)
 {
-	struct device *virt_dev, *gdev;
-	struct opp_table *genpd_table;
+	struct device *virt_dev;
 	int index = 0, ret = -EINVAL;
 	const char * const *name = names;
 
@@ -2427,37 +2425,6 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 			goto err;
 		}
 
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
 		index++;
 		name++;
 	}
diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 08c2192c02b4..0749da94624f 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2884,6 +2884,61 @@ static void genpd_dev_pm_sync(struct device *dev)
 	genpd_queue_power_off_work(pd);
 }
 
+static struct opp_table *genpd_find_opp_table(struct generic_pm_domain *genpd,
+					      unsigned int depth)
+{
+	struct opp_table *opp_table;
+	struct gpd_link *link;
+
+	if (genpd->opp_table)
+		return genpd->opp_table;
+
+	list_for_each_entry(link, &genpd->child_links, child_node) {
+		struct generic_pm_domain *parent = link->parent;
+
+		genpd_lock_nested(parent, depth + 1);
+		opp_table = genpd_find_opp_table(parent, depth + 1);
+		genpd_unlock(parent);
+
+		if (opp_table)
+			return opp_table;
+	}
+
+	return NULL;
+}
+
+static int genpd_set_required_opp_dev(struct device *dev,
+				      struct device *base_dev)
+{
+	struct generic_pm_domain *genpd = dev_to_genpd(dev);
+	struct opp_table *opp_table;
+	int ret = 0;
+
+	/* Limit support to non-providers for now. */
+	if (of_property_present(base_dev->of_node, "#power-domain-cells"))
+		return 0;
+
+	if (!dev_pm_opp_of_has_required_opp(base_dev))
+		return 0;
+
+	genpd_lock(genpd);
+	opp_table = genpd_find_opp_table(genpd, 0);
+	genpd_unlock(genpd);
+
+	if (opp_table) {
+		struct dev_pm_opp_config config = {
+			.required_dev = dev,
+			.required_opp_table = opp_table,
+		};
+
+		ret = devm_pm_opp_set_config(base_dev, &config);
+		if (ret < 0)
+			dev_err(dev, "failed to set opp config %d\n", ret);
+	}
+
+	return ret;
+}
+
 static int genpd_set_required_opp(struct device *dev, unsigned int index)
 {
 	int ret, pstate;
@@ -2940,6 +2995,10 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 	dev->pm_domain->detach = genpd_dev_pm_detach;
 	dev->pm_domain->sync = genpd_dev_pm_sync;
 
+	ret = genpd_set_required_opp_dev(dev, base_dev);
+	if (ret)
+		goto err;
+
 	ret = genpd_set_required_opp(dev, index);
 	if (ret)
 		goto err;
-- 
2.34.1


