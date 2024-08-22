Return-Path: <linux-pm+bounces-12782-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3DB95C10E
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 00:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45AD0B214B2
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 22:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBB31D3185;
	Thu, 22 Aug 2024 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IWoHAsCA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB6C1D2F5B
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366775; cv=none; b=UKTFjSILZIEDxGVQaNOs0HlbfL1nUI/i1+bVhzhdGGs1ufjiXhO+JH+lL46KEoW2XKTTTWfIy0Tg76rCSmHbVnJ+QQY8uN1eOyCudNTNZ80QGo4cXirhzTyMMlKOkg1/An0UzFsK7B7KtBIAk0LXwwaXgkdUnGep5mEhm01QcTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366775; c=relaxed/simple;
	bh=KEvEd+LQGygUiMRwqOZhLYNHpMTQYMq7EOdWZ45iHDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o5IbSf0UR85voCwRHCnID/cPjIeFUcgEK78bOgZknGf1w+l+ZQb0dFbrFi85CL6O1AFsEyhWBCGY9PQZcRewGPDQmhbZk2z1XAzn2WE3/NFrZMnyof4+n5q1I/lQrU8v4N7uJl9QEQp6wZKFcVAuXLsovKj/c6HhMN1vj9qLDOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IWoHAsCA; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5334c4d6829so1754896e87.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 15:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724366771; x=1724971571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IgtH0skR0e3C63jmvkIAtxr085sHyospA98t+tzDJI=;
        b=IWoHAsCA5t+GKz4hF4RFOSz7b7o5MR58bORAYlj561skVhRktprz5Ajxe2rkS1laSe
         u/EHHI/IuCDjuMOgFcYOiHN9G35Yr1I3W9TtR50NqgsQo0ZHoWutoIrIgwnctJyXqbaS
         csqcytQFepyTYblg6rkIXdbTcFLRxLsqTJVnw11Wottezf/hrsFjeaJY2xtLcYgxfya+
         sBuYJUyEjWbSflffsB0TgQ0eusoMxT9OMHTzoyEUmjKcSnu9NAA78L6NTOB4cXdy4etw
         Ri8A050WkM9M8IpPq0gNvhOgFzTZSwgHpuDftbF22y2Uf/cPNDOLvTjFZyXVCzUBHyeD
         SqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724366771; x=1724971571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IgtH0skR0e3C63jmvkIAtxr085sHyospA98t+tzDJI=;
        b=JEz4VJ6wX7V5tE1f8++GRJ5tFYWTvog4Gwg9FV1Pk6YGwHhKGtl5XqPgiqULXBThkg
         ACYRdeUDx25p7AQmgJvg1zxloJzOs8p957QL/eyB053BE+3hFXhF0iQbDQ83bpZ3YAgP
         8RzKoWnGvOBp/SZnj/rNkz7IdZokBUaejcV4hFHEUG8GbfLjf2tkMhE6xZ86g5eagsso
         FlUfIZtbZIlcpKJRordZ3HqH3iQDPHxLdVWFG4UUSPn/1wqWWafabk4wFQ5zYL6affR7
         /2UVRN2jca15KTXckpI/cbZU2M5FeaGibUFOeICwu9xPBNsMPH+YL4PeroYIKH5oDF76
         FjxA==
X-Forwarded-Encrypted: i=1; AJvYcCXKHYKMQduRmWu6Ml31Y3zVo+/VK+djQ8s0UsqgTHoCbBVs0rr7yFfjGAnNwTP4hv6vMvSfM7Wbpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBwG6USj4j0W84XoWI+r4Gvb1cwxb2/KIs+VF1FMhYE+otvG2p
	ZqPH4pGaxG6PxmCdzWfuTiLoqtNlQflMXrY0tAJeW2j5eZB0hrkoacd604jbCFg=
X-Google-Smtp-Source: AGHT+IFNgxeohcK9pIDV2zZdHATDKL7WYCEymR2r9L2dWkQ/5MOeAMKb0NrqhPaC3r++lSrG4socBw==
X-Received: by 2002:a05:6512:3c87:b0:52c:d905:9645 with SMTP id 2adb3069b0e04-534387786ebmr208252e87.13.1724366771338;
        Thu, 22 Aug 2024 15:46:11 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea362a4sm379443e87.66.2024.08.22.15.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 15:46:10 -0700 (PDT)
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
Subject: [PATCH v3 05/10] pmdomain: core: Drop the redundant dev_to_genpd_dev()
Date: Fri, 23 Aug 2024 00:45:42 +0200
Message-Id: <20240822224547.385095-6-ulf.hansson@linaro.org>
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

There's no longer any users of dev_to_genpd_dev(), hence let's drop it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- None.
Changes in v2:
	- None.
---
 drivers/pmdomain/core.c   | 10 ----------
 include/linux/pm_domain.h |  6 ------
 2 files changed, 16 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 0749da94624f..edef1a520110 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -226,16 +226,6 @@ static struct generic_pm_domain *dev_to_genpd(struct device *dev)
 	return pd_to_genpd(dev->pm_domain);
 }
 
-struct device *dev_to_genpd_dev(struct device *dev)
-{
-	struct generic_pm_domain *genpd = dev_to_genpd(dev);
-
-	if (IS_ERR(genpd))
-		return ERR_CAST(genpd);
-
-	return &genpd->dev;
-}
-
 static int genpd_stop_dev(const struct generic_pm_domain *genpd,
 			  struct device *dev)
 {
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b637ec14025f..f6d26cd81096 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -268,7 +268,6 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 int pm_genpd_init(struct generic_pm_domain *genpd,
 		  struct dev_power_governor *gov, bool is_off);
 int pm_genpd_remove(struct generic_pm_domain *genpd);
-struct device *dev_to_genpd_dev(struct device *dev);
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_genpd_remove_notifier(struct device *dev);
@@ -318,11 +317,6 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
 	return -EOPNOTSUPP;
 }
 
-static inline struct device *dev_to_genpd_dev(struct device *dev)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
 static inline int dev_pm_genpd_set_performance_state(struct device *dev,
 						     unsigned int state)
 {
-- 
2.34.1


