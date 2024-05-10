Return-Path: <linux-pm+bounces-7710-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 586B88C212D
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 11:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43801F22619
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 09:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0A71635B1;
	Fri, 10 May 2024 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4Tp99ij"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FB015B108;
	Fri, 10 May 2024 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715334057; cv=none; b=nBS9iyhh8MwOqgytjlAJ3IIem2WnxDXoJQ3NUsl5Tg3lzj3B7MA3ZCWZAWvuFYi7m7uYj/e9wWRMZB8FlvRJvfkr1ABncgWmFvtUgk8nRmryKfi0ApCsFPBt1MH4KB58ufJZvyrXFW/pSMkg9GvJrWq1WppiPBqt18Pn6SbH5OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715334057; c=relaxed/simple;
	bh=omwIVooKj2lhfiK2OyYV/ShnqtuKeUSCLFPStJaY/u4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xcnx9z2QYMZhn0l9C48q9+R6LRo4S+kh0vfOd8OC2mDfK2uyOGEHzekancE6rwTqrfGugq4WaVBXv030jjH4Sr1Ief4WlBfQD3AHXTGQIUmPpSzA975IvYbax40UZlYOTh6osLJb6iEkUyJXXsOu8NBkL55q2sVGTld06GUf8S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4Tp99ij; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f47787a0c3so1658360b3a.0;
        Fri, 10 May 2024 02:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715334055; x=1715938855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RkRaYasEXgqE/p0OdCATEgprTM8CbZFE90OPXfYhKMQ=;
        b=D4Tp99ijdwPXk8U6YAzzWsie0Apx0Rlv1bPJ2wOHb20bpAoP8A7A1oqSpZvyJO8BVH
         ApYswZu2pQ124+K48RFoS7MErIUdnCjqGzmI1NE3Z5pNNTmEanAMPjJVdQmCzweEzHFK
         LjWaRjBiitsFNzKhuQFrNsGMxC8ykGAAi7OoVCk8UKUJG2To2Y8mYCUPqg06h2txJzVM
         36mDGHhMZ5tRkxevHrZgYv1WV3j/NsT+B8T1GHjnbeuaO0DqcXHcDsaboJJfnHsYgUg9
         W+HZcjQJ6x8XWRWmZcsnMv6VjF5+k+0s4kVF0iH8l8w4mYuGor08zjA8QCqph9n/GR98
         ihFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715334055; x=1715938855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RkRaYasEXgqE/p0OdCATEgprTM8CbZFE90OPXfYhKMQ=;
        b=FwXmdWY4bziP6HnbPFBlreJIzQmuYwrnXpcWAnFnQkLg9crJ8/ZJe9goZJYpHdGm7B
         TaIqSfow8h3EFJOB/v2e0QlcJp15cP3o8K0oxu9bOjHjitAEiC7a2JI/Y0Jk5Ne/H1VU
         9G8nSf5qvaz2vBLfvokhOF0EkzIQUSS0fRqXQWKhPKMsHic5/UVohVd57RqZIfNevM5l
         eGR22FlvIeeWXQhOELJ7nopWJeBrGwAf2PB8LQyj3B+OoqMuLZiRzHW0FTjlPwNQJPv7
         7LKRDbwYA5pspUsKVdWi6z5caPoEt+cZ+GQtmhjzWRoVpjE+u4ZqvE6z3EMsNkeNPUQX
         PL0w==
X-Forwarded-Encrypted: i=1; AJvYcCUjDwoDhiKH4OL+cVs2W1b740C/CDeFmxZLcF8uqXL2IKSAEEPzqXwtXRN21Vp7zyCRSsjjvhsbn7vJakQ40HWWnonn4nKrO5msM9SAQvYvSk21626Q+asAkNZjDUY0Ivn+4hVd/z7Uqhyo1cQxoiskQGULouYHmE/38UpexsaldUVCcb2sB1xgHQ==
X-Gm-Message-State: AOJu0Yw1zBAWMRzaODMjYB4J1oQ3xwVMRNS6zIF1v9/fyeNvoCZzXsB6
	+j5SLU62F8eHMbnfCxlIQe0G3wIybgHP/x+E4/s4GY5/VFAW1yTa
X-Google-Smtp-Source: AGHT+IH0qhnOyz8bzZsEARgaFLjiq9X1vf+A71YpS9o0PB1YNYRGjZdOMaaTV2N8Jxrn2cF+sK4F8w==
X-Received: by 2002:a05:6a00:3ccd:b0:6f3:ebc4:4406 with SMTP id d2e1a72fcca58-6f4e026b878mr2506655b3a.7.1715334054910;
        Fri, 10 May 2024 02:40:54 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ade28asm2554518b3a.139.2024.05.10.02.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 02:40:54 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] PM / devfreq: exynos: Use Use devm_clk_get_enabled() helpers
Date: Fri, 10 May 2024 15:10:24 +0530
Message-ID: <20240510094034.12493-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

While at it, use dev_err_probe consistently, and use its return value
to return the error code.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v5 - No change
V4 - wrap up the error messagee within 80 char
v3 - No change
v2 - No change
---
 drivers/devfreq/exynos-bus.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 00118580905a..7d06c476d8e9 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -160,7 +160,6 @@ static void exynos_bus_exit(struct device *dev)
 	platform_device_unregister(bus->icc_pdev);
 
 	dev_pm_opp_of_remove_table(dev);
-	clk_disable_unprepare(bus->clk);
 	dev_pm_opp_put_regulators(bus->opp_token);
 }
 
@@ -171,7 +170,6 @@ static void exynos_bus_passive_exit(struct device *dev)
 	platform_device_unregister(bus->icc_pdev);
 
 	dev_pm_opp_of_remove_table(dev);
-	clk_disable_unprepare(bus->clk);
 }
 
 static int exynos_bus_parent_parse_of(struct device_node *np,
@@ -247,23 +245,16 @@ static int exynos_bus_parse_of(struct device_node *np,
 	int ret;
 
 	/* Get the clock to provide each bus with source clock */
-	bus->clk = devm_clk_get(dev, "bus");
-	if (IS_ERR(bus->clk)) {
-		dev_err(dev, "failed to get bus clock\n");
-		return PTR_ERR(bus->clk);
-	}
-
-	ret = clk_prepare_enable(bus->clk);
-	if (ret < 0) {
-		dev_err(dev, "failed to get enable clock\n");
-		return ret;
-	}
+	bus->clk = devm_clk_get_enabled(dev, "bus");
+	if (IS_ERR(bus->clk))
+		return dev_err_probe(dev, PTR_ERR(bus->clk),
+				"failed to get bus clock\n");
 
 	/* Get the freq and voltage from OPP table to scale the bus freq */
 	ret = dev_pm_opp_of_add_table(dev);
 	if (ret < 0) {
 		dev_err(dev, "failed to get OPP table\n");
-		goto err_clk;
+		return ret;
 	}
 
 	rate = clk_get_rate(bus->clk);
@@ -281,8 +272,6 @@ static int exynos_bus_parse_of(struct device_node *np,
 
 err_opp:
 	dev_pm_opp_of_remove_table(dev);
-err_clk:
-	clk_disable_unprepare(bus->clk);
 
 	return ret;
 }
@@ -453,7 +442,6 @@ static int exynos_bus_probe(struct platform_device *pdev)
 
 err:
 	dev_pm_opp_of_remove_table(dev);
-	clk_disable_unprepare(bus->clk);
 err_reg:
 	dev_pm_opp_put_regulators(bus->opp_token);
 
-- 
2.44.0


