Return-Path: <linux-pm+bounces-12229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2E195232E
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 22:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08AC6B23FD3
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 20:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1541C6885;
	Wed, 14 Aug 2024 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9W6aCqk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3836B1C3F3B
	for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 20:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723666687; cv=none; b=DNSjrNk6bIsk4WchjBTYcVIUm9+Iq+Ekn80277K0ZGdZyL41vbpIltcUibNZ2ano9Rflrr6bMezAjqGPS3oVsFuwftllKXqtZo4LnVR58d6W/N7QkJwWM5MrGOyRfiQz8J+wTmGU/v2DvSEn0ET2/FCmx8q0OFAtM6BQyF4gvSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723666687; c=relaxed/simple;
	bh=ACTPT/WKeh8vPrxZG+9k9m7syH9ZC+yY+13QhJEgNj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WA020jLp4Y9vnwx393LX/BciYi4XykhhgYLWQaeC9W6DM8V+0tP1dbfT6I1MaaJvLH2I9qOBq/Ij9pe+Ardat9mSXouwIiGvKJThud51TkA3UkkuY8wXv7qn0FlegIRuYSm8dKrh8xQKYw1/A3J/DjNXnTAs3PDdIcKdDLmwvCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E9W6aCqk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42816ca797fso1052365e9.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 13:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723666685; x=1724271485; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++p+JxzQS5UPTkfx3ma3H7Ls6vAeOBS5jFyHbB6JISU=;
        b=E9W6aCqkGZEm0RfP6TgcCoU4LhrUvca1IrM/R7EsKzXNflgMUHpXyOHaGzHAmh+5Dy
         jmbMmfsEqjpA/s8IT3y3dLrRRS0dp9SFbFIrmEXA7S1qzaoJcGbhsGw4F8ncxL3LVLaR
         e7+vq817WtsggEwyVAjknYw8rqyBTDBTy3iMr6Yvowkz9HGZ8YtLPa/OhEzxdAsbW2UX
         VqGlwmjnEvqwQQlkP431s/k+h1LxgKTuUJMbRx9YYLxLsYeb7Cn8NeoUKSuhcrmYwm/c
         ItJKeykgF97iJe+kvNib4pliSpG/oKQpGHujSTubkz9a2+8iiFjWkDoIVQoA2K8yU8Zk
         18Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723666685; x=1724271485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++p+JxzQS5UPTkfx3ma3H7Ls6vAeOBS5jFyHbB6JISU=;
        b=v/0k6kegqcGHeXQZb085W7mXrNEi7ocQU8WkeUC5hM879re24VXTuLQfFDs+CbSqHd
         M+fQvl5ua16eY3vgoNziqWa4p9CSwZE0ztZQPmPHhZnh2NWdwj4Yr19NSmCxPdAfpVtC
         o7ooE1+N7fZ1kQFXeK6cAiBpSzYf4CBeuqNPUKQ81n0TFaFgV03UxDwWRElHWh+v1AVD
         Azf2Shah/YE68QArWd2KBfFQG+vlwtOWQnNk2WHRmFFNa8kU3X1dg3o/idD/+LcH0F8k
         BFCdv7e/Z4rfvQI7NoX5rRo2Yi/1rUZg5T/oh2o8fgdJV2pSZ8Bi9CbPORj6gUVxuxsb
         QOlg==
X-Gm-Message-State: AOJu0YwqK7bdNI+dEbHCgJnvN+/G0C2injDq6EiDgSkThmtXfNT31smG
	0wLcHwAGBlT2XUEZ3n37UdPuEiAxO98I70RWDu+9BocGx4KtVhJMHtJ9sNcz33Y=
X-Google-Smtp-Source: AGHT+IGZiGFg5LA2lGJLTze5FU5Hft61dd3QE0hb8QyXPgP+/VawCBj27w0F0jk2ArjxvKBIS0JR2w==
X-Received: by 2002:a05:600c:3c96:b0:426:6eae:6596 with SMTP id 5b1f17b1804b1-429dd264983mr25480435e9.25.1723666684504;
        Wed, 14 Aug 2024 13:18:04 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd3631sm13623519f8f.110.2024.08.14.13.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 13:18:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 14 Aug 2024 22:17:48 +0200
