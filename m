Return-Path: <linux-pm+bounces-15053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804DB98D2F9
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 14:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0303D1F23361
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 12:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09241CFED8;
	Wed,  2 Oct 2024 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXshoZqi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062571CF7C6
	for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2024 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871765; cv=none; b=Bkm+6Cl6r8JuTXZxoTg6fQCnVDM0H+rJN3qJfPwDq/ZlyDeWR4mIUVfV9+C3lh4XlsfAtJmUlIu5eVFGrmLtTjdDYDo57otr2i0Ic7i3H+HzaggwRIKhrSHHwsXPnX0mPbceHB8LW1zkJ7teE1/HEONDyojBZj0KdvtMLy2mM74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871765; c=relaxed/simple;
	bh=bHtjzPG/Hb+7ZqaAKxtS3yoYjps3dQcwfj0ujdDPyg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DCYIu3uUJ4RW4zHSzSEQ1UzdMaqwZ0YnmTaqPVR0ln6n7bjV8bniysrXRnmafJusfEHaR5gLfGjqcFOeezleDfMgj04B6MxITsLvJrohtYD5IkEdY1/j4QbwDs1XCtHoFmE3yUebgjNcZ4C2eWhglSjRw6Ywxk+UtEsCeW9EIhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OXshoZqi; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5398ec2f3c3so993928e87.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2024 05:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727871762; x=1728476562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSX9EU17ASlDm3AgTKh4ubal0EGKVpY/9w9SUmxv4Ak=;
        b=OXshoZqiEfStsTOGcDG8w+vDkCQh0boU7rqDrgyxZIDcJ8S+pnfgSxSFWl5zDK38Ch
         7Z3QkM3o2CAeZeXaX5OcjbeHlIhTccy9uM4fy2pDOhfeBeGqVw9i3UFjiJlYIkVUxJoc
         mgXbQbIb0csjJL1nFWkzYvP1aDVxCwsTJcWcrvTI7lDJJIOv2ZCZW07GvvBPoY/L49/O
         pQVIMpw65Sa6lUMOBEQYqDhwK8VzPyq/WgV9uhS1CwIvGRLVAiZ7E+uyvpUMdsF8i+Ao
         FcjrUu5jDX1BJAbkDI6EEnqpTKs9gOi2HuFmLaC2Q0WFOE+3Z1mC5sdqkSByZbhlUlRV
         Metw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727871762; x=1728476562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSX9EU17ASlDm3AgTKh4ubal0EGKVpY/9w9SUmxv4Ak=;
        b=RuasjwNXx9kfoVbC/2G86uIj9hbGMJDxabditv0GLLcj9rghbuauDxyx8DQe1qFIE/
         F6phga0uuPtCMdD8FsOUiFxeCdAm6768pZPcYX66atl5Sv1skKEe31yxwjsi5zPZqqCz
         4XN3finh8VvvPdmTf3u7SVe3g4ufLeCeLVIcfBU2PossZUEcN5drniqTGsB5qKDBIWtt
         RX5ct7seHyJJlNh6bnS4oumH6jAuEhs8CFvfoo7ZmbGRuSSI/vSa37isVa7uoeyyeGoR
         XjnA02mH/H3Y/RoKdZLMeq1zVL8dMYclri9AJiNOzqx30ClvdA2wYLhcc8IJMDYllUP2
         /BJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlJbjSMa8Fl0hCA7JL+A6hwwmjuBWWU4jV597VrBiUH/pr792uxmkfeLm2Ivx1gVvuTBE2vnyCZw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzca4gUvDZAYtdAfIIXj/FnPiGNqN/Ju0Elyt3DMsTzIRWr/iMW
	QFPw7ggrBEpBhGSFzVo+3Dhn4vYV574eCLw/M+KfkDhpGuhp7/0dIUQpa+OIV3A18u5onnh+Cbj
	F
