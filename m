Return-Path: <linux-pm+bounces-34029-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A25B46503
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 22:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E755C5B82
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 20:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549B82E03EE;
	Fri,  5 Sep 2025 20:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DStwtmWh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A887285CB9;
	Fri,  5 Sep 2025 20:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757105816; cv=none; b=K15wTx4Yd27SzYPMGNZY0mxHVVla+6j0mvyKkAMR99nFUs4V/aBKHmEbVdSXxDUpxwnm0J46AY7+BMyN08kZXJPydevr6ylDO9oc1+gr801R1apSWQW22OnQsgjrvZ9XCZf1rTiovTC8D1zWvDbHgowMgZRgegtWlrR9Tr6Ica8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757105816; c=relaxed/simple;
	bh=+NdlnWi1jiW2LaPBnbNA3C/ANQGT3Y7PYpJ/cx4Icxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NrPbGNHWONyCWFbx5nDUhYPJVaJWWBtXkrfGtXsX5pYGjNYF+AptRB9bhJcZiRDEM6+xNU1yMwgoiOWBg0dsQ0vD7UGud7iB3LZhc2e/xB6I84yf5ZUAa7TyunFjKNz1AGbxbfWilm4X9nlvqpU0BCPM3uOACYjdQHAGva69kIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DStwtmWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B43C4CEFB;
	Fri,  5 Sep 2025 20:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757105815;
	bh=+NdlnWi1jiW2LaPBnbNA3C/ANQGT3Y7PYpJ/cx4Icxs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DStwtmWhfG/EADn9saTkpRdlA/0Q/rsfcItMVlZOLSlVqrPP1P//UOehpUCDYhxDC
	 VsMEpgHM26aAYtbEUeWB0GARi2AimNULv8BesWN7tX+qSfIpBodiGCM4+ow6BSkTgW
	 So4SkE07ivu6O4cdZcnuw2TYFNhse2jkS8+n5GDdo2w1xzaLld86t3brVpUk2idsrA
	 qNc+DF9X3dWdSGaoshd6DRdRd5shQFenoehEtfyu773JV+8KelloK459BtW6+1bafU
	 7/fpan+TegQajqVQV1h1sR/fWD/4P1IxF6s2qO+qVMsmxnRWtxljhpmkz7XU4XIVRu
	 w/+IHjLXEZSmw==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-74526ca79c2so1163630a34.3;
        Fri, 05 Sep 2025 13:56:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9CoIsUCZ2cdtryoAQqS+hXXPDUJvTXIW+b0Xy3HvRO+mxOrXweIJ5secE/Z+OXHMvUT10jbvCrKh/Tbs=@vger.kernel.org, AJvYcCW8z3L7TWf48UQ/TbCNzH7qH7obnJUdweZnbt/cGjgs9/905ycAx//XFCxwQziop8gXeR8VtVO73bA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFOqiwbla+9r8dXlj2mjJFNmeeerxhA0lcVASQlkAqIjaIAJzI
	eiUOJTDtpj3xkpeXrmGF8+9TggPqFDoBjduJtGsFmnk+sKuRR+JEebQoL9uOtv9ZcXfYRYh+R5b
	qiYJHD19oshwgWj6eLizG6II8dM0ATX8=
X-Google-Smtp-Source: AGHT+IEmbtYzZnRaxFvuXlG+2hlLcxMCbzonW/f42gHadQVNSEi7W7HL6UaIY6YZexkGAOUDo49QnV6WftSq9iTrcsE=
X-Received: by 2002:a05:6808:181d:b0:437:d885:a4d8 with SMTP id
 5614622812f47-43b29a3dabemr91718b6e.6.1757105815068; Fri, 05 Sep 2025
 13:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12740505.O9o76ZdvQC@rafael.j.wysocki> <871polxs9c.ffs@tglx>
 <CAJZ5v0jyN0=aGFOwE8fzuXi=1LgiLR5wgvvsAihGB0qpUp=mUQ@mail.gmail.com>
 <CAJZ5v0gsiuK5iFY6cHaqEgP8R1sz_pWGoqac2orYvXqLE2xbDQ@mail.gmail.com> <87o6rowrsp.ffs@tglx>
In-Reply-To: <87o6rowrsp.ffs@tglx>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 22:56:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0htmEeivbQaumRc7zw_Zx68GpUy98ksA9L42LupjO6tWA@mail.gmail.com>
X-Gm-Features: Ac12FXwYG6vx63kgSUHoTXbXe4b5qG4C5mVZk6O6qouX_co66kEe_LbA6Z6rT80
Message-ID: <CAJZ5v0htmEeivbQaumRc7zw_Zx68GpUy98ksA9L42LupjO6tWA@mail.gmail.com>
Subject: Re: [PATCH v1] cpu: Add missing check to cpuhp_smt_enable()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Christian Loehle <christian.loehle@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 10:47=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Fri, Sep 05 2025 at 15:27, Rafael J. Wysocki wrote:
> > On Fri, Sep 5, 2025 at 3:13=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >> Well, manual online can be used for onlining the secondary thread of a
> >> core where the primary thread is offline, so this is technically
> >> possible already.
> >>
> >> > Something like the completely untested below.
> >>
> >> So given the above, shouldn't topology_is_core_online() check if any
> >> thread in the given core is online?
> >
> > Besides, this would cause the siblings of offline SMT threads to be
> > skipped while enabling SMT via sysfs (using
> > /sys/devices/system/cpu/smt/control), but I'm not sure if this is the
> > expectation in the field today.  The current behavior is to online all
> > secondary SMT threads (and more, but that part is quite arguably
> > broken).
>
> It is broken, because the initial logic is to bring up primary threads
> unconditionally and then refuse to bring up sibling threads.
>
> With "maxcpus=3Dxxx" this obviously limits the amount of primary threads,
> so there is arguably no point to online any of the related secondary
> threads of them.
>
> The initial implementation was naively making that assumption, but the
> core check which was added due to PPC made this actually correct.
>
> It just did not snap with me back then, but it's actually the correct
> thing to do, no?

It would at least be consistent with the existing PPC behavior. :-)

