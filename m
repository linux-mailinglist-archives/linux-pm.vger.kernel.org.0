Return-Path: <linux-pm+bounces-28846-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1BAADB7BC
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 19:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900B63B1BC1
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 17:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A25A288518;
	Mon, 16 Jun 2025 17:25:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B92972607;
	Mon, 16 Jun 2025 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750094749; cv=none; b=XbhBml2+j4lip5SlX99w/3Umx06lH8aZ6StNcnL1HHwVoMZCi3EDrX2KlYXQVyF1KLgQKkZJ1r5gxmOcRIecvpfGd3TZY2Py0jdrMuoJHzINpSfyw4JtjhQLA1Gmh4haV1e0ZamtjNLaT0FXN17jWDbCXp/55Wc7lhzXSCF/q04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750094749; c=relaxed/simple;
	bh=QHUx6cKB2rtQdOemSisCWLkC+xiLsWheLFlOwBG+g3Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GeAdDvXzsvGSRNTFzOA7YSSezyjlPQQ2/GjX+9qEsbsWGLl5OPEP+W7wEv0MKUyJgKwDoTd+BQQqXspoAgXlDOARLXxxfAynJpjB8LHayooEXzWj62dDgbvbUjP3gCZMGkbTZIe5yy00JCCiXq2OALS4NlsojM8qcdSsFmiieFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B686114BF;
	Mon, 16 Jun 2025 10:25:24 -0700 (PDT)
Received: from [10.1.30.73] (e127648.arm.com [10.1.30.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 502E33F58B;
	Mon, 16 Jun 2025 10:25:45 -0700 (PDT)
Message-ID: <3cc5b83b-f81c-4bd7-b7ff-4d02db4e25d8@arm.com>
Date: Mon, 16 Jun 2025 18:25:43 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, zhenglifeng1@huawei.com
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] cpufreq: Fix initialization with disabled boost
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The boost_enabled early return in policy_set_boost() caused
the boost disabled at initialization to not actually set the
initial policy->max, therefore effectively enabling boost while
it should have been enabled.

Fixes: 27241c8b63bd ("cpufreq: Introduce policy_set_boost()")
Reported-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d7426e1d8bdd..e85139bd0436 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1630,7 +1630,7 @@ static int cpufreq_online(unsigned int cpu)
 	 */
 	if (cpufreq_driver->set_boost && policy->boost_supported &&
 	    (new_policy || !cpufreq_boost_enabled())) {
-		ret = policy_set_boost(policy, cpufreq_boost_enabled());
+		ret = cpufreq_driver->set_boost(policy, cpufreq_boost_enabled());
 		if (ret) {
 			/* If the set_boost fails, the online operation is not affected */
 			pr_info("%s: CPU%d: Cannot %s BOOST\n", __func__, policy->cpu,
-- 
2.34.1

