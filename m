Return-Path: <linux-pm+bounces-43861-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APkBLdEaq2lNaAEAu9opvQ
	(envelope-from <linux-pm+bounces-43861-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 19:20:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B010D2269FD
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 19:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40797300B9EA
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 18:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E673F0773;
	Fri,  6 Mar 2026 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DumPu8WH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E1536829E
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772821196; cv=none; b=hoWh3PTcEzrr/ic7E/iicfNyi/frpuyh6dQ3JgXog/LOsmzDvogMmbdXuIrw6wCMw4qZTZInZ4Gfe/AkAeL6jhVyVrb2QMoRGzJzWd0SawClhQW94DXegD+vd5kf810BMjsnoOHVApuGA5MiGi/aCCejkviyJKJwo7SoAA4VHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772821196; c=relaxed/simple;
	bh=3rmHBEZQR/uYQF8Cx03Lof9XN7U5JSyV3pEdqbqOwtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptP5ii+xNfESIG5lI1Oop0uVvT4UcqPgRVKjX/tsKGtP7wxDFQx5NQkl7/qui8IksMLS8kbtYjRq9Np1jHmSEWdEUuyV7aijR+O8KwRjXXxUUdpHW7nSFf2nAR8m0RQOsSkXA3S7JK/n1w63Q7KnpiGfV4+vFMrzGqzPzo4D0dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DumPu8WH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A327CC2BCB1
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 18:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772821195;
	bh=3rmHBEZQR/uYQF8Cx03Lof9XN7U5JSyV3pEdqbqOwtA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DumPu8WHSKh3Y26VzgvTDqHbRuAGsgmI5n8RBRU6PiloVgMhvP2rBhDBIBKTC0JCS
	 NW5f914DVI2znXucmXJ+MxCflID71k2ntqDiL5md+sbRJc3SpwTjnZifZ5Rj8wL/hu
	 9t5eKkGDrJskGqbv+qAQ8IydJ7EVqt7g+uQSOxvTEg71EjvRYqKvFogNsDOXsn+W42
	 TbjGiuxe3D/W9xiljxuShmgm2xUOXAAO3hScaCOKq84+Ob8MELiPn55KaLsNnVRAYm
	 IgbuoBvRjRw+vBQlOSX5tgoPnL6vOMXXxrKQl88bLnWZIYPgKDlGoB9X2UXyxOWsoX
	 6eC0jhqKYTc7w==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-415e568a7ecso1951632fac.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 10:19:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfv9zjG6nNUlLl3VbsQzgt9+y/nNJAnH6HjmlZuGsf61jav19ogi5Yj6YI3UecFj3GZj9BPXoWJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIkHSWbzcu9o+2UWASwEXTyTy+or2e+v/tPNEMAs7U755uWBV9
	h7L3j43z1WfeQElnagoeBgu6qbOVQs+H+6z+WreeJwQxCxQLVft92OoaLEHsr7Su8miEruFTwU4
	0HLjjHJbYrHvdXgu2vtdVZbT0f3Qn5nQ=
X-Received: by 2002:a05:6870:b2ed:b0:414:e37a:9b80 with SMTP id
 586e51a60fabf-416e452a598mr1918303fac.45.1772821194774; Fri, 06 Mar 2026
 10:19:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219181600.16388-1-fabio.m.de.francesco@linux.intel.com> <f9a7677b7ac4a85f77a438cd08e02c4fe7ea6ff6.camel@linux.intel.com>
In-Reply-To: <f9a7677b7ac4a85f77a438cd08e02c4fe7ea6ff6.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Mar 2026 19:19:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hUE9zacS_fCmP4qeXkT5xfh1W_T-t+bWWq8ho=PywfSQ@mail.gmail.com>
X-Gm-Features: AaiRm53ta8uJNqnFfaXHTp8XRRwOdL4ueXrLFksmLertLx2WqQgkrliCDb4mjBo
Message-ID: <CAJZ5v0hUE9zacS_fCmP4qeXkT5xfh1W_T-t+bWWq8ho=PywfSQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Allow repeated intel_pstate disable
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	Artem Bityutskiy <artem.bityutskiy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B010D2269FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43861-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.954];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 10:51=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Thu, 2026-02-19 at 19:15 +0100, Fabio M. De Francesco wrote:
> > Repeated intel_pstate disables currently return an error, adding
> > unnecessary
> > complexity to userspace scripts which must first read the current
> > state and
> > conditionally write 'off'.
> >
> > Make repeated intel_pstate disables a no-op.
> >
> > Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
> > Signed-off-by: Fabio M. De Francesco
> > <fabio.m.de.francesco@linux.intel.com>
>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>
> > ---
> >  drivers/cpufreq/intel_pstate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 1625ec2d0d06..d639cc150092 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -3470,7 +3470,7 @@ static int intel_pstate_update_status(const
> > char *buf, size_t size)
> >  {
> >       if (size =3D=3D 3 && !strncmp(buf, "off", size)) {
> >               if (!intel_pstate_driver)
> > -                     return -EINVAL;
> > +                     return 0;
> >
> >               if (hwp_active)
> >                       return -EBUSY;

Applied as 7.1 material, thanks!

