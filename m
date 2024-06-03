Return-Path: <linux-pm+bounces-8523-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B86F8D80B7
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 13:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CEC21C21C66
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 11:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE3184D05;
	Mon,  3 Jun 2024 11:15:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from new-mail.astralinux.ru (new-mail.astralinux.ru [51.250.53.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BBA84A51;
	Mon,  3 Jun 2024 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.53.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717413318; cv=none; b=Qp/3UwSp443PTzcc5UmPtdToILNJy6lKo6Brdxeq0otbDDm4AyrZwachw8x/VR4K6z9P03Fm1DoX9e7CBCvVGDyHYfFdv+2sSjaUuh8vci4nyLOjw01Fq7SiG4Renzgcc5BgusemLG9s7x9mkDUDSZWWYCTuGzGqJ1Nja7KFI/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717413318; c=relaxed/simple;
	bh=f0yBKYMqtygn3cVibz3OF+CIlIM/Id+Akw/nJOBq5Es=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ERbFSz+Xj/xgdfWbYkJ1RVo9oiP9i2otyjXrePYjP+Z7VQs54EnEFakOUcn8YjSIli438gC0GGtdc23pB314lEAkLpLsJoHBRVthj9RfJhpz8RA+iVsN7e/D3MO52THkEol+XPT81jjnBJ3mdPDG7lb1QVjDKKammzkZhX8zd7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=51.250.53.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.58])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4Vt9vK2f0bzlW00;
	Mon,  3 Jun 2024 14:08:29 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: Huang Rui <ray.huang@amd.com>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value
Date: Mon,  3 Jun 2024 14:07:41 +0300
Message-Id: <20240603110741.24818-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: -100
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetnhgrshhtrghsihgruceuvghlohhvrgcuoegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeffvddvueehvedvgfeivdeuvdduteeulefgfeehieffgfehtedutdfgveefvdeiheenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedutddrudejjedrvddtrdehkeenucfrrghrrghmpehhvghloheprhgsthgrqdhmshhkqdhlthdquddtiedtiedvrdgrshhtrhgrlhhinhhugidrrhhupdhinhgvthepuddtrddujeejrddvtddrheekmeegtdejtdegpdhmrghilhhfrhhomheprggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheprhgrhidrhhhurghnghesrghmugdrtghomhdprhgtphhtthhopegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhupdhrtghpthhtohepghgruhhthhgrmhdrshhhvghnohihsegrmhgurdgtohhmpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopehpvghrrhihrdihuhgrnhesrg
 hmugdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhgvshhhrdhkuhhmrghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvhgtqdhprhhojhgvtghtsehlihhnuhigthgvshhtihhnghdrohhrgh
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB; Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128, SE: 11.1.12.2210241838, Core engine: 7.00.65.05230, Virus records: 12717933, Updated: 2024-Jun-03 09:24:46 UTC]

cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
and return in case of error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 drivers/cpufreq/amd-pstate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1b7e82a0ad2e..672cb6c280a4 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -621,6 +621,8 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	unsigned long max_perf, min_perf, des_perf,
 		      cap_perf, lowest_nonlinear_perf, max_freq;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	if (!policy)
+		return;
 	struct amd_cpudata *cpudata = policy->driver_data;
 	unsigned int target_freq;
 
@@ -777,6 +779,8 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 static void amd_pstate_update_limits(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	if (!policy)
+		return;
 	struct amd_cpudata *cpudata = policy->driver_data;
 	u32 prev_high = 0, cur_high = 0;
 	int ret;
-- 
2.30.2


