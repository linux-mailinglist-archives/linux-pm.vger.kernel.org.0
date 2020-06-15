Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542221F9EB5
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 19:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgFORlt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 13:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgFORls (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 13:41:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E77C061A0E
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 10:41:47 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t194so410603wmt.4
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 10:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oY7ZuVvlWCgY01/3kLGR+1QSYIg+ZjHtQqquGW90g1U=;
        b=R3LMWQIId1cQohqf0X5bTssX/ck9Tat9HT9OWIJtTHwUY6SJ0BH8CtiQge02sxzDUq
         D/468yONxMF7MsAlOugNzzC2YJRB8zxxor77YujZujBHqBzigCQA3qHyqsBqBv0L4hSO
         heY6DqIyS4VDmZpZ/dfwO4K6juqvUhQdCcCRjn2P8EmeeiRY68CMIc1mplZLpSV32+Up
         qnKCwRpwuXmELRT8UbaTONcw2qLfz5xjasSz/YKLBfBn26ttGQqeH2+xuaeqngeV8Kj5
         7r1s7iTqSl7egrjPqVKAxy73xUc5TkC0MrMLtFUOCRvhujErEotYGvevMF+1/hS5ISAV
         SOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oY7ZuVvlWCgY01/3kLGR+1QSYIg+ZjHtQqquGW90g1U=;
        b=X0AiTs1YvR1WFcGtmhLZJMtTX57HkgaceYw9KDc/HNkSic9c/7SkFCU98Z0eL175Wj
         KGNYhjcEqHX6eY2A4Cs6nOR8vWzVIZAWsS2i1BWwIrFq40/2kJtzmCVk7/t19RXIaDXZ
         J7vYMgkRLgr6pLygVl1XfTAJvuNyWCberplqANE6mOxmqnb97K05QD8W1SmmPbWltlta
         gYBOjDipqjrJlfQe9+UaG83E+ereuSnW/NQxU4O581NFjGdaqDMsOrI50qLob4ePWRqi
         uZQ16P+sKqMs0PSzIwhhkwXLfsWUS9EFDVqMVr3jOGq0Ale5XaMcgT3Wsdseoq/2N1Bz
         ydqA==
X-Gm-Message-State: AOAM532dPUk5jK+KTrP3AorY/dXsv5j3oDcXA0k5AyUoyzZuFk6MaaWD
        eVIDiV6OSlR5C/DwZSMhcJga7Q==
X-Google-Smtp-Source: ABdhPJxZIkU/7mhMBRsRT52yrMQRtnq6d09FQMcwSh1k29JPx1ndKo/Cpw28q7Mi57mkncpvcG63yA==
X-Received: by 2002:a1c:4857:: with SMTP id v84mr459057wma.96.1592242906131;
        Mon, 15 Jun 2020 10:41:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id a16sm25199304wrx.8.2020.06.15.10.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 10:41:45 -0700 (PDT)
Date:   Mon, 15 Jun 2020 18:41:41 +0100
From:   Quentin Perret <qperret@google.com>
To:     rjw@rjwysocki.net, rafael@kernel.org, viresh.kumar@linaro.org
Cc:     arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        tkjos@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH 2/2] cpufreq: Specify default governor on command line
Message-ID: <20200615174141.GA235811@google.com>
References: <20200615165554.228063-1-qperret@google.com>
 <20200615165554.228063-3-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615165554.228063-3-qperret@google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday 15 Jun 2020 at 17:55:54 (+0100), Quentin Perret wrote:
>  static int cpufreq_init_governor(struct cpufreq_policy *policy)
>  {
>  	int ret;
> @@ -2701,6 +2721,8 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>  
>  	if (driver_data->setpolicy)
>  		driver_data->flags |= CPUFREQ_CONST_LOOPS;
> +	else
> +		cpufreq_get_default_governor();

Looking at this again, it appears that the comment above
cpufreq_parse_governor() confused me a bit -- this needs doing
unconditionally I think.

I'll fix it in v2.

Thanks,
Quentin
