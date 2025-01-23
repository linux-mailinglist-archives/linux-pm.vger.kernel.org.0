Return-Path: <linux-pm+bounces-20840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9D8A1A326
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79993188B7AE
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F2E20F97D;
	Thu, 23 Jan 2025 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bTWCmuhX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7877C20F972
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632295; cv=none; b=TeGfHtkXYJ5akNPm8ZqrOnjMeee9r3+HLSHg3feiG+gpLZLkzqiPmCioB/Ex6qDxDNTHXM1fMsP8WNlw/bwZsPfEo0BUSmM+Le0EygZ8Nfg5Ph3BF3D5gqHsFKqh2qnqWhFERg1gYtysLxAk2t5ZXDj2/NuOMn5X5l4vKuNofl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632295; c=relaxed/simple;
	bh=/eaDwV7KTDWfsPyU+hktEZ7d7yXLBX2ep1Cpqy09s9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dsXx3yF6XZ1D1vV3ZKDjcQ2hDg2ThG6uSyJjeJTZsiU348uXZq1PYZvTuYl8zyuRob3/RsgylomL5NoS5ctWoPlpo5/mn5o17jcegCdr+AGerUBRB6zjvitLQky+cUMXrZ6Vj4HGPN/GUpkmU3+nEsm9TtDDxAu+LRwrgkwqkfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bTWCmuhX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so1489072a91.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632294; x=1738237094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kw2sM+GGGQCvi7C9fRiq4muvzn9J9eRfRdcwd5c9mE=;
        b=bTWCmuhX7DU8ymMt5/srsw5NxVR2yaYOQtXO3HlmJqQ3hyKVotQ3yu3O4bQuCp7AyN
         1xEqTCBhQRsAeuPmy+wVTQzgjKRyr2ZurtJH+TX7cZ7qFkSGkET5ejz0OVh4VJteQXyk
         iUpwSaWSZ6LwSyPBiTeGfieUH+cBka0s6aMcAAwyaFoLvYKnOvPbtwTc9/Y5lqMc4qzR
         U9pnsP6QTAomyjRAc2iju4k1MjFuptw92vloHEXr1tixMQzqkCl00qCUKF6h4vo8IWFd
         MkF5vTnljF0wu94aPRyKmB3BR1NGGONSb1j80rearwerKb1bmgAPDjNlDHaBsrjSwoi1
         yssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632294; x=1738237094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kw2sM+GGGQCvi7C9fRiq4muvzn9J9eRfRdcwd5c9mE=;
        b=NS3OtgTyeGYyflXx0B8Xt880FUdihtWIpdNEBkkeGyPHXPkuZbBMvz9AcOlTS+YWf3
         1xj2TPDss6WrrV+Wl6EQLCo8sj6cjOcfuJRmW/aWxskH1VXBcbtbSZ78P6KsNw2BhECZ
         fa+qFUJezpsSzOCPhpyD4CzpFMchPJ0h2G1j/ydPe40yfOOt+odIm4JVK32D1jtaog24
         H8malQ/N8BUZ+buROI4USeCfsy5p2fDyPHDb6ZT/y138YiItmoeV2LWgDUk8pQgx3YhW
         sNGWsdaISHNjLeW8Aks0WlhmJlRwsm6rvp2kpISiSTsWkQbwH7/2BXt0TtdMGsgVNLZI
         qTvQ==
X-Gm-Message-State: AOJu0Yz6ypvI4CoaNMhffJtoo7AqrWEVALRX1PrnLkJXjn54KEZouSkD
	dVn2tjY1Dw4NL2xO3mTTl6ZUTHbf8eQWQ1V0quVgCzMoN3rGZnxeGtrC9XC70Ds=
X-Gm-Gg: ASbGncu3ojrFB1ZslDVlMnZe0Iu52LOhKw8Dt6DC9axc8uMkyTMlOCBVzfJ/iFugI8z
	j5iJoJI5Y4jpVKqa5L6dPRaeFt757pAJRRerlljIwmLUhp65C7btDRqO9TdwQfNyCfWqhsVi7eY
	qDU0mfCgOSVlzBEk7qwkbfqU9S4rhg/7dLiPTQPPXcENMqpC/8A/S0LvOLjAi871NFmp3Pdwpt4
	ky/7zNbXkkL48r9dBZPEVpproElCygZGyI/yr6lvitrtflL7P/dIKYZGIMZi8Z0s98+yG5I377E
	Uii9RCc=
X-Google-Smtp-Source: AGHT+IHWLM3diQyfBwkugU/sw/GmrdkJCg0OZDXV8IndopAoO/pn5U57ZDPYAMTatmutRubStW8Kvw==
X-Received: by 2002:a05:6a00:10d4:b0:72d:8fa2:9999 with SMTP id d2e1a72fcca58-72dafa03124mr36163356b3a.11.1737632293795;
        Thu, 23 Jan 2025 03:38:13 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f06c3sm12714223b3a.20.2025.01.23.03.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:38:13 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/33] cpufreq: apple: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:05:40 +0530
Message-Id: <17e7f171a63d9104a0688d223539d36feead8790.1737631669.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/apple-soc-cpufreq.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 269b18c62d04..6ff604a0fe79 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -229,12 +229,6 @@ static int apple_soc_cpufreq_find_cluster(struct cpufreq_policy *policy,
 	return 0;
 }
 
-static struct freq_attr *apple_soc_cpufreq_hw_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL, /* Filled in below if boost is enabled */
-	NULL,
-};
-
 static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret, i;
@@ -321,7 +315,6 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
 		if (ret) {
 			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
 		} else {
-			apple_soc_cpufreq_hw_attr[1] = &cpufreq_freq_attr_scaling_boost_freqs;
 			apple_soc_cpufreq_driver.boost_enabled = true;
 		}
 	}
@@ -360,7 +353,6 @@ static struct cpufreq_driver apple_soc_cpufreq_driver = {
 	.target_index	= apple_soc_cpufreq_set_target,
 	.fast_switch	= apple_soc_cpufreq_fast_switch,
 	.register_em	= cpufreq_register_em_with_opp,
-	.attr		= apple_soc_cpufreq_hw_attr,
 	.suspend	= cpufreq_generic_suspend,
 };
 
-- 
2.31.1.272.g89b43f80a514


