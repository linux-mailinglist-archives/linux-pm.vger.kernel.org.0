Return-Path: <linux-pm+bounces-18546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54C89E3CA5
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 15:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91B93164A7C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 14:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC46E1FC7EC;
	Wed,  4 Dec 2024 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK1HbRaP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05B61F668A;
	Wed,  4 Dec 2024 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322225; cv=none; b=Z8F0xsGd6WE36+zb1NkoMMSxcUr9sPJenxI7TKB9yTj2vxJVtqXTHiyfxDtthB+LLYwAWNBTKtQLqQ5WAf3NFVmV2SUri3wtKVCpUfphhHylOYMxF+43PpicwHCuT1iD4N8KCQ0KHQGExu3lbe4AHXXKhUwMcWVJxJFUqV7U8N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322225; c=relaxed/simple;
	bh=WVBFh1vbH/dM9nPHYzn4lnHAc1WN0C29gdBv6iLRnts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dffDSt55uq/Ud+9H5/Yvf/EuNGEzvHVWdW7bw87wOoMJBjJTFat5Jq/4SI0AIKQzO//NK3Ut1UBkbL4hxDSZJk/zvwkBT0F/jRRtnBqR6tCbOnaFsl6+SR25CqOuqvMOS575B2TRKYppLf27ehEf7wXZOD8QG58/65exydN+xlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gK1HbRaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD2BC4CED1;
	Wed,  4 Dec 2024 14:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733322225;
	bh=WVBFh1vbH/dM9nPHYzn4lnHAc1WN0C29gdBv6iLRnts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gK1HbRaPKfIBX+5m0ezzw1zxFBPhle9IGDv+ipb3FG+RH79fAvoHiL3TS8yRuPUjR
	 1pyLEUiQX7uqaDZLodUzoSnvj5JG4F/oEgiinMkDmCag8llYIEuVJgpiDJYsUBvycG
	 GtdoNFmoWo3jNEqNK+imdLKPNVfX4bdsnHWpB4G65Gu8iFbpgEt1sP8YHAaU/gZLcD
	 YIXgtSODgc2dJXhVKqm+30efV3/v6ZcBa6MsouzsbEai7pGLBnJKNujtohJlv5dQiN
	 fOf7nGyDakCK+jLWF4HM+V1fgrs0hq9GWfmn0APcOZpXXDwJfzgqQWvhk0CPv5N+ba
	 j0Bq54KqlHILA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-29e52a97a90so2025606fac.0;
        Wed, 04 Dec 2024 06:23:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMXdtI8vkgPUfw3M1Jn4YZgT63K6rpu/GSYGyl+05FhYqwTFEmzwfZaLJezj2fnYmDM0gd9tKw0Bq5cLM=@vger.kernel.org, AJvYcCVhxzB8vhSldzwY0+PDSTSnwUQDMgT0A9EYqXQ8PfBpN7OG89+Ym/dLvWFNhAoU/vjbcyfZ7Pwyttk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNEO+Yqb3dg3C3DE8tjuCi8gt4QgUvRNz2ExUMRpgbVDBsCO1M
	CdFPsENZ4tNv9qv4NrLmTjt7j0lrB+V5vDDyZBG8NGTwl7abFWm3zHHmdi2DFITS0IGrneMqxsm
	vNmNrwNNasoWWes5VaRHuLS6Uu6c=
X-Google-Smtp-Source: AGHT+IHx3168Bsx73/kFton9Y52aMk0Ng5C67FNvzZqARZejbGLyps3tRfCafZQ0x/p+ts3B/bRIJgWTU8lVSMLdc+E=
X-Received: by 2002:a05:6871:3586:b0:296:e6d9:a2e1 with SMTP id
 586e51a60fabf-29e886638a7mr5172338fac.11.1733322224526; Wed, 04 Dec 2024
 06:23:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2787627.mvXUDI8C0e@rjwysocki.net> <2024120450-makeshift-haggler-625c@gregkh>
 <CAJZ5v0hyi_2KL-h_+CbCSsZcQXEP3BspBxCbhzmfX2KydSfRKQ@mail.gmail.com> <2024120404-work-confider-88f5@gregkh>
In-Reply-To: <2024120404-work-confider-88f5@gregkh>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Dec 2024 15:23:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gFAKi7P6HqopkPDo=U3H8-4r3AcKUrY4jYRgO=rzPDdg@mail.gmail.com>
Message-ID: <CAJZ5v0gFAKi7P6HqopkPDo=U3H8-4r3AcKUrY4jYRgO=rzPDdg@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Update stale comment in device_resume()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 3:20=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 04, 2024 at 03:16:05PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Dec 4, 2024 at 2:12=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Dec 04, 2024 at 02:02:04PM +0100, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > There is no function called __device_suspend() any more and it is s=
till
> > > > mentioned in a comment in device_resume(), so update that comment.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/base/power/main.c |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > Index: linux-pm/drivers/base/power/main.c
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Are you not using git?  This looks like the old cvs output :)
> >
> > I use git, but for patch generation I prefer quilt which has produced
> > this patch.
>
> From my .quiltrc:
>         QUILT_REFRESH_ARGS=3D"--diffstat --strip-trailing-whitespace --no=
-timestamps --no-index --sort -p1 -p ab"
>
> makes it almost look like the git output :)

Good to know, thanks for the hint!

