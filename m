Return-Path: <linux-pm+bounces-22414-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EADBA3BD76
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 12:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D011893B08
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 11:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE041DE2CE;
	Wed, 19 Feb 2025 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p2EgY6RE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465BE286291
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965917; cv=none; b=lgXcjhyt0KnJMHV32B567zRiKv6vHEQL1c8Bu1YsLaPa5LdkgzNg8HfoHk3TIOYtW30Mm+D0TlUTTVd9AudreOyVUoUCt/GfeLoely9gLzsnWlWp1wCzC/+iVe5f4jApatcRHtXxPvzPmzUxUjL5FqJ82xViCabqgSuuVcu+WHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965917; c=relaxed/simple;
	bh=KPkXD/7cqbXf7VsD8IoPhTC6NEsbU4JuJNGhIxAsmAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4LTuyUIW7itKJMo8bHRPe9ZsLodVQvDk0zulaVv92bfGSFkVW89kAqczTzCxTBwMpn6RXO41WgaHlW0ZSQMOoVQLjIE53/1aX69h5sku8RSnDpK5a2pDa27ieRAr0KoX/hkdmmyXaIIjOtHp2aopkI9kjnidBhiAIbsvy+TfXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p2EgY6RE; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e46ebe19489so4368880276.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 03:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739965913; x=1740570713; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R46i4neiPPtDwdv3LQifChV+vLwO3rJdmLscnT0rln8=;
        b=p2EgY6REI6VmljfmMfna+LiilLPp+5y+G+i4bhcr10rosMCusCiN1WUpMD/Mpfe/I/
         spaK9FlPlfUaxXT+G+PMSHJ848Iy6kh4/ZMaEAwXfNJyLO+6UXlil46CnHBtdziwpUWh
         LU7V4fbWYeBUwgDWcHY22c9mCDzfdewxB0/NiwEjJ4P1L5hxG3tA2uTIOmRMrsl0yp4W
         JzpRtbW28g7Vktmbx9GQyQFpbOfkZJI+0t44xXZK3PBbBrN21dziRDroCsVPXlt34mOJ
         JO1pbNYZAtpWSTAkoCAiUMZ0u3DSNFgKFezvaCcWKcwt7Q79e4WnE43pOk7XvN9AKIUU
         itWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739965913; x=1740570713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R46i4neiPPtDwdv3LQifChV+vLwO3rJdmLscnT0rln8=;
        b=XqMTrlJ+UpDVyRCcXVwi/EQQSUUd6IwRRYLdg9uJ3CVWT94sYTecO5BEBA5DCeMCNi
         BZHpG2OmVBC5X++IegYwXqodqv1mAbayCEnIzbK7afSWmTzJ3ayWOpZn7CHK9yCeGQ6P
         MdqRF8o/d4m9OlvKVrO4D73QCQdOTDYqtQhicbPScpKzc9TmS3y5pQaG2qaoawnfSPsF
         qTrmR/iZ1YxZUOyWVtSzO0Od0ju5zW5ovu1egzGbModbvc8sVImsASMTPZDl9mc8m5ZO
         drWxT1qQ05wq535jIW+3l8HmEJu3++ff08WI8EdPQ0wY3Dm5ZZcvIdIqd4RX6FOgMinG
         CU3A==
X-Forwarded-Encrypted: i=1; AJvYcCWdKZ3Eua2q+gZ1Pfh+4d8FoVVFfeILPaPErG4m6VaIhHFpUFU+b3LQODgrQOlnovN6g3MgeogFIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZHEVEO7b9ytVOMPEjjWCcEKkJebOwuzF1mr2Qzvh0cDS2mQBG
	swAn+kYDFWvYionsOrkxoi8PNtqLqgTRZv6Qkq6SpCPzgb3O6cf7n8eDkySNPvZKe0TeF372VDb
	IOhr/Q1mjJDmmeRAsPYFDARJ3o5Wbo9Zgnmgixg==
