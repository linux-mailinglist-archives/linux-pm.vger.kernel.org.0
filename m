Return-Path: <linux-pm+bounces-22684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7373A3FD42
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 18:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13D83A4234
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 17:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE5824E4C4;
	Fri, 21 Feb 2025 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueXyEGTF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B8124E4BC;
	Fri, 21 Feb 2025 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158112; cv=none; b=Dk6jwP2TvfsTz64IGNu9+Jjd3v1juXgxCOh/TPXP462SCNfpEGuFlQJhDvj30qvVPs4tmiLmtQ5JsrDpOzxwWn3NX+zSoSFPNTBxba/fvh+Tn4ojqB4z5UlzURgMiIqtQtriW6PuYxCGuvCNy2m2AsqX24TbtwWVU1PKw09JDA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158112; c=relaxed/simple;
	bh=4PQM9t+0YypwAcqSCo3bdqve07Aqqp7/EUz1SJsYKJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+KsjowczDjyRlDu9swUiIXUdb7vrU9EWAlmoQiD9AG61rdjREoUxiehysjDqDeXXl+Wdz2fwTw56QvjWS/il4J6fshYzGvKuamJU2rtCsel/qGlvNJVAUecw5hH1L+QbebmOcKGN+KR985PGf7+QAwlUFs4C6GcFaAHQ+jkfPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueXyEGTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E1BC4AF0B;
	Fri, 21 Feb 2025 17:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740158112;
	bh=4PQM9t+0YypwAcqSCo3bdqve07Aqqp7/EUz1SJsYKJQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ueXyEGTFXJf6Qe8P+veQ6vHS/eaKbtZf0I3e067X0JqGy7GE5jetfTeQaUZdza1jU
	 /6fgdJup1dyyf8Ppr/NAcnwttP6kShVkGOQ8jbocfTKC2FHngCgcXplnY1On7ICdkH
	 mtdPZs9izLh3wYCVsEJ+bf+SHypeepJU8nb3xv3HAbsgs7Yr3iXE6F8SmUnlQeJD75
	 s+JcsSGC5wGz4WPIs7AVoKu4AAS9i+CeGdbPUaIbUMRRKn4gottLF4wMSSRAlS2Y7f
	 UFZvPicpJxdS8b6aUVK7qEeYDI6MWLOPwoRiaAmSOAf8SjgaeXQN58RgMtUGdxARFK
	 Yp1sT2Kfb8hJw==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5fa2a2bdde9so537527eaf.0;
        Fri, 21 Feb 2025 09:15:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWK6il9WWJKFHzJthAVwv3LSbJTDdxacTGi8nzdxT8xCGkkJo+/Gqgo/HrEsKWLu7VEkvT3n/nL3OI=@vger.kernel.org, AJvYcCXOIPnEhCWY2xEis4OJuisnahjeyqMRUTmudwbmalTi+YM8I8ASyzoXjlrfF2ImA9xxDBWxKMH4QA9EJ+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8W/j52a5lrsLKOc1PEOdVMQ4ZrMguVe6KlYE9Vu9yvop3Jq2T
	nI1SAiC+Wx4PpdNVdhrmNZhMNcMbNqT62R/NxjVzGqpave5VWbjQ0oCuHjof0XecoaiMiMDJxev
	0zl+y4HMEqJV5KA6fDSIoj8+Jfa4=
X-Google-Smtp-Source: AGHT+IG3vb+A1RQVBjNrvElN5nnYtOkQLsrAQv8SzBQBKtHK69lUl94qC+NHeiWRzKUbcDRT7MSBFVZq9rHbWacgyVM=
X-Received: by 2002:a05:6820:2294:b0:5fd:1401:7d32 with SMTP id
 006d021491bc7-5fd196d51a7mr2507238eaf.8.1740158111533; Fri, 21 Feb 2025
 09:15:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219-fix-power-allocator-calc-v1-1-48b860291919@chromium.org>
 <CAJZ5v0jSh=aOfP7BKTCSxnPGy-XKJKcHNw8bN5PXPH0LA0tAGg@mail.gmail.com> <9cc02f9e-9326-4fe1-820b-ca725f68de29@arm.com>
In-Reply-To: <9cc02f9e-9326-4fe1-820b-ca725f68de29@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Feb 2025 18:15:00 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ikFjYsCfzYX6utX4=sraaBYH==Vdwz7ZPU9gHX=JaGgA@mail.gmail.com>
X-Gm-Features: AWEUYZkoALubl7OlpmGrglJbQex3eiGNNvzoU73hGQz-POgzrpoEPEbN0f5X-Us
Message-ID: <CAJZ5v0ikFjYsCfzYX6utX4=sraaBYH==Vdwz7ZPU9gHX=JaGgA@mail.gmail.com>
Subject: Re: [PATCH] thermal: gov_power_allocator: Fix incorrect calculation
 in divvy_up_power
To: Lukasz Luba <lukasz.luba@arm.com>, Yu-Che Cheng <giver@chromium.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 11:35=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
>
>
> On 2/20/25 19:45, Rafael J. Wysocki wrote:
> > On Wed, Feb 19, 2025 at 8:07=E2=80=AFAM Yu-Che Cheng <giver@chromium.or=
g> wrote:
> >>
> >> divvy_up_power should use weighted_req_power instead of req_power to
> >> calculate the granted_power. Otherwise, the granted_power may be
> >> unexpected as the denominator total_req_power is weighted sum.
> >
> > Yes, this is what's happening, to my eyes.
> >
> >> This is a mistake during the previous refactor.
> >>
> >> Replace the req_power with weighted_req_power in divvy_up_power
> >> calculation.
> >>
> >> Fixes: 912e97c67cc3 ("thermal: gov_power_allocator: Move memory alloca=
tion out of throttle()")
> >> Signed-off-by: Yu-Che Cheng <giver@chromium.org>
> >> ---
> >>   drivers/thermal/gov_power_allocator.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/g=
ov_power_allocator.c
> >> index 3b644de3292e..3b626db55b2b 100644
> >> --- a/drivers/thermal/gov_power_allocator.c
> >> +++ b/drivers/thermal/gov_power_allocator.c
> >> @@ -370,7 +370,7 @@ static void divvy_up_power(struct power_actor *pow=
er, int num_actors,
> >>
> >>          for (i =3D 0; i < num_actors; i++) {
> >>                  struct power_actor *pa =3D &power[i];
> >> -               u64 req_range =3D (u64)pa->req_power * power_range;
> >> +               u64 req_range =3D (u64)pa->weighted_req_power * power_=
range;
> >>
> >>                  pa->granted_power =3D DIV_ROUND_CLOSEST_ULL(req_range=
,
> >>                                                            total_req_p=
ower);
> >>
> >> ---
> >
> > And the fix looks good to me.
> >
> > Lukasz, any concerns?
>
> Good catch! It went through since the test didn't set different weights.
>
> Thanks for the fix!
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Applied as 6.14-rc material, thanks!

