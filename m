Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4529C4C0D2
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 20:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfFSSf0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 14:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfFSSf0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Jun 2019 14:35:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00F55214AF;
        Wed, 19 Jun 2019 18:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560969325;
        bh=ZSXk5yQY5JgmMnKoJZp5pJgU23ioYLFdLftxt75KSUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=02DXmPJFYgSNzzsFki+MxmAyHDdHNWPBCaKNAYd4HmV/t2wmOIklt9U7P+VZnV+Rz
         bcdnh9SjtN/cdTKhJCLgKcpMi8Td9fVE85dyCBm75Kw9cbiFEO1ch+FKsLFoxb0vO+
         TpaxZZffvoAfEd4dTfO5JMSWwT2iMvdrbggqfoI0=
Date:   Wed, 19 Jun 2019 20:35:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joel Fernandes <joelaf@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tri Vo <trong@android.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sandeep Patil <sspatil@android.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@fb.com>
Subject: Re: Alternatives to /sys/kernel/debug/wakeup_sources
Message-ID: <20190619183523.GA7018@kroah.com>
References: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com>
 <CANA+-vARQ9Ao=W1oEArrAQ0sqh757orq=-=kytdVPhstm-3E9w@mail.gmail.com>
 <20190618182502.GC203031@google.com>
 <4587569.x9DSL43cXO@kreacher>
 <CANA+-vCMK6u1n9gXf2+v5dFn_tGfr1PT8d7W4d2BCzw+B-HvYw@mail.gmail.com>
 <CAJWu+oo7kwmEyMXQN0yfswV2=J-Fa9QybhAUx-SOGG_ipsBErQ@mail.gmail.com>
 <CAJZ5v0gvzCx-7qS9qkxB=sGKjQJKMR7yCc21f=_vqrbZxMSWNg@mail.gmail.com>
 <CAJWu+oqSgcBVhDY7CjWpNQrK=XiKAb5S-YSp=6-UM--UFmKvGQ@mail.gmail.com>
 <20190619170750.GB10107@kroah.com>
 <CAJWu+ookFTYGfSvJ3otpFQixG2kbkJGOqf7HHUeYNQAQv2Cskw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+ookFTYGfSvJ3otpFQixG2kbkJGOqf7HHUeYNQAQv2Cskw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 19, 2019 at 02:01:36PM -0400, Joel Fernandes wrote:
> On Wed, Jun 19, 2019 at 1:07 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jun 19, 2019 at 12:53:12PM -0400, Joel Fernandes wrote:
> > > > It is conceivable to have a "wakeup_sources" directory under
> > > > /sys/power/ and sysfs nodes for all wakeup sources in there.
> > >
> > > One of the "issues" with this is, now if you have say 100 wake up
> > > sources, with 10 entries each, then we're talking about a 1000 sysfs
> > > files. Each one has to be opened, and read individually. This adds
> > > overhead and it is more convenient to read from a single file. The
> > > problem is this single file is not ABI. So the question I guess is,
> > > how do we solve this in both an ABI friendly way while keeping the
> > > overhead low.
> >
> > How much overhead?  Have you measured it, reading from virtual files is
> > fast :)
> 
> I measured, and it is definitely not free. If you create and read a
> 1000 files and just return a string back, it can take up to 11-13
> milliseconds (did not lock CPU frequencies, was just looking for
> average ball park). This is assuming that the counter reading is just
> doing that, and nothing else is being done to return the sysfs data
> which is probably not always true in practice.
> 
> Our display pipeline deadline is around 16ms at 60Hz. Conceivably, any
> CPU scheduling competion reading sysfs can hurt the deadline. There's
> also the question of power - we definitely have spent time in the past
> optimizing other virtual files such as /proc/pid/smaps for this reason
> where it spent lots of CPU time.

smaps was "odd", but that was done after measurements were actually made
to prove it was needed.  That hasn't happened yet :)

And is there a reason you have to do this every 16ms?

> > And how often does this happen?  Does it _need_ to happen?
> 
> These are good questions and we should find out. I am not saying that
> sysfs will not work, I am just saying we need to consider all the
> things. I will let Tri look into this since he is working on it, I
> don't know off the top.
> 
> > Parsing files is also hard, and not for sysfs files, you can't have it
> > both ways.
> 
> I don't think we are concerned with a parsing issue here, or are
> discussing it in this thread.
> 
> > So try it this way, and if there really is a performance issue, we can
> > then talk about it...
> 
> Sure that sounds good to me, again I am not saying we should do sysfs.
> But we should consider all the issues and chose the right solution.

Figure out who needs this, how often it needs it, and how many files
really are going to be involved before we try to optimize anything.

thanks,

greg k-h
