Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C82FDE200
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 04:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfJUCQa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Oct 2019 22:16:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45164 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfJUCQa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Oct 2019 22:16:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1so6757982pgj.12
        for <linux-pm@vger.kernel.org>; Sun, 20 Oct 2019 19:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IrGq2UdphhTDmG1ho0jchaAJKoIiLiViaAzkdU1CW9s=;
        b=dI49xgZuPuMuYo69fAwYszJ3nCvOu9g2JC7WpKGZrRce4G4JupDLxqeMjOaQsnThl0
         AD9djEego/wLJaf5xAV+IpkqRfIBGkJi6GIFmjZNZ56sbjx0fAPXN+KmfhgaUZGj6zm3
         tBzNyzF2TI8hVuuoPRhEXUT9LKFPfh8LKOTdRlyPOC6UbrLN6URzxSSFV1pXd0LRfnX/
         t76wriU7LrXa0Yk0iITQSMywje4y6NjuDNl+lvRk0aIOI+iTLRNZCJ2GRRpK5WGyLQA2
         6x4fJwqZMnwoSH+demJk4XfrNeJ8ApW06cgQAvrizPZxPB5gv4e9AHMgqguHT38prBVZ
         xNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IrGq2UdphhTDmG1ho0jchaAJKoIiLiViaAzkdU1CW9s=;
        b=sMlKyPQ+ntcR1VLHEcjcpXulYToI8TVNMFbjElhXXDD5ga5zhGjMKqVFhb4DTpmX3t
         PMvw4isFO6wW2v+w19qnFAASjSRtujxVFJwPhIUV9pnNxO+W8/nI14IfkwaQwcrR3iLd
         pO/tdfHSiJ1/F86Pty/iH9sTMx/sr9pP1E8od4U22C7VonGpyMQuRSybj8VWOUE4Wz0v
         dDodDmFw+wP3fwtczBN2i7n2i45ujEqYHTrCeT31OHq07lSHDbUI6Mx4IWUjjyfyZ2u2
         CIiBXj8ZTACXc6P7J4YcO3xokjxXZxl/4U94qYM5y8eotHAjpedM8QN2Q8Y87NYIckzk
         fz2w==
X-Gm-Message-State: APjAAAWJg7de42cT5cZmuVGsGo8j4LTSUZgsKNRsVCA3RUt+HXvi8Fbj
        LJrwJf3NPeWx7bPQ7sCTPnEjiQ==
X-Google-Smtp-Source: APXvYqyOUQfF7x4JeeufeRM4Q//aRYMZcHl9s8cqdelQKWF5d/vbhQ7RrQ/FqW8N1ghN9UM9+GRqdQ==
X-Received: by 2002:a17:90a:7f81:: with SMTP id m1mr25237615pjl.92.1571624189037;
        Sun, 20 Oct 2019 19:16:29 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id z25sm14375052pfn.7.2019.10.20.19.16.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Oct 2019 19:16:28 -0700 (PDT)
Date:   Mon, 21 Oct 2019 07:46:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: cancel any pending policy update work
 scheduled before freeing
Message-ID: <20191021021626.piuqcts45ttyaiws@vireshk-i7>
References: <20191018105815.5714-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018105815.5714-1-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-10-19, 11:58, Sudeep Holla wrote:
> Schedules policy update work may end up racing with the freeing of the
> policy and unregistering the driver.
> 
> One possible race is as below where the cpufreq_driver is unregistered
> but the scheduled work gets executed at later stage when cpufreq_driver
> is NULL(i.e. after freeing the policy and driver)
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000001c
> pgd = (ptrval)
> [0000001c] *pgd=80000080204003, *pmd=00000000
> Internal error: Oops: 206 [#1] SMP THUMB2
> Modules linked in:
> CPU: 0 PID: 34 Comm: kworker/0:1 Not tainted 5.4.0-rc3-00006-g67f5a8081a4b #86
> Hardware name: ARM-Versatile Express
> Workqueue: events handle_update
> PC is at cpufreq_set_policy+0x58/0x228
> LR is at dev_pm_qos_read_value+0x77/0xac
> Control: 70c5387d  Table: 80203000  DAC: fffffffd
> Process kworker/0:1 (pid: 34, stack limit = 0x(ptrval))
> 	(cpufreq_set_policy) from (refresh_frequency_limits.part.24+0x37/0x48)
> 	(refresh_frequency_limits.part.24) from (handle_update+0x2f/0x38)
> 	(handle_update) from (process_one_work+0x16d/0x3cc)
> 	(process_one_work) from (worker_thread+0xff/0x414)
> 	(worker_thread) from (kthread+0xff/0x100)
> 	(kthread) from (ret_from_fork+0x11/0x28)
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> v1->v2:
> 	- Dropped check for work_pending as it can still be racy
> 	- Changed from flush_work to cancel_work_sync
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e93cba29fbb2..8ad9c2859841 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1279,6 +1279,8 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  	}
> 
>  	dev_pm_qos_remove_request(policy->min_freq_req);
> +	/* cancel any pending policy->update work before freeing the policy */
> +	cancel_work_sync(&policy->update);
>  	kfree(policy->min_freq_req);
> 
>  	cpufreq_policy_put_kobj(policy);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
