Return-Path: <linux-pm+bounces-15060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5F498D31A
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 14:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37DA51C210BE
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 12:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC67B1D0958;
	Wed,  2 Oct 2024 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uz5UTbpL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9361D0797
	for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2024 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871780; cv=none; b=udvpK7BsRTHfg2+2ThnYBS6zpCpJI/qPVDdoNy0QtCB1cx+QzFD4UNWuKVPZ6mvpPBT4D50RiZCR5ugjs6gNjhk4Mc4zZarppm0ZAdF0vAD2Hk0GEJJDFUgyUwfziueEMNvZefYYJ6T+rESjmyxm10QZacohFrhppg9BSmfEI1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871780; c=relaxed/simple;
	bh=KxhfgynaXl+ts0gFVfYweXnYNKp5iegvppU1weAPpVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S2y31ezRQ89R5dJZUhwW4ZVwj4JH+S3XjnZv8tcxdKU4Cru87/IZ6b+yLCC8RqEjKwDiUMpjGE0/RmceceFYZn7j/Du5ST4ACS+EkfmfcS8yiX5wKiSZaedIuFS+Fwr49TLX3I7xxw4tMz5isFfaBTxpndgixxvbvfJ43bUTG7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uz5UTbpL; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5398d171fa2so4392591e87.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2024 05:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727871777; x=1728476577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWiwvj5KSak5iw1HXEVPujm6Q2wWyAwA6z/lZYjaN0g=;
        b=uz5UTbpL6IF1Qs6U3c7ARIytAVMOGbEwfX+WXh1Ba64C+KZqZy6e592h9Vq5Ipcs3a
         S5V5zSzMg+ZOeChhJqiseohFIRvyKHObDlZl7HXVQNYgIB8Dve2IJYHbJ/XGGRCTPwzX
         TFDcHThn1TIOnVbEH3ff2C7NkeW3N/Sbva0YqKdk7x5CXFM2VQdzCHSIWHVpGuaYso82
         BEeJ/InCcgTaXy9pI7Xee/jSApaBkh4++MOuA0xUCw70RLUYcv2pPjNjc+1rcQbG84PV
         AsZ7W2UNjAKvOx4WoPE57HojnkJRCEI/N4bdyloVoMF0/zdkkkHn8W2Byda+hmm2Jmeq
         qqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727871777; x=1728476577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWiwvj5KSak5iw1HXEVPujm6Q2wWyAwA6z/lZYjaN0g=;
        b=gaiXAfQUtbC2arjOitTa5cM0KPTebcQlwyKdrJK0olwFiyUhsmD6VBBOFtxGA5zor5
         b7K78EIQCywdjKK08/4etSIusZD0Yk+UiyJS8nUNEwOTOvp9q6nLaD4W96hVUysuWUfH
         W2QgSHzDEZOiR9OvivTm4/TShL5XNKGxWLWrP1V+wI2w9o8viCH3POfXJ71oMmmfCCQs
         ZbQYdMz3ixZfntiJ6V1noXF+ImlEzbca/b/JxAccQyg/0HK4cN8F3SGLFVmbsBK6ZU6n
         Jbr3xHlf3nAIb+9WTv9iV/wZWKgz4iA403qiZfJbotaG7ZlJILEcNGdeGkqIuihKpZj7
         qwCA==
X-Forwarded-Encrypted: i=1; AJvYcCW0Kt87h7f9TcPSAhcMHE8usluT3kMJYrhRo0/EkFxkJyq5/cYC7dgiSvj8bBB42ZAMK+h4s2zsow==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdDIOLp/NYEb8VeWda9vpDL5vwnrTeEHuuMjQkmRimLScQXMja
	bKLsQUcNr9ihgJgl8+ZPeXAatn9kGfAVVY4hh7k3ktoQ7RuJUzXbPWmHfvoBGhg=
X-Google-Smtp-Source: AGHT+IG2YfIlzqOBf8Qe1+i7eKAaGcPaaQ69rOLevaHyKiEZfEu6G3jNyhzopd/Ym4Ztq1N1Cwr9lw==
X-Received: by 2002:a05:6512:33d4:b0:52d:b226:9428 with SMTP id 2adb3069b0e04-539a065c7d5mr1786952e87.6.1727871777108;
        Wed, 02 Oct 2024 05:22:57 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a043204fsm1912659e87.165.2024.10.02.05.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 05:22:55 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH v4 08/11] drm/tegra: gr3d: Convert into devm_pm_domain_attach_list()
Date: Wed,  2 Oct 2024 14:22:29 +0200
Message-Id: <20241002122232.194245-9-ulf.hansson@linaro.org>
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

Rather than hooking up the PM domains through devm_pm_opp_attach_genpd()
and manage the device-link, let's avoid the boilerplate-code by converting
into devm_pm_domain_attach_list().

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- Minor. Use PD_FLAG_REQUIRED_OPP.

---
 drivers/gpu/drm/tegra/gr3d.c | 39 ++++++++----------------------------
 1 file changed, 8 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 00c8564520e7..caee824832b3 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -46,6 +46,7 @@ struct gr3d {
 	unsigned int nclocks;
 	struct reset_control_bulk_data resets[RST_GR3D_MAX];
 	unsigned int nresets;
+	struct dev_pm_domain_list *pd_list;
 
 	DECLARE_BITMAP(addr_regs, GR3D_NUM_REGS);
 };
@@ -369,18 +370,13 @@ static int gr3d_power_up_legacy_domain(struct device *dev, const char *name,
 	return 0;
 }
 
-static void gr3d_del_link(void *link)
-{
-	device_link_del(link);
-}
-
 static int gr3d_init_power(struct device *dev, struct gr3d *gr3d)
 {
-	static const char * const opp_genpd_names[] = { "3d0", "3d1", NULL };
-	const u32 link_flags = DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME;
-	struct device **opp_virt_devs, *pd_dev;
-	struct device_link *link;
-	unsigned int i;
+	struct dev_pm_domain_attach_data pd_data = {
+		.pd_names = (const char *[]) { "3d0", "3d1" },
+		.num_pd_names = 2,
+		.pd_flags = PD_FLAG_REQUIRED_OPP,
+	};
 	int err;
 
 	err = of_count_phandle_with_args(dev->of_node, "power-domains",
@@ -414,29 +410,10 @@ static int gr3d_init_power(struct device *dev, struct gr3d *gr3d)
 	if (dev->pm_domain)
 		return 0;
 
-	err = devm_pm_opp_attach_genpd(dev, opp_genpd_names, &opp_virt_devs);
-	if (err)
+	err = devm_pm_domain_attach_list(dev, &pd_data, &gr3d->pd_list);
+	if (err < 0)
 		return err;
 
-	for (i = 0; opp_genpd_names[i]; i++) {
-		pd_dev = opp_virt_devs[i];
-		if (!pd_dev) {
-			dev_err(dev, "failed to get %s power domain\n",
-				opp_genpd_names[i]);
-			return -EINVAL;
-		}
-
-		link = device_link_add(dev, pd_dev, link_flags);
-		if (!link) {
-			dev_err(dev, "failed to link to %s\n", dev_name(pd_dev));
-			return -EINVAL;
-		}
-
-		err = devm_add_action_or_reset(dev, gr3d_del_link, link);
-		if (err)
-			return err;
-	}
-
 	return 0;
 }
 
-- 
2.34.1


