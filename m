Return-Path: <linux-pm+bounces-33977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89935B45760
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 14:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279317C1251
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 12:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A9C34AB06;
	Fri,  5 Sep 2025 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp6kX7w8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F0D3451DC;
	Fri,  5 Sep 2025 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074309; cv=none; b=eoCwl3rXnW+O2eELGOt18r/3B175EhTk1Bk42x99YFK/dUsDOHnZgSFvli/g8Jzbss/ulxuuKGDU1CMVZfn0Zs6VNKiTVTLyyhHpubqUrlKssQt8tVaHasSF5mqbjkjNF4bQxvirViw91nInCTcyoik76hWvqbLXTTTuvF7hC9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074309; c=relaxed/simple;
	bh=3gD2Qhc+5E473h3ua9+XZN5h/7+PHEzeZijzdmHNji0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWPq7uF6aqmDv/zTZ13LZb3rWcDIG2Bv1DGEbfHmAxajAy8ukrelWHJJnqe8R80PLozucEZZYVYYoJsh5v+auIcGN3IBiMgetdFNOLOKYVm3oY0U/3uvYMQuaBcrFMNyVxf/KOF+bz55D0FOwI1TyAk9TVyAMcF7k4b4y96ovW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp6kX7w8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5BBC4CEF1;
	Fri,  5 Sep 2025 12:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757074308;
	bh=3gD2Qhc+5E473h3ua9+XZN5h/7+PHEzeZijzdmHNji0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gp6kX7w8suo7dJu+yQjctDi+MoR8DSiO4B/d6frsKgq7pgwXeM9jhPsC78GkcRPg/
	 kiZl3r1uiaPz7v8iDdvViHUQQBOl3pTucAJSBKmLB5Esi5Xe0zHtxjwnDOWTE8eyBL
	 vLYfsf56cfFA+BwmLqpSK+yYTtP23yUNhoo8NlXT/+W/hO8MR6gwfbWoiyzNy6SDMx
	 e81wnmtUhP3u7GXb4VwT6UVLv0+sKvPuHusXUhGDz4s40ouCxQsGnjaB8ip+fwINRm
	 6p8ng1Mf+SXsInAYq1pNotdWa78dfubVYLtCRswPMjS+j217e//eHEMhtbUPz55mdj
	 mpU43fdgHKVqQ==
Date: Fri, 5 Sep 2025 14:11:43 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Len Brown
 <len.brown@intel.com>, linux-pm@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, Mauro Carvalho Chehab
 <mchehab@kernel.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH v4] kernel.h: add comments for system_states
Message-ID: <20250905140104.42418fba@foz.lan>
In-Reply-To: <6089e22ddfdc135040cdeb69329d817846026728@intel.com>
References: <20250904063631.2364995-1-rdunlap@infradead.org>
	<6089e22ddfdc135040cdeb69329d817846026728@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 05 Sep 2025 12:02:37 +0300
Jani Nikula <jani.nikula@linux.intel.com> escreveu:

> On Wed, 03 Sep 2025, Randy Dunlap <rdunlap@infradead.org> wrote:
> > Provide some basic comments about the system_states and what they imply.
> > Also convert the comments to kernel-doc format.
> >
> > However, kernel-doc does not support kernel-doc notation on extern
> > struct/union/typedef/enum/etc. So I made this a DOC: block so that
> > I can use (insert) it into a Documentation (.rst) file and have it
> > look decent.  
> 
> The simple workaround is to separate the enum type and the variable:
> 
> /**
>  * kernel-doc for the enum
>  */
> enum system_states {
> 	...
> };
> 
> /**
>  * kernel-doc for the variable
>  */
> extern enum system_states system_state;
> 
> BR,
> Jani.
> 
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Acked-by: Rafael J. Wysocki <rafael@kernel.org> # v1
> > ---
> > v2: add Rafael's Ack.
> > v3: add Andrew
> > v4: add DOC: so that this DOC: block can be used in Documentation/
> >     add Greg K-H
> >     add Jon Corbet, Mauro Chehab, & linux-doc
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: linux-pm@vger.kernel.org
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: linux-doc@vger.kernel.org
> > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> > ---
> >  Documentation/driver-api/pm/devices.rst |    8 ++++++++
> >  include/linux/kernel.h                  |   18 ++++++++++++++++--
> >  2 files changed, 24 insertions(+), 2 deletions(-)
> >
> > --- linux-next-20250819.orig/include/linux/kernel.h
> > +++ linux-next-20250819/include/linux/kernel.h
> > @@ -164,8 +164,22 @@ extern int root_mountflags;
> >  
> >  extern bool early_boot_irqs_disabled;
> >  
> > -/*
> > - * Values used for system_state. Ordering of the states must not be changed
> > +/**
> > + * DOC: General system_states available for drivers
> > + *
> > + * enum system_states - Values used for system_state.
> > + *
> > + * * @SYSTEM_BOOTING:	%0, no init needed
> > + * * @SYSTEM_SCHEDULING:	system is ready for scheduling; OK to use RCU
> > + * * @SYSTEM_FREEING_INITMEM: system is freeing all of initmem; almost running
> > + * * @SYSTEM_RUNNING:	system is up and running
> > + * * @SYSTEM_HALT:	system entered clean system halt state
> > + * * @SYSTEM_POWER_OFF:	system entered shutdown/clean power off state
> > + * * @SYSTEM_RESTART:	system entered emergency power off or normal restart
> > + * * @SYSTEM_SUSPEND:	system entered suspend or hibernate state
> > + *
> > + * Note:
> > + * Ordering of the states must not be changed
> >   * as code checks for <, <=, >, >= STATE.
> >   */
> >  extern enum system_states {
> > --- linux-next-20250819.orig/Documentation/driver-api/pm/devices.rst
> > +++ linux-next-20250819/Documentation/driver-api/pm/devices.rst
> > @@ -241,6 +241,14 @@ before reactivating its class I/O queues
> >  More power-aware drivers might prepare the devices for triggering system wakeup
> >  events.
> >  
> > +System states available for drivers
> > +-----------------------------------
> > +
> > +These system states are available for drivers to help them determine how to
> > +handle state transitions.
> > +
> > +.. kernel-doc:: include/linux/kernel.h
> > +   :doc: General system_states available for drivers
> >  
> >  Call Sequence Guarantees
> >  ------------------------
> >  
> 

If the problem is with "extern" before enum, fixing kdoc be
fairly trivial.

If you see:

	def dump_function(self, ln, prototype):
	
     	# Prefixes that would be removed
        sub_prefixes = [
	    ...
	    (r"^extern +", "", 0),	
	    ...
	}

        for search, sub, flags in sub_prefixes:
            prototype = KernRe(search, flags).sub(sub, prototype)


we need something similar to that at:
	def dump_enum(self, ln, proto):

alternatively, we could use a simpler approach modifying adding a
non-group optional match for "extern". E.g:

-	r = KernRe(r'enum\s+(\w*)\s*\{(.*)\}')
+       r = KernRe(r'(?:extern\s+)?enum\s+(\w*)\s*\{(.*)\}')

(untested)

Regards,
Mauro


Thanks,
Mauro

