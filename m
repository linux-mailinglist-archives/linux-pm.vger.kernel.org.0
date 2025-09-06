Return-Path: <linux-pm+bounces-34044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBDBB46A4B
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 10:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81061BC74F7
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 08:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD97628B7DA;
	Sat,  6 Sep 2025 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqjILkBZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08321DFDA1;
	Sat,  6 Sep 2025 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757148993; cv=none; b=DsxwvLu72gi+E7yEcslYKHjTZ3+lfh9VsT9VzHBzv/1iOrJWnK7ksKMxgV9Da5CJdI6VzjL3OE8I7d4533Mmwd7bLatLDgDmuc1SMec4ZU4nyHOnp9Zgl8DBdV+wEBPK1A3fZhcTXMJNQ522Ue+f8Ve4ZAriVfEHYSTdarzkO6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757148993; c=relaxed/simple;
	bh=v1shXLqxH0t05bzRbUG3PL919n2QCL2v5A4OOPOOdpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3dBUWvjb2vM9teNdJJVEW/c3IChiatOk2aC1HUCXwBB5If2iWddm1UG5n93CPyqiu8jmrSgP6YFUL/LhAB/vhWKak/9VoSZ/Nyg8Vz/1dWupng78mp0pQ+lKdhyJxbuh5m++GxHP4mnbJYEb3NmKCR2PEOEgd2JSKQtoRY+L4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqjILkBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F404DC4CEE7;
	Sat,  6 Sep 2025 08:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757148993;
	bh=v1shXLqxH0t05bzRbUG3PL919n2QCL2v5A4OOPOOdpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jqjILkBZCh2irmvYyDyNu6GEnrXIzDPtiZbVrlQOY33eC6R4CX+jXg6MHb7XKW3EB
	 9SDSNpGmVoVHaoPhULMYX/NIptPs4JVazTFTcChDVTsZSCSI9kXB0uiBtxsyVbXpVF
	 OLhgjIIMMlwf5N9fEWXNCby4BT/+keTIt38BODu+D0i11HXzD1B0/QyD6K7nqVfwSl
	 VQ3qc2ShZ5xxUBw6QskXKIQIiFRnRTnsYgFRQgb1ijsk/zBndeMpvbX6ES50uvOd7q
	 3q2ACG7HC3WsxwzyaraE6dTKppF6VDSr8QwD0VMe92Gl+WfZ+QcENlOSivE5KT3i5O
	 P9p64uENHM0Fg==
Date: Sat, 6 Sep 2025 10:56:27 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Len Brown
 <len.brown@intel.com>, linux-pm@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH v4] kernel.h: add comments for system_states
Message-ID: <20250906105627.2c0cd0d9@foz.lan>
In-Reply-To: <2aad4540-ccdd-4519-9bed-7d8c7ccd009d@infradead.org>
References: <20250904063631.2364995-1-rdunlap@infradead.org>
	<6089e22ddfdc135040cdeb69329d817846026728@intel.com>
	<20250905140104.42418fba@foz.lan>
	<34fb6a27a2c17c22c0ac93bebb0bbfd1a04d1833@intel.com>
	<atj2koasbiuf67rzr7bbdwpu4kcgkdsqt6rhz5vwpbryfqxm7z@mfmts3tnsasf>
	<2aad4540-ccdd-4519-9bed-7d8c7ccd009d@infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 5 Sep 2025 15:07:31 -0700
Randy Dunlap <rdunlap@infradead.org> escreveu:

> Hi,
> 
> On 9/5/25 6:38 AM, Mauro Carvalho Chehab wrote:
> > On Fri, Sep 05, 2025 at 04:06:31PM +0300, Jani Nikula wrote:  
> >> On Fri, 05 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:  
> >>> Em Fri, 05 Sep 2025 12:02:37 +0300
> >>> Jani Nikula <jani.nikula@linux.intel.com> escreveu:
> >>>  
> >>>> On Wed, 03 Sep 2025, Randy Dunlap <rdunlap@infradead.org> wrote:  
> >>>>> Provide some basic comments about the system_states and what they imply.
> >>>>> Also convert the comments to kernel-doc format.
> >>>>>
> >>>>> However, kernel-doc does not support kernel-doc notation on extern
> >>>>> struct/union/typedef/enum/etc. So I made this a DOC: block so that
> >>>>> I can use (insert) it into a Documentation (.rst) file and have it
> >>>>> look decent.    
> >>>>
> >>>> The simple workaround is to separate the enum type and the variable:
> >>>>
> >>>> /**
> >>>>  * kernel-doc for the enum
> >>>>  */
> >>>> enum system_states {
> >>>> 	...
> >>>> };
> >>>>
> >>>> /**
> >>>>  * kernel-doc for the variable
> >>>>  */
> >>>> extern enum system_states system_state;
> >>>>
> >>>> BR,
> >>>> Jani.
> >>>>  
> >>>>>
> >>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >>>>> Acked-by: Rafael J. Wysocki <rafael@kernel.org> # v1
> >>>>> ---  
> 
> [snip]
> >>> If the problem is with "extern" before enum, fixing kdoc be
> >>> fairly trivial.  
> >>
> >> The non-trivial part is deciding whether you're documenting the enum
> >> type or the variable. Both are equally valid options.  
> > 
> > True.
> > 
> > I'd say that, if the variable is under EXPORT_SYMBOL macros, it
> > should be documented.  
> 
> Do you mean documented with kernel-doc? How do we do that?
> I was under the impression that we don't currently have a way to
> use kernel-doc for variables (definitions, only for declarations).

No, but it shouldn't be hard to add something like:

	/**
	 * global system_state - stores system state
	 * <some description>
	 */
	extern enum system_states system_state;  

and place a dump_global() function at kdoc parser. Ok, one might use
DOC:, but IMHO the best is to have a proper handler for it that would
automatically pick the type.

> > The same applies to the enum: if it is used by kAPI, it should
> > also be documented.
> > 
> > So, yeah, I suspect that on most kAPI cases, the best is to split,
> > having documentation for both.
> >   
> >>
> >> BR,
> >> Jani.
> >>  
> >>>
> >>> If you see:
> >>>
> >>> 	def dump_function(self, ln, prototype):
> >>> 	
> >>>      	# Prefixes that would be removed
> >>>         sub_prefixes = [
> >>> 	    ...
> >>> 	    (r"^extern +", "", 0),	
> >>> 	    ...
> >>> 	}
> >>>
> >>>         for search, sub, flags in sub_prefixes:
> >>>             prototype = KernRe(search, flags).sub(sub, prototype)
> >>>
> >>>
> >>> we need something similar to that at:
> >>> 	def dump_enum(self, ln, proto):
> >>>
> >>> alternatively, we could use a simpler approach modifying adding a
> >>> non-group optional match for "extern". E.g:
> >>>
> >>> -	r = KernRe(r'enum\s+(\w*)\s*\{(.*)\}')
> >>> +       r = KernRe(r'(?:extern\s+)?enum\s+(\w*)\s*\{(.*)\}')
> >>>
> >>> (untested)  
> 
> Yes, this might work. It might also lead to documenting more than
> was intended. It seems safer just to do the enum declaration and
> variable definition split light Jani suggested.

Yeah, the extra var at the end may be problematic, although it
wouldn't be hard to drop or parse it, like:

	/**
	 * enum system_states - Values used for system_state.
	 *
	 * @SYSTEM_BOOTING:	%0, no init needed
	 * @SYSTEM_SCHEDULING: system is ready for scheduling; OK to use RCU
	 * @SYSTEM_FREEING_INITMEM: system is freeing all of initmem; almost running
	 * @SYSTEM_RUNNING:	system is up and running
	 * @SYSTEM_HALT:	system entered clean system halt state
	 * @SYSTEM_POWER_OFF:	system entered shutdown/clean power off state
	 * @SYSTEM_RESTART:	system entered emergency power off or normal restart
	 * @SYSTEM_SUSPEND:	system entered suspend or hibernate state
	 *
	 * @system_state: global var describing the current system state.
 	 *
	 * Note:
	 * Ordering of the states must not be changed
	 * as code checks for <, <=, >, >= STATE.
	 */
	extern enum system_states {
	 	SYSTEM_BOOTING,
	 	SYSTEM_SCHEDULING,
	 	SYSTEM_FREEING_INITMEM,
		SYSTEM_RUNNING,
		SYSTEM_HALT,
	 	SYSTEM_POWER_OFF,
	 	SYSTEM_RESTART,
	 	SYSTEM_SUSPEND,
	} system_state;

making it create two separate entries: one for the enum, and another one for
the global var - internally calling dump_global() for the var.

Thanks,
Mauro

