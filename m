Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183502DA713
	for <lists+linux-pm@lfdr.de>; Tue, 15 Dec 2020 05:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgLOERk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 23:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgLOERg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 23:17:36 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A26C0617A6
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2020 20:16:55 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id f14so434623pju.4
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2020 20:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CqQxEjBsAi+jtGHEEbw5bAKcGSsoEFK1eZykSZqb/as=;
        b=IIyUsOKveGEHhLShknJRFtJYnFflnuy9g9DTmJ973OzdLTEUpFXGgFoEmjX7sNw/EE
         f510xfphwQnV5Bf4yk0bJMBjLO/LDjVCTMQDR0o10z6sZCn7FpTwMkaXjfbppB7DNZAm
         Ru+9gu8Pm3DueFvB7ealoarROnht3SeCBh59V3awVNezmntSAiebv2eFZiUdVQ0AjjoR
         h8SBlJWj+n0FzJAPZ1niSkGTqzjqDv/NG3/iTDS4ViDiAGsnvBsiIf5ygHL5rdyKzTGm
         UWwNViAG4cIk33U+0n1q8RGQDo9Wyn3HvH1xY0bHoeHJd+n3/HdwcQOOpB1q97k0xEiu
         ZcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CqQxEjBsAi+jtGHEEbw5bAKcGSsoEFK1eZykSZqb/as=;
        b=dHpf4oqrp3r2Pd5uPJAl70mbVEnkqikiAfQDFfgfXb5HaUE74IYhS1qwnkvXvOOujb
         LQzMf9bA2JBT0mwuHSGYd6pIRavX7I+5sqrkf0vq6jdTxz+J3OdhN2MFX0z4QPTW+lwR
         eawj+Co9jnUKk9BIUbB2FbMYgdLwgoFeIJRclhZSvrBmD8LP48CB1V36Y7pyhkkNAIVJ
         cZN7qg/IVbhY+KCZwWvUvzfolH/j9XKCDabVBaMtPSgIhpzDHyqG6VIxYeCuRriWRS8i
         DEbEh/a3RHqWT2kUjkLzLIIsL0bRFa/ZVgiNvmKE5u9UnOY/WiaE8jrpZDR16Wl+sx3R
         hMYQ==
X-Gm-Message-State: AOAM533/knM2XiiKVujp46g531XqjOGkb0MiEvdvNU9MVo1kll61QLlS
        7ic5GHEzr5Rn4HiAZQCxtQ93Cw==
X-Google-Smtp-Source: ABdhPJx+XW/JUUiHTjIt8y4pIoEu/plQ+uULj22e0xTKX5ITGVNEciIgWwT6kr5UBAZP+sCS+GddsQ==
X-Received: by 2002:a17:90a:fd08:: with SMTP id cv8mr27831626pjb.29.1608005815515;
        Mon, 14 Dec 2020 20:16:55 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id y6sm252212pjl.0.2020.12.14.20.16.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 20:16:54 -0800 (PST)
Date:   Tue, 15 Dec 2020 09:46:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Subject: Re: [PATCH v2 0/3] cpufreq: Allow drivers to receive more
 information from the governor
Message-ID: <20201215041651.da3ii74xuc5orddp@vireshk-i7>
References: <20360841.iInq7taT2Z@kreacher>
 <3827230.0GnL3RTcl1@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3827230.0GnL3RTcl1@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-12-20, 21:01, Rafael J. Wysocki wrote:
> Hi,
> 
> The timing of this is not perfect (sorry about that), but here's a refresh
> of this series.
> 
> The majority of the previous cover letter still applies:
> 
> On Monday, December 7, 2020 5:25:38 PM CET Rafael J. Wysocki wrote:
> > 
> > This is based on the RFC posted a few days ago:
> > 
> > https://lore.kernel.org/linux-pm/1817571.2o5Kk4Ohv2@kreacher/
> > 
> >  Using intel_pstate in the passive mode with HWP enabled, in particular under
> >  the schedutil governor, is still kind of problematic, because it has to assume
> >  that it should not allow the frequency to fall below the one requested by the
> >  governor.  For this reason, it translates the target frequency into HWP.REQ.MIN
> >  which generally causes the processor to run a bit too fast.
> > 
> >  Moreover, this allows the HWP algorithm to use any frequency between the target
> >  one and HWP.REQ.MAX that corresponds to the policy max limit and some workloads
> >  cause it to go for the max turbo frequency prematurely which hurts energy-
> >  efficiency without improving performance, even though the schedutil governor
> >  itself would not allow the frequency to ramp up so fast.
> > 
> >  This patch series attempts to improve the situation by introducing a new driver
> >  callback allowing the driver to receive more information from the governor.  In
> >  particular, this allows the min (required) and target (desired) performance
> >  levels to be passed to it and those can be used to give better hints to the
> >  hardware.
> 
> In this second revision there are three patches (one preparatory patch for
> schedutil that hasn't changed since the v1, the introduction of the new
> callback and schedutil changes in patch [2/3] and the intel_pstate changes
> in patch [3/3] that are the same as before.
> 
> Please see patch changelogs for details.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
