Return-Path: <linux-pm+bounces-25079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4983FA8397F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 08:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8D71B65167
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 06:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D005620468C;
	Thu, 10 Apr 2025 06:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCUh1tXX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E30B2040A9;
	Thu, 10 Apr 2025 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744267105; cv=none; b=ADP16Sn1CBr8cQN8ybtpMYF/1Locj3aYjUQ6OvhethcXxCYhNbpxGHPuxBpRBwfAeaEtbX6ddTSBw7878dcM3ZwyDQiFT6SPM13Ha9w/nbSrBSO5nDYwz67muTJOWt6cfc8v9/YfnV2zolZunPJRGvfSqVt7aD2ey8hlvOyxYSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744267105; c=relaxed/simple;
	bh=AhjyS9iknHRUdZaPGb+mlSXE0It5xEtfFY1mjlKImkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sozJZYm4aA+uwy/QldWjE29j3AbBT+hRAgaU+4LmPH6Pm3dy4AQxEFQ+18w3MSra2MhqOkCnJquyO5O48MoLgWVb6HwtZCFeqXOkcxtNfRS/u4K3mrUBMXYP7Xu0maguHrk3JonROK67D/ZYf/4TubLuv4wpJ7znHPwARh4jtO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCUh1tXX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22438c356c8so4553815ad.1;
        Wed, 09 Apr 2025 23:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744267103; x=1744871903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KY9C2ohAdzqyv3wRnYpVxd1Yt/cF4tyWRl/ZSVb6rdo=;
        b=eCUh1tXXfbOQigw8Iub8yJEGJH+SkgIy2Wzi9vGSCmsrjcs1GA42bghydLNdJp0xu1
         pLnTLEFa+6tl6kNinYwCABcCPIbJUe5WjpZCevt91DZCglbNVDtjLjkyI+PmLS2wSU2U
         vge63KdP6F07OsexOEiAfKIGiloR+bce1OJHDCBQlPypQTqaThshXxhdFlSW4FDNV24B
         li896OG291zFopJm6+02UNJbu8JSYar8APBYKxcx38ezmyb1mN7SIMUL3nIA1kPzVsRr
         ajrHov598aQVRH9QhNVrcVvMpXNp1+gsEtRq/epRcWjOjnkgh63ZmV/8xt82eHu3ioLD
         9Rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744267103; x=1744871903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KY9C2ohAdzqyv3wRnYpVxd1Yt/cF4tyWRl/ZSVb6rdo=;
        b=mPwS62CbAd8z8mLZDZsqRTq0aRMl1NvplKNt4oIPO50dUD2+vSvyRJXSRqz1BG4I2d
         DtdvNdM8OAuSoU4dyjf7I0UHwaM5NjDz1jG5dCunYGHG2QEyac2LHpm50zRaFKlnkMbY
         momw9NsoZPi11M3T8cucKIDbNiKmxjkKOD5DdZWVElwAC6uD1LEt6CxPZkg5neav6ARd
         N9pph2psYvWTJVpF5OHL158tQefh1h118TA7+5mItR1Jua5qKYpoqrkvixxXi4FMz6NE
         iba8nXMzRwCzRvQpwcRmDXwUdDjiji5+vsy3rEFbW5zEWV5yQfdU3877EgmPvT6TU9XM
         HjfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBpejUG3jVcAuBVhzpyWsvcI7DALVIF24h/Sd9ChW8wHEDNptBVfspR8+K4We6TlboTSLepECueMk=@vger.kernel.org, AJvYcCWnqNnT5Ueh+HSCVjKsEbJ7oVeKqDUMrDuJtEf2KbmN5KhyK6znbus7Rj5lmKLFxfVESBAB04lI4Urjdf0DDHF0NFI=@vger.kernel.org, AJvYcCX9gRCDLsUCPRXnxgGRZk+QXmm+NCTLz1ZDdyQChBUe7bczmMJXBXMNlraS2yZmjRvyvagIqBVddnIDGB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrSnvuUbWPMRc5OUh/9DlGvKTOKnWvpCll8wl2w8u8XRRs8dqO
	qeiCpUX1q88H4d6hYwTvuUmBHMVUSR7x/Kc/x2q61imcpNzap+IV
X-Gm-Gg: ASbGnctXDrFoNmZMbuB6g1eWFJHLc/DE2vI6iEaDpIoa33MS5hc+Qz94qS0PDHDtvnQ
	oVU5XPbSLURrfHkx3+sgm6GM+MRUJurIi3UqKqlkZsJuSD7pEO9ykSNaTBCyKkolk3RLrtqnwgp
	yYrWpDV2V3BBnI7ot9hIHmzPpwekkGA9QW6U1zZ8IKiZ9zoblSzZvwXs0yj2qx9B3ntEvbrwx3n
	pvtS6Nq0h2QldxUu/vYKHoXC+ajzs4Arxm9YGcLdgIQt15NrUGC44RKcaxFW9jDDlVwQOsxFcfY
	yUQOXVZogYcD/NXxzMerIim8WObCvbEHLPr0sUDyeGobMi+nC+NOAHc=
X-Google-Smtp-Source: AGHT+IFesC5pq/Flznu9wGw7JQgIcSg+yrfPMnjQNGGmPdVTWxL+TEbq0QvSI6FgGfoZP8oQu6ZWLw==
X-Received: by 2002:a17:902:f709:b0:224:c47:b6c3 with SMTP id d9443c01a7336-22be02d17d1mr13927735ad.6.1744267103249;
        Wed, 09 Apr 2025 23:38:23 -0700 (PDT)
Received: from localhost.localdomain ([103.221.69.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd57865csm973145a91.2.2025.04.09.23.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 23:38:22 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-pm@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v5 2/3] drivers/thermal/exymos: Remove redundant IS_ERR() checks for clk_sec clock
Date: Thu, 10 Apr 2025 12:07:49 +0530
Message-ID: <20250410063754.5483-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410063754.5483-1-linux.amoon@gmail.com>
References: <20250410063754.5483-1-linux.amoon@gmail.com>
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
v5: None
v4: drop IE_ERR() for clk_unprepare() as its handle in earlier code.
v3: improve the commit message.
---
 drivers/thermal/samsung/exynos_tmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 3657920de000..ac3b9d2c900c 100644
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
 
-- 
2.49.0


