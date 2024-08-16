Return-Path: <linux-pm+bounces-12306-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CDA95431B
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 09:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F6C5B299E9
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 07:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DA1143722;
	Fri, 16 Aug 2024 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KxFnNi+N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236D413E039
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723794053; cv=none; b=NXNYkmhygrF7R9twrqiQsJ1sWsPnzuwkPb90e89/w5yK6y7tQvON+tlX+H7iFfBeSL1sfwipfmnIf8Lu6DFh2Xnh08PuVXqnwVt6QJZHwxWtCf0kxVG7OCJn1FbMZdIJJkWkw2xB0BM9pool+r9gNeixchYIdxvIL87gp5RpO54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723794053; c=relaxed/simple;
	bh=qxgv5qfoaV6bk0OmgUgWLVEm3V76aGC+t6S+7+lxV4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oDwciaFPeZWz4lMcQCd7aHj5B7PWlBRjweOA5yBnByWFvlOsOR0W6FimmyoOdSiV1uKykWjwwGoKuCkzR9lgL67dOe82W1uEe67brOq1djtP/KIzLzP0jOezXUYQKMoC9eFCXSnzeK10MnwQs9EHN4CplxSDb1SBQFMgFnf+RGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KxFnNi+N; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so12040915e9.2
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 00:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723794048; x=1724398848; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWnAc9E8rxrrK2bbeb3Pwo9Qok9E02qmGv7eCa97j/0=;
        b=KxFnNi+NAbHm6u03vaF/2g5ES1iezk0rmu1Mq7xQpUxALPG4Ev09SyKYtuu3H2ZE+u
         e+6lGTEw8xq+ST3PNAJ3HXXus8zhX6ohL0nA7ysPwOXFtnRJhE84002tYn5nb6K2hqta
         wOXFgZarzYdokpNP06QXdQRnOdm0IvJ1Jf2auwAX5OH8+GTh55sJqQpqBSxFtVyvpJGX
         lcPEssCCjeJxuwP8HfOOSuu1h6b2xTpXN8YZ3Vp6mzNxn8lrWkbnnNGg+y7Ck6KY72hn
         XLXtth8OncFqWstCtulEA2BYXApHqTB1MmjHosHtnFdRbn3YVK3QWvK8JLwgniSmCe+/
         YejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723794048; x=1724398848;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWnAc9E8rxrrK2bbeb3Pwo9Qok9E02qmGv7eCa97j/0=;
        b=iLPp+tkvljlTC376+lrZRXEnwu/jlX6r6r5A+B4u/NVz9db3B5ozHtR2b9hI+AXQtb
         W12fhsFBokXelCpyX+sDeckwrTObM17UyhRktVaLbWWOaCpeJSQPqusgCEvWP/yQqKD/
         Xd4Pf+jZvi32+/r34wRXCUadlzxTR7QzZl+M6sWP+fHszcKoXIROT836qjdzk/sYid6+
         YUf2fcmJFTIBQqFag9ITjBQCe9tiwUmgXY1HiNwbFRxHOw2ZU3lTbB7GgpuNJLqbbv8E
         r3rRsxbLU5xFFwIUdWhvk1zLMS/a1SQWXL/DAlNM8Z3fKdDm6fbqgq+na5BI3HEHDQIb
         MhNA==
X-Gm-Message-State: AOJu0YwM5M+JuWFJeEhjDluxgrGubTY79glrH+9ucrwq6Vda6MbcWFz9
	35jLksZi+w6cAGWzrFGgzFkY+EgbdZ79t0uhCMbzO5HxdH1KKbzUp3iDDjyz+Eo=
X-Google-Smtp-Source: AGHT+IFzZLTDR5Z98Up78oxxOH+SbWTXfGpurjJuT98BrROkaRsrI5irwTZI7n2q0qacDhrKuwnF0g==
X-Received: by 2002:a05:600c:46cb:b0:426:50e1:ea6e with SMTP id 5b1f17b1804b1-429ed7b79dbmr14872275e9.18.1723794048073;
        Fri, 16 Aug 2024 00:40:48 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded3596esm68549625e9.22.2024.08.16.00.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 00:40:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 16 Aug 2024 09:40:32 +0200
Subject: [PATCH v2 2/7] thermal: of: Use scoped device node handling to
 simplify thermal_of_trips_init()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-b4-cleanup-h-of-node-put-thermal-v2-2-cee9fc490478@linaro.org>
References: <20240816-b4-cleanup-h-of-node-put-thermal-v2-0-cee9fc490478@linaro.org>
In-Reply-To: <20240816-b4-cleanup-h-of-node-put-thermal-v2-0-cee9fc490478@linaro.org>
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
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1865;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=qxgv5qfoaV6bk0OmgUgWLVEm3V76aGC+t6S+7+lxV4o=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvwJ1LBtoOQCdO9Cr1eEJODRs6I3T1W1H/w+SX
 U+gR/nFdGyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr8CdQAKCRDBN2bmhouD
 1xccD/0WObW22ZnbaV0PXY8czCHkU1Yim1p2MtptSNdwFysLYe8ouBEf5h0y2cVtx/WQve6U6Tm
 NRMDHm6TIiZ27dHtIGoEeMHJ5aE3VT+XaMnWZWNfYtPR6dYouYGFE01zHfrZA86jC76t4niQIS1
 a0i8S/EO22tIYbNommV4h4Z8R1AXRsmERkng26Mqa6u36FwpC3mYKeJAIPet/tdYrIpgWxtiN6s
 JVETWM+MDJEpe/NCavkDNYUt/a9gB5Sfc3mYa34U5dKU4p0UUQLePzG2GIcao0vvhxsPfroWoa3
 ntTls/kc8KJ4IORiALnrEZKIgr7tCXB7Csszwj7/B5N39OEqkTsXDefW9QuQy5bqR8m26qoJ1kI
 N5FZwQXzVfrvqK48rV2j0xfABUt3fsvhNhIf2RSoaKLIU3NBN9l4IibaQCwvZc+5QO5v5TzX0SM
 15jyp/5pBeYp9XoMnKqXwPGye4w589dsJNpviP2ll0/hJ3zLyF05DZJLIQaCqdMSCjMIY/E4kRO
 IzPLGF7Qu+B1bzcKtOYEwZOmxj3CHSilb0tKztEo1XZON/Hw/h0hQk5Gyk1zZYlWLayUsebzO/E
 cG0Nv0ab5vTM99EmNXc+EOXesnUDcBQ/H4Z/D6f8zaJRjH7X2EbJDDWCK5/ZnoIBkRI6sQhToru
 LfpnO6jio4rXUKA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Obtain the device node reference with scoped/cleanup.h to reduce error
handling and make the code a bit simpler.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Drop left-over of_node_put in regular exit path (Chen-Yu)
---
 drivers/thermal/thermal_of.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index a2278d4ad886..2a50910f35d3 100644
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
 
@@ -148,15 +144,11 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
 			goto out_kfree;
 	}
 
-	of_node_put(trips);
-
 	return tt;
 
 out_kfree:
 	kfree(tt);
 	*ntrips = 0;
-out_of_node_put:
-	of_node_put(trips);
 
 	return ERR_PTR(ret);
 }

-- 
2.43.0


