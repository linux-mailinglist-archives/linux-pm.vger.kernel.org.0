Return-Path: <linux-pm+bounces-8803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B326900C6E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 21:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2461F22659
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 19:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3E813C3F9;
	Fri,  7 Jun 2024 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbff5fk3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534DFD2E5;
	Fri,  7 Jun 2024 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717788227; cv=none; b=sE6Xs1nNtgVc4iV7ST4mOuVyvFHD3lpLVVP6QJHAbb3NfruMK7nRbCAhArRkTHgoy6pnDyOGB0916wpNmGEWBr/uCPCeJtx29fYdWhW3Uhvet28oJPtf1rYruySgdrAbws1kjxv+JkKDME5xhChEPJUKi8j1ljN8YKhvlhtvey4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717788227; c=relaxed/simple;
	bh=IRIu25eul++r8OdWAyggt5URxrtTicHpzECu6XHEj54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAzluP8F2tYSh+4QrqHHqgwB/8GLSlwtmT6RtmZLf5EkCp4PyiuBQmCkZudi6jTyGem6nDI+35nFVsIQ/flnHh/ALwXwM9TwYvkNYZz5tAS9wsMbqZGKF9G94bvlOzcLlZdvIscLUeAbBygsgGyrw/rSwEcPepbg2NTXKbBCxWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbff5fk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC1BC32781;
	Fri,  7 Jun 2024 19:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717788226;
	bh=IRIu25eul++r8OdWAyggt5URxrtTicHpzECu6XHEj54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mbff5fk3giQb+LSX22q/5wLdn3Pnn4oQ+5YZLnLmTpXed1gWI1KHZZ5cWDztWeaVu
	 pktK5LmrGF6nMiL8AhUsyclipV//lbxdP5mYpx//VwkXXYPHITOGpYpM3Yrd2TQJlo
	 TM/Zsz6rLlxXJkxHcwtjhKn9sxtdDwEFOlai+9QMNBdaS2q0ky93VDJ8tI9aqFTn7H
	 OUMBoO+ZksJGtwVhPdwSE9q6XXp9CkaQYeb3dOG7pruNjjnlQPqLZh7seQ6YrCKT3H
	 UmzVI6f9jJSLXw6u2fPv1YOB3hhPF92Q+CSgvpV1caXH9gclhjCpREZcJQuffRLL5s
	 IzToQbK/RU7Cw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b3364995b4so396289eaf.0;
        Fri, 07 Jun 2024 12:23:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWC4GfTsrf2+IiIT7jG255sgN5kv01kmYQ77DOUtjsJglz1ZkVKgOsAqp+tnndGa+/E9uOmSMPsowd4adlQQ02ZZXc8eal4jKVcdL4AbstxRVXMWUcGJqWYssFu0rDLCV2lNjXzL90=
X-Gm-Message-State: AOJu0YygH+C2+iXJZV22BHb3Doxe9+43ZZ5cYgSGRaOy/FmVJoW7hig2
	AKVzD7PDoLG3aRkB1L4d6GsjWnOvqCb5jIpDq5xP4KkAPSuY6QdviB8BzW4jChQ9nea/pf2ccfE
	PrOgBZB9rZi1ogF0+YjaM6eT8nIo=
X-Google-Smtp-Source: AGHT+IGg7vhWlPX7XrfJDgTnk+B9qkmOr0V2Zf6wZmLBMHuN799C97wvRKO1GMUXidLvNCxejZmzi7MXHyKyTJBvus4=
X-Received: by 2002:a4a:ac08:0:b0:5aa:3e4f:f01e with SMTP id
 006d021491bc7-5baae73b688mr3334682eaf.1.1717788226269; Fri, 07 Jun 2024
 12:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529175309.83294-1-linux@treblig.org> <cf30918b5db386910ee38a33f3cbc0bd7da34a4e.camel@intel.com>
In-Reply-To: <cf30918b5db386910ee38a33f3cbc0bd7da34a4e.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Jun 2024 21:23:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j8=4ZKn-i=Z_BSQZObUQFrdV7i7W_3JskSzqWs9D4=FA@mail.gmail.com>
Message-ID: <CAJZ5v0j8=4ZKn-i=Z_BSQZObUQFrdV7i7W_3JskSzqWs9D4=FA@mail.gmail.com>
Subject: Re: [PATCH] thermal: int3403: remove unused struct 'int3403_performance_state'
To: "Zhang, Rui" <rui.zhang@intel.com>, "linux@treblig.org" <linux@treblig.org>
Cc: "rafael@kernel.org" <rafael@kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 9:21=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com> wr=
ote:
>
> On Wed, 2024-05-29 at 18:53 +0100, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > 'int3403_performance_state' has never been used since the original
> > commit 4384b8fe162d ("Thermal: introduce int3403 thermal driver").
> >
> > Remove it.
> >
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>
> Acked-by: Zhang Rui <rui.zhang@intel.com>

Applied as 6.11 material, thanks!

> > ---
> >  .../thermal/intel/int340x_thermal/int3403_thermal.c   | 11 ---------
> > --
> >  1 file changed, 11 deletions(-)
> >
> > diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> > b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> > index 86901f9f54d8..c094a422ded3 100644
> > --- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> > +++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> > @@ -25,17 +25,6 @@ struct int3403_sensor {
> >         struct int34x_thermal_zone *int340x_zone;
> >  };
> >
> > -struct int3403_performance_state {
> > -       u64 performance;
> > -       u64 power;
> > -       u64 latency;
> > -       u64 linear;
> > -       u64 control;
> > -       u64 raw_performace;
> > -       char *raw_unit;
> > -       int reserved;
> > -};
> > -
> >  struct int3403_cdev {
> >         struct thermal_cooling_device *cdev;
> >         unsigned long max_state;
>

