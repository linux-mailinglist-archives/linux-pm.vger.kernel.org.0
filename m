Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393E44A2D12
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jan 2022 09:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345144AbiA2I12 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 Jan 2022 03:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344981AbiA2I11 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 Jan 2022 03:27:27 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F39C061714
        for <linux-pm@vger.kernel.org>; Sat, 29 Jan 2022 00:27:27 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id c15so12219323ljf.11
        for <linux-pm@vger.kernel.org>; Sat, 29 Jan 2022 00:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9uRzLT9tOaaqJM7nSMiNZ/1KY+M4UxydAN6h5AO9MI=;
        b=aW8u7H6qeuvdLJsJXRJr4Qi2iXnWYsgSsPltESLApBgvx8c2ZZoIXyjXi+8Rpv8uZh
         kyouL7Vg2mulPxjRMWY1yolI0YuY4hcsmlHBtXc8MzP3R43eKrsAjqj+JPYT1D2fyxsr
         7jqBgUygsfVoEZNGAjTg+cumT4CGZpxq8BltpfIsp+26BYuGg67CGzNod9UCf7++ULtP
         xfsq/uTFN3ArJLfYHsqSkAjLXPlOlqin0DCaHSeHLup4Cl/YpozOc5A9MCRyuyzhFtqc
         a/wvCsQKp8Y2o82FBBfmt1nBImLpR8Hb3c9AbkmQTHQdvVJrCj8lo0Ga4ZmhmFGngEGU
         ckFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9uRzLT9tOaaqJM7nSMiNZ/1KY+M4UxydAN6h5AO9MI=;
        b=K1Mxu7Nf78aug9NqNd6fmxWxmFIqdB28fHBMYtjVUXw3/RALf+eem23r5wyNRYib/Z
         VzG8x6qHF+XtCPd7gTRuGc+3ICUQcBKrU0vy+mvHGUoaOkSYQXIIHPhHs4eZY7gMXbl9
         0dAwJSewEwyGYZT3fH3WbaNkG3MJI8QPlLFuOrlWqvwv8JRjI8bbA9+vtNTUCVSl5VxT
         99Kl/T5ouGPO0s89ja2I3ye3m3ERBB4qwLB/iOFbmhVhglR60rJJG2mWShpI/w1MY7QZ
         3YhwIjUBSoxNQU/TEcB1OcfBEVxo9A/aZQAxRKipe1ywlc2lVMYCG55QYYVxo38ENpCg
         yKKA==
X-Gm-Message-State: AOAM530xiN9Dmw0YijErsUUHbQlpMouaMltGrYdTvhKOqilnBWf3SoQH
        kPVPpN/ByWroVfnvWmzsg65yFADqYb8GFqcGn1+CLw==
X-Google-Smtp-Source: ABdhPJxpz9Bvq18me08M00YHjoD295rRRh9PT9SOtaJU/iABRC0Qg+sWNK2KHRfUeK0jlNA2/4eyyV/dtBXrembmLJs=
X-Received: by 2002:a05:651c:1142:: with SMTP id h2mr8171907ljo.150.1643444845259;
 Sat, 29 Jan 2022 00:27:25 -0800 (PST)
MIME-Version: 1.0
References: <CAHTsKTdSyC7Jwk56tDR8QwM_oO13ByBRaA78VpHymOZ7J4NQ9Q@mail.gmail.com>
 <CAJZ5v0jrU4Xw2wzdUL9Vd2C6u8NVx5J79DeiRY6KU1xT6ZSuqw@mail.gmail.com> <CAJZ5v0gLMSPsaS7Jnsr8DhevaQamsVk=pu=BfXZxrT+SBAM=fQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gLMSPsaS7Jnsr8DhevaQamsVk=pu=BfXZxrT+SBAM=fQ@mail.gmail.com>
From:   Kelly Rossmoyer <krossmo@google.com>
Date:   Sat, 29 Jan 2022 00:26:48 -0800
Message-ID: <CAHTsKTc0M0wDLVJovzO01z1B9iOSc4cHcS4tNffykna3c=9eJQ@mail.gmail.com>
Subject: Re: [RFC] PM: suspend: Upstreaming wakeup reason capture support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Vijay Nayak <nayakvij@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 27, 2022 at 12:10 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jan 27, 2022 at 8:54 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, Jan 10, 2022 at 7:49 PM Kelly Rossmoyer <krossmo@google.com> wrote:
> > >
> > So as Zichar said, this is quite heavy-weight.
> >
> > I'm not fundamentally against adding more infrastructure to help
> > identify issues related to system suspend, but there needs to be a
> > clear benefit associated with any change in this direction.
>
> That said, the general idea behind wakeup_source objects is that every
> system wakeup event should be recorded in one of them which then can
> be used for later analysis.
>
> If there are reasons why this cannot work in general, what are they?

I won't presume to say that it "cannot work in general."  Nearly everyone on
this thread has more expertise here than I do, and I'm keenly aware of how
much I don't know.  :-)

What I will say is that - across the chips and architectures I've worked upon
over the last few years - that concept has not appeared to match observed
reality.  From what I've seen (which is a very narrow slice of the Linux
universe, but I suspect is at least pretty representative of Android):
* resumes from successful suspends are typically accompanied by a flurry of
  wakesource activity from which it is not possible to determine what actually
  caused the resume (despite last changed timestamps)
* resumes that aren't accompanied by wakeup-armed IRQs can be even
  less well-reflected by wakesource activity
* I believe inferring wakeup reasons from wakesource stats would require
  having a snapshot from the last moment prior to suspend, which seems
  unsolvable from userspace
* suspend aborts (which can be even more harmful for battery life than
  "true" wakeups) are often caused by things that aren't reflected by specific
  wakesources (e.g. a driver failing to suspend)

And as I mentioned in my reply to Zichar, this isn't solely about
troubleshooting.  There's a lot of room to improve on user-focused power
attribution, and I'm hoping to build change in that direction upon the same
foundation.  Having the best possible data about "why we're awake" serves both
goals.

Tangentially, the new(ish) wakesource stats interface has also proved to be
quite difficult to utilize robustly from userspace (at least on Android, maybe
not elsewhere?).  But that's a different fish for a different fryer, that I'm
hoping to tackle later this year.


--

Kelly Rossmoyer | Software Engineer | krossmo@google.com | 858-239-4111