X-Google-Smtp-Source: AGHT+IHEvwRxBb9GrNyhgaRg0+vv+PetyLiU75/JMXFKI6h0PdYDgnClXnPqY2gTN5ud9jelhP1j5g==
X-Received: by 2002:a05:6512:280a:b0:530:d088:233f with SMTP id 2adb3069b0e04-539a079f870mr1678944e87.40.1727871762024;
        Wed, 02 Oct 2024 05:22:42 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a043204fsm1912659e87.165.2024.10.02.05.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 05:22:41 -0700 (PDT)
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
Subject: [PATCH v4 01/11] Revert "drm/tegra: gr3d: Convert into dev_pm_domain_attach|detach_list()"
Date: Wed,  2 Oct 2024 14:22:22 +0200
Message-Id: <20241002122232.194245-2-ulf.hansson@linaro.org>
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

This reverts commit f790b5c09665cab0d51dfcc84832d79d2b1e6c0e.

The reverted commit was not ready to be applied due to dependency on other
OPP/pmdomain changes that didn't make it for the last release cycle. Let's
revert it to fix the behaviour.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- New patch.
	- Thierry, I intend to queue this via my pmdomain tree as a fix for
	v6.12. Please let me know, if you have any issues with that.

---
 drivers/gpu/drm/tegra/gr3d.c | 46 ++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 4de1ea0fc7c0..00c8564520e7 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -46,7 +46,6 @@ struct gr3d {
 	unsigned int nclocks;
 	struct reset_control_bulk_data resets[RST_GR3D_MAX];
 	unsigned int nresets;
-	struct dev_pm_domain_list *pd_list;
 
 	DECLARE_BITMAP(addr_regs, GR3D_NUM_REGS);
 };
@@ -370,12 +369,18 @@ static int gr3d_power_up_legacy_domain(struct device *dev, const char *name,
 	return 0;
 }
 
+static void gr3d_del_link(void *link)
+{
+	device_link_del(link);
+}
+
 static int gr3d_init_power(struct device *dev, struct gr3d *gr3d)
 {
-	struct dev_pm_domain_attach_data pd_data = {
-		.pd_names = (const char *[]) { "3d0", "3d1" },
-		.num_pd_names = 2,
-	};
+	static const char * const opp_genpd_names[] = { "3d0", "3d1", NULL };
+	const u32 link_flags = DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME;
+	struct device **opp_virt_devs, *pd_dev;
+	struct device_link *link;
+	unsigned int i;
 	int err;
 
 	err = of_count_phandle_with_args(dev->of_node, "power-domains",
@@ -409,10 +414,29 @@ static int gr3d_init_power(struct device *dev, struct gr3d *gr3d)
 	if (dev->pm_domain)
 		return 0;
 
-	err = dev_pm_domain_attach_list(dev, &pd_data, &gr3d->pd_list);
-	if (err < 0)
+	err = devm_pm_opp_attach_genpd(dev, opp_genpd_names, &opp_virt_devs);
+	if (err)
 		return err;
 
+	for (i = 0; opp_genpd_names[i]; i++) {
+		pd_dev = opp_virt_devs[i];
+		if (!pd_dev) {
+			dev_err(dev, "failed to get %s power domain\n",
+				opp_genpd_names[i]);
+			return -EINVAL;
+		}
+
+		link = device_link_add(dev, pd_dev, link_flags);
+		if (!link) {
+			dev_err(dev, "failed to link to %s\n", dev_name(pd_dev));
+			return -EINVAL;
+		}
+
+		err = devm_add_action_or_reset(dev, gr3d_del_link, link);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -503,13 +527,13 @@ static int gr3d_probe(struct platform_device *pdev)
 
 	err = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
 	if (err)
-		goto err;
+		return err;
 
 	err = host1x_client_register(&gr3d->client.base);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to register host1x client: %d\n",
 			err);
-		goto err;
+		return err;
 	}
 
 	/* initialize address register map */
@@ -517,9 +541,6 @@ static int gr3d_probe(struct platform_device *pdev)
 		set_bit(gr3d_addr_regs[i], gr3d->addr_regs);
 
 	return 0;
-err:
-	dev_pm_domain_detach_list(gr3d->pd_list);
-	return err;
 }
 
 static void gr3d_remove(struct platform_device *pdev)
@@ -528,7 +549,6 @@ static void gr3d_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 	host1x_client_unregister(&gr3d->client.base);
-	dev_pm_domain_detach_list(gr3d->pd_list);
 }
 
 static int __maybe_unused gr3d_runtime_suspend(struct device *dev)
-- 
2.34.1


