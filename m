Return-Path: <linux-pm+bounces-20844-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744F0A1A32E
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3693E3AABD1
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2557F21129D;
	Thu, 23 Jan 2025 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PyALAkdI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4739211499
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632310; cv=none; b=b9/yzu7uZC8Ibbk3B2aem9E0u3uMdF5MZiEcb5PLIq2lcY8aLs4yP3cwpmaTFqkD2xE8+eqqKPNeQf2sI6wvzZd9kdkVNlle3nDBavmSnSRD6OrQr5CLvUqYnL+vnA4/BCyzv+i10sRTS4+m066a2Hu86EaU5dG9Os1BZFnLF0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632310; c=relaxed/simple;
	bh=FxwoZUT4CWAkTdJpb5wTqOHaH/qxwabhS0+9DskqS/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AZWTiv64f9kKU6xRXypdicB+C2c4VFVfVpZjbhEpxXw9GbOJdxSHUrtdHwxaWiru46mHVW+LDvbaPUzFut80IfkloKOUg2YnRbPeQyyWiWscWjbcADbbSkUI0LubpIQvam0wJ2//qWfKgNbK60gM+ofVg9owy2NjDI/+0hh0zas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PyALAkdI; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so3156591a91.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632308; x=1738237108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNUCJs8tTMBbcsMlIIIc/iUWSozwVtiMbxOIXPAmzXM=;
        b=PyALAkdIW5MPHc5kzEKD5F5RMswzCnZg9D2VSTiljFrEKFVBpSGZo4k7Q9DJf2hTH8
         svLEdiFx569QX8imz2GyIFB6xYbhK0z/LdpTjpWUsN7Jfd15mpdEfQU9lnFydASo9Q6H
         3ttwGdadomtjCxJQzNWP3x2iSH1aOLLCEsTZDXLOPIYs1yzefF/jsZvyLjdjk/lzBtUX
         SSaUDVfEhtnFLWW4zm+SKoFdc8A+8aDF8187yUXBxya24eWnIg7SqDCtOZybFowHGl5V
         bkOx1gUeziH7MJgzgriZzYgdYDyNAu418X6QCvExHRBq6KqYVftVEE6p18t1I0GYaFKp
         gPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632308; x=1738237108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNUCJs8tTMBbcsMlIIIc/iUWSozwVtiMbxOIXPAmzXM=;
        b=JXOvYrnu6ov4WgLYwifnpuzeKTvBXpn4K+iC0++HCvrfZPSnIt5JA+Yc0V9V9iCMtw
         NEuXzay3Lhsa1DB/QXRuuq8Gz7FsPPH1EqL3sjbWpjSGdRkflLvKc2TURpOe1tPvo7JW
         4Mo2ie+zvYnIqXDRFqQ23aXfzGrmVAwt7w7wt35+7J9q9fkiES/2VAUq/6eGs3elugBu
         kIp1AKD4ecuwu2xyL324m6g4DNqwCYcqJyd++PeuNM22yhMc2yarS5734b5mY/P70I0w
         kj9/tkJDte1fOw0lL+p3fYlTXN8bhEt1sgadk8AqQjsFIEGkB+7yV3Ey/WkoYNTAaqRS
         /fAQ==
X-Gm-Message-State: AOJu0YxzUty8RaFvp1fJFTTGh7jm4/ygc/HdiFjtikCc9BjiCYZSLQDg
	PYEN4ivhZxMmMA4+Zk20xxo2P2rTyl4plQZ0TBP8byb7HLEu8MDNEsqXJA92BDk=
X-Gm-Gg: ASbGncvVSExH0CXSDfF147L2PT88PkGF8ziiVNk+gYGpqcYcGrwM0RylyUwGv40Ffv2
	u8Avu2AkiO+7ttiiFau7ptqpoxICvsvbiV+f69QgcQC4AcvJMF5iCR4b9euLxdBBmB58BRGD/Ls
	LkodyHFdtzdDivKaCEUgyZ6sAta7f7Ne8WyrfuYSAvdOsbVBNYjReord9WT499h8qCctTUds16A
	elVxnEwH3azsMPR5joVBMB0JSdz5vgx+jm/Hf2R2VLXGsoRZWKuzHAlAne9UL16OTtl5f3BQ8+U
	7yUa338=
X-Google-Smtp-Source: AGHT+IFvwnmbtMq1AAgByJ1dQ6xLahavSboMk8vqrBZAEwTMZjjFkDFba2QzD5D2VC7qs1yzoyT1xA==
X-Received: by 2002:aa7:8512:0:b0:725:e386:3c5b with SMTP id d2e1a72fcca58-72f7d1fc0acmr5032604b3a.5.1737632307954;
        Thu, 23 Jan 2025 03:38:27 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab814955sm12748876b3a.48.2025.01.23.03.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:38:27 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/33] cpufreq: e_powersaver: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:05:44 +0530
Message-Id: <81a74edcd9cf07440f07106d702953bde079206e.1737631669.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/e_powersaver.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index 6e958b09e1b5..d23a97ba6478 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -376,7 +376,6 @@ static struct cpufreq_driver eps_driver = {
 	.exit		= eps_cpu_exit,
 	.get		= eps_get,
 	.name		= "e_powersaver",
-	.attr		= cpufreq_generic_attr,
 };
 
 
-- 
2.31.1.272.g89b43f80a514


