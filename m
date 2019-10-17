Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3468BDB9EC
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 00:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438353AbfJQW4G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 18:56:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44446 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389846AbfJQW4F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 18:56:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id z9so4109060wrl.11
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 15:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9rBnmh0SQQD7EZXCwG/Rmi0xjqD1Y0ThAZXFkdsY+iQ=;
        b=SjAkaqVlUWpxNksMr2KvBoEDX6hksckR56Ak8Yd5CTE9AGs8U5Mp3OPVW1cg0eUInR
         pQtHGsO8MiZVlBZP6PN6PgoShQbW0ceFcn1VKnGZH6/o5ZkgI+gSS10Rx6FU7p6GXaYV
         n8GxMp0AeaWH12aLWP+Xdx/UaIMz+2T7BqQBSu0rNhFpTX93+/f4g/q0x34Wx2L+63tR
         8mrCxZB9PV6Fi4T+QFxbMDcWys2prqsiPfoKfNgKquWVITTygcfcurosbtiT7jNr5jU2
         TQ0oxtisPoGLGLfZ+tO+0noC+nQNPKx/0FhAzp0z7aUcpblBYGq5CLshgI3YGxy6AXam
         JIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9rBnmh0SQQD7EZXCwG/Rmi0xjqD1Y0ThAZXFkdsY+iQ=;
        b=jInLsx2x23yLyM3hEmCADL+K6GAMmZ7X4P+dLeuPKlT5tMfb0fN8F6bhNttD5CFKZV
         jXrf0D1+W+b7HdmmxJRFjJkFKTWEoNT7y0BtAKJRXoKpKIVteDA60BP6qVvzjYx2GyVy
         egjWzPf3ScSEXzxsf8KvJg7TvmJX34sjfiQe4u6Y5nFXJ3/yhq0YsafYmvxH83I+xb1W
         a6YApQlOdkPWB+pxQLlbNFjkxHP88RopCyzwsnP5iLqK43ls/X3IDsAJxRkf9tXQp0vB
         4fOqQJNoLjHeb3+MJ4LeO12XZ4RUBRKPkdeDUlHo6Z3xkNZKyokn9e5bM+F2VjnQ6BDD
         5QSw==
X-Gm-Message-State: APjAAAV06M0TfdhZ6sf/DIXqbuGoJoxgIhFcfLZkuUtdcI9WJ85nr+Kt
        5TaQW+v4ViO9BMtUKqTif+A8GT92IoB0Ozstd8kWTQ==
X-Google-Smtp-Source: APXvYqxHqv5uhe6ktRmll2ZYbxrAZbwZeyIqcYcgbC3LJooqk9Iaqd3KZYxFkpAuQ+Hwd/x1fSfnhac10/ItdibGrSc=
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr4967616wrn.29.1571352961493;
 Thu, 17 Oct 2019 15:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAA25o9T6C4VCVbqzS0hJgmvpJb6h+htFpH3OUY30E2VtuG8fxQ@mail.gmail.com>
 <56319808-87dc-76ed-c1e0-9f60108e94a6@arm.com> <CAA25o9TpBm+LNwVccTaUng4vQ1Q9_Wz2QftGho7DG_+26CCYoA@mail.gmail.com>
 <CAJZ5v0jCb5jLVQ2Oj0bSNf987apxi7SHx4duX9eALMD6QQXB+w@mail.gmail.com>
 <CAA25o9SUnwc908Grh8qYMDi_tnyhov00Y11RT69MuK8gXcrN4A@mail.gmail.com> <CAA25o9TWrLh0o17Epqimsvwe8GoW682jVh_4u2KtjJ7SqKGbsQ@mail.gmail.com>
