Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DC63CEF70
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jul 2021 00:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhGSWHR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Jul 2021 18:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384872AbhGSSip (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jul 2021 14:38:45 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2FCC061766
        for <linux-pm@vger.kernel.org>; Mon, 19 Jul 2021 12:09:52 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id a132so11086444oib.6
        for <linux-pm@vger.kernel.org>; Mon, 19 Jul 2021 12:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SudKCvvWg+Me2mbMwVYeRd31oZcZoO+nm1Zj7MU/9gg=;
        b=RiQJfGKTOT2Bj8qhCAPRxVkQZzJtvEnwyjwbYTcQHA7FdW/IjgqG6dCtax0iF7wZ2+
         lJ6ZILsNV8Tn+kJ2osIhKWO6+BYMHQI7C/oeokRCZr7kbIZ9PDfpGDj6xejngosaZkBZ
         oCJrxu77q+CrhX7GrjH62ULOIcf9vv5fDwSHFuFTPv610ALry6kWkpWYGm6dqV1qDiNE
         6Y7ZBjkIVDgOmfXIB+pHLaipkkBmRVcxCvzPdgk1NqM9goQtPQTPgackMCv17gTIPF+g
         bkoXpPN2pU4AF8ohL6w1DOwmqNc9S+eHMr+XQZhn3oolQIgtEw86MbbiTrly+ksKWlb1
         QITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SudKCvvWg+Me2mbMwVYeRd31oZcZoO+nm1Zj7MU/9gg=;
        b=HVUpN7Hknha/BVPljz8HdlmQPIoyh/fcoolMkJqK9eevPHEW8FSpQvP75uVaAgssXl
         2onh9SI3maLK/3WSMWiHyOUhdbWOHwK28MbsIXv6KXk2oC0f67QbXx3rQFDVrCM49yMk
         jbhp1GzTN+INSUWbe8lC3a2tC2v5GMCHUtG/rN1CXJZPlTkZMZ3fpbQWdeWPpWKpaB6v
         2fRUZQjyEh5OjR3gsBVh7d6CCHBQu8eLCGImzr/K8ESnM8Y+8nb1uE1Hk8vtPUCe1/13
         bXm9g6/HPQhXPeJy03u93EUkpJENZXc+zDX3xGws/g+kAPOxv3Vd44UKR2V9jl+oclsK
         mFoQ==
X-Gm-Message-State: AOAM532UdFyiMSCY5yETUSszBlowlI0+SyokXobQ2WWXdqwFqx+nn0Ls
        +wa4wYOsQEB/h+dQ2LdPjsBUCw==
X-Google-Smtp-Source: ABdhPJwO37v6aowZTTyjCfO4cfR2vcCGGaC3PxOZL4mHx6+hfxl3wT4+ud5JxCI5Zjr3L+1noEk9zA==
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr22994769oij.125.1626722359359;
        Mon, 19 Jul 2021 12:19:19 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id d81sm2738922oob.13.2021.07.19.12.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 12:19:18 -0700 (PDT)
Date:   Mon, 19 Jul 2021 14:19:16 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, ulf.hansson@linaro.org,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rojay@codeaurora.org,
        stephan@gerhold.net
Subject: Re: [PATCH v4 2/2] arm64: dts: sc7180: Add required-opps for i2c
Message-ID: <YPXQNFYKfH/xZxFY@yoga>
References: <1626429658-18961-1-git-send-email-rnayak@codeaurora.org>
 <1626429658-18961-3-git-send-email-rnayak@codeaurora.org>
 <YPHpsO5LlQRQxj9y@yoga>
 <CAE-0n53CHD8c7C4ETWRgzmZmFSCcBw46wSs4pKbYMRjA_tD3yg@mail.gmail.com>
 <YPHxfHPC/faq/y+J@yoga>
 <CAE-0n50qx80cMFPJ1x9rc+EMR1L+j2CUMyDjWAbnE9mPHjf-TQ@mail.gmail.com>
 <YPIBK/NJgBNZVI8Y@yoga>
 <12711a61-e16c-d2bc-6e04-ab94c7551abe@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12711a61-e16c-d2bc-6e04-ab94c7551abe@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 19 Jul 04:37 CDT 2021, Rajendra Nayak wrote:

> 
> 
> On 7/17/2021 3:29 AM, Bjorn Andersson wrote:
> > On Fri 16 Jul 16:49 CDT 2021, Stephen Boyd wrote:
> > 
> > > Quoting Bjorn Andersson (2021-07-16 13:52:12)
> > > > On Fri 16 Jul 15:21 CDT 2021, Stephen Boyd wrote:
> > > > 
> > > > > Quoting Bjorn Andersson (2021-07-16 13:18:56)
> > > > > > On Fri 16 Jul 05:00 CDT 2021, Rajendra Nayak wrote:
> > > > > > 
> > > > > > > qup-i2c devices on sc7180 are clocked with a fixed clock (19.2 MHz)
> > > > > > > Though qup-i2c does not support DVFS, it still needs to vote for a
> > > > > > > performance state on 'CX' to satisfy the 19.2 Mhz clock frequency
> > > > > > > requirement.
> > > > > > > 
> > > > > > 
> > > > > > Sounds good, but...
> > > > > > 
> > > > > > > Use 'required-opps' to pass this information from
> > > > > > > device tree, and also add the power-domains property to specify
> > > > > > > the CX power-domain.
> > > > > > > 
> > > > > > 
> > > > > > ..is the required-opps really needed with my rpmhpd patch in place?
> > > > > > 
> > > > > 
> > > > > Yes? Because rpmhpd_opp_low_svs is not the lowest performance state for
> > > > > CX.
> > > > 
> > > > On e.g. sm8250 the first available non-zero corner presented in cmd-db
> > > > is low_svs.
> 
> what rail is this? the mmcx? Perhaps it does not support RET.
> cx usually supports both collapse state and RET.
> 

That was the one I was specifically looking at for the MDSS_GDSC->MMCX
issue, so it's likely I didn't look elsewhere.

> > > 
> > > Indeed. On sc7180 it's not the first non-zero corner. I suppose
> > > retention for CX isn't actually used when the SoC is awake so your
> > > rpmhpd patch is putting in a vote for something that doesn't do anything
> > > at runtime for CX? I imagine that rpmh only sets the aggregate corner to
> > > retention when the whole SoC is suspended/sleeping, otherwise things
> > > wouldn't go very well. Similarly, min_svs may be VDD minimization? If
> > > so, those first two states are basically states that shouldn't be used
> > > at runtime, almost like sleep states.
> > > 
> > 
> > But if that's the case, I don't think it's appropriate for the "enabled
> > state" of the domain to use any of those corners.
> 
> I rechecked the downstream kernels where all this voting happens from within
> the clock drivers, and I do see votes to min_svs for some clocks, but Stephen is
> right that RET is not something that's voted on while in active state.
> 
> But always going with something just above the ret level while active will also
> not work for all devices, for instance for i2c on 7180, it needs a cx vote of
> low svs while the rail (cx) does support something lower than that which is min svs.
> (why can't it just work with min svs?, I don't know, these values and recommendations
> come in from the voltage plans published by HW teams for every SoC and we just end up
> using them in SW, perhaps something to dig further and understand which I will try and
> do but these are the values in voltage plans and downstream kernels which work for now)
> 

So to some degree this invalidates my argumentation about the
enabled_corner in rpmhpd, given that "enabled" means a different corner
for each rail - not just the one with lowest non-zero value.

So perhaps instead of introducing the enabled_corner we need to
introduce your patch and slap a WARN_ON(corner == 0) in
rpmhpd_power_on() - to ensure that all clients that uses a rpmhpd domain
actually do vote for a high enough corner?

Regards,
Bjorn

> > 
> > As this means that anyone who needs any of the rpmhpd domains active
> > also needs to specify required-opps, which wouldn't be needed for any
> > other power domain provider.
> > 
> > And more importantly it means that a device sitting in a GDSC, which
> > would be parented by a rpmhpd domain has no way to specify the GDSC and
> > trickle the minimum-vote up to the rpmhpd domain. (And I know that we
> > don't describe the parentship of the GDSCs today, but this patch
> > tells me that it's around the corner - for more than MMCX)
> > 
> > Regards,
> > Bjorn
> > 
> > > > 
> > > > And if this (which?) clock requires a higher corner than the lowest
> > > > possible in order to tick at this "lowest" frequency, I'm certainly
> > > > interested in some more details.
> > > > 
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
