Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6FBDEA22
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 12:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfJUK4E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 06:56:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32990 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfJUK4D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 06:56:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so8224593pfl.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 03:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wF1+8YZQPASjCzMnoxagVtf09QEbjdj0mZoAlrVP5Cs=;
        b=LMChVAZfWEwWAiP/W1Lpr/Cx13RyxCKmAavy8ARHSE4X1bKwsHSOjkhCrrk7dHU5uK
         MCnnOrefKvNyBpX1eeKrTQF+yTBqFuHYojitYoMR56/2y8GZhU8/zWMgweVVc873sN9N
         1vEQMgvMCqicCakx/fhau0P2MFX2vzXWq3jkcu4taXakMKDfvp5OlA9Wzmt2f+D9Xkx4
         f1TjJZfyHyWrvvN3X0wx2BOOzi/o3DydEymPA2Y/LynPyBatfsmGoTCP1PV5iplm0rrx
         aiu2+O1aHTKTv9MbqnKXQr3LbUw2fvIZ996Q+YyrTm7X4kW9D61ycInxcVzyk1Hvg/Np
         km3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wF1+8YZQPASjCzMnoxagVtf09QEbjdj0mZoAlrVP5Cs=;
        b=QIUGtjt3OOfWZ0RKAVgjUZn4DsrKa55cggMgZT6TGUFzzt9nvcWMWVe62/FATDC5nr
         cIMRDY3qD5uFp35kGvmrgIoFBKuJw545jajhk0w0zQX3bG6Agee9xtwIfx78pgfYXfEG
         NAckF+D/Giy0xeIs2CUHluGtsLgP6Kcrg31o6MqJ11T26K37xdFt79h/9LF4lcoV0CVE
         nGRywXnCfe4YtYdav/BAtI/BWWCa3erE0qg10No8vicGR0pCwYamCjo3ghUVFonj7H+f
         vwbyeAGu8czbXV70uUul4dp+hq8emPrwbi7eeATK5Z/eGcRbts3eeqY2kMkFQ3T9QjDr
         MmIQ==
X-Gm-Message-State: APjAAAX2YD37cSVhNitSDBXy46zy5tMeELTAplGMsyg5EBsylOu4khtP
        Ntd0m0PqIDmlMOYElo6/bK4o9Q==
X-Google-Smtp-Source: APXvYqxtkhlEHrd59Xgs4FPY7IgW8ANyk/EGhMAMJhBaYKDI8tISB5wQrYi5RgTUkoGiQD3QnsJCmQ==
X-Received: by 2002:a17:90a:35a5:: with SMTP id r34mr26976603pjb.40.1571655362925;
        Mon, 21 Oct 2019 03:56:02 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id y17sm22150159pfo.171.2019.10.21.03.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 03:56:02 -0700 (PDT)
Date:   Mon, 21 Oct 2019 16:25:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: flush any pending policy update work scheduled
 before freeing
Message-ID: <20191021105559.fqmf3pcvxxeh2ote@vireshk-i7>
References: <20191017163503.30791-1-sudeep.holla@arm.com>
 <20191018060247.g5asfuh3kncoj7kl@vireshk-i7>
 <20191018101924.GA25540@bogus>
 <4881906.zjS51fuFuv@kreacher>
 <20191018110632.GB25540@bogus>
 <20191021021551.bjhf74zeyuqcl4w3@vireshk-i7>
 <20191021102730.GA21581@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021102730.GA21581@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-10-19, 11:27, Sudeep Holla wrote:
> I just tested now with today's linux-pm/bleeding-edge branch.
> And even if I move cancel_work_sync just after freq_qos_remove_notifier,
> it works fine now. It was not the case on Friday.
> 
> Is that what you wanted to check or something else ?
> 
> Regards,
> Sudeep
> 
> -->8
> 
> diff --git i/drivers/cpufreq/cpufreq.c w/drivers/cpufreq/cpufreq.c
> index 829a3764df1b..48a224a6b178 100644
> --- i/drivers/cpufreq/cpufreq.c
> +++ w/drivers/cpufreq/cpufreq.c
> @@ -1268,6 +1268,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>         freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MIN,
>                                  &policy->nb_min);
> 
> +       /* Cancel any pending policy->update work before freeing the policy. */
> +       cancel_work_sync(&policy->update);
> +
>         if (policy->max_freq_req) {
>                 /*
>                  * CPUFREQ_CREATE_POLICY notification is sent only after
> @@ -1279,8 +1282,6 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>         }
> 
>         freq_qos_remove_request(policy->min_freq_req);
> -       /* Cancel any pending policy->update work before freeing the policy. */
> -       cancel_work_sync(&policy->update);
>         kfree(policy->min_freq_req);
> 
>         cpufreq_policy_put_kobj(policy);

Yes, send a incremental patch for that. Thanks.

-- 
viresh
