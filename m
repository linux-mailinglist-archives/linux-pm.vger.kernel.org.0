Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDBD39D373
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 05:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhFGD3b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Jun 2021 23:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhFGD3a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Jun 2021 23:29:30 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBB5C061766
        for <linux-pm@vger.kernel.org>; Sun,  6 Jun 2021 20:27:29 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id k15so12056997pfp.6
        for <linux-pm@vger.kernel.org>; Sun, 06 Jun 2021 20:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RvJrJ0XY7euO+eidhzQthv58D56gVbJFmIhLbAAQKkE=;
        b=k68m4h5gZBiwW1crjzom3dhfE6vfJhoWEYUvqjpn1j8YEc4V8/D9mnOTEHkYDbOZ6r
         BZka4ZTnUSWbB7zwgpcKTwYrs+sWPupGSOON0cFKaQJmSkByvTz9FSvVpr4/rFPkpWJn
         6apUkGHeQlovEGxKtlNbFDza8VbIJ6kCJmWlWocM1dzrLqf5yB/ub/Eg7qekci8o8cRQ
         0EUC2vCPLJF5g7x36dm1NWaWee7zgmDgtMMbJg1Drug2Zax5bJoOxIQiyRNG1+awkU8B
         9YLrXJ+AD3P6Z+bDAney5fy4HO6ylv0BzGSqiM7MlYKN1Hwzjjzrn5AwxASfNICdUzOi
         6iIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RvJrJ0XY7euO+eidhzQthv58D56gVbJFmIhLbAAQKkE=;
        b=qeOpu2J4fhSDywFCbLeXA1tAyjeY5r8sIlvcrau1Af19RHCSDaB02X1H4644lLNdYM
         n+WY16S+NylxDQ6qx+sWLeb/ppK6qXHnfCPuZ1v7KoLUqo9sSFtTm7UfU2axABc7wJpk
         vXdVSSPsRL4Az7SEu89cp+gBiCWGqACGSRlwHRyq1FLDcNy/W3dGrw0bSy71QTlIdVS8
         Wegxlnnk7BbX0DceTq1jAVeSksLi+akzxEOaoc9+wIMgfvHaLZsgMbDKJaG9LB/iaFTY
         C1GkEoe6WSQJOPPxhK6KAu6FZZPoaqY5wlwEZCUR2BK5Vsrwk/sOZcD7T6K8Lyhmfuzd
         BcPw==
X-Gm-Message-State: AOAM532BW/xRTHjM47VQQkRpBsio5q0JF2RA2NregfAW0USJaCCoTen0
        E09rjGuPo18Qbo4ZS+L2IipKbg==
X-Google-Smtp-Source: ABdhPJxojceEpIFdRg0YIgRTnQd4QZh7XXvWqZEyy79dUZAXAhQ7OjZqNLy8LEY8XCmgkggWa2TQyA==
X-Received: by 2002:a63:5446:: with SMTP id e6mr9816706pgm.73.1623036448487;
        Sun, 06 Jun 2021 20:27:28 -0700 (PDT)
Received: from localhost ([136.185.169.128])
        by smtp.gmail.com with ESMTPSA id w59sm10425127pjj.13.2021.06.06.20.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 20:27:28 -0700 (PDT)
Date:   Mon, 7 Jun 2021 08:57:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hailong Liu <liuhailongg6@163.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hailong Liu <liu.hailong6@zte.com.cn>
Subject: Re: [PATCH] cpufreq: sh: Remove unused linux/sched.h headers
Message-ID: <20210607032726.rolhnshkctluepw2@vireshk-i7>
References: <20210606115828.27020-1-liuhailongg6@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606115828.27020-1-liuhailongg6@163.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-06-21, 19:58, Hailong Liu wrote:
> From: Hailong Liu <liu.hailong6@zte.com.cn>
> 
> Since commit '205dcc1ecbc5(cpufreq/sh: Replace racy task affinity logic)'
> the header <linux/sched.h> is useless in sh-cpufreq.c, so remove it.
> 
> Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
> ---
>  drivers/cpufreq/sh-cpufreq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
> index 0ac265d47ef0..1a251e635ebd 100644
> --- a/drivers/cpufreq/sh-cpufreq.c
> +++ b/drivers/cpufreq/sh-cpufreq.c
> @@ -23,7 +23,6 @@
>  #include <linux/cpumask.h>
>  #include <linux/cpu.h>
>  #include <linux/smp.h>
> -#include <linux/sched.h>	/* set_cpus_allowed() */
>  #include <linux/clk.h>
>  #include <linux/percpu.h>
>  #include <linux/sh_clk.h>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
