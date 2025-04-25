Return-Path: <linux-pm+bounces-26213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76190A9C7D2
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 13:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3212460B7C
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 11:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA1C244675;
	Fri, 25 Apr 2025 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PK8iqMFg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146D2243364
	for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2025 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745581191; cv=none; b=TD6fVDBJc4sLzhoHFqhkNyN1gaQOahU3zas9EfcgSL8Cuz8tZj+O+hHsCFOtUeiSiKY5hXp09BKleRLC+oZmBH9BFAA5Ps5+q3ttMmxbAqDKZwqxCckWz2HM85xieGJa6/KqWqplD5isprNDWzSVnfEEbtcMSVBJGLixW/ngTXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745581191; c=relaxed/simple;
	bh=Ekvbxj8ie3aP3p+Ppy4BmvqkqgZEJ4eDgTuXpv3T8ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OH7a6JyShrUAHQge06+tNXyyQX8S7Wtc7jQr8danldoVjsDuPFebGDja+CIksdLTX6NrC6btWiKnzz6UntNcQG2v/bsFdQVWwJwi2LNV2AYTUNwYWUUFTh9MEMZWf1dddakUpxIL9L9mdIlXr9/XfYXtA7hAFUNDDhnxc+AhlAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PK8iqMFg; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54e7967cf67so2355028e87.0
        for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2025 04:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745581186; x=1746185986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O2m2Aoo1Yj9SjRuX3tvCRBORIOzSUjs0HNbHFmUyy+E=;
        b=PK8iqMFgquHnI7+mOFm05KvBYjXQwKgdZIRcfalKKXcP+Cuk7rliO8U5TjWSkPrA8n
         xp70rcR7aEUFebzM18B9CwtIw1faU+cQ+kyaqQV4CyZt/R4nk5jtIa0jy5mGi8caUJQR
         Ahg4p1O/zWcTMwzgFcsbFplqK0hzjCx5Ib0RBpvNx10CFsvXLTVZXBWaEYiC0UyEGtR7
         0+/v3VMNxD397qdwXhlMbgGXmV+jSKLvfV45DA7cPnEFy24615c4SWhFkHck3GfbzDXo
         taMvREqpT0BFrWcReeHMQiIBaU6SKWN4opBGHd8sLoi6zyGDWjhvScm87fXZ9/uw+q4T
         YH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745581186; x=1746185986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2m2Aoo1Yj9SjRuX3tvCRBORIOzSUjs0HNbHFmUyy+E=;
        b=eaD74s7FoUPIrNPjEG637Ii5LpcI72O0A8O1OLMFKd7U3AafWTHV0U2kFFpBbfcNcj
         HA6+Eaer1L3sJiZqJ4to7H6bHwLzMgl1D2Yy6qQ44P+5UxDL/Sng9rrp/uCjjVZC3feB
         elRQRV2O0bAiEFAU/lr33Y5FwlJbwIIpTZSvIgHfJHuR2ys2ufo+uIKe+BZY0eg3O0Y7
         iJ9nAtfG5302vEz/sh5zqxV2rXTMminV6k1AlEKyMSZuLMFFNUFM74/qYSqE4BEQFp3i
         S5XV7WjmfD+UYlvimY+6q8WNw6OPZC51KcUqjsrvlepKMWXUAm7nXINmYrd4u7y9gMy2
         i84g==
X-Forwarded-Encrypted: i=1; AJvYcCUmuZHGe0LPWQMDYXDNvsRBm5cwKhln4sjin7+Xs8lmZElqv59MAv6AfUqxxFIQyAWvGZTz7MsSyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYrFoesXmLcwlZTKNWVvaSC6rZ5MpiaKg41UkYTK3bGFrlpAT1
	6DsiDmeUQn6Vu0eXD1hXSz/qETi6Z4wQaz75xvNQZ2c8SDEhhyUn0t2XZYpiZgazTWz4acTbGy4
	y
X-Gm-Gg: ASbGncuxNBeE8PnQ0qgcJiUH1xj4jGQ0zd04h4Aic1KR42oBaUZDMqebNagSqdetcvv
	+18wWuKHjD8wbRWEJbLOjuuvSY0REmxIwWakvYdHtxe5YutbRXBnFo8+A/M4qnOdPMyLpyBOZek
	koFOZ2WASZtp/Qif02tJdvCfgCTVGEz4LnLsKDmOSEhFabAScKI4zUHvhO6sei2wg63aFz4vX8G
	8okdWxR64w1M1Xj3SrbzlMUoiXBuNd9zswUVx5xxuKBdwva1YJJXMgORiJz9FszYKwIMqFpnLGI
	aNQp3YtGN4L4aP74YVfzASxI1OuR7NH8ZhPhU4xw8NcFtcPVMwsf4sH4rZ4lgCUDbi2LugxJTQc
	6jT4tlcUGfRVOdGs=
X-Google-Smtp-Source: AGHT+IEy1Ze2Inm4YbRPTrLQmT+mPyOVbA8yhIPraVyHblYKgU+yLXCJwHaMdnfN0LS3s7iYdWCcBw==
X-Received: by 2002:a05:6512:3b95:b0:545:e2e:843a with SMTP id 2adb3069b0e04-54e8cc0b338mr599451e87.38.1745581186050;
        Fri, 25 Apr 2025 04:39:46 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7cca83c6sm560581e87.113.2025.04.25.04.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 04:39:45 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Peng Fan <peng.fan@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pmdomain: core: Convert to device_awake_path()
Date: Fri, 25 Apr 2025 13:39:42 +0200
Message-ID: <20250425113942.134458-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As device_wakeup_path() is intended to be removed, let's switch to use the
device_awake_path() instead. No functional change.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 3523d0331cec..a16105b34201 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1508,7 +1508,7 @@ static int genpd_finish_suspend(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd))
+	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd))
 		return 0;
 
 	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
@@ -1563,7 +1563,7 @@ static int genpd_finish_resume(struct device *dev,
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd))
+	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd))
 		return resume_noirq(dev);
 
 	genpd_lock(genpd);
-- 
2.43.0


