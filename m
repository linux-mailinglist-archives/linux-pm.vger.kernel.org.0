Return-Path: <linux-pm+bounces-12959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9347A96090E
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 13:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8A9285123
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 11:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607C51A0729;
	Tue, 27 Aug 2024 11:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKhx1CcT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330FC17C69;
	Tue, 27 Aug 2024 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758789; cv=none; b=btjaatJy/1fLW7YYS97tCEFYaUDDEE+Y2rKSveRvAImj048Ff040dMFFDVgaXalrXKqVwsZ+OhikLoQvbzIslaHX12wdrpo0zkIFflVDOcAfGcFhNfxOW9KFm0YWAlHi1PJYnjRQ0hozDt3YZE4muoGS7zVkkjR55ltbZ/ER/EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758789; c=relaxed/simple;
	bh=5aiCA1KifFkP5iaGWPQMv96TRmb7TG8TWiOnSHnr4Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A57ecCJOIR7HmpL0C/Mznp9JQ71V0Ssm7VCXYIlylIdR//3+Sv4ZWXRhWUnBA/uVEgg5bY6sDkEkPHFVka19gOkUIxmpLIW9GFTZ2zk2/X3nZr1fHdeHGCofBtL/EMjhjqfwr871ilAs6BPZfq1etl8htTXGiy2kLy58k+mF8uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKhx1CcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F47C4CB0E;
	Tue, 27 Aug 2024 11:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724758788;
	bh=5aiCA1KifFkP5iaGWPQMv96TRmb7TG8TWiOnSHnr4Kw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YKhx1CcTr13AVlW0lGluSP/OG0ne45wnDwcoKh8pDLTC0OIk+BAsyIUXH9ItJe4t8
	 t1ZpjPPAeOA+ppxDYHyXDRye0UcGIc3txxzQvZCV5tSKUJZUzNpr2i/BD0MRz19pMR
	 TV5SBzTc6CmNVfWHfwkDtO7AzFh0S4McBfL/bW6qA/ERj24Tqwt+CpGLj8EATxTibM
	 dKLGdtQLm/kM/utcSOUjycu1NYjbmzCRJkeGMtzz8PEDTiBOwaAO8dVOhScTd7gUlz
	 9YZtq+saUkSTu/cGyYUKAuqA9RyFRFEr80QDkJNCHo5Ez7vsq/9b1A/C3LUWfTEFVi
	 KFEEzgc10Ct5A==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-27045e54272so3511423fac.0;
        Tue, 27 Aug 2024 04:39:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEbRHJilkQcYWG4siwt/uVIoJc8zP7Ib/u6Tku6zGZtiRTCb5vnYNZ7hubVXt3k/2xu9fK1BpzxqIF+98=@vger.kernel.org, AJvYcCUU+lWfBrvS2boZQgYeKVja8nGvUYnsIMxoXMs/op0VHc66KT+g7Blp1vCh1YTZ9S07Gm61pBJmUpO/8bGI534vBWI=@vger.kernel.org, AJvYcCWRY6s8wwSx4/I6gV7JIfKkjcREFl+GAqXmsh0PsNw6KcbYN+eVB6Z1iy6Eedp/6HTuc9BBpIVDhNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmUFjSuCY1+2NnRPpTT7cHHsLfPiwhVQnjTWLIGYSltZUmRH4G
	Zf4KdW6lty4b0+fsQ2SeNM+mFVKpV2SP7B0nnFQYs/yN4tIeVWCsPcmIv9+B19+xeHyH5q4nQFg
	TZkV8qqceoYYzSlWo6SUKJweRUdA=
X-Google-Smtp-Source: AGHT+IF/Xn74FPzWxUMpobK5eYPXxi3H+e7CiAt/e1busK+TNSBvd20Vw3Rlp2wN4ZY8to/DMozxHrLIKv+WBrNjWJ4=
X-Received: by 2002:a05:6870:e249:b0:270:4637:40fa with SMTP id
 586e51a60fabf-273e675c7a1mr13625626fac.48.1724758787990; Tue, 27 Aug 2024
 04:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2205737.irdbgypaU6@rjwysocki.net> <CGME20240826113153eucas1p110e90b4cd98aa70601770fe93d7aa1e5@eucas1p1.samsung.com>
 <2236794.NgBsaNRSFp@rjwysocki.net> <ef729a47-b7f9-48b6-a14d-692565ef1d38@samsung.com>
 <CAJZ5v0gOqNi+-Hi8uyeEJ9dHzhwU6GyL6t_7Xjt5Knf2yJmH-w@mail.gmail.com> <0e710ff1-4ff4-403a-b85d-b1e51c03378a@samsung.com>
In-Reply-To: <0e710ff1-4ff4-403a-b85d-b1e51c03378a@samsung.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Aug 2024 13:39:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h2pF3E_Ni1D7_6jB0NpQrkhcZ6tCCmww8CX02-5qAYEw@mail.gmail.com>
Message-ID: <CAJZ5v0h2pF3E_Ni1D7_6jB0NpQrkhcZ6tCCmww8CX02-5qAYEw@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] thermal/of: Use the .should_bind() thermal zone callback
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>, 
	Mateusz Majewski <m.majewski2@samsung.com>, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 10:49=E2=80=AFPM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 26.08.2024 14:14, Rafael J. Wysocki wrote:
> > On Mon, Aug 26, 2024 at 1:32=E2=80=AFPM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> >> On 19.08.2024 18:30, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Make the thermal_of driver use the .should_bind() thermal zone callba=
ck
> >>> to provide the thermal core with the information on whether or not to
> >>> bind the given cooling device to the given trip point in the given
> >>> thermal zone.  If it returns 'true', the thermal core will bind the
> >>> cooling device to the trip and the corresponding unbinding will be
> >>> taken care of automatically by the core on the removal of the involve=
d
> >>> thermal zone or cooling device.
> >>>
> >>> This replaces the .bind() and .unbind() thermal zone callbacks which
> >>> assumed the same trip points ordering in the driver and in the therma=
l
> >>> core (that may not be true any more in the future).  The .bind()
> >>> callback would walk the given thermal zone's cooling maps to find all
> >>> of the valid trip point combinations with the given cooling device an=
d
> >>> it would call thermal_zone_bind_cooling_device() for all of them usin=
g
> >>> trip point indices reflecting the ordering of the trips in the DT.
> >>>
> >>> The .should_bind() callback still walks the thermal zone's cooling ma=
ps,
> >>> but it can use the trip object passed to it by the thermal core to fi=
nd
> >>> the trip in question in the first place and then it uses the
> >>> corresponding 'cooling-device' entries to look up the given cooling
> >>> device.  To be able to match the trip object provided by the thermal
> >>> core to a specific device node, the driver sets the 'priv' field of e=
ach
> >>> trip to the corresponding device node pointer during initialization.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> This patch landed recently in linux-next as commit 6d71d55c3b12
> >> ("thermal/of: Use the .should_bind() thermal zone callback")
> > It has been fixed since and it is commit  94c6110b0b13c6416146 now.
>
>
> Confirmed. Thanks for fixing it and sorry for the noise.

Thank you!

And it wasn't noise.  You reported the problem as soon as you saw it
and before you could see the fix.  Somebody else saw it earlier, but
there's nothing wrong with that.

