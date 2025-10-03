Return-Path: <linux-pm+bounces-35699-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E8CBB7FA6
	for <lists+linux-pm@lfdr.de>; Fri, 03 Oct 2025 21:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9FD2F34814B
	for <lists+linux-pm@lfdr.de>; Fri,  3 Oct 2025 19:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB80D223DED;
	Fri,  3 Oct 2025 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVlYUeUi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D791DF258
	for <linux-pm@vger.kernel.org>; Fri,  3 Oct 2025 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759519648; cv=none; b=avQoz67FwHtdcRiu3dtYSH77mAXQvyIwwccBwgxe1Xf0jiBJcx9zh4PC8Ljg0tkH2BLr3j+rSQaSPdH/AzMLM4Guhw0rHCxTVW9sY6xYsGbY76fVewW70vCoYI7BdGDwAQStlEItarsiCJuwTTwOUF33qjWG232EmayZXmBUKLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759519648; c=relaxed/simple;
	bh=f/LqKLc9MJ+mLYQaPZ1lV8+MeJ9MaG9Xyfc/PZeq8As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7AIxXYuvIsQaJOa4oOwwzuRCCh8d1jG/jU4Y/q5gJywNzNzOuLBoThuoNR708oHb7y5CYbgciNbWEIrKek2Q9GmzbRsijcqMP8FdCKWFrkNA5A7wCYihJhHL3fyh/ISbrmYk1UQVageRoT6a1kbOUbwLdM8mmTPI+KstCQy/ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVlYUeUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4AAC4CEFD
	for <linux-pm@vger.kernel.org>; Fri,  3 Oct 2025 19:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759519648;
	bh=f/LqKLc9MJ+mLYQaPZ1lV8+MeJ9MaG9Xyfc/PZeq8As=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MVlYUeUiAg3BfjBIiU137OYQqbr93vHHAviTvIqdpViuNOkXbZ7GyaOYJaW5ubhem
	 rodbrzz3bkkkOTlnNjwEGeKTDhZzFHeFwAptOwHBdUQz4b0j5TYyxlcKHMGVjiyK5z
	 twn5TyRKB9J13RdrrepyYnT8YL3OPgQa84olKLosXTUhp3m5suBeIV7DxrVZwDVv1z
	 wLAzFwstbgrZ8PzZrDNYwwTwvfpAA8YD2BFOANPHG0IMARbZkqt070GoTz+XSj48l8
	 APO5jdiDaIVH/CwQxVE66WzEN7kOE45ID+S1gVjlyYNXvrd5aOr7BLK2RimKgrz+04
	 8wna9vdF2q3MQ==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-43f4650340eso1310442b6e.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Oct 2025 12:27:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUD4OWjnnPHsxl+DSmnOL9h/Kwhs6esDwyUmv6CjQMTl7wEdI5G6PpWRCRQ7wWh0YezLFg1RbpKog==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3MDC1rxGfXNjVzbST5uHpoyvI3ii6X6f4Fms+iXwcBsyvliel
	MKNhAUnDDgPq7TJAuD1UFPj3ZC9VbC+xNNpuzAuVf9RrtUjuV7zwwRGW7XB5m7idLxw5BLDcIAe
	kUWIiGRFaEcdmaaSWQ/V/OjxBaP2K1PM=
X-Google-Smtp-Source: AGHT+IHULswGdoIFKuCxTcQrBU+FeeCAQQ7e5W/n7YJIg5v1QKXCoxc/GmWqOGq4cK/6X0JqkzJzL1RpZuqao4iuzKE=
X-Received: by 2002:a05:6808:1525:b0:438:bdb0:89ba with SMTP id
 5614622812f47-43fc178aad2mr1849983b6e.3.1759519647460; Fri, 03 Oct 2025
 12:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001-libthermal-install-v1-0-3071fd3f6612@pengutronix.de> <59a02980-3d3f-4baa-b466-271121a97a2e@linaro.org>
In-Reply-To: <59a02980-3d3f-4baa-b466-271121a97a2e@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 3 Oct 2025 21:27:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i7JKLNfi5nDFrJuOuHfQ7k01uve=WV-KccNgnNKGLr+Q@mail.gmail.com>
X-Gm-Features: AS18NWB5iB4OoZmA0nz146FsSGzdA-mFd_FFtInMF9a01s7P754Smg5cbBvVQJ4
Message-ID: <CAJZ5v0i7JKLNfi5nDFrJuOuHfQ7k01uve=WV-KccNgnNKGLr+Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] tools: lib: thermal: compile/install improvements
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Emil Dahl Juhl <juhl.emildahl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 4:11=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 10/1/25 13:40, Sascha Hauer wrote:
> > This series contains some installation/compilation improvements for
> > libthermal.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> > Emil Dahl Juhl (2):
> >        tools: lib: thermal: don't preserve owner in install
> >        tools: lib: thermal: expose thermal_exit symbols
> >
> > Sascha Hauer (1):
> >        tools: lib: thermal: use pkg-config to locate libnl3
> >
> >   tools/lib/thermal/Makefile       | 9 +++++++--
> >   tools/lib/thermal/libthermal.map | 5 ++++-
> >   2 files changed, 11 insertions(+), 3 deletions(-)
> > ---
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> Thanks for the series

Applied as 6.18 material, thanks!

