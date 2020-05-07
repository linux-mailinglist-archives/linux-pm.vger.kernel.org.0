Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9D01C98E1
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 20:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgEGSKV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 14:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726864AbgEGSKU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 14:10:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5312AC05BD0A
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 11:10:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z1so4234848ybm.5
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 11:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=509wYnGQ2ll8bD7lPJSFtG4McPi0txJLxy0qvSv45Lo=;
        b=ZhFfVBNHUmUmHvR6RS1KKWKRBbqh0HTuUO7pHTeDUaozng1hAAZP9tIZ+8LZTZaau7
         Z9IyHFYhb7tm2qWuEnfRILjVtXmrBUI68g930iuEC9carHiDuqJM0Q8hbwRfrYJOnMHr
         Mgiip6Sbjhz8csT4cQrv1o7W+McWrcFK2dCkrjLjttEyhQx5tBY2nv25d94p8HinQY69
         bAq4kIJxs93uzLLprZ68fwclQpsOnpw9wzY5nEva6p8IaoAzV2FXlO1YO17homT1jj9v
         rUVm+1XOYjBQxScTdPenOUF48W1umyG+mIMEcfc8/IR/gUNAJXBdT9qI0TFZ+veEPlea
         yjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=509wYnGQ2ll8bD7lPJSFtG4McPi0txJLxy0qvSv45Lo=;
        b=NGQrvWw4Pu+CZawj+GfRsRKRdB1a0IRXKaGZitbE8wtobWCeF4AEsb7Xh/E7GNOfPl
         hFkRd9Qkqte+wiuBHH/RNyBjy6gBSSd1cx4zF+/QyPLKUTUeWMHlSP4nqhzdh4xhjxxh
         7MUXoVfCjCbP24nwsHpnAFprpUqeSb1lHQZolys4SxzObpEtSWQ5B/FrI2y5pLscD9zq
         1Rz6fMHTDThcOq49+tZ1BHU/WWF935nGCNe3svCd06ZBne+l43HP8FXZ2rebH3dZlqwc
         A4JuQswyUKDJawtWV6v88b8FwX/bgGi1XRzgGZNkDIRWAsJ9IcIPIU2ZBd1rv02NYHzM
         9OPg==
X-Gm-Message-State: AGi0PuZ1cPKg++RIc9PIvUuz6e8xUUUT7x5Q9sQ2FqNeaNHXa5kw0kO/
        /dcmmko3leWpS6sMYnNaKeTHz/BF5U4m
X-Google-Smtp-Source: APiQypJlZZ0Nv+hjKxeI5eVTKF6u8iZstKbYl+urYr+Vc4mwMoSpMjoTwgcq1KFh3BK9+P30QwuTBkg0l1kn
X-Received: by 2002:a25:bb49:: with SMTP id b9mr26834376ybk.172.1588875019348;
 Thu, 07 May 2020 11:10:19 -0700 (PDT)
Date:   Thu,  7 May 2020 19:10:00 +0100
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Message-Id: <20200507181012.29791-3-qperret@google.com>
Mime-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 02/14] sched: cpufreq: Use sched_set_deadline() from sugov
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

sched_set_deadline() is an exported symbol, use it instead of
sched_setattr_nocheck() to elevate the sugov kthreads to DL.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 kernel/sched/cpufreq_schedutil.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 7fbaee24c824..ebd5d30f0861 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -654,20 +654,6 @@ static void sugov_policy_free(struct sugov_policy *sg_policy)
 static int sugov_kthread_create(struct sugov_policy *sg_policy)
 {
 	struct task_struct *thread;
-	struct sched_attr attr = {
-		.size		= sizeof(struct sched_attr),
-		.sched_policy	= SCHED_DEADLINE,
-		.sched_flags	= SCHED_FLAG_SUGOV,
-		.sched_nice	= 0,
-		.sched_priority	= 0,
-		/*
-		 * Fake (unused) bandwidth; workaround to "fix"
-		 * priority inheritance.
-		 */
-		.sched_runtime	=  1000000,
-		.sched_deadline = 10000000,
-		.sched_period	= 10000000,
-	};
 	struct cpufreq_policy *policy = sg_policy->policy;
 	int ret;
 
@@ -685,7 +671,9 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
 		return PTR_ERR(thread);
 	}
 
-	ret = sched_setattr_nocheck(thread, &attr);
+	/* Fake (unused) bandwidth; workaround to "fix" priority inheritance. */
+	ret = sched_set_deadline(thread, 1000000, 10000000, 10000000,
+				 SCHED_FLAG_SUGOV);
 	if (ret) {
 		kthread_stop(thread);
 		pr_warn("%s: failed to set SCHED_DEADLINE\n", __func__);
-- 
2.26.2.526.g744177e7f7-goog

