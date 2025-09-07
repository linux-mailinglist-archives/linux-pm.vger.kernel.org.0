Return-Path: <linux-pm+bounces-34114-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92513B48074
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 23:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753B6189D4DD
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 21:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB5D27AC54;
	Sun,  7 Sep 2025 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMhAGVvT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF3D219ED;
	Sun,  7 Sep 2025 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757281582; cv=none; b=LwRLdjWpT1SNRsveKjlLm4n1ks+323Taq5cuw0phFRreiuMREHDZPsU9CnqN/XcsCNg4QZEDSd/Yfb26RWu1lRlYpW3wZ0PjSJl5P2LZRYY6TES0+ubkb/hA3T4tTXkru7NTQ0lgKiI3eMuYw/4dmy0D9ysQsnSPxdR4rIRfb4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757281582; c=relaxed/simple;
	bh=rg9+K3wBakczakrazyxmSEmfRgnIztrz72yZBaC/Uzw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBp2m7GNQzZ0QpL4GFBU+QObLNkyGCSPDpbtnNUo1qCqkRWEQ6IEofVNAyVbDNyU0JtyMCp7oqFzj6M5vGvfFZvywO0OQ5tYm7qb4eKaTPxqpXB1yIPkN+Lwl0/yQJMh74gBFJ5EDWExe5j+dsbRL+jvGKQuoZnUgpLvUJjCW8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMhAGVvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9F7C4CEF0;
	Sun,  7 Sep 2025 21:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757281581;
	bh=rg9+K3wBakczakrazyxmSEmfRgnIztrz72yZBaC/Uzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MMhAGVvT+2211KLdLvGAOCvJleUqT5zCQUjQefdnFqmJA+2Ri9WIBAIwzTxBmPojU
	 udfYalxv797ZkuIVxgGrhyuBGRGUkWUKcJgoYMvK2QMqCgQFtKNcFwnX8tSVgXspfa
	 QZ+TJecx/wQJRdC6VBYP0hItgq6vYefMjGAxHQ9U1Qf0aRBgHA9HZDHKw26Msv6nMu
	 P0ZxYRBPmTKxxZlFqg+ti2EEs4uCO840bRnmLhXvVkU4bdzEM7MyT60Wse6GU0L6DR
	 0KPqzXKATw8X+A9NqG4t+hbF60A+Gaz3TjWzpIjJJ2/5094XxrIXQKRyeTG+oJplvV
	 h2uiVWr3AOHvA==
Date: Sun, 7 Sep 2025 23:46:16 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Len Brown
 <len.brown@intel.com>, linux-pm@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH v4] kernel.h: add comments for system_states
Message-ID: <20250907234616.134dbda4@foz.lan>
In-Reply-To: <d815f5c3-6e15-4758-8bf4-601d5543cab9@infradead.org>
References: <20250904063631.2364995-1-rdunlap@infradead.org>
	<6089e22ddfdc135040cdeb69329d817846026728@intel.com>
	<20250905140104.42418fba@foz.lan>
	<34fb6a27a2c17c22c0ac93bebb0bbfd1a04d1833@intel.com>
	<atj2koasbiuf67rzr7bbdwpu4kcgkdsqt6rhz5vwpbryfqxm7z@mfmts3tnsasf>
	<2aad4540-ccdd-4519-9bed-7d8c7ccd009d@infradead.org>
	<20250906105627.2c0cd0d9@foz.lan>
	<d815f5c3-6e15-4758-8bf4-601d5543cab9@infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sat, 6 Sep 2025 10:13:23 -0700
Randy Dunlap <rdunlap@infradead.org> escreveu:

> On 9/6/25 1:56 AM, Mauro Carvalho Chehab wrote:
> > Em Fri, 5 Sep 2025 15:07:31 -0700
> > Randy Dunlap <rdunlap@infradead.org> escreveu:
> >   
> >> Hi,
> >>
> >> On 9/5/25 6:38 AM, Mauro Carvalho Chehab wrote:  
> >>> On Fri, Sep 05, 2025 at 04:06:31PM +0300, Jani Nikula wrote:    
> >>>> On Fri, 05 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:    
> >>>>> Em Fri, 05 Sep 2025 12:02:37 +0300
> >>>>> Jani Nikula <jani.nikula@linux.intel.com> escreveu:
> >>>>>    
> >>>>>> On Wed, 03 Sep 2025, Randy Dunlap <rdunlap@infradead.org> wrote:    
> >>>>>>> Provide some basic comments about the system_states and what they imply.
> >>>>>>> Also convert the comments to kernel-doc format.
> >>>>>>>
> >>>>>>> However, kernel-doc does not support kernel-doc notation on extern
> >>>>>>> struct/union/typedef/enum/etc. So I made this a DOC: block so that
> >>>>>>> I can use (insert) it into a Documentation (.rst) file and have it
> >>>>>>> look decent.      
> >>>>>>
> >>>>>> The simple workaround is to separate the enum type and the variable:
> >>>>>>
> >>>>>> /**
> >>>>>>  * kernel-doc for the enum
> >>>>>>  */
> >>>>>> enum system_states {
> >>>>>> 	...
> >>>>>> };
> >>>>>>
> >>>>>> /**
> >>>>>>  * kernel-doc for the variable
> >>>>>>  */
> >>>>>> extern enum system_states system_state;
> >>>>>>
> >>>>>> BR,
> >>>>>> Jani.
> >>>>>>    
> >>>>>>>
> >>>>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >>>>>>> Acked-by: Rafael J. Wysocki <rafael@kernel.org> # v1
> >>>>>>> ---    
> >>
> >> [snip]  
> >>>>> If the problem is with "extern" before enum, fixing kdoc be
> >>>>> fairly trivial.    
> >>>>
> >>>> The non-trivial part is deciding whether you're documenting the enum
> >>>> type or the variable. Both are equally valid options.    
> >>>
> >>> True.
> >>>
> >>> I'd say that, if the variable is under EXPORT_SYMBOL macros, it
> >>> should be documented.    
> >>
> >> Do you mean documented with kernel-doc? How do we do that?
> >> I was under the impression that we don't currently have a way to
> >> use kernel-doc for variables (definitions, only for declarations).  
> > 
> > No, but it shouldn't be hard to add something like:
> > 
> > 	/**
> > 	 * global system_state - stores system state
> > 	 * <some description>
> > 	 */
> > 	extern enum system_states system_state;  
> > 
> > and place a dump_global() function at kdoc parser. Ok, one might use
> > DOC:, but IMHO the best is to have a proper handler for it that would
> > automatically pick the type.  
> 
> Nitpick, I would s/global/var/. But I won't complain about "global".
> 
> More importantly, I have seen several patches where people try to document a
> variable, so it seems like something that we should support at some point.

