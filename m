Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD8B7E0E78
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 01:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732530AbfJVXQ5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 19:16:57 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:45026 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfJVXQ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 19:16:57 -0400
Received: by mail-oi1-f179.google.com with SMTP id s71so2871516oih.11;
        Tue, 22 Oct 2019 16:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o7ny16/mnyqk5KkvAfWXHyW+yD70otI87QA0VLCTMkw=;
        b=UuoZGqKuzbC0bUtrcpzDgbFcjnh1+c69186xZh75Veey32L1ZZLCFOaTqszVSc4yeb
         GR+JK4esuiRfNYbOO2Mw4735KubXm/VM4qC62go0Ez2+mj5m+U+GgY63vmH6m4G+WzBY
         t0HiK2jrZcfDejH3ynWG1MEIHCi4o9fTaGC0TavLzeupKG6ZRTwbBH0t2Ou9Hqr6sd4t
         ZkhWqlTRILZY6DRUxSTcbNxPOzBqVAA0ELKqN4euU4+gQbleF62lAWiARA6WBfGOIPpU
         YA/x31ywD8qwihvQeGAOa5qSZvxq55UXyFPpd7BaSrc9E6EWsCq7cRlW9RisApeOWwnp
         rdjA==
X-Gm-Message-State: APjAAAXwntdH/dZZk800Dam0iAnnHs3knQOWkeVklweeG8zqIesaIsiF
        PSH3cN+Jat13R0GjRinu4UIikMt0DdO3WYDErsFteG5P
X-Google-Smtp-Source: APXvYqxYf8YWXu5+u/mwjWAbrC38MXvHAb1sDdX7TSSBvj5NQHLohbDCObbbjBrsoIqtGSJL4ByZXive0vcGLIwkPdM=
X-Received: by 2002:a05:6808:9b7:: with SMTP id e23mr752573oig.68.1571786215994;
 Tue, 22 Oct 2019 16:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAA25o9TABY=3C+FQEg8FDyF1rim315G2hmeB1DBWJLn-wG1j0g@mail.gmail.com>
 <CAJZ5v0gJWxLJTi7TjaRP-3aR3f4VnX1n9dRE_jxdS6e3SM46LQ@mail.gmail.com>
 <CAA25o9TiaaKGH4ZkOa=FhZW7PdXQ592YZ4q52o-QNx=yFsR4Pw@mail.gmail.com>
 <CAJZ5v0j7N=o0S1tSwn5DP10oAmb5oN5SsM3jWhs+ZJ2YxMEvnw@mail.gmail.com> <CAA25o9Rd5x7PjFkrhWL-vqfV9uEYKA4K2K=9t1V7TY2OKX+k6g@mail.gmail.com>
In-Reply-To: <CAA25o9Rd5x7PjFkrhWL-vqfV9uEYKA4K2K=9t1V7TY2OKX+k6g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Oct 2019 01:16:45 +0200
Message-ID: <CAJZ5v0jDwUi4dU5zjCWuRAYEbg63xJadE=Fdr_OY7UcU82q94w@mail.gmail.com>
Subject: Re: is hibernation usable?
To:     Luigi Semenzato <semenzato@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geoff Pike <gpike@google.com>, Bas Nowaira <bassem@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 23, 2019 at 12:53 AM Luigi Semenzato <semenzato@google.com> wrote:
>
> On Tue, Oct 22, 2019 at 3:14 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Oct 22, 2019 at 11:26 PM Luigi Semenzato <semenzato@google.com> wrote:
> > >
> > > Thank you for the quick reply!
> > >
> > > On Tue, Oct 22, 2019 at 1:57 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Tue, Oct 22, 2019 at 10:09 PM Luigi Semenzato <semenzato@google.com> wrote:
> > > > >
> > > > > Following a thread in linux-pm
> > > > > (https://marc.info/?l=linux-mm&m=157012300901871) I have some issues
> > > > > that may be of general interest.
> > > > >
> > > > > 1. To the best of my knowledge, Linux hibernation is guaranteed to
> > > > > fail if more than 1/2 of total RAM is in use (for instance, by
> > > > > anonymous pages).  My knowledge is based on evidence, experiments,
> > > > > code inspection, the thread above, and a comment in
> > > > > Documentation/swsusp.txt, copied here:
> > > >
> > > > So I use it on a regular basis (i.e. every day) on a system that often
> > > > has over 50% or RAM in use and it all works.
> > > >
> > > > I also know about other people using it on a regular basis.
> > > >
> > > > For all of these users, it is usable.
> > > >
> > > > >  "Instead, we load the image into unused memory and then atomically
> > > > > copy it back to it original location. This implies, of course, a
> > > > > maximum image size of half the amount of memory."
> > > >
> > > > That isn't right any more.  An image that is loaded during resume can,
> > > > in fact, be larger than 50% of RAM.  An image that is created during
> > > > hibernation, however, cannot.
> > >
> > > Sorry, I don't understand this.  Are you saying that, for instance,
> > > you can resume a 30 GB image on a 32 GB device, but that image could
> > > only have been created on a 64 GB device?
> >
> > Had it been possible to create images larger than 50% of memory during
> > hibernation, it would have been possible to load them during resume as
> > well.
> >
> > The resume code doesn't have a 50% of RAM limitation, the image
> > creation code does.
>
> Thanks a lot for the clarifications.
>
> It is possible that you and I have different definitions of "working
> in general".  My main issue ia that I would like image creation (i.e.
> entering hibernation) to work with >50% of RAM in use, and I am
> extrapolating that other people would like that too.  I can see that
> there are many uses where this is not needed though, especially if you
> mostly care about resume.

