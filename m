Return-Path: <linux-pm+bounces-20924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 969CBA1B229
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 10:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BD93AEC8B
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 09:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4260B21C169;
	Fri, 24 Jan 2025 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QI0CqMVg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B553621B910
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709137; cv=none; b=RfxZAIjKF7p0T1LFfC2hfjrAiQJUjqaNywz4BipVWCuEqB1f4M7Dt5mPhVzyxmdoWuziwY1c8lBd08Fi57iXjy7ZiY9dFmbNOcy8A03fxzylmve0QAX9bkFvMZ6GUalZK17QPS39BiouZezSA0Jn0YYZR8ZYDi+Tuko6cvZLNn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709137; c=relaxed/simple;
	bh=uYhHZdbr64hdPoU54/0DIov0rDAVvGEb3ytqetE8eIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gihb7ub54vEPrlKOWtnug3n6hWDqolBxc8JuVXjz42KNdpjm0ekeuFAnClxJFzKlWUjKu3SC8icV33oU3Ct27oZmMhEGtFQgXr+Ixfsyd5wNVwXt7PcD6UusjARuTgIayc3VC0TOPsnZWmVqx744prRzr2/9oBjcxaP13Xp9Wd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QI0CqMVg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-219f8263ae0so34664965ad.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 00:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737709135; x=1738313935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiL8oqpXAlFH/FMIkjYWkKmW/Cs3uhy3DDlxYi5jlOQ=;
        b=QI0CqMVgN997O906MbJNE0QRP5Kqzm/W6B7Efh0S5nDmMgkj06VhMMs16v9mg6ghUU
         aEwBtL14/nqcJGLZznti+WCc9HOw58ohJhmXSqZMCAoNVNATmzLsAQnt2fZ0ot3ohMt0
         BQHG3fZLRufUXeqxYS5F52/X70WsghJ/JJqY9jOL2MLn2+3zqrPNyDfP8ct3dQbIEljZ
         H9lR+k9bIc1Xip+xYcOzCedO8EhX6yapLKsPKyO6rP4TEoBiFG+ppMxTH4H0aMWjIxkG
         M0Hx0Vkm662Yc7UuBne/QtORyfvHYwkLda9VBpN1ttI1RlPsrFORjBtRYGETEimkoUJO
         giXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709135; x=1738313935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiL8oqpXAlFH/FMIkjYWkKmW/Cs3uhy3DDlxYi5jlOQ=;
        b=NI+laka/1s4BPklTLJsTbV80syZw9N+53+9mQZfNksKN6QhHzk7KWAyDoIs20rSUw+
         bT2vz0qGVe1DhU8LJpFyobahHPcmmIKmFFkT+BrDIr9YCXeUq2L5cLAKdv5BINTPUE8X
         h0mIm9pBmp/oq4QchV9smGYuQeacoKjqep+eysWrWZUqi/w+XvkwvYnHKOwnHiDvwjvY
         fzO/KDxJn6UGo+UjmPyEaE7Cm1sqNA10UNNEfcizV8G/Ki4mGdOFxFvuqtz2W8IEOgAx
         jZ5QQav9A14uF2dLO0MMQzpSiFDO8ZTUZbgwJxCFH/6FogaSymdAVltUG6eTXXFdQxgg
         ZZLg==
X-Gm-Message-State: AOJu0Yy5CkkrjOg7w4apsUgXfrn39Nd3vS6IIojAQIqZaXLpX1BAiQI/
	+xJwBW2hfbmhdtrQkw3UsJuL6zhMYLK0fdGC4PKDMbyRtjGy7mhMw1iO3Cfh7sk=
X-Gm-Gg: ASbGncvKzgaYrghs5/YgJ279zNzXBJwu+35aWSHPXaPFBEEgDmPiWBHyPl7CdR50swB
	EZOLD/3YFxJ4Zkh6G+UCb9DjdCcxIW78NqfuBJq2mM22qO5O49KHjP8KdG96E57ebRky2AFgNOR
	sXtwxWkxOUtKk5mwPEOALmu8dHTorH03Kg3iry2KihiRCPrs2/vSI83m4Sr76XqvxmMAvo6YUYu
	nbgz95IHlZwk56PyvnMK0TXZRPWQJ0bQfL8PMLveRU5cxmoi3YbmOOd4MHQYY7TqCjqEMdr+4w/
	/znQqZ0=
X-Google-Smtp-Source: AGHT+IEsz2Y0I/86SGoar4cxilqh6u/4N68lmrkUwz97Jaxsbzl2m+7O6b5bkF3tOeNVC5P95iG6dA==
X-Received: by 2002:a17:902:d2c8:b0:216:5e6e:68ae with SMTP id d9443c01a7336-21c3558c76bmr447252415ad.31.1737709134962;
        Fri, 24 Jan 2025 00:58:54 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141302sm11568035ad.154.2025.01.24.00.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 00:58:54 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] cpufreq: Restrict enabling boost on policies with no boost frequencies
Date: Fri, 24 Jan 2025 14:28:11 +0530
Message-Id: <7121e83e58bfd004d6e0d94e11e3e810b669eb51.1737707712.git.viresh.kumar@linaro.org>
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

It is possible to have a scenario where not all cpufreq policies support
boost frequencies. And letting sysfs (or other parts of the kernel)
enable boost feature for that policy isn't correct.

Now that all drivers (that required a change) are updated to set the
policy->boost_supported properly, check this flag before enabling boost
feature for a policy.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8b0754b506fa..1e6ab42b405f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -631,6 +631,9 @@ static ssize_t store_local_boost(struct cpufreq_policy *policy,
 	if (!cpufreq_driver->boost_enabled)
 		return -EINVAL;
 
+	if (!policy->boost_supported)
+		return -EINVAL;
+
 	if (policy->boost_enabled == enable)
 		return count;
 
@@ -1586,7 +1589,8 @@ static int cpufreq_online(unsigned int cpu)
 		policy->cdev = of_cpufreq_cooling_register(policy);
 
 	/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
-	if (policy->boost_enabled != cpufreq_boost_enabled()) {
+	if (policy->boost_supported &&
+	    policy->boost_enabled != cpufreq_boost_enabled()) {
 		policy->boost_enabled = cpufreq_boost_enabled();
 		ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);
 		if (ret) {
@@ -2822,6 +2826,9 @@ static int cpufreq_boost_trigger_state(int state)
 
 	cpus_read_lock();
 	for_each_active_policy(policy) {
+		if (!policy->boost_supported)
+			continue;
+
 		policy->boost_enabled = state;
 		ret = cpufreq_driver->set_boost(policy, state);
 		if (ret) {
-- 
2.31.1.272.g89b43f80a514


