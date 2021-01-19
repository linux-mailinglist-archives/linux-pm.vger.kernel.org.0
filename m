Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AED2FBAE2
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 16:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbhASPRT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 10:17:19 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:38353 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391250AbhASPNO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 10:13:14 -0500
Received: by mail-ot1-f48.google.com with SMTP id 34so9241230otd.5;
        Tue, 19 Jan 2021 07:12:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0t6RhR/1R2XdCgrNs9/OaQXmFfvvtj4DhEfvATabpOA=;
        b=lu+/uWBJBNlyhTNilTvHcLLym4xbOFgIEmDrBU+2VzChQILygAFpvtbyfgGiQgwBdA
         UdhP1E4CH+G1epDeWEkOJAxmkpetN6kv/EYF3KPsM3G6GbkijrTRaHUa35kkGqJ578oK
         NjGD0n+yH+0FbSRIgR8jz9FQoDi2BRsiweTyH1aRwu1bTf99O6Yo3PYjpOIzH26aY/QM
         E17vv5AsBh+6FF7gM5ILg2XPzd3nKNhxURz5uBMpMKc1LtrJyY3quQQdUcN4GxYk/Kio
         t8/vwU0Y6rgLD3ruu+DHypx757UJ7cYYBvv7+GR1AvCF6ET41nhkiuuIskMjXwWxpXtx
         nXsA==
X-Gm-Message-State: AOAM530P5d2VlwmbRSMDG+Dnp4g7mewR/ioQeFf1lYnShQOttOkPgM9s
        hAZ1eXRc+UW/x+K7soRlUVgBztza3R6/KK4Y0uA=
X-Google-Smtp-Source: ABdhPJw482oBIg5gsTjxTJ8UOsOMF94ibHpB/GKQTJ5J+tg8rTnonCKX9SiOANbm5nfSPQm9LZnSVwrSsHrp6qqVQDI=
X-Received: by 2002:a9d:1710:: with SMTP id i16mr3721277ota.260.1611069152634;
 Tue, 19 Jan 2021 07:12:32 -0800 (PST)
MIME-Version: 1.0
References: <1803209.Mvru99baaF@kreacher> <X/25ssA2scFSu+3/@hirez.programming.kicks-ass.net>
 <CAJZ5v0gHHPcBbL-EnCYJieMV-pRJWsjb5qC-iqHYznYjzrkitw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gHHPcBbL-EnCYJieMV-pRJWsjb5qC-iqHYznYjzrkitw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Jan 2021 16:12:20 +0100
Message-ID: <CAJZ5v0gY+WjB2q=wnRYxpwFmLzOcLMKewrCgKdpC0oNPFgoDww@mail.gmail.com>
Subject: Re: [PATCH] x86: PM: Register syscore_ops for scale invariance
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 12, 2021 at 4:10 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Jan 12, 2021 at 4:02 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Jan 08, 2021 at 07:05:59PM +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > On x86 scale invariace tends to be disabled during resume from
> > > suspend-to-RAM, because the MPERF or APERF MSR values are not as
> > > expected then due to updates taking place after the platform
> > > firmware has been invoked to complete the suspend transition.
> > >
> > > That, of course, is not desirable, especially if the schedutil
> > > scaling governor is in use, because the lack of scale invariance
> > > causes it to be less reliable.
> > >
> > > To counter that effect, modify init_freq_invariance() to register
> > > a syscore_ops object for scale invariance with the ->resume callback
> > > pointing to init_counter_refs() which will run on the CPU starting
> > > the resume transition (the other CPUs will be taken care of the
> > > "online" operations taking place later).
> > >
> > > Fixes: e2b0d619b400 ("x86, sched: check for counters overflow in frequency invariant accounting")
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Thanks!, I'll take it through the sched/urgent tree?
>
> That works, thanks!

Any news on this front?  It's been a few days ...
