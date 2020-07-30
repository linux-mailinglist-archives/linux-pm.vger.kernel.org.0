Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B35232ACE
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 06:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgG3EY2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 00:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3EY1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 00:24:27 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF518C0619D4
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 21:24:27 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t15so3495240pjq.5
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 21:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5sgdtYzqTNVnuC7tTThaaFG3wxZ0ZxYzze4AncPyru0=;
        b=GRJbWIVRXQ2chTvOGH7LcET+CS3EqdQ3FE2txXjNJJQd5NhQbwr1Bs1WJV09IAstre
         c7nY+/7bByE/JMUWsVycHako7T8U+8AiWmGitjQiTfsigfC+SrZauFxZd+kdnTKC4o0B
         ctRZULLQjmxvICgTh1WOqrF4pPYw12UCGrqRzCdKTQgBIlmm24e6szM/3PNuK7LqEcpv
         3KhCahzYK/6fpdEyp9hZf65tcY9kSZd/yzFTCljxnTwobIZr05T4p1U6WIFp61VaL9iH
         Cr1FAiKnrYVNWB7omYDjL6h5/REgvSqtYWq2OlLNN0a/DDDciMhCb0NLnRud1FD3iAqs
         c6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5sgdtYzqTNVnuC7tTThaaFG3wxZ0ZxYzze4AncPyru0=;
        b=IMj8+s6JF00/NcCoktM0sss+S4FjnGrZZqM6vF5y32aT6l2t7qF6nK9pXEzPwpQxj/
         I9PyBiFqu7CGG/G2LenmCeu7lp8FrqxNaOnzBokKDPRCXFJT7qRSqVObEjZmz2VbvXXF
         0Lz2gbH/LAdPPwSUQIBfpurWWO7lJpPfrvf2GmeD1OoegfkYOcED8apDljgUN1Gh3IEl
         8RkjO8lTPMK8Jy8KIr+AipCptVuwg2sEz0EVzHk5m4QRIu6zRk9uqOMJQJXT5hdPO/J8
         EBRb24op5DvebSQRtMpb1DKCZ6yafk5VVZG3r3iFxxK+xxgr/xZ1M1LB8H+gj+d0IDBw
         nOpg==
X-Gm-Message-State: AOAM532E4nAmB3bt2lUv0pW6WNtgOvfl2SBqJbNehYfeieAgs1AjCXtL
        CN+GTOJW9O9L9yhL3s/AKXk+wg==
X-Google-Smtp-Source: ABdhPJx1DHAbdahx3DDZViUcA0KPnnf1c9a/fhDZ4VrpcnC85CChhioBJu+ODR5uSLaHF1eR5NILUA==
X-Received: by 2002:a17:902:a713:: with SMTP id w19mr31748049plq.146.1596083067140;
        Wed, 29 Jul 2020 21:24:27 -0700 (PDT)
Received: from localhost ([106.201.14.19])
        by smtp.gmail.com with ESMTPSA id 9sm4158736pfy.177.2020.07.29.21.24.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jul 2020 21:24:26 -0700 (PDT)
Date:   Thu, 30 Jul 2020 09:54:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] arch_topology: disable frequency invariance for
 CONFIG_BL_SWITCHER
Message-ID: <20200730042423.4j22udejluis7blw@vireshk-mac-ubuntu>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-4-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722093732.14297-4-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-07-20, 10:37, Ionela Voinescu wrote:
> +++ b/drivers/base/arch_topology.c
> @@ -27,6 +27,7 @@ __weak bool arch_freq_counters_available(struct cpumask *cpus)
>  }
>  DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
>  
> +#ifndef CONFIG_BL_SWITCHER
>  void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
>  			 unsigned long max_freq)
>  {
> @@ -46,6 +47,7 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
>  	for_each_cpu(i, cpus)
>  		per_cpu(freq_scale, i) = scale;
>  }
> +#endif

I don't really like this change, the ifdef hackery is disgusting and
then we are putting that in a completely different part of the kernel.

There are at least these two ways of solving this, maybe more:

- Fix the bl switcher driver and add the complexity in it (which you
  tried to do earlier).

- Add a cpufreq flag to skip arch-set-freq-scale call.

Rafael ?

-- 
viresh
