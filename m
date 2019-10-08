Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E28D01EA
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2019 22:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbfJHULH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Oct 2019 16:11:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46651 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbfJHULH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Oct 2019 16:11:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id o18so20831142wrv.13
        for <linux-pm@vger.kernel.org>; Tue, 08 Oct 2019 13:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zRkRhcx1S5ZqWKlDmiJVwEoGZ+yDHNmQqx+oKN4Jgv8=;
        b=AtOd3TWDRf/o/4Bk21hI1q1YaTWWdaG3kfNytZ/qPPqQn0JmyK/rui2r0EuMm8vE2N
         Np/9eOnnhAfrOMxdeGVmpMNNUITk/jZ0GxMsHDhFh98bjdETUHvlBY2H2yWdhLUbI3W5
         vOw1QD0teRf5YvXCnUOhW96QuhDy8himtKuUpNv4e8Cbmhg7SsZTzok5JiGonwy3xyCF
         F5Ed/T8RqitQMrGPS8M9hZq/uA/ExeBWPyxPR4ynWQ+mri6r3sRTW7Pq+bKlCVlSkT7+
         AmUR5uR3NbMZ6Yc37l6ZxQyjo9BNg3wNZWoK0wGtnUY7GBdQj5t/AJWTt9Ft4SABFuL4
         uzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zRkRhcx1S5ZqWKlDmiJVwEoGZ+yDHNmQqx+oKN4Jgv8=;
        b=jGHmztQ40/lQ3Da1hGa64Rpk0CP0XWImLTv3wvS26lsXDgtJpRC0iGe+HzbZ376wLT
         aOLyRGXUI7cDXAjRWmNZIdMPWaV6KpoRVWMP86JJYjQYPYPckuC0CK3mzs1fMMFmnKNt
         6/TITCfrNhjjXRlZSRi/oQI+S6PGfTxruMspWfWhITM6pV0w0/hDKDeTURRAPe50vgtx
         ktBSUH67kxkIu/0xA+ESaJnxBabJ9siYfDDFGOz6bf1R7qRUdYLvY7JtzFjgFmpyeTAP
         KH/mXk7XpkZu5gxQT4BSjoa9Pa5O6gWu3/WfFAqUWNyzRFsfrYBL4i0v7LiDJoE6vrIR
         sWgw==
X-Gm-Message-State: APjAAAUIuyjiY0QAFvjZQ5IXS1hTE3kUXIncsa7ranWZHUJNbUDWWB3n
        Gl5ZMXz8qDSJM3JlIw3OVGaIRbgYUYv1KmWmAPZ+Ug==
X-Google-Smtp-Source: APXvYqwecQ8I1R5sloUUyTYf0HUKBV5L5CNFDnDEzLhwHMC1MDTm+0cieCjDImMOjidyvRvF2c1VqO+N08z5SbZTKEw=
X-Received: by 2002:adf:f7ce:: with SMTP id a14mr15752442wrq.239.1570565464249;
 Tue, 08 Oct 2019 13:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAA25o9T6C4VCVbqzS0hJgmvpJb6h+htFpH3OUY30E2VtuG8fxQ@mail.gmail.com>
 <56319808-87dc-76ed-c1e0-9f60108e94a6@arm.com> <CAA25o9TpBm+LNwVccTaUng4vQ1Q9_Wz2QftGho7DG_+26CCYoA@mail.gmail.com>
 <CAJZ5v0jCb5jLVQ2Oj0bSNf987apxi7SHx4duX9eALMD6QQXB+w@mail.gmail.com> <CAA25o9SUnwc908Grh8qYMDi_tnyhov00Y11RT69MuK8gXcrN4A@mail.gmail.com>
In-Reply-To: <CAA25o9SUnwc908Grh8qYMDi_tnyhov00Y11RT69MuK8gXcrN4A@mail.gmail.com>
From:   Luigi Semenzato <semenzato@google.com>
Date:   Tue, 8 Oct 2019 13:10:52 -0700
Message-ID: <CAA25o9TWrLh0o17Epqimsvwe8GoW682jVh_4u2KtjJ7SqKGbsQ@mail.gmail.com>
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

Actually, I think we only need to change the MM watermarks before
hibernation and after resume.  There's a patch that will do just that:

https://lkml.org/lkml/2013/2/17/210

It didn't make it into mainline (which seems kind of unreasonable,
since the watermarks themselves are based on heuristics) but shouldn't
be difficult to apply.  Or are there simpler solutions?

On Tue, Oct 8, 2019 at 9:18 AM Luigi Semenzato <semenzato@google.com> wrote:
>
> Yes, that makes sense, thank you.  Use separate partitions for swap
> and hibernation.
>
> Normally the kernel starts swapping out when there's no reclaimable
> memory, so anon usage will be high.  Do you think cranking up
> /proc/vm/swappiness would be enough to ensure that file pages stay
> over 50%?  Or would you use some tricks, such as running a
> high-priority process which allocates >50% of RAM, thus forcing other
> anon pages to be swapped out, then killing that process and quickly
> hibernating before too many pages are brought back in?  Or changing
> the kernel so that in the first part of hibernation we'll just swap
> stuff out?
>
> On Tue, Oct 8, 2019 at 8:39 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Oct 8, 2019 at 5:26 PM Luigi Semenzato <semenzato@google.com> wrote:
> > >
> > > Thank you for your reply!
> > >
> > > I understand the need for saving all state, not just process/task
> > > state.  But for many of the systems that could benefit from
> > > hibernation, the majority of RAM is taken by user processes (I am
> > > thinking laptops).  It should be possible to copy their anonymous
> > > pages to disk more or less directly, without making an extra copy like
> > > it's done for all other pages.  I am not sure what happens with kernel
> > > tasks, but they don't have anonymous pages (that I know).
> > >
> > > I am curious to know how/if hibernation is currently used in practice.
> > > It doesn't seem practical to require that user processes take less
> > > than 50% of RAM at all times.  There may be special cases in which the
> > > restriction can be achieved by terminating non-essential processes
> > > before hibernating, but I don't know of any.
> > >
> > > I would also like to know how much work it might take to avoid the
> > > extra copy of the anonymous pages of frozen processes.
> >
> > Whatever doesn't fit into 50% of RAM needs to be swapped out before
> > hibernation.  The efficiency of that depends on the swap handling code
> > and the underlying hardware.  If that is efficient enough overall,
> > trying to avoid it altogether isn't going to make much of a
> > difference.
