Return-Path: <linux-pm+bounces-20929-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6ACA1B238
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 10:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116773AEACF
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 09:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696C521CA1F;
	Fri, 24 Jan 2025 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vMXJxbCw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D2C21CA12
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709153; cv=none; b=pMSROrwgDfynAFURlDHlcYmhfqYA5XvjpLXdlTpYULaXtD6pQnIzvmA98GzgzLYD6VJAFcWBLccyJAF1NI0oFL+LIC7l4T3aAs4UsHZZKt4LPctj4JW3TOeBqAphSCqij9XeeBXvVYTso2yCeotGd6yAgPJgiFdQXmQLGn7SiWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709153; c=relaxed/simple;
	bh=vHiYt7vyvuTJG+6H+4GLHJZ9r0KvgIZnQowmLqEx3JQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AbExSrrXHrakyxcNanZybfo9xK8uur6t3aPjrJ9X9/kk9pIEIEVCEuOv7/FYbAF+1SUVp5Hh3j3jP1LZZu02JyPiCR0biEThWy+PdvbDPA5VriieVPBmwdWxW0veDbpxpJM9Gi3M0uWvi/bsvCJyziCcEIqUeNB6LlXN4WX7qJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vMXJxbCw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2166022c5caso29276735ad.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 00:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737709151; x=1738313951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p945ECaq9P80WMODWEJG85jptgTxpTyGy7Go/5N1kDQ=;
        b=vMXJxbCwpdu0D4J7HFbHuTsGyOEuW/jHwOqAFg58kT5KLWBVRlfr36X0LgpcOq21UE
         eKVODHRbBC7G8mRuJOwS0dHI2qksLilfmpzjzKwOOcrOmmgt3PJpu+tGLIowVVkZix2M
         BERiEbIHZLawOEIHZeYHh1RKlVc6ng2qqhqkNdIAHbPmmvrv7s+caBKqWP7h1de/YQWm
         P7boG/Z1K/bThOT5hnrRJu3Xqmd+dxobrbgy680FE7+6kuap6QiSOUEvvYBOorO/31ON
         pRvdajIqg2CklrLASOFsXliT28U5Cc/BiV4ftOvTz5NvPSTjExpOWFktvo/CXDkVRFQR
         FcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709151; x=1738313951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p945ECaq9P80WMODWEJG85jptgTxpTyGy7Go/5N1kDQ=;
        b=gJ6HqmZGmlFljizpcEPERMz2nhqYkEVPL8YW28rJoHVmXIRPC9qOM8IvWTofdOSe7Q
         oXKHMB3GClfnVcGYJvLx/dB61mPRspF/HwcPvEblHkdT8Fd/Oaw4RHaH7ZP+IeudV4Hu
         okXtD40H7xkRKH9z/TUlKMa5Crgz/aRYCKPc27BYlsUlhcDA9bxypxji9Z60ehsnBNtW
         toAR5BSr/Af4MRLPbj5fhu0DiD2hD5Z15BZgDzHNOC7VBe897+ra15cks0hgiI9b93PT
         PpjjiaIfasMG1oh+PcpnmCAVqt4xN/m9DMMYXeinQT7Q8LbGF2tyLeC3zx+7Q/rOo7fv
         lRWA==
X-Gm-Message-State: AOJu0YySJD5spltSz4J4lDkVujN4oI2LJcZeaFbhYJ9dte6L6rurgw2p
	6TkuWwarsY3upHRN3WUHZSjznWdxGHx0x6Y59tU6A4Uy8M6dpCMT41XR3hVexnC6EVsmtr4XjYI
	W
X-Gm-Gg: ASbGncuPMoF5yKnjdEphNmWDHFklEY6Y/kWbZ3b4iDawr5fBBPBocaDnkp4KCzR+SBO
	kmLgjckcIHFgajHiPXPUbgo8g+rVOXRv9DxEOiJjzWfCrlGtcp0jJoEUHTfBkBfp1eATQ5nvZAl
	8bZ/EbMaXf/oF5M8D4wBkS5RW+9UdDGObzUgp5WZA3KghZ9WrqjmIdx/H/vgOchOHX4rLPoApOg
	3QniB8CjmeenQBv5XOQxFAm7aRdt/SLBahVvX3sJc+H+fBUdA6S5Yoxd2QB1EAj+epFJIAY+k4h
	nOPOxeQ=
X-Google-Smtp-Source: AGHT+IHmp/m1FnjKUe6ha9HUOGa0p8k+59e/B1rJ5ftyPx/opbLtw59hiYoa4G65siJHRA37syBgsw==
X-Received: by 2002:a17:902:d58b:b0:216:3e9a:89e with SMTP id d9443c01a7336-21c355b70ccmr503518985ad.35.1737709151226;
        Fri, 24 Jan 2025 00:59:11 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3ea3adesm11668875ad.74.2025.01.24.00.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 00:59:10 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] cpufreq: dt: Set .set_boost directly
Date: Fri, 24 Jan 2025 14:28:16 +0530
Message-Id: <e499720e04b548726212c3896ec4e4a887087ffd.1737707712.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1737707712.git.viresh.kumar@linaro.org>
References: <cover.1737707712.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The boost feature can be controlled at two levels currently, driver
level (applies to all policies) and per-policy.

Currently the driver enables driver level boost support from the
per-policy ->init() callback, which isn't really efficient as that gets
called for each policy and then there is online/offline path too where
this gets done unnecessarily.

Instead set the .set_boost field directly and always enable the boost
support. If a policy doesn't support boost feature, the core will not
enable it for that policy.

Keep the initial state of driver level boost to disabled and let the
user enable it if required as ideally the boost frequencies must be used
only when really required.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 072ccf0c2e41..778916f89a51 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -114,20 +114,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = transition_latency;
 	policy->dvfs_possible_from_any_cpu = true;
 
-	/* Support turbo/boost mode */
-	if (policy_has_boost_freq(policy)) {
-		/* This gets disabled by core on driver unregister */
-		ret = cpufreq_enable_boost_support();
-		if (ret)
-			goto out_clk_put;
-	}
-
 	return 0;
-
-out_clk_put:
-	clk_put(cpu_clk);
-
-	return ret;
 }
 
 static int cpufreq_online(struct cpufreq_policy *policy)
@@ -162,6 +149,7 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 	.offline = cpufreq_offline,
 	.register_em = cpufreq_register_em_with_opp,
 	.name = "cpufreq-dt",
+	.set_boost = cpufreq_boost_set_sw,
 	.suspend = cpufreq_generic_suspend,
 };
 
-- 
2.31.1.272.g89b43f80a514


