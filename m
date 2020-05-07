Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804D71C9902
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 20:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgEGSKV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 14:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGSKT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 14:10:19 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053A5C05BD43
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 11:10:18 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 11so6680903qkh.7
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 11:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KCzP4bl+LsDIRE9Q4UUvX6EBmJ7sU8y+C6Dq7vCJhH8=;
        b=buLQEpFYJXDRA5yOOUN1Qv439Td9XdcBA8tv5KPRARKKfvPpsCXa/OGiesg1VlmuUi
         blDGxmJsXai8UyPSMxrDHjhxkit77Jj/4ySr1XgMT2k9ikcR9bYF4eRJXN97Oym5x3Mm
         g0d0AdY8/H2rxNvlriy3bU09kZxmXVHdY1EUyAt2D0ICjogDvlWZ8SaS4SxgowHGXnrJ
         zjVYurnBZTOolQWBNn0L3DoWL1ggGFySbJtZJ+WKh6PIs99yIJsX7LyUDI+D5NCruQhp
         XFuqjRQC5gpzIwYswzujFnzxHjlbr+c3SJpXiKKAwAJJz9fqFKP43I56hHQ3byQqbplU
         ujag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KCzP4bl+LsDIRE9Q4UUvX6EBmJ7sU8y+C6Dq7vCJhH8=;
        b=EAnIP0gMfPCWLv1R5qr6AsHDISfraTZq1E3nTJ3J+pF2Yt1oGyOcfRxF0Z0t52YZie
         HDUXlF6hiGHn6cwg376Uc0AqGRbnmK2+pLrCSoLcP6gNQJvqUC2svIW7T0JJo/gkgJK9
         6Vo+IU53Qox7FlrhFNf2Rb1Y1yBps3Ee2taie4MOWVUXpFQ26catJIHl3pVsCDaZ1zGR
         5JvAVUAxtGKCCdOKOdKwt+rHB/RqwY0rdoB/rvH0VN1MxCednxWsHlv12d3mwJlGChVi
         yNYflIPFv9YG56xAtu5wopPWFFAIMsY3cLoUyvrUnpFUsGoOGmhLH1Ur3wHEBNIgW/v4
         Ck0Q==
X-Gm-Message-State: AGi0PubJgUt2V7A8+YGW7IYF2v4EH1M/7zeW5dLSTWTv3JJM/g2yiawd
        fBPNb0X43/9+JgYnlVVq5ofRX+NXu4Yy
X-Google-Smtp-Source: APiQypKQhmCNyPtVGvHVeJln2UQbjcMKFZZasRoGbfH9naq6fFRrNf4dZOwRdFtzNL/pINDfbcBonxYb3hAe
X-Received: by 2002:ad4:50c3:: with SMTP id e3mr13732268qvq.116.1588875017166;
 Thu, 07 May 2020 11:10:17 -0700 (PDT)
Date:   Thu,  7 May 2020 19:09:59 +0100
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Message-Id: <20200507181012.29791-2-qperret@google.com>
Mime-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 01/14] sched: Provide sched_set_deadline()
From:   Quentin Perret <qperret@google.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As all the sched_setscheduler*() exports have been removed, introduce
sched_set_deadline() on the model of sched_set_fifo() to enable modules
to create SCHED_DEADLINE tasks.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 include/linux/sched.h |  2 ++
 kernel/sched/core.c   | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c0da93a26f62..63c8ae7a0dd8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1630,6 +1630,8 @@ extern int sched_setscheduler_nocheck(struct task_struct *, int, const struct sc
 extern void sched_set_fifo(struct task_struct *p);
 extern void sched_set_fifo_low(struct task_struct *p);
 extern void sched_set_normal(struct task_struct *p, int nice);
+extern int sched_set_deadline(struct task_struct *p, u64 runtime, u64 deadline,
+			      u64 period, u64 flags);
 extern int sched_setattr(struct task_struct *, const struct sched_attr *);
 extern int sched_setattr_nocheck(struct task_struct *, const struct sched_attr *);
 extern struct task_struct *idle_task(int cpu);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7324f3b0f8d2..dbaf3f63df22 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5136,6 +5136,23 @@ void sched_set_normal(struct task_struct *p, int nice)
 }
 EXPORT_SYMBOL_GPL(sched_set_normal);
 
+int sched_set_deadline(struct task_struct *p, u64 runtime, u64 deadline,
+		       u64 period, u64 flags)
+{
+	struct sched_attr attr = {
+		.size		= sizeof(struct sched_attr),
+		.sched_policy	= SCHED_DEADLINE,
+		.sched_flags	= flags,
+		.sched_nice	= 0,
+		.sched_priority	= 0,
+		.sched_runtime	= runtime,
+		.sched_deadline = deadline,
+		.sched_period	= period,
+	};
+	return sched_setattr_nocheck(p, &attr);
+}
+EXPORT_SYMBOL_GPL(sched_set_deadline);
+
 static int
 do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
 {
-- 
2.26.2.526.g744177e7f7-goog

