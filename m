Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F43D290ADD
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 19:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391991AbgJPRga (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 13:36:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32929 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733088AbgJPRg3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 13:36:29 -0400
Received: by mail-oi1-f195.google.com with SMTP id s21so3312723oij.0;
        Fri, 16 Oct 2020 10:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uNjJL9XRXf6UiVLAufuLhgqCl6U0FzLOoCk4A9Q+UKg=;
        b=jCWdp34+7nVQbbNjoQaqxefXZl833KpTUtBo8w92GApZKxICvHKur1kE3JjEAv/aCb
         PNnZLsMz4fRtKCZi5BLmM/MFHWaMt4H7m2EbIfOEBsvpWST8u1o8wi84g2uEWm8P9tfo
         B3MpDFTe61LOmloK1R/zJVd19s/Kmmh+q7YAueuAtS13iGuchWiXKYPZkc4uIPysKH5W
         1jwbtdnQRUMUvEiSQFlSRFkTCRpeeC4fGGWsrMdnh1UK1SQOkuUn/7z78PQeHjC0cyC6
         lztl/85/rn44eZ4IyJkR0v8jiWPmR8zhxZMoyFaOgxkuajpy4qf7gt4M3jUK/3btQIKS
         0IOA==
X-Gm-Message-State: AOAM530nF4cc3i0SxfxW+PEocdmj87xkrqGi8s/KAFFuhT/xev3ade3h
        T8sk3Mb46PAypw12lYJolXFaflLZ2fHHrr54TI66He0o
X-Google-Smtp-Source: ABdhPJwc6hEIByVrIX+yaimgNWYjOejjd72/SieX3kq7/0xwhSeZeMPey6u21dcQkanDvtB29ybz9vLA0LqG/XWoa2M=
X-Received: by 2002:aca:724a:: with SMTP id p71mr3250305oic.157.1602869788870;
 Fri, 16 Oct 2020 10:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201016163634.857573-1-wvw@google.com> <CAJZ5v0in0N6USFqvuLcccpirahj=oOki67+Lq9_5i_q7Ep7T6g@mail.gmail.com>
 <CAGXk5yq_xcHYizG_z+FV14ieWya-4qeyVFz1gQZ9_gbJxUcQqg@mail.gmail.com>
In-Reply-To: <CAGXk5yq_xcHYizG_z+FV14ieWya-4qeyVFz1gQZ9_gbJxUcQqg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 19:36:17 +0200
Message-ID: <CAJZ5v0jSC3oD+SFEzhyk=PqhSZoz9yt7jojXj3T5BXhjJ-CaFw@mail.gmail.com>
Subject: Re: [PATCH] sched: cpufreq_schedutil: maintain raw cache when next_f
 is not changed
To:     Wei Wang <wvw@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Wei Wang <wei.vince.wang@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <qperret@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 16, 2020 at 7:18 PM Wei Wang <wvw@google.com> wrote:
>
> On Fri, Oct 16, 2020 at 10:01 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Oct 16, 2020 at 6:36 PM Wei Wang <wvw@google.com> wrote:
> > >
> > > Currently, raw cache will be reset when next_f is changed after
> > > get_next_freq for correctness. However, it may introduce more
> > > cycles. This patch changes it to maintain the cached value instead of
> > > dropping it.
> >
> > IMV you need to be more specific about why this helps.
> >
>
> I think the idea of cached_raw_freq is to reduce the chance of calling
> cpufreq drivers (in some arch those may be costly) but sometimes the
> cache will be wiped for correctness. The purpose of this patch is to
> still keep the cached value instead of wiping them.

Well, I see what the problem is and how the patch is attempting to
address it (which is not the best way to do that because of the extra
struct member that doesn't need to be added if I'm not mistaken), but
IMO the changelog is way too vague from the problem statement
perspective.
