Return-Path: <linux-pm+bounces-33871-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD1EB4447B
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 19:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02FD47BF35C
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 17:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAF8311C13;
	Thu,  4 Sep 2025 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZvzEd38"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5333730DEB9;
	Thu,  4 Sep 2025 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007275; cv=none; b=Xnihqi7P1ay5Qc+uLLxHNl5bBpB6pN9FdAspcbpkZRelX0MUjocBWu11YAEGVQwIjUo/7VZn6/97RNdjD+WiAYNJimH0zh3/guat2YifncS9+DjWglN5H5Z0k1xkWqKq6B2wlMrfx03tRaaRn0t2ES9FKrJ7CUSDBOLgMqQf/Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007275; c=relaxed/simple;
	bh=tCLGWZJhndfDcfJe3z589KPXK1Zk69hQ1QEKUh6o5Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/JHBU8a50yFF+KK+oyBkMu7Oygir1LrZJo+fEGZp/2MrKxkt+Wyrr9kAhLzBowHfRE9oAvORwdRCfKENpWAUzGTwMjIr1IpA5y1We5O4/dXVM1AcBsY/p7Z4UX9hvvkF3aDH30GLJNYH4GzpWaODYsAQ/CgmpVZbjMLJKLNtfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZvzEd38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E774EC4CEF1;
	Thu,  4 Sep 2025 17:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757007274;
	bh=tCLGWZJhndfDcfJe3z589KPXK1Zk69hQ1QEKUh6o5Tg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tZvzEd38xEHTkfTpv+FYj/RS7DGEKhlJxdHCdJW9cDcrQPuOBv2b+/hQf5AKjrk/G
	 3iAc+0l5lsgl9FP3F/nMyiwkNhoKsOpG9PgFdjoORzvq2+pBFy7WORUqhGDyP0I7m3
	 s5pCJug2VStSgTPsixJfv0qhSnKkXulep7keGFBcrYs+kLUwdThGXbnj4VUXtaDAfI
	 fooT34dSBrlGUwnxW+GKOstGPNAVkSbh9iHCRJJos3ul+aEM8PgFopr8/QY/rJCbI6
	 Z1HX2c3rbtMgeD/9fK5e6BxYjwBOSwxNbn3s1qRa5V/tsXMfcmHbZFqG/V5OnXm50Q
	 1Zv/GLtwPVewQ==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-74543fea20dso1243254a34.0;
        Thu, 04 Sep 2025 10:34:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUK30AKdGV/LejLUUZZJxcXnp9wZjloh6zd9IWQAMHOoW8Sa6TXj+A46znyZLY327X4Yr+raPZUGf3TGNY=@vger.kernel.org, AJvYcCVTSsbY4GY0gFWqxcVwmAPiiSltqboKE/D50ndTocEB80xEEOz2OUuk9eikCzT4zEZdWVAD+gsLcVGo@vger.kernel.org, AJvYcCWufwdGdA3Zi+y/PMnJUSEku51fro8jYC/LYG/vc2pGeo5EdRF/VDBV5JE3oGSYGVBjwFfFOfxiPyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHIY7dXJg+OdcrsQIxsHUTrxn6bwAPyzO7dHWEqIKB4e9RJdXQ
	RCHt+7+LZGQxKg8QFBu18P4PY8Sq3Y0JXohuhhQ9YxBVdlhS4AzlfowsVeH2yspTnxa+9se2Jek
	9PwEfr5hH9/rfFDqNPVzl9h2NR79pnEA=
X-Google-Smtp-Source: AGHT+IHCJx2YeLOt6lgCr5q536R8BEGnjy/zChXJQpn7RBXnleW4q5+lM0/+WHBZekvTwO013k+P5rQEsuJ4Oe0AGQU=
X-Received: by 2002:a05:6830:67ec:b0:745:63b7:dd9e with SMTP id
 46e09a7af769-74569e7c2c0mr9218117a34.20.1757007274274; Thu, 04 Sep 2025
 10:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829004312.5fw5jxj2gpft75nx@synopsys.com> <e3b5a026-fe08-4b7e-acd1-e78a88c5f59c@rowland.harvard.edu>
 <CAJZ5v0gwBvC-y0fgWLMCkKdd=wpXs2msf5HCFaXkc1HbRfhNsg@mail.gmail.com>
 <f8965cfe-de9a-439c-84e3-63da066aa74f@rowland.harvard.edu>
 <CAJZ5v0g9nip2KUs2hoa7yMMAow-WsS-4EYX6FvEbpRFw10C2wQ@mail.gmail.com>
 <CAJZ5v0gzFWW6roYTjUFeL2Tt8kKJ_g5Q=tp2=s87dy05x-Hvww@mail.gmail.com>
 <38b706cc-5966-4766-9165-51935fdcd790@rowland.harvard.edu>
 <CAJZ5v0h=i9XF_SQMOhz3P+4SAH3Qy-r1oUiiw7Bp=PcRnJjVbQ@mail.gmail.com>
 <59951c2d-60e8-47a8-a43c-00b92e095043@rowland.harvard.edu>
 <CAJZ5v0i6aFarDU8OTZ_3VS9dp4SaqKJ0SuiN4gFSxrRoAAV5CQ@mail.gmail.com> <24a69e4d-2f10-43fb-81d4-f7eea44a6b8d@rowland.harvard.edu>
