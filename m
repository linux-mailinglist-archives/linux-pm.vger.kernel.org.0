Return-Path: <linux-pm+bounces-12308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83085954323
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 09:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02CD61F21F67
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 07:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195BE14F118;
	Fri, 16 Aug 2024 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eb90VByx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C7A14388F
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723794057; cv=none; b=T1ZDCcIgsK7XMndORioZrOXTuSmyPHhEF0JwyY5JsFrubod9Zcumkc+byeD0OTonnWWhCRS6zy2m/tY5Ta+flywuOHpHvFKZ3GoPE4DW31hZqhg+4JqQJknfCs83N9dFkFJJvblmETmQ+fYPJuQ52Y/ogd4ea7E//Y6qEMsWMe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723794057; c=relaxed/simple;
	bh=9M5ntznKTX5NDEFACMt23t7+gXPt/dasJVMFbG8WF/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qHIp0ZWbGHnA9SySoTmHX4PIi4rur0OY0gsTe9hs9xYd5wvevqdOWQTWw9Hrz0qQ988syXUtR3wuq1/DbofsiT0Yn6TlgfDvTG6Ee45FEZjqc1Ii3QEdxrU94yxis/SObnlsAXq2Wsu8aH3qaIVVaEzBl+3ZugQmHcLLoAQOziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Eb90VByx; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ef1c12ae23so14946131fa.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 00:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723794052; x=1724398852; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpiLIHd7RwewW+o/fTDGbmxF9iEJfCFxBRNxKUku6uc=;
        b=Eb90VByxzOuc3RJPVDMIkIywo54AUDWzqyw10c8rsYAgTbkoyCn3oMqcEZQgFThuU8
         cG9NIjFey05N119ActgiTtkoIU+BNOE8PoyNdkS+jMJVrU7QZor9+nEzwbhNgHyiDmPS
         zcYq3jba/8+XAFXBlGxcy36Z/d0T1zJjIbBcioG8hhcCgRTdEt+vgIBy9bIasKqxLejD
         1tH8hrCDOojaHF/L32Wv5fCqhNYUPbslXaC//G9UhlQ85PnRqjl3KKC0EYLLG7VH1xqV
         p/fBH6VbVoduWPNiSMdoIvCeZ+rHZbgJ1JDh1ylmGnrlpBF6gT3HjlwlMd2iZ6NqDh5h
         gmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723794052; x=1724398852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpiLIHd7RwewW+o/fTDGbmxF9iEJfCFxBRNxKUku6uc=;
        b=vwVJ+Wsbo+Ik2MdFKvkj+YXG+fyNIXRvoVacF6+XOJmO9GjPocSZpv5Nnhk7Wl/cLA
         uxgBk+4TGI1TEFbhV05WdXTogvQ3MMvah6T5996lbjbxz4UiASRmjyUetleJoBFWW55v
         pvHg3IpLI9bvjKWCW69999Llas6BHnWwrPs4+hwD384QaYS6X+wHvXVWJNZ0utSQFNUf
         qOyumYHMZ+dpIQGj7Z1stEKF8E74++i6D2E4at5y2Y/ZbcTh2X6q8EUTa+5pXlDItBLJ
         DPDQ96DNGDOinq1J6nGS69rxFzwz2lOYJucDllP/imOc1SxRcNDZJZnD5tCeZtyhTvWG
         lcVg==
X-Gm-Message-State: AOJu0YydtUnlLyKmsDYGBLHEmrU1qOvbK7PTDe4XjEcRKOSIbNjuT+UM
	CujnOnwv16gP1Vhf37IBFbgehKKhakUeBxU5/91G/zDGP4QyRKWgAIEjl7yKyv4=
X-Google-Smtp-Source: AGHT+IELCc+OCzcJ/Js9NwPDwHfifOzvE4gl8BthiWmIBR2Eaem8CWHrHiKiF111j3uXtD+30pxdXA==
X-Received: by 2002:a2e:a99d:0:b0:2ef:2490:46fb with SMTP id 38308e7fff4ca-2f3be5f59femr14797761fa.37.1723794051688;
        Fri, 16 Aug 2024 00:40:51 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded3596esm68549625e9.22.2024.08.16.00.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 00:40:51 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 16 Aug 2024 09:40:34 +0200
Subject: [PATCH v2 4/7] thermal: of: Simplify
 thermal_of_for_each_cooling_maps() with scoped for each OF child loop
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-b4-cleanup-h-of-node-put-thermal-v2-4-cee9fc490478@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=9M5ntznKTX5NDEFACMt23t7+gXPt/dasJVMFbG8WF/M=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvwJ3KbC+CIW/wgMP/qsQhWUwSxbE78dCD5pPL
 pLwIbQ3KvGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr8CdwAKCRDBN2bmhouD
 1wEiD/9ZPNQh9CCdAjJ7tvBzsxq+KQKtvaWC/fQDIECn5V/X2lAA0i7fPqDihwYNGci0qdbP77c
 nGwvi5k79aqQ/K9EHna3OBQR343woYrPjcIQ/3kYcvzY9DdqIXbNaGVHtypT154nMeZysDY1jbd
 ZxM2XiVBivBQvsad9X21O6NKdbP3u6KvuLXNj6aaIJ0gPQYU9/PInP2wU/21gIYSAZTsVLEwxaf
 9Gb0c87Irgoq1zyV/6LIzngJVoJtQavHuWHgA66hTlAlYhZYAqq/TTUsJzNP2tWmEVUVz7qL8rw
 8nGc9pL64W+FFW2EvNgZNbFFT42DsghleR66MnBH/hMxcLpyg4lYtAt6Nzd6kHBYzexQzp2Tq3m
 dXNHetyc4N0Qg24s02eeR8eILN/iHrAKJAhYEPuLrRNODZs3yBDSk+ZxJJ78w2B/I7jRDiwTnaj
 fZxW9te26WMReCULmYh/TV3wBj/O2qgl8ZwEogLuB5xZ3fEqfBnHRfT5mIGSzJ4YG85T+K/hJMR
 ayrpjXDymP7W+xnSv8auBecvBDVuTBMeHWvoxaSIf7jqrathAKibinrv5qi8KU2uG4A2i6rQtZ+
 2QlPWRmMoyiFKZdF+ylcC+RC2TyCdKGZLQFkq7SwSQXMs2KTP358oSRs6MeyTky/OfRLPvq+Xy5
 52INWgb0WAFW/4Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/thermal_of.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 94cc077ab3a1..ce398fde48bb 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -373,7 +373,7 @@ static int thermal_of_for_each_cooling_maps(struct thermal_zone_device *tz,
 					    int (*action)(struct device_node *, int, int,
 							  struct thermal_zone_device *, struct thermal_cooling_device *))
 {
-	struct device_node *tz_np, *cm_np, *child;
+	struct device_node *tz_np, *cm_np;
 	int ret = 0;
 
 	tz_np = thermal_of_zone_get_by_name(tz);
@@ -386,12 +386,10 @@ static int thermal_of_for_each_cooling_maps(struct thermal_zone_device *tz,
 	if (!cm_np)
 		goto out;
 
-	for_each_child_of_node(cm_np, child) {
+	for_each_child_of_node_scoped(cm_np, child) {
 		ret = thermal_of_for_each_cooling_device(tz_np, child, tz, cdev, action);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			break;
-		}
 	}
 
 	of_node_put(cm_np);

-- 
2.43.0


