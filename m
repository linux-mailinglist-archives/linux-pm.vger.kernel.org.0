Return-Path: <linux-pm+bounces-20377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF09CA0C170
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 20:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 521EF7A23F7
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 19:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44531BFE10;
	Mon, 13 Jan 2025 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aihf2wdD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA59C1B4148;
	Mon, 13 Jan 2025 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796680; cv=none; b=pB4hkqXhUfbrzbdCzgTxIHW7h+sUNP2K7ms6JrmgP6NkP/AmF0l0xx88l7kP/eId39n16ddmfwA0XePqR6FDhMZ+zG8WlrsZj+HZRz/fRox/EFHyTOPauK72CdGFumvnO6hBj83izNlvBndmBZf9PlbnpVN4vd2x1kr++WrPel0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796680; c=relaxed/simple;
	bh=kUk4lA6D6xEXrsDNVRQlt7/E/DyGLa2BX/UXDgDb+L4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrhwNCR1JfxrfsOhtZYOx7DXvYrNEragTPr5VPHgnVbPRXZGVJrg+w0SkXHDtHSP49K3yCDQ8rwstjCqacDZixvpm6BLTcEghblqVmFmH8uGRjG9Zc17BqEMKzEhfCC0TVZOnWv9ScRsW6a9Id+TEOmN4C2q9UObnHpwYT42vcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aihf2wdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49821C4CEE2;
	Mon, 13 Jan 2025 19:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736796680;
	bh=kUk4lA6D6xEXrsDNVRQlt7/E/DyGLa2BX/UXDgDb+L4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Aihf2wdDHK2zTM5Cs1jJUx0u1ZEOh8+8KF1DCdO5r4bU2nkbaRcGfxBoKS3BucePS
	 jGi78lKwns/2c7Rgvbs8eaVjWyKoZWie2hd06SkOehL5L2JTgZra3tgC9KfA+u0zdO
	 Eu5jT2jkygS0duSF6y8EdSFi9ngUHkyHZM7JCf29iIXtchIFCnAfDyTZTtn7N5fyis
	 vWo3ELhxNFyhhjHUunPZDsSEfunzGLB3A06yyxwWGv8ZEb16sINx2LDV5p39MYwdft
	 rEt3VLMxdWdFhiXtKUse+mLAavTdU/qoma28nkc0SObV7og+BIPYNLJX9VuhkkPnEj
	 kInVqzUA/XkSw==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3eb9101419cso2676493b6e.0;
        Mon, 13 Jan 2025 11:31:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUf6LawBqzZhALHvQKckE8USbwVzSONuKMxGjBtqX0WJXP5ThNMAFliteV7Ti0243jjxDL3yWLLAZZgLfQ=@vger.kernel.org, AJvYcCXWFDLpaW+exodrgrDqwAlbpZJeU98bt0goxFOBVN3Luygwu6t0Syn0cy6GXHz2pGGgyXB24vonELo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEZeeeC5spfyOQl/mfcOO1vBsZa4gN7TtzmfFKY1dubVdCXhI6
	9PwNfI4DL1C1LmSuZ98RJ4SyDtXc0PJcPreMhcufjUcoUl4r8Z1THAG+PZjagF1UmuzbjVyHDg7
	COIcVhIXAtgabvjJ98ashz4yirqg=
X-Google-Smtp-Source: AGHT+IHT9VBtI6KvQqcoWS2W+r7qQft//5e4mZ7/gujUU0XVPsTl2rM8ZzDW8KTeRmD2ZeUR4kvD2zSFBsAX+PIoCts=
X-Received: by 2002:a05:6808:2395:b0:3e5:f9ee:a2b3 with SMTP id
 5614622812f47-3ef2ebc9c32mr14950658b6e.4.1736796679615; Mon, 13 Jan 2025
 11:31:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110115953.6058-1-patryk.wlazlyn@linux.intel.com> <e6c49f30-b32a-4ad0-98e2-634113011f90@intel.com>
In-Reply-To: <e6c49f30-b32a-4ad0-98e2-634113011f90@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Jan 2025 20:31:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0im2GzeXRxCEj3KwNy0naG6zyp193mORv2Gy9xwNy+v=g@mail.gmail.com>
X-Gm-Features: AbW1kvYY6clMO1edj-y1zixyQrXEjPG5k25WqGJebMjXvpYKz8qmci6sMaDlpo0
Message-ID: <CAJZ5v0im2GzeXRxCEj3KwNy0naG6zyp193mORv2Gy9xwNy+v=g@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] SRF: Fix offline CPU preventing pc6 entry
To: Dave Hansen <dave.hansen@intel.com>
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 4:17=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 1/10/25 03:59, Patryk Wlazlyn wrote:
> > Patryk Wlazlyn (4):
> >   x86/smp: Allow calling mwait_play_dead with an arbitrary hint
> >   ACPI: processor_idle: Add FFH state handling
> >   intel_idle: Provide the default enter_dead() handler
> >   x86/smp: Eliminate mwait_play_dead_cpuid_hint()
> >
> >  arch/x86/include/asm/smp.h    |  3 +++
> >  arch/x86/kernel/acpi/cstate.c | 10 ++++++++
> >  arch/x86/kernel/smpboot.c     | 46 ++++-------------------------------
> >  drivers/acpi/processor_idle.c |  2 ++
> >  drivers/idle/intel_idle.c     | 15 ++++++++++++
> >  include/acpi/processor.h      |  5 ++++
> >  6 files changed, 40 insertions(+), 41 deletions(-)
>
> Is everybody happy with this now?

It is fine by me.

Please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to all patches.

Thanks!

