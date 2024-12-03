Return-Path: <linux-pm+bounces-18451-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB639E1DAC
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 14:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D42FB25FA7
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 11:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494D01632E6;
	Tue,  3 Dec 2024 11:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swIpzDOq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044E1DA0F5
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226907; cv=none; b=XAkfDU26vhZWa5EJDg6tTfXOSsxhW//OXbrNbXKGGEnrHX0Ji6en9/RZNEWId40tDJfizxrJSSVOEJi8/Oabqf/Qkb/KqNw/lRvMAoBIKESwqkgrlPzxH74EICjy13WHB/QIQHAoLG8zV9mk9BrMDBGdHY1uZaw31SS/iQgSU3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226907; c=relaxed/simple;
	bh=N/o9QrpTvLGERh33N1iKh6DaRqNYdNgXwjWQfAK0g9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwu7J3q6Ig9vYwJsDbiNluYMFd4QaTw1pb7VovPbUb9zTKxKmxiqK50Bm6rbYloYE/UhOLcem7xTVGzh+Bl/SLVTezPhks9inPFkGU25CefP9ljQRZkgSC+Zc/N1NOFEwqKuaSyKvOUeACWhG+8xuq8Fg32kRs2AlXVTumZycDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swIpzDOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA50C4CEDA
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 11:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733226906;
	bh=N/o9QrpTvLGERh33N1iKh6DaRqNYdNgXwjWQfAK0g9k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=swIpzDOqw+Ean7bXywtFyc96sxzlE+L9v2fFpXgTLoFrh4L8ISWn8Xl6P69kGerS1
	 p57OgE5hQwnvXODczvo39EhrCMS07BNHWB4UvrGANNhRkddda+3Jc68mNkjelb/YtJ
	 2FQ3SfAmbEz2pVB8OcB/WM0IRxQMpC9xyNP+iUY1fx7I0UxGwhKB6DKVcfgyLSfcPF
	 gDzkIEZg8kC3k79Jh1uwO22VVPJ+v17v66O1yf3muzjkyW3UcbiGPj6KWMdUthzliw
	 n0IM6+qkCzYDX6sPgZbF0siM7zWo5a3SpLQdr7iSTYtulf0iJa4Jqqfvkh2EDGRdqE
	 MnFO/UPALfhMQ==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5f1dc7c6c67so1677652eaf.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2024 03:55:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXarMTSblQAFIzPL1oYJtw9uKE2+JlbnRHuPX68426ycKpGL0ac4K2qWXdX056m+o5l6Ez92jud6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyReJvYpVVidj6bVdNkPTXRO55YdxlpStAV7GJkaYCjIUUsPpBz
	0r3Ielz3OwC8uCTWN16QECUzY4qGWWzZl6DkGQ2hTl1UJmxLgUjt3EdmhAM236OfwAIj9ng+Nx1
	gZ3VisnrbTFV4Lqv7DOJGnFhSXEo=
X-Google-Smtp-Source: AGHT+IGwR11wmC26MnR8qrUzuGc81R3ZFhKQnYAGjMelBFIRYZk3yBB7hTR2KVin5ABaPEhvg7rYJaJEzZPTOUD7+lk=
X-Received: by 2002:a05:6870:46ac:b0:29e:6b6a:d6f4 with SMTP id
 586e51a60fabf-29e8890fbccmr1953346fac.37.1733226905887; Tue, 03 Dec 2024
 03:55:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SJ1PR11MB6129CCD82CD78D8EE6E27EF4B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <SJ1PR11MB612965ACA3E84745346F0400B9362@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <5e405ad4-34d6-4507-978f-3d81d4af2455@t-8ch.de>
