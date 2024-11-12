Return-Path: <linux-pm+bounces-17455-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B35E9C61B0
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 20:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33DCF1F23E32
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 19:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28019218D76;
	Tue, 12 Nov 2024 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxWNWLeP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1830217472;
	Tue, 12 Nov 2024 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440645; cv=none; b=cVOI6u8mzC48efwT33J1dYWCzVJsydbsotZmbAxFjxzJx8nm//7I9nggO5ythpR+SKkEWGaadPMHVIqinEJrPmnjxa33q1FQqtEgfyYuJ41YYNFwAY8IRHXpR69Ku+Xlcu6NEfJciojJjzgK78+8LNN/3Wac6ND7Nl4R3pa++4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440645; c=relaxed/simple;
	bh=AappissoYwBNcNYycxE66m9DbEWKCEwjUg0eYlGwP8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urFMfYOdyUQ2xb4bhmPvc2IDjbTBgcYxlV9N1uyCLdCrGzvJzOVYvCbhY3WsKt1fu50RIv0IjxH+0+1Dt6sqH64G3SRPUdYCje6WrOa/40LK8Ju3xS9yeLivlC9bUUmFKgvrD8HSa31KJ10k2cr4XTArchYavwovMmZxu9f2wDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxWNWLeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFCFC4CED7;
	Tue, 12 Nov 2024 19:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731440644;
	bh=AappissoYwBNcNYycxE66m9DbEWKCEwjUg0eYlGwP8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pxWNWLePMNZdYawxFizFsDYK0OcSTcUKxoCjOZ5egmAO3Kt9QPEXkh0f/6oRyRhkK
	 abigGQ6dgrmeIWwHzs/xXLX/VnN/Ybigpcl3I3I9aY2obrBB+VKF4K6E0lLG/TgbfE
	 Z7Wc2pzAsU0n67TgJahOBfalwij83r1veWp0+tob59x0wUkhswI5wOJl5JVqBrMhFS
	 jndZtaheAU92BlQCK1vuk45uh55zyBTpqrfLF1xQKvuxCAHbNTjZ9zkDne0hTZImq6
	 k4O8Po7kXHFu4+SCrC9e/uD1VWxXVHb4N48Xbd3SnyiLpanTvSfhSU4vw9xy6SqhYl
	 7wok/TftT+bLg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ee763f9779so1390459eaf.1;
        Tue, 12 Nov 2024 11:44:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVE/RPYbX5WjjmQyEfrCckrX+Ug7GWLBtxm0ewh8GsaP2ITuNkwT8/JvAqoCrYYT9ZqjYsgccbAk54obc4=@vger.kernel.org, AJvYcCXxcorTXFWaoKaSnwmwVTXaq09rFwfaWd6S+TC09sS9VNhFyfjlqYy3/q7mYgenO+KAK3G7SKC35x0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6nhGHp1ucODtHFOEvOAh6SlFZjx6y447DTOYhKFiJ+OHoc6Sq
	9N82B8VU5BT/AqcCRoq9EsRpFxzRM7X0Jvm9myoYDvjSSUBtYpH+/ED+5ILC2vqWMynE3gHA0aa
	w5JL6kMHQBmpd5vFFpZIlnemtMQU=
X-Google-Smtp-Source: AGHT+IEhsv9UvrCRWDRDHoyy3aqZW5R0nVDTG4fF3r1Jv5EWx3lZsgY2xS60eMDDAws9uWOxPX271nuFHZ8Vdp7/BBs=
X-Received: by 2002:a05:6820:983:b0:5ee:bb2:bdd4 with SMTP id
 006d021491bc7-5ee57b96aadmr12232598eaf.1.1731440643623; Tue, 12 Nov 2024
 11:44:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-4-patryk.wlazlyn@linux.intel.com> <b6ab357c-1562-4035-ad3a-2159d2c8c1fa@intel.com>
 <ee9b0a70-6f44-4203-bba9-c07d94444ad6@linux.intel.com> <CAJZ5v0gmg_6OnzR6BNm+3Mx0Wzsf2nPQEZDutYu_-Px-TsvX-w@mail.gmail.com>
 <87serwmfbx.ffs@tglx>
In-Reply-To: <87serwmfbx.ffs@tglx>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Nov 2024 20:43:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iR5A8AdEU-v34oG4i9ceW2uS4D2EWfwKcmDVnTO8F9_g@mail.gmail.com>
Message-ID: <CAJZ5v0iR5A8AdEU-v34oG4i9ceW2uS4D2EWfwKcmDVnTO8F9_g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] intel_idle: Provide enter_dead() handler for SRF
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, 
	Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 8:18=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Tue, Nov 12 2024 at 12:28, Rafael J. Wysocki wrote:
> > On Tue, Nov 12, 2024 at 12:18=E2=80=AFPM Patryk Wlazlyn
> > <patryk.wlazlyn@linux.intel.com> wrote:
> >> I don't think so. The old algorithm gives fairly good heuristic for co=
mputing
> >> the mwait hint for the deepest cstate. Even though it's not guaranteed=
 to work,
> >> it does work on most of the platforms that don't early return. I think=
 we should
> >> leave it, but prefer idle_driver.
> >
> > IOW, as a fallback mechanism, it is as good as it gets.
> >
> > As the primary source of information though, not quite.
>
> So we have at least 5 places in the kernel which evaluate CPUID leaf 0x5
> in different ways.
>
> Can we please have _ONE_ function which evaluates the leaf correctly
> once and provides the required information for all places ready to use?

Yup, that's what needs to be done.

