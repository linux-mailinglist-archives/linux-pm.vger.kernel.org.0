Return-Path: <linux-pm+bounces-37964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86C5C588C2
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 17:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759C14254C4
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 15:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F523396E4;
	Thu, 13 Nov 2025 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VG0SAln8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA3D33556C
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047515; cv=none; b=BdyER7rVpDxEm7rfhusfc83dRIsX2yu9YJGnv2N1VAolunWZPOVJ885jf1/tDLSqFEn42MJBpDr3rEA7IOav4GFb8sWEfZ6BkxAeT2hBkpraJV4gLiOz0md+vvQebqPoYz4tqChpsByAoI8QqjEKqPj4CSXNR1HYTFWD5KAJcq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047515; c=relaxed/simple;
	bh=zVXuKQQY5c+w49KZil6xN/VdD3U8/LYFNkcdzi/d9Jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVePmsJPW0buCOkFYjFnqIC92O1wX8uNgyU4lHpq+tHTLkG4Fa2k/gAbNjm9gZL5KC2/jEJJeht8TifgXeeRKfsCnY+VnCgpv/ddiRyxtl1n1MPwfguRzyD138r1EJQQom23NcWwVMoPENjpyZbii+9xKq6a/S4FGJ0YkKiqSNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VG0SAln8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383DEC113D0
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 15:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763047515;
	bh=zVXuKQQY5c+w49KZil6xN/VdD3U8/LYFNkcdzi/d9Jg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VG0SAln8X5hDAzGWIpcCvMT3nHvaEUZO2q/NXQBAkFbvP6GTSy+nxanUiWeppQavo
	 b62nh0uR+J7Ke8239WlagW3h08WlmKI8ZvkmansIfD1RgaMhQI2gA9fia49pnPhr2Q
	 YuAOZXGNbigalvda3Bkv7mH6ffBD3HTYE/KBZY2rAdn4JV2AdiBPVeajoYOjUFUmVr
	 M9uo8l2eT4Wo0PATOC6nGZvuO41rzd37fLQUwNbyzp9iiQ7TUIzUchSVTSg+qXRbDG
	 b6hdk70kL3AvoR9Nm2sP2ov9fTijrDWxdaKJCGt2tOVmQGI6ufQ4YYA5sYhDNbD+Ao
	 9w5Bd2tAigYiQ==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45034dbaaabso386389b6e.3
        for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 07:25:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXsmCtdcQoFUSNAhCgA2EZ1LvM6Z14ErUUXQIXPajwWjIlteAEVkSC4VsObrsFCouuDbh9Af3b6Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+rRYopLqJ4P9HE/NAyANJoRRpUoszw1nHZRjEsKS2HHU0A84j
	RAfLTNsrfhRbHPg4JVToR3woPjeYm0z9MAcmzUaHOsuaDFrFMewwSS3ccIpX5nc6MqFm+rqC9bf
	7lU75hZ/qrpPD9cBnrsae0ZusiXm7nIo=
X-Google-Smtp-Source: AGHT+IFfmmIT1O0Jd8y77kmYZ06G5uXm163vmKDKtM5n96Ro7peJ5hDMSwqL4MNbQKH56lk/SqOCUOy9kBnuSlJqUnA=
X-Received: by 2002:a05:6808:318a:b0:44d:be6b:33c1 with SMTP id
 5614622812f47-450745d93c4mr3472624b6e.65.1763047514456; Thu, 13 Nov 2025
 07:25:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4701737.LvFx2qVVIh@rafael.j.wysocki> <69115878-ec5e-4f7c-bb3e-9f61cce75c70@arm.com>
In-Reply-To: <69115878-ec5e-4f7c-bb3e-9f61cce75c70@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Nov 2025 16:25:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gWrkT9-wucHBGLLN1AVOazBLEv0Xn_ebpO1dt=Xp3XeQ@mail.gmail.com>
X-Gm-Features: AWmQ_bl0a74gTL4igagURGNIBDyo6DjQ8P3FklGJBAiHMwLu5o5AlK695HdZILU
Message-ID: <CAJZ5v0gWrkT9-wucHBGLLN1AVOazBLEv0Xn_ebpO1dt=Xp3XeQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] cpuidle: governors: teo: Assorted improvements
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Reka Norman <rekanorman@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 4:21=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/12/25 16:21, Rafael J. Wysocki wrote:
> > Hi,
> >
> > This is a bunch of teo cpuidle governor improvements, some of which are=
 related
> > to a bug report discussed recently:
> >
> > https://lore.kernel.org/linux-pm/CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQs=
U_qdcCx1m4w5g@mail.gmail.com/
> >
> > The first patch fixes a bug that may cause an overly deep idle state
> > to be selected when the scheduler tick has been already stopped.
> >
> > Patch [2/4] removes an unnecessary function argument.
> >
> > Patch [3/4] makes teo_update() to use s64 as the data type for its loca=
l
> > variables more consistently.
> >
> > The last patch reworks the governor's decay implementation to also deca=
y
> > metric values lower than 8.
> >
>
> Tested-by: Christian Loehle <christian.loehle@arm.com>

Thank you!

> Test results below, although there really isn't anything interesting in t=
here.
> teo-1 to teo-4 (patches 1 to 4 respectively are essentially indistinguish=
able from
> teo-m =3D mainline)

Good, that's how it should be.

