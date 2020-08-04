Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5119323B537
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 08:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgHDGrA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 02:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgHDGrA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 02:47:00 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D1EC061756
        for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2020 23:47:00 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id l60so1443040pjb.3
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2020 23:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DnhGljgxfzJeLlq9y9e/7VwoaSWViejckL3W26FCQPY=;
        b=UueG+3z15qVK2BxckVCRjepMJOMHSHdHWYx8MT/s56DT3z3RtFe/nSLY6u9tf2ZzJ8
         eMXgwJqof8xUczI7iHjHGThgYrEfWavNmoupNofQO6/R2wsJm1NzglZgMAwhp+yknPDK
         wXa2CW0UqNzxav/1My/2A6rIXJ5YKQXFsJsuko0rDuZ26pwovnAbcbt36OQOSjbSt8LR
         aCN8S7hG5dMZHcRB84/FG46LoCP6ZDI525Awim5YurR0M1wKIXOen6IsIg7ArGlt0LBm
         5KuKYW03vVO0btus6/4Yg3chKAwddsyu2AFaisM3kjURSRe048PgLImAUFCF8knh+LE1
         H01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DnhGljgxfzJeLlq9y9e/7VwoaSWViejckL3W26FCQPY=;
        b=k2zxZrVGxfsTxKueJrbrJfjGhMX+pkO/Pvrrm9dheLap0jR2kTvFp0YtWdqouDH33v
         zLYrQ6ZpP7NrHeBjJ670hkp0m6ftjxfuC2FktPbUOqeouiJQK3XrPUoamFnpXOsGxims
         wJG17V/BAdJ3dSKZtgfdLvu3o7ZbmgO8Rw4TTXpVeIecn/29/HIrT/1wIFDxjhx/tWzd
         7ffi/qMg1HsL/u+tAopUt9YICBkEkERUY1DR8scSq8jObuLBnyzhClvASwuwhU7Ho8Cp
         tCjjGeYsYkjinXsGKqey/0lYGjybeuVfP/S+Ou7xj+U/vz+tTEg9BezDkjKE0xyt1YXB
         dQKA==
X-Gm-Message-State: AOAM531uRCqLoVq8XuTdZzbxGXu7P6zIrfaiN+DeBzT3hTBI07tp5msw
        iQykNm+8ObaI4zl2bHsDMpa7jQ==
X-Google-Smtp-Source: ABdhPJwJkKqdgXZJK1wqpAHnVHCHlWOIav+LLGoSZfd5dZ34R0P644MLXYy4TL5d6mUKKMaqtgjCVQ==
X-Received: by 2002:a17:902:6bc2:: with SMTP id m2mr18395916plt.158.1596523619660;
        Mon, 03 Aug 2020 23:46:59 -0700 (PDT)
Received: from localhost ([122.162.244.227])
        by smtp.gmail.com with ESMTPSA id u26sm20550893pgo.71.2020.08.03.23.46.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Aug 2020 23:46:58 -0700 (PDT)
Date:   Tue, 4 Aug 2020 12:16:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] cpufreq: report whether cpufreq supports
 Frequency Invariance (FI)
Message-ID: <20200804064656.h25yapthuumdxjw7@vireshk-mac-ubuntu>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-5-ionela.voinescu@arm.com>
 <20200730044346.rgtaikotkgwdpc3m@vireshk-mac-ubuntu>
 <20200803152400.GB20312@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803152400.GB20312@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-08-20, 16:24, Ionela Voinescu wrote:
> Right, cpufreq_register_driver() should check that at least one of them
> is present

> (although currently cpufreq_register_driver() will return
> -EINVAL if .fast_switch() alone is present - something to be fixed).

I think it is fine as there is no guarantee from cpufreq core if
.fast_switch() will get called and so target/target_index must be
present. We can't do fast-switch today without schedutil (as only that
enables it) and if a notifier gets registered before the driver, then
we are gone again.

> Will do, on both accounts.
> 
> 
> > > +		static_branch_enable_cpuslocked(&cpufreq_set_freq_scale);
> > > +		pr_debug("%s: Driver %s can provide frequency invariance.",
> > > +			 __func__, driver->name);
> > 
> > I think a simpler print will work well too.
> > 
> >                 pr_debug("Freq invariance enabled");
> > 
> 
> I think the right way of reporting this support is important here.

Yeah, we can't say it is enabled as you explained, though I meant
something else here then, i.e. getting rid of driver name and
unimportant stuff. What about this now:

pr_debug("supports frequency invariance");

This shall get printed as this finally:

cpufreq: supports frequency invariance

-- 
viresh
