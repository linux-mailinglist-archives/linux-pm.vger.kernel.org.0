Return-Path: <linux-pm+bounces-41016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD13D32F24
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 15:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADD90304E8BA
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 14:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FFB394480;
	Fri, 16 Jan 2026 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUnnY7SK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82294394469;
	Fri, 16 Jan 2026 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575191; cv=none; b=lvVUPb0CIzyF7pu9PaJxCMaCwIxrqSL5u7qZT3WRBLbvXlMvwfirzLkItc+jNQn5+c+DK9Duv3oeXYfw6lOlieqCINX2QQ5JmgeqJ+Vw9z8hvzO413rLlWGIQCYKMXMjusbNGGPSvUhWUKNSZqjWs7yZINm3OZBCL0Eqmn7labc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575191; c=relaxed/simple;
	bh=TzrKoRirKu2E+jAiuhlzsln8JBhROUV36dDGy9tKFsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoKRgsphjvgq1vvRKGW7EKP4fS904kY+Bcnm4m+bsXGEnNqw5Xrf4QI01cZwUN+Z6ykuPCZ9WFzm0ABA+Qw4deG2Kj+WPPW39TpGDWht8CoBURnsCRyWFMpa76OSzJUd7oKi85xolKthrbps3gNEcPH1xwfoR/Zy9loYU7+HxkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUnnY7SK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A0FC19421;
	Fri, 16 Jan 2026 14:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768575191;
	bh=TzrKoRirKu2E+jAiuhlzsln8JBhROUV36dDGy9tKFsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUnnY7SK3ALhVTftF+V//K5xP8H7lrjkEswZ+U2Y2mPJfJsD3b2iS1zkZM/21hkDb
	 otcvgtr3VNOsAa5lRYT6msuhiOEdltnRqueCWPAs3RmlhuxjPkj0MoZRyQYXkCVkp+
	 EEa529KqpaVkr3RPuZTwr5AB9LQEXD1IOjZhct9kLv/VlIEdQtP5Pg0qGxOgAtdzuG
	 zKl2D/2NbJb9yEWBpc2c6pyOL9cKpOdjPb072dxVwl4v4i2PACLu684MJTdcq35VeG
	 yuc16NjatOamu0X8Rn+5hd5bF/GzfXEYSr+6rWj9yP9o2l3izkMwerxfrSQRHI6L2Y
	 YEhsuz1tKeRPA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>,
	linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/15] cpufreq: ondemand: Simplify idle cputime granularity test
Date: Fri, 16 Jan 2026 15:52:00 +0100
Message-ID: <20260116145208.87445-8-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260116145208.87445-1-frederic@kernel.org>
References: <20260116145208.87445-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpufreq calls get_cpu_idle_time_us() just to know if idle cputime
accounting has a nanoseconds granularity.

Use the appropriate indicator instead to make that deduction.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/cpufreq/cpufreq_ondemand.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index a6ecc203f7b7..2d52ee035702 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -334,17 +334,12 @@ static void od_free(struct policy_dbs_info *policy_dbs)
 static int od_init(struct dbs_data *dbs_data)
 {
 	struct od_dbs_tuners *tuners;
-	u64 idle_time;
-	int cpu;
 
 	tuners = kzalloc(sizeof(*tuners), GFP_KERNEL);
 	if (!tuners)
 		return -ENOMEM;
 
-	cpu = get_cpu();
-	idle_time = get_cpu_idle_time_us(cpu, NULL);
-	put_cpu();
-	if (idle_time != -1ULL) {
+	if (tick_nohz_enabled) {
 		/* Idle micro accounting is supported. Use finer thresholds */
 		dbs_data->up_threshold = MICRO_FREQUENCY_UP_THRESHOLD;
 	} else {
-- 
2.51.1


