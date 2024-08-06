Return-Path: <linux-pm+bounces-11937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C54BD9491C8
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 15:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7858A1F220A1
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 13:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C05D1D2F59;
	Tue,  6 Aug 2024 13:41:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A150019F464;
	Tue,  6 Aug 2024 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951702; cv=none; b=DbdMblr+2kWmAQxvLr3WkQUi6h+pWImQQ/za3pnuvT2QROZR7kMzZ7OdOQNVG3U+SfFGwnQE3Aq2aHiqNAyYiejpV/Rzc2DR6cY+dRpvQThXzpazpfOZLWIYg47Zx5TjSaYOs3JB1cPgxMh0YRVViwvsD35YU49OhBRInsUGAyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951702; c=relaxed/simple;
	bh=otlxXCTvS0KqqXV501/OYYMjUI/xwQcBceHDk7ITyWU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=iXIBGAsK4rcuBW3eAyD3L+T6LDBlv1umrB9FG/2ZBXxLP2NHNDs7XrrrtnYQ++ZsleILXKpW5IHcvnvH+aKpObtsQxTe4kBq0on5wn2xC27vbfdDXTUYxckE1N6Bk93INmTBdOnJs6F/c0pUdxT+smZdtZkS++1/zUEep/Lr9Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADD5AFEC;
	Tue,  6 Aug 2024 06:42:05 -0700 (PDT)
Received: from [10.1.34.37] (e127648.arm.com [10.1.34.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB66C3F86F;
	Tue,  6 Aug 2024 06:41:38 -0700 (PDT)
Message-ID: <3c726cf5-0c94-4cc6-aff0-a453d840d452@arm.com>
Date: Tue, 6 Aug 2024 14:41:36 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Qais Yousef <qyousef@layalina.io>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] sched/cpufreq: Use USEC_PER_SEC for deadline task
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert the sugov deadline task attributes to use the available
definitions to make them more readable.
No functional change.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index eece6244f9d2..012b38a04894 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -654,9 +654,9 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
 		 * Fake (unused) bandwidth; workaround to "fix"
 		 * priority inheritance.
 		 */
-		.sched_runtime	=  1000000,
-		.sched_deadline = 10000000,
-		.sched_period	= 10000000,
+		.sched_runtime	= USEC_PER_SEC,
+		.sched_deadline = 10 * USEC_PER_SEC,
+		.sched_period	= 10 * USEC_PER_SEC,
 	};
 	struct cpufreq_policy *policy = sg_policy->policy;
 	int ret;
-- 
2.34.1

