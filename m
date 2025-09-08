Return-Path: <linux-pm+bounces-34149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9657DB48B23
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 13:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2C33A2159
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 11:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3912F90DC;
	Mon,  8 Sep 2025 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxgzLJaw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E551C4A10;
	Mon,  8 Sep 2025 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329710; cv=none; b=O6kxOx+edg/DotuTXQ3NKeCc7knHBJ2ZKIodXHcR/8ex80G+gNuSlVDElww2EJ1As/E39EKWRgp0ACtsgpo0Lg+ytuEt6/9USTaHy2XIwbFgx9dPR+Btz3LhR/R6B7TR0Oprqd2dHuE2fFljne6n0r253zF4dfQ/LNxeMs+JK/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329710; c=relaxed/simple;
	bh=+Q43JtoguPcKuo4Q1eJ/Poz52uueYi6hh+5pzKswldA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/m1lzpx6FwFHCHtrUbQc4HjqNEV95lElzXdYq/EeLoZ1A9gV7nmLzkYvlaKnmclyel+6Q0OnrcR9ojAXf6gS72i6L9IR/i5htqZtcUPGlrsqqZLniPN2XFIbix/IP/u5wsZtsCfiyTTvQDOojFVtRyx4Gl+2P7bj3zN0y9tBAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxgzLJaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B0BC4CEF1;
	Mon,  8 Sep 2025 11:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757329709;
	bh=+Q43JtoguPcKuo4Q1eJ/Poz52uueYi6hh+5pzKswldA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PxgzLJawFXejmbGNwpkM2ZvxsiaMFNyFYD/mUNZtq0696MwrW1wGMLsOyASAiQ96P
	 1hlbEAmgWodQj08SqXlDsvKKtD0ZRWgbzVqQ33TEsPpRY8tRnXAo1SCkn2vwRkyFVo
	 WxptTEtOB0kks3ZKYCA3NhUaQpW0s8+yOYQitIW80B1hi98B138Jsh94pxI4JHtxC5
	 bwuag3CE/Xjod2DV27WSPxvxTf8sG/tCVoM8jNvSLjbNL1R8WNKuxdOg8e3QKhi8/x
	 kBnPRPbCop4ij9+Gwdn54H2JeW39F275dmdlwxA1NZsGXX7xoiD05Yhsva/5/j5WEg
	 7OrRoU/BrMxIQ==
Date: Mon, 8 Sep 2025 13:08:24 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, Len Brown
 <len.brown@intel.com>, linux-pm@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH v4] kernel.h: add comments for system_states
Message-ID: <20250908130824.7510ffda@foz.lan>
In-Reply-To: <f6e0f7409df67e0554885cacb74023a8aad9a717@intel.com>
References: <20250904063631.2364995-1-rdunlap@infradead.org>
	<6089e22ddfdc135040cdeb69329d817846026728@intel.com>
	<20250905140104.42418fba@foz.lan>
	<34fb6a27a2c17c22c0ac93bebb0bbfd1a04d1833@intel.com>
	<atj2koasbiuf67rzr7bbdwpu4kcgkdsqt6rhz5vwpbryfqxm7z@mfmts3tnsasf>
	<2aad4540-ccdd-4519-9bed-7d8c7ccd009d@infradead.org>
	<20250906105627.2c0cd0d9@foz.lan>
	<d815f5c3-6e15-4758-8bf4-601d5543cab9@infradead.org>
	<20250906233028.56573fd6@foz.lan>
	<20250907153547.5d4271d9@foz.lan>
	<20250907181719.0138c054@foz.lan>
	<f6e0f7409df67e0554885cacb74023a8aad9a717@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 08 Sep 2025 12:22:06 +0300
Jani Nikula <jani.nikula@linux.intel.com> escreveu:

> On Sun, 07 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > Heh, looking at Sphinx doc at:
> > https://www.sphinx-doc.org/en/master/usage/domains/c.html:
> >
> > 	.. c:member:: declaration
> > 	.. c:var:: declaration
> >
> > 	    Describes a C struct member or variable. Example signature:
> >
> > 	    .. c:member:: PyObject *PyTypeObject.tp_bases
> >
> > 	    The difference between the two directives is only cosmetic.
> >
> > I guess the best is to encode it as:
> >
> > 	prototype = args.other_stuff["var_type"]
> > 	self.data += f"\n\n.. c:var:: {prototype}\n\n"
> >
> > And let Sphinx format it for us.  
> 
> In the same vein, I believe we should let Sphinx format everything else
> for us as well. Function parameters should use ":param foo: desc" and
> struct/union members should be indented within the enclosing
> struct/union.

Good idea. We need to verify first if :param: and :returns: are available 
since 3.4.3. Docs imply so:

	https://www.sphinx-doc.org/en/master/usage/domains/c.html

> I also think we're going way overboard with including e.g. struct
> definition in the output. I'd just chuck those away and maybe add links
> to kernel git source for the definition instead.

We still need to parse all parameters, as we need them for man pages, as this
is the standard practice (see "man 2 read", for instance).

We may do something else for html, but:

- on functions, the full prototype is required by Sphinx:

	.. c:function:: void media_set_bus_info (char *bus_info, size_t bus_info_size, struct device *dev)

- for struct/union/enum, a data type is not supported, but the documentation
  has an example about how Sphinx actually expects it:

	.. c:struct:: Data

	   .. c:union:: @data

	      .. c:var:: int a

	      .. c:var:: double b

  If we're willing to use the Sphinx way, tests are required.
  Implementing it would add more complexity, though. Not sure
  about the benefits if any.

In summary, for html/pdf/epub, there are three possible outcomings:

- keep as-is;
- replace them by links;
- implement Sphinx way.

In any case, changing it won't cleanup the code, as we still need
parameters parsing for man pages.

Also, as a documentation user, when read I documentation, I do 
expect to see the function prototypes just before parameter
descriptions. If possible, untouched. This is specially important, 
IMHO, where there are macros to help generating functions and structs.

Thanks,
Mauro