In-Reply-To: <24a69e4d-2f10-43fb-81d4-f7eea44a6b8d@rowland.harvard.edu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 19:34:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gUjgY45WFye5STJ7kv30O4rQ=23qkOsHEMSxfwg8jO4g@mail.gmail.com>
X-Gm-Features: Ac12FXyJScJSubeQr6Bx8dVCUZ25WEBH-wTjxWX3tVmLnpFp_wYjmQnZ4PU2zTo
Message-ID: <CAJZ5v0gUjgY45WFye5STJ7kv30O4rQ=23qkOsHEMSxfwg8jO4g@mail.gmail.com>
Subject: Re: [PATCH] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	ryan zhou <ryanzhou54@gmail.com>, Roy Luo <royluo@google.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 4:19=E2=80=AFPM Alan Stern <stern@rowland.harvard.ed=
u> wrote:
>
> On Thu, Sep 04, 2025 at 04:08:47PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Sep 3, 2025 at 11:54=E2=80=AFPM Alan Stern <stern@rowland.harva=
rd.edu> wrote:
> > >
> > > On Wed, Sep 03, 2025 at 09:30:47PM +0200, Rafael J. Wysocki wrote:
> > > > I personally think that it would be reasonable to simply preserve
> > > > device states in error paths unless they have been changed already
> > > > before the error (or suspend abort due to a wakeup signal).
> > >
> > > The problem is complicated by the interaction between runtime-PM stat=
es
> > > and system-sleep states.  In the case, we've been considering, B chan=
ges
> > > from runtime-suspended to runtime-suspended + system-suspended.
> > > Therefore the error path is allowed to modify B's state.
> >
> > Yes, it is, but retaining the B's state in an error path is also fine
> > so long as no changes have been made to it so far.
> >
> > If B was runtime-suspended to start with and none of the suspend
> > callbacks invoked for it so far has done anything to it, then it is de
> > facto still runtime-suspended and its state need not be changed in an
> > error path.
> >
> > > > By this rule, B would be left in runtime suspend if it were still i=
n
> > > > runtime suspend when the error (or suspend abort in general) occurr=
ed
> > > > and then it doesn't matter what happens to A.
> > >
> > > More fully, B would be changed from runtime-suspended + system-suspen=
ded
> > > back to simply runtime-suspended.  Unfortunately, none of the PM
> > > callbacks in the kernel are defined to make this change -- at least, =
not
> > > without some cooperation from the driver.
> >
> > Except when runtime-suspended + system-suspended is effectively the
> > same as runtime-suspended.
> >
> > Say this is not the case and say that the device is runtime-suspended
> > to start with.  Then the "suspend" callback has two choices: either
> > (1) it can runtime-resume the device before doing anything to it,
> > which will also cause the device's parent and suppliers to
> > runtime-resume, or (2) it can update the device's state without
> > resuming it.
> >
> > If it chooses (1), then "resume" is straightforward.  If it chooses
> > (2), "resume" may just reverse the changes made by "suspend" and
> > declare that the device is runtime-suspended.  And if it really really
> > wants to resume the device then, why not call runtime_resume() on it?
>
> That's what I meant by needing "cooperation from the driver".  The
> driver's ->resume callback needs to do this check to see which pathway
> to follow: (1) or (2).

Unless "suspend" always does the same thing, so it always does (1) or
it always does (2).

In that case, "resume" will know what to do without checking.

I'd like to mention that if "suspend" chooses (2), it may need to
resume the suspended parent or suppliers to be able to access the
device even though the device itself won't be resumed.  I'm not sure
if (2) is really attractive then, though.

Also, in the example we've been considering so far, the assumption is
that B can just stay in runtime suspend, so why would it need to be
resumed by "resume"?  And if there is a specific reason for resuming
it, "resume" can just call runtime_resume() on it AFAICS.

