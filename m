Return-Path: <linux-pm+bounces-11238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE76937134
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 01:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25980B21FA9
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 23:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86B51474D4;
	Thu, 18 Jul 2024 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yKnCZb6K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0823E146D6A
	for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2024 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721346211; cv=none; b=DWTMUO3UEHgrcFG8oGVDP/4CltAX+e/uJJtg53kJWTO9cnmTugdnYFjrgO0sYs89jkZxzD4UMG5vvFdjOpy60JfD2GlVCj7Ew1G7eaPJgSSwLCgXqD13SEEnkcP7ZenNqzIrq3oA8fvLfFN5qfczIlBn1Jel1mYMSC6M5w8JbAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721346211; c=relaxed/simple;
	bh=Y3hwNFUGYkYRfIHL/7k3SZgbiEUCm5J9K1Jr9I8q53M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ED/xJI7FQqFsiQrn//VviOhlyxXtVcas5aDd7F45NVtB3F2lVPRrkMJpp4Y47xgJ1kpvcU8n3egzOhJX4yU/lSapclu4RsET62CF1rM0gAMBA6Y8/hcMAqhGLAoTdFUuqpvb4IQb8JDoVMkNFtSLd7PYQETWA5Hy35reYAt+XsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yKnCZb6K; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52e98087e32so1139322e87.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2024 16:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721346208; x=1721951008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Faj5QcK3We3F3NVuTbRR7vS8a3eBKTUsob4pR7kBr7Q=;
        b=yKnCZb6Khu8Vs/frX6dovOzo+VqjRnJLPt76bngbG/WkJpPmeL6numGXRUd1PqsRxK
         sr5YHmR6QeL0XnaBwUsxDzZ2IADNag2S2rIE6WNbPiowBiIiQLm4tH3zvqoy/+mp2305
         7/2PeV1j2TZaI4AydX/rR6w1G0IW3uTCR8Cd/EaQVcYDRv1LWf2ACT/bUD0ZK6euw2DL
         mb+JS/fSvHb0LJcQJHeM5djNJmbU0I6wWHx1jWUu3QQFAEAc03vMBFoDvGsjvr7b2+ww
         BfrvFur/10FxxnMvk8wXd3yovtRzQXoIerCSI+VZb5kru4E/33F2HnLJBGLG4R4oJzV7
         PNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721346208; x=1721951008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Faj5QcK3We3F3NVuTbRR7vS8a3eBKTUsob4pR7kBr7Q=;
        b=hlWiuEsvtlVOOJSSDqeJvaTTWTqImvPYcW+DMCvgyXBM6IC9d4W++oWd4jHZUsIyZs
         Io/+DYxHAHzrzVb1MpKua3ogP1fRucS4Wqwg4cs8Ro31QTKxoIf/bndpNO10FMvxlvZc
         y+oauEmNRCOCcBMleatcPIsj4EsmaxuEm7A9P1HodAoO9u1Uo9oye5QyLULGHtlgDRkX
         Oq0bYlRAnLBTsN0Vt0t4rqSMOZEKwHFBmHBNlm/m3dhjASVnrGJ1S26Chagvp/wOQitj
         8Zrb5McNFSLvWds9q8Z6i3kH1PQEZk249WSj9E/DAnLBliswyctZ/NcF8kzs8t24SSfj
         kUkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoBy0CPXnuhxRgwg+DgukQGcKKK3N9zC0vZZDE1CGvR1IeSD11nEjXlKfPuSNQgO2jVFYhVW4pLm2+v68y/eQ8rtO6C/qbEKk=
X-Gm-Message-State: AOJu0YwxlVW6KJM1K+IPKYFvIe0CeD1gy2rtnKT+mkUzLJy+5yirAOY1
	x76WXsHRuR1MwFMPWve4zNGl5rXQJ8J5aev6FIYMT4FIjpHZ70vbF4TUMwGmNgyVPgr0BcXyM00
	6
X-Google-Smtp-Source: AGHT+IHK7FOzBoV+1FS5of2LM4i6O9EZB5TaiB2xWzxT7vDsImay40B6se0ysI9gGqmvrwlYKjDpPA==
X-Received: by 2002:a05:6512:234b:b0:52e:9cf0:69cf with SMTP id 2adb3069b0e04-52eeaea73bdmr3196721e87.62.1721346208245;
        Thu, 18 Jul 2024 16:43:28 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef556b4fbsm22491e87.139.2024.07.18.16.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 16:43:27 -0700 (PDT)
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
Subject: [PATCH v2 3/6] pmdomain: core: Manage the default required OPP from a separate function
Date: Fri, 19 Jul 2024 01:43:16 +0200
Message-Id: <20240718234319.356451-4-ulf.hansson@linaro.org>
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

To improve the readability of the code in __genpd_dev_pm_attach(), let's
move out the required OPP handling into a separate function.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- None.
---
 drivers/pmdomain/core.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 623d15b68707..930cd5382032 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2774,12 +2774,34 @@ static void genpd_dev_pm_sync(struct device *dev)
 	genpd_queue_power_off_work(pd);
 }
 
+static int genpd_set_required_opp(struct device *dev, unsigned int index)
+{
+	int ret, pstate;
+
+	/* Set the default performance state */
+	pstate = of_get_required_opp_performance_state(dev->of_node, index);
+	if (pstate < 0 && pstate != -ENODEV && pstate != -EOPNOTSUPP) {
+		ret = pstate;
+		goto err;
+	} else if (pstate > 0) {
+		ret = dev_pm_genpd_set_performance_state(dev, pstate);
+		if (ret)
+			goto err;
+		dev_gpd_data(dev)->default_pstate = pstate;
+	}
+
+	return 0;
+err:
+	dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
+		dev_to_genpd(dev)->name, ret);
+	return ret;
+}
+
 static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 				 unsigned int index, bool power_on)
 {
 	struct of_phandle_args pd_args;
 	struct generic_pm_domain *pd;
-	int pstate;
 	int ret;
 
 	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
@@ -2808,17 +2830,9 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 	dev->pm_domain->detach = genpd_dev_pm_detach;
 	dev->pm_domain->sync = genpd_dev_pm_sync;
 
-	/* Set the default performance state */
-	pstate = of_get_required_opp_performance_state(dev->of_node, index);
-	if (pstate < 0 && pstate != -ENODEV && pstate != -EOPNOTSUPP) {
-		ret = pstate;
+	ret = genpd_set_required_opp(dev, index);
+	if (ret)
 		goto err;
-	} else if (pstate > 0) {
-		ret = dev_pm_genpd_set_performance_state(dev, pstate);
-		if (ret)
-			goto err;
-		dev_gpd_data(dev)->default_pstate = pstate;
-	}
 
 	if (power_on) {
 		genpd_lock(pd);
@@ -2840,8 +2854,6 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 	return 1;
 
 err:
-	dev_err(dev, "failed to set required performance state for power-domain %s: %d\n",
-		pd->name, ret);
 	genpd_remove_device(pd, dev);
 	return ret;
 }
-- 
2.34.1


