Return-Path: <linux-pm+bounces-25050-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915E5A83087
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 21:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB4217E477
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 19:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7A21E51E3;
	Wed,  9 Apr 2025 19:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6nnY5P5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A95165F1A;
	Wed,  9 Apr 2025 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226921; cv=none; b=tD3x2RjwUoiqYBY6BnPqkxd5+2o8lZTFeT5uR7ql+rQRg87bqVNboNxm2xYywVufBMDIuamum5X/A79VqQat9dFizHUegdnQsaMKxzFCWNXynLg6M+Wf/431hlx2FV98t5hDFsFUyHqZ2yY1mBqbgT4c6qWBRQ1FIW/U7as2pZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226921; c=relaxed/simple;
	bh=DhFwMu1PKUY4hicZ2+TMOX5Fqw+M6yOZu7nOaMMC/38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyCd1jbMcusx4rS7+TtqN0216protfBR56RvxDfr/DyYAU89w7/rOjfMkoSwEmd9ddJeFhfSqgfn0NdlI2MaeCqqxP8PkdgumtSVj22YQzAug2PupMZaLE1y3s/ufhf6bLLtJuv3fWda5yqlkQrXWiLp71R4WWQus/PQ4QlT91E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6nnY5P5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BC3C4CEEA;
	Wed,  9 Apr 2025 19:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744226920;
	bh=DhFwMu1PKUY4hicZ2+TMOX5Fqw+M6yOZu7nOaMMC/38=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t6nnY5P5bU0W7rQ8BC7DtGFfUACwss+wCt0kxkjCwbEzewsdu7f6z9SKj8BkvNSEo
	 UlbnyZyFNrj4hfWfGdwOd9/H5nfJEN9wSvhZy7MtGoZ1jgCbG5E8BgoeHQ4PZfB57l
	 WHILETRO3wQZAeUfPMvpyzFxFledF1Fb/JqW7aoved8oKzrgE9GWottedblTnESW/l
	 7rCgj8eBDrbJ6tZmzayOVA+DPBJX9RLXZ4iU42/9QeZfVaVccfQs7xFKpUxDIMGgRd
	 tVA2hNZ3VU6qu8CuBPMsrqDIZhr9LEsw81p7XTgqHczn9LfluxCUr/I99KeszxMyGj
	 0O8YoRUInNdmw==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2b8e2606a58so3833139fac.0;
        Wed, 09 Apr 2025 12:28:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBIS41QfOXTcnEU3KCOqNxh6at7j28prlbTfChJPaegxi9UELbYUt5ZIOBsNIFbd00Arw+BCm/2dcgiXg=@vger.kernel.org, AJvYcCW2rx9vr/5vCz+Uti4D/49nC1ooO0xXf6FzWhOKpPzQzND4LVAmIi1is6VglYPi37rtz2JgaKiSFzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjcxHKIdM0ijK0cC5/X5S4KJ1579aelm9w26Bms3++nwG9WryQ
	NneyVyu9a6fe2ubQ1VZVYhMu/pSshcqcCbJfOBnAUwpSNytEr5bCNlkAR2vZ4/fwGSKaWml72HC
	/69uGwW6DqqDNGzQeoAUosjMI5kk=
X-Google-Smtp-Source: AGHT+IFQrvV9siJvA+vy09af+rlvAnNn8NW1kjNdBkk+pxh+gUmoXyC+FogYn/4QTdn7lohQj3L7WQQYxEOm0GLA+n8=
X-Received: by 2002:a05:6870:aa98:b0:2cc:3603:f05f with SMTP id
 586e51a60fabf-2d08e08e3aemr2986761fac.35.1744226919578; Wed, 09 Apr 2025
 12:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
 <20250317-plat2faux_dev-v1-1-5fe67c085ad5@arm.com> <CAJZ5v0gcRDJFJtnPY+sszkUEYsdqxfm194Y7=namkD0qYnokHg@mail.gmail.com>
 <20250409-adorable-venomous-cormorant-d01246@sudeepholla>
In-Reply-To: <20250409-adorable-venomous-cormorant-d01246@sudeepholla>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 21:28:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jty2P6KoMH2i3vYwTaTH8a0HUBisKF0BBpHvoWuSOdDw@mail.gmail.com>
X-Gm-Features: ATxdqUGJQTSKhadOFmwt9qo96GsZu6OMpUapnTgnX2HxAu4AGKLXm61CGMUf6h8
Message-ID: <CAJZ5v0jty2P6KoMH2i3vYwTaTH8a0HUBisKF0BBpHvoWuSOdDw@mail.gmail.com>
Subject: Re: [PATCH 1/9] cpuidle: psci: Transition to the faux device interface
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 9:18=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com> =
wrote:
>
> On Wed, Apr 09, 2025 at 08:03:32PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Mar 17, 2025 at 11:13=E2=80=AFAM Sudeep Holla <sudeep.holla@arm=
.com> wrote:
> > >
> > > The PSCI cpuidle driver does not require the creation of a platform
> > > device. Originally, this approach was chosen for simplicity when the
> > > driver was first implemented.
> > >
> > > With the introduction of the lightweight faux device interface, we no=
w
> > > have a more appropriate alternative. Migrate the driver to utilize th=
e
> > > faux bus, given that the platform device it previously created was no=
t
> > > a real one anyway. This will simplify the code, reducing its footprin=
t
> > > while maintaining functionality.
> > >
> > > Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Cc: linux-pm@vger.kernel.org
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > Do you want me to pick up this one?
> >
>
> Yes you can pick this up.
>
> Just checked again, this is v1 and correct version.

Applied as 6.16 material, thanks!

