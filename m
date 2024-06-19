Return-Path: <linux-pm+bounces-9588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7940790EFC9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 16:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E58E2B214E3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 14:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6315F1552FF;
	Wed, 19 Jun 2024 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uXlD6olg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97529154420
	for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806161; cv=none; b=mh7GHozzqOulw8jcjGqlKZj+JbuoSVE9ow0gw13rpTM6qib6ZXqzoHxdaHvxPYscPGFbVBZifa7HgpbxrCVH5Lr/F/AGPWISuKQ0qRHk4QZNmGj5w1uyfCDp6ucOmnSGbBDcXXLRMf7FVtxG6bLtRvGTaw5dGWnhNGTFoWp0CuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806161; c=relaxed/simple;
	bh=tMkKP1j3bPuCq4pIK6nHgDfdOCxrfuXOdv1IXJAZ2JI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MNocW8InXCT2HqiivcHubqnWlRX8389Rgo/cPe35QUNHS7+859haMlvwvYx7W3xcu72JFltb5ofQ10mdh8SNZ+cULQS4AGwSzTFg+xogOXzPVzqIPOHfGZADxMCo8JePXJrW9aMxwNYhtmrvc8QvAm3reMBGT3v2MtQjiJ43YwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uXlD6olg; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52bbf73f334so6348192e87.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 07:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718806158; x=1719410958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CngIhS3kRulmGpU0Rg5JrWUuRc/630k552QGhg/cDY=;
        b=uXlD6olgAX1XYnFHcIuNNjtrSHiXI4DaZY3yL2t5QT2XfkplFCnxbZdJTviVhc39fR
         3K9D01pwUPEg28oXcKRIjlNSrZK1yk9a5kaMp2BhqMV8SgPN7OIdzAdwC8uY0PLBK3wh
         5+HcyOU+scfZ7ICiiqPrrOiIl0jnd3c9eT5uFm9NwBZasV3zdQEWlP/1Ox/PUsxH/b4l
         Obso2qXO+lpG1WymmtK4ktMsg6iVtpdKh1gVh6S7rpsae5dovkiark6HMxNSXvKwJKu2
         wMq45yGBQxehJ2KV3pxHmG35I3OOsIFf219XluuRanpdLwi7FnGV40N/wC53m8h9aV4p
         Wlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806158; x=1719410958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CngIhS3kRulmGpU0Rg5JrWUuRc/630k552QGhg/cDY=;
        b=n13RgzYAGeMM55As6+e5XWRiXtNN+JTMJnZHBttvzyvKOjKHuIqTxe2gIYR9gVmbgi
         y5Bi+s4pElpTNLEluExoXF5IexmQ4H6i3ZlzV5Kd7PSgGAse+9ms655OpKG2hAo42Dmw
         XrgAjd4L7qSbz2HABMXaSX+Tc5g4mItriI1BjNUwdkGolow71hmCQPcKz42baPrga0fn
         S1USnMV5/s89BCpKy9Lm+6rPSslADhCHuGeumYnLdyl9V6jOf4svSnn4mFw4nqBdUl7f
         6TXgzN29K89uMf4m2yeCgysfu5IkGDqBcgOlhn3nnohUeTRrdglRaGcuvcvHKwrV0/Ud
         yl5g==
X-Forwarded-Encrypted: i=1; AJvYcCW2z8JVvCREGCLlX+uMT3NcwGhvg059H+T099Oud/IYAiIh9ZXQOm1Ei1L/FwJwNn8mQDs+GugpnpSHuvDipWRHvH0N4VGE3FM=
X-Gm-Message-State: AOJu0Yw5hSEavBPb8gWdEENXKye+k8wVM3fF2Ljxf5gfOpDGV25u2yYg
	21yZtUQcFFbui8zhQ7/D4SN6tNNcUrq83vvx8kzsnanRjWaKJeN0I6wn8piHqZY=
X-Google-Smtp-Source: AGHT+IGtMjaVRxqwME3U7CGrSptN6JfejN8F/ypK0frJbXiy1thTIGiCDNeAXU2vN4DLOqXBQiFdNw==
X-Received: by 2002:a05:6512:3ca1:b0:52c:8b03:99d6 with SMTP id 2adb3069b0e04-52ccaa585e9mr2256803e87.6.1718806157835;
        Wed, 19 Jun 2024 07:09:17 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2872241sm1787003e87.124.2024.06.19.07.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:09:17 -0700 (PDT)
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
Subject: [PATCH 7/7] pmdomain: core: Drop the redundant dev_to_genpd_dev()
Date: Wed, 19 Jun 2024 16:08:49 +0200
Message-Id: <20240619140849.368580-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619140849.368580-1-ulf.hansson@linaro.org>
References: <20240619140849.368580-1-ulf.hansson@linaro.org>
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
 drivers/pmdomain/core.c   | 10 ----------
 include/linux/pm_domain.h |  6 ------
 2 files changed, 16 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index a38d08862a61..4abedbb65354 100644
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


