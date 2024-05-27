Return-Path: <linux-pm+bounces-8172-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D49238D04DB
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 16:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D44D2824D7
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE18916FF26;
	Mon, 27 May 2024 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ywo3EySX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DCC161916
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819974; cv=none; b=DwhAkyxroooE6+oxSxQS4FTvpqfA5U0lSpHKK60/TFy9tk61QV0HGVnh4LUDeJHVcmrVHYVJ4dNheusrtNJ0/woukLaHwO6BsFYWGQ/JF5q9qHTMEu2HgybWuDFOiX4tpcgZc0ZHcfSB+OFkuBNsn2wCi9icyR4xU8i9VwwgBqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819974; c=relaxed/simple;
	bh=YcCK16hCcedyEDxCm8Q4x8DZte4hLECUoktYNDUh8Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dDkC+wAClRWmrPAkxapk3s9tpvVWsEZCo/nQVaNc6Dk6vFhEHhtdkDgQvWtTcmEipBCg11gHg8+Nhh8sF638nX7HS+SJD0HoSImmGK40/SPsqBMqqclIv6GJQ50lK0GBaJs+A8IGYxV3FdYjmj1rYDUoby7+ogYGyIhpXJHCceE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ywo3EySX; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5295a576702so3600789e87.0
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 07:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716819971; x=1717424771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ajlq1staYQWjI54ZRvjbkTZMy5GI2GeZyK3MIpoEkc=;
        b=Ywo3EySXtnPb3AlIxCagFsDBfd9qXwHIEmFczq4ALhGvX6HgW+Wjmi+dgHqOcj2AFw
         WEYmpY9UesrETHK6BrDf0Lc5/p70EcyQq46s1DHpM5CZC8ncbm0GHFVjOTXkQR+bKDGq
         Zg7+fIxixtQyANaJMdeQsjqPhGD9eG+iUsm8I6QnQ97WJrpiGYF0tyUq49soXThZbRpL
         VAumhoQmuhc7yTEZjX8cwpLv05lYtWFHcYKM+rX7k5Rp++jLcQ8gcwUPPUQaV6lAZzLw
         ljYkIlp/KBoJpEt0rO5vW0bDre4POVDvHQZQAB1m2rgvn18YWfrWlSYTd67xpXd0UOeu
         TZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819971; x=1717424771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Ajlq1staYQWjI54ZRvjbkTZMy5GI2GeZyK3MIpoEkc=;
        b=VM6DiIrgJJxCvTe5dLQLrskTtCmoc/9J72ARYTNukohm0al+kwni1NKKcCr8GxZJRj
         ZlAzAgn0qlpbrHZG3YgZXTS79L+IvI062+OZIw0QxBwVZABSnHv2rg9gDy4uauTajDas
         jgs+EG7mxv2eaMm0V8UzlN3U6T4h2z1lwq948q+atPeoxqpdWOgC8urOBRLzYJaJ5I/0
         qoCWsvKEiFY+rFwIgYfPO3IAKegTfWQN7fX01MfUQF5c70H2127wv91IjLKrkeyn7wXB
         aqkpxrl5amxO61hMgDi5Xtk4rbLHkFz24qAvY+lvbA5ZknlfjjHuXG8BTM22Klp8kO9y
         dpKg==
X-Forwarded-Encrypted: i=1; AJvYcCXhL8kNKbjqppqOVLzxi5OPVNib3t7SEhJwgC/wu5m5oqrLM0ZBUnFyrXD0LthowQyoDm2nK9TzCkv+CqJbD4Kdhlf+Muub9YE=
X-Gm-Message-State: AOJu0Yyw7rw8YMCFlsXCj6MRmgEHO6D2xizCZl3MHxipDKxMElZehU03
	iJr22x1zr4yb61JFAU+oIhKKHfrqh8FDZu2jjuuY6GuNOjbs7JLMX45Dl0XKFUhcU+bQnju3DHW
	B
X-Google-Smtp-Source: AGHT+IHWRypJfff5qBHtAk5lsZ8/wFX/161EBjl7n9TAWLIPrFWtZ+0qN16FQcGUnCCHIR2OZDLIJQ==
X-Received: by 2002:ac2:5a09:0:b0:51f:5853:14e3 with SMTP id 2adb3069b0e04-529647d8360mr5535854e87.25.1716819971096;
        Mon, 27 May 2024 07:26:11 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529711fa7f3sm562002e87.258.2024.05.27.07.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:10 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] pmdomain: core: Don't hold the genpd-lock when calling dev_pm_domain_set()
Date: Mon, 27 May 2024 16:25:52 +0200
Message-Id: <20240527142557.321610-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527142557.321610-1-ulf.hansson@linaro.org>
References: <20240527142557.321610-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to hold the genpd-lock, while assigning the
dev->pm_domain. In fact, it becomes a problem on a PREEMPT_RT based
configuration as the genpd-lock may be a raw spinlock, while the lock
acquired through the call to dev_pm_domain_set() is a regular spinlock.

To fix the problem, let's simply move the calls to dev_pm_domain_set()
outside the genpd-lock.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
Changes in v2:
	- None.

---
 drivers/pmdomain/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 072e6bdb6ee6..454fccc38df1 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1736,7 +1736,6 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	genpd_lock(genpd);
 
 	genpd_set_cpumask(genpd, gpd_data->cpu);
-	dev_pm_domain_set(dev, &genpd->domain);
 
 	genpd->device_count++;
 	if (gd)
@@ -1745,6 +1744,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
 
 	genpd_unlock(genpd);
+	dev_pm_domain_set(dev, &genpd->domain);
  out:
 	if (ret)
 		genpd_free_dev_data(dev, gpd_data);
@@ -1801,12 +1801,13 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 		genpd->gd->max_off_time_changed = true;
 
 	genpd_clear_cpumask(genpd, gpd_data->cpu);
-	dev_pm_domain_set(dev, NULL);
 
 	list_del_init(&pdd->list_node);
 
 	genpd_unlock(genpd);
 
+	dev_pm_domain_set(dev, NULL);
+
 	if (genpd->detach_dev)
 		genpd->detach_dev(genpd, dev);
 
-- 
2.34.1


