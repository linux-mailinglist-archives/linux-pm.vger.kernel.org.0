Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F037211A905
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 11:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfLKKhC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 05:37:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38763 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbfLKKhC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 05:37:02 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so10361832pgm.5
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 02:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ypE33xjQV/xvJGAZCWivOIGTaz+zZc3+WM/gMk54BwY=;
        b=ku5JWRXHY/4veanZyG8iQdHT0kYKtnWrt0lOiJIykUMYt7UpMhO8waPPbxxBj2otrl
         bDgisHUNs9rz9JvoydvEjjQIAbGxuoPj3HVse/aKJEQE9b2yYigFC1JvqXInJ92IvOaO
         sABULdBYbXyovUn5TOaZG/UGWVOX1aW3Qy890mHCEszuZ/BVltf1ZX7sZlSLfdlE3Wzs
         CNZB2w2B4ClFHBAPQf1CVZnPyiGMtJTNpJ692XLwBNj+G7OK6PTQuZxWn4MmfOebuJWw
         FZoL84GO37bX8zZYHpjNncA6n0ObQk804kuvInGOR2q4sunTTT1E2+cVt31xezT6Nx9T
         Lc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ypE33xjQV/xvJGAZCWivOIGTaz+zZc3+WM/gMk54BwY=;
        b=CDVssSgIIVMckNUxPhLZIQyTGC+1ZeB/8NJdWfoFx2LRPoJpAVM9qpGoW98AbpoVML
         NmG79xgFQnUu8Ox2WMhni7U4bJs1B6HfRJxFwZnVhTHVincNyMw2IEsqekKe1jAHrQ1N
         SgJoe+sXxnPg4E5zlHVVpwRnTFK6COFgm6GxpkR/dMxyhYtFB/9QXxIffuwY1zq3hYDo
         wXZS4e+OJaSzAwiWICzqNtuZB76hgojyS7mXo3iJzZOR9e/fLDBlnUNkQLHgNYuBYyCm
         VdxjhoRGK7jCKucpt/Cd1Stv52wPOCZYHWAwljqviaxYE+iD2yp8D430hEU8ntXt4FUI
         +qIw==
X-Gm-Message-State: APjAAAVh5TF+EMdZTmp7umZ2RxCq7W4srDPq65rMnL8VCAjupq5uKVfU
        7CVOxrEN69QFjP+hJzFOoJ2Dmg==
X-Google-Smtp-Source: APXvYqzJJfawC442tcd1C948WInoK6P499lQWD+a+zwnYmrtZja3a1LGlkVe185HjEnQFTF2zWHCoA==
X-Received: by 2002:a63:5f91:: with SMTP id t139mr3243528pgb.185.1576060621746;
        Wed, 11 Dec 2019 02:37:01 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id z10sm2311173pgg.39.2019.12.11.02.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2019 02:37:01 -0800 (PST)
Date:   Wed, 11 Dec 2019 16:06:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: Avoid leaving stale IRQ work items during CPU
 offline
Message-ID: <20191211103658.54pqb4jch3gxvzsv@vireshk-i7>
References: <2691942.bH9KnLg61H@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2691942.bH9KnLg61H@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-12-19, 11:28, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The scheduler code calling cpufreq_update_util() may run during CPU
> offline on the target CPU after the IRQ work lists have been flushed
> for it, so the target CPU should be prevented from running code that
> may queue up an IRQ work item on it at that point.
> 
> Unfortunately, that may not be the case if dvfs_possible_from_any_cpu
> is set for at least one cpufreq policy in the system, because that
> allows the CPU going offline to run the utilization update callback
> of the cpufreq governor on behalf of another (online) CPU in some
> cases.
> 
> If that happens, the cpufreq governor callback may queue up an IRQ
> work on the CPU running it, which is going offline, and the IRQ work
> will not be flushed after that point.  Moreover, that IRQ work cannot
> be flushed until the "offlining" CPU goes back online, so if any
> other CPU calls irq_work_sync() to wait for the completion of that
> IRQ work, it will have to wait until the "offlining" CPU is back
> online and that may not happen forever.  In particular, a system-wide
> deadlock may occur during CPU online as a result of that.
> 
> The failing scenario is as follows.  CPU0 is the boot CPU, so it
> creates a cpufreq policy and becomes the "leader" of it
> (policy->cpu).  It cannot go offline, because it is the boot CPU.
> Next, other CPUs join the cpufreq policy as they go online and they
> leave it when they go offline.  The last CPU to go offline, say CPU3,
> may queue up an IRQ work while running the governor callback on
> behalf of CPU0 after leaving the cpufreq policy because of the
> dvfs_possible_from_any_cpu effect described above.  Then, CPU0 is
> the only online CPU in the system and the stale IRQ work is still
> queued on CPU3.  When, say, CPU1 goes back online, it will run
> irq_work_sync() to wait for that IRQ work to complete and so it
> will wait for CPU3 to go back online (which may never happen even
> in principle), but (worse yet) CPU0 is waiting for CPU1 at that
> point too and a system-wide deadlock occurs.
> 
> To address this problem notice that CPUs which cannot run cpufreq
> utilization update code for themselves (for example, because they
> have left the cpufreq policies that they belonged to), should also
> be prevented from running that code on behalf of the other CPUs that
> belong to a cpufreq policy with dvfs_possible_from_any_cpu set and so
> in that case the cpufreq_update_util_data pointer of the CPU running
> the code must not be NULL as well as for the CPU which is the target
> of the cpufreq utilization update in progress.
> 
> Accordingly, change cpufreq_this_cpu_can_update() into a regular
> function in kernel/sched/cpufreq.c (instead of a static inline in a
> header file) and make it check the cpufreq_update_util_data pointer
> of the local CPU if dvfs_possible_from_any_cpu is set for the target
> cpufreq policy.
> 
> Also update the schedutil governor to do the
> cpufreq_this_cpu_can_update() check in the non-fast-switch
> case too to avoid the stale IRQ work issues.
> 
> Fixes: 99d14d0e16fa ("cpufreq: Process remote callbacks from any CPU if the platform permits")
> Link: https://lore.kernel.org/linux-pm/20191121093557.bycvdo4xyinbc5cb@vireshk-i7/
> Reported-by: Anson Huang <anson.huang@nxp.com>
> Cc: 4.14+ <stable@vger.kernel.org> # 4.14+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
