Return-Path: <linux-pm+bounces-12816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7975B95CBC2
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 13:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363BB283526
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 11:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F94187847;
	Fri, 23 Aug 2024 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dulkqBj7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B78017E01E
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414108; cv=none; b=kid2sOYpkozgoVMMBWreyzRpL9sYMAoH9a7hklU1rAFYzz+CWgdfnDoGmINLXhH6oyB8XUJDqqUZrhxSatOA1oSNWBiEgVgrpF9sN9PNdcx90+b8Y0pl6s8rAPvjZVWt5r/oIQC73Tzo52lL6//s4lRPj2jDAFpKmncaSLsNfNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414108; c=relaxed/simple;
	bh=mE30tFPerVjz1hMQD19dglrF4v8Mc86tY8LTYlGryUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NoScFdzbDy/uHXvBTm+a7gE4TZQdnaDhACWSpF2E01kk/wp2V+oo/KJSBhk+7+EiLyb1QZmwz1DJvVefUK73meugfgcvTEnFzcakN0tATqnhso12QFvl5VT+cg3STMc8EcDTK+uOmv1DDFnm4uTOO+eUs659sxi5X7Vv9zWTJSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dulkqBj7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428243f928cso14838675e9.3
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 04:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724414104; x=1725018904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YjB6qUCGKHWMxKbWr+1XyaIhur+Dx/TBgKbSsSEgQwo=;
        b=dulkqBj7b54ntJkancNh0uAse5tQaVUnVs/4KEzw11vZjuPulbcX8QQuVhMGadeEv7
         cZRTESBu4R31IYoyMJEJKwcUIEAC/IolejPieW7hwmbgJir8kAkDxhjlF+aVVgut6t7a
         ujtb/cMID4j/PqFENrxiSm4LD8aMqsxhbYj/csMk0yu/ZYIa49mN8t4JEalVrGvrB36h
         M3K3rINju1Y1WwfCPyHzWTSDxxn1spdvfa7WoTu9JttUZaL5XNeW1QqHaJ5eHmj5K7Xo
         VfPG3zrRgj3uZRZRgX/I+l5gkrZ9Ewh/qkD3jbzCY7c5rEfInPfE5koXI2WE3T8g2bwH
         SImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724414104; x=1725018904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YjB6qUCGKHWMxKbWr+1XyaIhur+Dx/TBgKbSsSEgQwo=;
        b=r9Ff2AXABaOoMbAlLEWg/pusAD71+ObJf/HkSchEa7j2gsU/Fgj7/UjGUEpIvfe/QA
         CYHv7aBRBYmAHpGvJzdATl0F9gBI0N0rLMi6MZvj1FghCUvgzYS9Vrw0zikc0Vqh3DB1
         WhSfWmX9tnK9PoE1yH7X7hS4Ju7CMTzjAfbwpLdJoS4oxJsjLq2GuSA1j8OP9bH36Yh/
         N8Xt45xt47OwSC2OXSGnV2VIsUiDwFoUnEDtSXix4cP7mCAAlUnKKXux9z6KuL8yWVXB
         3eyBLqSXQ71YsHYFnrpL2axyqzFKXpBclVHLbxsjt5GwakJhlJJZiF9cV5LD49x0ozdw
         XilA==
X-Gm-Message-State: AOJu0Yx+d2muTAgX2FTI8CViOAkT3b7d+8mbgOTsYdlUIWacOOdLQ+h6
	Xjg+yHFaqWhNeVdJ2M/IOiBsVSvp98LgYbKhNHPGDPkRPyWRpCRt+VZfeYBAUsJzOesNQ3qSHX3
	iYtg=
X-Google-Smtp-Source: AGHT+IFPtmh/Kb0AOFMbjOIF6PgocrhpRJr53++YPtKB/vcg+SaeiqCVHtwg7xr7/7n7cgCix1DrFA==
X-Received: by 2002:adf:efc7:0:b0:367:8e53:7fd7 with SMTP id ffacd0b85a97d-373118b9961mr1489598f8f.28.1724414103149;
        Fri, 23 Aug 2024 04:55:03 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:58fc:2464:50b0:90c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abef81a5esm93423695e9.28.2024.08.23.04.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 04:55:02 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] power: sequencing: qcom-wcn: set the wlan-enable GPIO to output
Date: Fri, 23 Aug 2024 13:55:00 +0200
Message-ID: <20240823115500.37280-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Commit a9aaf1ff88a8 ("power: sequencing: request the WLAN enable GPIO
as-is") broke WLAN on boards on which the wlan-enable GPIO enabling the
wifi module isn't in output mode by default. We need to set direction to
output while retaining the value that was already set to keep the ath
module on if it's already started.

Fixes: a9aaf1ff88a8 ("power: sequencing: request the WLAN enable GPIO as-is")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index d786cbf1b2cd..700879474abf 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -288,6 +288,13 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
 				     "Failed to get the WLAN enable GPIO\n");
 
+	/*
+	 * Set direction to output but keep the current value in order to not
+	 * disable the WLAN module accidentally if it's already powered on.
+	 */
+	gpiod_direction_output(ctx->wlan_gpio,
+			       gpiod_get_value_cansleep(ctx->wlan_gpio));
+
 	ctx->clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(ctx->clk))
 		return dev_err_probe(dev, PTR_ERR(ctx->clk),
-- 
2.43.0


