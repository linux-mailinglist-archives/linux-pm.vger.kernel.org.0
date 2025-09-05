Return-Path: <linux-pm+bounces-33987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ECEB458FD
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 15:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C06E5C658B
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 13:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507B1350D5D;
	Fri,  5 Sep 2025 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKzK8HwJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2623B342CB6;
	Fri,  5 Sep 2025 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078870; cv=none; b=rDeBvoU3Tblf72+5Zp0StkfRygP2ga765ZkXchKAdryeAHgJobGx0EJDkZ/fxiz8SIKcc2CT297rkbt/diIqtOUO4QnOzOqkj8vyMq8bihZU2U+fnl/DXprDuUBEkcrKorrgV3kL7QT+6OzQ9J0J31n27WQsmCI/PUxTcFgqsIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078870; c=relaxed/simple;
	bh=bkDiGEH9mofzXHj8b43dFa+vNYhnCsf6eSp58t4nD0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vw79rVtG7bVblC1FRh72rDLC6lWWkZ4Pg84nkB+/7r1vs3mKQE5y3MWsN0cCunrovDsZHRdHYvfUGpdXJ5wG1cujbTPW5gUTb90faXi0nstajrYBsOgR35QPIHuMfl30ZerWpBZJ5N8yhAbrJEtvIvwCXPD965vCyd79pgL9gmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKzK8HwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED3AC4CEF1;
	Fri,  5 Sep 2025 13:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757078869;
	bh=bkDiGEH9mofzXHj8b43dFa+vNYhnCsf6eSp58t4nD0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZKzK8HwJelgMsbYdzwhnxbdctZN6JAOs3mNjddqVTfeTJcZCznr03oeiwuSJOGolc
	 BGPfQF5rKDJHyNV37fLseaAZo7x27gkfDMatA7hhA15FerFa01R5QYoElWMPLIhHgK
	 tR0wz+OttjzOGmnr+XL0i7xpkaTgemOVXZkRVG12/cwBi0Sm/HGusVNiCXwsImcfLU
	 sQCt/IWR01nb0evujWyCZ68e/7JVpWPG1PGHcuX3XAPRpgjcjxdtULgGYkRbQ0IrmY
	 vvovJH+FPoP/HcGZIEnECvZlbM06F2/nELuHaMprOa8WEY7pW3GU3vTKbCYhT5s/8q
	 w6KsI0Hpprq8g==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-621132816c8so239639eaf.2;
        Fri, 05 Sep 2025 06:27:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+2+nYnFD1sr2LxuCX/EQO/pHkqMPpl01jD5DOYa4qUJira4PRFj5wWTFTiyxGXLztubvDNu8JXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLAZzBBsw2K2j0nyLwAXXhNJqHQ7WIB2wnwkG6YF45aoJblZKe
	IjswEhOC7ejSnr0U+SQuRetXm+hql6bPWVzo2zNG1J6lVAaaPkBKVeJf4GR/1oxJPdMTJ8lJiqE
	7i7sa7Rg5nW1TysvlpbWjoRHqiJtwqgU=
X-Google-Smtp-Source: AGHT+IGPRWd+q+YxOwqf+vnrps+eVyqGapv8AXVlvXl2AJPnm7qAHFqI6kUWN2tMvBWWgomBtdJwXRMUWld+xB6w+N4=
X-Received: by 2002:a05:6820:80e:b0:621:7095:5ab8 with SMTP id
 006d021491bc7-62170956069mr574409eaf.4.1757078868929; Fri, 05 Sep 2025
 06:27:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12740505.O9o76ZdvQC@rafael.j.wysocki> <871polxs9c.ffs@tglx> <CAJZ5v0jyN0=aGFOwE8fzuXi=1LgiLR5wgvvsAihGB0qpUp=mUQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jyN0=aGFOwE8fzuXi=1LgiLR5wgvvsAihGB0qpUp=mUQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 15:27:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gsiuK5iFY6cHaqEgP8R1sz_pWGoqac2orYvXqLE2xbDQ@mail.gmail.com>
X-Gm-Features: Ac12FXzrqP5sVZPQ5P_Y_4KwJCjSeScS_1OvhUlPcf2eQvrS-Sas5tE8X0ltMTY
Message-ID: <CAJZ5v0gsiuK5iFY6cHaqEgP8R1sz_pWGoqac2orYvXqLE2xbDQ@mail.gmail.com>
Subject: Re: [PATCH v1] cpu: Add missing check to cpuhp_smt_enable()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Christian Loehle <christian.loehle@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 3:13=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Fri, Sep 5, 2025 at 9:39=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
> >
> > On Fri, Aug 29 2025 at 22:01, Rafael J. Wysocki wrote:
> > > --- a/kernel/cpu.c
> > > +++ b/kernel/cpu.c
> > > @@ -2710,6 +2710,12 @@
> > >       cpu_maps_update_begin();
> > >       cpu_smt_control =3D CPU_SMT_ENABLED;
> > >       for_each_present_cpu(cpu) {
> > > +             /*
> > > +              * Avoid accidentally onlining primary thread CPUs that=
 have
> > > +              * been taken offline.
> > > +              */
> > > +             if (topology_is_primary_thread(cpu))
> > > +                     continue;
> >
> > Hmm. That's kinda solving the problem, but I think the proper solution
> > would be to implement topology_is_core_online() for x86.
> >
> > The above is preventing the primary thread to be onlined, but then
> > onlines the corresponding hyperthread, which does not really make sense=
.
>
> Well, manual online can be used for onlining the secondary thread of a
> core where the primary thread is offline, so this is technically
> possible already.
>
> > Something like the completely untested below.
>
> So given the above, shouldn't topology_is_core_online() check if any
> thread in the given core is online?

Besides, this would cause the siblings of offline SMT threads to be
skipped while enabling SMT via sysfs (using
/sys/devices/system/cpu/smt/control), but I'm not sure if this is the
expectation in the field today.  The current behavior is to online all
secondary SMT threads (and more, but that part is quite arguably
broken).

That's why I decided to use a simpler patch which doesn't go that far.

