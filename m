Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87934DFB98
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 04:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfJVCZO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 22:25:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42513 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfJVCZO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 22:25:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id f14so8967492pgi.9
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 19:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b7R0jpCoBOrrhcXAwPBls/opcu6DyfBOiyKCvmQcYDE=;
        b=dgXXAXc8wmNKaoX7CcLHcKCDDs9zfWHGkc/6P1imYO+MGf7tIvzuw9JIpK2ov9CviP
         iTGZ3tqodJ0Db7qDp0fM3DdYhL6vFNdaOrQAifq86gC7d3drgOxzIb6kZwqWytkgXBjd
         HPMDGIEF7itXwQLx0byCjhjOrLEiMtzIHliMSfLzQthLg0Za+aI8Zp27SFUZT/qxSIew
         NGHtJP3sx/9vRyJQIB7sp+LfEkyJL9RdJ++r9zUn+buoQEzD1sPAAB28WMODHIaYN44M
         TJsOGMcqVCFrRD44PLtxdd5hFF66zpSkkudVxDpF7W5Kj4K1PmqvpZN+PqWFpLSdOf8K
         0NPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b7R0jpCoBOrrhcXAwPBls/opcu6DyfBOiyKCvmQcYDE=;
        b=pZxIVrfLIuxkOAXSp2BVtsXyoMarV8n3hIkxDPb16hwjSNIkQcaC+7WF6fqe1qegok
         Agxrva+79oV2NNQ05Lz0KV0gYQXhwkvGKK/DKAukdm3m0XOXKaJTvHY/IUj/hJVGZ1o9
         jZFWPPYuOgM68Dd0KJgOCvKMopF0oU2KbaNk2EBetQLOh3U+CaCH9eiPz+93UKeum5t0
         pepyqOswl45wmCQJf6zSqQR/eglfoSGCDECdc4w3Qu5tyh16kdQK+EGVw1L+8QBMIegO
         uQN7G1griCs5zCYisorOkliXQgqfjPowfwV0Vk7hoHAW6gqASfOYMx6KgQhyrLlasDN0
         /laA==
X-Gm-Message-State: APjAAAXHDABKyNkvO0sDCVqNgQ4hpk+q3AfMZloZ/Hj4vDsxHl6r2cRV
        e8vSpGSkKhnNvWlJMx8XwnJl4g==
X-Google-Smtp-Source: APXvYqwjG41aQ/fTp5pO2rwcXW53d2nGOCIiy8oYaqL7cNokUf4ZeukAPzrmF0wibT2tb3+2MMg3Cg==
X-Received: by 2002:a62:6404:: with SMTP id y4mr219786pfb.170.1571711113584;
        Mon, 21 Oct 2019 19:25:13 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id k23sm15980776pgi.49.2019.10.21.19.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 19:25:12 -0700 (PDT)
Date:   Tue, 22 Oct 2019 07:55:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rjw@rjwysocki.net
Subject: Re: [PATCH] cpufreq: Move cancelling of policy update work just
 after removing notifiers
Message-ID: <20191022022508.g3ar735237haybxe@vireshk-i7>
References: <20191021132818.23787-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021132818.23787-1-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-10-19, 14:28, Sudeep Holla wrote:
> Commit 099967699ad9 ("cpufreq: Cancel policy update work scheduled before freeing")
> added cancel_work_sync(policy->update) after the frequency QoS were
> removed. We can cancel the work just after taking the last CPU in the
> policy offline and unregistering the notifiers as policy->update cannot
> be scheduled from anywhere at this point.
> 
> However, due to other bugs, doing so still triggered the race between
> freeing of policy and scheduled policy update work. Now that all those
> issues are resolved, we can move this cancelling of any scheduled policy
> update work just after removing min/max notifiers.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Hi Rafael,
> 
> Based on Viresh's suggestion, I am posting a patch to move this
> cancel_work_sync earlier though it's not a must have change.

For me it is :)

> I will leave it up to your preference.
> 
> Regards,
> Sudeep
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 829a3764df1b..48a224a6b178 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1268,6 +1268,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  	freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MIN,
>  				 &policy->nb_min);
>  
> +	/* Cancel any pending policy->update work before freeing the policy. */
> +	cancel_work_sync(&policy->update);
> +
>  	if (policy->max_freq_req) {
>  		/*
>  		 * CPUFREQ_CREATE_POLICY notification is sent only after
> @@ -1279,8 +1282,6 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  	}
>  
>  	freq_qos_remove_request(policy->min_freq_req);
> -	/* Cancel any pending policy->update work before freeing the policy. */
> -	cancel_work_sync(&policy->update);
>  	kfree(policy->min_freq_req);
>  
>  	cpufreq_policy_put_kobj(policy);

Thanks for doing this.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
