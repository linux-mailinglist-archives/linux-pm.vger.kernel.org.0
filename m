Return-Path: <linux-pm+bounces-3667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A1F84E9B2
	for <lists+linux-pm@lfdr.de>; Thu,  8 Feb 2024 21:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFDDF29072B
	for <lists+linux-pm@lfdr.de>; Thu,  8 Feb 2024 20:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF70A38FA3;
	Thu,  8 Feb 2024 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JpNIye8o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0652138F9F
	for <linux-pm@vger.kernel.org>; Thu,  8 Feb 2024 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424111; cv=none; b=n+ieC/D0LMwFXQdcEapn+Lj47aIkcN5LanjTvOgTvE++mmUxDv3oHtRGO7l+5oTqRtrMshQ7fnm2OTVAWXMuUpvnbJGYyVvDOMqfrUSUAiLUZd1iiMDIvSPFyaK+g213d9ZeuIV/jWHtNjYN9vX9n7Rmh9uacL9Q+PyB45FwOlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424111; c=relaxed/simple;
	bh=MaJXUgIclpf/EWglWjbhZesimNmRnmJ7sAoUT4K4IHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MhwaXnYYO7UxD4bl31SOAmz6k/DDs5zmf1Q3/mn28u8t3kwOGEKNfOd319/K06gE1/MZVXu4+HR4GBzi94+Hi0S3giSA6Fquu7OeBbAnjmrASXPGEfXwcUJAIQ3+ZMs7DtP8NOUU/fovTX015AZ3jg2N+kkDKTGfzdFJtS7cMug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JpNIye8o; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fc22f372cso2034085e9.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Feb 2024 12:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707424108; x=1708028908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvrDBjoAHTErzMnmMJ2vCSaXAadIr1IUPSl1p95UmCk=;
        b=JpNIye8oaEv5dRHBkQ0KzR+ZlQcGFatiRd9h40BYERWchtULfs8AK8UujSyfJ5/ddd
         oHtuvPog+/z381chR1nGSXBjXWVumkUAot3QEliBlT/1bIFKT/DGqYS8/yyVT08Ay/B0
         8nfyH8W10b/FRhpBzYlozPABJHZHRqzTFPyMKKbAZqw4k2RHK8+wNEXLm/gODRisRpGN
         AZy9LjEr62V6uWFD8O83P7TwPGfcY5OvOFJ9jGDUfusMtXToGmESjj8nXWMw+Lrh6Gj7
         1ptyKjC8lULdUk8wH3AltYGp1OnJZ49U63kXanYeMX9YieaFW/nyG6OsWWn4cE9rlAHv
         eVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707424108; x=1708028908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvrDBjoAHTErzMnmMJ2vCSaXAadIr1IUPSl1p95UmCk=;
        b=MUQEI2T7gwWxGaXMoe4MfannNDfIcuo7jqXUUAHL7ZgzNuNeCgKZlEZtViMhn6m0YZ
         ho9xqrri6GLf0F/yTdlZoihCmi73P2EQdpgbDaQy3CdRdlgyTTjGvLL/+WCcD2le9kO+
         eUah4O2afAX5qwdkmDN5pE+BGz+aIEPEL5FiC1Lh0asBeare3uwasGAhZwDbLWknvSj+
         KBExgBNFl/D4DxQJSKBlcztPQSrrrk9SQuRzxnx5oVsoblQImNNGqx7kirmJ3pT1AOAq
         LpG/GpL4yjDtPnSYbdgPTdH6B3YLSXTCe9/V/viU7xuUXIxWGtwuL4/K1qpzhbo7ZDG1
         TpXA==
X-Gm-Message-State: AOJu0YxfyguGMgAPsGTKhkhuEj0lTOP7H2iovillAU/63sCA+gFp4BXL
	xyjnxUkUMMVb1zzCDHLXIIrvvI0NMV8qG0WiA8Fw1ITbH4LAq2LYm4NDOf1cVTE=
