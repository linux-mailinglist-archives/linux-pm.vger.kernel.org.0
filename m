Return-Path: <linux-pm+bounces-34454-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E04B52EA1
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 12:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7321C825D1
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 10:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7F731194A;
	Thu, 11 Sep 2025 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFiT8THp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9563631158A
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586709; cv=none; b=QcI73tk//8UHsel7ysd5IMN689qrX3WcSTadd7LexYuDD228oVbPkrCnJL7DbeYgg5SrGoYQOlMieyO2JMcTeyJhvhETJYkS19+N/hExMXPiD+ANf/Y995KVpf2bKTtU+sRQYc67TsMBxYOg0+ntWHxASjMzeOg23WK3hbbjlgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586709; c=relaxed/simple;
	bh=xaPe7WTboY6+/tPQNyhe8Htaun8q0KWDYpAJ4c9xb4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvJeoAVmbGUm+ETQtqsxZ2Sg8W4ARRLO0Ol7BGAWP89weErAqWaTJvBJFmRxTt9SYXdM8q0BpJhr/+Baibtv6dsCY3PxDHjLg4mAcPx4EppavEX71kaXpGAtP0WpNr2T9iIyzJKwGtZwZJQ92wafYcETEPZBE8GzQ4WA8M9s7vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFiT8THp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CB4C4AF09
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 10:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757586709;
	bh=xaPe7WTboY6+/tPQNyhe8Htaun8q0KWDYpAJ4c9xb4g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DFiT8THp5lZHrVka74NLFyRStJbrTYWBc4EmtpFwYy66jD4REiTMvhBAWpPp/vUPE
	 IfMUeltYdNawHOcxkgmUPQsukgiewWPRolOOUGCQCqJoqQpFRZJWKfe8FWQDGL0nDf
	 bzRSgmLWwjfdUbeDfiPFqdYXmTUTIgJ7WXKLrsVEhScF0I/r/I9n7Co73pypwTzqJ+
	 d4+sjPkouu5J6qZVHevWiZWtWyfQxgZNgBL5zDmOgq+YJ5Jn1hy1oBTaI2OfZ4miWg
	 kE9p7D6Z9XOjLqrLf4lILkEeVObPVR51m4e9M6Q69YOWayNNlUCBS37Z/pfqQGR8vs
	 PZPdxfio5q8lg==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7459fa1ef2aso577954a34.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 03:31:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKVbgcpz3vvYV2muHSeykKO4NEe10DiIarAksiaYzxW7DwGhF1SCCQEk8oZAuzek4RLfGx/nX7zw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+JdqklQUFmUPgbeqGVx9uuQ4w9IDFHlnGv6PWJEhibSPXZPCV
	oBW722UD+oFpOCR4tV+j9XqALUeLhVei4bGGcRyQmB8j//pPbief43c8l1oEgYFgN+VRmXM9qS/
	L8ckKoRLalfMPznEcrGs8m9AEVsiRPC8=
X-Google-Smtp-Source: AGHT+IHHqcVDj1OR3RKUpL+hwMYtQNeAHfRxOjE8VI69WXeSCnFBIKD4xZFw5ff9F2oLdfPcCewT212Xf+wkZvrkyjs=
X-Received: by 2002:a05:6830:348e:b0:74b:3422:f33d with SMTP id
 46e09a7af769-74c66acfea9mr10519629a34.0.1757586708559; Thu, 11 Sep 2025
 03:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12740505.O9o76ZdvQC@rafael.j.wysocki> <871polxs9c.ffs@tglx>
 <CAJZ5v0jyN0=aGFOwE8fzuXi=1LgiLR5wgvvsAihGB0qpUp=mUQ@mail.gmail.com>
 <CAJZ5v0gsiuK5iFY6cHaqEgP8R1sz_pWGoqac2orYvXqLE2xbDQ@mail.gmail.com>
 <87o6rowrsp.ffs@tglx> <CAJZ5v0htmEeivbQaumRc7zw_Zx68GpUy98ksA9L42LupjO6tWA@mail.gmail.com>
 <87ldmqwgjc.ffs@tglx>
In-Reply-To: <87ldmqwgjc.ffs@tglx>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Sep 2025 12:31:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gW+A-eyckySFrHc7=Qr9URdRX6NqvPgkq4gZEvs_uBWg@mail.gmail.com>
X-Gm-Features: Ac12FXzgGiowTvScHQ01Ay90U85oEzvZ5PQbqDaWOC0Z8BaVn36F5KL13kIgeVI
Message-ID: <CAJZ5v0gW+A-eyckySFrHc7=Qr9URdRX6NqvPgkq4gZEvs_uBWg@mail.gmail.com>
Subject: Re: [PATCH v1] cpu: Add missing check to cpuhp_smt_enable()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Christian Loehle <christian.loehle@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 3:14=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Fri, Sep 05 2025 at 22:56, Rafael J. Wysocki wrote:
> > On Fri, Sep 5, 2025 at 10:47=E2=80=AFPM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >>
> >> On Fri, Sep 05 2025 at 15:27, Rafael J. Wysocki wrote:
> >> > On Fri, Sep 5, 2025 at 3:13=E2=80=AFPM Rafael J. Wysocki <rafael@ker=
nel.org> wrote:
> >> >> Well, manual online can be used for onlining the secondary thread o=
f a
> >> >> core where the primary thread is offline, so this is technically
> >> >> possible already.
> >> >>
> >> >> > Something like the completely untested below.
> >> >>
> >> >> So given the above, shouldn't topology_is_core_online() check if an=
y
> >> >> thread in the given core is online?
> >> >
> >> > Besides, this would cause the siblings of offline SMT threads to be
> >> > skipped while enabling SMT via sysfs (using
> >> > /sys/devices/system/cpu/smt/control), but I'm not sure if this is th=
e
> >> > expectation in the field today.  The current behavior is to online a=
ll
> >> > secondary SMT threads (and more, but that part is quite arguably
> >> > broken).
> >>
> >> It is broken, because the initial logic is to bring up primary threads
> >> unconditionally and then refuse to bring up sibling threads.
> >>
> >> With "maxcpus=3Dxxx" this obviously limits the amount of primary threa=
ds,
> >> so there is arguably no point to online any of the related secondary
> >> threads of them.
> >>
> >> The initial implementation was naively making that assumption, but the
> >> core check which was added due to PPC made this actually correct.
> >>
> >> It just did not snap with me back then, but it's actually the correct
> >> thing to do, no?
> >
> > It would at least be consistent with the existing PPC behavior. :-)
>
> Correct.

So are you going to send a patch or do you want me to do something?

From a user standpoint, this issue is a regression in 6.16, so it
would be good to address it before final 6.17.