X-Gm-Gg: ASbGncsusGW+5tGXkc0nXk5oSjiybX8jiUQ1Jtl18WQJFAYCZeOs9EraLvCbPS0nYgJ
	2UAbV7r0NgwxVwZppXO+GuLOGymIvWgWicc+moArliiU1+cjNlnQvT/5B2xlhw7gM7EK/nIQCzg
	==
X-Google-Smtp-Source: AGHT+IF336n6iz9MKaV4OlZuLX65CGYiKzqQpe2IHd1yE/zIFjichwdqnXiqfBQCF3WNembgFV6LWh1J7NEVULKdLeg=
X-Received: by 2002:a05:6902:161c:b0:e5d:b9a0:a14a with SMTP id
 3f1490d57ef6-e5e0a0c07famr2649054276.24.1739965913150; Wed, 19 Feb 2025
 03:51:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1739926689-151827-1-git-send-email-shawn.lin@rock-chips.com> <a0b41ce7-4ab8-4baa-adee-8b5717326729@arm.com>
In-Reply-To: <a0b41ce7-4ab8-4baa-adee-8b5717326729@arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 19 Feb 2025 12:51:15 +0100
X-Gm-Features: AWEUYZkoxtEGbbZwqqZGnxCLVjqAx-yQQXpJMgP8dLv4LTOLDOVvgXG75zeBKTo
Message-ID: <CAPDyKFr6CLzXjXW3SiiE0y4kf6nDgfLppexFtAZds=jOyqtWHg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: rockchip: Check if smcc could be handled by TA
To: Shawn Lin <shawn.lin@rock-chips.com>, Steven Price <steven.price@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, 
	Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"

+ Sudeep

On Wed, 19 Feb 2025 at 10:34, Steven Price <steven.price@arm.com> wrote:
>
> On 19/02/2025 00:58, Shawn Lin wrote:
> > Non-existent trusted-firmware could lead smcc calls into some
> > unset location which breaks the system.
> >
> > Reported-by: Steven Price <steven.price@arm.com>
> > Cc: Steven Price <steven.price@arm.com>
> > Suggested-by: Heiko Stuebner <heiko@sntech.de>
> > Fixes: 58ebba35ddab ("pmdomain: rockchip: Add smc call to inform firmware")
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> Tested-by: Steven Price <steven.price@arm.com>
>
> Although one note below...
>
> > ---
> > Hi Ulf, this's a follow-up patch fixing the issue Steven saw.
> >
> >  drivers/pmdomain/rockchip/pm-domains.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> > index 49842f1..27a5c68 100644
> > --- a/drivers/pmdomain/rockchip/pm-domains.c
> > +++ b/drivers/pmdomain/rockchip/pm-domains.c
> > @@ -572,9 +572,10 @@ static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
> >       }
> >
> >       /* Inform firmware to keep this pd on or off */
> > -     arm_smccc_smc(ROCKCHIP_SIP_SUSPEND_MODE, ROCKCHIP_SLEEP_PD_CONFIG,
> > -                     pmu->info->pwr_offset + pd_pwr_offset,
> > -                     pd->info->pwr_mask, on, 0, 0, 0, &res);
> > +     if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_NONE)
> > +             arm_smccc_smc(ROCKCHIP_SIP_SUSPEND_MODE, ROCKCHIP_SLEEP_PD_CONFIG,
> > +                             pmu->info->pwr_offset + pd_pwr_offset,
> > +                             pd->info->pwr_mask, on, 0, 0, 0, &res);
>
> Note that if the conduit is SMCCC_CONDUIT_HVC then this will still
> attempt an SMC. I'm not sure if this situation can happen in practice.
>
> There is a (horrifyingly complex) macro arm_smccc_1_1_invoke() which
> will automatically use the correct conduit, and even copes with the
> SMCCC_CONDUIT_NONE case (by simply failing the call).
>
> Steve

Thanks for letting us know!

Note that, arm_smccc_1_1_invoke() is also a bit problematic, as it
doesn't compile with Clang-20 and Thumb2 mode. See commit
885f5669f2ab.

[...]

As the current approach seems fine too, I decided to pick up the
$patch as is and by updating the commit message, according to Sudeep's
comment.

Kind regards
Uffe