X-Google-Smtp-Source: AGHT+IFMnvpCLLUh9jB2SQYbYHV+ofwXSAPTFyZLLd/Wjz22g2zfesy+qsAGKC1R3LU1pQkc7bDgSQ==
X-Received: by 2002:adf:f88a:0:b0:33b:31f2:a957 with SMTP id u10-20020adff88a000000b0033b31f2a957mr381750wrp.21.1707424108366;
        Thu, 08 Feb 2024 12:28:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUx2uTQ78/pzHPc0j0QINI8jebXKW5zA5HCUTsogwb5SVs+jPbq/h4F0k0suZBl8miv+iULjTLbEYP0SHNQiIb3+2QjFCpybqsCL9H161P+cxVAN/2XAUkSH/jcfEdv9xUdbZwlPbuShN09ouABAL3KAzh/U4oVWfOwQsqH9sELFB2yFboOhq/pdmExlOhJZFi3tdH/UZX6CH4cztvIgFd0dxayQZEg/8pvEQ1Zaer9v6pF6IfMZCn8adfzOf9lJ6mRDmYR4bg0KPs31OQI5lerl4BRMVJzM/HSHcYyvb7t43YeRgicapbmvVcW/8QYh8ZQtJteAbMK7aB/O2/+4XGOdiaWe0OfNff6oC+/hqIKCAwjNL91J4weQEqlvKleXUIh++GTvgC27iC43XBln08d5hodt7xOf8VfsJ44IZxnneGqVa5a//ei00fAN09vuCFrkloVJ0PpCr+Jq8ZMvBNXOKo9+DcVpdMiHGPsuLo0UAyTlrtCf0qHxdIM9qPlNJHWcykERRVqnK5cJEzbF/9/mymAMIMEiw5PNGr6v7DqQA==
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id r16-20020adfce90000000b0033b47ee01f1sm114643wrn.49.2024.02.08.12.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 12:28:28 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] pmdomain: constify of_phandle_args in add device and subdomain
Date: Thu,  8 Feb 2024 21:28:22 +0100
Message-Id: <20240208202822.631449-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208202822.631449-1-krzysztof.kozlowski@linaro.org>
References: <20240208202822.631449-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pointer to of_phandle_args is not modified by of_genpd_add_device() and
of_genpd_add_subdomain(), so it can be made pointer to const for code
safety and readability.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pmdomain/core.c   | 12 ++++++------
 include/linux/pm_domain.h | 20 ++++++++++----------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index ea4b29475206..4215ffd9b11c 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2526,7 +2526,7 @@ EXPORT_SYMBOL_GPL(of_genpd_del_provider);
  * on failure.
  */
 static struct generic_pm_domain *genpd_get_from_provider(
-					struct of_phandle_args *genpdspec)
+					const struct of_phandle_args *genpdspec)
 {
 	struct generic_pm_domain *genpd = ERR_PTR(-ENOENT);
 	struct of_genpd_provider *provider;
@@ -2557,7 +2557,7 @@ static struct generic_pm_domain *genpd_get_from_provider(
  * Looks-up an I/O PM domain based upon phandle args provided and adds
  * the device to the PM domain. Returns a negative error code on failure.
  */
-int of_genpd_add_device(struct of_phandle_args *genpdspec, struct device *dev)
+int of_genpd_add_device(const struct of_phandle_args *genpdspec, struct device *dev)
 {
 	struct generic_pm_domain *genpd;
 	int ret;
@@ -2591,8 +2591,8 @@ EXPORT_SYMBOL_GPL(of_genpd_add_device);
  * provided and adds the subdomain to the parent PM domain. Returns a
  * negative error code on failure.
  */
-int of_genpd_add_subdomain(struct of_phandle_args *parent_spec,
-			   struct of_phandle_args *subdomain_spec)
+int of_genpd_add_subdomain(const struct of_phandle_args *parent_spec,
+			   const struct of_phandle_args *subdomain_spec)
 {
 	struct generic_pm_domain *parent, *subdomain;
 	int ret;
@@ -2629,8 +2629,8 @@ EXPORT_SYMBOL_GPL(of_genpd_add_subdomain);
  * provided and removes the subdomain from the parent PM domain. Returns a
  * negative error code on failure.
  */
-int of_genpd_remove_subdomain(struct of_phandle_args *parent_spec,
-			      struct of_phandle_args *subdomain_spec)
+int of_genpd_remove_subdomain(const struct of_phandle_args *parent_spec,
+			      const struct of_phandle_args *subdomain_spec)
 {
 	struct generic_pm_domain *parent, *subdomain;
 	int ret;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 1a391ef1b6f8..772d3280d35f 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -364,11 +364,11 @@ int of_genpd_add_provider_simple(struct device_node *np,
 int of_genpd_add_provider_onecell(struct device_node *np,
 				  struct genpd_onecell_data *data);
 void of_genpd_del_provider(struct device_node *np);
-int of_genpd_add_device(struct of_phandle_args *args, struct device *dev);
-int of_genpd_add_subdomain(struct of_phandle_args *parent_spec,
-			   struct of_phandle_args *subdomain_spec);
-int of_genpd_remove_subdomain(struct of_phandle_args *parent_spec,
-			      struct of_phandle_args *subdomain_spec);
+int of_genpd_add_device(const struct of_phandle_args *args, struct device *dev);
+int of_genpd_add_subdomain(const struct of_phandle_args *parent_spec,
+			   const struct of_phandle_args *subdomain_spec);
+int of_genpd_remove_subdomain(const struct of_phandle_args *parent_spec,
+			      const struct of_phandle_args *subdomain_spec);
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
 int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
@@ -393,20 +393,20 @@ static inline int of_genpd_add_provider_onecell(struct device_node *np,
 
 static inline void of_genpd_del_provider(struct device_node *np) {}
 
-static inline int of_genpd_add_device(struct of_phandle_args *args,
+static inline int of_genpd_add_device(const struct of_phandle_args *args,
 				      struct device *dev)
 {
 	return -ENODEV;
 }
 
-static inline int of_genpd_add_subdomain(struct of_phandle_args *parent_spec,
-					 struct of_phandle_args *subdomain_spec)
+static inline int of_genpd_add_subdomain(const struct of_phandle_args *parent_spec,
+					 const struct of_phandle_args *subdomain_spec)
 {
 	return -ENODEV;
 }
 
-static inline int of_genpd_remove_subdomain(struct of_phandle_args *parent_spec,
-					struct of_phandle_args *subdomain_spec)
+static inline int of_genpd_remove_subdomain(const struct of_phandle_args *parent_spec,
+					    const struct of_phandle_args *subdomain_spec)
 {
 	return -ENODEV;
 }
-- 
2.34.1


