Return-Path: <linux-pm+bounces-25641-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8149CA91F94
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 16:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 555F97B23CB
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D04A25333D;
	Thu, 17 Apr 2025 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YhmeIm5G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCFC2528E6
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899945; cv=none; b=CkMNHisb117zGsglL8kBXEwmND61x0F9/AjL4YNNw40x9RdZPd3+yhFCguRAeITytoZf59VbvOJ2aMj9X0xo/bDaOOXv8JiB12A5+SnL52470SpGj+2/SN+jL245cJlv0QaKz/0Kzzc6R71jm3Qpmfp5M0GUJwVSfoAg2YzcBvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899945; c=relaxed/simple;
	bh=mCvK16gSgEDQy1+5bYn7FFtCLXuKxhPqDJ3FRjReYEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7nx7LbPGOix3/C3g9JU7UcTpMmY7uZNzQSGPmJbvZjFy+meMym5nrFhICOf8Xibmo7poV2pi7nQlgCmBy7kHbBui3bN70w5rwxf572MlYfmqZcSPlwMXFaRjaD/m0XJl6vz1Ye9VaEvrnaeg5GjYgpexi/Ql0h3sEcLN1UJCqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YhmeIm5G; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54996d30bfbso786546e87.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744899942; x=1745504742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhCzeeuIRn9U4lLFeFB39wEFdroIdbbgBLNLNN654Y4=;
        b=YhmeIm5Gv+7KPC7WLKw4TTfzlaVcxpqkiHsyMEDZaBV2xsaHhfV9xgH3WpL1WIaKtW
         eAVoTBxfiZfWZsErRI2Tg6ajPU2wH+WPqae2x1s2rJdSb6lT1ZV2oXsxNUvNBXW+drII
         ExfeJ7zk3xKLyIPV9uvOnSfvZOj92GlwWYce8PgvMCLVs9sx5bURTZi7ORXKZPgRufLd
         55hnG75pfgVeGhoQhmEnNadY2gpxe6IHlJIWGJMWRAZT+hSTNsnfNX/CsF9VkuzAC7ba
         t3IEck7D7wF/xFgxHNZIY/Ia6uSnH059t2eUnJBAyJvJF6uNFC7Dyhb1qiQ9JaQWVQJi
         z9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744899942; x=1745504742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhCzeeuIRn9U4lLFeFB39wEFdroIdbbgBLNLNN654Y4=;
        b=JWMeOSC7USu2jk7H4YQOABkH2nwLbH9jMIyWYdOhCJrTaONHp7QYxubn7lUo/l/Jyc
         J2uue3CM+TkCP5IAGGWo4NJEejj6h81L5YFZ1NhsqZWCjpy7UqEbuliOAgqrLsAjg3NT
         Z5dYet1XMMG+mTVIry8RCIShq4N+/ut9Q5+p08q1A92t8HUFytBKD0umIYmvdLulgciT
         PDee9bSkqYtU0Z8rkZJpxFlX9Sg9rgGyH20fm4oT55egk8oZynwybFYZeU2lqqZ1iw2d
         3CNR90i+mIobuQayejkI/ByAEbODxx5XeekCzghaoRYTHfpUrJjL2u8Kaa3kLj9p70mA
         dAHA==
X-Forwarded-Encrypted: i=1; AJvYcCXQQ3zqgAalYlA2QtRFZBxg/q2HY5+gvrrl03J9Pd6+6Gq8fIz/2gnB9RkIKceRO54uiNWc6EiSNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWOxnmOoo3SqLLlPn0Zh4hRR7QYprjKYGaz0PnduAFHjI5tD4f
	wOYNP92PAb2JhlpyBdkVCgbcecn67Lj5E2d/9B2eHZ016ukL+f/ZbKhU5RunUs0=
X-Gm-Gg: ASbGncv7DzLXC1YbbqnP9IgcCllnCPsgLpfQIv7LRE1VWyWIpelwbsVeKNvEjXxa09G
	1Eo+SJsunzB26d3Xmt35Gx2YmhvzozsodlbfbPu2CaBG7rolaGgpjDnB3oigAphY/dd58kou/Uk
	8Ix3C1sYn1fY+CEVzO6Hv1DFCeE5M2nzV+e+slfFGM5jG5J3s9tYDRHk53Q4tzZR2/qnbwTYtRr
	X2Yy+SiB7/vbcaPpLRwIvEYf7KjCSi7H4J51pfYRqHtfzEgaIhdqeSEnXHosFQNtKwztv+rFuC0
	7UYe41IVeyjDqyfyorGc5wbbN5dTvt4Rgq7eQHZpY4IC0YCGEWpi5Y9pVWHZhMmql9ghOInDSo3
	rGvxoM7rxvIensfA=
