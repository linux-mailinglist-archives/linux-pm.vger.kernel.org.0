Return-Path: <linux-pm+bounces-17245-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7639C28CA
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 01:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7774D1F22F72
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 00:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD2553A7;
	Sat,  9 Nov 2024 00:24:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786068F5C;
	Sat,  9 Nov 2024 00:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111862; cv=none; b=s70rhgDisc0WF4Majmk7szjIvqcZmAWASfbrHxCBAkIC5aKfwM4JFRZPkFa3TdT1h6ixYYSMLO89Cis2tNS2/tlEIeYG1/8wgjast0zhWO3CPpWZ92FmrHMmNNY7dcFS+G21MjAem7x5rSnTV3qF+oz/qWduzbo3n5PeATO1MdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111862; c=relaxed/simple;
	bh=mXfTxwr4zocV9lzNyylbEkCLnFBOwyQbvQrLJBGfqJQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=hKS9QbkfMY761sKp73Wmx5Tou6gtP6n1necZrc8G+Ljj9aeXrX8J1hPl709XXIJMZHW6P3fuaQGUC8JbyWpOT1ivZ2NfoOR0y4cu3obTaDuSgDw3250W1olE2iEFIsbbR0UXhq4eKFkrprlvp/JhydWM6nVtfztre4PMFucqcJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AAE3497;
	Fri,  8 Nov 2024 16:24:48 -0800 (PST)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6013C3F66E;
	Fri,  8 Nov 2024 16:24:16 -0800 (PST)
Message-ID: <35e572d9-1152-406a-9e34-2525f7548af9@arm.com>
Date: Sat, 9 Nov 2024 00:24:14 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Pierre Gondois <pierre.gondois@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] sched/cpufreq: Ensure sd is rebuilt for EAS check
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ensure sugov_eas_rebuild_sd() is always called when sugov_init()
succeeds. The out goto initialized sugov without forcing the rebuild.

Previously the missing call to sugov_eas_rebuild_sd() could lead to EAS
not being enabled on boot when it should have been, because it requires
all policies to be controlled by schedutil while they might not have
been initialized yet.

Fixes: e7a1b32e43b1 ("cpufreq: Rebuild sched-domains when removing cpufreq driver")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index c6ba15388ea7..28c77904ea74 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -783,9 +783,8 @@ static int sugov_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto fail;
 
-	sugov_eas_rebuild_sd();
-
 out:
+	sugov_eas_rebuild_sd();
 	mutex_unlock(&global_tunables_lock);
 	return 0;
 
-- 
2.34.1

