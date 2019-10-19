Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA21DD60C
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2019 03:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfJSBtU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 21:49:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54096 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfJSBtU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 21:49:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so7878401wmd.3
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2019 18:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8gx1BmqM46WdJVc4Gf2BxUzi9XfzcFz0ScvsTxkV+8I=;
        b=sWtHEsB6ul2jGRYR95HNkgQoUVKB4s+E8M/EmCQ/mq+3HRPpW+v79wzHvWZ+FW+AiO
         KMlg1AKe9UKxsnsQFHHn5oYiHKBWhrHxQ+jeapdmKm8bjSP8mG3F/ECxjHha4quQoP03
         wdgYxGIBd3fIr5sCB1P4QR8PTCjUuwQWXDlIcc5WR8lO7DWLRCE3Jn25mPZqfQIx44St
         JydaJ2QemvFueVrK0yyLv2Zf0PjVkdqNfq1fmsYpfSfUV0mGCM0T4y5+QVQfm1+4KPpB
         NYutBMFYKmDNT0RRmpJeNX1Wk0js7PE27uLo72LrOh00ruH0slBx+MFSGMeKEB7RwTqm
         JXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8gx1BmqM46WdJVc4Gf2BxUzi9XfzcFz0ScvsTxkV+8I=;
        b=pn3uDQWcSqtzP51A/Ma3xGtJnYq0o+ELfQz/ql/P+DUBKJ68h1aC97VjWRugUCr+RY
         Gg3XsR4U3cWxmvCV1h4gKOpYLRTI624s11gSJ/X+yk8WZ50yH2StWbO5HZ4zdypTSlsz
         PmKWP5AfyoO5xW8DqJGN131YDszEbXtKvQ3XfCOnU+lPW+HIfLyitMncRcDx/dVLrDmL
         Kk+6mPpANvjns7ktITVwI/O/2RWIMIsuHALPwJmZtf2R6HmVL1Ir6yenDEx3FiWq+bmw
         7op0dCdXUGlhNda63w6bOgbk58PofDKe5Q4CuI22ntYQLX1CZlIMUx6WyzhztJA+z5+Z
         qLNA==
X-Gm-Message-State: APjAAAXP/WmTunjLmIIg355HmLZlSZlntbCVe5g18dlej5ELg6w1jgQu
        9Y9WrEvwPWOCJpSwmos/t5mzvCCMSUIzj2uvkTGZCQ==
X-Google-Smtp-Source: APXvYqy7WBGcfW3iDAqhA0uZlzezvPdjzAZLfmyPQhHNEhxHBnO2KxjQSw3PzpXH6Jga9rlV3Vzuj4YTyNZMpuUl2Y0=
X-Received: by 2002:a1c:7d08:: with SMTP id y8mr4758419wmc.160.1571449757594;
 Fri, 18 Oct 2019 18:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAA25o9T6C4VCVbqzS0hJgmvpJb6h+htFpH3OUY30E2VtuG8fxQ@mail.gmail.com>
 <56319808-87dc-76ed-c1e0-9f60108e94a6@arm.com> <CAA25o9TpBm+LNwVccTaUng4vQ1Q9_Wz2QftGho7DG_+26CCYoA@mail.gmail.com>
 <CAJZ5v0jCb5jLVQ2Oj0bSNf987apxi7SHx4duX9eALMD6QQXB+w@mail.gmail.com>
 <CAA25o9SUnwc908Grh8qYMDi_tnyhov00Y11RT69MuK8gXcrN4A@mail.gmail.com>
 <CAA25o9TWrLh0o17Epqimsvwe8GoW682jVh_4u2KtjJ7SqKGbsQ@mail.gmail.com> <CAA25o9QKsTwMcuz1yAT7qtnO2rOUVpzkUmnfSLkfRZAFZ_CE9g@mail.gmail.com>
In-Reply-To: <CAA25o9QKsTwMcuz1yAT7qtnO2rOUVpzkUmnfSLkfRZAFZ_CE9g@mail.gmail.com>
From:   Luigi Semenzato <semenzato@google.com>
Date:   Fri, 18 Oct 2019 18:49:04 -0700
Message-ID: <CAA25o9S+QEMkH9TQnAYEaq=7vUZ6caUkFrUB1x-MVqa4Nj+9zA@mail.gmail.com>
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

