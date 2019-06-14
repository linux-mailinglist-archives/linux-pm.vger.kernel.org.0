Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08BD3464DF
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 18:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfFNQqs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 12:46:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42628 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfFNQqs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 12:46:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id l19so1852724pgh.9
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2019 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yf8AaZQCzwIcFoIppyOptGSt+yOTkl5BeJ2O0ErAtlY=;
        b=nivcbY2W2jCDywDVEROgcoel9+RmuFM394rEuAbBkZ7FmgB7YDOPVzzaN7/vWluvCJ
         znwydKoHFp4gR4cXxVA70LSg1seuu8YKkPKfmw5Ito8FLP6jEmeEkeVJqUvqQP2+uxJR
         ZZj0r9za8esEvab9jQ2IMJJJwGSRhTKCsE56E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yf8AaZQCzwIcFoIppyOptGSt+yOTkl5BeJ2O0ErAtlY=;
        b=oN0WjyPQRWb9XgZfscuzLoZzBwk86NQe8C+KgYLwbt4WDONfO+5kP5OBD5UoUItXn0
         IMAP4J62z5O2/IDgJ3xbaqCjj/slSvvlSFNYKBZRY1MyPB8wAQU2Y8rpE8GHtaV9woLN
         H3a0XyXjVGkZUSwZT6seOdRSVNkTAQEJ/eaBdCN0f6WsoDi+ShRN+MFkXIy6SxwhJytw
         AahTLv0XYexFXeXC+wexYeJPic1nYP3L1YQw2C1YlrSBNPxbetGpcQvhQuNRM8pnykZ+
         gfhFODmU8SAwEa+VZFv1tUsGdK/pXSGnip+Ik5SimSvNy3fiknqqUTet8p7C9uzLVJTp
         7M8g==
X-Gm-Message-State: APjAAAVVbVGFQ5iE8WoeMtjewCN99mdxIoEWQkHhP+Uh92YWniw8EqnE
        CbFLA9EvcEtFHBl4N8d1JaVGBw==
X-Google-Smtp-Source: APXvYqyXMk7ZfP/0d6oGbg9M5RURFbm0kAH8HF/iLk/DodByjVz3Pz9UAhRTisfbR4mQaLnDr6PceQ==
X-Received: by 2002:a17:90a:bd8c:: with SMTP id z12mr12174873pjr.60.1560530807697;
        Fri, 14 Jun 2019 09:46:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f21sm3487102pjq.2.2019.06.14.09.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 09:46:47 -0700 (PDT)
Date:   Fri, 14 Jun 2019 09:46:41 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/5] cpufreq: Register notifiers with the PM QoS
 framework
Message-ID: <20190614164641.GP137143@google.com>
References: <cover.1560163748.git.viresh.kumar@linaro.org>
 <a275fdd9325f1b2cba046c79930ad59653674455.1560163748.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a275fdd9325f1b2cba046c79930ad59653674455.1560163748.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Mon, Jun 10, 2019 at 04:21:35PM +0530, Viresh Kumar wrote:
> This registers the notifiers for min/max frequency constraints with the
> PM QoS framework. The constraints are also taken into consideration in
> cpufreq_set_policy().
> 
> This also relocates cpufreq_policy_put_kobj() as it is required to be
> called from cpufreq_policy_alloc() now.
> 
> No constraints are added until now though.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 139 +++++++++++++++++++++++++++++++-------
>  include/linux/cpufreq.h   |   4 ++
>  2 files changed, 120 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 85ff958e01f1..547d221b2ff2 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -26,6 +26,7 @@
>  #include <linux/kernel_stat.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/pm_qos.h>
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
>  #include <linux/syscore_ops.h>
> @@ -1126,11 +1127,77 @@ static void handle_update(struct work_struct *work)
>  	cpufreq_update_policy(cpu);
>  }
>  
> +static void cpufreq_update_freq_work(struct work_struct *work)
> +{
> +	struct cpufreq_policy *policy =
> +		container_of(work, struct cpufreq_policy, req_work);
> +	struct cpufreq_policy new_policy = *policy;
> +
> +	/* We should read constraint values from QoS layer */
> +	new_policy.min = 0;
> +	new_policy.max = UINT_MAX;
> +
> +	down_write(&policy->rwsem);
> +
> +	if (!policy_is_inactive(policy))
> +		cpufreq_set_policy(policy, &new_policy);
> +
> +	up_write(&policy->rwsem);
> +}
> +
> +static int cpufreq_update_freq(struct cpufreq_policy *policy)
> +{
> +	schedule_work(&policy->req_work);

I think you need to add a cancel_work_sync() in cpufreq_policy_free()
to make sure the work doesn't run after the policy has been freed.

Otherwise it looks good to me.

Cheers

Matthias