In-Reply-To: <CAA25o9TWrLh0o17Epqimsvwe8GoW682jVh_4u2KtjJ7SqKGbsQ@mail.gmail.com>
From:   Luigi Semenzato <semenzato@google.com>
Date:   Thu, 17 Oct 2019 15:55:49 -0700
Message-ID: <CAA25o9QKsTwMcuz1yAT7qtnO2rOUVpzkUmnfSLkfRZAFZ_CE9g@mail.gmail.com>
Subject: Re: hibernation memory usage
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Bas Nowaira <bassem@google.com>, Geoff Pike <gpike@google.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To make hibernation work, I have been playing with this suggestion:

> Whatever doesn't fit into 50% of RAM needs to be swapped out before
> hibernation.  The efficiency of that depends on the swap handling code
> and the underlying hardware.  If that is efficient enough overall,
> trying to avoid it altogether isn't going to make much of a
> difference.

What's a good way of swapping out 50% of RAM?  I have tried playing
with /proc/sys/vm/min_free_kbytes.  Lowering it below MemFree forces
reclaim and gets swapping started.  Unfortunately the reclaim also
hits file pages, so badly that the system thrashes to a grinding halt.
Swappiness is already set to 100.  Internally it seems that values up
to 200 are valid, and I wish that the entire range was allowed, but I
am not sure it would help.  Right now I am playing with the production
kernel, but similar situations triggered the same behavior in the
Chrome OS kernels, even after internally setting swappiness to values
close to 200.


On Tue, Oct 8, 2019 at 1:10 PM Luigi Semenzato <semenzato@google.com> wrote:
>
> Actually, I think we only need to change the MM watermarks before
> hibernation and after resume.  There's a patch that will do just that:
>
> https://lkml.org/lkml/2013/2/17/210
>
> It didn't make it into mainline (which seems kind of unreasonable,
> since the watermarks themselves are based on heuristics) but shouldn't
> be difficult to apply.  Or are there simpler solutions?
>
> On Tue, Oct 8, 2019 at 9:18 AM Luigi Semenzato <semenzato@google.com> wrote:
> >
> > Yes, that makes sense, thank you.  Use separate partitions for swap
> > and hibernation.
> >
> > Normally the kernel starts swapping out when there's no reclaimable
> > memory, so anon usage will be high.  Do you think cranking up
> > /proc/vm/swappiness would be enough to ensure that file pages stay
> > over 50%?  Or would you use some tricks, such as running a
> > high-priority process which allocates >50% of RAM, thus forcing other
> > anon pages to be swapped out, then killing that process and quickly
> > hibernating before too many pages are brought back in?  Or changing
> > the kernel so that in the first part of hibernation we'll just swap
> > stuff out?
> >
> > On Tue, Oct 8, 2019 at 8:39 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Tue, Oct 8, 2019 at 5:26 PM Luigi Semenzato <semenzato@google.com> wrote:
> > > >
> > > > Thank you for your reply!
> > > >
> > > > I understand the need for saving all state, not just process/task
> > > > state.  But for many of the systems that could benefit from
> > > > hibernation, the majority of RAM is taken by user processes (I am
> > > > thinking laptops).  It should be possible to copy their anonymous
> > > > pages to disk more or less directly, without making an extra copy like
> > > > it's done for all other pages.  I am not sure what happens with kernel
> > > > tasks, but they don't have anonymous pages (that I know).
> > > >
> > > > I am curious to know how/if hibernation is currently used in practice.
> > > > It doesn't seem practical to require that user processes take less
> > > > than 50% of RAM at all times.  There may be special cases in which the
> > > > restriction can be achieved by terminating non-essential processes
> > > > before hibernating, but I don't know of any.
> > > >
> > > > I would also like to know how much work it might take to avoid the
> > > > extra copy of the anonymous pages of frozen processes.
> > >
> > > Whatever doesn't fit into 50% of RAM needs to be swapped out before
> > > hibernation.  The efficiency of that depends on the swap handling code
> > > and the underlying hardware.  If that is efficient enough overall,
> > > trying to avoid it altogether isn't going to make much of a
> > > difference.
