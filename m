Return-Path: <linux-pm+bounces-15305-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE13994385
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 11:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26A04B278BD
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 09:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5D81D3185;
	Tue,  8 Oct 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="seCLATiI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23441CEE90
	for <linux-pm@vger.kernel.org>; Tue,  8 Oct 2024 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378028; cv=none; b=p+66k2l+xpyxjtDbM/hB+1ocbgK11+cZqM3Kmjzvrcjh7+WAZxfybxj9NW/t86Jzd/cSEX9ssgoDuWKUhRy3aKjg4sklW1v6TghS+ldJFSiX0oE40KCJ2dDOu88dFQCwL3rNlOHqx7hbEUFdFgZV6uECPAQrN+BwaJ7zg01pYII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378028; c=relaxed/simple;
	bh=f8R4vPEQrLlg+uQU0hqpfy7huKkBhYLvXSmkKXC3XkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Odh4fLwrwdhWIfCVqfAuSMYWPqu9nye127eVkE94UsLAOCUmVuIVD6HO4vwamJoszIv4p2lslWrV+gnif4p5RW0QZMvMlz0++giijnJaWRTBuDZWJgwdyHKjtYggh/f9RJdoVifyayXlKn9OPSHyQiwg/txCsKEHj8MzoLl29c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=seCLATiI; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c88367684bso1059367a12.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Oct 2024 02:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728378023; x=1728982823; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VqC8VxguTcsDUEEbczg9yl17o4tpL25LM2OL53pKrc=;
        b=seCLATiI4R+AewsoPujGGIfasJHzykFQjKzivcfiHn7fW+gC4IglKMaX/6dWK1lWyX
         4drF+POUMjKjzF17sGtjo5hdhU/y3k8I4FDs8USAK8sDmOAgiSP6Ra5rm/XAvWAa/0za
         3rUnyyTfB7kllQe3zuz5Ikcf0lYhgnk1ffjccFQOWzVlOoWZPYzfjUIt3t5mT4mpJCYr
         sNXoXywmoV0DAbwaA+OyvgksMwqUTIgWtSgJEnhx4fRH0QThplFn+TJLzStlYQ3ELMVk
         ozhr+fNs19GSvVHnO0SZugKy6BOr3+Tf5Qbhiuuu1wkySy0dVO9lYGTYAvWleAnXproy
         ITrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728378023; x=1728982823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VqC8VxguTcsDUEEbczg9yl17o4tpL25LM2OL53pKrc=;
        b=MSSM+XFkqE/tv5/y8fi9mg1klHuFkjCbFK/iaFNcd1g4vkjc0VMqztf05kxAwz/jSw
         jB65rMGecvHQE2NptN1eJFD49FHxli6VSkef3xrqOg71l3Bxhh2Gooa1mqjRBoFts2Au
         yffeUqRcSg4naSQfUvRo9qNy1pSNtr2nmj+PMIFLSmw2rqdWZEyJRpXSDg+Wu1z3Nvow
         RKCAa5/A0F8F/jf4o+kb00q5G8kWduAuytFaw4W/QUXVjVgnZF5DdzKbJqjLKCatRnmu
         C5yAF3Vxm/jPyHnZmgDIVqFoVNDvTblffUJhooSUjI+g4XDqm8QefOh1kDxg7h+KqdF7
         juzw==
X-Gm-Message-State: AOJu0YwC+BRhORO9Sm5Wb9lCNyLzPScMpvQSDuLyYreTavZT7XqaBQdl
	wnUDiyBGw5EmIausggPOJqLBM99Ccqjy0yYwWOtq8ikiOi3Z8ngwCyZCRqsj1Z4=
X-Google-Smtp-Source: AGHT+IFEyUOTrrK9/MFjPogQ0jScCR6ikh+1YFZdLnlwxjJjHIEA4i0X2pX53X+tA6dUtRJR33C3mQ==
X-Received: by 2002:a17:907:7f8e:b0:a99:63d8:a1a8 with SMTP id a640c23a62f3a-a9963d8a3c9mr114298866b.1.1728378023275;
        Tue, 08 Oct 2024 02:00:23 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994e6e571asm294701166b.85.2024.10.08.02.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 02:00:22 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 08 Oct 2024 11:00:03 +0200
Subject: [PATCH v3 3/6] thermal: of: Use scoped device node handling to
 simplify of_thermal_zone_find()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-b4-cleanup-h-of-node-put-thermal-v3-3-825122398f71@linaro.org>
