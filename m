Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61D6019CFEE
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 07:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbgDCFs5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 01:48:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40540 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbgDCFs5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2020 01:48:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id c20so2963670pfi.7
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2020 22:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lEuCnG1hC7hkoMeTpMkJ0ZOk4ZF8anIyWsJ+Bib4RJ0=;
        b=HWMgdrTg/4e1ihpCNZekctF8+royp5qDM1p33E2eOKXySwQQ2En/uDVttrXIAyWHaL
         PMnfwUshIQSoDhv/c1zJNKTVJN9UVnmvJCxLtoYn3RBZ/Ah6EKigavNaC/AYLBlR36d6
         em4RzAE/FtI5uPKmSEjXsKn13EI1pf1mUHwVDBjNb7f1xBzqQbewdm8onbDSNakKaYPF
         +EMx1Rw2WYwNFg6ue8MwGd4ZU4CASY/6/tVzjrR1ydQqtEeVdACUnXKGal2lx+G8W4bQ
         fyDVXBKuUP2MvaZPbRJ24tclCtRaVSudXvULkDSTV3WWvh6hVot/cHda+m6ucwNoV7ZO
         QO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lEuCnG1hC7hkoMeTpMkJ0ZOk4ZF8anIyWsJ+Bib4RJ0=;
        b=FoiOsuLQOkQQw/6MMM+pKTMRQxwE2Q/16brdlDwyVl6Rgu11pmAaz3WxjZYqJW9JPq
         grec8EQTEexaWyhGA6Rm235aj1q8FE4XrhSAES3DHjpcPmcR8fI9gDrQBqDyExzbm/fL
         FykSDDE0jXrHk/2/Tu4KNIFSysCQyTELT7vINCQbXrmqf+ZKAqhBkvC4lbVxBSai1EZt
         qbfyiHo541JhoxwfyDOvAJpY91EpLtrB4HDzqmt3L2ewhK52+C3qoPwTV2xQSGtIHWdj
         tWNuRgIO352I9zTzfRpgMfSY1XjSwP0K1BbxcqpEzRriiQ7Vun0W/Or+bex1a6re7F7c
         SIIg==
X-Gm-Message-State: AGi0PuYDvg6dGgmisKDgpUZcdganpCttfdVWd6zksy0iPN8SfcDIENet
        OK67qRLagy/j73xwFxy/cr6mBA==
X-Google-Smtp-Source: APiQypKsdkC9AIQMLLAQSU0jy4LZoi7FwFTrBBdJUcSopHnRoHBK/wTF3hx/pHxFe0Cc1gfYJ2khhw==
X-Received: by 2002:a63:230f:: with SMTP id j15mr4139593pgj.393.1585892934786;
        Thu, 02 Apr 2020 22:48:54 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id p22sm4646330pgn.73.2020.04.02.22.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 22:48:54 -0700 (PDT)
Date:   Fri, 3 Apr 2020 11:18:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cpufreq: Select schedutil when using big.LITTLE
Message-ID: <20200403054852.cx5sv27kt7wjgfa5@vireshk-i7>
References: <20200402080239.7471-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402080239.7471-1-linus.walleij@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-04-20, 10:02, Linus Walleij wrote:
> When we are using a system with big.LITTLE HMP
> configuration, we need to use EAS to schedule the
> system.
> 
> As can be seen from kernel/sched/topology.c:
> 
>  "EAS can be used on a root domain if it meets all the following conditions:
>   1. an Energy Model (EM) is available;
>   2. the SD_ASYM_CPUCAPACITY flag is set in the sched_domain hierarchy.
>   3. no SMT is detected.
>   4. the EM complexity is low enough to keep scheduling overheads low;
>   5. schedutil is driving the frequency of all CPUs of the rd;"
> 
> This means that at the very least, schedutil needs to be
> available as a scheduling policy for EAS to work on these
> systems. Make this explicit by defaulting to the schedutil
> governor if BIG_LITTLE is selected.
> 
> Currently users of the TC2 board (like me) has to figure these
> dependencies out themselves and it is not helpful.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/cpufreq/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index bff5295016ae..873aefd96cf2 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -36,6 +36,7 @@ config CPU_FREQ_STAT
>  
>  choice
>  	prompt "Default CPUFreq governor"
> +	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if BIG_LITTLE
>  	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1100_CPUFREQ || ARM_SA1110_CPUFREQ
>  	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
>  	help

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
