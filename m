Return-Path: <linux-pm+bounces-11669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3755B9413CF
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 16:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29241F24C2B
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 14:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124691A254B;
	Tue, 30 Jul 2024 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwJ9Im54"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD4B1A2547;
	Tue, 30 Jul 2024 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347996; cv=none; b=ZU/+7UpJ4kXYy8T+HEQ+H41Hk3E2amQoMFmIaSrEabBmYRrcWye012LqfgMUEkZxIxzyiro2JU5GDvYoe/c6ps4eNs/buso9uDLgw0FqZx489p55fl9EGmTz1Z7Mi/j0obOzhHuagUCxVTzG+L0ZOa9oYMB7UpFNAm0YYHiQ/yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347996; c=relaxed/simple;
	bh=9I3t+2dLuJ2ymcdQLJWhU6wV/uau+oXQREYtjZtGTQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MF853mzuNoHIm0y5nWlggQ2go/5Io6TOK9NNj9eu4mIndvT3yMVpS6Z9ruO6yc9mCnzMb04C0wVT+NjEQflr8/atVZ8cvqLquAhdk63GTFGhVApSo/HY1k5q05VAe7HE2SzfCJxIBVG5wrP9E8zCYNq+SSOJvy4GMrAe0St55Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwJ9Im54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9CAC4AF10;
	Tue, 30 Jul 2024 13:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722347995;
	bh=9I3t+2dLuJ2ymcdQLJWhU6wV/uau+oXQREYtjZtGTQM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TwJ9Im546+jPVNSFQfZA6XHD99DTlk0IEFhs4RTd+WlcL+QqAFuywCJlOPlcrPOmt
	 2UjGWYq/p6BFuehqd6ZB93JsEYz0QwfpZPOpUD1Ypy1bp6u42/KX9kGDejwv0ihY2e
	 INfHHO7nINOsIZW7xWnAm6LF9oCNXx3U1iW6MXI1ege27998483agsH8BwEfaX9ZMi
	 HjT75h9p7aNa1QdNHDbZB198SNPro7CMqy1tN6uR4yyKofa8cqigFsbvdsCLfkk4Tw
	 2AkKrRJ351Dw1GMqS/WDRFFmrrjzhaRJANQ94MYNLenhUhHC3Wc3/ue+hytCv8b7iM
	 rBarJUr8TLNbg==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3db1bf000a0so448378b6e.1;
        Tue, 30 Jul 2024 06:59:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzR1x65opX4q00avdnxm7I2sr42hMFDTZRG06xN5xevZTbAdq2rOPVsaOQfktOiDoyMUkQWtL9pfSWbdEH9MqeSJgt50qJxW80ciPhmb0McgY1e0iW5l1UHgG7QPfliLRVBmHBtrU=
X-Gm-Message-State: AOJu0Yy0SD+R9ML+LZDaAV1MXHOTXvLiU0CiOG96zInoKhh/124PRCMU
	3O+BE5LyaQiaab3J04k0CNa/JxRsXUSFl7dHdU4tWtxEXPHHEids0EtqRR69MXutWX0T2xIz7RT
	DOnwRI4CXh8Z8fp6gvk6wF7bfkC0=
X-Google-Smtp-Source: AGHT+IHblQ9qTk5V1VavphzqxLU6ioreErW1SEQs2RHnBvOkTqqzL88Ns0uEck9G/hJsam3f4K0w1Z9n89tnWpoAHPQ=
X-Received: by 2002:a05:6808:3028:b0:3d6:36d7:fcb9 with SMTP id
 5614622812f47-3db12088dd9mr10628463b6e.2.1722347994768; Tue, 30 Jul 2024
 06:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726062601.674078-1-kai.heng.feng@canonical.com>
 <2048df524f8be7ed200bc92eb1c6efe106f0ed19.camel@intel.com> <CAAd53p5ftAjtfb-uCcVKR8G0JfoGnA_a0Se1E_vPeietgOENOg@mail.gmail.com>
In-Reply-To: <CAAd53p5ftAjtfb-uCcVKR8G0JfoGnA_a0Se1E_vPeietgOENOg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Jul 2024 15:59:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i9Qt3OFKCbqkd-q4VKYreV2PZZpQ2Km9az2htANG5zxA@mail.gmail.com>
Message-ID: <CAJZ5v0i9Qt3OFKCbqkd-q4VKYreV2PZZpQ2Km9az2htANG5zxA@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add Jasper Lake and Elkhart Lake support
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, 
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 6:08=E2=80=AFAM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> [+Cc Rafael, Srinivas]
>
> On Fri, Jul 26, 2024 at 2:52=E2=80=AFPM Zhang, Rui <rui.zhang@intel.com> =
wrote:
> >
> > On Fri, 2024-07-26 at 14:26 +0800, Kai-Heng Feng wrote:
> > > Without proper C-state support, the CPU can take long time to exit to
> > > C0
> > > to handle IRQ and perform DMA.
> >
> > Can you provide more details?
> >
> > Say, what cstate is entered w/ and w/o this patch?
>
> Without the patch it's ACPI C1, C2 and C3.

They are called like this because they come from ACPI _CST.  You need
to use turbostat (or equivalent) to check what C-states really are
entered.

>
> >
> > can you show the output of "grep .
> > /sys/devices/system/cpu/cpu0/cpuidle/state*/*" without this patch?
>
> /sys/devices/system/cpu/cpu0/cpuidle$ grep . */*
> state0/above:0
> state0/below:631
> state0/default_status:enabled
> state0/desc:CPUIDLE CORE POLL IDLE
> state0/disable:0
> state0/latency:0
> state0/name:POLL
> state0/power:4294967295
> state0/rejected:0
> state0/residency:0
> state0/time:19513
> state0/usage:635
> state1/above:26
> state1/below:12437
> state1/default_status:enabled
> state1/desc:ACPI FFH MWAIT 0x0

This is C1 AFAICS.

> state1/disable:0
> state1/latency:1
> state1/name:C1_ACPI
> state1/power:0
> state1/rejected:0
> state1/residency:1
> grep: state1/s2idle: Is a directory
> state1/time:18621370
> state1/usage:74523
> state2/above:1690
> state2/below:17
> state2/default_status:enabled
> state2/desc:ACPI FFH MWAIT 0x31

This looks like something that used to be called "C7s".

> state2/disable:0
> state2/latency:253
> state2/name:C2_ACPI
> state2/power:0
> state2/rejected:0
> state2/residency:759
> grep: state2/s2idle: Is a directory
> state2/time:7063052
> state2/usage:7909
> state3/above:13111
> state3/below:0
> state3/default_status:enabled
> state3/desc:ACPI FFH MWAIT 0x60

And this looks like C10.

> state3/disable:0
> state3/latency:1048
> state3/name:C3_ACPI
> state3/power:0
> state3/rejected:0
> state3/residency:3144
> grep: state3/s2idle: Is a directory
> state3/time:4451519230
> state3/usage:55467
>
>
> >
> > >
> > > The data collect via wult shows the latency is similar to Broxton, so
> > > use the existing table to support C-state on JSL and EHL.
> >
> > so you have done cstate measurement on the EHL using wult?
> > can you share more details about the measurement results?
>
> I look at the "spikes" of the aggregated graph. Not sure if it's the
> right way to interpret the graph though.
>
> It will be much better if Intel can add the proper C-states table for
> JSL and EHL.

So what's missing in the above, from the technical standpoint?

