Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861952F33B8
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 16:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732838AbhALPLV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 10:11:21 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:43952 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbhALPLU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 10:11:20 -0500
Received: by mail-ot1-f50.google.com with SMTP id q25so2514404otn.10;
        Tue, 12 Jan 2021 07:11:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cic+dKHjBRRPZEU7+Q8NLJL208GeD9ZlM4pd6J+pZ/8=;
        b=pX/VUKyWC/hDGUc2c51Gfgc4wEclB0AppwPpCUJewkbNxvX5UpNezHXtHG3zq49RxI
         AMYMGrklNZpFfRiAKmGFgV8x6lQEh7uzFRawCeMGpzVJduh2Qj52b4lJagwuqtGIZqYq
         3qCxd+MD7y1Au8v6bNnVdnoCN6ElCdqU45EikH8PEtiy4LmArJfF0W3zi1zQrleNJ58I
         Xnvyw8dU3rzJIw77bervXHPAdWv4ay3dH1wq8stqGAmue2URQfFn9hgd4pvZNA0QxBYf
         0MrN0faW7kA1ISCXwZGNYvERftQ8uG8O7NWp8fdGQ6/s3jYzVZuSy/Zjknd5+RzvVAgB
         SAfA==
X-Gm-Message-State: AOAM530r0FTih1bHpR+jhNYDcrx+TAz2Dhsn1TyN41FnhGrX/3aHtP2w
        gEffNnJnICy8o0hc2xnVnIC3bfrgUHs/46Eb/FY=
X-Google-Smtp-Source: ABdhPJxLIiV+xD7KLNzPqNXRs9SRLSytJqfj7cJqXk3wLIhQjQWUenLTCCtrWElwndRW6csU5BKPPJJx+vIcKj/DAog=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr3206166otk.206.1610464239852;
 Tue, 12 Jan 2021 07:10:39 -0800 (PST)
MIME-Version: 1.0
References: <1803209.Mvru99baaF@kreacher> <X/25ssA2scFSu+3/@hirez.programming.kicks-ass.net>
In-Reply-To: <X/25ssA2scFSu+3/@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Jan 2021 16:10:28 +0100
Message-ID: <CAJZ5v0gHHPcBbL-EnCYJieMV-pRJWsjb5qC-iqHYznYjzrkitw@mail.gmail.com>
Subject: Re: [PATCH] x86: PM: Register syscore_ops for scale invariance
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Tue, Jan 12, 2021 at 4:02 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jan 08, 2021 at 07:05:59PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > On x86 scale invariace tends to be disabled during resume from
> > suspend-to-RAM, because the MPERF or APERF MSR values are not as
> > expected then due to updates taking place after the platform
> > firmware has been invoked to complete the suspend transition.
> >
> > That, of course, is not desirable, especially if the schedutil
> > scaling governor is in use, because the lack of scale invariance
> > causes it to be less reliable.
> >
> > To counter that effect, modify init_freq_invariance() to register
> > a syscore_ops object for scale invariance with the ->resume callback
> > pointing to init_counter_refs() which will run on the CPU starting
> > the resume transition (the other CPUs will be taken care of the
> > "online" operations taking place later).
> >
> > Fixes: e2b0d619b400 ("x86, sched: check for counters overflow in frequency invariant accounting")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Thanks!, I'll take it through the sched/urgent tree?

That works, thanks!
