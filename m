Return-Path: <linux-pm+bounces-12878-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B8595F117
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 14:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 691D8B23001
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 12:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB71184525;
	Mon, 26 Aug 2024 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bl4JKknE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D831714BE;
	Mon, 26 Aug 2024 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674469; cv=none; b=Ijs/JbXeEbGZjzc6gqGXbBetuul0xmLu1470107zR8lJnjb98Lfbyl0L+DqVQ4gYTOzmJ31/XCFrVZxneW9KtDJEmB93lYFofoA8mreMw9MyRUcgpqxyrjPBUQxz7dzzi873MoDdCZpYw6n1bWoDI9dfdNQIiR5/X2CUM/xdiRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674469; c=relaxed/simple;
	bh=fPunrM8wQmioX20CPKHx2jmPcu0ptHjNsZuRqPqcdBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5c/Yxg/LN9EZUpEl4axzh7/sJgL+QAerY8rt83GOL9Pib83nn3AkyVd671WZSlL/r3GxGen8KjkbKmS1QCGQj6k+bJ7D01L/QegdbV+2Cuux3G8Lc8JU32vzcEGMz39mXATwI2CMM2CYHOONL71bH/Ykq84bqpgBzZnCxbGDiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bl4JKknE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121FCC5676E;
	Mon, 26 Aug 2024 12:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724674469;
	bh=fPunrM8wQmioX20CPKHx2jmPcu0ptHjNsZuRqPqcdBY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bl4JKknExI0/Akf8Pn3jp1o9ioLn7g0g/I6y8kRHDH/vsIfFbvl9zkTyKrNM/cSD5
	 CN82TM87IycmdUHF/mr1n17OMtptMN+HIVNk+ORpFp0v0Kah/TWzPlCmzLCbCrtBCY
	 djaYhIDWrbgJDjsZNua0QfA3JUVnA/jkpoHm4KYTdxRlKpUue0J4igVCMvvG4LPsD+
	 NrLP8e0auODuAhko+atjos9/k+8c+GJ6L3yAvOWpuRUvPsUtgUaKbKBcMYKYlOd4Wm
	 lglFBZpXZDalLSznIb/iEMa66QSW6xABX8CPqmYrS8wPkyzbJ7GdHGfhB7GUhjN9B3
	 SSTYl5RPU9SSQ==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-27028b2cf22so2144438fac.1;
        Mon, 26 Aug 2024 05:14:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/RMalkyV4I+wJ9USs5gbG2gm8eAuEK1eCqwl8DDJbHo3Ul6Hx67gSzdB6nQmWhmbAlTV3dc1PUVZMa5Y=@vger.kernel.org, AJvYcCV8sXJG6GERn1x/qaVLLBAnvt04WEw8LPizzVNK9rjaAM2jHe8eiKFIwO5Ksf8VPU4yQ4Ammn1RI174LzVtVA9Dx9g=@vger.kernel.org, AJvYcCVkZlNv8RctiKke9nGzZ4v/Y5+o7uXFxt7znFmOaPiUL+HJas+QVN+T0typju5Hdegff4AzKfsuRfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY79Ec3zJR2GzWeccHDfNltBiiZuOBmITJqz0lADzLA6FewPHF
	ElU16RckBe7Fz8JG9Mz5W6zMc6rc3rCuBei3OUPUxbsdx/Jn93ik5QfUQk98+Wz9AoEzHCONHks
	w6TeJtA0zg219A84qMvhPp3stm9Q=
X-Google-Smtp-Source: AGHT+IHHIxz6xXD0eumhtaQ76KUnOsLvK/0jHEg0Pa8eJhhrxY2DehTK1l7SfWk+MDuetN59VRcDB1RzH8KdDg1MoWw=
X-Received: by 2002:a05:6870:a11e:b0:260:26a2:68e8 with SMTP id
 586e51a60fabf-273e44fafabmr4131563fac.4.1724674468431; Mon, 26 Aug 2024
 05:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2205737.irdbgypaU6@rjwysocki.net> <CGME20240826113153eucas1p110e90b4cd98aa70601770fe93d7aa1e5@eucas1p1.samsung.com>
 <2236794.NgBsaNRSFp@rjwysocki.net> <ef729a47-b7f9-48b6-a14d-692565ef1d38@samsung.com>
In-Reply-To: <ef729a47-b7f9-48b6-a14d-692565ef1d38@samsung.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Aug 2024 14:14:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gOqNi+-Hi8uyeEJ9dHzhwU6GyL6t_7Xjt5Knf2yJmH-w@mail.gmail.com>
Message-ID: <CAJZ5v0gOqNi+-Hi8uyeEJ9dHzhwU6GyL6t_7Xjt5Knf2yJmH-w@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] thermal/of: Use the .should_bind() thermal zone callback
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>, 
	Mateusz Majewski <m.majewski2@samsung.com>, linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 1:32=E2=80=AFPM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 19.08.2024 18:30, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Make the thermal_of driver use the .should_bind() thermal zone callback
> > to provide the thermal core with the information on whether or not to
> > bind the given cooling device to the given trip point in the given
> > thermal zone.  If it returns 'true', the thermal core will bind the
> > cooling device to the trip and the corresponding unbinding will be
> > taken care of automatically by the core on the removal of the involved
> > thermal zone or cooling device.
> >
> > This replaces the .bind() and .unbind() thermal zone callbacks which
> > assumed the same trip points ordering in the driver and in the thermal
> > core (that may not be true any more in the future).  The .bind()
> > callback would walk the given thermal zone's cooling maps to find all
> > of the valid trip point combinations with the given cooling device and
> > it would call thermal_zone_bind_cooling_device() for all of them using
> > trip point indices reflecting the ordering of the trips in the DT.
> >
> > The .should_bind() callback still walks the thermal zone's cooling maps=
,
> > but it can use the trip object passed to it by the thermal core to find
> > the trip in question in the first place and then it uses the
> > corresponding 'cooling-device' entries to look up the given cooling
> > device.  To be able to match the trip object provided by the thermal
> > core to a specific device node, the driver sets the 'priv' field of eac=
h
> > trip to the corresponding device node pointer during initialization.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> This patch landed recently in linux-next as commit 6d71d55c3b12
> ("thermal/of: Use the .should_bind() thermal zone callback")

It has been fixed since and it is commit  94c6110b0b13c6416146 now.

Bottom line is that it was calling of_node_put() too many times due to
a coding mistake.

> In my tests I found that it breaks booting some on my test boars: Exynos-=
based
> (OdroidXU4 with ARM32 bit kernel from multi_v7_defconfig) and Amlogic
> Meson based boards (OdroidC4, VIM3 with ARM64 defconfig+some debug
> options). Reverting $subject on top of next-20240823 together with
> c1ee6e1f68f5 ("thermal: core: Clean up trip bind/unbind functions") and
> 526954900465 ("thermal: core: Drop unused bind/unbind functions and
> callbacks") due to compile dependencies fixes the issue.

Thanks for the report!