References: <20241008-b4-cleanup-h-of-node-put-thermal-v3-0-825122398f71@linaro.org>
In-Reply-To: <20241008-b4-cleanup-h-of-node-put-thermal-v3-0-825122398f71@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Chen-Yu Tsai <wenst@chromium.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2232;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=f8R4vPEQrLlg+uQU0hqpfy7huKkBhYLvXSmkKXC3XkA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnBPSc31927xZQcLU9qXE2lgs2BbLCHiXUAd+pK
 iFxi47CEw6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZwT0nAAKCRDBN2bmhouD
 15oeEACMPR9GWv/Lx6eziZByXPhR16yhAuUFH+uuwrhfEAQ4OoGlvn4Hs2p2xNeK0o23LSFTF84
 5/585BxDyRxRxD5QUwVkAG4hjhOtM6d36WED3JkfWf2JfMOuDD7RyUlhBJoaQpoKTdqlFxX83Ho
 WfacrlEkzaUrb/lDCXRkwqvT/W6txqPHYu7/58XL6uJw1B/HFLNqVHgMNik3twv5hYXuxQDYYJf
 isAjLv4jmumNsZmNKMGCJzd2m7iw38DG6IbBb9YpRLHrFpE2UT/wSR/5FUE3vfY/gbxZq3IV+/K
 uJlL5QNoxac2OIN9gAaq4VPhFEfSDJ093n2ndKb8077Nin5Xlx39Hu+/OHjcuYhQEKWrR7slXDv
 YSYn+LMPCogPt+pSAwNuVcl5TDGqdaP5jzuEzM5CdPWkO1JUn3BpdmRMkF17skarY4Ah1+dkio4
 vevoWc3Nxi1eSXIk4pyN1kgARorqU2h2aNa9b+JDg7JZmB2w/QD6AFO0+zQZRuIUheJinukanpq
 UwOx7kKPX4tn6V8IU0E09c5RBpmgLh3h8u/TuSVvVauunSDe4uykBA0zgeoilt1/oWEPkY1e5ym
 o5+1PlHncSFlWKZg8nT5fdBt8AOCn0Yu/0hwRQ/w62u1UbZBA+VYMI6sL3CepEpBJApQcx7Cg+m
 +cvCh7nM/j/YjSw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Obtain the device node reference with scoped/cleanup.h to reduce error
handling and make the code a bit simpler.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/thermal_of.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index d7d6f62caa13d545e5f7fae4c8ac1e737bf4c4b1..a2e20986668b7aa465f3f2ab861f70101d2111c8 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -134,10 +134,9 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
 
 static struct device_node *of_thermal_zone_find(struct device_node *sensor, int id)
 {
-	struct device_node *np, *tz;
 	struct of_phandle_args sensor_specs;
 
-	np = of_find_node_by_name(NULL, "thermal-zones");
+	struct device_node *np __free(device_node) = of_find_node_by_name(NULL, "thermal-zones");
 	if (!np) {
 		pr_debug("No thermal zones description\n");
 		return ERR_PTR(-ENODEV);
@@ -155,8 +154,7 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 						   "#thermal-sensor-cells");
 		if (count <= 0) {
 			pr_err("%pOFn: missing thermal sensor\n", child);
-			tz = ERR_PTR(-EINVAL);
-			goto out;
+			return ERR_PTR(-EINVAL);
 		}
 
 		for (i = 0; i < count; i++) {
@@ -168,22 +166,18 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
 							 i, &sensor_specs);
 			if (ret < 0) {
 				pr_err("%pOFn: Failed to read thermal-sensors cells: %d\n", child, ret);
-				tz = ERR_PTR(ret);
-				goto out;
+				return ERR_PTR(ret);
 			}
 
 			if ((sensor == sensor_specs.np) && id == (sensor_specs.args_count ?
 								  sensor_specs.args[0] : 0)) {
 				pr_debug("sensor %pOFn id=%d belongs to %pOFn\n", sensor, id, child);
-				tz = no_free_ptr(child);
-				goto out;
+				return no_free_ptr(child);
 			}
 		}
 	}
-	tz = ERR_PTR(-ENODEV);
-out:
-	of_node_put(np);
-	return tz;
+
+	return ERR_PTR(-ENODEV);
 }
 
 static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdelay)

-- 
2.43.0


