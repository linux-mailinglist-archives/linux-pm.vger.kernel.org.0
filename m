Return-Path: <linux-pm+bounces-20846-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C50A1A332
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8DF516A4F5
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82D920F078;
	Thu, 23 Jan 2025 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RNQwjFmn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C5320E6E5
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632316; cv=none; b=IMv0hsCIr8Cp0ZXqcjDez4KA81YRdpC0YAHhgsrdpInXoRoOLNZHzQ9QBKvgVD3AzGnJ9IO8pQpYBvEoI7HmUU7S9jLUKL30N8JHiWWxkSvuQLf4LQnFkr54CYQD/0nu1FoKQH5a+yUK4/FOtxPqd/wbC8jV8ccaHgSZw6t7JNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632316; c=relaxed/simple;
	bh=eqge6iGc84vWezU2Z/6+14UXJ7R2ONxOtI2jhRzLc18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qN0/cMuJnL7J0RNnEXmgxB5fAuBaiiWwH0muAYeFTYSYVQuB6WK8C8iFQpzu7KTOD4gUEUcDHpy7ZBHmRZV/8/fPDgSZInCcnsQp3ctdMvg3uxfo/LVcT467vjJ76tu9902Y0ETa4zGEnaVl1U+XKo5/LA3bCDQqob854KUgtRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RNQwjFmn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2165cb60719so12416555ad.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632314; x=1738237114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYbiAMRoMV0hiAkufuN0q0TYEj4Lvw0IVcfL3LWIkWk=;
        b=RNQwjFmnrXm5TK26oWPCp3JBQYPBIMuwwE5btaF515vHageFFrd4Jji6WgloD71ESA
         G2SCcDsxNP7nZ77SvdOmyxGn6m8TsASbJ4JVtZh4hsBOayfG7DjzGacK9+QzTAs7EyNv
         bU92q/eE1DBtUwNJfOXlz4uHVsHR027qgcVHOY9W9dfepl2wru0FkxnY/pvrTRZGQzlQ
         D/i8qlPeGdfe2Wlfh1WNwmqp+vuUVLpIXb5f4ExOmOz2FI3DYFkyQisRltKBhLQ95j6y
         CSHZ5syfoAt5Ytrfd91IgqGTfjTf9IiiIcO34gLJi6rMprDWdTJHQkrx/e03eGYSxHpR
         n7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632314; x=1738237114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYbiAMRoMV0hiAkufuN0q0TYEj4Lvw0IVcfL3LWIkWk=;
        b=k9W/2GvKbf8FJ8bzQJxelmD2SOBGsRkutaWZjP8PklBVgqjqqXTEIpdcTs9tTQtoQj
         4VQaQ/qBg/r4DdMuz9eIBvu67bz1HnlIZEbOlUWwscEpuF4V63X8egqejmmRM7wiJ/4D
         QQ47OzXkTuYzsylwYH+R09cPrphQlbSqiMK+ShhewWzXtW3Mr74Zx/wxa2im/SgmuYM5
         4m4LaxwlTs29YV0G6LPIMWnlW8SHubzqtQR3fBdYtj22bNGgurVZk3xrUcMn584JHoDU
         Lgz5pp2l/qO53WdSXxxcepsvjrIGhIzQsuQ0xG3EnKGFibDaNJDIjNMiX8vN2em9CZrA
         R3bw==
X-Gm-Message-State: AOJu0YyTwNYXHN28ht1Dc6KKVw5FNVDvzQ8W95GeaSX0c0hgoPcNbhRb
	5zJMnl8NffMEkKqfJac3gwluvIjXM1stnMzdc0sPLFvKJTFE8bEOwSa1InCYEQk62BKsfid1pWr
	L
X-Gm-Gg: ASbGncu75oKbFlTPfkC+x+qhmAYH6VkCUurDTDsrbULGe5ECfNYOM6CpOLbG0o6yOQF
	eTzgLl9FikNuO4/vEWIxd2R2tVDcGSNdoi/5AjK4jYtJ+xPGq9LjwP0VuemO2T23VpN2AVSzdpi
	MCG9z7qOBid5wpQTHMtJIi0L0SjWp2/8A2NOQQTKttX5hPgsZR6qENWo9jR1MLhdAtRUVS859Aq
	wmpZifi/AXvvqE7mgdzZIkewbq/ZC69duDUuId8PArAz1VJWjAN7rfvhPsILVRS/jasHJfTVnca
	NzKfDo8=
X-Google-Smtp-Source: AGHT+IEWmtbirwXj+IQSwqe5xIcegzpevjEjqaadAFbmkiVSRl3S49VNOuJSbdJ9u4+HbITo37I9Vg==
X-Received: by 2002:a17:902:d2c9:b0:21a:8ce5:10e7 with SMTP id d9443c01a7336-21c35530380mr379810615ad.23.1737632314631;
        Thu, 23 Jan 2025 03:38:34 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ce9e938sm112035515ad.44.2025.01.23.03.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:38:34 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/33] cpufreq: imx6q: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:05:46 +0530
Message-Id: <5d3f8c59063edeffb48671025685f0189b052654.1737631669.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1737631669.git.viresh.kumar@linaro.org>
References: <cover.1737631669.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpufreq core handles this for basic attributes now, the driver can skip
setting them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index f3c99f378ad6..db1c88e9d3f9 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -207,7 +207,6 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
 	.init = imx6q_cpufreq_init,
 	.register_em = cpufreq_register_em_with_opp,
 	.name = "imx6q-cpufreq",
-	.attr = cpufreq_generic_attr,
 	.suspend = cpufreq_generic_suspend,
 };
 
-- 
2.31.1.272.g89b43f80a514