On Thu, Oct 17, 2019 at 3:55 PM Luigi Semenzato <semenzato@google.com> wrote:
>
> To make hibernation work, I have been playing with this suggestion:
>
> > Whatever doesn't fit into 50% of RAM needs to be swapped out before
> > hibernation.  The efficiency of that depends on the swap handling code
> > and the underlying hardware.  If that is efficient enough overall,
> > trying to avoid it altogether isn't going to make much of a
> > difference.
>
> What's a good way of swapping out 50% of RAM?  I have tried playing
> with /proc/sys/vm/min_free_kbytes.  Lowering it below MemFree forces
> reclaim and gets swapping started.  Unfortunately the reclaim also
> hits file pages, so badly that the system thrashes to a grinding halt.
> Swappiness is already set to 100.  Internally it seems that values up
> to 200 are valid, and I wish that the entire range was allowed, but I
> am not sure it would help.  Right now I am playing with the production
> kernel, but similar situations triggered the same behavior in the
> Chrome OS kernels, even after internally setting swappiness to values
> close to 200.

One more data point: playing with min_free_kbytes is flakey: it can
cause OOM-kills even when I increase it slowly (so that I don't
completely destroy the file RSS) and there is plenty of swap space
available.  Not sure why.

Is there perhaps a way of achieving this using the userland suspend
API?  If there is, I am not able to see it.

Thanks!



> On Tue, Oct 8, 2019 at 1:10 PM Luigi Semenzato <semenzato@google.com> wrote:
> >
> > Actually, I think we only need to change the MM watermarks before
> > hibernation and after resume.  There's a patch that will do just that:
> >
> > https://lkml.org/lkml/2013/2/17/210
> >
> > It didn't make it into mainline (which seems kind of unreasonable,
> > since the watermarks themselves are based on heuristics) but shouldn't
> > be difficult to apply.  Or are there simpler solutions?
> >
> > On Tue, Oct 8, 2019 at 9:18 AM Luigi Semenzato <semenzato@google.com> wrote:
> > >
> > > Yes, that makes sense, thank you.  Use separate partitions for swap
> > > and hibernation.
> > >
> > > Normally the kernel starts swapping out when there's no reclaimable
> > > memory, so anon usage will be high.  Do you think cranking up
> > > /proc/vm/swappiness would be enough to ensure that file pages stay
> > > over 50%?  Or would you use some tricks, such as running a
> > > high-priority process which allocates >50% of RAM, thus forcing other
> > > anon pages to be swapped out, then killing that process and quickly
> > > hibernating before too many pages are brought back in?  Or changing
> > > the kernel so that in the first part of hibernation we'll just swap
> > > stuff out?
> > >
> > > On Tue, Oct 8, 2019 at 8:39 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Tue, Oct 8, 2019 at 5:26 PM Luigi Semenzato <semenzato@google.com> wrote:
> > > > >
> > > > > Thank you for your reply!
> > > > >
> > > > > I understand the need for saving all state, not just process/task
> > > > > state.  But for many of the systems that could benefit from
> > > > > hibernation, the majority of RAM is taken by user processes (I am
> > > > > thinking laptops).  It should be possible to copy their anonymous
> > > > > pages to disk more or less directly, without making an extra copy like
> > > > > it's done for all other pages.  I am not sure what happens with kernel
> > > > > tasks, but they don't have anonymous pages (that I know).
> > > > >
> > > > > I am curious to know how/if hibernation is currently used in practice.
> > > > > It doesn't seem practical to require that user processes take less
> > > > > than 50% of RAM at all times.  There may be special cases in which the
> > > > > restriction can be achieved by terminating non-essential processes
> > > > > before hibernating, but I don't know of any.
> > > > >
> > > > > I would also like to know how much work it might take to avoid the
> > > > > extra copy of the anonymous pages of frozen processes.
> > > >
> > > > Whatever doesn't fit into 50% of RAM needs to be swapped out before
> > > > hibernation.  The efficiency of that depends on the swap handling code
> > > > and the underlying hardware.  If that is efficient enough overall,
> > > > trying to avoid it altogether isn't going to make much of a
> > > > difference.
