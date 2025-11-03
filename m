Return-Path: <linux-pm+bounces-37292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA488C2B857
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 12:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284243A4566
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 11:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2353016F1;
	Mon,  3 Nov 2025 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8txxgeY"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF7B2DF133
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170560; cv=none; b=FyEd9wxAhSJHGDLZ+A4j6w15XN6RSl1SLcRGY2MJtoxLteL7RlC8rcVECrUXtSP4/UBZCie8blMmxFCpZ5lsOtHMgJyX1gmpDSFdoHHUvIINWmsZnd5K8RXmMiEcXG2HOVqEvluTRyTG1T/cINox67+CKByBLfhYORzWmu7/rH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170560; c=relaxed/simple;
	bh=99Cdm2xqhFv1TOcXhfqNfoTQPsNfZb6mquTYm2Xo5zM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hwJOeoZDV7Z/65c8Zqe9v+4wD6DHMO6B449QMdkMPomV09QHPMMhzfwDgGSw+ydngnlj4X6hb9v/nLaE+CzAJOwbZ0Qz5OjYlgtpWAusxVuFYN2zbapkRCjfF1jsiAvAx9aCSVATNE/jqawlFtBEu5SH2I9x6TVyAE/NcJTVmL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8txxgeY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762170557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=tTmPrRw3fEIfzQPvEP/RXlZxAzYt65ZwvfVe0Qlyb50=;
	b=H8txxgeYvIKpViseTKbTlMXU0UZZ/w36KLx2B9AxH6wSlVtqbjrACKtE5DWpDGJ5CjplID
	SlkfnK7DKTt5qJkR+YMzglXNAUu7GF3SVBg2IS30Hh6cWE5BDBoZWLJe/C6O4IoDyxad17
	ld0zBb8D7C1xVXGDsfxXSjfSSaOnxdw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-ciON35-PMg-I1x7hEd-ggg-1; Mon,
 03 Nov 2025 06:49:16 -0500
X-MC-Unique: ciON35-PMg-I1x7hEd-ggg-1
X-Mimecast-MFC-AGG-ID: ciON35-PMg-I1x7hEd-ggg_1762170555
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F2F119560B5;
	Mon,  3 Nov 2025 11:49:14 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDB0E180057E;
	Mon,  3 Nov 2025 11:49:12 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id C228E400ECC26; Mon,  3 Nov 2025 08:48:14 -0300 (-03)
Date: Mon, 3 Nov 2025 08:48:14 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3] sched/idle: disable tick in idle=poll idle entry 
Message-ID: <aQiWfnnSzxsnwa2o@tpad>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111


Commit a5183862e76fdc25f36b39c2489b816a5c66e2e5
("tick/nohz: Conditionally restart tick on idle exit") allows
a nohz_full CPU to enter idle and return from it with the
scheduler tick disabled (since the tick might be undesired noise).

The idle=poll case still unconditionally restarts the tick when entering
idle.

To reduce the noise for that case as well, stop the tick when entering
idle, for the idle=poll case.

Change tick_nohz_full_kick_cpu to set NEED_RESCHED bit, to handle the
case where a new timer is added from an interrupt. This breaks out of
cpu_idle_poll and rearms the timer if necessary.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---

v3: Add comment with proper explanation (Frederic Weisbecker)
    Add signed-off-by			(Thomas Gleixner)
v2: Handle the case where a new timer is added from an interrupt (Frederic Weisbecker)

 include/linux/sched.h    |    2 ++
 kernel/sched/core.c      |   10 ++++++++++
 kernel/sched/idle.c      |    2 +-
 kernel/time/tick-sched.c |    7 +++++++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index cbb7340c5866..1f6938dc20cd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2428,4 +2428,6 @@ extern void migrate_enable(void);
 
 DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
 
+void set_tif_resched_if_polling(int cpu);
+
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f1ebf67b48e2..f0b84600084b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -988,6 +988,11 @@ static bool set_nr_if_polling(struct task_struct *p)
 	return true;
 }
 
+void set_tif_resched_if_polling(int cpu)
+{
+	set_nr_if_polling(cpu_rq(cpu)->idle);
+}
+
 #else
 static inline bool set_nr_and_not_polling(struct thread_info *ti, int tif)
 {
@@ -999,6 +1004,11 @@ static inline bool set_nr_if_polling(struct task_struct *p)
 {
 	return false;
 }
+
+void set_tif_resched_if_polling(int cpu)
+{
+	set_tsk_need_resched(cpu_rq(cpu)->idle);
+}
 #endif
 
 static bool __wake_q_add(struct wake_q_head *head, struct task_struct *task)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index c39b089d4f09..428c2d1cbd1b 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -324,7 +324,7 @@ static void do_idle(void)
 		 * idle as we know that the IPI is going to arrive right away.
 		 */
 		if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
-			tick_nohz_idle_restart_tick();
+			tick_nohz_idle_stop_tick();
 			cpu_idle_poll();
 		} else {
 			cpuidle_idle_call();
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c527b421c865..9ec51da49591 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -408,6 +408,13 @@ void tick_nohz_full_kick_cpu(int cpu)
 	if (!tick_nohz_full_cpu(cpu))
 		return;
 
+	/*
+	 * When idle=poll, with the tick disabled (therefore idle CPU looping
+	 * at cpu_idle_poll), if a new timer is added from an interrupt,
+	 * the cpu_idle_poll only exits when TIF_NEED_RESCHED gets set.
+	 */
+	set_tif_resched_if_polling(cpu);
+
 	irq_work_queue_on(&per_cpu(nohz_full_kick_work, cpu), cpu);
 }
 


