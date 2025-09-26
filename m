Return-Path: <linux-pm+bounces-35490-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57404BA4BC7
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 19:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A983849A5
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 17:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EDA30C615;
	Fri, 26 Sep 2025 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMiEpzTZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA4426D4EF
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758906509; cv=none; b=SPj64Jyr2ewAt2GDerP3RVvVg7Um15NUTKpU4ylQajP23Z4BR1+sLSM5tSSRoKTocGf5v8TB7HflWAlll28UrbMaAxv+yEGUEnY0lIVuZBQurDFMPFSClq2Z/dpE09SEXpNYlfanhIOuwFjrUuwmnuRuVowhpQ9cEJ7LQ7/AA34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758906509; c=relaxed/simple;
	bh=2k2hTdvMUMCBLwcaMUYR14NEFrjKaCrWCdwr1BF81Cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rb9yDuYM5MSbV9cNvmSmbGcWKJVyH/b+yFFE51uq2NxdWww+XSLFL3szM7Gv6smBWpVIYx26GDpe5CN0Sm3/d411rg50VwEGo7s5oNwQPrSWEg4WmzgEnmtNhM+0EVP4PYMYA59SzSPj3Mw4+6Awy/13tG82s5J55/nBQEqcVzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMiEpzTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CE7C113D0
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 17:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758906509;
	bh=2k2hTdvMUMCBLwcaMUYR14NEFrjKaCrWCdwr1BF81Cg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CMiEpzTZJcual83j5hUldPV7+sHvWuKekiGZpRbf8yW4eWpZHbUvLCpeOt9NV/nMh
	 uJm8f2PXJmUdV4iu+E3DBbVyZpz9pPQqHgtys75AFnCO0IxcaLjqe7xfqcGNjEiFjV
	 YuFElmU8ijUO12SEIBM6QEJbwj35Sx0W0Fgh/HiOvxTCULZMcH6D7qa2LnJLvu5Cd+
	 2OUW3yVplKehk2pkpNswf4pNDZWD5Mj7RG2VujP4oj4R+1mz0VVyQqDmkSa5o0zl7O
	 bo0GN3l/Ptt4bCS4mZm8C9BVeh/Qrs1TLSHmQjeWnqB5J38yPud+FBazAD8qBsInWE
	 yv6YTFw+LbHqw==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3627a1979a0so2034109fac.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 10:08:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfC39nt2gIS5RdjmhtpSSCaba8KJH8TMBbGp0V1VV+pNtd9drVsyYyjPoWrXKhIynTR8ST4RorOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTAlDrr4fS0xmLh9Z3YHgcDUxF86MIYXkIwPO1aixmLTtTQzdC
	Ju3CAJMAmp1RRsse91D+LtEnu/XNmJcopOAjDo7L9z1uhPYIdnYBL0zjZZsBf/2gmzuZzQfwWis
	3IYP5KBvkTthlJbXHDJcaRLHMGLY2xAA=
X-Google-Smtp-Source: AGHT+IH2mRpZIU8ZaEbNdZwTO1VJh8Q624WlaeOlz908V4Q1o4tThzIUzp9Web59JAo2CF5s+jg+70n4pfAm8Y+ST1k=
X-Received: by 2002:a05:6870:f609:b0:35d:45c7:4a83 with SMTP id
 586e51a60fabf-35ee837d602mr4724817fac.23.1758906508329; Fri, 26 Sep 2025
 10:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925115924.188257-1-ulf.hansson@linaro.org>
 <DD1XOHE6P5OC.2JUQRAGAE1KTU@cknow.org> <CAPDyKFrKP2bdpKTHzqDdhEpRAjYu+PFd2Bst=-WPddByxcAX_w@mail.gmail.com>
 <DD22MGF3HNLM.Q7S70RX4NZXS@cknow.org> <CAGETcx-WY1x_ud8Ef1jbpYQVtFv7MZHMpHfSVKA9R9tya0Lxjw@mail.gmail.com>
 <CAPDyKFp0uV2WaQGjwsO8JG1zF_1oXj7-GVnaejih+dN9RAdykg@mail.gmail.com>
