Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847553725C6
	for <lists+linux-pm@lfdr.de>; Tue,  4 May 2021 08:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhEDGXo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 May 2021 02:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhEDGXn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 May 2021 02:23:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEF5C061574
        for <linux-pm@vger.kernel.org>; Mon,  3 May 2021 23:22:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q2so6387260pfh.13
        for <linux-pm@vger.kernel.org>; Mon, 03 May 2021 23:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3YMOpCFwOQ5/oGp7LeUxJXSRhhzJtLuBZ+yX60UEizs=;
        b=s8CZRVn5Ed8r5/QEOgDr4GY8yV//Vi0hk29hzKbvq0omwtbqMcR7+HZTVxzRVVAaER
         TdQYTfiLFSrnUT7j03MJ0nBIVAIvCphiQsRdc4Sew8mplABwCm8/FtoZ9v1YUsiMXs/3
         pQrzsZMSNJt6mZeVgkU8bV8ZFOiUXGh2s6cL4akwV5Hp3G7EcuUakOWgZpwDBt729hAB
         M5jhTr5WsaDcbo7dghmTTrHJKPbQgMjtmJhcWJKHHL90osrxB0Jd7i/h90SwvyAiMNTl
         G7VLYEixDeqPr39aVljR3iTAuppvsR6sZwddhoo235Eobx096b5fR9I3NEuRvXk7QoyK
         VqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3YMOpCFwOQ5/oGp7LeUxJXSRhhzJtLuBZ+yX60UEizs=;
        b=ltOWOLjDOgCgBCrFB4fwjj5aUPHPC4pwl/s4C0SbyxoK9E6qrlBL4xXWJsSEOtTZ6v
         ibuyHxjFRB/EMCWKqreHJrnqlu55D9ygmJRDxCYIlA6WcRWhRKIVEiXY1Kz8kBsAjgB1
         8BIa3vlgEKdvVfP4aAa1QUiUNdHReqJ5dlwPH+cTm/B/dqHk8V+nYV9HS7y4G3gUnfcA
         9wsVUQ1o4r50EyRtbGAWr8kMmSRkFyZTj30OB3f92/d9cop/Rbv5LJAB3aeBisVdmv3J
         R/2ML0FY7NsbwjyYbInEOs5yfp6bp9ai62vJhX7NcmDU4oGmXfL0v6gicQGkMM/fZLfO
         wUKA==
X-Gm-Message-State: AOAM5338aw/c0LljVbVaRaVxnmSXB7hoFU591ZdlqfRRrIA+d2RJaWl4
        7oL0O5dsIOGxgWL4JtyUkdKHOA==
X-Google-Smtp-Source: ABdhPJylRdzZ9avH5dzAfWy33bRGsia12Hqqrc5+RwkWrrh9MEX9sQ9ruwNrm+0A7fwVp/JqYHNEcQ==
X-Received: by 2002:a17:90b:88b:: with SMTP id bj11mr26075603pjb.224.1620109368205;
        Mon, 03 May 2021 23:22:48 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id c13sm11131455pfl.212.2021.05.03.23.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 23:22:47 -0700 (PDT)
Date:   Tue, 4 May 2021 11:52:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: sc520_freq: add 'fallthrough' to one case
Message-ID: <20210504062245.hfn7n7ghm27oxehx@vireshk-i7>
References: <20210503161840.26771-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503161840.26771-1-rdunlap@infradead.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-05-21, 09:18, Randy Dunlap wrote:
> Quieten an implicit-fallthrough warning in sc520_freq.c:
> 
> ../drivers/cpufreq/sc520_freq.c: In function 'sc520_freq_get_cpu_frequency':
> ../include/linux/printk.h:343:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
> ../drivers/cpufreq/sc520_freq.c:43:3: note: in expansion of macro 'pr_err'
>    pr_err("error: cpuctl register has unexpected value %02x\n",
> ../drivers/cpufreq/sc520_freq.c:45:2: note: here
>   case 0x01:
> 
> Fixes: bf6fc9fd2d848 ("[CPUFREQ] AMD Elan SC520 cpufreq driver.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> ---
> Found in linux-next but applies to mainline.
> 
>  drivers/cpufreq/sc520_freq.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20210503.orig/drivers/cpufreq/sc520_freq.c
> +++ linux-next-20210503/drivers/cpufreq/sc520_freq.c
> @@ -42,6 +42,7 @@ static unsigned int sc520_freq_get_cpu_f
>  	default:
>  		pr_err("error: cpuctl register has unexpected value %02x\n",
>  		       clockspeed_reg);
> +		fallthrough;
>  	case 0x01:
>  		return 100000;
>  	case 0x02:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
