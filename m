Return-Path: <linux-pm+bounces-11236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7087E93712D
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2024 01:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8CFEB21D84
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2024 23:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61AB146D54;
	Thu, 18 Jul 2024 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EQCRqAzo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B361465BE
	for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2024 23:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721346209; cv=none; b=SX83Bed6QtqFi3d6c5uG4i2CbT2VqgRifexMe/XBQR4f7mxYyFljwogQnsoGAsS/jkhuKlHn+Oni1H5rWTjmvwyT/jqkcyUDHtxWk82l06Mhv80fqpVWTO6Vd1JmmyIVzBvgnpABR/ViZ9pnqeanCVHlb+b1rVAtHQ/9/kUQI98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721346209; c=relaxed/simple;
	bh=HiN+rgq9gu0Chb+FnevRuAodoxjBWMVVAIsr/15wHVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O4/h41/hNXrft3RSd8M8MkNs/z5aJXbuCagCgTonx1hEAiglEoI3Oke9Ez6MnH42vGcrR4KjGGxjOnt66VMCLkfdU20uEWQPZFYohrhdjtuBVQ8d37uRhzLWflZsTHrVJA36QGXtOjmEWIMqEmbTuJOT+2C7aRxHS5XLvXrIt8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EQCRqAzo; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52ea2ce7abaso1466144e87.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2024 16:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721346206; x=1721951006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zb2TnLEPy/yYn4OHpN9GAbJBX2HlvGglgTvnLaEwow=;
        b=EQCRqAzolnnkPwLdlVvSsRG8JkC2j5iMhLAMg7/OI0XaN/Niyeg7J84DkhgJBACsSJ
         RBtlu/jSzOeyuVxRG4+4KA7pUNFgo4BGeCUfhJ8e/LcFbJHVaTqRuRTABYs5pkiE+POf
         nd99qRC7HyvhanQAPA+N4DkKMai7eR16Mc22EWHBC81V3yT+P3R36zHiqKjwsN5S8w+j
         enc5WsGEBpkTmpie028WIouV6JCbbKlzITRqHMNL07uToUsCRVqnsABYcShOQggcOG+a
         fPisKIyJw+g8/UfV5Aomds5HmA/cpY/VWIYbPCxxYkG5m5HwnL/I/rWthL/a8eAoQXsM
         CTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721346206; x=1721951006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zb2TnLEPy/yYn4OHpN9GAbJBX2HlvGglgTvnLaEwow=;
        b=ON5eGfSOmuQ0rQ8irRNuW5k8K0y6ctvIYFeGh48pW7ouLDGccIjjhHl2R7G3yOXbwG
         jsNbtxpbGcaUrZf5ryJ0tTIhC8dZ0TkJXflBLETwvu1b85h/vTxmz86m0/DBzm8DO9Cw
         xiyxJ0nhid9M4apHirweegEk46Zdmsv/GXfGmB9nQT1IBNa+9kfDIiNlDjkgNb4SyZOh
         G7OSEluCTzDts6DlVE/9Kv6HSuwyU3sXQxTNaAapuT9hif5eiWuQDBFiJZFCfjLTkTvR
         c95mSLpoS4DOSowsMIEuJQti9PytMF86zhmc6pS+4qaW9ObGzsOIoTSw8NeAorM2CZz7
         kkag==
X-Forwarded-Encrypted: i=1; AJvYcCVHl6VIZBVrM0uYUszPMXH7q8iWcQ6i7qSUSiXVIqdZBpr8aXSaYjg9GWqh8HNPntUPM08Y6D4ebvH+XZEtzs8FfMSlEJ4an6Y=
X-Gm-Message-State: AOJu0YwDn09HmorNnEtsZr1O1NJzBGbvEwnXrCnmBfy4GheoTpSEVQgV
	oKmdDvTSrX/5MRLwnBawLvLrmhfJObEjSkm/kNX6fiqSSzPe1YIjhGB9iqzsRIg=
X-Google-Smtp-Source: AGHT+IFF8smI3aMAQT3AbKX1NQGZpHaJaCkvum5gaxbfN2nJOzdqHbIsk7af5xBZTpN9HOnmw05rOw==
X-Received: by 2002:a05:6512:ac7:b0:52b:9c8a:734f with SMTP id 2adb3069b0e04-52ee5411e3dmr5098927e87.50.1721346205884;
        Thu, 18 Jul 2024 16:43:25 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef556b4fbsm22491e87.139.2024.07.18.16.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 16:43:25 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/6] OPP: Fix support for required OPPs for multiple PM domains
