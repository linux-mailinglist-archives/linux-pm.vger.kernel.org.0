Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64EA1C98FA
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 20:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgEGSLI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 14:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728410AbgEGSKh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 14:10:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA20C05BD43
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 11:10:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s8so7933814ybj.9
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 11:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4lcduyr6+J6gjW9QNJps5OFAxCiY2gXgkQhtQfZmlTA=;
        b=cEOQlfEVMyYdUWmraiQv6868nByrpJRpaaymVgBwUTg6wEdgwdIVUponU3hyLSlvTp
         5fiab1SKPl//PLD9mpej/wjBU00SMNMDS/A6fS41QZb3XHBzUwGFrYDzviO9ErMIFElp
         LwjjpHOlYW87TavxsSdPCcg22n61ccvSbxkoFAZDeYUmjLjjj4SVs55GP1gwTD4sufrO
         1E+2tAPiEMo1TUE9sizh8TCAFsd4mfShxMp1rSgIjvOIDptPPsdc8eHYXWVvI/Knbn3T
         e3CUlcs//sah/3XJ5uIYx6vHAdrtdPm6R0cTeDtF/EcwT6CcWJezEkkN2nUm9CU5LFel
         gO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4lcduyr6+J6gjW9QNJps5OFAxCiY2gXgkQhtQfZmlTA=;
        b=rxyE+tLSMDZiEqvN9IhCmJleoPyVFqe29pYGDPVFBMopYWmMsSjMkgrDxNxXSlFDRT
         Db6o46cchhXkyT0+YwuBqkd2rZoK3FLlEOk4H7g8zcKoyMLGLF0+wVMiIEE5u2Ia6kya
         Q0gne3wnZl4SA2GuoBUXiF6Iw6E11UyqMRbkE6Jm0Xn1aaPh6w6xxm4KTS1tRVjDzyLD
         qn4IDn8XIPB9szg5iO526uMD5fiIY3Z+GZqSyoeR+41U4p2G93ItKYHc3V/B+6fbb+wG
         PRKZXWX2HA3H/z1+T+zn/8TouPleXVVRsm1r0Og8LWaurTUBMwxB1pHD/rMcYVmo7nwt
         XgWg==
X-Gm-Message-State: AGi0PubP1dgduL+cfGMjaFcE/aZCpxXzqEtkVuKXFUnzr4qlM09oe5EK
        XXjM0e8pH+p3NchJFuMduq5JpI9ynlAv
X-Google-Smtp-Source: APiQypJPdsp8s/0FJ9HkF1hHrjGbTTy5ACV7cG92EmYwZKI6DWKFrz6S0o0PVs9GwAJo3DvMiOded7dIskOr
X-Received: by 2002:a5b:707:: with SMTP id g7mr13422225ybq.489.1588875036707;
 Thu, 07 May 2020 11:10:36 -0700 (PDT)
Date:   Thu,  7 May 2020 19:10:08 +0100
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Message-Id: <20200507181012.29791-11-qperret@google.com>
Mime-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 10/14] sched/fair: Export cpu_util_freq()
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
 kernel/sched/fair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dadf0a060abe..b7b43aeff969 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6488,6 +6488,7 @@ unsigned long cpu_util_freq(int cpu, unsigned long max)
 {
 	return aggregate_cpu_util(cpu, cpu_util(cpu), max, FREQUENCY_UTIL, NULL);
 }
+EXPORT_SYMBOL_GPL(cpu_util_freq);
 
 /*
  * Predicts what cpu_util(@cpu) would return if @p was migrated (and enqueued)
-- 
2.26.2.526.g744177e7f7-goog

