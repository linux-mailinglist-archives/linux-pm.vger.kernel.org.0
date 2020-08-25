Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9642511E0
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 08:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgHYGED (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 02:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728805AbgHYGED (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 02:04:03 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE8FC061574
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 23:04:03 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nv17so676906pjb.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 23:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j6FEjnx7PaimSRrvrozgKYaPtn/SFhcnkbYcPW36XLg=;
        b=p6T3Focr93ouZkmdLVz/SoOb0+bPLw1NHJB09nzp0GY4q40NpzUs7tJvMy0+PKhiMJ
         LnJ9l/p6zB3J6wvU715eAWiJLvLwWYskvSd3upNiPNFBbRvixg/m3pCHWOyLGcKnU7k4
         nvZGTw30p6IsdJ9W1UNw8+BkiBczelkgNf+S10SXKFTqbIR3e32QqIkbJKetHDsZZmGC
         ++5/JUNJ5sE674VUVsUrXLotNFqT6gkXNJFCpdBIAFpmII8xm22OtWmmWxlKDCNMTD55
         GwXqlIaVxGgYHufBeL3mG2OOUtDyWiELn3fC9QCt41AWXj/PiMnc5qvdqKCtt25msY31
         KyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j6FEjnx7PaimSRrvrozgKYaPtn/SFhcnkbYcPW36XLg=;
        b=r6BtDUEPshKzv3HCz6RUrKjodIPWsMHmJY/UbJF7LhUK2u8xyBII6jketQUIFgfA8n
         Kxv/dUbjT8K0619BJPAbHhsVNbaAJQAlAbG1ELrSGBl2MhgN0vDd6Ji0JZqGwZI0hMvu
         AcIVhs/kDBmwbW3SuzVqicNAOXZNtG7uqYAj6v1dppjRLiy/ny9hwRUKG1aEKXLjBHEa
         lEi1XLOJQbdUxPPMoEjCGaRxiCZRZTLwickhf9dqhvXId0YBm6NoASY1Bbk6xUns6s6U
         a1oOEhcJ0VToAFafkQn5M4KbLtca+AB0kY8xm4E74TzdwqUdpQ2CeakAdHr4GR9+4YK6
         WDAQ==
X-Gm-Message-State: AOAM5330XOJXPZ1KbBlKrg1mlAa105V3t7K6pSPs8lXM7lRCk/dP2oeR
        1ziA1JGGNoGU/GqW6Yw6AlkMsQ==
X-Google-Smtp-Source: ABdhPJyZ+OEKLubiI1wEvFDF9H9Vf+Wr3UBGzlkTTh7kt7lwA9ceWdtWRoYesX7q9QVxmW8MDraiXg==
X-Received: by 2002:a17:90a:9c3:: with SMTP id 61mr304355pjo.191.1598335441898;
        Mon, 24 Aug 2020 23:04:01 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id q5sm11548209pgv.1.2020.08.24.23.04.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 23:04:01 -0700 (PDT)
Date:   Tue, 25 Aug 2020 11:33:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] cpufreq: move invariance setter calls in cpufreq
 core
Message-ID: <20200825060359.mrhou4pwrzmfq23n@vireshk-i7>
References: <20200824210252.27486-1-ionela.voinescu@arm.com>
 <20200824210252.27486-3-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824210252.27486-3-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-08-20, 22:02, Ionela Voinescu wrote:
> To properly scale its per-entity load-tracking signals, the task scheduler
> needs to be given a frequency scale factor, i.e. some image of the current
> frequency the CPU is running at. Currently, this scale can be computed
> either by using counters (APERF/MPERF on x86, AMU on arm64), or by
> piggy-backing on the frequency selection done by cpufreq.
> 
> For the latter, drivers have to explicitly set the scale factor
> themselves, despite it being purely boiler-plate code: the required
> information depends entirely on the kind of frequency switch callback
> implemented by the driver, i.e. either of: target_index(), target(),
> fast_switch() and setpolicy().
> 
> The fitness of those callbacks with regard to driving the Frequency
> Invariance Engine (FIE) is studied below:
> 
> target_index()
> ==============
> Documentation states that the chosen frequency "must be determined by
> freq_table[index].frequency". It isn't clear if it *has* to be that
> frequency, or if it can use that frequency value to do some computation
> that ultimately leads to a different frequency selection. All drivers
> go for the former, while the vexpress-spc-cpufreq has an atypical
> implementation which is handled separately.
> 
> Therefore, the hook works on the assumption the core can use
> freq_table[index].frequency.
> 
> target()
> =======
> This has been flagged as deprecated since:
> 
>   commit 9c0ebcf78fde ("cpufreq: Implement light weight ->target_index() routine")
> 
> It also doesn't have that many users:
> 
>   gx-suspmod.c:439:       .target = cpufreq_gx_target,
>   s3c24xx-cpufreq.c:428:  .target = s3c_cpufreq_target,
>   intel_pstate.c:2528:    .target = intel_cpufreq_target,
>   cppc_cpufreq.c:401:     .target = cppc_cpufreq_set_target,
>   cpufreq-nforce2.c:371:  .target = nforce2_target,
>   sh-cpufreq.c:163:       .target = sh_cpufreq_target,
>   pcc-cpufreq.c:573:      .target = pcc_cpufreq_target,
> 
> Similarly to the path taken for target_index() calls in the cpufreq core
> during a frequency change, all of the drivers above will mark the end of a
> frequency change by a call to cpufreq_freq_transition_end().
> 
> Therefore, cpufreq_freq_transition_end() can be used as the location for
> the arch_set_freq_scale() call to potentially inform the scheduler of the
> frequency change.
> 
> This change maintains the previous functionality for the drivers that
> implement the target_index() callback, while also adding support for the
> few drivers that implement the deprecated target() callback.
> 
> fast_switch()
> =============
> This callback *has* to return the frequency that was selected.
> 
> setpolicy()
> ===========
> This callback does not have any designated way of informing what was the
> end choice. But there are only two drivers using setpolicy(), and none
> of them have current FIE support:
> 
>   drivers/cpufreq/longrun.c:281:	.setpolicy	= longrun_set_policy,
>   drivers/cpufreq/intel_pstate.c:2215:	.setpolicy	= intel_pstate_set_policy,
> 
> The intel_pstate is known to use counter-driven frequency invariance.
> 
> Conclusion
> ==========
> 
> Given that the significant majority of current FIE enabled drivers use
> callbacks that lend themselves to triggering the setting of the FIE scale
> factor in a generic way, move the invariance setter calls to cpufreq core.
> 
> As a result of setting the frequency scale factor in cpufreq core, after
> callbacks that lend themselves to trigger it, remove this functionality
> from the driver side.
> 
> To be noted that despite marking a successful frequency change, many
> cpufreq drivers will consider the new frequency as the requested
> frequency, although this is might not be the one granted by the hardware.
> 
> Therefore, the call to arch_set_freq_scale() is a "best effort" one, and
> it is up to the architecture if the new frequency is used in the new
> frequency scale factor setting (determined by the implementation of
> arch_set_freq_scale()) or eventually used by the scheduler (determined
> by the implementation of arch_scale_freq_capacity()). The architecture
> is in a better position to decide if it has better methods to obtain
> more accurate information regarding the current frequency and use that
> information instead (for example, the use of counters).
> 
> Also, the implementation to arch_set_freq_scale() will now have to handle
> error conditions (current frequency == 0) in order to prevent the
> overhead in cpufreq core when the default arch_set_freq_scale()
> implementation is used.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Suggested-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt.c           | 10 +---------
>  drivers/cpufreq/cpufreq.c              | 12 +++++++++++-
>  drivers/cpufreq/qcom-cpufreq-hw.c      |  9 +--------
>  drivers/cpufreq/scmi-cpufreq.c         | 12 ++----------
>  drivers/cpufreq/scpi-cpufreq.c         |  6 +-----
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 12 ++----------
>  6 files changed, 18 insertions(+), 43 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
