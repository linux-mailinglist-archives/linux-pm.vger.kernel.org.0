Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F8B2510D4
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 06:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgHYEnM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 00:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgHYEnL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 00:43:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961EDC061755
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 21:43:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 17so6338655pfw.9
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 21:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xAFI0qsutu56A0T8YbbHopvqKbQ58AqtuMd/bLnxq5g=;
        b=PydPDPoT9vmx4KjiX1i5QeL7G5IfhbjA4PIFEOGyLWxh0HDxsXFN8fyO5OVlo3F/iE
         ElxirtK3oeBKmrsmX08tHaLMb4fhSlfn5als2H3BMplmzAZ8ijHJSrUB0WS2B5QJ5aN7
         rwkZBEPwV2O2ZRpBlC7zmXGU8HXlCqVoIc0GDrUkYu55pH+Aa5Fe1UZHjsMCaKhIgPYI
         QCgg3JIG5tjylER4Uf5wbivxNZG1fQ+Ogj4ErV+HhQmi1Z7KvJQ9QOtCK2jNdjtxZ5sx
         XCpLUvHTQ7LgfkMVuZ7RrfxQ6CgUmGcc53WahQg7wCX3LemU2umWdyPwtNsEGv+sG3RE
         i2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xAFI0qsutu56A0T8YbbHopvqKbQ58AqtuMd/bLnxq5g=;
        b=dfgvv8NAe8bk0mdRnDRoPD8UOycW8sENAaGRYs1x74908J4SaTFbk7+knRq+j38JEP
         gTBNCjJE2+samG/G+yH1m/x4mb6zaqBg+8af9a9z9cV5lN38RAIQdW1Zdf+fl0newx9y
         pmt3q/REOsIoCYopEJWop7ERhk9NksS/+ylnIxeR5D7js6T99httTMcQ13c2rhUUvF4k
         Ar2uBZJdRnUNYAGuMiXbi7YIMWfwrLKe/PhGXnyYHSrTBLLGlwz1NNoljWeu2qdo1TcG
         FyPpzUMry74/lFdjagF/w8/mstS/t67nUImT0aus9M3O6JyJcUtZNcY5Nz7nSzFjY6Ud
         Gq6A==
X-Gm-Message-State: AOAM533KU3tMIjeeMl/nbpUBw2MwN7/3IwMh2jvgAfvkmHlXUOb1iArX
        K7/j4/vxKDSg5Gs65isYJXF96A==
X-Google-Smtp-Source: ABdhPJz/01SNEdqoJUUp5KGjIxBdVrind7pWS2z9Jie8BehWkAtUSxB98NdsBDL0xiGRsxF+n6YkcA==
X-Received: by 2002:a17:902:4b:: with SMTP id 69mr6335779pla.245.1598330591057;
        Mon, 24 Aug 2020 21:43:11 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id k5sm11698020pgk.78.2020.08.24.21.43.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 21:43:10 -0700 (PDT)
Date:   Tue, 25 Aug 2020 10:13:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [RFC PATCH 3/3] opp: Power on (virtual) power domains managed by
 the OPP core
Message-ID: <20200825044308.4y3w2urcikban7if@vireshk-i7>
References: <20200730080146.25185-1-stephan@gerhold.net>
 <20200730080146.25185-4-stephan@gerhold.net>
 <20200824112744.jsyaxrfbybyjpwex@vireshk-i7>
 <20200824115549.GB208090@gerhold.net>
 <CAPDyKFojtArMRfO+Z8YaWCWw2fFYcO62x3eL1paNi5pKRg3Jww@mail.gmail.com>
 <20200824150831.GA842@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824150831.GA842@gerhold.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-08-20, 17:08, Stephan Gerhold wrote:
> On Mon, Aug 24, 2020 at 04:36:57PM +0200, Ulf Hansson wrote:
> > That said, perhaps should rely on the consumer to deploy runtime PM
> > support, but let the OPP core to set up the device links for the genpd
> > virtual devices!?
> > 
> 
> Yes, that would be the alternative option.

That is the right option IMO.

> I would be fine with it as long as it also works for the CPUfreq case.
> 
> I don't think anything manages runtime PM for the CPU device, just
> like no-one calls dev_pm_opp_set_rate(cpu_dev, 0). So with my patch the
> power domain is essentially kept always-on (except for system suspend).
> At least in my case this is intended.
> 
> If device links also keep the power domains on if the consumer device
> does not make use of runtime PM it should work fine for my case.

With device link, you only need to do rpm enable/disable on the consumer device
and it will get propagated by itself.

> Personally, I think my original patch (without device links) fits better
> into the OPP API, for the following two reasons.
> 
> With device links:
> 
>   1. Unlike regulators/interconnects, attached power domains would be
>      controlled by runtime PM instead of dev_pm_opp_set_rate(opp_dev, 0).
> 
>   2. ... some driver using OPP tables might not make use of runtime PM.
>      In that case, the power domains would stay on the whole time,
>      even if dev_pm_opp_set_rate(opp_dev, 0) was called.
> 
> With my patch, the power domain state is directly related to the
> dev_pm_opp_set_rate(opp_dev, 0) call, which is more intuitive than
> relying on the runtime PM state in my opinion.

So opp-set-rate isn't in the best of shape TBH, some things are left for the
drivers while other are done by it. Regulator-enable/disable was moved to it
some time back as people needed something like that. While on the other hand,
clk_enable/disable doesn't happen there, nor does rpm enable/disable.

Maybe one day we may want to do that, but lets make sure someone wants to do
that first.

Anyway, even in that case both of the changes would be required. We must make
device links nevertheless first. And later on if required, we may want to do rpm
enable/disable on the consumer device itself.

-- 
viresh
