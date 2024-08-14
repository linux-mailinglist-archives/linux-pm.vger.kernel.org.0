Return-Path: <linux-pm+bounces-12228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B72395232C
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 22:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76402847AC
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 20:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755051C5787;
	Wed, 14 Aug 2024 20:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ve2o9I55"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE971C2321
	for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723666686; cv=none; b=A3drHiQY35idORgYcuXATslXkM6MmdzXkpFlolth//J360vJwlarH6QzjdoP/53I+77l9tdISkfrgHyC5Qza8GLI5xlSdwSiO8AEAzUIbUV/lj4k43MTMllTgQoB+Y/VP7hBPyLUYAS1gXD+BG4NtGUBdtiSmOqWNolTSCmb7TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723666686; c=relaxed/simple;
	bh=Jfl9CCDjoTMAykhligO10CdduRTjKmS0DGo6xlPScyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r7QCg7FaEYPnBhOdcQpQasUvPhFjvxK/+7dHF5qlGGyAHQO5YVKz2kUJf+WX/X3Gi6ZPQbDXbHirNbGwm+3mJDprKWkd6EeiUoziub6AHhOu7F+VAgiJMSYOK887kyz759vLUdhnzKpjqVWahEfw4z0td3ZkQugvCWoBHzeb6Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ve2o9I55; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4280bca3960so1098525e9.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 13:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723666682; x=1724271482; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObSCoIKHR53RsBAjPImzvWTBDUOXW/cdZ+itJeFwmLI=;
        b=ve2o9I55gH0kUVjpF8TLMxc/sUWRd9OvMkI52fKkKT1XjjIbFUYCiAtABVV6S9KT29
         Grzbb9G772GMMZ0N2DdokcTT2X7wnJXwwp0xPjwI8Dkr57RG8Nu9gYTU6gYQ4EqGTrkm
         /B7LWj/TrRmpTmhENmAmaxSYT0j+ESNPoaph0RHBm+KgWZpP8Rxg1ttUA+TTyCQGqrYq
         qGUhVa9ZQXsqbMET5rUHmxpHoER01XE2lopVOtkYfbCqgMMq8Oh/wH3+iVQsrorj3bTf
         BVnDW0Wh1muRRdLAlnb4Z9UhdZpMZjYtdkYc1sPUGqqu/+HbaaH8V69IEqpUoElt5Enr
         1msA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723666682; x=1724271482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObSCoIKHR53RsBAjPImzvWTBDUOXW/cdZ+itJeFwmLI=;
        b=qBP52Mrn6enW9V5FWAhY3XXx5uG3Qf7sSb/p1ewHB8QcifB36fSwcsIP4etxtLrSfu
         rJUkGnAJJ3gspvI7e8nzvAy6q1dOr8Pan+yw2penP3mVoUMH4QhHjx4Z63XEI4d85/fw
         /taK7hMdIxfZhm3BN7tWW/8lNh57J3XJLgE5lTL9wdP1KPTQ2FqY+G4yXc29H/lU0tWH
         BqTYA6I/dg7uS/yGN4LllRQi+h6fo9EhcU0T/xp5bJC+RQmyX85qKlnSfFVhULnLSXFI
         IewhzCm+vyVe7nrgheDn/CsdwiPu2QsGrPIlbGLLFCBJyrImOVeAZIKrEwEE599dK4qZ
         ReiA==
X-Gm-Message-State: AOJu0YyIYVXxerJvVtuJiz4yskb9aVBkWG7pUR3Pq0Nu4iVYj9qnOZ2s
	1Ni2EWrxlXQ+J83jI9rAGayQgzWiND96k+nTNgpNutHXQJ3ttpiflMw8NMgPPXg=
X-Google-Smtp-Source: AGHT+IEjqXpjYet6ypGc802+q411OKw8d01xxmNltI0G2Yu9eqYwp/090Xmw263ZglHYyBOUSAWiig==
X-Received: by 2002:a05:600c:4e8f:b0:426:55c4:ff34 with SMTP id 5b1f17b1804b1-429dd23b7ebmr25874885e9.15.1723666682300;
        Wed, 14 Aug 2024 13:18:02 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd3631sm13623519f8f.110.2024.08.14.13.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 13:18:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 14 Aug 2024 22:17:47 +0200
