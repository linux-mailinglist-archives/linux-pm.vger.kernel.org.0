Return-Path: <linux-pm+bounces-12176-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65B0950CDC
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 21:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475F71F24B2F
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 19:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731F81A4F0A;
	Tue, 13 Aug 2024 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="RoYTUhmi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E8A1A3BD3
	for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576081; cv=none; b=H8kXR5eTzjR14YGSn0jxeJHXTyL+7PPvfufZ1PP9yjg9/MmRfpTgnc1vpDlJuysj5LebRNTtNpd2M/VtFG0IBGJ/9FfBTnRhy4M5Gb11YYDDQBMGHv4lwmXHBtBs1HhfsBWCMMIuMTYdDtOabrsB8AQQn97f5QvAJUbhmXyq4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576081; c=relaxed/simple;
	bh=tCTZNvks5Dji/DPwbWp4D+2JRZzPE8RQGWlJqbCRBro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q4lIOKNb1qQ9pKIja9L8iAvT2uQYBzZ0tZOEzn2JUFgphH6wSjaUYs0URCddyqNLAMxJB92mEFtU+9Q69xeRPX1WaKoDx48H/B+HfBd+WQwXOL6D68BQUjN+wHWf4nzJjn7tDexB5c6JeU2j3w0Zm2HSnMnOfjdlmfekBfY3D/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=RoYTUhmi; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso41200955e9.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723576077; x=1724180877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fucHxJDb4WTy1/fQWLrG2cUypxevB2ecHl2m670aBzg=;
        b=RoYTUhmiqUcHo8W1aqKF2+V6jXj59xGfzBUipTmZ4nQz2sZdQ0Rb2v3QEmRA3SXQRh
         3z1pR+gfl+GawQMpnWJ0RtveY4Pq4Ad/yPu4flYpIE7a0Zaspck2rcTFe2G5ulN5dCxH
         5M+O1bubwoTwGDpFkR7bxUiWazN19mp7dvRhsKESTz8H0J8ohVgsknesxMYolND0G6Zx
         Nwm2HZ3P677jrOPd2weR7gLY3QBMDQJheFzFLGHo8MF5sCHaM8DojPOedGZR5KGvcLGW
         LV/cY0mM2WnibzqF3xbcNg1m/2HvdqTA5d+KmVqUM081VsoCaRPNQMJBWOKzrirCrwhF
         XlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723576077; x=1724180877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fucHxJDb4WTy1/fQWLrG2cUypxevB2ecHl2m670aBzg=;
        b=t7M7FHemBP3RQ/DIf+ouSV27SZ+o+f06meaa3DQHuC2A1TUQAmThMs2croDZ289eCb
         ukHzZmrRPeNUfBysFloJeXRo/M4JwZwiWONhFY55YaXuWdjA60VzbpANUL1wV6BhsRi0
         WG800dA/OorEgmM7wndRpKj4t3aEg22Qi8g+pw9QVppcWHyv4EAWkCT1nZYLw2juIDR9
         cFcPSUG4kxNLXDA3+ZA57UmA7a9KN4Ep6R8WupuCF/iziqNNt050Ctq1sKQnLjeqJSd2
         77srvIhb3qS9V6bNRa6t0Dw1m9oiwzNtzYm32qYUopeDjL2aUOCxj4O8HdI8ZalnYpOh
         8z2g==
X-Gm-Message-State: AOJu0Yz3FBmetGpXRjS7UhqgnsvBvvjGlRZQICLPfuUHAmlYJ7zTHNoJ
	rXodhqEEcbPEQiMcqekR/S2WHFrgLyds4H0vsaXZouqX8epzibPWzr+0xCZ9mp0tqvlXCmlfI4K
	wVLs=
X-Google-Smtp-Source: AGHT+IFTP18Ooy0kSjMn6g0+8tTiFH/zU/vjmiHh0vzWvZVyA8mCxrmn/32VyAcijblo13De+va+vg==
X-Received: by 2002:a05:600c:34c4:b0:426:6389:94c4 with SMTP id 5b1f17b1804b1-429dd268d25mr2897265e9.37.1723576077196;
        Tue, 13 Aug 2024 12:07:57 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3979:ff54:1b42:968a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c74ffb1esm149147985e9.5.2024.08.13.12.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:07:56 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH] power: sequencing: request the WLAN enable GPIO as-is
Date: Tue, 13 Aug 2024 21:07:50 +0200
Message-ID: <20240813190751.155035-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

If the WCN module is powered up before linux boots and the ath11k driver
probes at the same time as the power sequencing driver, we may end up
driving the wlan-enable GPIO low in the latter, breaking the start-up of
the WLAN module. Request the wlan-enable GPIO as-is so that if the WLAN
module is already starting/started, we leave it alone.

Fixes: 2f1630f437df ("power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets")
Reported-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index 42dacfda745e..d786cbf1b2cd 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -283,7 +283,7 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 				     "Failed to get the Bluetooth enable GPIO\n");
 
 	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
-						 GPIOD_OUT_LOW);
+						 GPIOD_ASIS);
 	if (IS_ERR(ctx->wlan_gpio))
 		return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
 				     "Failed to get the WLAN enable GPIO\n");
-- 
2.43.0


