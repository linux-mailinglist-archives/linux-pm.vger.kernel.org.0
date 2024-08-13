Return-Path: <linux-pm+bounces-12166-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D53CA95080F
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 16:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948C8288FBF
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 14:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D5F19EEB7;
	Tue, 13 Aug 2024 14:44:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E47719FA8A;
	Tue, 13 Aug 2024 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560250; cv=none; b=Dxa43Yb1g5Udu0qhNTTDyYGDmYvLyW9cTylpsNOv5ReH2xDk5TnZa2DIqPrz0LvZH3VhqDdT4B+EO1iWc+QutHz6EUA4vhJ/+Lhs0Y2ofTFdDjPl3w3ZdW6VwGn9IkHpawBxw/XFC8gX86bpRYiWM/wO+ODhvTbBSj+yMpbYWIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560250; c=relaxed/simple;
	bh=rlTff6BH+S02Z7v6mU3O5SYccXhywjE7llECeO3S+BY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=leEdXgRY0P009pttkywepB6lSRRS9qs8tywXBFhe6LYDLhmPvGAbFhrnXC2OGJiafI6ZT8bilto8IbJJ9YkfhegFBXGzHoLX2MjVzbDdQK1XodRX/u++h0cy99DXfU8szoe20G3UKp8ylLxJycGOCRbTdT/WjPzg/dvqPJTGWt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2081168F;
	Tue, 13 Aug 2024 07:44:33 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.84.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6361F3F58B;
	Tue, 13 Aug 2024 07:44:05 -0700 (PDT)
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
Subject: [PATCH 3/4] cpufreq/cppc: Use NSEC_PER_MSEC for deadline task
Date: Tue, 13 Aug 2024 15:43:47 +0100
Message-Id: <20240813144348.1180344-4-christian.loehle@arm.com>
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

Convert the cppc deadline task attributes to use the available
definitions to make them more readable.
No functional change.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index bafa32dd375d..aff25b598ec4 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -224,9 +224,9 @@ static void __init cppc_freq_invariance_init(void)
 		 * Fake (unused) bandwidth; workaround to "fix"
 		 * priority inheritance.
 		 */
-		.sched_runtime	= 1000000,
-		.sched_deadline = 10000000,
-		.sched_period	= 10000000,
+		.sched_runtime	= NSER_PER_MSEC,
+		.sched_deadline = 10 * NSEC_PER_MSEC
+		.sched_period	= 10 * NSEC_PER_MSEC,
 	};
 	int ret;
 
-- 
2.34.1


