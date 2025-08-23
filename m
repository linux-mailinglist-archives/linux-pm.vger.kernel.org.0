Return-Path: <linux-pm+bounces-32928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 828FDB325BA
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 02:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45EB0588C85
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 00:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5ACEAC7;
	Sat, 23 Aug 2025 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/LoIvV3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFA417555
	for <linux-pm@vger.kernel.org>; Sat, 23 Aug 2025 00:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908431; cv=none; b=g3243YgoR4EIY8NtwlxLFRSvBuyNkHhBwcyRg2dtJEZAkQWzBlzP0tQS/iG5NSXI8Mg3P8/xZGMTUXY46OJnhYxARFTJl3UWrTNc+ISvaP9veeC4dPaPZCSmJTgpgjDgKjblT/9wTP1WXQRWUHDTx7/zgYQvUfsxndKzsm5Fu8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908431; c=relaxed/simple;
	bh=IzXBy0JDm5P7DeRxtoCFvOVrJJzRcpwGhg/ODLS/f4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fhw4tIfRrOEETIts9euQEsL1migCvmG5zYEPaG+3UlhwJSsVlK8EBaUafaLLl3052X46e4prGxVzQ/IDYd47qTyz6zHexBZ2Lh0gb/8xD6TzPcc2y6rPbe9BHFRb/3bf6a1CXt8AYYLGsdTWzDyyYEgTPkN23HyAITkyAsFMKEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/LoIvV3; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b49b53c9743so1329304a12.0
        for <linux-pm@vger.kernel.org>; Fri, 22 Aug 2025 17:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755908429; x=1756513229; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IkunMuqOTjzTmYvfp0kTEUrdTSxEiMipgCHfYoiQGpg=;
        b=C/LoIvV3G5gGWak0Zg6/TA3X1Ee+kQiFe8bRwpI7RqJtMtZ/7rkbRdN2fstSA5S5V5
         E1iOEXKfiTMUrWtTe5EdZPI0wL0IQlNIvxvH0mL7DDUsV6zWHxbg8c9TebQ2t/rNlUWN
         8YS+qyzEZNETXoW8jhGOsBSfprRw84MCZBoTkzo0dnG33URLhIWlvzw+KwaHIek5gdig
         utGKizGKOYcdJcfqf2Nf6aPQSPVlHPlklF456hMkVTZkZJFAagapprQBxmiGly1Sfz2T
         VLSqicJxy/9pvuW0oIyZVDjGI3tssbPA7IfOy5iOwWDRyjDPiYvQVcGN3poeYfuTAlso
         b0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755908429; x=1756513229;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkunMuqOTjzTmYvfp0kTEUrdTSxEiMipgCHfYoiQGpg=;
        b=jk6NUkt44h0Ys74THkJeI5Uo4MVeKA2SBtmqLAu5CQCjzXDX1KMSMVQlV+msGjWw8L
         VUenFV8Prl0x97II2G2WvtkiTpcamU+Qyl0TRrWqWHGNPwe32YIN2BhUPkpTU/Iw5srP
         GLxOH49V9A6yv1IxBz3HlesNT0JBfsATIfViBvEqo+pafKfmQrB70kX9VZGsKAt65+JB
         neaNKe31ETfKv3lFcbQ6ZhftFoUmwJio3RXkbLQfyPrJGnBbAE3JvqoSYm1evLtBNjEW
         qVNTGSPg00aKmCu+uOU2mRW6eY8ipZYf2TQk8weXcXofFiKDs8TdBDuSBxKtuVyoJ+jo
         dDcA==
X-Forwarded-Encrypted: i=1; AJvYcCVhWFH9sTH6VaGUANaaWFHA6qOI7tJeZMuSYuQ527df39X2jJNRtf7p9Alcv1tq6zlx4VvU7ZczEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGtgSaj+HT0AF3CBasQm11gjv5y9pUWtNhiNLLj6CRWFXaaKy7
	uHzYcMJXXOIIh38qp2guxE2329LQiwevyT0hB27G9nEVIEqBPIVYFvrdDwBvuHuFW5x1mlYtc8o
	dEoilma6obQ==
X-Google-Smtp-Source: AGHT+IH2meIMrbfg6cA0DiATMI+gqKbNcFZVYHUt9TbVkruM9LnU8cXpri5WfeUocsKnglMv3dRahkUsS8Mf
X-Received: from pfbfa6.prod.google.com ([2002:a05:6a00:2d06:b0:76c:555a:bfaa])
 (user=pmalani job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:430a:b0:233:927b:3ffa
 with SMTP id adf61e73a8af0-24340b7ca46mr6933649637.12.1755908429227; Fri, 22
 Aug 2025 17:20:29 -0700 (PDT)
Date: Sat, 23 Aug 2025 00:17:50 +0000
In-Reply-To: <20250823001937.2765316-1-pmalani@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823001937.2765316-1-pmalani@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823001937.2765316-5-pmalani@google.com>
Subject: [PATCH 2/2] cpufreq: CPPC: Don't verify cur frequency on governor start
From: Prashant Malani <pmalani@google.com>
To: open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Beata Michalska <beata.michalska@arm.com>, Prashant Malani <pmalani@google.com>
Content-Type: text/plain; charset="UTF-8"

Opt in to not verifying the policy's current frequency when the governor
starts. CPPC's get() function is known to return unreliable values,
so checking against that can mean the frequency gets set to the
unreliable value even though the governor (and user) didn't intend to do
so. That in turn causes unexpected performance drops.

Cc: Beata Michalska <beata.michalska@arm.com>
Signed-off-by: Prashant Malani <pmalani@google.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 4a17162a392d..7fd6c03bb726 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -910,7 +910,8 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
 };
 
 static struct cpufreq_driver cppc_cpufreq_driver = {
-	.flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
+	.flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS |
+		 CPUFREQ_DONT_VERIFY_FREQ_ON_GOVERNOR_START,
 	.verify = cppc_verify_policy,
 	.target = cppc_cpufreq_set_target,
 	.get = cppc_cpufreq_get_rate,
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


