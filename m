Return-Path: <linux-pm+bounces-12167-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF3D950811
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 16:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17753288F63
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 14:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5BE19EEBB;
	Tue, 13 Aug 2024 14:44:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34F51A00EC;
	Tue, 13 Aug 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560253; cv=none; b=VVCvwtYzSoh69ZHHzP3OI1VGD+Mf//xv6oCcgW5YVHMisSpJMhl8+iAkTOYKUEg0SyjiUV2VWSOdmJv77L6NDbqKo9rd/aaZbY+uW/cu/2hYuXhw82grEx81JguWgpAXijUD0i48Wts/2IsOXpssarcv49Ih+Egan4qr+AwDqK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560253; c=relaxed/simple;
	bh=Qlu1HYB7+bT3fSXN4kVOyYR7KHbgSX488+bRZ21T6/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SUgRVFzkuQnNW/IVmHIaj0c9ZIOpLPP67DylfJa5w62HpAKAhDopBTvefWvFH09WOOG7fIt2hDfeem0Ves7rbUn+lKL/OcNsxBHK1wUoIxLiwTlx744grvQR70Ocm++YhEbRskQGG3ZOtWIARaPxAYrupqCxOU974ELD/papBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AEB212FC;
	Tue, 13 Aug 2024 07:44:37 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.84.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F193C3F58B;
	Tue, 13 Aug 2024 07:44:08 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org
Cc: vincent.guittot@linaro.org,
	qyousef@layalina.io,
	peterz@infradead.org,
	daniel.lezcano@linaro.org,
	rostedt@goodmis.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 4/4] sched/cpufreq: Use NSEC_PER_MSEC for deadline task
Date: Tue, 13 Aug 2024 15:43:48 +0100
Message-Id: <20240813144348.1180344-5-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813144348.1180344-1-christian.loehle@arm.com>
References: <20240813144348.1180344-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the sugov deadline task attributes to use the available
definitions to make them more readable.
No functional change.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index eece6244f9d2..43111a515a28 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -654,9 +654,9 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
 		 * Fake (unused) bandwidth; workaround to "fix"
 		 * priority inheritance.
 		 */
-		.sched_runtime	=  1000000,
-		.sched_deadline = 10000000,
-		.sched_period	= 10000000,
+		.sched_runtime	= NSEC_PER_MSEC,
+		.sched_deadline = 10 * NSEC_PER_MSEC,
+		.sched_period	= 10 * NSEC_PER_MSEC,
 	};
 	struct cpufreq_policy *policy = sg_policy->policy;
 	int ret;
-- 
2.34.1