In-Reply-To: <5e405ad4-34d6-4507-978f-3d81d4af2455@t-8ch.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Dec 2024 12:54:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iXKvaxz-hmW2+qwTcSmtPJ23Hv04CMnmT=qPE0ytNwLg@mail.gmail.com>
Message-ID: <CAJZ5v0iXKvaxz-hmW2+qwTcSmtPJ23Hv04CMnmT=qPE0ytNwLg@mail.gmail.com>
Subject: Re: Regression on linux-next (next-20241120) and drm-tip
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, "Coelho, Luciano" <luciano.coelho@intel.com>, 
	"Saarinen, Jani" <jani.saarinen@intel.com>, "Nikula, Jani" <jani.nikula@intel.com>, 
	"De Marchi, Lucas" <lucas.demarchi@intel.com>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 7:51=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weisssc=
huh.net> wrote:
>
> (+Cc Sebastian)
>
> Hi Chaitanya,
>
> On 2024-12-03 05:07:47+0000, Borah, Chaitanya Kumar wrote:
> > Hope you are doing well. I am Chaitanya from the linux graphics team in=
 Intel.
> >
> > This mail is regarding a regression we are seeing in our CI runs[1] on =
linux-next repository.
>
> Thanks for the report.
>
> > Since the version next-20241120 [2], we are seeing the following regres=
sion
> >
> > ```````````````````````````````````````````````````````````````````````=
``````````
> > <4>[   19.990743] Oops: general protection fault, probably for non-cano=
nical address 0xb11675ef8d1ccbce: 0000 [#1] PREEMPT SMP NOPTI
> > <4>[   19.990760] CPU: 21 UID: 110 PID: 867 Comm: prometheus-node Not t=
ainted 6.12.0-next-20241120-next-20241120-gac24e26aa08f+ #1
> > <4>[   19.990771] Hardware name: Intel Corporation Arrow Lake Client Pl=
atform/MTL-S UDIMM 2DPC EVCRB, BIOS MTLSFWI1.R00.4400.D85.2410100007 10/10/=
2024
> > <4>[   19.990782] RIP: 0010:power_supply_get_property+0x3e/0xe0
> > ```````````````````````````````````````````````````````````````````````=
``````````
> > Details log can be found in [3].
> >
> > After bisecting the tree, the following patch [4] seems to be the first=
 "bad"
> > commit
> >
> > ```````````````````````````````````````````````````````````````````````=
``````````````````````````````````
> > Commit 49000fee9e639f62ba1f965ed2ae4c5ad18d19e2
> > Author:     Thomas Wei=C3=9Fschuh <mailto:linux@weissschuh.net>
> > AuthorDate: Sat Oct 5 12:05:03 2024 +0200
> > Commit:     Sebastian Reichel <mailto:sebastian.reichel@collabora.com>
> > CommitDate: Tue Oct 15 22:22:20 2024 +0200
> >     power: supply: core: add wakeup source inhibit by power_supply_conf=
ig
> > ```````````````````````````````````````````````````````````````````````=
``````````````````````````````````
> >
> > This is now seen in our drm-tip runs as well. [5]
> >
> > Could you please check why the patch causes this regression and provide=
 a fix if necessary?
>
> I don't see how this patch can lead to this error.

It looks like the cfg->no_wakeup_source access reaches beyond the
struct boundary for some reason.



> Could you doublecheck the bisect?
>
> Note: Having line numbers in the trace would be very useful.
>
> > Thank you.
> >
> > Regards
> >
> > Chaitanya
>
> Thanks,
> Thomas
>
>
> >
> > P.S. We could not revert the patch cleanly and therefore we are yet to =
verify the bisect but we are currently working on it.
> >
> >
> > [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
> > [2]https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/=
commit/?h=3Dnext-20241120
> > [3] https://intel-gfx-ci.01.org/tree/linux-next/next-20241120/bat-arls-=
6/boot0.txt
> > [4] https://cgit.freedesktop.org/drm-tip/commit/?id=3D49000fee9e639f62b=
a1f965ed2ae4c5ad18d19e2
> > [5] https://intel-gfx-ci.01.org/tree/drm-tip/index.html?
>

