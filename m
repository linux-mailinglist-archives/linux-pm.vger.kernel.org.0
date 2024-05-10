Return-Path: <linux-pm+bounces-7711-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FF58C2130
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 11:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E050282062
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2024 09:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5BD1635BC;
	Fri, 10 May 2024 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT0g+QV7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6DB1649DD;
	Fri, 10 May 2024 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715334063; cv=none; b=iFwMqxK/SoVXbXwmsV6sF0aoNUY25tqtQ50S6Mts1Z+CiqlsItJGPm8E8+jxS9dtZ7hpNdM6T2Wu9jW9cuQlibxJFjd9x5xBA2sAEQNLzVF+fwnywWtqXNkwcVF6ff/Q4bEbfZyKioO9Yw0d8CNjLErfgkfeH4CWCCjWxHhyJFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715334063; c=relaxed/simple;
	bh=1AdAs/JP/a3mKsJUfe3CkMCB928cBD8nioKo20W2VsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nt70Ebe7/1h2phUbBXGXA1snPcsOUs+SUkFCeBtnw9cW6xYPjvwxiAi7o0Oc9mbQuani2pRPFvH5FMdkcr83w+JRgwJAa3Y0PBjpKT/jrM3GpJprPD1Bq4hCopCHbPjkmHEv/TRlLxuEOWiqtDJisxNJ6OQszD7qfGgT5rNZG0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AT0g+QV7; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f4dcc3eeb3so680274b3a.0;
        Fri, 10 May 2024 02:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715334061; x=1715938861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYCA026a98+jinm4XXjivyCMpzTaBQNxk+cwgCPrDy4=;
        b=AT0g+QV72pJc1e7BisZ5Qon4GauE4AfiXMUNsJ2bCERTZ7cbE/uUVW8Rzgwmbd2kHm
         Y6ZcQFArkqQiyE3wjtzPfFdbMtzXnK23E1nGtV+uyPhnitjIrfF6F5vkfw0d13oKW46Z
         /Rvl2Uuk52jqqPA7mKwLS98/8sc7Luv9sKHMnI7ZmsLSZwkx3luQ/74FmouQW4mTXg8N
         zMkfPRLBBVq/0ekQeFdaEF2yc4rCkOZenhdKw2dFozdhbKBlFDOaWQsIfaPEnCAj6sIK
         nE6ddHm04Ts3AjoyTx0CFnpqxgpA7/s0wFk3a2cVCJken2ShIaNDsQRXVqyf+C1KFLxE
         /HvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715334061; x=1715938861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYCA026a98+jinm4XXjivyCMpzTaBQNxk+cwgCPrDy4=;
        b=hpHSbXSQ6k8+zmZ9xFdUWhWDw4mtqxbRJiY1Z5t/pDIYEcZkOCUwywXIJYbaybex2b
         Nq/z/lcCLiTzrDxgvD6Cf2GRi7xY/fefBhxYVeAqFmqRM6zIY/HdUS7D0lJuDBzn0hzt
         IthgCGG9RK1aV18kx7wBLgm5pV87ggrp3cYXHpanhxAhMqXsnsycOyNI/QeBci3+m6jY
         +EY6OFcQxsJLcAgXWHqFLjGfHL3vmZ5K/9qKIgkLcAHzlqTZs1oASlKTrxzYouTKdzL3
         1rFf4+PbdUDoEUak2t21YgnnBQiis1WRpAsrBjhhhZ01gGtRIu5MR+kczmkbjE5uadlc
         vZdA==
X-Forwarded-Encrypted: i=1; AJvYcCVdVn7njd9Nqfu7XLtmWZv9LPmSofvesYkmpFggUMWSuwzAOCIKPoYf2pBI0fRCixLwcgd40ypJpeqLCaESLXMHnhnAArvx3iaKDaEq2FZOQXo3Ha3YrQ8yTlwZrH/26tK0F1HQnG9lXlrD1PKmOppsfDHhL5eZ3lDrhSM7WaRGwmprtcSw+duf3g==
X-Gm-Message-State: AOJu0YyUZg1NkgoIZs7C87IuhxVPxIEuKXL7rtVoB+Io05ygejkBkgFO
	O5I/3D2D4uW4j+aPtdipqscs4/ON4fLBEe8Vw3cOq3r8nx3h/Vug
X-Google-Smtp-Source: AGHT+IGv0EhQaZQv5264QLirP3eVLjx8maXcHjKU/FgFJ8ZT4iudZpiwgz4HLBkM4c/WXo008palAg==
X-Received: by 2002:a05:6a00:3cc7:b0:6f3:e6e0:d9fb with SMTP id d2e1a72fcca58-6f4e02c6a0emr2055840b3a.11.1715334061383;
        Fri, 10 May 2024 02:41:01 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ade28asm2554518b3a.139.2024.05.10.02.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 02:41:01 -0700 (PDT)
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
Subject: [PATCH v5 2/2] PM / devfreq: exynos: Use local clk variable instead of exynos_bus member
Date: Fri, 10 May 2024 15:10:25 +0530
Message-ID: <20240510094034.12493-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510094034.12493-1-linux.amoon@gmail.com>
References: <20240510094034.12493-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit modifies the exynos bus driver to use a local clk variable
for clock handling instead of storing it in the exynos_bus struct member.
This helps in simplifying the code and makes it more readable.

Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v5: New patch
---
 drivers/devfreq/exynos-bus.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 7d06c476d8e9..e55ae59a8ae7 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -34,7 +34,6 @@ struct exynos_bus {
 	unsigned long curr_freq;
 
 	int opp_token;
-	struct clk *clk;
 	unsigned int ratio;
 };
 
@@ -241,13 +240,14 @@ static int exynos_bus_parse_of(struct device_node *np,
 {
 	struct device *dev = bus->dev;
 	struct dev_pm_opp *opp;
+	struct clk *clk;
 	unsigned long rate;
 	int ret;
 
 	/* Get the clock to provide each bus with source clock */
-	bus->clk = devm_clk_get_enabled(dev, "bus");
-	if (IS_ERR(bus->clk))
-		return dev_err_probe(dev, PTR_ERR(bus->clk),
+	clk = devm_clk_get_enabled(dev, "bus");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
 				"failed to get bus clock\n");
 
 	/* Get the freq and voltage from OPP table to scale the bus freq */
@@ -257,7 +257,7 @@ static int exynos_bus_parse_of(struct device_node *np,
 		return ret;
 	}
 
-	rate = clk_get_rate(bus->clk);
+	rate = clk_get_rate(clk);
 
 	opp = devfreq_recommended_opp(dev, &rate, 0);
 	if (IS_ERR(opp)) {
-- 
2.44.0


