Return-Path: <linux-pm+bounces-39236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FECCA641C
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 07:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9B85302C4EE
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 06:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C0D21D3D2;
	Fri,  5 Dec 2025 06:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlwA4+8j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F9F1C28E
	for <linux-pm@vger.kernel.org>; Fri,  5 Dec 2025 06:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764917271; cv=none; b=G0aT6zHqY/gXI0tZhEQZss4MG2ugAEz9EqNERu3o3B6/cdeX3o5reUjkrJRdiRxXBPr2Y+22zLWGKOndYfUISMtRJ3OBsQbFQ00Bl8h8IIYR2+uiyQoy41ve3U+LrOJeJnb14Zg/YFqdSXT//pxdn/CF7A5mnw7e63jHCH5Ntgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764917271; c=relaxed/simple;
	bh=HYWa7sYqo/+IWEhKErinEtaCB2smT0RLRWd4UNd8vSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kZGKeqnV+e+VaDmMjKOBltIFxVfPaPbecw84gM91yalzRv5wF37dCYRg/Xx3pu9eugOuVR2UdwSE/qr/NOM0ITw5JCkO3Ura0YRO+CaObXtzif8iq3OoyFLwQcYtgbmMNH1weHZ4jQQKurobqgaM923jKGwlXY2nfsCLmxLKoEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlwA4+8j; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29806bd4776so3071365ad.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Dec 2025 22:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764917269; x=1765522069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cQCqvOs+rmxg5luABnNgFbGK2aNywkYQWiXVFeR2OFE=;
        b=KlwA4+8jMvxIhGFbDORUTFtZpNCoSzpr6d204ogvZx2XnH0+p5T3Nsr3go0P0V4nMD
         lBJjBjsvDQf7M+tB3DnEUTHCTA8d7D6K6quQtpL4xZUsjxVVkVuZW+H9xrQMb68XShwZ
         xSA/IJD1Pn3FBcFq1sBjL3Rnrc744tipqH0nZQqEF/ErtYw5D8QllyNt1EhMc0NaXXh8
         GdI4Hp4OM8DWc00efTjPQznX5zJyPuGheScoQAHTKWiz9AN+RS/d906C6LRReLKe7LRs
         OaSLsaUczoZ/aNHnqZuoknCNUGoGenR+V5PcR/CwlwjK4F4ekVQQGtu3aXD1/GhVHG11
         i3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764917269; x=1765522069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQCqvOs+rmxg5luABnNgFbGK2aNywkYQWiXVFeR2OFE=;
        b=i/ktOA295R/XeBWRcL0rXqWtABstAe5ySMkGIVBMBFsHXCdeuybp3Q9SyG2O/NB4j5
         xj1umDjjFEGPaWn+gaINIslHq+Tt9x/ptQuiTC21PZyOgsgBy7H45rG7q3m6giW9xMNV
         3FwV5GNZyPtKyWNaON9PNEzyuXc0eowQJFJStBcVQrhM6+EbWsaWSyEzehrhsNHCN9eU
         J303OeF5+b7zNvGoqT1WPDUac55QJU432iTq4pSYqIkr0B+GHFJB3bxcGjg0ILZnMm+h
         tsh3vlnb0bMlp9f+QKgZQFa1JstoptnYcgVx4GuyNesaybQrhbfoqgzuRd0ANHz/CFmG
         DwXg==
X-Forwarded-Encrypted: i=1; AJvYcCVTuRdM/5j4IecvsEPceYtDDE4skTFldwgALHvnzL5pUQ18AGV+Dh6i6dy5h/153NLOXqPCYueOhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBDoHY2XiN8/gHzMTGEV9biElVY3pNG8kXAT88TZHh9PvY+iOt
	yWnhXnMq2UgrWjJUdvGEDbGpb+ndBgExvhGa3yTVj85m5KROrFUgedFa
