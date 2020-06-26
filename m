Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B3020AA84
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 04:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgFZCxt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 22:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgFZCxt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 22:53:49 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6E8C08C5DB
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 19:53:49 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cv18so1151297pjb.1
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2020 19:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OE2Vo0qG83iB7BMo6JAJNv84RiXgGFQgXdTAJPIwfFc=;
        b=cld7GXxLM80Gcp9eugoMDXHxz/hjT0bnh0DaxZN5lsxVfByA91/he+oQFCAt9j+qcT
         0QJCW0YGkoXAmN2lJZ8Vrjbs3mS5nj+5u0dIAVohlo5Lhw90FN0s+cp1v8GSTPAlcdF2
         tXXDtkIEjHRUonv7SK4Wdhxb5i2197fZ4WdtVoo4eEhvg4F5KQw2zobB+mGPK8VPUdn0
         m9EBR9D6JPLnx/J0OzRt52gGu5OGYVJTqonbfd/FL8zVLi0zP1Z+aiXjZixqmPD1TRUJ
         Tkvnc+DtPbUOG094aIDb3j1liAbmH7dv1zXH+gZUktDQT9A4P6rGR3O1YFSJ9KmS1oJM
         6bPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OE2Vo0qG83iB7BMo6JAJNv84RiXgGFQgXdTAJPIwfFc=;
        b=ZzpynepiljUyzY628Kd84EgGZpnBOKYCS7t1xQow+/KEtckHFHsBAUPHOdepdMwfIv
         9MOysz3T91YsNHaoB6l7gafo8HKc8SaMqJ6pq03WkgL96TybfYzMjbuOecieC+COx9Zz
         gROoWnP4HThlJIUz5Mdw/88GoD8BKhaEF1HG7Jlqa/4oN67JnQkruwRx7FWe/ea0HRlf
         g/FXAvMAvuHYOO+IsqA/ECT4kgbfNtj9ByudxzqrZIg6LDVNlarT4J4S2NSgMz1uirzv
         BIy1snzHYdIiWnSB3DVzNBbQZQdRbYD6RQlmFEvZmo4xQMm8K2s/9lMXpwHAstFNqY0v
         ag3w==
X-Gm-Message-State: AOAM531B5gQOIIGBCIVG6lJV014PnU+OFQMLTObCNjdHWXxi6zMTB/1e
        JHKyrqHQB8xbF6YQQzBAd/uiyg==
X-Google-Smtp-Source: ABdhPJzC8gnl+ASvdyCwQjS7mvY7SDXrNT8HJFNc3QUXgxsHMb+BJL+HfBNqpOHWdy26y6bBKheJkw==
X-Received: by 2002:a17:90b:3685:: with SMTP id mj5mr1095889pjb.162.1593140028573;
        Thu, 25 Jun 2020 19:53:48 -0700 (PDT)
Received: from localhost ([122.172.127.76])
        by smtp.gmail.com with ESMTPSA id fv7sm5997431pjb.22.2020.06.25.19.53.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2020 19:53:47 -0700 (PDT)
Date:   Fri, 26 Jun 2020 08:23:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     rjw@rjwysocki.net, rafael@kernel.org, arnd@arndb.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH v2 2/2] cpufreq: Specify default governor on command line
Message-ID: <20200626025346.z3g3ikdcin56gjlo@vireshk-i7>
References: <20200623142138.209513-1-qperret@google.com>
 <20200623142138.209513-3-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623142138.209513-3-qperret@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-06-20, 15:21, Quentin Perret wrote:
> @@ -2789,7 +2796,13 @@ static int __init cpufreq_core_init(void)
>  	cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
>  	BUG_ON(!cpufreq_global_kobject);
>  
> +	mutex_lock(&cpufreq_governor_mutex);
> +	if (!default_governor)

Also is this check really required ? The pointer will always be NULL
at this point, isn't it ?

> +		default_governor = cpufreq_default_governor();
> +	mutex_unlock(&cpufreq_governor_mutex);
> +
>  	return 0;
>  }
>  module_param(off, int, 0444);
> +module_param_string(default_governor, cpufreq_param_governor, CPUFREQ_NAME_LEN, 0444);
>  core_initcall(cpufreq_core_init);
> -- 
> 2.27.0.111.gc72c7da667-goog

-- 
viresh