Also note that you need to be precise about what ">50% of RAM in use"
means.  For example, AFAICS hibernation works just fine for many cases
in which MemFree is way below 50% of MemTotal.

> >
> > > > > 2. There's no simple/general workaround.  Rafael suggested on the
> > > > > thread "Whatever doesn't fit into 50% of RAM needs to be swapped out
> > > > > before hibernation".  This is a good suggestion: I am actually close
> > > > > to achieving this using memcgroups, but it's a fair amount of work,
> > > > > and a fairly special case.  Not everybody uses memcgroups, and I don't
> > > > > know of other reliable ways of forcing swap from user level.
> > > >
> > > > I don't need to do anything like that.
> > >
> > > Again, I don't understand.  Why did you make that suggestion then?
> > >
> > > > hibernate_preallocate_memory() manages to free a sufficient amount of
> > > > memory on my system every time.
> > >
> > > Unfortunately this doesn't work for me.  I may have described a simple
> > > experiment: on a 4GB device, create two large processes like this:
> > >
> > > dd if=/dev/zero bs=1100M count=1 | sleep infinity &
> > > dd if=/dev/zero bs=1100M count=1 | sleep infinity &
> > >
> > > so that more than 50% of TotalMem is used for anonymous pages.  Then
> > > echo disk > /sys/power/state fails with ENOMEM.
> >
> > I guess hibernate_preallocate_memory() is not able to free enough
> > memory for itself in that case.
> >
> > > Is this supposed to work?
> >
> > Yes, it is, in general.
> >
> > > Maybe I am doing something wrong?
> > > Hibernation works before I create the dd processes.  After I force
> > > some of those pages to a separate swap device, hibernation works too,
> > > so those pages aren't mlocked or anything.
> >
> > It looks like you are doing something that is not covered by
> > hibernate_preallocate_memory().
> >
> > > > > 3. A feature that works only when 1/2 of total RAM can be allocated
> > > > > is, in my opinion, not usable, except possibly under special
> > > > > circumstances, such as mine. Most of the available articles and
> > > > > documentation do not mention this important fact (but for the excerpt
> > > > > I mentioned, which is not in a prominent position).
> > > >
> > > > It can be used with over 1/2 of RAM allocated and that is quite easy
> > > > to demonstrate.
> > > >
> > > > Honestly, I'm not sure what your problem is really.
> > >
> > > I apologize if I am doing something stupid and I should know better
> > > before I waste other people's time.  I have been trying to explain
> > > these issues as best as I can.  I have a reproducible failure.  I'll
> > > be happy to provide any additional detail.
> >
> > Simply put, hibernation, as implemented today, needs to allocate over
> > 50% of RAM (or at least as much as to be able to copy all of the
> > non-free pages) for image creation.  If it cannot do that, it will
> > fail and you know how to prevent it from allocating enough memory in a
> > reproducible way.  AFAICS that's a situation in which every attempt to
> > allocate 50% of memory for any other purpose will fail as well.
> >
> > Frankly, you are first to report this problem, so it arguably is not
> > common.  It looks like hibernate_preallocate_memory() may be improved
> > to cover that case, but then the question is how much more complicated
> > it will have to become for this purpose and whether or not that's
> > worth pursuing.
>
> Right.  I was hoping to discuss that.  Is it easier to do in the
> kernel what I am trying to do at user level, i.e. force swap of excess
> pages (possibly to a separate device or partition) so that enough
> pages are freed up to make hibernate_preallocate_memory always
> succeed?

It should at least be possible to do that, but it's been a while since
I last looked at hibernate_preallocate_memory() etc.

> I started reading the swap code, but it is entangled with
> page reclaim and I haven't seen a simple solution, neither do I know
> if there is one and how long it would take to find it, or code around
> it.  (However I haven't looked yet at how it works when memcgroup
> limits are lowered---that may give me good ideas).
