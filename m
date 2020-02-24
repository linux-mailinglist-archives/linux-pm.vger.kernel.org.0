Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17F72169B30
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 01:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgBXA3W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Feb 2020 19:29:22 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33744 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgBXA3W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Feb 2020 19:29:22 -0500
Received: by mail-ot1-f65.google.com with SMTP id w6so7232084otk.0;
        Sun, 23 Feb 2020 16:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9C3Udx1D1DIdp1i8/eh8sT/C9Vzzs0UrF8N4PaPtKL8=;
        b=PYHLlY6A5SIei/BPPam5xL5F7rBhryLnJqbmwRxf4aauTfz+bqvxnO3ymsAAxZH9yx
         lsYKxxGfxaWny9y0SE1ItUlbJXnRU0SlLtSqx/Y3QNThuNaPRLILGlHwRqUThdkZlYM5
         UX7sNMuCkSgCD7Km0T0Ls7HeQ/2DyxzJJ1rL5T7RO6u7Z2D7VNagRl0MN2+a91jNWGyd
         AXNoYVQKEGGf5UMlsITqolwcoTQ6/8zT41LOrsEs9rwe2EXOdW5mbKoBOIimJbPASdcd
         qdPoqB2b4vAzgrMUxL8sAHfd9YzaZqNeo+Ru4beCgJiwviwQ9XklFgxcqUylHe6GI+bb
         GBMg==
X-Gm-Message-State: APjAAAXYirrcD/ThSmJfuh0kp6I5fLtkXAvDnaEE/SOTD/yA13lNgm//
        8HKIwquIh7o3q014fy9unQnkXLULM+BqEiyWk8VHyA9N
X-Google-Smtp-Source: APXvYqzDN+R8PPgZf6yIc7l0P8ZtL6kbXsw+7HtqFkiR99MwsbCjyGxiwOog3gTlFJ76sAPKK8B+bnGwRCP77nTtGnI=
X-Received: by 2002:a9d:7559:: with SMTP id b25mr37014520otl.189.1582504161350;
 Sun, 23 Feb 2020 16:29:21 -0800 (PST)
MIME-Version: 1.0
References: <1654227.8mz0SueHsU@kreacher> <87wo8rjsa4.fsf@riseup.net>
 <CAJZ5v0hAn0V-QhebFt=vqKK6gBLxjTq7SNOWOStt7huCXMSH7g@mail.gmail.com>
 <CAJZ5v0hrOma52rocMsitvYUK6WxHAa0702_8XJn1UJZVyhz=rQ@mail.gmail.com>
 <877e0qj4bm.fsf@riseup.net> <CAJZ5v0hH1XiphdakYFPmHLL+hFKw2U3YNU9HSRxsdRUV6ZtM5g@mail.gmail.com>
 <87ftf3fv69.fsf@riseup.net>
In-Reply-To: <87ftf3fv69.fsf@riseup.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Feb 2020 01:29:10 +0100
Message-ID: <CAJZ5v0jqp7aEh43kUvxyMWxbnEUjUZZ31iHk_oxDdvGM6RTdMw@mail.gmail.com>
Subject: Re: [PATCH 00/28] PM: QoS: Get rid of unuseful code and rework CPU
 latency QoS interface
To:     Francisco Jerez <currojerez@riseup.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 21, 2020 at 11:10 PM Francisco Jerez <currojerez@riseup.net> wrote:
>
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
> > On Thu, Feb 13, 2020 at 9:09 AM Francisco Jerez <currojerez@riseup.net> wrote:
> >>
> >> "Rafael J. Wysocki" <rafael@kernel.org> writes:
> >>
> >> > On Thu, Feb 13, 2020 at 1:16 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >> >>
> >> >> On Thu, Feb 13, 2020 at 12:31 AM Francisco Jerez <currojerez@riseup.net> wrote:
> >> >> >
> >
> > [cut]
> >
> >> >
> >> > And BTW, posting patches as RFC is fine even if they have not been
> >> > tested.  At least you let people know that you work on something this
> >> > way, so if they work on changes in the same area, they may take that
> >> > into consideration.
> >> >
> >>
> >> Sure, that was going to be the first RFC.
> >>
> >> > Also if there are objections to your proposal, you may save quite a
> >> > bit of time by sending it early.
> >> >
> >> > It is unfortunate that this series has clashed with the changes that
> >> > you were about to propose, but in this particular case in my view it
> >> > is better to clean up things and start over.
> >> >
> >>
> >> Luckily it doesn't clash with the second RFC I was meaning to send,
> >> maybe we should just skip the first?
> >
> > Yes, please.
> >
> >> Or maybe it's valuable as a curiosity anyway?
> >
> > No, let's just focus on the latest one.
> >
> > Thanks!
>
> We don't seem to have reached much of an agreement on the general
> direction of RFC2, so I can't really get started with it.  Here is RFC1
> for the record:
>
> https://github.com/curro/linux/commits/intel_pstate-lp-hwp-v10.8-alt

Appreciate the link, but that hasn't been posted to linux-pm yet, so
there's not much to discuss.

And when you post it, please rebase it on top of linux-next.

> Specifically the following patch conflicts with this series:
>
> https://github.com/curro/linux/commit/9a16f35531bbb76d38493da892ece088e31dc2e0
>
> Series improves performance-per-watt of GfxBench gl_4 (AKA Car Chase) by
> over 15% on my system with the branch above, actual FPS "only" improves
> about 5.9% on ICL laptop due to it being very lightly TDP-bound with its
> rather huge TDP.  The performance of almost every graphics benchmark
> I've tried improves significantly with it (a number of SynMark
> test-cases are improved by around 40% in perf-per-watt, Egypt
> perf-per-watt improves by about 25%).
>
> Hopefully we can come up with some alternative plan of action.

It is very easy to replace the patch above with an alternative one on
top of linux-next that will add CPU_RESPONSE_FREQUENCY QoS along the
lines of the CPU latency QoS implementation in there without the need
restore to global QoS classes.

IOW, you don't really need the code that goes away in linux-next to
implement what you need.

Thanks!
