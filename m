Return-Path: <linux-pm+bounces-11239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC034937138
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 01:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28B6CB22309
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 23:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5F91482FE;
	Thu, 18 Jul 2024 23:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDoUzT2N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9EB1474B4
	for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2024 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721346213; cv=none; b=AU7JvL/8CsxlaC7eNc9J1jFJz8XMTMiS35WxrdVce/sTVp95shQ6AIsP7C6BLjUne6cHeQdcKkzM4vk8qpddxZ24ZRS4T8WcPlkPbYuqIedeunvtErAXiGPlCfECl0CVszCi39LsHE/MDnyopJbokv79QfiNclCj3jgb8YG8SA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721346213; c=relaxed/simple;
	bh=NAfpFw+HWYAoDaBWfwr80BMUDZiqy4N+6uqMB5AAJX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SU4SrKrzgSs1ecsCBuHfW7mdh8m2MX4/MyFlbQ5vWoS4jPBTKaNFmiRTZh4JxqnPe4kyFga0AxqC1i9KRs5Ciozh7Q4pt2iul3CusqXQQ4qLHXmMuwO+H0w7O9zAX75lhOcdj0ERw0s4FQq1PQQATORIVwkSTi3ecW518PeMPEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NDoUzT2N; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52e99060b0dso1109729e87.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2024 16:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721346209; x=1721951009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9vI4SwwGNFQB5ve0cZ2IKXbIbaFjJCx9WMpU5iHjvI=;
        b=NDoUzT2N5rNubEzf8c2tkC1qn9EcLuP/3SANWyx5XWHbSmlYqH21RG3HrWKHEr9Rpe
         DmDMPngr5Ww4YsnQPELkoo5nqtCb/DcbCDjVn2RBtLl5H9EA3v++ktKU1h3XNILxMrUA
         ZDteHFXCPS8hbgZTbD6axL/+qtN1EYwtVdCsnahiH2AnxXlS8g+TUKpAZ0qq2e6MpnhL
         Bv6/bf4y9RwzUN7LRpJ85ZJtiYnK8h40Fz3xwnDvhujA72b2AeLbWGWLd1t7oOnSqWLG
         s5PrnBQ8GzM/z3rWR6XG0otadG6HbpM8MkK5BjiJekobe0jIMeMa8TgJgsUd8HotcvWN
         a9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721346209; x=1721951009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9vI4SwwGNFQB5ve0cZ2IKXbIbaFjJCx9WMpU5iHjvI=;
        b=D+oAlgT3J4pL/t9/4nsKqT0RR4jAEOFsHgQOUriqhOny0rToIhZtHHfjY/k0Q1kuxg
         ubm5dBAhC3hoYXFTQA1yP1zOo62vDe9f+Qfez9U2GMvu9yqRJR7rlkFvrNm0MJbP4Mbx
         tHZhgrQ8yHu5ORvDGQCocR/7RdAT+qyh+YYLhrMuS2NsFpNEcRJ06F1zYrcDi6P0N8rd
         PiUSQbl1lXbQryx0jmcBb0u4D6uCXglF2MI2/LapIBpkIsjtGMHfXHUoSkEPoIAGGHDR
         +oPK6T2sAo9fVz5phe8E9QQ+cSjwfCzJdW2EnTDh0oBhhAOlnYoFFqypYacH0siiv2uT
         K+MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAgKhgjN1vFDO0WIqZDzwJgGd44wB8kGG/cZtCE+OuLyToQGA5SV2FNDa+o+7t+bvlqRLcRU+H6AW3Avkmsxm80Jrzqit/Rc8=
X-Gm-Message-State: AOJu0YxDxhXlqQ7l5pZnp0qVaIHGarQKdM+QrIyXaRb1dj9a+KC4Z77k
	PcSNfISQBfbYpBQgtae3oQqPKJANht3j274wmzfaJlUh3hvrVLRgdb6eBUtmyFQ=
X-Google-Smtp-Source: AGHT+IHhvBJQZZLF4qvCA1+VeH1XflwZ0B4C4bcRfZpPoV5ESlTMWrHmMyYLyE0Fj/9144c0IPpr/w==
X-Received: by 2002:a05:6512:31ca:b0:52e:be30:7e7 with SMTP id 2adb3069b0e04-52ee53a25ebmr4597627e87.1.1721346209536;
        Thu, 18 Jul 2024 16:43:29 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef556b4fbsm22491e87.139.2024.07.18.16.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 16:43:29 -0700 (PDT)
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
Subject: [PATCH v2 4/6] OPP/pmdomain: Set the required_dev for a required OPP during genpd attach
Date: Fri, 19 Jul 2024 01:43:17 +0200
Message-Id: <20240718234319.356451-5-ulf.hansson@linaro.org>
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

Through dev_pm_opp_set_config() the _opp_attach_genpd() allows consumer
drivers to hook up a device to its PM domains. Their corresponding virtual
devices that are created by genpd during attach, are later being assigned
as the required_devs for the corresponding required OPPs.

In _opp_attach_genpd() we are also cross-checking whether the attached
device's required OPPs really belongs to its PM domain's OPP table - and
tries to fix it up if possible. In principle this works fine, but sometimes
it's not convenient for consumer drivers to use _opp_attach_genpd().
Especially in the single PM domain case, when a device is usually attached
by the bus-level ->probe() callbacks.

Moreover, we now have dev_pm_domain_attach|detach_list() that helps
consumer drivers to attach their devices to their PM domains.

To improve the situation, let's instead assign the required_devs during
device attach in genpd, by using _opp_set_required_dev(). In this way, the
cross-check of the OPP table is always being done.

Note that, we still need to allow existing users of _opp_attach_genpd(),
which makes this change slightly more complicated. On the other hand, once
we have migrated those users to dev_pm_domain_attach|detach_list(), the
entire _opp_attach_genpd() should be removed.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

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
index 930cd5382032..fdbc3aab9083 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2774,6 +2774,61 @@ static void genpd_dev_pm_sync(struct device *dev)
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
@@ -2830,6 +2885,10 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
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