Subject: [PATCH 1/7] thermal: of: Use scoped device node handling to
 simplify of_find_trip_id()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-b4-cleanup-h-of-node-put-thermal-v1-1-7a1381e1627e@linaro.org>
References: <20240814-b4-cleanup-h-of-node-put-thermal-v1-0-7a1381e1627e@linaro.org>
In-Reply-To: <20240814-b4-cleanup-h-of-node-put-thermal-v1-0-7a1381e1627e@linaro.org>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1610;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Jfl9CCDjoTMAykhligO10CdduRTjKmS0DGo6xlPScyg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvRDww327vaCGWSmCQ5rATkIm5TMFxxObspRAg
 BwE3OcKQ1+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr0Q8AAKCRDBN2bmhouD
 10wNEACYQM02wcgcm6jW32tliH/1WiMeu85GF915kaNTEIw+b5lwNX8CD1OIwKt11RUVLIrxq2r
 fjTc4r7xwznphVHVZG0DtaMp4+nIxLeo7/odUs8f7rapwhtz+8PHbyAq5mEk6VTLjkq/5MQIChG
 9CVFWkmuMj+cZL9nTtPPVITIUmuQDnslBlS27/vm5Jb2azkaZcg5dmgMj3QxGM9JyOfSuLhtqaX
 uF1wJBOafwHjG46OU/QvVVNGc7uZlBVpjRSI9L/ZZePiTcx7GhtK/GUm4w4WQpybcaJjQlmyghZ
 w91qS+XkrupTPhyZxQ2p0QBv0WBHH3eoeyP/LJO6AN0sRb87Lfifq7GyyVO1FA0+jOh+iYuRMiH
 sFid4KKB9Ahclv+XJHdCuXsUAULeU2SK3jtEiAx9fCrzqwNp7qyhGV0QqLAFQancLX1ZEdj31lt
 yxYCp4ee6/kKpcB3RHmdWZQUZ6X01FVavPeZIrIdyQrMQO+bv0a6zO3VAvD7pt6PqDPcSCgDejf
 vufLcOV3IRMZnObwPiw3RhlwrwMk+3FWdOKv1FmQtiAu7lD2PqMKUQPn/IozQAgXC+spvP3+90u
 3+BjIpQ4YWpDdxbwdvZL+rXHD7KStxzwqih1EwGP5W7NYh27CP/zXW2AkupPw42+FWnuinaa5tq
 pIWUfWMRnZDMyEQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Obtain the device node reference with scoped/cleanup.h and use scoped
for_each_child_of_node_scoped() to reduce error handling in
of_find_trip_id() and make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/thermal_of.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 1f252692815a..a2278d4ad886 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/of.h>
@@ -22,11 +23,9 @@
 
 static int of_find_trip_id(struct device_node *np, struct device_node *trip)
 {
-	struct device_node *trips;
-	struct device_node *t;
 	int i = 0;
 
-	trips = of_get_child_by_name(np, "trips");
+	struct device_node *trips __free(device_node) = of_get_child_by_name(np, "trips");
 	if (!trips) {
 		pr_err("Failed to find 'trips' node\n");
 		return -EINVAL;
@@ -35,20 +34,13 @@ static int of_find_trip_id(struct device_node *np, struct device_node *trip)
 	/*
 	 * Find the trip id point associated with the cooling device map
 	 */
-	for_each_child_of_node(trips, t) {
-
-		if (t == trip) {
-			of_node_put(t);
-			goto out;
-		}
+	for_each_child_of_node_scoped(trips, t) {
+		if (t == trip)
+			return i;
 		i++;
 	}
 
-	i = -ENXIO;
-out:
-	of_node_put(trips);
-
-	return i;
+	return -ENXIO;
 }
 
 /*

-- 
2.43.0