As we're talking about possible new kernel-doc features, there's
something that IMHO we should consider implementing: define
groups. For instance, media videodev2.h uapi has several ones like
this (and this pattern is quite common on other places - either using
BIT() or not):

	/* Values for 'capabilities' field */
	#define V4L2_CAP_VIDEO_CAPTURE      0x00000001  /* Is a video capture device */
	#define V4L2_CAP_VIDEO_OUTPUT       0x00000002  /* Is a video output device */
	#define V4L2_CAP_VIDEO_OVERLAY      0x00000004  /* Can do video overlay */
	#define V4L2_CAP_VBI_CAPTURE        0x00000010  /* Is a raw VBI capture device */
	#define V4L2_CAP_VBI_OUTPUT     0x00000020  /* Is a raw VBI output device */
	#define V4L2_CAP_SLICED_VBI_CAPTURE 0x00000040  /* Is a sliced VBI capture device */
	#define V4L2_CAP_SLICED_VBI_OUTPUT  0x00000080  /* Is a sliced VBI output device */
	#define V4L2_CAP_RDS_CAPTURE        0x00000100  /* RDS data capture */
	#define V4L2_CAP_VIDEO_OUTPUT_OVERLAY   0x00000200  /* Can do video output overlay */
	#define V4L2_CAP_HW_FREQ_SEEK       0x00000400  /* Can do hardware frequency seek  */
	#define V4L2_CAP_RDS_OUTPUT     0x00000800  /* Is an RDS encoder */


We could use something like this:

	/**
	 * defgroup - Values for 'capabilities' field
	 *
	 * @V4L2_CAP_VIDEO_CAPTURE: Is a video capture device
	 * @V4L2_CAP_VIDEO_OUTPUT: Is a video output device
	 * @V4L2_CAP_VIDEO_OVERLAY: Can do video overlay
	 * @V4L2_CAP_VBI_CAPTURE: Is a raw VBI capture device
	 * @V4L2_CAP_VBI_OUTPUT: Is a raw VBI output device
	 * @V4L2_CAP_SLICED_VBI_CAPTURE: Is a sliced VBI capture device
	 * @V4L2_CAP_SLICED_VBI_OUTPUT: Is a sliced VBI output device
	 * @V4L2_CAP_RDS_CAPTURE: RDS data capture
	 * @V4L2_CAP_VIDEO_OUTPUT_OVERLAY: Can do video output overlay
	 * @V4L2_CAP_HW_FREQ_SEEK: Can do hardware frequency seek
	 * @V4L2_CAP_RDS_OUTPUT: Is an RDS encoder
	 */
	#define V4L2_CAP_VIDEO_CAPTURE		0x00000001
	#define V4L2_CAP_VIDEO_OUTPUT		0x00000002
	#define V4L2_CAP_VIDEO_OVERLAY		0x00000004
	#define V4L2_CAP_VBI_CAPTURE		0x00000010
	#define V4L2_CAP_VBI_OUTPUT		0x00000020
	#define V4L2_CAP_SLICED_VBI_CAPTURE	0x00000040
	#define V4L2_CAP_SLICED_VBI_OUTPUT	0x00000080
	#define V4L2_CAP_RDS_CAPTURE		0x00000100
	#define V4L2_CAP_VIDEO_OUTPUT_OVERLAY	0x00000200
	#define V4L2_CAP_HW_FREQ_SEEK		0x00000400
	#define V4L2_CAP_RDS_OUTPUT		0x00000800

I suspect this is easier said than done, but there are lots of
similar stuff at the Kernel. On some cases, it is easier to use
enums, but on others like here, it probably keeps sense to keep
them a defines.

Thanks,
Mauro

