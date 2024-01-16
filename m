Return-Path: <linux-pm+bounces-2239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D01CD82E4C7
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jan 2024 01:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656DF1C2142F
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jan 2024 00:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD051F951;
	Tue, 16 Jan 2024 00:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhFa56fb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8CB1F947;
	Tue, 16 Jan 2024 00:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD1BC433C7;
	Tue, 16 Jan 2024 00:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364048;
	bh=wxnk5sJ9XHCVsUQUHVqrsA+mZ7kc2ZJnQdVJwyUkK1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LhFa56fbnRrIcTCS5qwkE+YI+/dXGjdm6h0StlNudwNWgpa+PQ5Rzf8G7rTPOtHei
	 LAJZ1Ek6VwKetyOHVPTYdteRMKum3afMua5ewbSUo2Lwmr11z+WcjVqFUv6obxnnMM
	 uJoRcg3rPg1gGVsWDEZbvsrKrKABIE6/QdZ6eS81CL6UTaQ+y4Ml0Jnwxtsl+eDANZ
	 6INmCNuEdrZyhx29OlQax9R/ojzm1QH4mFMnGqG2xgqakMuyVF2BlpE0vZ+lx0zFAi
	 0U1Kmi3g7a9v5DuF3gRNt9PiybjcOCW1IPKQzLCEwWJwDLlZ2u9NHCM5voKWE6457i
	 z+cpD6ZY6X92A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mukesh Ojha <quic_mojha@quicinc.com>,
	Joyyoung Huang <huangzaiyang@oppo.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sasha Levin <sashal@kernel.org>,
	kyungmin.park@samsung.com,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 12/14] PM / devfreq: Synchronize devfreq_monitor_[start/stop]
Date: Mon, 15 Jan 2024 19:13:38 -0500
Message-ID: <20240116001347.213328-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001347.213328-1-sashal@kernel.org>
References: <20240116001347.213328-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Mukesh Ojha <quic_mojha@quicinc.com>

[ Upstream commit aed5ed595960c6d301dcd4ed31aeaa7a8054c0c6 ]

There is a chance if a frequent switch of the governor
done in a loop result in timer list corruption where
timer cancel being done from two place one from
cancel_delayed_work_sync() and followed by expire_timers()
can be seen from the traces[1].

while true
do
        echo "simple_ondemand" > /sys/class/devfreq/1d84000.ufshc/governor
        echo "performance" > /sys/class/devfreq/1d84000.ufshc/governor
done

It looks to be issue with devfreq driver where
device_monitor_[start/stop] need to synchronized so that
delayed work should get corrupted while it is either
being queued or running or being cancelled.

Let's use polling flag and devfreq lock to synchronize the
queueing the timer instance twice and work data being
corrupted.

[1]
...
..
<idle>-0    [003]   9436.209662:  timer_cancel   timer=0xffffff80444f0428
<idle>-0    [003]   9436.209664:  timer_expire_entry   timer=0xffffff80444f0428  now=0x10022da1c  function=__typeid__ZTSFvP10timer_listE_global_addr  baseclk=0x10022da1c
<idle>-0    [003]   9436.209718:  timer_expire_exit   timer=0xffffff80444f0428
kworker/u16:6-14217    [003]   9436.209863:  timer_start   timer=0xffffff80444f0428  function=__typeid__ZTSFvP10timer_listE_global_addr  expires=0x10022da2b  now=0x10022da1c  flags=182452227
vendor.xxxyyy.ha-1593    [004]   9436.209888:  timer_cancel   timer=0xffffff80444f0428
vendor.xxxyyy.ha-1593    [004]   9436.216390:  timer_init   timer=0xffffff80444f0428
vendor.xxxyyy.ha-1593    [004]   9436.216392:  timer_start   timer=0xffffff80444f0428  function=__typeid__ZTSFvP10timer_listE_global_addr  expires=0x10022da2c  now=0x10022da1d  flags=186646532
vendor.xxxyyy.ha-1593    [005]   9436.220992:  timer_cancel   timer=0xffffff80444f0428
xxxyyyTraceManag-7795    [004]   9436.261641:  timer_cancel   timer=0xffffff80444f0428

[2]

 9436.261653][    C4] Unable to handle kernel paging request at virtual address dead00000000012a
