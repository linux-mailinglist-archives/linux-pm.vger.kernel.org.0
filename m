Return-Path: <linux-pm+bounces-27565-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E555AC2438
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DEE03A748A
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 13:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27491294A12;
	Fri, 23 May 2025 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JXH2DuKX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E952949F0
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007649; cv=none; b=qDnoSGtD8YP6VaMyJjCO560WCojjaqWCtEayEyvjWvVUt2C1gfJlJ8siHwkZhKZgi1Anu16lOMBZ6W5Gn7oiufJUFeIhQOWc3ArxIZvFHAcxqpGhje7S7eo7b6CeFCFZf9NOXX3j6/hQiR9R2CezCQzjp86TZpkmpgFRo3zF5IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007649; c=relaxed/simple;
	bh=k/gokzrB+B3txUi/Vz2QwJ5ruZou9efWYDfsnSiPgWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJ7O0HeQYO1i+XDhR6doCh2cypMNwuZmnXBfmEbunEDqhH7ClNiOLqkEEyf4r/Ov90QxPhhhNQjfU+HAbJfLn8KbAvS/WB6s+y74UC6dKvt8CH9+LXY/RPNafRPq/3gNskC7H9MxQRjPZFvZW8OR5QItV/4cBEcn6YE81iDHi3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JXH2DuKX; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54acc0cd458so11969970e87.0
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748007645; x=1748612445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWwLIPtTzxYEWEZZw852hEtxpMYtFzOXN6IU6m8GQeI=;
        b=JXH2DuKXyr9jsVGUSqNbU+LZWCXJ886YOAVc4/vG+Doqsb04P7Viip14eF1BSjVvJN
         IyQWQZNRaLbCVmSPDWstBOn8ZHhTjc5Q7hY/AP7dw+fVeHxl5oREcXxWX9VZ1DV4MIWi
         x+zQdkp14An6bsoQ1kq+0XwzvReukhIv+dF4t8fEyPn/sh+r793WlIqfhuFzO50HGTFx
         VhPJDZ1HFoOD0XN44eJXzd1ctBINqTUnYiAuwaDgh+qFKEvKHpr8bX4OTXyHSW93bw7e
         Zni7eHdjZHMB1cr+EAB+EIcPS60eyY/US8/2uK5hjJZ5Ia+vY/DjfllDVdqcn/sT1Qy9
         bwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007645; x=1748612445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWwLIPtTzxYEWEZZw852hEtxpMYtFzOXN6IU6m8GQeI=;
        b=XA2Q5PbdyVV9+cWhzn4uEO6P8Ejvrm0H7jUst2zOahEDv9NRykBfQu5yNyVjlb4Z2N
         ynovtooJnlnJsvaUfBeriZceeaz7+JmFgJsah/qWXcS2PEx0g9X46+aiNL2OCzRZxmq+
         mLcI0X3+s3mWlGLs0bKrPMKnSeQf69v7Mrv11/8PmgHkIe7/7SuYJ5/qGUYTzZPKJfkL
         BEuKm07xFLYOmwdZE27JGVDI2QCG4XMm+WYeOltKNIaDSdDM7qgxl3o1hWRoL1cMqia2
         2aEU+L+19IMMSoJbLTMtJSUvikHKbp+JjCyFJWHZ5Yc+tf1y2E0fRPRNDoTGKLu4CkZP
         z22w==
X-Forwarded-Encrypted: i=1; AJvYcCWFJbRHY4phmMyYL3GN8dHBS1jPfvtXqmwDSRwFB3EUhelP6Gbml0mHjPOlR9s0qbXpQ1KnQkkfSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5nNZZLrF0BdvJdZBWkMNzEf1YtvrkAzNWxdKHMPQMU4qYbkRT
	WDRg1LD23CpemQDJkmsUguTWAQuKH1w4rxmHjbN/aPsyqVgyKr57ptwKa4FY0eg8DVw=