Date: Fri, 19 Jul 2024 01:43:14 +0200
Message-Id: <20240718234319.356451-2-ulf.hansson@linaro.org>
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

It has turned out that having _set_required_opps() to recursively call
dev_pm_opp_set_opp() to set the required OPPs, doesn't really work as well
as we expected.

More precisely, at each recursive call to dev_pm_opp_set_opp() we are
changing the OPP for a genpd's OPP table for a device that has been
attached to it. The problem with this, is that we may have several devices
being attached to the same genpd, thus sharing the same OPP-table that is
being used for their required OPPs. So, typically we may have several
active requests simultaneously for different OPPs for a genpd's OPP table.
This may lead to that the per device vote for a performance-state
(opp-level) for a genpd doesn't get requested accordingly.

Moreover, dev_pm_opp_set_opp() doesn't get called for a required OPP when a
device has been attached to a single PM domain. Even if a consumer driver
would attempt to assign the required-devs, via _opp_attach_genpd() or
_opp_set_required_devs() it would not be possible, as there is no separate
virtual device at hand to use in this case.

The above said, let's fix the problem by replacing the call to
dev_pm_opp_set_opp() in _set_required_opps() by a call to _set_opp_level().
At the moment there's no drawback doing this, as there is no need to manage
anything but the performance-state of the genpd. If it later turns out that
another resource needs to be managed for a required-OPP, it can still be
extended without having to call dev_pm_opp_set_opp().

Fixes: e37440e7e2c2 ("OPP: Call dev_pm_opp_set_opp() for required OPPs")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Clarified the commitmsg.
	- Addressed some comments from Viresh.
	- Drop calls to _add_opp_dev() for required_devs.

---
 drivers/opp/core.c | 56 ++++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 5f4598246a87..494f8860220d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1061,6 +1061,27 @@ static int _set_opp_bw(const struct opp_table *opp_table,
 	return 0;
 }
 
+static int _set_opp_level(struct device *dev, struct dev_pm_opp *opp)
+{
+	unsigned int level = 0;
+	int ret = 0;
+
+	if (opp) {
+		if (opp->level == OPP_LEVEL_UNSET)
+			return 0;
+
+		level = opp->level;
+	}
+
+	/* Request a new performance state through the device's PM domain. */
+	ret = dev_pm_domain_set_performance_state(dev, level);
+	if (ret)
+		dev_err(dev, "Failed to set performance state %u (%d)\n", level,
+			ret);
+
+	return ret;
+}
+
 /* This is only called for PM domain for now */
 static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 			      struct dev_pm_opp *opp, bool up)
@@ -1091,7 +1112,7 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 		if (devs[index]) {
 			required_opp = opp ? opp->required_opps[index] : NULL;
 
-			ret = dev_pm_opp_set_opp(devs[index], required_opp);
+			ret = _set_opp_level(devs[index], required_opp);
 			if (ret)
 				return ret;
 		}
@@ -1102,27 +1123,6 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 	return 0;
 }
 
-static int _set_opp_level(struct device *dev, struct dev_pm_opp *opp)
-{
-	unsigned int level = 0;
-	int ret = 0;
-
-	if (opp) {
-		if (opp->level == OPP_LEVEL_UNSET)
-			return 0;
-
-		level = opp->level;
-	}
-
-	/* Request a new performance state through the device's PM domain. */
-	ret = dev_pm_domain_set_performance_state(dev, level);
-	if (ret)
-		dev_err(dev, "Failed to set performance state %u (%d)\n", level,
-			ret);
-
-	return ret;
-}
-
 static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
@@ -2457,18 +2457,6 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 			}
 		}
 
-		/*
-		 * Add the virtual genpd device as a user of the OPP table, so
-		 * we can call dev_pm_opp_set_opp() on it directly.
-		 *
-		 * This will be automatically removed when the OPP table is
-		 * removed, don't need to handle that here.
-		 */
-		if (!_add_opp_dev(virt_dev, opp_table->required_opp_tables[index])) {
-			ret = -ENOMEM;
-			goto err;
-		}
-
 		opp_table->required_devs[index] = virt_dev;
 		index++;
 		name++;
-- 
2.34.1


