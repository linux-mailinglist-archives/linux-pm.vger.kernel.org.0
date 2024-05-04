Return-Path: <linux-pm+bounces-7498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE018BBAB4
	for <lists+linux-pm@lfdr.de>; Sat,  4 May 2024 13:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EDC1F21DBE
	for <lists+linux-pm@lfdr.de>; Sat,  4 May 2024 11:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738B7182B9;
	Sat,  4 May 2024 11:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LjOjICvf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3524017C7C
	for <linux-pm@vger.kernel.org>; Sat,  4 May 2024 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714821931; cv=none; b=jcm95efqsKAqZ3LONV2lpYBdrR4jIMbFIcebIepbvimmMzKBxRQ9ez8x6LaGvKZE/9xkygZBT3+O0xjfRrcO9fTQlomHUETENcbANIFk7cMLM+hzSlFLMBwPRqkwTH/K75Pf1AXWoVt91Qty3DIv0u/xRXhjgwYM/P5lp62T8Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714821931; c=relaxed/simple;
	bh=zThw4UDAOnEh6F/I9eYX3+ObEBgRTkhGcMAD0FioUnI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BCXW9Y0Gb47jC3NAbyvIWY/+SgsL6yjI1F39HBcX+57MOfuwtKCwdCRgzFwZh5bunpswauSUMi7yTDReEsza+tpOcz0yZ84nqWRjfof9Vw/kd9iAgScRdMDb9y1gh0wKut1hquv2LksFxN8aAqn+5nuHcd/I9pi+Tcks7mz8PHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LjOjICvf; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de60a51fe21so520098276.0
        for <linux-pm@vger.kernel.org>; Sat, 04 May 2024 04:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714821928; x=1715426728; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jPKRgPrnhQkyQvjVNzNYJS982z7u5glAR7kHzQu9FB8=;
        b=LjOjICvfAs2LtW1qzETVjwP6Y1ALQ+praSuAoyouCEaJayFuzzvlikOgOwUS0x/wcQ
         /E8oc+Pem8yya6aRg+bTt/oJL2lSc+CJq7SiCJmLHoRusCAmt16v3TVKbBPjbRU1cXdi
         roAmS73itEGh2HHmhbYQUiPJVVbOS7sk1SwnANHB32oIxpNP1hMWyVOsWCXcWdL8fBsJ
         sMIqb9qi+XsMG1deVhPsWXbJ2e1u0gQffw4C95XVy7FyqzFqmqRlPo37h4dRDmTWUJ//
         yBpZL5ayrPqB5duXytrJYpAYXbMltwskJ9Bvgxus30BJWRX6cmofi/0KEY4QpvH/lqJl
         hYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714821928; x=1715426728;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPKRgPrnhQkyQvjVNzNYJS982z7u5glAR7kHzQu9FB8=;
        b=mvOrp6naqhKr7m8FjPjNiE8IzWqm8dFPCIz5HiR3H698Koc5cu9dDsspzyqdMiotgz
         LtWyIKGDtOyVQFRyHy6c5Uuy9mWce1qOkMr2ZyJKt2xGcM+6ruMpVSfHyZGrXLwIuk+V
         84UDqYViMnSJbomLaXh0Nn7o64c4h4n5SOc2zbgJr6cbaN0UtH47TVISsXp7iEdyaEVR
         5Ldo9RcNW9qM/Z7gQG6VYuYrzYKUwuKoVYxUdOpzSfgsEo5wj0+NeD3qbdAlQkDa5ikp
         LKyhThJOHhbH41rR4KjstkLVqz+1yfXKNS7umT4NT42wNxMa6UZnUwwy8+j7UGwDVMx4
         m8zg==
X-Forwarded-Encrypted: i=1; AJvYcCXnisNPe+mspggqqTe+4o5FdGbzTs7N9EMQ7F2nHoF3W1beQx8K0qmahWQiNVgKpyI+4V8vOE55INnhCDomHMrCHqctnpJfzjs=
X-Gm-Message-State: AOJu0YzwujM8F4kArihK8a+VgXjc6vtZJbn/V/XHx8bqM0ur6VxDiNNs
	9ZwqxSvUbmVO8Wd+RIF3YTD8I119rBsNH1r32l2YsFiIpLbSIc+qPXN3nTiNTng=
X-Google-Smtp-Source: AGHT+IHmoThEg6ZICI1nanJtD8NqubVsHGjSSagbRYqxHTK+797ThcIKk75RKEhweCH/CV76yxB55Q==
X-Received: by 2002:a25:aba7:0:b0:dbd:8f9:a71 with SMTP id v36-20020a25aba7000000b00dbd08f90a71mr6069893ybi.28.1714821928012;
        Sat, 04 May 2024 04:25:28 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id d72-20020a25684b000000b00de4f5e1e45bsm1055110ybc.54.2024.05.04.04.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 04:25:27 -0700 (PDT)
Date: Sat, 4 May 2024 14:25:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Amit Daniel Kachhap <amit.kachhap@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] thermal/cpufreq: increment i in cpufreq_get_requested_power()
Message-ID: <a7c1fe73-b40e-437c-8ccb-7b3baad04df7@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We accidentally deleted the "i++" as part of a cleanup.  Restore it.

Fixes: 3f7ced7ac9af ("drivers/thermal/cpufreq_cooling : Refactor thermal_power_cpu_get_power tracing")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This is based on static analysis and not tested.

 drivers/thermal/cpufreq_cooling.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 280071be30b1..a074192896de 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -249,6 +249,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 			load = 0;
 
 		total_load += load;
+		i++;
 	}
 
 	cpufreq_cdev->last_load = total_load;
-- 
2.43.0


