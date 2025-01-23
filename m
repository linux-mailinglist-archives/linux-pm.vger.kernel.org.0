Return-Path: <linux-pm+bounces-20862-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DD2A1A364
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12833AF64E
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D34216E26;
	Thu, 23 Jan 2025 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eX2v4j1x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF3D216E19
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632371; cv=none; b=jaqP/H6kbNe2rP2dlqPvT44ezgzZoCvNz7nEh+pugUu2vPq5LEt86CNDASaw5gGZF5jSolELsTA2fp3aNxSXSm9C3VAm5wZfLq4gnaXxumIBBU0vwfqFfVkLVUmLZackp5g/FV6RImFmcA7cNIo7LR4dbTNjZNO/15yhrlMXKTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632371; c=relaxed/simple;
	bh=tVzpkvRHob2oScLfzIZzugzDEZoNPWNMmUeVbL5KCJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X21r3C3B981j8w+GIKVV2tajMzCw6etM2auyBzcOkjoQCv0XnLCG6APMgvrmGEtmCcPUp/pmUkgZdNliOYbSLA6JAVyUN2n/7CJP6OFlc9iptT09x8i0oXza66avxqrjaL5GU/cewecs8o/WWRQulYER4am2qnuldyaqd1EVFWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eX2v4j1x; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21636268e43so15826495ad.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632369; x=1738237169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGe7MqKM2mmQTSmw67MYMu+5UndpwYqCm1PZBz2cmzo=;
        b=eX2v4j1xsKeOwKFtMm0YaFu8E94TF07F5GBbPH1ptY7qIqMdoDAen1gPHejl0hBmL4
         MfOUrKEb1+ksjaCjS8nnCOTORwI5xi72Nhmv0UuCLDPRyZH603wEOYSvyfrBNppe+i0z
         AGgmNOlV9gmuXYOtvGX964TT14QjPGUOvmhvf+NDrkKTn1eiWt96oGWJGXkXnTkarRQG
         JraWXHExOPFNmqKw2T2Bi6DuNa5P46EKwJ0OAVZhYEWvb5WjUMxgVPoC5moPv5P2VaG3
         kct+KJLgY+O0PrH8caxAJzGmoTzTouRhdKk3JRUcr/1bwn3K2F7cOH1+oF3ePL0T9fMi
         N5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632369; x=1738237169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGe7MqKM2mmQTSmw67MYMu+5UndpwYqCm1PZBz2cmzo=;
        b=gBYreg3uPEzjXzbu7vMvAbv/wkFdO1hQQbepYILb6M9IcPEVwBv8oSNYe6NvVWbqjg
         FS3fT+oYTf45f2jPegbG8N2Vu+0osm3T1i3rut2V/P+AhQ8NK3Oqu60L9F97ZeVUOjBR
         ZUyIdcEdrecfm49sicVTQ9EADQZL+WkgS88JsCBDDlREdtiHpzlG/fsIBcBnv9xAFCZt
         SCJvSJ0D+DljqPOqhM/fH6C8kPdRTW9/Y4Jany7w913yIH2tJzwLg553Rkr0t262RNUx
         l01Sl4dsDUTm8m74rIZytnPtHk9SP9bmHs4dLT8Ml9JEV2BWaAslIp2ysgrQa9kQxDwM
         oq3w==
X-Gm-Message-State: AOJu0YwFiXidV8PTBZ/n/FSCKa5kBKaDcLmRMIKzQUDFdvFg/2Uza1cF
	aYFZZOkv7Z/lhCwdcde9D7NEQwf8pVn5NczP0tEdg6GSgBvqFYpqVSBDgN1D6/U=
X-Gm-Gg: ASbGnctg/ZYLLBW/urDsEasKIbv6cMsK5BcpHYlRF9/+rVaY3Ht0s1SRBcjgYandC7s
	iIofI+LL7cFU4T7vJ1WpsYgmbq1z9TKRHo0OhdO9kayhLApQp/Yt3NY/vazBBqcv6v3B3b2VBJH
	t84yE287rAn2NYHX4V4UeHfi5iZ4KYNtgENHVsA7RlHAewk9ik5pCWPjuFj0xNoiKIfa1scmGKN
	RM8cU2JXOc7lB10UgqH7MvzdzBDJAw4wqaJFI1AxJQPZ31BSYwTsuuiKZTnF1DwezkIiZgg20ek
	h9i4ntU=
X-Google-Smtp-Source: AGHT+IHG6Tmy6vaGOWJamV9GkohlZ7OBqGg9X+O+3mNupP6Bb4a45cYQLihph+6Wmco/QdsR7Mkr1g==
X-Received: by 2002:a17:903:41c4:b0:216:2d42:2e05 with SMTP id d9443c01a7336-21c35539f08mr371019405ad.22.1737632369164;
        Thu, 23 Jan 2025 03:39:29 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d402799sm111476555ad.221.2025.01.23.03.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:39:28 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 26/33] cpufreq: sh: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:06:02 +0530
Message-Id: <47b6125c790b37393b2c35e9924c1b8a8fc6fff7.1737631669.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/sh-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
index aa74036d0420..9c0b01e00508 100644
--- a/drivers/cpufreq/sh-cpufreq.c
+++ b/drivers/cpufreq/sh-cpufreq.c
@@ -151,7 +151,6 @@ static struct cpufreq_driver sh_cpufreq_driver = {
 	.verify		= sh_cpufreq_verify,
 	.init		= sh_cpufreq_cpu_init,
 	.exit		= sh_cpufreq_cpu_exit,
-	.attr		= cpufreq_generic_attr,
 };
 
 static int __init sh_cpufreq_module_init(void)
-- 
2.31.1.272.g89b43f80a514


