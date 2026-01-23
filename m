Return-Path: <linux-pm+bounces-41341-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oONdN4jLcmlgpgAAu9opvQ
	(envelope-from <linux-pm+bounces-41341-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 02:14:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BEC6EF22
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 02:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 910BD301D32D
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 01:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268F22EC55C;
	Fri, 23 Jan 2026 01:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LUyKIaGR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29F8344DB2
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769130858; cv=none; b=AVGAESIxHnqrkBF+ZIc417iejJ4jhb0ZtUAgfsrIIeYlaYaS9zYAo5m1QaIVJMfH9bPxqj1qXYxz82VT/QNAqcAqMDXRJUo1BWP8rsc+cf/yQovnI1oLQcjaJcbmkK+v5leHL14BVE0j8fA7EECmntJrpVWqCbRWX3YLzrLsDIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769130858; c=relaxed/simple;
	bh=lzR3NEhB2g7iCRM+bJ588/XYQ1irfnPbijYHHqE2mb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aDmfp+1ws697xvrqrgKiWdKH1ja6svdra8cCoV0Y6jSRBMteARyWtBsT4udIYQX83RuuIo1MIM+TyMqGpm461ftVI+mAj4OGhHviF9db82zSrJOscI+WT/Yoi+usyTnxunEnq3w10pMDINLtf8JI1x1Qr3l3WPZPxhSqYsx3jUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LUyKIaGR; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-81ecbdfdcebso946745b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 17:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769130848; x=1769735648; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHt+mmH4C5nxGUCfgNrBDFG/vUcO3dbURh+yi1mxNm8=;
        b=LUyKIaGRIpheIGdp0yKFGdzr0U1qdx5mYQcDms5odjnfkUx37cLKUx7hgJvUVbdU1F
         uuX0RWhLlNMcix2W6aSeG45R7ET9gGKuk3QtrBVR6YSb3epHMY3Nucwp0zp+XYAJPST2
         DHL4rN3wyymwZX2yDZtKb+w0JrQkse4s8275juX658M0rD1nW99kJWm8NIp7MPcyN1hu
         HEisa7voX2PE4rUxF+o7hO72KIEVVPyjgusIqGGl8mxpiiSStTue1ifRJP0utekUOVc1
         wDWaB1Xh2ISCublU0d+pS77/7JlLQ6a9KuNWrWwCDkGcUazVVgQmreje1yWj/nlBC2c/
         +yiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769130848; x=1769735648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aHt+mmH4C5nxGUCfgNrBDFG/vUcO3dbURh+yi1mxNm8=;
        b=Beuj7PhNYT8c6EFiNFWAtbCFPGydwshxaDzPJFIByFMVNLNOU8DXo3/yIH4EBVhOzk
         sZ8t+/UciixW9VF4nsiw7EhX/jU1Krp6/h0OVaJAIpH/G6eJFFS1RsReyogPcnWmqxG2
         sVGlncjeY/AsEhTH9RWmrBT4vqlqik/B6D5fFtflGH14phnWvamW0yvCZVW4bV96BJuW
         inEm2WlMoR5pS8bf7EHj9ZKYFia8Q2El1/r3gMp9qeo7h4JbpStyNFJx1vRfo+sZjCD/
         K52pNPvUjMrZRrtr+PlOdEtuPsrabJF5L2xo+5BoMb+SvkmuCBp4rSMaVOBpnACq2/Rs
         6U1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8XHxenw01qU4EWuU1c3BuESLV/rqUCbYCgerQgo/Cr0RkF7x0xW9HSay2IMIkl8TqYRi+eutaPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpNAiCXKcg1yZrakEYgjvABiR9HaqNNfGiEHlxnqIQULv8k/Ph
	h1XbODNJHCD9upHf7AqHGOkqcSXPjbs0LLM7R2bFoJcPbDKZc7ISDwxM0/iEwTc4u/s=
X-Gm-Gg: AZuq6aKhdCtOMfEeC24TsidTaPCyzdRISlQBy9st31UmCviBhu3+tGC8AviXjFEuC1u
	FSGfREUIHs9gOKk0UHJPYbPy3SZwRg3t86QzGbPoj7004HMibWvfLvaGYzcR6dtrrCyLThBgr9i
	snK7FNVi0HiWBSkAZGrk7V4+0JH1tkkdcB7//IJTth3C7j6uji/PZHQ5xUv2SQtCMIwzaSJV/vH
	bTmyMI2NMYtEmQ/auODJYwc5O3lfjJ/ZbA37vbCPSWbcCSqFtmB3Ohbvn2IpB2k51njiTbWUi05
	MMMi8uhi95jqt2Slp1bHxouzY3tTPlhOxAZPjbhCLGRnSBzaPdNR+k2S80IrZF6akBBHu5juHDh
	+MNxwi3odvWKwfWoqHS8ZuhdJiuhCoGea7t51qZ2O0yM8dtDtgMmxlbmr3c2IgxPo/hjFt4BKcc
	Tp/6FikEjf
X-Received: by 2002:a05:6a00:228a:b0:823:ad3:4ff4 with SMTP id d2e1a72fcca58-82317e1f2fbmr995725b3a.37.1769130848424;
        Thu, 22 Jan 2026 17:14:08 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876e5d0sm495195b3a.61.2026.01.22.17.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 17:14:07 -0800 (PST)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Thu, 22 Jan 2026 17:14:00 -0800
Subject: [PATCH RFC v5 1/2] pmdomain: core: support domain hierarchy via
 power-domain-map
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-pmdomain-hierarchy-onecell-v5-1-76855ec856bd@baylibre.com>
References: <20260122-pmdomain-hierarchy-onecell-v5-0-76855ec856bd@baylibre.com>
In-Reply-To: <20260122-pmdomain-hierarchy-onecell-v5-0-76855ec856bd@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=8104; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=lzR3NEhB2g7iCRM+bJ588/XYQ1irfnPbijYHHqE2mb0=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBpcstegivFzLujdyy/XYyCoOTFhTKHJRAJ8NSZt
 PKtjt8GNvKJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaXLLXgAKCRBZNxia0/vG
 ZYTyEACh3s27sFpbfZ/ydsd8FMkRCxosg8QXT/a2xgDoeAuFNT+1jyG2LMV6Cjudi5xBIfK5o5+
 K3rCkRFQItyaH0a2LcgHP1ysn+3J+w2O9jUPpq9M/bPVLnvG0wrPPggT5UyVG7/tuHVDuXbEUym
 E3YJRv9CholjJhRnXmP/Kr3ZBnbGrol0MS9vaP5sCLYbKRZR5dysNMLxbv4Tgq3N/AKfgBfw6b3
 Q74xOX/xuxPeFQD2H2MRdkrxmo9B62WkZkuMRYVMVERQxnn2oYBHTtl0X4e8IHnR1TtQBrhFAaa
 T6YDp5ROfuR0IFTYO1JkOYl2SkaCB5FvyM+nJx6GbuWKGzcUo/QsyzdiWSSiCfe6nGkwcuvnGa3
 2wje3dW4WqQfamM80nMSj1P6vznxc55kdLF/KxoRZRw/4pZwuoHt+Xuryy6vuV40VRntvMRE10D
 OxizOhFu6oqR26Yneomed1EZP0UaI66OIqdyQVj9Rqm8ZrTeVfJ35Y3hEjpHPr1HsRFZ/Ir4kCB
 LI59eoPpfLf+zMyBvm2ycc9gabfPz64DoKuvsnoGOgbxbSb0E8AIPP1XJ1mNJoelQmFGh8L1jhO
 /txN/VKIOHIm+hyiJleWlDYBJ2VOc8zeFSqePAamWNlzSi8bg91+VSFiBVONnrg409+suH1Gu2r
 kx4s+ReBZ01uOpg==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-41341-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.11:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:mid,baylibre.com:email,parent_args.np:url,baylibre-com.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58BEC6EF22
X-Rspamd-Action: no action

Add of_genpd_[add|remove]_subdomain_map() helper functions to support
hierarchical PM domains defined by using power-domains-map
property (c.f. nexus node maps in DT spec, section 2.5.1).

This enables PM domain providers with #power-domain-cells > 0 to
establish subdomain relationships via the power-domain-map property,
which was not previously possible.

These new helper functions:
- uses an OF helper to iterate to over entries in power-domain-map
- For each mapped entry: extracts child specifier, resolves parent phandle,
  extracts parent specifier args, and establishes subdomain relationship
- Calls genpd_[add|remove]_subdomain() with proper gpd_list_lock mutex protection

Example from k3-am62l.dtsi:

  scmi_pds: protocol@11 {
      #power-domain-cells = <1>;
      power-domain-map = <15 &MAIN_PD>,  /* TIMER0 */
                         <19 &WKUP_PD>;  /* WKUP_TIMER0 */
  };

  MAIN_PD: power-controller-main {
      #power-domain-cells = <0>;
  };

  WKUP_PD: power-controller-main {
      #power-domain-cells = <0>;
  };

This allows SCMI power domain 15 to become a subdomain of MAIN_PD, and
domain 19 to become a subdomain of WKUP_PD.

Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
 drivers/pmdomain/core.c   | 160 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h |  16 ++++++++++++++++
 2 files changed, 176 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index bf82775f6a67..cee7fbbda829 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3556,6 +3556,166 @@ static struct device_driver genpd_provider_drv = {
 	.suppress_bind_attrs = true,
 };
 
+/**
+ * of_genpd_remove_subdomain_map - Remove subdomain relationships from map
+ *
+ * @np: pointer to parent node containing map property
+ * @data: pointer to PM domain onecell data
+ *
+ * Iterate over entries in a power-domain-map, and remove the subdomain
+ * relationships that were previously established by of_genpd_add_subdomain_map().
+ * This allows cleanup during driver removal or error handling.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int of_genpd_remove_subdomain_map(struct device_node *np,
+				  struct genpd_onecell_data *data)
+{
+	struct generic_pm_domain *genpd, *parent_genpd;
+	struct of_phandle_args child_args, parent_args;
+	int index = 0;
+	int ret = 0;
+	u32 child_index;
+
+	if (!np || !data)
+		return -EINVAL;
+
+	/* Iterate through power-domain-map entries using the OF helper */
+	while (!of_parse_map_iter(np, "power-domain", &index,
+				   &child_args, &parent_args)) {
+		/* Extract the child domain index from the child specifier */
+		if (child_args.args_count < 1) {
+			of_node_put(parent_args.np);
+			continue;
+		}
+		child_index = child_args.args[0];
+
+		/* Validate child domain index */
+		if (child_index >= data->num_domains) {
+			of_node_put(parent_args.np);
+			continue;
+		}
+
+		genpd = data->domains[child_index];
+		if (!genpd) {
+			of_node_put(parent_args.np);
+			continue;
+		}
+
+		/* Get parent power domain from provider */
+		mutex_lock(&gpd_list_lock);
+
+		parent_genpd = genpd_get_from_provider(&parent_args);
+		if (IS_ERR(parent_genpd)) {
+			mutex_unlock(&gpd_list_lock);
+			of_node_put(parent_args.np);
+			dev_warn(&genpd->dev, "failed to get parent domain for removal\n");
+			continue;
+		}
+
+		/* Remove subdomain relationship */
+		ret = pm_genpd_remove_subdomain(parent_genpd, genpd);
+		mutex_unlock(&gpd_list_lock);
+		of_node_put(parent_args.np);
+
+		if (ret)
+			dev_warn(&genpd->dev, "failed to remove as subdomain of %s: %d\n",
+				 parent_genpd->name, ret);
+		else
+			dev_dbg(&genpd->dev, "removed as subdomain of %s\n",
+				parent_genpd->name);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_genpd_remove_subdomain_map);
+
+/**
+ * of_genpd_add_subdomain_map - Parse and map child PM domains
+ *
+ * @np: pointer to parent node containing map property
+ * @data: pointer to PM domain onecell data
+ *
+ * Iterate over entries in a power-domain-map, and add them as
+ * children of the parent domain. If any child fails to be added,
+ * all previously added children are removed to maintain atomicity.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int of_genpd_add_subdomain_map(struct device_node *np,
+			       struct genpd_onecell_data *data)
+{
+	struct generic_pm_domain *genpd, *parent_genpd;
+	struct of_phandle_args child_args, parent_args;
+	int index = 0;
+	int ret = 0;
+	u32 child_index;
+
+	if (!np || !data)
+		return -EINVAL;
+
+	/* Iterate through power-domain-map entries using the OF helper */
+	while (!of_parse_map_iter(np, "power-domain", &index,
+				   &child_args, &parent_args)) {
+		/* Extract the child domain index from the child specifier */
+		if (child_args.args_count < 1) {
+			of_node_put(parent_args.np);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		child_index = child_args.args[0];
+
+		/* Validate child domain index */
+		if (child_index >= data->num_domains) {
+			of_node_put(parent_args.np);
+			pr_debug("map's child index (%u) > number of domains (%u).  Skipping.\n",
+				 child_index, data->num_domains);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+
+		genpd = data->domains[child_index];
+		if (!genpd) {
+			of_node_put(parent_args.np);
+			continue;
+		}
+
+		/* Get parent power domain from provider and establish subdomain relationship */
+		mutex_lock(&gpd_list_lock);
+
+		parent_genpd = genpd_get_from_provider(&parent_args);
+		if (IS_ERR(parent_genpd)) {
+			mutex_unlock(&gpd_list_lock);
+			of_node_put(parent_args.np);
+			ret = PTR_ERR(parent_genpd);
+			dev_err(&genpd->dev, "failed to get parent domain: %d\n", ret);
+			goto cleanup;
+		}
+
+		ret = genpd_add_subdomain(parent_genpd, genpd);
+		mutex_unlock(&gpd_list_lock);
+		of_node_put(parent_args.np);
+
+		if (ret) {
+			dev_err(&genpd->dev, "failed to add as subdomain of %s: %d\n",
+				parent_genpd->name, ret);
+			goto cleanup;
+		}
+
+		dev_dbg(&genpd->dev, "added as subdomain of %s\n",
+			parent_genpd->name);
+	}
+
+	return 0;
+
+cleanup:
+	/* Remove all successfully added subdomains using the removal function */
+	pr_err("rolling back child map additions due to error: %d\n", ret);
+	of_genpd_remove_subdomain_map(np, data);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_genpd_add_subdomain_map);
+
 static int __init genpd_bus_init(void)
 {
 	int ret;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 93ba0143ca47..3baf224e4f24 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -463,6 +463,10 @@ int of_genpd_add_subdomain(const struct of_phandle_args *parent_spec,
 int of_genpd_remove_subdomain(const struct of_phandle_args *parent_spec,
 			      const struct of_phandle_args *subdomain_spec);
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
+int of_genpd_add_subdomain_map(struct device_node *np,
+			       struct genpd_onecell_data *data);
+int of_genpd_remove_subdomain_map(struct device_node *np,
+				  struct genpd_onecell_data *data);
 int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
 void of_genpd_sync_state(struct device_node *np);
@@ -505,6 +509,18 @@ static inline int of_genpd_remove_subdomain(const struct of_phandle_args *parent
 	return -ENODEV;
 }
 
+static inline int of_genpd_add_subdomain_map(struct device_node *np,
+					     struct genpd_onecell_data *data)
+{
+	return -ENODEV;
+}
+
+static inline int of_genpd_remove_subdomain_map(struct device_node *np,
+						struct genpd_onecell_data *data)
+{
+	return -ENODEV;
+}
+
 static inline int of_genpd_parse_idle_states(struct device_node *dn,
 			struct genpd_power_state **states, int *n)
 {

-- 
2.51.0


