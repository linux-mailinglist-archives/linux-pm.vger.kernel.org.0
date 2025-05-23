Return-Path: <linux-pm+bounces-27564-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6963FAC2436
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E90C3A9A61
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 13:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C7C2949FF;
	Fri, 23 May 2025 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZRBJL0P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA2D293B7A
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007647; cv=none; b=nnHgCVYEtE61/YVnDtRRKMn/nnLT/5nWxMNBRw6TxuErI0KQMvBMVW8JV9JyMcq5VaBirggZnIX8GVPeNeJpWMWtFvalTf8cJ5FAaKgGuurOvpfFIbSU4SA4YtIPCAXs1jvDlHdkP7HtOV75BHChf+s0DA1gk26phgak/kOyVl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007647; c=relaxed/simple;
	bh=rvDBm88S7HVgvVUDiuw3q7zPuLExbVy9UL4/VZLr+SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amGEehpKNC/k5vEr0XllCRGvE1vZftcOhKMEExiVHXwMbouwAl13erJxxUlFc1c8WIXJtVdsepxxUmhgO5qdwHrf4JsRa8zYz3KsoigUQe97Hlnd/2IQsn0jjnO+Q60YNlTemnwWu4EptE+yAjaz7IfCNmCY8heZxy7TS4S8pqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hZRBJL0P; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-551efd86048so7532782e87.3
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 06:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748007644; x=1748612444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dwV7gI+Nsvg70NFtF53M46En6xO9EIKkeyF4GjRazs=;
        b=hZRBJL0PCmBos6X357czaEbqtH3FAhvv4JD2xiorvpaPCBFcz3kFCgkv7AJHwe2XGJ
         8Td/VvgUoeQEabpMiuHQpufyVu42slGfXiL/phdgxeo2Kc9ga7L+nR0oCPZB5Prdg6LO
         l5nmjfsv03aDFPun43w7KJb0zp+op92zT5mMXhSC+GE/i0SlWHiz5nvVenMCJHeL7t3N
         CeAb1Sw0kAR5ZRLHeSqQBvsAa2wWClyyQ6s4vQsaVt4nfnz7sdhqIurPV+g4/CdNTTfg
         0wDuZz+QZMuSG/Kv2BEvVsb9SdL38r4YUfjAgJJOHBV22o66sdi4NuHwQHp2RB4ja+QB
         WtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007644; x=1748612444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dwV7gI+Nsvg70NFtF53M46En6xO9EIKkeyF4GjRazs=;
        b=YBaTHsj7o2x8MqkRaZUO8jt2P3H2D8l7RCHirPcXPjgiF/ZtafANZeJz2GYJUUDv5d
         fUGSQlAPRTTq9r1y3rsZKyjHYC6qlBWncIncDajyBz/C2YR1fNHgawfUTxnO1XbjUAe5
         VWau2zdsM6V/Koy6GCSzYbokSUuQKoE9daE99sAm9CNVURzSIc6znF8m2syLPlO1fza5
         5DUrzoqHouowgYDzX26YA5Qc3/mht8sMJzRyu7wiJSOsIwP6FuCmI9E/SeO8ekz+umyv
         Z4Q7afSzth3GIUZ5Ah5ufwZ7zkXEhHmb6ayWQaHCwZJM5St5mQ1Q6uv/CsFHvnBUuPBL
         FRTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeA/GBkFOR73XXV5EKvWbWLdtKiWSvKiGbjiY5gz29lUYET3+ISGBkNYJ7s+Bksyhhug4Ne+yeMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRyBukIRKSVsDj9PK1I2LE7obUBQJVVBxHr/PY6h0KHDuuwA3B
	AuOi7g4G7c8AejJQzzC0qVzSLvOhaFZA3+6+blfnbufLtcaBCMnKayIL/k0LumNH758=
X-Gm-Gg: ASbGncsBdxF9qzGp7TxEJuoDxnUWmLe0gB1E0BEEI0HIz9FAAG4U+IQ+U2gQcUAGRYy
	ciMQDL1xiROiqIBkYURO0AnEkczKEp125xjTvwbuYpsA+lCU75WK7Dr282sY25WZ/gV7twEjsxV
	UsErLSAUIHxiT91b7E3AHmaTCuBVeTHbSiSgvIbjSZLWdyiQjLDXaIlb9GHt6pg9WWg5IaY2dBT
	7+vynFu9AubnRhIQzxysWXZONB5wzW/VA1FOfG3fKSTIdVJkQ3ixZTgGzgFW3dVR/Vx7+Cs3T2Y
	hGpbYg0TLn4blcwoqSg6bPJ1rL7tS0N3MAYM9PVZ/UhWqa++ZpJfZgDm1CQqRabYEU45JfGGKk0
	YD+g4n8ey0YlWWrh6TTmMpWH1Yg==
X-Google-Smtp-Source: AGHT+IGBn6n6EgDrMlkJDyd0jqLFfex9/E7P3NJi4ff8Az72HWi1omtWGQrPu5v8XW0RIf89Dfo3KQ==
X-Received: by 2002:a05:6512:6618:b0:549:c1e6:cbc9 with SMTP id 2adb3069b0e04-550e97a1835mr7651160e87.18.1748007643820;
        Fri, 23 May 2025 06:40:43 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551fc0d473bsm1950609e87.244.2025.05.23.06.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:40:43 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/21] pmdomain: core: Add the genpd->dev to the genpd provider bus
Date: Fri, 23 May 2025 15:40:00 +0200
Message-ID: <20250523134025.75130-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523134025.75130-1-ulf.hansson@linaro.org>
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
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

Suggested-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index da515350c65b..8d5dca22e35e 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2637,11 +2637,17 @@ int of_genpd_add_provider_simple(struct device_node *np,
 
 	genpd->dev.of_node = np;
 
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
@@ -2652,19 +2658,22 @@ int of_genpd_add_provider_simple(struct device_node *np,
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
 
 	genpd->provider = &np->fwnode;
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
 
@@ -2696,12 +2705,17 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 
 		genpd->dev.of_node = np;
 
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
 
@@ -2737,6 +2751,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 			dev_pm_opp_put_opp_table(genpd->opp_table);
 			dev_pm_opp_of_remove_table(&genpd->dev);
 		}
+
+		device_del(&genpd->dev);
 	}
 
 	return ret;
@@ -2769,6 +2785,8 @@ void of_genpd_del_provider(struct device_node *np)
 						dev_pm_opp_put_opp_table(gpd->opp_table);
 						dev_pm_opp_of_remove_table(&gpd->dev);
 					}
+
+					device_del(&gpd->dev);
 				}
 			}
 
-- 
2.43.0


