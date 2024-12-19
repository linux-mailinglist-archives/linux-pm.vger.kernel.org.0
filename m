Return-Path: <linux-pm+bounces-19534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC229F840A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 20:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A84BE7A3340
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 19:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21621AA1E7;
	Thu, 19 Dec 2024 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="d/3E2lyb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FDD1A704C
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 19:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734636117; cv=none; b=a7EyN5D5nbci8Fthv10poYYIR6/CBo+OI+RF/6IwmUDUYvP9zmnXURVSqaxgfp9m+Gj9z7goZv/n+jy7M+p5fDcaTPDF/w9WaVgXan1EjDJ/n8ApX0Zurr7yXyEqpeGh6on0MQo9YHJ310J388vMxEaVUe4mgrcC5n7u2SNoPpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734636117; c=relaxed/simple;
	bh=cFOZEW7bW7hijkJbEkuiT+veherkKLz3/wXF8DZQgnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YLYSxuhIzlXcxkn5Z/v9TkGct/2krvu9MYMRJSIJ23svRu3v0aLajHIfxhYnLVamWBq5FqHPq5ath75nZ2IL2VexuFRHC3WLcR0QtLmzGU2Fe6kh2TJ8OUIXVvj+60y/P47WFUGfas/hn7qHU8EfzYX8FvDqthcMmpulvOHIXwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=d/3E2lyb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361815b96cso8451795e9.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 11:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1734636113; x=1735240913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UnWI2zj2aMIKQzCXIjdxrWPl8CZX1JzCR1K4TNUFlMQ=;
        b=d/3E2lybLc7EBIoSitWTmilQFuHe5C4xtd6eYsJHa7QdwPBZ6VrBKJb8Ks2iHmF6GS
         AukXPd8MXUBiUT8GSW/O3r/+PrBGEaOPrvjwhGZy2Qbe+9xJKRDYeXYo8ok/MJRqVNDX
         I24hsU52a6+aV3g2HsOJEf5AmV8HbpFZMXZmf/r+YnH1WKinZQzGYjnWfyXsi5Z9xxT0
         iEFbRYO8+kiQQVSOQDBbpG+GA5Tfxj+b0YFoIaGby0xVcsiCgOawDRIciK4Dj55kY7aB
         2Ve8/ORbocS1lJ0iSGSXCsR56yaXI0Ym6HdYZR8xdyXkZtsJMziiI7OYvtzEOtRpe3Jp
         n9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734636113; x=1735240913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnWI2zj2aMIKQzCXIjdxrWPl8CZX1JzCR1K4TNUFlMQ=;
        b=g8okQBrE3r6adxkZNXMsVUZ7datiiatclu5RJLVf/R3t12nsGDwYfAKOU1UuuWjUjZ
         Y2OdVC3YPUXMP1tkuYp/0eODWtUPBH7PGv56f2N/KKQvSeOlENWhKNCndD5Dbi1pnRYD
         CoocTgOCzZsvbYSgO/vcS3P43GtbyZ6LPvptN90cepS8T98VJ3bDwmfCGaqwlsTfLQq2
         CprXTcqofZfuRezkPWCz5ZqdB+D9AzOlqYhY1N9GIfrxkxf4qvAZ/bqkaRBpJsVCK0EU
         JkF75n2EKPTPZnU8kaKGono/Lvu1fyhzqTeOqOwpCUOOQOJioVBD3w8pSjUvLNZ7StC8
         2KhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeVa8mjVqjxYkFbkaj9jkcMejLW3ny1I01WPRVfzCoya5T+8f0e3m4/h0J0ogl4IE7GOcrHhFhtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyskJE8ZU8JigKprE1NWDEm75UTh/dJXjuJVubKzyrnrwmj3S/h
	3YiFAlo6u1pdzUmJRg3PKIfYtP+uKMXqL7n2ZDAoYrKrBJ89Og1Jv918meL0DzE=
X-Gm-Gg: ASbGncuFn/GedqppUL8T0yAfXC6TBhLD/ndUowanDCzgwXeztFPZIwqwWVydO6sceqf
	j8oSzHAy4yhygUx7rS53yrV5yF/zM5OsAfHLEPh5AMX5/zrItKrcY8rWD/wXaZPshCNtc3dMqHQ
	xzg9PCi+Q0dXGalr+jOIPmEoiTxxJbvPGM+KayPwIV9JxrvL6SrXQlfQRwXEc46lpgPH7p9vMtW
	uLjSDpMjmN+X7tWxRslB7BR+wZEA1PDDKC8DnbhoQttA+lYICmFQCED21k7GlN6Mrt1qQkA00OS
	Th8VSQO7YlADT1uWrgBnL85kHVQnLchahB9r245AQeeu31XE96Gw
X-Google-Smtp-Source: AGHT+IH6vI4r48pSPALL4h5MSC1XqGE47m7al/T6HesGimHeD/QbRmrOA+YwT6DOvCJYxBZ2ru/NYw==
X-Received: by 2002:a5d:5e09:0:b0:385:f1df:24ea with SMTP id ffacd0b85a97d-38a223ffa3amr317939f8f.40.1734636112779;
        Thu, 19 Dec 2024 11:21:52 -0800 (PST)
Received: from stroh80.lab.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8acabbsm2190052f8f.93.2024.12.19.11.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 11:21:52 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Naresh Solanki <naresh.solanki@9elements.com>
Subject: [PATCH v2] cpufreq/amd-pstate: Refactor max frequency calculation
Date: Fri, 20 Dec 2024 00:51:43 +0530
Message-ID: <20241219192144.2744863-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous approach introduced roundoff errors during division when
calculating the boost ratio. This, in turn, affected the maximum
frequency calculation, often resulting in reporting lower frequency
values.

For example, on the Glinda SoC based board with the following
parameters:

max_perf = 208
nominal_perf = 100
nominal_freq = 2600 MHz

The Linux kernel previously calculated the frequency as:
freq = ((max_perf * 1024 / nominal_perf) * nominal_freq) / 1024
freq = 5405 MHz  // Integer arithmetic.

With the updated formula:
freq = (max_perf * nominal_freq) / nominal_perf
freq = 5408 MHz

This change ensures more accurate frequency calculations by eliminating
unnecessary shifts and divisions, thereby improving precision.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

Changes in V2:
1. Rebase on superm1.git/linux-next branch
---
 drivers/cpufreq/amd-pstate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d7b1de97727a..02a851f93fd6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -908,9 +908,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 {
 	int ret;
 	u32 min_freq, max_freq;
-	u32 nominal_perf, nominal_freq;
+	u32 highest_perf, nominal_perf, nominal_freq;
 	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
-	u32 boost_ratio, lowest_nonlinear_ratio;
+	u32 lowest_nonlinear_ratio;
 	struct cppc_perf_caps cppc_perf;
 
 	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
@@ -927,10 +927,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	else
 		nominal_freq = cppc_perf.nominal_freq;
 
+	highest_perf = READ_ONCE(cpudata->highest_perf);
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
-
-	boost_ratio = div_u64(cpudata->highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
-	max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT);
+	max_freq = div_u64((u64)highest_perf * nominal_freq, nominal_perf);
 
 	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
 	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
-- 
2.42.0


