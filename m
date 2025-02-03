Return-Path: <linux-pm+bounces-21282-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD81BA25660
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 10:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2CD18872BA
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 09:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BFB200BB4;
	Mon,  3 Feb 2025 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g5gJzon+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F5720012C
	for <linux-pm@vger.kernel.org>; Mon,  3 Feb 2025 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738576441; cv=none; b=kYGnXryPTIYqxyJbMM56YaZlhLtTaGYUhi5Lc9Kuulm+Q6DV32RsnXYAN0AMq9ferniXmhnSlcNgNbI/EO/HjEZntTRySKWXFPT+yz8f0IwfSjNORHl129HZD3d8qz4O339HiVCy2OPGg/1swMtVVCEGtgKshSVQrl1Q75Oc5GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738576441; c=relaxed/simple;
	bh=ozCbctTngO50lZWfr7m8Wu4UXC9YqYbG/0hWz6Iy5mA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F39m1E5JbRbYCC8g5p8+zggCSUc4GImBUtNEiL4tIf5UMGcuCrbrBauIH9onfzVI8tUjIEvd+F6xLvBhiiookFY7uvUbKvPDw+Ze+FxDa/43laeYo2rIx2u2NcH92UJiiy0A5bf4nk6trL1AvAAux3E4S+9BxFhGx7B0B2F1pq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g5gJzon+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21680814d42so67097565ad.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Feb 2025 01:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738576439; x=1739181239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGm/bq6SKySYHYDc9Teum4UAC1vMAmPVFWHcwcmi784=;
        b=g5gJzon+dFqn8XdsSQRGi5Wacr6DHanGZ2jgs0PrqnA55ckVn3A2/46tTdey4p4KG/
         de3q+UkL51exKTHa7TXILHcF2N8732o8iQd3abFt6LmOC9wYrtfEk7qfdY1B1Fm3NBNw
         o0zVt7AVpyzXEooCq36NcBTRlPXHkqJAKbzr9bdov0s7aNddi6ybzv/Ht2siPxZhYKJd
         GdvEhXnuGsMWaAh/Ohg3sfXmQ/BOoH4J7NA+0hwK2k8zmksCi/AQg4G53/jNDgPQRNB6
         e3IFkoovfjfIDxdvLN78y87xMEfS+8sm2w3VdUmkdet6GkWdH+OCNXOyep7XUhODIxct
         munw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738576439; x=1739181239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGm/bq6SKySYHYDc9Teum4UAC1vMAmPVFWHcwcmi784=;
        b=mFSuIlKPd9EnzXQtM/xHljFx4YbBOknz4TDT+Exb7I9UxLxhIyI6shP2Bz9HiVStRB
         sCtCUFHLrn+FrDgONF+fyYBMftzZ3bkxFYqg4KPgtjK7fMZB/T/O2mYS/fRMp6ueXy6n
         L+gzzkva49wa6zKScKPIiY55vUo2yKID+8dqgYUkG0sTPjkzwrEihwHo+91y5w2/00kU
         Z9LsMaudloqK54r2kRQ4F9cj0H2f0TOQInyiN4EPy4IBIrllPzqco4E0YEMHzl3FQGnG
         bJUKwqpdyOOSxSuDtmuUjqDTiB6ecVhRTtInjIiWhl4c+jLCDXoffhrFI5FNAjIAo7Ua
         6sQw==
X-Gm-Message-State: AOJu0Yz89sR3rEwJbDKxa2U1iuNU5hXu4i6/VNwZVxB9FvU82649QOi5
	pQNtU+BO09gYUzTvECpn/TOghsK8aHRqf99s74/XQbDJqT/LRNAnigSknSBzWBQ=
X-Gm-Gg: ASbGnct1uVFnJSybiAcPS18fuhiHesyvnIPihcAqbw/O0YFqjew7EfL260L7aDfmAoW
	SDVPz+ze6xir0qFy7krab+rhirNQeTfkX+GT8ofxJAg7upRtFnurz+3d1Nhhp1FoDrBuaoRD+gs
	ZRJjnKPr3bkH/wk/TeqqYetSTj/Nstfwz20UZkyYUKcuiTuFhB8WfOwYIVHY7j10GifWCqOeIwC
	lnxJ0rxvr1FIschGreWdZhIKKCm0619ERMRtXeLAiEmELNiY2OQxi9i/yB0Ywc9nSd5d5qwiqzj
	YC2LNI9DueTLW3BFGQ==
X-Google-Smtp-Source: AGHT+IFwo05BiIt05ICb4MDKGKrGGWOHvgZo0+KY9Q0VF4jPxeMFSPJcZ0MPvxF/KghXhf5T9qIi1A==
X-Received: by 2002:a17:903:947:b0:212:4c82:e3d4 with SMTP id d9443c01a7336-21dd7df2d2cmr345490545ad.46.1738576438710;
        Mon, 03 Feb 2025 01:53:58 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de33206besm71659285ad.241.2025.02.03.01.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 01:53:58 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V1.1 20/33] cpufreq: powernv: Stop setting common freq attributes
Date: Mon,  3 Feb 2025 15:23:32 +0530
Message-Id: <fa304da30d5f10e7ff069d72fb3aff2741630ca4.1738576306.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <1f5393d54b2c04206afefd521ebdf3fc03004a11.1737631669.git.viresh.kumar@linaro.org>
References: <1f5393d54b2c04206afefd521ebdf3fc03004a11.1737631669.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpufreq core handles this now, the driver can skip setting it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
---
V1.1:
- Drop runtime updates to freq attr.

 drivers/cpufreq/powernv-cpufreq.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index ae79d909943b..0631284c4cfb 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -386,12 +386,8 @@ static ssize_t cpuinfo_nominal_freq_show(struct cpufreq_policy *policy,
 static struct freq_attr cpufreq_freq_attr_cpuinfo_nominal_freq =
 	__ATTR_RO(cpuinfo_nominal_freq);
 
-#define SCALING_BOOST_FREQS_ATTR_INDEX		2
-
 static struct freq_attr *powernv_cpu_freq_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
 	&cpufreq_freq_attr_cpuinfo_nominal_freq,
-	&cpufreq_freq_attr_scaling_boost_freqs,
 	NULL,
 };
 
@@ -1129,8 +1125,6 @@ static int __init powernv_cpufreq_init(void)
 
 	if (powernv_pstate_info.wof_enabled)
 		powernv_cpufreq_driver.boost_enabled = true;
-	else
-		powernv_cpu_freq_attr[SCALING_BOOST_FREQS_ATTR_INDEX] = NULL;
 
 	rc = cpufreq_register_driver(&powernv_cpufreq_driver);
 	if (rc) {
-- 
2.31.1.272.g89b43f80a514


