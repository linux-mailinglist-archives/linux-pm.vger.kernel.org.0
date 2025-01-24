Return-Path: <linux-pm+bounces-20927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0F5A1B22E
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 10:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D573AEEFF
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 09:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4AA21C9F0;
	Fri, 24 Jan 2025 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dCqrEGVm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E621C19E
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709147; cv=none; b=ATc178V1NN97jAew44pqzEX5/2+2ZYIAN7l6X9qDNgSfIsuGYvN9+8lwYsgjcphG3fDNzQHskLsfvrFOydQEDTaQIoF7HVvrC0/4fqmzf/7qF5NmTT0CgN3cgNI9nBXZsIhn9Ci6AP7FrhDkeMMje5bq3iWW6p83YJJycJbUXAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709147; c=relaxed/simple;
	bh=3/ztBZ/HEPa/0k8R9f3RWIpWad4EPbBsiTzjR0GmEsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aMgO4ahUSm8c5tGgt6+53kLc6zT6W7jGRhqotslgxE34dRv5JrL7e8Iegg4hPQo6r7AJFHnCpbkR5HJ/LFt/CFDJDEVN2w44lii7Cu6LnMdp5zgFYz9JmSoDZc3zi6Q/VcVlfzYxU7nG7IWz2d0YRiW5ZASsp7x2m67CwjlDdjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dCqrEGVm; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f43da61ba9so2662721a91.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 00:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737709145; x=1738313945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHvPLEImTEWfALntTBCPd9TKW0+oiHv2uyr8XB4xyIc=;
        b=dCqrEGVmN+SlrNYH2QodDIHZOAalwer66LQDEbpuOG9nE+XQwJ7LyJX6yaeOD8R3fg
         tO2LgPMFfSXNLcVB1GKO+P3NusZmqfwE21yiEwhuBWQqoeWXVYWvLMe7hv/TinyBiDZR
         IajaY1abD/+q2n4g0WBYPWWXKVB0kx/GpIfgf+/1hrEt5NFlTqcB+N9orZlip9ZW4gRO
         m8kKSDhYDycm41hhQkw4ylpHRpp6lCu7bM/9p4zemo9oF6hKUY5QER9ZcHA50zM3YVFp
         c+kMm1A/GG/YfUnNhS3JGbUalUVVeMGFxQR/oRjggYQG4GHV38AoprHBdGf1wym7uVAb
         V9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709145; x=1738313945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHvPLEImTEWfALntTBCPd9TKW0+oiHv2uyr8XB4xyIc=;
        b=kAUzVlkC6KqdXtY1qmyG3wl6W9YHdju8SwoZe0osVXRJ+krTIk43IvGGboNKii1jBw
         ntaxcyV8Si8QdDhvQosRMgl8tLdO8uZ5FgA+1LxM8Z1CD0SqsMs1FFQUr1jzL/Ct4AhV
         9jyk5yMtJpFCJnYLxwgcesA4ydkXneglrAPUeIlS2Zkr751BSYU0Fkbj5/s8FYLzlTso
         hOj32/dKInghvEnuHnFiYwc09FV0xKWIN/JfxgbSuLzn9a447aVxaxUUSrv+aC8uET2i
         wW5k/k3ictknRSM08pJjZ4SNAoJoluaGeXFBPKGUJNz8LFqpK+h8UIBlv1xAnLuxsw2z
         1XDQ==
X-Gm-Message-State: AOJu0YwoJCVx8yuCvNIHRjmwxZCNJq+q8ekhy6LOcUqfcAOy0QzaaW7i
	cnZ69EPLa3cv8ET82mVdU49MjTATArQMGiyP9uxHVeEJponkmyofngQsOTMKPUw=
X-Gm-Gg: ASbGncu0+qAf6jV7rE2O5JzNG/TvKjPVmJb/mKUriWamYlLUWcUrMIRJLHNsU1uXWAb
	RE+srtM1L1i9AgRkauHNb199wvW/V7F0UukcbrwgiIjuCl/Qauo3jOkGvZNHycr+/DqdHis00Hb
	Eqn/D5C6VvQyjM9uzk8Wyg4HeqRuolyTR/kvIoE3ErxFHdPKj/ymUA1DH1Ou18T+QOe5dTFSeZy
	L+7m6Jek2qnm7BIp0gVJelSI7H2mq/wk3u8ovhM/eMViZbmWWCyqixNFxpa3klgjR4C76MvFzJK
	DKGxmUY=
X-Google-Smtp-Source: AGHT+IFlPf6Y5ApV2vEgtwBRH/T2hTrMCJRbAhXXb7JfHHFFf33S6aG5dH1A+wfV/EhE0fz4W4IA+g==
X-Received: by 2002:a17:90b:1f92:b0:2ee:db8a:29d0 with SMTP id 98e67ed59e1d1-2f782d4f3edmr36840886a91.26.1737709144725;
        Fri, 24 Jan 2025 00:59:04 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa6a725sm1258715a91.21.2025.01.24.00.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 00:59:04 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] cpufreq: powernv: Set .set_boost directly
Date: Fri, 24 Jan 2025 14:28:14 +0530
Message-Id: <9b4af20d5b415f41e866ddd8bde9cf6441c463b8.1737707712.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/powernv-cpufreq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 0c3e907c58bc..4d3e891ff508 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -1125,7 +1125,7 @@ static int __init powernv_cpufreq_init(void)
 		goto out;
 
 	if (powernv_pstate_info.wof_enabled)
-		powernv_cpufreq_driver.boost_enabled = true;
+		powernv_cpufreq_driver.set_boost = cpufreq_boost_set_sw;
 	else
 		powernv_cpu_freq_attr[SCALING_BOOST_FREQS_ATTR_INDEX] = NULL;
 
@@ -1135,9 +1135,6 @@ static int __init powernv_cpufreq_init(void)
 		goto cleanup;
 	}
 
-	if (powernv_pstate_info.wof_enabled)
-		cpufreq_enable_boost_support();
-
 	register_reboot_notifier(&powernv_cpufreq_reboot_nb);
 	opal_message_notifier_register(OPAL_MSG_OCC, &powernv_cpufreq_opal_nb);
 
-- 
2.31.1.272.g89b43f80a514