X-Gm-Gg: ASbGncsgPLviB9uOb8fRZbAPgMSXhZV+i8ovBVSrPmxIxt4mnl1CeodDG+x4M0FokZl
	Ibv8xWZiJoyUizK7HzJInr33VC7qFr5qcofnHBtUkNouOzxE67FAOiAtKTakPT96kGF+Vi88gIe
	7g+NTx/4sn37y/VMvDZWuTGzJIyUDM9gHAJzBboKYBZAB7elgGxeTBgNeQqE4wC1Mg+x7D+aVm0
	OZALdd/aK60vQquguQJgGw7tq0sHVRB+Th2K3qrTlvk50L5WTuRaf5YpLnX/h1aqeD7elV/ty2d
	7+ofxjHJl8/k1FJx/LprtozQV3uXkYYsxBGfGq91t/tDazVJxWF6I3xGQmeidA3Td6CWX3m5T9Z
	gyJEqVmd1aschmBoETDXmqoqD+A==
X-Google-Smtp-Source: AGHT+IGNGyKHt6rNzkDqqmR2aYUSiJolKpNdYz92YDpW2HCUQjN23ubBERBvBislD/qe18fWhnbOWw==
X-Received: by 2002:a05:6512:2581:b0:54e:752a:ae5f with SMTP id 2adb3069b0e04-550e71938bfmr11180010e87.8.1748007645507;
        Fri, 23 May 2025 06:40:45 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551fc0d473bsm1950609e87.244.2025.05.23.06.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:40:44 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/21] pmdomain: core: Export a common ->sync_state() helper for genpd providers
Date: Fri, 23 May 2025 15:40:01 +0200
Message-ID: <20250523134025.75130-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523134025.75130-1-ulf.hansson@linaro.org>
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases the typical platform driver that act as genpd provider, may
need its own ->sync_state() callback to manage various things. In this
regards, the provider most likely wants to allow its corresponding genpds
to be powered-off.

For this reason, let's introduce a new genpd helper function,
of_genpd_sync_state() that helps genpd provider drivers to achieve this.

Suggested-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Changed the in-parameter from a struct device* to a stuct device_node*

---
 drivers/pmdomain/core.c   | 27 +++++++++++++++++++++++++++
 include/linux/pm_domain.h |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 8d5dca22e35e..4047af5a275d 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3408,6 +3408,33 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 }
 EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
 
+/**
+ * of_genpd_sync_state() - A common sync_state function for genpd providers
+ * @np: The device node the genpd provider is associated with.
+ *
+ * The @np that corresponds to a genpd provider may provide one or multiple
+ * genpds. This function makes use @np to find the genpds that belongs to the
+ * provider. For each genpd we try a power-off.
+ */
+void of_genpd_sync_state(struct device_node *np)
+{
+	struct generic_pm_domain *genpd;
+
+	if (!np)
+		return;
+
+	mutex_lock(&gpd_list_lock);
+	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
+		if (genpd->provider == of_fwnode_handle(np)) {
+			genpd_lock(genpd);
+			genpd_power_off(genpd, false, 0);
+			genpd_unlock(genpd);
+		}
+	}
+	mutex_unlock(&gpd_list_lock);
+}
+EXPORT_SYMBOL_GPL(of_genpd_sync_state);
+
 static int genpd_provider_probe(struct device *dev)
 {
 	return 0;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 0b18160901a2..3578196e6626 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -431,6 +431,7 @@ int of_genpd_remove_subdomain(const struct of_phandle_args *parent_spec,
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
 int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
+void of_genpd_sync_state(struct device_node *np);
 
 int genpd_dev_pm_attach(struct device *dev);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
@@ -476,6 +477,8 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
 	return -ENODEV;
 }
 
+static inline void of_genpd_sync_state(struct device_node *np) {}
+
 static inline int genpd_dev_pm_attach(struct device *dev)
 {
 	return 0;
-- 
2.43.0


