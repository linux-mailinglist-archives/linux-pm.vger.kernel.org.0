Return-Path: <linux-pm+bounces-37063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A632C1CCF1
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 19:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5CA402EF0
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 18:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092E33563E2;
	Wed, 29 Oct 2025 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmFM8ywu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B6B350299
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761763267; cv=none; b=b9Z1int+kilKb461Zuo4Mh0THEjH4eA7c3BF341XM4WD0iX8JcVOW+/z3iNyoyo7gk2+Ikr/m5sq6nuph0uW4P4IwNt+MBBdIbP/WQ0oJ5Z95mXXfjOW4h6vy1QOWoFnt5XEaxrz7kx488MZXHvjha61EB5Aovkepu2xwPqfAPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761763267; c=relaxed/simple;
	bh=GS1Zphv+EbG7XlBMw/aHGT00IIeC7ZPxd+Ab0bzQ7+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I77KCmVLYC16DiovQKAvc8f4SaD4tq8ALp9f5237XBOEnwWrD6Ys+c7rQaXQRXynZjDeWqmux2K/r9rqX6G1MQKEOoscxWdirdKGz1yA58xfeMLLMeApnWuCbFhyPPqRpueOyJKCOZ6Jsv94qyrXUwqzg69ls7vUD9O73dGSJL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmFM8ywu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54625C4CEF7
	for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 18:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761763267;
	bh=GS1Zphv+EbG7XlBMw/aHGT00IIeC7ZPxd+Ab0bzQ7+M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gmFM8ywuYVY5ZgYtZzSvmZ+feVT4U8RJMpmL6QsJvvuUno4k19FZJuf7g0016Q4cW
	 8tc4eS0Cx4B0dlvOgFRzV2u2MghTqMBhCHu0R/gr4ABTL8J1VT+dDGxMUj/3dt3G3D
	 b0puBkiMS1gGgwpyjOE3H1LD26aPjScEJ/FgiptPAkw0t4fyzjBcUJaE9Ho/e7Ir5+
	 H38vOVMQDPNR9zaZaxZLL36DtV/JC2KVLL1zLg6u9TWlBQHBww6jpBP98qEhXliFTk
	 2Fbfe1XqgBGU2ovyZ3ryeEBsIIXw8FuIydpff6umocoNzYS1hInW0Rt3ooE5kCdlSA
	 ERbar3LRQ/Kjg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3d5bb03d5c2so204163fac.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Oct 2025 11:41:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwMmooNwfC/uvttsWFrJEogGAnEtG4Roq2wA9dm9B8XraWDGnfzN/mxybe3ALugmLaWT2R/+jlag==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFN+3D+NzhBeBlRiI9Kca3WayjPvOAX2T08mD59521rnZCpzVo
	bDHdt+f7u6I5kRIQiTgLj5TYQDjEkJMm86yntweeP3h8xTNziKZ89tu2cAP9VgZl8UAdaHguKzX
	e4Ny7kBvKLA1wf2/DWjrvlch9JgQVKZo=
X-Google-Smtp-Source: AGHT+IGaNLhHznXHN73xHwv4GOy2e1s6EiMsliq2a5Bos7xqurFN2wEF1eqj3ml1pO8IiKr1S510KDF68N5o+n1ilyQ=
X-Received: by 2002:a05:6870:7023:b0:332:1b00:6d5 with SMTP id
 586e51a60fabf-3d8c9b135f9mr208705fac.39.1761763266672; Wed, 29 Oct 2025
 11:41:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017072703.2064390-1-kaushlendra.kumar@intel.com> <CAJZ5v0hK+ZaV2F8_LEjyCQyyvE-HeWX4Oyw-MVjzODQucyurkw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hK+ZaV2F8_LEjyCQyyvE-HeWX4Oyw-MVjzODQucyurkw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Oct 2025 19:40:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hpWd4Sr4-_OpNSKn5n6=pwqYDQnRX62iCeg9Td0tjeqg@mail.gmail.com>
X-Gm-Features: AWmQ_blJDDtTbcs_x0LR4ioyaZaLGoklW7VPmOSVq6a9ZtdIf5LOsPBiHzWJZzU
Message-ID: <CAJZ5v0hpWd4Sr4-_OpNSKn5n6=pwqYDQnRX62iCeg9Td0tjeqg@mail.gmail.com>
Subject: Re: [PATCH] thermal: Fix UUID string comparison in current_uuid_store()
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 5:40=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Oct 17, 2025 at 9:29=E2=80=AFAM Kaushlendra Kumar
> <kaushlendra.kumar@intel.com> wrote:
> >
> > Use strlen() for UUID matching instead of sizeof() to ensure
> > correct comparison of supported UUIDs. sizeof() returns pointer
> > size instead of actual string length, causing incomplete UUID
> > matching.
> >
> > Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> > ---
> >  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/=
drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > index 908cc1bf57f1..236003d12dc7 100644
> > --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > @@ -199,7 +199,7 @@ static ssize_t current_uuid_store(struct device *de=
v,
> >
> >         for (i =3D 0; i < INT3400_THERMAL_MAXIMUM_UUID; ++i) {
>
> Exercise for the reader: Add a printk() here to print
> sizeof(int3400_thermal_uuids[i]) and see what number gets printed.

It is 8, but note that comparing the first 7 characters is practically
sufficient to distinguish all of the UUIDs in int3400_thermal_uuids[]
from each other.

Also, this change would alter the kernel ABI, possibly confusing users
who might notice that the first 7 characters mattered and might start
to rely on that.

If you want to clean up that piece of code, please change it to pass a
symbol representing the number 7 as the last argument to strncmp(),
but that is as much as can be done here.

> >                 if (!strncmp(buf, int3400_thermal_uuids[i],
> > -                            sizeof(int3400_thermal_uuids[i]) - 1)) {
> > +                            strlen(int3400_thermal_uuids[i]))) {
> >                         /*
> >                          * If we have a list of supported UUIDs, make s=
ure
> >                          * this one is supported.
> > --

