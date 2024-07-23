Return-Path: <linux-pm+bounces-11342-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1232693A320
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 16:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31ECF1C22D2C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 14:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE87156F2C;
	Tue, 23 Jul 2024 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v16j/tJY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F284915689B
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745998; cv=none; b=UYy16JaADgM8NPXC4p/v09oEB+AQARb9IulNph33lyc+ce6g06OtvjvBRkrObkqGXSHp3Z9mFHLUakhxQHDr705nbE3Cm484PjTKOzgSX2TtZ3YEFelxMeDv1WCAvkwzH2QZ69nkQXNoekl2w5KlZmgDXA66gWx4ynE7z4SAT24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745998; c=relaxed/simple;
	bh=G1bdc1Bbc1w5rYBE7Tc2f+lHBc5gkXwukaXyrq0t8+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n3g+9ARwvIDrCPywtasXDv8up3E9haMB9NiUJ2pn5n244C0NgUg9NtqmpLZ02QfPoinMuKRb2d9/x2mqMvErz4u35w4NZNFpq8l1T1Z87bne0Iyi5gUkKTXhl34m15LBfht4ZT4asBtO3jq73dyO1L734YaQf6wradi+SqIvGM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v16j/tJY; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so4341293e87.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 07:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721745994; x=1722350794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMvMejcYTJIM4KIVqv1c9N6HVUpji/79NTaho6YiZqU=;
        b=v16j/tJYy846EjQGBTisf6koyNavGBk0U9LTqoxVFznPcGNliMDzFfVA2pNvP7xxHJ
         7ruRYZRnqhueSuzXNCEw0fPMcm96WdCeslCb8MQT6mztmT0gqoqie5UtGqDC1/yG/KPK
         qsigbKXMleH2k7gUKeut/JATSW7Rq3USugbcWBbvwuEmLHqhVYwTGzLMfOS/Ckpq/hdL
         iem5Cz5HqLJgT2N5b4UEXu732uxhfXi7acK+0IHMPTx+Fub0u6XIeYvHQgYEpniwfNMu
         fGxkpMbSYhUtbyg7nMt8wdgXxndYYZ5Ik3ZJhTIxBa5JXXkA2VOvwz7T3rfd1vD0ao/B
         2MbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745994; x=1722350794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMvMejcYTJIM4KIVqv1c9N6HVUpji/79NTaho6YiZqU=;
        b=xFm0Wuuk0PUO6CgMFD1Ww3fK+hDMomkYA0jZibZv3v1Qf+iZSPv8lPLcgNDNfLJ0es
         hlCq6rhcJOU7keVDUoUNNSpJcoiqfFWfVm3GLDYRqang2yPtNgzzta1mAYdH2X13Uq2Z
         ZrueB1KEZtCXcXtQ+W+IrmJYuOGZeGoVh93GNmOEdmb2CXxCvF7VcN4gsgtxd+8mgtqr
         rzvidiIMxg+fqoVi5VSKt4C+tyurqLuOuNMdfmrS8RdDJwj3eHaAh8VX/N8DWkRRFiZe
         FwpUjWstMzuFoPiqycUg0ERfYuADtDtRJR/6et3jXxwr+jZC2cGxGbBRcLip5pSeP/uo
         GXDg==
X-Forwarded-Encrypted: i=1; AJvYcCUFl0d7nmpuXGpfUsvIgpfOoN92cKQY9kTWnI6S8eG+gXh5+zdoD9yCDvDuolYKeNkB4ybyoH6FBRJU3lnEWxLUa3ZqiEyIsUQ=
X-Gm-Message-State: AOJu0Ywz4lvyBbjf2Q7lxUUaZljUQghtloe9zr3ySr8dy93T4Qy6GwXO
	7tUG72zOKR1LH3W3D1hEF+VdAc9XByMCxohU2Y99GMT21ef8v/cNW8N0nJthRmo=
X-Google-Smtp-Source: AGHT+IEZ1h6MbPLjULEjFJKo9gP06D2/tDoy9HevGDIpR9mHTnvQPTceARptLwA/k582cDSpVdzfpQ==
X-Received: by 2002:a05:6512:4008:b0:52e:fada:f002 with SMTP id 2adb3069b0e04-52efb5223cemr8834295e87.10.1721745994036;
        Tue, 23 Jul 2024 07:46:34 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52f0415eb08sm774540e87.9.2024.07.23.07.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:46:33 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH 1/4] drm/tegra: gr3d: Convert into dev_pm_domain_attach|detach_list()
Date: Tue, 23 Jul 2024 16:46:07 +0200
Message-Id: <20240723144610.564273-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723144610.564273-1-ulf.hansson@linaro.org>
References: <20240723144610.564273-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than hooking up the PM domains through devm_pm_opp_attach_genpd()
and manage the device-link, let's avoid the boilerplate-code by converting
into dev_pm_domain_attach|detach_list.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/gpu/drm/tegra/gr3d.c | 46 ++++++++++--------------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 00c8564520e7..4de1ea0fc7c0 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -46,6 +46,7 @@ struct gr3d {
 	unsigned int nclocks;
 	struct reset_control_bulk_data resets[RST_GR3D_MAX];
 	unsigned int nresets;
+	struct dev_pm_domain_list *pd_list;
 
 	DECLARE_BITMAP(addr_regs, GR3D_NUM_REGS);
 };
@@ -369,18 +370,12 @@ static int gr3d_power_up_legacy_domain(struct device *dev, const char *name,
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
+	};
 	int err;
 
 	err = of_count_phandle_with_args(dev->of_node, "power-domains",
@@ -414,29 +409,10 @@ static int gr3d_init_power(struct device *dev, struct gr3d *gr3d)
 	if (dev->pm_domain)
 		return 0;
 
-	err = devm_pm_opp_attach_genpd(dev, opp_genpd_names, &opp_virt_devs);
-	if (err)
+	err = dev_pm_domain_attach_list(dev, &pd_data, &gr3d->pd_list);
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
 
@@ -527,13 +503,13 @@ static int gr3d_probe(struct platform_device *pdev)
 
 	err = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
 	if (err)
-		return err;
+		goto err;
 
 	err = host1x_client_register(&gr3d->client.base);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to register host1x client: %d\n",
 			err);
-		return err;
+		goto err;
 	}
 
 	/* initialize address register map */
@@ -541,6 +517,9 @@ static int gr3d_probe(struct platform_device *pdev)
 		set_bit(gr3d_addr_regs[i], gr3d->addr_regs);
 
 	return 0;
+err:
+	dev_pm_domain_detach_list(gr3d->pd_list);
+	return err;
 }
 
 static void gr3d_remove(struct platform_device *pdev)
@@ -549,6 +528,7 @@ static void gr3d_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 	host1x_client_unregister(&gr3d->client.base);
+	dev_pm_domain_detach_list(gr3d->pd_list);
 }
 
 static int __maybe_unused gr3d_runtime_suspend(struct device *dev)
-- 
2.34.1


