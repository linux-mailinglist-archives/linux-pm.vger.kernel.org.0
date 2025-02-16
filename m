Return-Path: <linux-pm+bounces-22173-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E17A37754
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 20:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EBB516EA72
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 19:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E5E1A3035;
	Sun, 16 Feb 2025 19:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+Bj92uC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E095619A288;
	Sun, 16 Feb 2025 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739735965; cv=none; b=Ds7kyJCUtd4mF4mTaF4fqykQKXYOytFfCj9SbnyauBRTbhpG9XEMY9qaegyTQAH8KjAwyHoVjL8DQkzde4ZYgy1Xur9CrfKMpQrORqEgY/CL4eioyPdDxiarQ02ir4j9v7zgifxFykIzH13Og4RK/N1VJCaYhvDVNv0marvdYeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739735965; c=relaxed/simple;
	bh=RJ55YcNZT5UFYMjXuIJJsv5D4yu6W+siHI8/lmurhoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlzQZ7DyxpMBfJWJDMZbIzD3+NScvWP1prZ06J2Nx0tZSZMpbWjPZcjLQ/+ThoYbvBdXcFP77zZ8H6XxH7489sN4oRaY/vbCibQRrImj+ROJfRr8GgkG81PJR0We9pi+x5IjlwoXJ55z1nux4yXUI6QuZDQDBo6kkpE+439jTVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+Bj92uC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-219f8263ae0so64030285ad.0;
        Sun, 16 Feb 2025 11:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739735963; x=1740340763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNDUgkHOvW2TQ9tKHoRawdYQbA3LIUTfvAXYbhOHBfQ=;
        b=P+Bj92uCfecI4LGriY6t2N/emwypIfZnCWa+qgwMUqpfKoQglOt8+vTzFT97CJ2uo/
         gePFJVpb6IY3mFfKCQu4civfmlr6OXkE723ej1gpSl/UPScNjRGKqM3ZtVkrcJg+tx25
         CXYzeEEAZSs5ibecsBavMJXG/yG6jPIMJnj1Ez56/YiVGQH4f07OnD+HJVY/AIlbnhON
         WzKdfSuHR2g8I3eC/JoeRUR4nKzYvqCPrY5r4oKTdx2c88cxT6VpN92iqjSma32e9gWI
         +9rjt3tD7Bwv+iM1XQS+oQy+afiO9cZN2firm9HyXlfs3p6f8xSBXslVfaZH4ehEXxIP
         +i8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739735963; x=1740340763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNDUgkHOvW2TQ9tKHoRawdYQbA3LIUTfvAXYbhOHBfQ=;
        b=p68yv8KRrSGvQ44Us1WfpFaS8XUTgeB7OXmIuDGI2WlCVeO8o1lj1Pl+udM2BO/Nja
         9YxB0nKnB69OIwMjzbciXENyqaUEamm3HXwNN2K+OfhHR9jQRir+j9OJI1K2lg5B+Y1U
         NxH/4gA07TA70XndQKqBxmdOtz5S8KNXVer/vvZkiEkt+XrOroVdoDGW3zYLsyMzKQw4
         6XVE2CPq6q2eijpc0/tv9642nztfz2LSk5JeN3BprWgsDQINJqBgpGpkpCk7cTwDaYO9
         I3DcjlZy67DZeVUOwjaEPqEM95W5TEMSzMf+Arz1WCiALLNdUHfT0gyMAIbGp2xYVF73
         UrGw==
X-Forwarded-Encrypted: i=1; AJvYcCUl5uGAn0J8xQXmYscSmEZg24WVxtok/m8ibOx6RBSSCYi/a2AjZQAHE+4T0fJOJqGdI+1CzPHIP/yk4QM=@vger.kernel.org, AJvYcCWwEKXOs913FrHty8p95bCoh4PtAsGeOLFkRnYkc7jL6jbCDNJE6o9juKAjyT87/1I6Dk1oZZYPz+0=@vger.kernel.org, AJvYcCXVdU4p8K8JJS48xm1hoCod6Vsny6byOgke875Ku3TNUnh6Ksb6LPOolDdWdFrzf+Pp09JiZQ0fx67PesQsqZdtRpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF07CiL8v339ur4DpXYgjzsn8+5pa0Z45Ji0d2n6pcvUVwFjL/
	KrYtfxqMK94FbbktPchqZtKVvY1vSbYFtAHGOFe6VOY6VFeUu0HX
X-Gm-Gg: ASbGncsLgIM3Y3+BCS/yBFm40b9EYrMUMDMX13m06P4pyvRnqfJfeF9m0pg4qKlZ+Q/
	ozy18ApKoAfgsdy8N4KzJzDqUfjtUFCStcbTxMYjVSBOn95tNtzuSTWCXEvifnk+e3FT9usbiqn
	vYaEFUUm5usRUadJ8U+LgC8Xt/fSPJsGoL/RLiYp+Pe5Xvw/PWQjT+gXN0r4AtmmjcXV/351opp
	3QE5yGo1VtlggVRBqtMX9Um0ge46SVn26F51kXsvIrXMlC/UZ6cwUTmq03Hwkq4Hy1wKY/5gaoy
	47Ls2Lp6VqqC6MKcXkOeyxyhcu6MWg==
X-Google-Smtp-Source: AGHT+IEUSK/sL4gi2aLg69L2RvsgLCz1QQ9HQlsi/sHzB48lrdXXIwILZrddPrIHBAHT6tkw84447w==
X-Received: by 2002:a05:6a00:2d95:b0:730:7600:aeab with SMTP id d2e1a72fcca58-732617dfc60mr9838175b3a.13.1739735963046;
        Sun, 16 Feb 2025 11:59:23 -0800 (PST)
Received: from localhost.localdomain ([110.44.101.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73265098570sm3023559b3a.22.2025.02.16.11.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 11:59:21 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-pm@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v3 2/4] drivers/thermal/exymos: Remove redundant IS_ERR() checks for clk_sec clock
Date: Mon, 17 Feb 2025 01:28:35 +0530
Message-ID: <20250216195850.5352-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216195850.5352-1-linux.amoon@gmail.com>
References: <20250216195850.5352-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary IS_ERR() checks for the clk_sec clock,
the clk_enable() and clk_disable() functions can handle NULL clock
pointers, so the additional checks are redundant and have been removed
to simplify the code.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: improve the commit message
---
 drivers/thermal/samsung/exynos_tmu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 9c138772d380..8d26000c73aa 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -258,8 +258,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
-	if (!IS_ERR(data->clk_sec))
-		clk_enable(data->clk_sec);
+	clk_enable(data->clk_sec);
 
 	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
 	if (!status) {
@@ -269,8 +268,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		data->tmu_clear_irqs(data);
 	}
 
-	if (!IS_ERR(data->clk_sec))
-		clk_disable(data->clk_sec);
+	clk_disable(data->clk_sec);
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 
@@ -1115,8 +1113,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 err_clk:
 	clk_unprepare(data->clk);
 err_clk_sec:
-	if (!IS_ERR(data->clk_sec))
-		clk_unprepare(data->clk_sec);
+	clk_unprepare(data->clk_sec);
 	return ret;
 }
 
@@ -1128,8 +1125,7 @@ static void exynos_tmu_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(data->sclk);
 	clk_unprepare(data->clk);
-	if (!IS_ERR(data->clk_sec))
-		clk_unprepare(data->clk_sec);
+	clk_unprepare(data->clk_sec);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.48.1


