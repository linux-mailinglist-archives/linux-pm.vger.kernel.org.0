Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80897295E03
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 14:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897868AbgJVMHw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 08:07:52 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42088 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897863AbgJVMHu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 08:07:50 -0400
Received: by mail-oi1-f195.google.com with SMTP id 16so1432072oix.9;
        Thu, 22 Oct 2020 05:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rsWpUgmKiK1iTffkYnIeKuIs/1+05Y0WxWiqciGePpU=;
        b=q9uE8/FeCFyEpVUfe8sbIMZKDd72yw/qFdOzyBpPpkj5yrHHtOusGJXTY4nlXihPYH
         2KIBlWkFP5QpeqN9hwuJb8QB1i5NqP6cHWlxTHhb/M/dZ2kc5swKln1ExlTSC/ZVT774
         qhPGsQc3xJcaH0ev4N05cj+qnVjQiMPeqCzMzlbzbZ1HeF10LkmSSIb8yLi2Lc2wjsxr
         1MQC87gsBQTckjW72FAkGiJX0o4n4kK/Sva+iAe4EIdyyGzLvQ8ECm/1UEmWglUvBjSB
         OfAxfUDtJOHxIrLkwBcEEPM/3FxWvkX3MlmlirguTb/up4K1NsY7IwoUk6OZnr7Wlr4I
         CyZg==
X-Gm-Message-State: AOAM530Sw2H90iEtO7tibbND6PkmAikXw/leSviRx+caciI7GVXnTHze
        q68AVhjw/4AavUUsTIW0o3NALq+xDOFBXaYtISg=
X-Google-Smtp-Source: ABdhPJwYKUSR87064DuZyOBUHttXjyy/bJD6aPomrsK++Z1bvXnvv86RsKwSzLufomfAgxgNxXJ4r4Dla2wRN25orNs=
X-Received: by 2002:aca:fd52:: with SMTP id b79mr1327660oii.69.1603368469292;
 Thu, 22 Oct 2020 05:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594707424.git.viresh.kumar@linaro.org> <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
 <20200716115605.GR10769@hirez.programming.kicks-ass.net> <20201022083255.37xl3lffwk5qo6uk@vireshk-i7>
 <20201022090523.GV2628@hirez.programming.kicks-ass.net> <20201022110656.gaphjv2tzhj4f5y6@vireshk-i7>
 <CAJZ5v0jZC=UwW9L+KB3pugsTL9P1tZmvQ-sVMV-udn7+L_gEeA@mail.gmail.com> <20201022115752.GF2611@hirez.programming.kicks-ass.net>
In-Reply-To: <20201022115752.GF2611@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Oct 2020 14:07:38 +0200
Message-ID: <CAJZ5v0hTCzQWV8NBNdQPcKbgKyU79yRyVb=sDBiDv87cab-YCw@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 22, 2020 at 1:58 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Oct 22, 2020 at 01:30:01PM +0200, Rafael J. Wysocki wrote:
>
> > Many people use intel_pstate in the active mode with HWP enabled too.
>
> We now have HWP-passive supported, afaict. So we should discourage that.

Which is kind of hard, because plain HWP does better in some cases,
especially performance-focused.

I am still not sure why this is the case given how the passive mode
with HWP enabled is implemented, but that's what Srinivas sees in his
tests.

> That is; I'll care less and less about people not using schedutil as
> time goes on.
>
> > Arguably, that doesn't need to compute the effective utilization, so I
> > guess it is not relevant for the discussion here, but it is not
> > negligible in general.
>
> Why not? cpufreq-cooling should still be able to throttle the system by
> setting HWP.Highest_Performance no?

Well, in theory, but it is not used on x86 AFAICS.

> In which case it still needs an energy estimate.
