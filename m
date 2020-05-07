Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881671C98E7
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 20:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgEGSKe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 14:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728279AbgEGSKd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 14:10:33 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502C2C05BD43
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 11:10:33 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id v18so7681672qtq.22
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 11:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9OhNNPOR5bOJXqrXgYTR/z4ZLcIw94c7qBlgw12zehM=;
        b=ge96F09XdFsFsB5dYM9NSm1hEwRKTOm6LHBDxv4p756JWp8TiB91WkCmvrH5GpJ7ID
         R1VU3A76KGfuijtfRH6+xrVKU0ddCaeLZF07G8RQYkl68nCxyTdIXIQfY4W8gRGhbCod
         azIuW5jjVQqpdZInIkwMQBSRaUjl5Tu+cNcP1+KoCyvyGrxIzqKulY0Gn7TkwjziZ94Z
         BtRbwdywx5zzFJCVKWdH20zAP5GXCNqJLhSfhYgDYP5/Mm28PlWHVX30Ju4SOsih1iTY
         7kpSk4677XwaHJJbNtMj+FUeOaemVnGoLjxIK5A4BsQxJR1aZ0j9uqW/oOpFjoP7CYkq
         VN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9OhNNPOR5bOJXqrXgYTR/z4ZLcIw94c7qBlgw12zehM=;
        b=EN/SaTlmYGcl+httFDxTdGR1JI6DrXXsvTiJAOjOF9UOPjrGdq9Hw+v212KF8u4MCe
         LKPlt2YT0ywI8YZhBH/4H33RmP48DR/x4kUdYRF7i4+9+bo+4n/QyEAj0WM7l32+7yew
         ZDRxgrbT2fEYqzOZpngjNqNSvdgv7BQAGMUcGJE9hxfOTiX4ohz8UO4er1C3Y/AI9Uyw
         7AlwPmCTtckT+rusM5G0s9Ch1JPOiBxZSAplbgPttUki9+5J07aRRSFDwrQazxvHURN7
         hRoQNTyfCym/QHalkduLqewdLc3ZgZV92LN6vKtaroVQBTt1Cn752EeqILjV2iUbesCn
         LNag==
X-Gm-Message-State: AGi0Pub+pL+HW173tqu0mgXNVnmgqYn2NWPBk1PhlhXYVS8ac3M2KIkG
        myD26XtfhTSCAF18rfzpwcllhFL9+46Z
X-Google-Smtp-Source: APiQypIiwLV5BbE0n5CUQvk0QJA7FNWdGbxWcAUCqDJsE+LSuluk52+DrvUSh3DwGlH7tJ6FU4zi3lidRXSp
X-Received: by 2002:a0c:f50a:: with SMTP id j10mr13910437qvm.172.1588875032506;
 Thu, 07 May 2020 11:10:32 -0700 (PDT)
Date:   Thu,  7 May 2020 19:10:06 +0100
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Message-Id: <20200507181012.29791-9-qperret@google.com>
Mime-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 08/14] sched/core: Export runqueues per-cpu array
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

It will be needed by schedutil once modularized, export it.

Signed-off-by: Quentin Perret <qperret@google.com>
---
This is only needed for cpu_rq() -> cpu_bw_dl() in schedutil, so there is
probably an alternative if exporting this isn't desirable.
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dbaf3f63df22..537eb45b4274 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -36,6 +36,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+EXPORT_SYMBOL_GPL(runqueues);
 
 #if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
 /*
-- 
2.26.2.526.g744177e7f7-goog

