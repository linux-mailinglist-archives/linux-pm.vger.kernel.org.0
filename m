Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437AC1C98FB
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 20:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgEGSLK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 14:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728378AbgEGSKf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 14:10:35 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F56BC05BD43
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 11:10:35 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id z8so7691231qtu.17
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 11:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DfxtwXI8P8XYrWM5eaBon+8Miqx9tOiiT4uA5B/D10w=;
        b=VpHuDRD3x1EhaaRdJqrnbGTDyAXQO4MFmWH4pJHMS83w4ots6AXYPEFxqNMMm0qGZZ
         LFiJv4ekcAnYvmWhZGt06rYb+pN3owdaJPkkA/v0FeipJzuCvO10Jb/MwaRjTeMpt0UK
         t6OHkQnPhqLt4WpxTiuixQRnYh3LpnTulmrdKdCtsaeKYAPgKRqF1C8RLaT24hBj1j2E
         S/unIaQOkLs2Ga8pAx0Cwv8mml64n8ey3EGv0ST710vZNEz0elcR+8XMAJN+flMjlgMj
         LlOaEL39pa1UbV7CYf+18zzWcQVX3r4JyfjV9YIq/bFHDirTQUipLCaJ7glZdREobAiC
         JkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DfxtwXI8P8XYrWM5eaBon+8Miqx9tOiiT4uA5B/D10w=;
        b=nLRpoN14lgL2TZ8gP4tDEWEf9Wa3yCEmh6TJ77Zru8fwlpXVlzxQ6BYARxaDPt7xEu
         zg+bRBo2mm5p7XRIyy3J3Z+vgzLzAah0lZm0JcaX3wRNs2HxrsHtdMJRd8lpCI6OA8kj
         ssepNtZCHwilgtfMHjoH8t2wI702K1U3EE5NKNhShKZLMD5pEhdCxfZELfM3Gk6h51ta
         sinXtdNDZGWxOsTLS+olQOzSktyhMUk1bgETC25h7zlJ8LcFyhkw1alFMdU90gm/RQbh
         lbKIZmkYR3RsEg/mtLey4Y42jTMo42R1lA2g7XybDZ2+cS72Ku8O2Jp72gkG+DtcFSBQ
         VUQg==
X-Gm-Message-State: AGi0PuYK2AEEqxYmkgQBLmWmbNzwb9iV+3iBxOiTJojv2IRf2WwlPjZV
        mCtYH/5IyCFL7roTvXvfnJFlqCCB137l
X-Google-Smtp-Source: APiQypISczuWnNG4La/XG2W8nFH7JeUZ2tqgh5D3kd/vIRdYL3gah5ZjsGOiYjkD93PCI2ZdBobicL9VO7GJ
X-Received: by 2002:a05:6214:15d1:: with SMTP id p17mr15021011qvz.45.1588875034647;
 Thu, 07 May 2020 11:10:34 -0700 (PDT)
Date:   Thu,  7 May 2020 19:10:07 +0100
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Message-Id: <20200507181012.29791-10-qperret@google.com>
Mime-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 09/14] sched/cpufreq: Export cpufreq_this_cpu_can_update()
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
 kernel/sched/cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index 82f2dda61a55..f4abe4e4e927 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -75,6 +75,7 @@ bool cpufreq_this_cpu_can_update(struct cpufreq_policy *policy)
 		(policy->dvfs_possible_from_any_cpu &&
 		 rcu_dereference_sched(*this_cpu_ptr(&cpufreq_update_util_data)));
 }
+EXPORT_SYMBOL_GPL(cpufreq_this_cpu_can_update);
 
 #ifdef CONFIG_ENERGY_MODEL
 extern bool sched_energy_update;
-- 
2.26.2.526.g744177e7f7-goog