X-Gm-Gg: ASbGnctrtPOqjocAHgBKbTcxhjPXPQ2+3xYYNQ2i4KeqcDTzax103PfW5xVTsdZChE/
	43VBRdwWRDezN2yrwxJfDy35W9ulp+VdUEI4ApnVOhEBYapvMTUTUN/8a37+jnvUiJpU5ZsSLjo
	LMCNCvX3yzRZHuXVemF3vY81Dt1r2bpUMr7TbtL8o4Tc+FJkswZKBlIH43Qf/lK42i+Scw2brQN
	tAo3V/tw087e0SvFYn431cVqjZuUU/QhECRWE8TDsJxoP0w9uKJnvmc4OnDGjyeA51rylt0c2ok
	aeGo4JnzuZvxy5mEfMpAeLKf0Upx222rIQgyE91hcUANGUvQiu9nkRWqclAsciczcMzy7zG7fhd
	RByrVB/HqooVuPPE6wAnxUYfDkwIb9zoP4SHYsnqSh91oUzydcc0LrxcZDzxbKPS6wcCfFFWP+A
	u6++Dn17smLgmE+ITJVNOhM/r9apDurygiCRphPXo=
X-Google-Smtp-Source: AGHT+IGRKM8BQrG2ZI8dHPnVSfWZ2b0YQ8no5vBvlYxduzRFOFHV5uKsY+yIJjsLzz4NB9mnoBzUQg==
X-Received: by 2002:a05:7022:252a:b0:119:e55a:95a3 with SMTP id a92af1059eb24-11df25cac52mr5909504c88.5.1764917268841;
        Thu, 04 Dec 2025 22:47:48 -0800 (PST)
Received: from localhost.localdomain ([183.14.133.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df749f8ddsm10664692c88.0.2025.12.04.22.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 22:47:48 -0800 (PST)
From: Frank Zhang <rmxpzlb@gmail.com>
To: ulf.hansson@linaro.org,
	heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank Zhang <rmxpzlb@gmail.com>
Subject: [PATCH] pmdomain:rockchip: Fix init genpd as GENPD_STATE_ON before regulator ready
Date: Fri,  5 Dec 2025 14:47:39 +0800
Message-ID: <20251205064739.20270-1-rmxpzlb@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3588_PD_NPU initialize as GENPD_STATE_ON before regulator ready.
rknn_iommu initlized success and suspend RK3588_PD_NPU. When rocket
driver register, it will resume rknn_iommu.

If regulator is still not ready at this point, rknn_iommu resume fail,
pm runtime status will be error: -EPROBE_DEFER.

This patch check regulator when pmdomain init, if regulator is not ready
or not enabled, power off pmdomain. Consumer device can power on it's
pmdomain after regulator ready

Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 1955c6d453e4..bc69f5d840e6 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -659,6 +659,11 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 	return ret;
 }
 
+static bool rockchip_pd_regulator_is_enabled(struct rockchip_pm_domain *pd)
+{
+	return IS_ERR_OR_NULL(pd->supply) ? false : regulator_is_enabled(pd->supply);
+}
+
 static int rockchip_pd_regulator_disable(struct rockchip_pm_domain *pd)
 {
 	return IS_ERR_OR_NULL(pd->supply) ? 0 : regulator_disable(pd->supply);
@@ -861,6 +866,15 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 		pd->genpd.name = pd->info->name;
 	else
 		pd->genpd.name = kbasename(node->full_name);
+
+	if (pd->info->need_regulator) {
+		if (IS_ERR_OR_NULL(pd->supply))
+			pd->supply = devm_of_regulator_get(pmu->dev, pd->node, "domain");
+
+		if (!rockchip_pd_regulator_is_enabled(pd))
+			rockchip_pd_power(pd, false);
+	}
+
 	pd->genpd.power_off = rockchip_pd_power_off;
 	pd->genpd.power_on = rockchip_pd_power_on;
 	pd->genpd.attach_dev = rockchip_pd_attach_dev;

