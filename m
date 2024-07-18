Return-Path: <linux-pm+bounces-11240-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC93937139
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 01:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E05D1C20F5D
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 23:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5853B1487CC;
	Thu, 18 Jul 2024 23:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/I9ZBRo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716911482E0
	for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2024 23:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721346214; cv=none; b=nTRt7qXeY2dsaIzCrcNnWxWr/cWLszqB980dx8uaTTSp6gOflVF8uKVyRUutVlksZLXyGuGvvexNbQLwTC9Z0Qlz8lNwJlWY3JC36/OkUa2FBK92Ox6DuM9hjWtipwEkM9Xo1WZmvREH3mz9ryMHtYV4KyPAhk1aMT17+YIeMK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721346214; c=relaxed/simple;
	bh=q9HqaY78viyGGiaUkgmvLpNWtXDFKV24MjRfrhvMn+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I26yREIzm2TVXRcg3pC9Ft9sX7B7WTHRsyCS8hJyiiEp2Uzb3SNTufkFvKVc4tb9vrSkeBNt0/sZ91HRSGeHn9Lb5+2kZZxABXFJIjHMa8fJwC4U1/pWLhyaqs6XAay01ZRSWNctnQmc291/u3ej7eDes1QEgT65fpZbKfl8xAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z/I9ZBRo; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52ea79e6979so1206442e87.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2024 16:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721346211; x=1721951011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiy79RCH12nO+kuD43r9KxQZmT684plvYyRVA5SbNNc=;
        b=Z/I9ZBRoZ6zTywC1rtlBk+efuDYKgcIlMhFHnaljqMSk7EpqsX0/sA113l4E/o9wlu
         LRnKUuQoxlHIoF7qAxViIaEXgttiCIXeAlgfgFa9RNGBlRNc8bor845iQLHqrHTRtz4O
         RmSlhf8cVZ+8/w0EhpWMIk3iTlQWZJRzM/cZPdHDboYBagr8l2A02Ie9v3opihNWC6Ek
         pNtOxlYtwRFTQTRGQHqo9G1y42jCatIzqTsn9lkIeLhjIkoX7UCJcVxyHaGgHJBY+7Yr
         PB3OUriKodUml5FrPNfvDFkwlFuMqs3qOIh3KUzxgcgdOxdphMMt0OiL3Y8G2Rud1dby
         NbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721346211; x=1721951011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiy79RCH12nO+kuD43r9KxQZmT684plvYyRVA5SbNNc=;
        b=UsiMUPmnM/snfdEEzLROGBb3fM/5CPwWrzsnIaAmp20oTVWrYJQix6Hv2YeUC7zqp1
         HAD0ryruYZiKciGLUj4mzytCw+/zMxqzb8TRPughcVmM91v2titK/GtG49NjDncLpCK3
         xRc6w2IdD8DWm0NYVekOQrJXMKSIPCZdXnfCiKZagCUbSBj+yvOPUkkI4R7nkxlrlb90
         1plWPJ0kZmWEo3wJhI+W+LCIhEA/OGr6/8y0YIclg5xAeogoyrvKM4AYtnMK25AKDsg6
         LxZRPtpm7bGa/xPmKCneYRR8N0RxTqIpMUb5sFdqINf7lmD9SuraWvPbR9L5s90R13yX
         /ktQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvxRHDg5HN1TuK8u8piygyTkceXmR4Fw7bUhbHSyTuJlIdS99C8Fr6/WVKMtrPahU+BINTjs5V63t/TFHRbSo3aSg2Dc5QL/k=
X-Gm-Message-State: AOJu0YykXYKfvu80F0/wfx+h5ig9c6sHwyjo6jcgpVMj7JGIGU7J7kAH
	4MeSLW04z0wFRG0CCDrMB8m2F8BJGCaUga/BLddODRC5ZpnnkJd5ydiFazakfr0=
X-Google-Smtp-Source: AGHT+IE/PQcs9Xj45ekRvDZ9k+t/Et7RHcrmh62SIuBoPAG7Wl7rJpYPtWq1KQeWzrJ9ZjlpqQ2KEA==
X-Received: by 2002:a05:6512:39c7:b0:52c:8df9:2e6f with SMTP id 2adb3069b0e04-52ee5429228mr4551665e87.42.1721346210863;
        Thu, 18 Jul 2024 16:43:30 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef556b4fbsm22491e87.139.2024.07.18.16.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 16:43:30 -0700 (PDT)
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
Subject: [PATCH v2 5/6] pmdomain: core: Drop the redundant dev_to_genpd_dev()
Date: Fri, 19 Jul 2024 01:43:18 +0200
Message-Id: <20240718234319.356451-6-ulf.hansson@linaro.org>
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

There's no longer any users of dev_to_genpd_dev(), hence let's drop it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- None.
---
 drivers/pmdomain/core.c   | 10 ----------
 include/linux/pm_domain.h |  6 ------
 2 files changed, 16 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index fdbc3aab9083..bc89edcbd583 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -184,16 +184,6 @@ static struct generic_pm_domain *dev_to_genpd(struct device *dev)
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
index f24546a3d3db..772d3280d35f 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -260,7 +260,6 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 int pm_genpd_init(struct generic_pm_domain *genpd,
 		  struct dev_power_governor *gov, bool is_off);
 int pm_genpd_remove(struct generic_pm_domain *genpd);
-struct device *dev_to_genpd_dev(struct device *dev);
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_genpd_remove_notifier(struct device *dev);
@@ -308,11 +307,6 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
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