X-Google-Smtp-Source: AGHT+IEKg2sAljzc60RG1x7zQS31Y71/y6HRPvtwzajn+isSwZjg667wjhQKlzCNX2y4YKOKam9UjA==
X-Received: by 2002:a05:6512:10d5:b0:549:8675:c388 with SMTP id 2adb3069b0e04-54d64af3fbbmr2088472e87.52.1744899942203;
        Thu, 17 Apr 2025 07:25:42 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d65e43647sm370096e87.58.2025.04.17.07.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 07:25:41 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] pmdomain: core: Add the genpd->dev to the genpd provider bus
Date: Thu, 17 Apr 2025 16:25:04 +0200
Message-ID: <20250417142513.312939-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417142513.312939-1-ulf.hansson@linaro.org>
References: <20250417142513.312939-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To take the next step for a more common handling of the genpd providers,
let's add the genpd->dev to the genpd provider bus when registering a genpd
OF provider.

Beyond this, the corresponding genpd provider driver's ->probe(),
->remove() and ->sync_state() callbacks starts to be invoked. However,
let's leave those callbacks as empty functions for now. Instead, subsequent
changes will implement them.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 3911d3e96626..5aba66ac78f1 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2640,11 +2640,17 @@ int of_genpd_add_provider_simple(struct device_node *np,
 
 	device_set_node(&genpd->dev, fwnode);
 
+	ret = device_add(&genpd->dev);
+	if (ret)
+		return ret;
+
 	/* Parse genpd OPP table */
 	if (!genpd_is_opp_table_fw(genpd) && genpd->set_performance_state) {
 		ret = dev_pm_opp_of_add_table(&genpd->dev);
-		if (ret)
-			return dev_err_probe(&genpd->dev, ret, "Failed to add OPP table\n");
+		if (ret) {
+			dev_err_probe(&genpd->dev, ret, "Failed to add OPP table\n");
+			goto err_del;
+		}
 
 		/*
 		 * Save table for faster processing while setting performance
@@ -2655,19 +2661,22 @@ int of_genpd_add_provider_simple(struct device_node *np,
 	}
 
 	ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
-	if (ret) {
-		if (genpd->opp_table) {
-			dev_pm_opp_put_opp_table(genpd->opp_table);
-			dev_pm_opp_of_remove_table(&genpd->dev);
-		}
-
-		return ret;
-	}
+	if (ret)
+		goto err_opp;
 
 	genpd->provider = fwnode;
 	genpd->has_provider = true;
 
 	return 0;
+
+err_opp:
+	if (genpd->opp_table) {
+		dev_pm_opp_put_opp_table(genpd->opp_table);
+		dev_pm_opp_of_remove_table(&genpd->dev);
+	}
+err_del:
+	device_del(&genpd->dev);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(of_genpd_add_provider_simple);
 
@@ -2702,12 +2711,17 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 
 		device_set_node(&genpd->dev, fwnode);
 
+		ret = device_add(&genpd->dev);
+		if (ret)
+			goto error;
+
 		/* Parse genpd OPP table */
 		if (!genpd_is_opp_table_fw(genpd) && genpd->set_performance_state) {
 			ret = dev_pm_opp_of_add_table_indexed(&genpd->dev, i);
 			if (ret) {
 				dev_err_probe(&genpd->dev, ret,
 					      "Failed to add OPP table for index %d\n", i);
+				device_del(&genpd->dev);
 				goto error;
 			}
 
@@ -2743,6 +2757,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 			dev_pm_opp_put_opp_table(genpd->opp_table);
 			dev_pm_opp_of_remove_table(&genpd->dev);
 		}
+
+		device_del(&genpd->dev);
 	}
 
 	return ret;
@@ -2775,6 +2791,8 @@ void of_genpd_del_provider(struct device_node *np)
 						dev_pm_opp_put_opp_table(gpd->opp_table);
 						dev_pm_opp_of_remove_table(&gpd->dev);
 					}
+
+					device_del(&gpd->dev);
 				}
 			}
 
-- 
2.43.0


