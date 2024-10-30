Return-Path: <linux-pm+bounces-16716-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 558379B6160
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 12:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8774B1C21B67
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 11:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8121E47B4;
	Wed, 30 Oct 2024 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGbeZX9E"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E824D8A7;
	Wed, 30 Oct 2024 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287399; cv=none; b=p3XUGrMcbgfbEsP3a5gOUoKBVd3JWIWvjGUflPyJ8paKkr18GpO7y7btLHCiHP+2jYSzTDwROc+HIhmAG4bQrErP93Cm2pc5MrZh5KTc8nNUJUJrZCeucEYr4pu9jNIDhrKv6gENp2kfsxHdtCqNeU9EQAdCgm9ZdmtfvvNpS1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287399; c=relaxed/simple;
	bh=ZELZTzUNqo0r6dZrQS3xkAeDQuEaYVCCa8D/LddOGWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEgcNZoPVF6DDfhlJ+UzHA+4tTpadt+vFJu/MDlGRXYjYkMkKIdNTp3qfEyyFNdYxC3ih7k0Lp0Te/VM3v9YH6xhzw0k1wRRKWQo2d9auyFf+E82uwNiPeKbxWtnQJCHfDBY2V8FPuwpps5cMFdgO2jYEmSZ3ERmDxMIt/ecvzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGbeZX9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBCBC4CEE7;
	Wed, 30 Oct 2024 11:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730287399;
	bh=ZELZTzUNqo0r6dZrQS3xkAeDQuEaYVCCa8D/LddOGWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cGbeZX9EN1J3qsM4AAtPIN9HLwtII22J+bicmUkKdNoCqTC7kBczPwtQS23D5Tklx
	 +JBxetXSg9mTVcrMkfwcAwEXgG8jhASBcSpyHSYUq3J+4IZX0RRN7kBjB03n7Y4doq
	 bpZYBt9+B5pb2RgJMJ9qIGU0GKmCGD3jlB16qUdEyV3PsXMR4ZZXqZ97X9iMykDcAj
	 Z0CIGRoKULl4b+m6qkWm0cWNnXv9zXcsmTBPkYK4ekDuLoyX5XRJpiebDaji3QVc0n
	 BjphU5nRf5D3rrP0Gjz+gCeEdxCvhLcg1w6aAV6IHif1r3CVo5HGetry6kYGjIoJV6
	 EEGFyn0JgnOLg==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-27beb2496f4so2306462fac.1;
        Wed, 30 Oct 2024 04:23:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3pInNz7AR+lTRKJPXzKCQTjk01IPuiQzs3Hbyv12YsuHgKW2k5k5TW2kmhs9asVbOZVSGM0NSPt0TPg0=@vger.kernel.org, AJvYcCWgDsA5RO4lLVz3We/ne/ij1CITLm6bBikz51K/T2L13pSZnpIYTzJQdZj8NS9o0ZYTReoRSeJcmA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmyNzMmDJpVnKYo4iG4gewoQLBHyIaOQVTZrwGGf4WAau6muny
	M+KYxxCNwdQVkID35BzNHFCTPoCfHTZnlFb56C5pzXC4NvgLiN6qeTc9i8rzjHRELBjW28fBajF
	5ZOiO2CMr6/NZqymxueWNBUiM4UA=
X-Google-Smtp-Source: AGHT+IHCcWzbBvzQZ78Xsrj4J41Cv8KkkFQU9rrK6ytLjSa1GuXNRtwhVDyN2RGzYyIdPv0n4BIGocz5VnkSr6tUzvI=
X-Received: by 2002:a05:6870:469e:b0:277:ca2f:905 with SMTP id
 586e51a60fabf-29051d432c4mr12996048fac.29.1730287398214; Wed, 30 Oct 2024
 04:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029094452.495439-1-lukasz.luba@arm.com> <20241029094452.495439-2-lukasz.luba@arm.com>
 <CAJZ5v0gzQhw3wkRVFTEx-y4pawknJqC2JPrN6_dqd77vTVuSOw@mail.gmail.com>
 <6cdb2f8b-62e0-455c-a3a5-ed5359a2e941@arm.com> <61afac10-b434-4e39-8c49-c220add4bd8e@arm.com>
In-Reply-To: <61afac10-b434-4e39-8c49-c220add4bd8e@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 Oct 2024 12:23:05 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jk+0vfn88+gaunezgtb6TLVagqav=9sM-D169Q69MF5w@mail.gmail.com>
Message-ID: <CAJZ5v0jk+0vfn88+gaunezgtb6TLVagqav=9sM-D169Q69MF5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PM: EM: Add min/max available performance state limits
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 11:00=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
> On 10/30/24 08:48, Lukasz Luba wrote:
> > Hi Rafael,
> >
> > On 10/29/24 18:29, Rafael J. Wysocki wrote:
> >> On Tue, Oct 29, 2024 at 10:43=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.=
com> wrote:
> >>>
>
> [snip]
>
> >>> +EXPORT_SYMBOL_GPL(em_update_performance_limits);
> >>
> >> It would be good to have at least one caller of this function in the
> >> tree.
> >
> > Yes, I know, but we had delays with the SCMI cpufreq to get the
> > notifications support, which are sent from FW...
> >
> > The patch using this API was part of v1 but with assumption that
> > those SCMI notifications are merged.
> >
> > The patch v1 for the SCMI cpufreq driver [1].
> >
> > In that v1 cover letter I mentioned that the 2nd patch depends
> > on notifications [2].
> >
> > I will have to work with Cristian on that notification in SCMI
> > then this API will be used. I can see that it stuck for a while
> > in v5. Let me sort that out (probably not in this merge window
> > though).
>
> Just to link the effort which has been started into that direction:
>
> https://lore.kernel.org/lkml/ab36709d-a181-4621-a8e5-0ef38b80186b@arm.com=
/

OK, then this can be queued up as a prerequisite for the upcoming changes.

I would, however, mention that in the patch changelog and add a Link:
tag pointing to the above.

> > [1]
> > https://lore.kernel.org/lkml/20240403162315.1458337-3-lukasz.luba@arm.c=
om/
> > [2]
> > https://lore.kernel.org/lkml/20240403162315.1458337-1-lukasz.luba@arm.c=
om/
> > [3]
> > https://lore.kernel.org/lkml/20240603192654.2167620-1-quic_sibis@quicin=
c.com/
> >

