Return-Path: <linux-pm+bounces-20852-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F124BA1A342
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3642216C3DE
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B81E2144C4;
	Thu, 23 Jan 2025 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehnAED0E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34F520F967
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632337; cv=none; b=eePDV+7SO1vtX14t/ZJDFY7+KHPPHH2kzroW2g0OIiCBD8iHPncUOQwURwAjZBkbDHQop5VYpYkle2qJwhNcYZ67L9ADTZDaurPgcgILwl6mSWMCiZvqO1k4OVwvQYhwBmLFV/8b3XHhvAICynsO7dlUuS+U0FUE2TB9KYAIdus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632337; c=relaxed/simple;
	bh=l/ZtrPDOVSNg8XHI3m1UYzDQeoPlFdWwpysIgnohRTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fdONqLLFej53g3+kcHio8/cfVWcLCyL50P0y3P91OAp/Ipwhlcd/3xiQPM9UzfOuxoqvcFU2lW+GrruFpduBmeQMKkoE6ocqk18jrtf1pbsaf/OMriYWV/nuBMMypuPof4r6OoxMlb9tg1Wle2jBNMXqrao/kbaFBY0cLeTd7Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ehnAED0E; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2164b1f05caso11956725ad.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632335; x=1738237135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZKL8mCFGzDJ57UILfjkQQSDe5NBzM/NuS+z4/cUha0=;
        b=ehnAED0El3KFJGOK0tF5a/0q+GQJOvbimrqrNLzIcvdUne3PFKY+bQx95PHPHRQZFg
         yTzUfLFvwVxbmNKgtsr7J7XkR0NklKwXzn28IdL0yMDbYwMVSKjfxK+mgtFaYe2sshHL
         nryt2+p/Rlv38euT8ACNN096FVpPmOR8c8N4t2sNFLQnucmSQVJ03NZpUm09FX4Jx+zt
         W6snftGGOEQmWK+VTq+YIv+W/8ykwvPflRGRfNv2WdM4r9fIctqn+gWWEUSednFGWPv5
         OZKdZcSUiIFPHEOvd8pggou9z+GdvdBG1TFsXshu74DM0qwrolHmAiJM5s+KJcZ22+CE
         uWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632335; x=1738237135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZKL8mCFGzDJ57UILfjkQQSDe5NBzM/NuS+z4/cUha0=;
        b=OychiA5Uty9Jf6CNFPXQ8RjUF4uEBluhG7j335F4zKew1eRsqr5Slre5HTsOUr4Bld
         JfRtqseXyG7jCngITXQyih0Gqyd4BjkGk1klEFCHjNBjVeSc94fLaBaNlJZZX1d4MsYb
         K/6wIYPkidRitt4SilwiGpdnpoOgCmNEnEX5qGQkkwkUHjlQTr5K9+viDPwL5ObRaDn6
         kYl2f9pkcxWJnH2gjJx/ByTxG+GAYyJ2hwKDUa+d2wx2j/ePZD7iz+WJPkrMObSkt4lj
         8LH4Mt7yci4R5Vvl4BnDe+vzSe0uj7B5tW+KyRIMQCFTqVeqsx+76r6S/ExsRrtyHoWl
         Rtzg==
X-Gm-Message-State: AOJu0YzQDJgvfC6nQZPNaH0nWQPqFR0nu0V9Ta97L+1J+VYiSsACcC5z
	qyJ4Lx5azo5le8GkvY712elwNCGkmzBDVF3BbtPmaeL03ThDszihakfzoDmIY6M=
X-Gm-Gg: ASbGnctuw148VE9/sfR8Fc/mLoyeilRVZ6SBcWu4pX66n5G7DaMhlNB/aU927CXcp0v
	6ZKFk/K7PsC391DGgqLDgOIpn3bjoxI/9iOpAYjI5QccouKCXjBe+VDp5P9RYPa6N2ya9cZStXN
	qbgkIXCcPbDWbbD8iNU8EDJVSNVIWACc2wdaxSUVp63kgwZVdl2vstdOHaJpOFCHXPTPDq9hn/y
	HKKtRSAImzLOGfDTF+oH0hbm2tI311sjYnEn/1ty6so33deVXzfhW4CU5FQbJMtvhnUXk8w3P9K
	I0eV8Ls=
X-Google-Smtp-Source: AGHT+IGkhkDfdgugGjlffy8yk5cvn/fKZwo0Z6Pi2dOa8WyxHLZVLsDgHmGNQbOmumHerqhkpWOpXA==
X-Received: by 2002:a17:902:db12:b0:215:603e:214a with SMTP id d9443c01a7336-21c352c8151mr450071325ad.1.1737632335096;
        Thu, 23 Jan 2025 03:38:55 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d4027bdsm111345385ad.219.2025.01.23.03.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:38:54 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/33] cpufreq: p4: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:05:52 +0530
Message-Id: <3ba09d4cdeca803770791333335b7917d3480b60.1737631669.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/p4-clockmod.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/p4-clockmod.c b/drivers/cpufreq/p4-clockmod.c
index ef0a3216a386..69c19233fcd4 100644
--- a/drivers/cpufreq/p4-clockmod.c
+++ b/drivers/cpufreq/p4-clockmod.c
@@ -227,7 +227,6 @@ static struct cpufreq_driver p4clockmod_driver = {
 	.init		= cpufreq_p4_cpu_init,
 	.get		= cpufreq_p4_get,
 	.name		= "p4-clockmod",
-	.attr		= cpufreq_generic_attr,
 };
 
 static const struct x86_cpu_id cpufreq_p4_id[] = {
-- 
2.31.1.272.g89b43f80a514


