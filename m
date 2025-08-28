Return-Path: <linux-pm+bounces-33326-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCCEB3AA8D
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 21:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F22A03393
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 19:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DE12765EB;
	Thu, 28 Aug 2025 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwVBx0MH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD470BA4A;
	Thu, 28 Aug 2025 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407980; cv=none; b=T9ECadY/xgb2eN4dFctKSzT8ATScG4kBEYNHpwebS/hJIgZeUiMbkr1P+EJ23LY1rKGrZWZrAcjJ+IVYzknI6BL0fNRaQM+7qV9xOrik/VYmBadm0ks8PqY5jleTNDGdVca41MElVN+9vRXJXwZZe//Num3fdb+4CFIJJRKB03I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407980; c=relaxed/simple;
	bh=gi8hdVT9HHu4Wiplx3eEcjGfjRwntJaWHk89UtZXhIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmUg4GlQ6LgeUMu+/uzOb5tUtEfUTQ6sQCcNU3ojIBqh+lu3O1fw10wP/WWLCcQTGBF07Yn6VTNqM+/b7QTIecxZywKBO2JQX3ixaRxwiF9lkbawkj/DR0TgT0VIkJgvY8jQ9oVDw/wQ95P0j/MW+S+gEfrRULc/EBvcNwHIDaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwVBx0MH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9E3C4CEEB;
	Thu, 28 Aug 2025 19:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756407980;
	bh=gi8hdVT9HHu4Wiplx3eEcjGfjRwntJaWHk89UtZXhIY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SwVBx0MHNUw9i7h3MiWHMtMUDUcdQX6ADIPhyHsAxcGQVKb7L1u6XxAufCNDv72ia
	 5IwWvY2rdRaGFSjlu3D7TmWWI8txQHkZqXdcOQ38M69qx9bxVuMvyM2jdItuRAQ3JW
	 7NsyzYApYJTXjXcFI6IzUKEmAkhusUG/v/M5+UMucDxjOIKr+9TZfMfyUfvmwKxOIa
	 1mdep7vZO3TooI78g2EvnnOVoDqvLsYqrjyBeXYQpdXJJmKQ37saS7Rm8T9KliF8Dw
	 QFGZbQtU6jW5TQ8qAyz2WyMuxcBK88KpVNr/AgeW67A39uaUcWQPmKpF3G0JHwNfeE
	 KCihcSVFVaSFA==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-61de87bdca5so485067eaf.1;
        Thu, 28 Aug 2025 12:06:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXWx9IVcZ5UzANSuFMsDpfytwxuVAyZpG1CYTBM6JgDChjU63pS/GJhclLDpXfWLwl6DFiCiMPzn5NHnYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo1tPUWXbiXxVCRZJw9jE3UeIJN3MDeIgeEz2dV5iOr6wo6pn8
	dPKs0woNgHT7xIF0hIS2JCp5EohX66MjkDzG+f+wYf/ROQaL2IoDlKT6us+8ItgrOozYs5nyeTm
	kvfiZ+72iWJaqYVIKBfZNw09SNeec2tc=
X-Google-Smtp-Source: AGHT+IGwFaSRZyUZhEEneldJNoYsYHl9utLxDtabxa2KZNsv1+GJc4CaUPVJikGvi9LffPDKwXwYEBCoJwBegYhKsQw=
X-Received: by 2002:a05:6820:1606:b0:61e:1b97:149b with SMTP id
 006d021491bc7-61e1b971769mr1047086eaf.7.1756407979571; Thu, 28 Aug 2025
 12:06:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <724616a2-6374-4ba3-8ce3-ea9c45e2ae3b@arm.com> <CAJZ5v0gGchbaQWRq39JbrX8chca7uefef763coJeup+vUOfyCw@mail.gmail.com>
 <CAJZ5v0h=OG-wgcZBD8mZ51+kb7j3yeDZQt9XfO=fdasLRgQkEg@mail.gmail.com>
In-Reply-To: <CAJZ5v0h=OG-wgcZBD8mZ51+kb7j3yeDZQt9XfO=fdasLRgQkEg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 28 Aug 2025 21:06:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jdMHd7cRktE8xsQZMTkSK44LZCyFdWzDVLcasvfhJP-g@mail.gmail.com>
X-Gm-Features: Ac12FXxaSnQhGCowQgnVnFw2YbzFI8OZHxA8lLP5N1Zh1bHln2jBU2e0_npDctk
Message-ID: <CAJZ5v0jdMHd7cRktE8xsQZMTkSK44LZCyFdWzDVLcasvfhJP-g@mail.gmail.com>
Subject: Re: [PATCH] Revert "intel_idle: Rescan "dead" SMT siblings during, initialization"
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 6:13=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Aug 28, 2025 at 4:44=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Thu, Aug 28, 2025 at 4:26=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> > >
> > > This reverts commit a430c11f401589a0f4f57fd398271a5d85142c7a.
> > >
> > > Calling arch_cpu_rescan_dead_smt_siblings() in intel_idle_init with
> > > boot parameter nosmt and maxcpus active hotplugged boot-offline CPUs
> > > in (and leave them online) which weren't supposed to be online.
> > >
> > > With the revert and nosmt and maxcpus=3D12 on a raptor lake:
> > > cpu     online  capacity
> > > cpu0    1       1009
> > > cpu1    0       -
> > > cpu2    1       1009
> > > cpu3    0       -
> > > cpu4    1       1009
> > > cpu5    0       -
> > > cpu6    1       1009
> > > cpu7    0       -
> > > cpu8    1       1024
> > > cpu9    0       -
> > > cpu10   1       1024
> > > cpu11   0       -
> > > cpu12   1       1009
> > > cpu13   0       -
> > > cpu14   1       1009
> > > cpu15   0       -
> > > cpu16   1       623
> > > cpu17   1       623
> > > cpu18   1       623
> > > cpu19   1       623
> > > cpu20   0       -
> > > cpu21   0       -
> > > cpu22   0       -
> > > cpu23   0       -
> > >
> > > Previously:
> > > cpu     online  capacity
> > > cpu0    1       1009
> > > cpu1    0       -
> > > cpu2    1       1009
> > > cpu3    0       -
> > > cpu4    1       1009
> > > cpu5    0       -
> > > cpu6    1       1009
> > > cpu7    0       -
> > > cpu8    1       1024
> > > cpu9    0       -
> > > cpu10   1       1024
> > > cpu11   0       -
> > > cpu12   1       1009
> > > cpu13   0       -
> > > cpu14   1       1009
> > > cpu15   0       -
> > > cpu16   1       623
> > > cpu17   1       623
> > > cpu18   1       623
> > > cpu19   1       623
> > > cpu20   1       623
> > > cpu21   1       623
> > > cpu22   1       623
> > > cpu23   1       623
> > >
> > > Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> > > ---
> > > Rafael, I don't immediately see how to fix this properly so I won't
> > > try to, feel free to treat this as a bug report.
> >
> > Sure, thanks for reporting this!
> >
> > Well, I think that cpuhp_smt_enable() is missing a check.  It looks to
> > me like it should do the topology_is_primary_thread(cpu) check like
> > cpuhp_smt_disable().
> >
> > I'll cut a test patch for this later.
>
> Something like the attached one, perhaps.  I haven't tested it yet,
> but I'll do that later.

Works here AFAICS, but my test system is not hybrid.

