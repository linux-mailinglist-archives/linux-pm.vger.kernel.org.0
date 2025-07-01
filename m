Return-Path: <linux-pm+bounces-29897-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F201AAEF717
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 13:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538101888DEB
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 11:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496342749DA;
	Tue,  1 Jul 2025 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l5iOuLpQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4B227466E
	for <linux-pm@vger.kernel.org>; Tue,  1 Jul 2025 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370477; cv=none; b=ZoZmtYfBzYW0PEAf5+0qDh0sa5IjLPhCwrcrgka3njTmc0nEehKpLQWuXTRz8V2nBZM73tIkxqksGUJdSxfLotwYW+25sbcJBUHTsk1s3VgsdmkXctFrIevuLPdtipNpY4Dntsgp+Sn+029/Z9U/8G+gnt/gq9FmuIb1hbd9xFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370477; c=relaxed/simple;
	bh=GSQjDAAw/2UFfOSDhN4XP7m6qEVN6g7wVlZceYPRiQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bp2lIK180XvS5Ti8GeravWVomL9VhBvmkZBuLGAiL6qEjn9bwKe/+/7EeU225AbVCCo81jc3QhnNGsFTs5FcgyQeXy3MpG24FMugq3osqCxYFao0DNSi+exOUWpF0HcYYoSS20tUQgg8wo7y7SiCZN1KCurIhoolz6LcWpNGYcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l5iOuLpQ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553bcba4ff8so3582422e87.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2025 04:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751370474; x=1751975274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8snE3wteaj05up9xuc38N+GpWHiyr4TVp4DRKu79Vw=;
        b=l5iOuLpQMOVzxO/4T1vXdMRsDV9x6YeySVd2w7IqZuVzHDCpI5gqs6OdGo7D6tE6XF
         MR9CctnrRHOkfXAmAzYP9WG8WYLohxYfKkLw0LygKZmMGdbbjEO24Y8XDlVr9Nrfjqzg
         4J1dfYpd6bP7pFY9byI/mogq0My2YKWd+k04ioCyu5i4+q1BP81g9gWbCQLI5QFyANCP
         cEP0Qwc5w62bbmv2nA36zcsacjyoxF9Oq8qEsBGhNTSYBSeyhnhBWbwjb/Mg+D9DcduM
         iDoMezsJ6l6w8GjN/PlAfZOn1a0tnLmzKK7DE28xCCRtIExDUbCJ6VHpi4mRS2RQp9PX
         XYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370474; x=1751975274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8snE3wteaj05up9xuc38N+GpWHiyr4TVp4DRKu79Vw=;
        b=MPsQ16mwAJorV63h8fNEplD6wgfhCqCfQQH2EiisbMZtSh4wOMzTcgx888NBuI9l6z
         izS7Yx/UPsyjELjnR5sjp2B6f94MiHpgr9ITYkesAZkdEXaulnhI6pE53QeMHQe9a0rX
         bROJDZCY/7ipCffjQDBuWekE+P9BN6nSguYZZ7EuzFc24byWOZ2T8HyC2Sz/L0xE2ZDs
         eWVKiQECnpJ2XrfjK93mVwZ7VUi9bpxu2JVzEaJdjqDQ9aeJnoylXgGzEV/IxO9oEjKS
         W+LMdzfOgwtJku4QITmbRfkf4jswZVNtJiO1MvSAbZukKURphdN3Y6De0/ngpKwyv6gY
         CFSA==
X-Forwarded-Encrypted: i=1; AJvYcCUuYcv++/LdoBqboRY1FXQJtLSY5lgYQrBTHzlo0XOsdL/0IlhszxNh2cMXVBLlYXjUIYkd7zKMhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyKu51bFw9k8YbXMpRr1zQTSQohSB7O2Hld+U22Fh93MpJB66w
	x7Y7TCEG3bNqvhmn0AZyURcLdmRXUe/aKqdodZ3t+qQF1IycVzsGItakXq7XfLTxUtw=
X-Gm-Gg: ASbGnctQGN8BL55+Ju0c1C6IBmJUnjTu4i3+9zgX5XFvALuQEcochozSDrSwTc2BR+z
	6cIGcLm0NOJIwz9JBiskKdXA2lNLqXs/WmhgyVtFYBZDkwJ1ADlRnfv1DiWv4xA2JT7WUhH9OsX
	GtO46LLyk09/Du7IwjbhiYvgTI2ZC8PaJc0J+ERZjNvzDxIizWsYGz/5z2BYlLXqTBbCL1rO5Pc
	/agAXCH93t14ZmrEwKhhLAxS/lw4zkaZyvSFWP/f3tllt+eBxctsd0yGcK/sE7ATYVCXn91tf22
	rCRRncw+A55jWxrYVLJA27MfqlFb3CftynD/mE7Ihgn8wpx6akVK1FsloI8wb/NO4FdSnvk03xL
	oEm5jx2OEb3JjZuyXOSj7dr/f2coEPj5/PVbv
X-Google-Smtp-Source: AGHT+IGHOXSS3IfRhKJLvej9F7sNLg96swujqTnE5kCTQPPh6ovfx1jtoUYgG1FeyEuKZgdZjCc4VA==
X-Received: by 2002:a05:6512:1590:b0:553:3073:c38b with SMTP id 2adb3069b0e04-5550b8293fbmr5034875e87.1.1751370473628;
        Tue, 01 Jul 2025 04:47:53 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2f162dsm1800592e87.248.2025.07.01.04.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:47:53 -0700 (PDT)
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
	Hiago De Franco <hiago.franco@toradex.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/24] pmdomain: core: Export a common ->sync_state() helper for genpd providers
Date: Tue,  1 Jul 2025 13:47:09 +0200
Message-ID: <20250701114733.636510-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701114733.636510-1-ulf.hansson@linaro.org>
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
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
Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xilinx ZynqMP ZCU106
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c   | 27 +++++++++++++++++++++++++++
 include/linux/pm_domain.h |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 79dc0bf406f0..0a6593a1b1c8 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3396,6 +3396,33 @@ int of_genpd_parse_idle_states(struct device_node *dn,
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


