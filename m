Return-Path: <linux-pm+bounces-33990-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E81B45942
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 15:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC9F1B23606
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 13:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC2A350D59;
	Fri,  5 Sep 2025 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q33vqLJF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4333451AF;
	Fri,  5 Sep 2025 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079527; cv=none; b=kmbe93ldCB17xaU4MKyVQcMMCbFWWRcnFLkmvVJm6QjEIpCHK6K2AVV4rfHZqef6hehObfcjfuW/9bDALCyOi9eVaPFaxqvnSvjlrqxIFdLGLkL4Qqp+ul4Pgt9KIMi3q+i5XscAPPLfHuoYe7MD71vZiR06AOfg/GZtHLpMr9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079527; c=relaxed/simple;
	bh=Cl155zoOQv6dgu/qZ5T3MWn6Ouqu+4nY0VZi6ERoQYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/YETAG5tKaecmVqEDescMqlugd+q/o5CSzYXTe3j+qrfPhdI+yuk2LF4SaEvi6PFgK7o6mhLXmeN89yhQ7ceIn6PjrNiKWQFfc95KFBTaic8TqK/LYlQla+QLv5Bji+zFfs9KWzPQxNssAaQxDwHHMj2D6ijyiHHoJVzIu8zOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q33vqLJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F288BC4CEF5;
	Fri,  5 Sep 2025 13:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757079527;
	bh=Cl155zoOQv6dgu/qZ5T3MWn6Ouqu+4nY0VZi6ERoQYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q33vqLJF4AhDtyHJv50H8B7q//w8IzccuqsXxSw6I7idUKfnaP5JbOl44yOC49Pzg
	 SXbT4C1F9jnQiF41Wk2n8A3m9e+WlqYr7JbJ2X94av/AWVJTbb0p1XDkQUoZqwclNV
	 izlngGrTk/q3gRFsAUTiNZh4XGKQF1Vy3BZW0GSJPZIf7HxTdjz8kEZSRh0ICeWzJZ
	 hpZgPZzmlDC4O5ng0F0y0cLX9IDXIH2RaI7gCuPtdUeWnANxwMuvF4C0jOlJuLCL0h
	 flVQ4JPWZFkwGpDSgK7d/mu1nwLlyCjyHMfigxm6Zeqnh1i5iZPVyOf+vbCerV5Cxt
	 23PQixXR3gm5w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uuWeL-0000000GuBY-00JJ;
	Fri, 05 Sep 2025 15:38:45 +0200
Date: Fri, 5 Sep 2025 15:38:44 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <mchehab+huawei@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH v4] kernel.h: add comments for system_states
Message-ID: <atj2koasbiuf67rzr7bbdwpu4kcgkdsqt6rhz5vwpbryfqxm7z@mfmts3tnsasf>
References: <20250904063631.2364995-1-rdunlap@infradead.org>
 <6089e22ddfdc135040cdeb69329d817846026728@intel.com>
 <20250905140104.42418fba@foz.lan>
 <34fb6a27a2c17c22c0ac93bebb0bbfd1a04d1833@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34fb6a27a2c17c22c0ac93bebb0bbfd1a04d1833@intel.com>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Fri, Sep 05, 2025 at 04:06:31PM +0300, Jani Nikula wrote:
> On Fri, 05 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > Em Fri, 05 Sep 2025 12:02:37 +0300
> > Jani Nikula <jani.nikula@linux.intel.com> escreveu:
> >
> >> On Wed, 03 Sep 2025, Randy Dunlap <rdunlap@infradead.org> wrote:
> >> > Provide some basic comments about the system_states and what they imply.
> >> > Also convert the comments to kernel-doc format.
> >> >
> >> > However, kernel-doc does not support kernel-doc notation on extern
> >> > struct/union/typedef/enum/etc. So I made this a DOC: block so that
> >> > I can use (insert) it into a Documentation (.rst) file and have it
> >> > look decent.  
> >> 
> >> The simple workaround is to separate the enum type and the variable:
> >> 
> >> /**
> >>  * kernel-doc for the enum
> >>  */
> >> enum system_states {
> >> 	...
> >> };
> >> 
> >> /**
> >>  * kernel-doc for the variable
> >>  */
> >> extern enum system_states system_state;
> >> 
> >> BR,
> >> Jani.
> >> 
> >> >
> >> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> > Acked-by: Rafael J. Wysocki <rafael@kernel.org> # v1
> >> > ---
> >> > v2: add Rafael's Ack.
> >> > v3: add Andrew
> >> > v4: add DOC: so that this DOC: block can be used in Documentation/
> >> >     add Greg K-H
> >> >     add Jon Corbet, Mauro Chehab, & linux-doc
> >> >
> >> > Cc: Andrew Morton <akpm@linux-foundation.org>
> >> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> >> > Cc: Pavel Machek <pavel@ucw.cz>
> >> > Cc: Len Brown <len.brown@intel.com>
> >> > Cc: linux-pm@vger.kernel.org
> >> > Cc: Jonathan Corbet <corbet@lwn.net>
> >> > Cc: linux-doc@vger.kernel.org
> >> > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> >> > Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> >> > ---
> >> >  Documentation/driver-api/pm/devices.rst |    8 ++++++++
> >> >  include/linux/kernel.h                  |   18 ++++++++++++++++--
> >> >  2 files changed, 24 insertions(+), 2 deletions(-)
> >> >
> >> > --- linux-next-20250819.orig/include/linux/kernel.h
> >> > +++ linux-next-20250819/include/linux/kernel.h
> >> > @@ -164,8 +164,22 @@ extern int root_mountflags;
> >> >  
> >> >  extern bool early_boot_irqs_disabled;
> >> >  
> >> > -/*
> >> > - * Values used for system_state. Ordering of the states must not be changed
> >> > +/**
> >> > + * DOC: General system_states available for drivers
> >> > + *
> >> > + * enum system_states - Values used for system_state.
> >> > + *
> >> > + * * @SYSTEM_BOOTING:	%0, no init needed
> >> > + * * @SYSTEM_SCHEDULING:	system is ready for scheduling; OK to use RCU
> >> > + * * @SYSTEM_FREEING_INITMEM: system is freeing all of initmem; almost running
> >> > + * * @SYSTEM_RUNNING:	system is up and running
> >> > + * * @SYSTEM_HALT:	system entered clean system halt state
> >> > + * * @SYSTEM_POWER_OFF:	system entered shutdown/clean power off state
> >> > + * * @SYSTEM_RESTART:	system entered emergency power off or normal restart
> >> > + * * @SYSTEM_SUSPEND:	system entered suspend or hibernate state
> >> > + *
> >> > + * Note:
> >> > + * Ordering of the states must not be changed
> >> >   * as code checks for <, <=, >, >= STATE.
> >> >   */
> >> >  extern enum system_states {
> >> > --- linux-next-20250819.orig/Documentation/driver-api/pm/devices.rst
> >> > +++ linux-next-20250819/Documentation/driver-api/pm/devices.rst
> >> > @@ -241,6 +241,14 @@ before reactivating its class I/O queues
> >> >  More power-aware drivers might prepare the devices for triggering system wakeup
> >> >  events.
> >> >  
> >> > +System states available for drivers
> >> > +-----------------------------------
> >> > +
> >> > +These system states are available for drivers to help them determine how to
> >> > +handle state transitions.
> >> > +
> >> > +.. kernel-doc:: include/linux/kernel.h
> >> > +   :doc: General system_states available for drivers
> >> >  
> >> >  Call Sequence Guarantees
> >> >  ------------------------
> >> >  
> >> 
> >
> > If the problem is with "extern" before enum, fixing kdoc be
> > fairly trivial.
> 
> The non-trivial part is deciding whether you're documenting the enum
> type or the variable. Both are equally valid options.

True.

I'd say that, if the variable is under EXPORT_SYMBOL macros, it
should be documented.

The same applies to the enum: if it is used by kAPI, it should
also be documented.

So, yeah, I suspect that on most kAPI cases, the best is to split,
having documentation for both.

> 
> BR,
> Jani.
> 
> >
> > If you see:
> >
> > 	def dump_function(self, ln, prototype):
> > 	
> >      	# Prefixes that would be removed
> >         sub_prefixes = [
> > 	    ...
> > 	    (r"^extern +", "", 0),	
> > 	    ...
> > 	}
> >
> >         for search, sub, flags in sub_prefixes:
> >             prototype = KernRe(search, flags).sub(sub, prototype)
> >
> >
> > we need something similar to that at:
> > 	def dump_enum(self, ln, proto):
> >
> > alternatively, we could use a simpler approach modifying adding a
> > non-group optional match for "extern". E.g:
> >
> > -	r = KernRe(r'enum\s+(\w*)\s*\{(.*)\}')
> > +       r = KernRe(r'(?:extern\s+)?enum\s+(\w*)\s*\{(.*)\}')
> >
> > (untested)
> >
> > Regards,
> > Mauro
> >
> >
> > Thanks,
> > Mauro
> 
> -- 
> Jani Nikula, Intel

-- 
Thanks,
Mauro

