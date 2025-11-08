Return-Path: <linux-pm+bounces-37665-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF26C42BB6
	for <lists+linux-pm@lfdr.de>; Sat, 08 Nov 2025 12:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97003A5D1A
	for <lists+linux-pm@lfdr.de>; Sat,  8 Nov 2025 11:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCD02FFFB6;
	Sat,  8 Nov 2025 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0hdVKEi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61542FCC16
	for <linux-pm@vger.kernel.org>; Sat,  8 Nov 2025 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762600212; cv=none; b=KKAaHwPKZqwJLgfF+n/lYz2PO01uvY2uJj6g0i/4HHoCKzWO5obuyQi1dkq5fzZtzAlocPD8Ed9SztRb4cF3I2qUiF/4RJy+o66YdoekmCrLUVUqAstzaJcUqJ177OGV4wqFp/xglcA2TUpTUWdlB83JSP8pLl1d37zvn13u/aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762600212; c=relaxed/simple;
	bh=ENiGirSxflVnMHnkvoNDtVq+HOZoXzMiQusmB4+cygE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwTv/HymkcBgXA0K+AdEu9E/W+AdBd4cN8Py9TZisZEXuGNkbq2H+ASTOOTVrsN+z41ckJoQVhNcEdLr+RDTjkAZNsQy+w/ITDYJoXxK8vzVH+PyiNIxSadLv+09ZAh+V28gr0WA7fICtpPPBI7VaxjrpMZZMECuJPxSPlP9kvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0hdVKEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C18C19423
	for <linux-pm@vger.kernel.org>; Sat,  8 Nov 2025 11:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762600212;
	bh=ENiGirSxflVnMHnkvoNDtVq+HOZoXzMiQusmB4+cygE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J0hdVKEiabYioBF3YgQdYOtVs+e+Ve0/N4/afwC/ASyWqdNyQNCDvXsGUP5HyCVdU
	 WCAEyhXZnUzrQ3rNHh8zE8N1mEzl164HlE2unJ2u78so77dGzzAep7zgGrotriwayo
	 cXGE58tYCdC7X1Q+dDkOa5gQW+oF3nj4rANF+RGofYe8XTclsXwK0Q156c2Lk0HWrj
	 hJDOngsozMIvfjsyhHVUq8r7XG7CdRjQKw4yYHkW5A+nxToqUVW3pTZxwm8Ms6edkv
	 wouwICNWqkAOVPkCoCkktyxUv7A94AaNnSo4Z5NCH1al/ChDF8PNpYWyLq6fSdzJqc
	 Gwx3gL2MeQOKg==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-45015646170so730476b6e.0
        for <linux-pm@vger.kernel.org>; Sat, 08 Nov 2025 03:10:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWopLxjk65VnQLJg6n/C5o7Yaqgc+ihGdDfbgJOw56EiEcTCt87OvMgBMGB9CQpOLEBx250ViUSuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEx7a5jamkyG0olPn/Qb5P6xoSbKBpNdD+SxLlIS7dMykBgaN8
	pX4SXRX5fbdF331BWgLAnfKNnjM+7E4Vb/sJyD2XQ8a7of9YC9CuzeGE2G0OQskillC5dNZ6lny
	gtCC+ycVwDbzMNtUHRddLU2koRjq13OM=
X-Google-Smtp-Source: AGHT+IGOT5JCMz6gstNi8J2x/CW3Yxe0kzm/XVsduIuA88CCMdmj7eokzY9hzdmIAa908lzaH48eKEP1wVAkg22Ykjk=
X-Received: by 2002:a05:6808:d49:b0:43f:9c34:fba2 with SMTP id
 5614622812f47-4502a1b130emr1154566b6e.12.1762600211559; Sat, 08 Nov 2025
 03:10:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027044127.2456365-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0iAHMUQ99Mc_cBDHPHcjG5p+o67SDmvwd_eAkDxR5zZmA@mail.gmail.com> <LV3PR11MB87686D8E65B5895D66FD1EB5F5C0A@LV3PR11MB8768.namprd11.prod.outlook.com>
In-Reply-To: <LV3PR11MB87686D8E65B5895D66FD1EB5F5C0A@LV3PR11MB8768.namprd11.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 8 Nov 2025 12:09:59 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0grp2vD4qrkNBtiwgjf6iOcqbyvLouFNHJUHQfdWsay0g@mail.gmail.com>
X-Gm-Features: AWmQ_bnrd0Z0A4X3_BFCABOlHGtUkGVdPotcFPAiTpx4Cpbhaaf_OkBRcYVcdME
Message-ID: <CAJZ5v0grp2vD4qrkNBtiwgjf6iOcqbyvLouFNHJUHQfdWsay0g@mail.gmail.com>
Subject: Re: [PATCH v3] PM: Delete timer before removing wakeup source from list
To: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "pavel@kernel.org" <pavel@kernel.org>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "dakr@kernel.org" <dakr@kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 8:17=E2=80=AFAM Kumar, Kaushlendra
<kaushlendra.kumar@intel.com> wrote:
>
> On [Date], [Reviewer Name] wrote:
> > So you need to delete the WARN_ONCE() from wakeup_source_activate() alo=
ng
> > with wakeup_source_not_registered() because now it may trigger before
> > removing the wakeup source from the list.
> >
> > Frankly, I'm not sure you know what you are doing here and I'm not goin=
g
> > to consider any new versions of this patch until I'm convinced that thi=
s
> > is the case.
>
> Thank you for the feedback.
> When timer_shutdown_sync() is called, it internally sets ws->timer.functi=
on to NULL within the __try_to_del_timer_sync() function. Since timer_shutd=
own_sync() already handles clearing the function pointer, the explicit ws->=
timer.function =3D NULL assignment that follows becomes redundant and can b=
e safely removed.
>
> Are you suggesting here a simpler approach: just replace timer_delete_syn=
c(&ws->timer) with timer_shutdown_sync(&ws->timer) and remove the ws->timer=
.function =3D NULL line, without changing the ordering of operations?

I thought about doing that, but on second thought the $subject patch
may be a good change after all because people are generally expected
to stop using the given wakeup source before calling
wakeup_source_unregister() on it.

So I'm going to apply it, but I will send a follow-up patch to make
some more changes on top of it.

Thanks!