In-Reply-To: <CAPDyKFp0uV2WaQGjwsO8JG1zF_1oXj7-GVnaejih+dN9RAdykg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Sep 2025 19:08:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g_QHQzYTN4Sra_gGQXmRDxUPEjDMyOMB4+PxHcD6vfsQ@mail.gmail.com>
X-Gm-Features: AS18NWAipPCw_sbfz1uZIP7ywHKnNEbuCNxO6eGIBb1HO8SG50NvmitiB8SDjLc
Message-ID: <CAJZ5v0g_QHQzYTN4Sra_gGQXmRDxUPEjDMyOMB4+PxHcD6vfsQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: fw_devlink: Don't warn in fw_devlink_dev_sync_state()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, Diederik de Haas <didi.debian@cknow.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Heiko Stuebner <heiko@sntech.de>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Sebin Francis <sebin.francis@ti.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Jon Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 2:05=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Thu, 25 Sept 2025 at 23:49, Saravana Kannan <saravanak@google.com> wro=
te:
> >
> > On Thu, Sep 25, 2025 at 10:52=E2=80=AFAM Diederik de Haas <didi.debian@=
cknow.org> wrote:
> > >
> > > On Thu Sep 25, 2025 at 4:26 PM CEST, Ulf Hansson wrote:
> > > > On Thu, 25 Sept 2025 at 15:59, Diederik de Haas <didi.debian@cknow.=
org> wrote:
> > > >> On Thu Sep 25, 2025 at 1:59 PM CEST, Ulf Hansson wrote:
> > > >> > Due to the wider deployment of the ->sync_state() support, for P=
M domains
> > > >> > for example, we are receiving reports about the messages that ar=
e being
> > > >> > logged in fw_devlink_dev_sync_state(). In particular as they are=
 at the
> > > >> > warning level, which doesn't seem correct.
> > > >> >
> > > >> > Even if it certainly is useful to know that the ->sync_state() c=
ondition
> > > >> > could not be met, there may be nothing wrong with it. For exampl=
e, a driver
> > > >> > may be built as module and are still waiting to be initialized/p=
robed.
> > > >>
> > > >> "there may be nothing wrong with it" doesn't sound very convincing=
.
> > > >> So there *can* be something wrong with it, so warning sounds
> > > >> appropriate? If there is (certainly) something wrong with it, I ex=
pect
> > > >> an error.
> > > >
> > > > Sorry if I was too vague. See more below.
> > > >
> > > >> FWIW: most of my drivers/modules are built as modules.
> > > >> I do seem to run into 'problems' more then average because of that=
, but
> > > >> to me it just signals there is something wrong ... which should be
> > > >> fixed. Not silenced.
> > > >
> > > > Well, why is it wrong to have drivers being built as modules? They
> >
> > IIUC/Remember Kconfig correctly, FW_DEVLINK_SYNC_STATE_TIMEOUT should
> > be off by default? (if I don't give any default, what ends up
> > happening?)
>
> As "FW_DEVLINK_SYNC_STATE_STRICT" is default, the "sync_state()
> pending due..." print gets printed for a lot of consumer devices that
> have not been probed yet.
>
> >
> > If we can assume, timeout won't happen by default, then the only
> > people seeing this warning are people setting the flag or setting the
> > command line param. So I'm okay with making it an info.
>
> I think you got this wrong. It's the default behaviour that triggers
> lots of prints.
>
> >
> > But the "sync_state() pending due to" is for the default behavior. I'm
> > assuming without the sync_state() supported added to power domains,
> > the ones getting this warning would have been powered off? But after
> > the sync_state() support, it's not powered off anymore. That can cause
> > increased power usage. Seems like something worth warning about.
>
> Yes, I certainly agree, but...
>
> To me, it kind of sounds like we should change to use
> FW_DEVLINK_SYNC_STATE_TIMEOUT as the default behaviour. In that case,
> I don't think there is a need to change the log-level for
> "sync_state() pending due to..".
>
> >
> > Also, another thing I want to understand is, for all the reports you
> > are getting for "sync_state() pending due to", is it actually correct
> > to have them pending? Or can fw_devlink do better in those cases and
> > turn them off? It could be a driver fix/fw_devlink fix depending on
> > the issue.
>
> There are some cases that we potentially could fix, in particular for
> when a genpd-provider, provides multiple power-domains per device-node
> (#power-domain-cells =3D <1>;). But let's discuss that separately.
>
> >
> > TL;DR:
> > 1. For timeout messages, since timeout isn't default behavior, I'm
> > okay making it an info. But
> > 2. For pending sync state messages, I think it should remain as a warni=
ng.
>
> See above.
>
> This means drivers being built as modules will trigger a lot of
> warnings, in the default behavior. Is this really what we want?

No, at least I don't.

Printing a warn level message about anything that is not a clear
functional issue is seriously problematic IMV.

As for whether or not the messages should be info level or debug
level, it also depends on the amount of noise generated by them.  IMV,
generating a lot of noise at the info level is not really useful and
may cause some actually useful information to be missed.