[ 9436.261664][    C4] Mem abort info:
[ 9436.261666][    C4]   ESR = 0x96000044
[ 9436.261669][    C4]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 9436.261671][    C4]   SET = 0, FnV = 0
[ 9436.261673][    C4]   EA = 0, S1PTW = 0
[ 9436.261675][    C4] Data abort info:
[ 9436.261677][    C4]   ISV = 0, ISS = 0x00000044
[ 9436.261680][    C4]   CM = 0, WnR = 1
[ 9436.261682][    C4] [dead00000000012a] address between user and kernel address ranges
[ 9436.261685][    C4] Internal error: Oops: 96000044 [#1] PREEMPT SMP
[ 9436.261701][    C4] Skip md ftrace buffer dump for: 0x3a982d0
...

[ 9436.262138][    C4] CPU: 4 PID: 7795 Comm: TraceManag Tainted: G S      W  O      5.10.149-android12-9-o-g17f915d29d0c #1
[ 9436.262141][    C4] Hardware name: Qualcomm Technologies, Inc.  (DT)
[ 9436.262144][    C4] pstate: 22400085 (nzCv daIf +PAN -UAO +TCO BTYPE=--)
[ 9436.262161][    C4] pc : expire_timers+0x9c/0x438
[ 9436.262164][    C4] lr : expire_timers+0x2a4/0x438
[ 9436.262168][    C4] sp : ffffffc010023dd0
[ 9436.262171][    C4] x29: ffffffc010023df0 x28: ffffffd0636fdc18
[ 9436.262178][    C4] x27: ffffffd063569dd0 x26: ffffffd063536008
[ 9436.262182][    C4] x25: 0000000000000001 x24: ffffff88f7c69280
[ 9436.262185][    C4] x23: 00000000000000e0 x22: dead000000000122
[ 9436.262188][    C4] x21: 000000010022da29 x20: ffffff8af72b4e80
[ 9436.262191][    C4] x19: ffffffc010023e50 x18: ffffffc010025038
[ 9436.262195][    C4] x17: 0000000000000240 x16: 0000000000000201
[ 9436.262199][    C4] x15: ffffffffffffffff x14: ffffff889f3c3100
[ 9436.262203][    C4] x13: ffffff889f3c3100 x12: 00000000049f56b8
[ 9436.262207][    C4] x11: 00000000049f56b8 x10: 00000000ffffffff
[ 9436.262212][    C4] x9 : ffffffc010023e50 x8 : dead000000000122
[ 9436.262216][    C4] x7 : ffffffffffffffff x6 : ffffffc0100239d8
[ 9436.262220][    C4] x5 : 0000000000000000 x4 : 0000000000000101
[ 9436.262223][    C4] x3 : 0000000000000080 x2 : ffffff889edc155c
[ 9436.262227][    C4] x1 : ffffff8001005200 x0 : ffffff80444f0428
[ 9436.262232][    C4] Call trace:
[ 9436.262236][    C4]  expire_timers+0x9c/0x438
[ 9436.262240][    C4]  __run_timers+0x1f0/0x330
[ 9436.262245][    C4]  run_timer_softirq+0x28/0x58
[ 9436.262255][    C4]  efi_header_end+0x168/0x5ec
[ 9436.262265][    C4]  __irq_exit_rcu+0x108/0x124
[ 9436.262274][    C4]  __handle_domain_irq+0x118/0x1e4
[ 9436.262282][    C4]  gic_handle_irq.30369+0x6c/0x2bc
[ 9436.262286][    C4]  el0_irq_naked+0x60/0x6c

Link: https://lore.kernel.org/all/1700860318-4025-1-git-send-email-quic_mojha@quicinc.com/
Reported-by: Joyyoung Huang <huangzaiyang@oppo.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/devfreq/devfreq.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 474d81831ad3..195e045aa731 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -461,10 +461,14 @@ static void devfreq_monitor(struct work_struct *work)
 	if (err)
 		dev_err(&devfreq->dev, "dvfs failed with (%d) error\n", err);
 
+	if (devfreq->stop_polling)
+		goto out;
+
 	queue_delayed_work(devfreq_wq, &devfreq->work,
 				msecs_to_jiffies(devfreq->profile->polling_ms));
-	mutex_unlock(&devfreq->lock);
 
+out:
+	mutex_unlock(&devfreq->lock);
 	trace_devfreq_monitor(devfreq);
 }
 
@@ -483,6 +487,10 @@ void devfreq_monitor_start(struct devfreq *devfreq)
 	if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
 		return;
 
+	mutex_lock(&devfreq->lock);
+	if (delayed_work_pending(&devfreq->work))
+		goto out;
+
 	switch (devfreq->profile->timer) {
 	case DEVFREQ_TIMER_DEFERRABLE:
 		INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
@@ -491,12 +499,16 @@ void devfreq_monitor_start(struct devfreq *devfreq)
 		INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
 		break;
 	default:
-		return;
+		goto out;
 	}
 
 	if (devfreq->profile->polling_ms)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
+
+out:
+	devfreq->stop_polling = false;
+	mutex_unlock(&devfreq->lock);
 }
 EXPORT_SYMBOL(devfreq_monitor_start);
 
@@ -513,6 +525,14 @@ void devfreq_monitor_stop(struct devfreq *devfreq)
 	if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
 		return;
 
+	mutex_lock(&devfreq->lock);
+	if (devfreq->stop_polling) {
+		mutex_unlock(&devfreq->lock);
+		return;
+	}
+
+	devfreq->stop_polling = true;
+	mutex_unlock(&devfreq->lock);
 	cancel_delayed_work_sync(&devfreq->work);
 }
 EXPORT_SYMBOL(devfreq_monitor_stop);
-- 
2.43.0


