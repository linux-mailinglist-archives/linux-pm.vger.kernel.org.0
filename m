Return-Path: <linux-pm+bounces-16384-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5250F9AE5E7
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 15:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4841B26B93
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 13:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C271DDA0C;
	Thu, 24 Oct 2024 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpT8pek0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0D91DD88B;
	Thu, 24 Oct 2024 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775909; cv=none; b=UUHxrTAmOfqkrYf28+QeJKXU3pgKyktZ6dgcwIJj4oclZ68MylyynPO0V1Jvs6Legx3RkoA5Vwl7/wHEUgPyD5J2sy95A/KoitDcSEs2UpbQOoh5o34rEqCsFds7V8l6AvwJOz5srVHX81rvReFrSS4HDFljtgwojS+UdxTsePg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775909; c=relaxed/simple;
	bh=fUPMtLGUu5qsQ9CvPJPbRbDf4Ywd2f07fy+PXcaOFUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1mqK6qGRdPdiLm7frwgUmkz6oeIndxX4Fz6LdZ8Du6kv3pLGMi9n3Mo/1UpP5xBPa2j7qxbb2BH1jq53SjsbpmsbluklFjoU+hvkQsPJmUcEhIPYFwK0k/Mv495kxYGKCpEQdh9xsC3CKmDtmwWzIWdti/wVjGVTqJqwpCT0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpT8pek0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D40C4CEE8;
	Thu, 24 Oct 2024 13:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729775908;
	bh=fUPMtLGUu5qsQ9CvPJPbRbDf4Ywd2f07fy+PXcaOFUk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rpT8pek0qutK7KGKpdZ49JQUG2hi4UD5nDgICPm/dmLTHOG+cL8FJL+P4Xfv32fGh
	 XbRZacCxhHu6q19EhTSlM7JHYBYRmHA2hjZuGllaHqZKrdoO/tAVIHwe6AnAXxaUP+
	 YD2CV9Jf1pAtQwYt3lOjNi+EQQCSTcHGu/cqz1my9G89LJyhPrWVfJcJDs/iDVIOgi
	 A2U/hmjXzqpkL8tofc8DGOs5/sQUhVLYDzBiASvYsF7kDLXYk+m0jf1qLiNajfK0tY
	 ZLKOaTysRIQ4ZPwqgkLZB+CXkW4bVYzqgASHmHzJ6+ZIQQI3oUSl5NU+W5VMlTcV5k
	 nw57M8vJtfIQw==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e5ffea2699so917048b6e.1;
        Thu, 24 Oct 2024 06:18:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxnGdRmsU9f/dBI0+Yn5zLnRLu8OX31UI4sPXqFRE+hwk7hNYn1FFGoSXIgsbSd+m4QOZaRTS37aRn6X8=@vger.kernel.org, AJvYcCVGaI9bW665gMCEg0Mx2cdyskyYKQMGoIErbdVuvIqurV/uM/BJIorz0KFIrmyLFo8zSxwUxLtXxbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL4h38CvcLa7iAb5O75BuidJ2IgSCOP9OyhSs6RYvSE8ognBt1
	27NBkigwuTnCTyJ+vCu4ogAhekixJvk7QpNn3FZB96pyT9WIU5sNQ/o+BrUjbvZUjzkxtg+4sfw
	MmnVve8e+T/X28NQo6WImz3AheQ0=
X-Google-Smtp-Source: AGHT+IGLRzCtSDhNTOWOusH4AqBYnt+g8QFbKTd3yubHvDvJVyXXGjbi9ShRWEWpLZclfZ3Cem/g7ViDIYj0SqVOi1Y=
X-Received: by 2002:a05:6808:d52:b0:3e6:1f35:62c9 with SMTP id
 5614622812f47-3e62c48defcmr1120934b6e.0.1729775908144; Thu, 24 Oct 2024
 06:18:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024105938.1095358-1-daniel.lezcano@linaro.org>
 <45265aca-7371-455f-819f-c4d68cbb089b@web.de> <9ba3fa17-57c3-41e9-9e19-33fa105a179e@linaro.org>
In-Reply-To: <9ba3fa17-57c3-41e9-9e19-33fa105a179e@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Oct 2024 15:18:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jWGdzakj8ob2otAO6auwGBvVsewujG-d9b1Z5nnO7Vkw@mail.gmail.com>
Message-ID: <CAJZ5v0jWGdzakj8ob2otAO6auwGBvVsewujG-d9b1Z5nnO7Vkw@mail.gmail.com>
Subject: Re: [PATCH] thermal/lib: Fix memory leak on error in thermal_genl_auto()
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-pm@vger.kernel.org, 
	Lukasz Luba <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 2:57=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 24/10/2024 14:02, Markus Elfring wrote:
> >> The function thermal_genl_auto() does not free the allocated message
> >> in the error path. Fix that by putting a out label and jump to it
> >> which will free the message instead of directly returning an error.
> >
> > Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=
=9CCc=E2=80=9D) accordingly?
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.12-rc4#n145
> >
> >
> > =E2=80=A6
> >> +++ b/tools/lib/thermal/commands.c
> >> @@ -375,27 +375,30 @@ static thermal_error_t thermal_genl_auto(struct =
thermal_handler *th, cmd_cb_t cm
> >>                                       struct cmd_param *param,
> >>                                       int cmd, int flags, void *arg)
> >>   {
> >> +    thermal_error_t ret =3D THERMAL_ERROR;
> >>      struct nl_msg *msg;
> >>      void *hdr;
> >>
> >>      msg =3D nlmsg_alloc();
> >>      if (!msg)
> >> -            return THERMAL_ERROR;
> >> +            goto out;
> > =E2=80=A6
> >
> > Is it really reasonable to pass a null pointer (from a failed function =
call)
> > to a subsequent nlmsg_free() call?
>
> You are right, I should return here :S

Do you want to respin it?

Alternatively, I can fix it up when applying the patch.

