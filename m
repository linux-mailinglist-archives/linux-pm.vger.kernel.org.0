Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240703D4EDC
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jul 2021 19:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhGYQVF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Jul 2021 12:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhGYQVE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jul 2021 12:21:04 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1715CC061757
        for <linux-pm@vger.kernel.org>; Sun, 25 Jul 2021 10:01:34 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id u10so8140637oiw.4
        for <linux-pm@vger.kernel.org>; Sun, 25 Jul 2021 10:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J0CqnawQFzTaboVphqTqnPpq47SB6w0kctdgBqfSago=;
        b=ITGcVgWjSvk5bdFkmu5wJhRrOIzDh7n905jeU+xxK0Mz9qtizqH+GcTExX46Y0QVas
         5OE3hmix/dh79fsNFA9eB0sYl3mYP4aTas4Gwj5JjuFGvTENZ8gyHOMtNnBH8dRQAMeK
         etMtwLyA2hEgPDgaCvMfvz24iEUyCFFCpLx3L/W/XkMWCJmrYtk9kqG2Qui5owf8X1Hg
         8PM180c3svlm4TGJ8KEebXANtqymxujl3Xm66BwvuyJ4ZHVsueIWafOo7dPE5Dk87pvD
         bSZuRwPbjn50cpOOPz82O3HHYkSXefr2AB2Yt4XXwq46rpXa+tEsgT/wlc+Rocw8FU2L
         YdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J0CqnawQFzTaboVphqTqnPpq47SB6w0kctdgBqfSago=;
        b=lX9bUIq9OZUKl3RXM9b6xM9uYoL8JgqdHrO3uZuQONp5DtXXEldYc94ihlvnHU5+kM
         l8qZxYgqQWZc6XvOO/y+yxby9G6bqRVhjhLX4ukWwEK87PgaJBlP20d2X56IW/8JdYAe
         gSiEtq2j2g2YVvYQdyoxMpq//a1nxRcdl19ui67kKT7KaaXKiEjjl2MEUh5pC7q/qZ36
         +c5OZYUCtX5lgeb7jLz/x6SPSldBKQB3SKVJlw1PYIvdOwGkou2G1Zfn7kHevEKqyXcT
         h1ElQmb9mt8OSFLnGxkJqfNCkrcg5YvEJTBLOd6Yzo+4+3BD6OqbKcLzjiGkI8sidB8i
         boZQ==
X-Gm-Message-State: AOAM5322rFdn+5rH2+jcmoGGCTaUfKBUYYgLeITq96aWVsyTqOUVk20f
        zK0cSC8JVe6fuR/nRcmFnU5TTQ==
X-Google-Smtp-Source: ABdhPJwkUYRSRS/PVfVlS/yPsxZSb3XuJOtkClFX3eA5J4vUj2jA5H1/Ze8TUvDpulmBKoPP1z6+vg==
X-Received: by 2002:aca:4355:: with SMTP id q82mr14520179oia.165.1627232493401;
        Sun, 25 Jul 2021 10:01:33 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r24sm6852639otg.14.2021.07.25.10.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 10:01:32 -0700 (PDT)
Date:   Sun, 25 Jul 2021 12:01:30 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, ulf.hansson@linaro.org,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rojay@codeaurora.org,
        stephan@gerhold.net
Subject: Re: [PATCH v4 2/2] arm64: dts: sc7180: Add required-opps for i2c
Message-ID: <YP2Y6qs5P5mb2jzE@yoga>
References: <1626429658-18961-1-git-send-email-rnayak@codeaurora.org>
 <1626429658-18961-3-git-send-email-rnayak@codeaurora.org>
 <YPHpsO5LlQRQxj9y@yoga>
 <CAE-0n53CHD8c7C4ETWRgzmZmFSCcBw46wSs4pKbYMRjA_tD3yg@mail.gmail.com>
 <YPHxfHPC/faq/y+J@yoga>
 <CAE-0n50qx80cMFPJ1x9rc+EMR1L+j2CUMyDjWAbnE9mPHjf-TQ@mail.gmail.com>
 <YPIBK/NJgBNZVI8Y@yoga>
 <12711a61-e16c-d2bc-6e04-ab94c7551abe@codeaurora.org>
 <YPXQNFYKfH/xZxFY@yoga>
 <bc79ea3e-4981-8f9b-f9a7-59cb972047a7@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc79ea3e-4981-8f9b-f9a7-59cb972047a7@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 19 Jul 23:29 CDT 2021, Rajendra Nayak wrote:

> 
> 
> On 7/20/2021 12:49 AM, Bjorn Andersson wrote:
> > On Mon 19 Jul 04:37 CDT 2021, Rajendra Nayak wrote:
> > 
> > > 
> > > 
> > > On 7/17/2021 3:29 AM, Bjorn Andersson wrote:
> > > > On Fri 16 Jul 16:49 CDT 2021, Stephen Boyd wrote:
> > > > 
> > > > > Quoting Bjorn Andersson (2021-07-16 13:52:12)
> > > > > > On Fri 16 Jul 15:21 CDT 2021, Stephen Boyd wrote:
> > > > > > 
> > > > > > > Quoting Bjorn Andersson (2021-07-16 13:18:56)
> > > > > > > > On Fri 16 Jul 05:00 CDT 2021, Rajendra Nayak wrote:
> > > > > > > > 
> > > > > > > > > qup-i2c devices on sc7180 are clocked with a fixed clock (19.2 MHz)
> > > > > > > > > Though qup-i2c does not support DVFS, it still needs to vote for a
> > > > > > > > > performance state on 'CX' to satisfy the 19.2 Mhz clock frequency
> > > > > > > > > requirement.
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > Sounds good, but...
> > > > > > > > 
> > > > > > > > > Use 'required-opps' to pass this information from
> > > > > > > > > device tree, and also add the power-domains property to specify
> > > > > > > > > the CX power-domain.
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > ..is the required-opps really needed with my rpmhpd patch in place?
> > > > > > > > 
> > > > > > > 
> > > > > > > Yes? Because rpmhpd_opp_low_svs is not the lowest performance state for
> > > > > > > CX.
> > > > > > 
> > > > > > On e.g. sm8250 the first available non-zero corner presented in cmd-db
> > > > > > is low_svs.
> > > 
> > > what rail is this? the mmcx? Perhaps it does not support RET.
> > > cx usually supports both collapse state and RET.
> > > 
> > 
> > That was the one I was specifically looking at for the MDSS_GDSC->MMCX
> > issue, so it's likely I didn't look elsewhere.
> > 
> > > > > 
> > > > > Indeed. On sc7180 it's not the first non-zero corner. I suppose
> > > > > retention for CX isn't actually used when the SoC is awake so your
> > > > > rpmhpd patch is putting in a vote for something that doesn't do anything
> > > > > at runtime for CX? I imagine that rpmh only sets the aggregate corner to
> > > > > retention when the whole SoC is suspended/sleeping, otherwise things
> > > > > wouldn't go very well. Similarly, min_svs may be VDD minimization? If
> > > > > so, those first two states are basically states that shouldn't be used
> > > > > at runtime, almost like sleep states.
> > > > > 
> > > > 
> > > > But if that's the case, I don't think it's appropriate for the "enabled
> > > > state" of the domain to use any of those corners.
> > > 
> > > I rechecked the downstream kernels where all this voting happens from within
> > > the clock drivers, and I do see votes to min_svs for some clocks, but Stephen is
> > > right that RET is not something that's voted on while in active state.
> > > 
> > > But always going with something just above the ret level while active will also
> > > not work for all devices, for instance for i2c on 7180, it needs a cx vote of
> > > low svs while the rail (cx) does support something lower than that which is min svs.
> > > (why can't it just work with min svs?, I don't know, these values and recommendations
> > > come in from the voltage plans published by HW teams for every SoC and we just end up
> > > using them in SW, perhaps something to dig further and understand which I will try and
> > > do but these are the values in voltage plans and downstream kernels which work for now)
> > > 
> > 
> > So to some degree this invalidates my argumentation about the
> > enabled_corner in rpmhpd, given that "enabled" means a different corner
> > for each rail - not just the one with lowest non-zero value.
> 
> Right, it might work in some cases but might not work for all.
> 

Which makes it way less desirable.

The enable state for rpmhpd power domains doesn't meet my expectations
for how a power domain should behave, but we should at least be
consistent across all consumers of it then...


But the original issue remains, that when a device is powered by
MDSS_GDSC, which is a subdomain of MMCX we still need to ensure that
"on" for MMCX is actually "on" - which just happens to be the first
non-0 corner.

But I presume we will end up having to do the same with &gcc's GDSCs,
which are subdomains of CX and MX where this isn't true.

> > 
> > So perhaps instead of introducing the enabled_corner we need to
> > introduce your patch and slap a WARN_ON(corner == 0) in
> > rpmhpd_power_on() - to ensure that all clients that uses a rpmhpd domain
> > actually do vote for a high enough corner?
> 
> So this would mean the expectation is that the clients set the perf state/corner
> before they call power_on? I don;t think that's the case today with most clients,
> infact its the opposite, we power on first and then make a call to set the perf
> state of the domain.
> 

You're right, it's pretty much always the opposite, given that genpd
will always enable the domain during attach.

Regards,
Bjorn

> > 
> > Regards,
> > Bjorn
> > 
> > > > 
> > > > As this means that anyone who needs any of the rpmhpd domains active
> > > > also needs to specify required-opps, which wouldn't be needed for any
> > > > other power domain provider.
> > > > 
> > > > And more importantly it means that a device sitting in a GDSC, which
> > > > would be parented by a rpmhpd domain has no way to specify the GDSC and
> > > > trickle the minimum-vote up to the rpmhpd domain. (And I know that we
> > > > don't describe the parentship of the GDSCs today, but this patch
> > > > tells me that it's around the corner - for more than MMCX)
> > > > 
> > > > Regards,
> > > > Bjorn
> > > > 
> > > > > > 
> > > > > > And if this (which?) clock requires a higher corner than the lowest
> > > > > > possible in order to tick at this "lowest" frequency, I'm certainly
> > > > > > interested in some more details.
> > > > > > 
> > > 
> > > -- 
> > > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> > > of Code Aurora Forum, hosted by The Linux Foundation
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