Subject: [PATCH 2/7] thermal: of: Use scoped device node handling to
 simplify thermal_of_trips_init()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-b4-cleanup-h-of-node-put-thermal-v1-2-7a1381e1627e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1654;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ACTPT/WKeh8vPrxZG+9k9m7syH9ZC+yY+13QhJEgNj0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvRDx7NYdG6rXPPkRJrrDAHgRjoLKhzOmBCUbJ
 I8k1L+TZP6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr0Q8QAKCRDBN2bmhouD
 1wujEACJpmuU29GVP2zsxezI8prUfzlD7Dd1+Iqtv8zthOx8t2E5ZqFctpVVI+MKRT/R6mVKS//
 U4kJXFpNtgs4UEuc1kNVnl9nNX4jtvW24aQJmPkYMwlf9YBGuHWWYh/0LwjAla3bR7TQj3GpKGi
 cUKzjtiGHn/X/DsbY1vZNWYvLIxlf6liEtilmsZOJczvEQmxlyUrBaFhj4h7Etjgw6GvEiuBo6R
 +AUL0t1Ub4L+Da8vdWUd/DnOysxjTeDfAuY2gMpgRmfe4JFNF/BVhFc1ULBx9a373LNUvjlzI4v
 tzor1aruDD8jpccHc5jEEwsBifiYCavIf+/YwF4WYDV/JjoArEL0xavpKzdWaVsdEWBelvaFp2G
 Sz+7ZiUpDZQxiKiu5XYOPrUt/zBUb/Om88yNxspDCUFLpUB9tWapk2Bg5Dp1DjO7rtJxKrCwbKf
 FCU0iZo7E00Ibt8esX8i6IPfo96rrh2Uw43X3geCtY9zqA8hOWn/tZBiy0xxuNMOMR7MK7XYfK3
 1TEQ7WkvZi+ytUQEEREOvCBUIcf8GOou/ALd+O5SFD4yFWBnqpR+mEYDvfOMLFFnrG9FvU2EfI2
 ifFhHDDDczOFhS6oE3i1pHl7U3w1jzlco+CefAoXghMjvTE4xP3Pc9tGOmRp2XBFWnJVdizYn8r
 IJs7VOjqz7i23OA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Obtain the device node reference with scoped/cleanup.h to reduce error
handling and make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/thermal_of.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index a2278d4ad886..c8ded4462bb8 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -117,10 +117,9 @@ static int thermal_of_populate_trip(struct device_node *np,
 static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *ntrips)
 {
 	struct thermal_trip *tt;
-	struct device_node *trips;
 	int ret, count;
 
-	trips = of_get_child_by_name(np, "trips");
+	struct device_node *trips __free(device_node) = of_get_child_by_name(np, "trips");
 	if (!trips) {
 		pr_err("Failed to find 'trips' node\n");
 		return ERR_PTR(-EINVAL);
@@ -129,15 +128,12 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
 	count = of_get_child_count(trips);
 	if (!count) {
 		pr_err("No trip point defined\n");
-		ret = -EINVAL;
-		goto out_of_node_put;
+		return ERR_PTR(-EINVAL);
 	}
 
 	tt = kzalloc(sizeof(*tt) * count, GFP_KERNEL);
-	if (!tt) {
-		ret = -ENOMEM;
-		goto out_of_node_put;
-	}
+	if (!tt)
+		return ERR_PTR(-ENOMEM);
 
 	*ntrips = count;
 
@@ -155,8 +151,6 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
 out_kfree:
 	kfree(tt);
 	*ntrips = 0;
-out_of_node_put:
-	of_node_put(trips);
 
 	return ERR_PTR(ret);
 }

-- 
2.43.0


