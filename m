Return-Path: <linux-pm+bounces-19915-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 928D39FFFD1
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 21:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6956E1628D7
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 20:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B2E1B4F04;
	Thu,  2 Jan 2025 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+2YCuB2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ED513D508
	for <linux-pm@vger.kernel.org>; Thu,  2 Jan 2025 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735848491; cv=none; b=kcsWYqhmekXAIGuHM71j/Z5AoLu5PhzZklx0Fb+0oZUs8izLSW+M3W5NcuN7aT8JPSCGQSFFwsW7OZlmEXpuHIir2vKoC1PmQXPaD9bBuhkdSi+4k0vCmV7bjBeIkuIcNx+T8NZmpj1YDRv9ah/FZiSTGf1FvX7XDqQCpvs9OMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735848491; c=relaxed/simple;
	bh=jvX67mFsfLe4VWpjGP9IYHEM0KqK/Nai/jzo3FhJ+6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BubtBXSHlscf26deJqSyuLey0dwokj7/ntyXpOKp5C3XMEQrXRXGglFCuQqY5VZp4k5TrOPlJmfI0Rqy4zrqYs+FunxGdV2NarG4uiDgIjLDE9vRZ2yK+uU71rQ/BpSdy+qN9g3/tvZgQ0kKZx9dXStB+FFlDRhUjpysNqYdy+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E+2YCuB2; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e4a6b978283so15692680276.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Jan 2025 12:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735848487; x=1736453287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfITormVFn4jObWXUL+Z9GCJHTq0moTZycjXJjd+H4I=;
        b=E+2YCuB2sV7ifeL046zbPvrBMgt2htFoJAJ19kS2uvEm59xdMtpXP0toElZvQe1TjG
         D8I/ZgahG1CP79aJPrj69p7wirzN/Oz9mJzn7SdvSe1TtA+GJi7YyXdZAbw40SAlrU6L
         7nB5idrXoJzSYLGS4g9Pp2UK8f4MzR5cQ7zpRkQ2uWIwm5cNRSqMKEWNdPBfThBmYEwf
         rz69I2YF0XwBI0wPL4XaH6M/wD3hCqoxv+Uev51oJiDXnz47O1YO+nExvJWUjOoZ8dGe
         Jw3lGtYiAQY6XV4m5+AEs1Lk/c0w5/1Tnb+peH0uhdaDBxKWhVhlP7ayyvMsVjuElGYu
         ObRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735848487; x=1736453287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LfITormVFn4jObWXUL+Z9GCJHTq0moTZycjXJjd+H4I=;
        b=iLpbLCKfO+qnwBFdshMzFc/H9eOSXSmEdLHQnifipqTfeYuINt+rBdecG5qqljeYJa
         DQStHUrezZZMoIUbTTZXNDdQB8twLFdxZgNFXDxCl3pg/NkQqwXz7dtlYRtZyGXm/fnh
         ZZOj8/SG6PVx6G5oAjl4skBYSFSvYebXw3FDP7QklCH0cFBq7a+xYyVYwe6+aIJO5Izo
         bTJ1lPOwJzgRta/EJfuiGH3B85Ifs9u0kiocUaELwjOBtn3FphkTCdprVB7784XUh7aj
         MHJP7hSB2Ygn21P33JsWuRh5T/+iDM69Lar0Kfh6sWOWm2tWS3NvABwUg6IVnIY90nEk
         1v7w==
X-Forwarded-Encrypted: i=1; AJvYcCV1KP1VQB+JojbYLBnND2ObeLdK9pRMQa07DpN2RQb8a9oUJd1GaDIaanWQfLy42CUrkX1LNcwQIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjoPBku13JqyIvUiiq6ZzW2tbkVDdbda5lovlHlvAGyihdTIFv
	4ezZjO38r5jRVplIpJtsEIa3+UIxL7g9wC6kVouTn6vdMBIVBbp/HLH9I6mqNDVgMZLvI5JAmyG
	bH4937f8Q0CBGqMURu381gC6R3ihWMcKGougX/g==
X-Gm-Gg: ASbGncvAgOyfNSaAp4ToOBGOsSg5vEjb9TjYLEVpi5Gd6Bli6SgfAiMHKCZy14SdvHB
	CDYlMm55AFkFxA6oLpK3uoVD+tPB4hUEhRMBwRjY=
X-Google-Smtp-Source: AGHT+IHTMntr/wIaqTba+whMGR9EjXQOW5JmOmFz3zgpeRIDl3WKXyCdvz2mWr5GNUq+dMW//xlN4NVag3thQW3KuxM=
X-Received: by 2002:a05:690c:74c3:b0:6f0:23c9:2989 with SMTP id
 00721157ae682-6f3f7e3d205mr266592177b3.11.1735848487650; Thu, 02 Jan 2025
 12:08:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218184433.1930532-1-l.stach@pengutronix.de>
 <CAPDyKFoeebzUkmeya4WEcdc+px-=8rwSGdmF_-1giiwkHvWo5Q@mail.gmail.com>
 <CAPDyKFp8jvEDGfkuMzzSVSo2gDtf+naC3QwXrCJD7t1e8wPJFQ@mail.gmail.com> <CAMuHMdU=Kyu7n-Wn85mPpJFKKxRDqNAVv+RBJsN7Xauma-jpHQ@mail.gmail.com>
In-Reply-To: <CAMuHMdU=Kyu7n-Wn85mPpJFKKxRDqNAVv+RBJsN7Xauma-jpHQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 2 Jan 2025 21:07:31 +0100
Message-ID: <CAPDyKFo7rqJ4dw_0cBK+fF0BSwZcM1Z_MMH6o=p8H22E5UVCmw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: add dummy release function to genpd device
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, linux-pm@vger.kernel.org, kernel@pengutronix.de, 
	patchwork-lst@pengutronix.de, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 31 Dec 2024 at 11:45, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>
> Hi Ulf,
>
> On Thu, Dec 19, 2024 at 3:49=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> > Applied for fixes and by adding a stable tag.
>
> commit f64f610ec6ab59dd0391b03842cea3a4cd8ee34f
> Author: Lucas Stach <l.stach@pengutronix.de>
> Date:   Wed Dec 18 19:44:33 2024 +0100
>
>     pmdomain: core: add dummy release function to genpd device
>
>     The genpd device, which is really only used as a handle to lookup
>     OPP, but not even registered to the device core otherwise and thus
>     lifetime linked to the genpd struct it is contained in, is missing
>     a release function. After b8f7bbd1f4ec ("pmdomain: core: Add
>     missing put_device()") the device will be cleaned up going through
>     the driver core device_release() function, which will warn when no
>     release callback is present for the device. Add a dummy release
>     function to shut up the warning.
>
>     Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>     Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>     Fixes: b8f7bbd1f4ec ("pmdomain: core: Add missing put_device()")
>     Cc: stable@vger.kernel.org
>     Message-ID: <20241218184433.1930532-1-l.stach@pengutronix.de>
>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Can you please use Link:-tags pointing to lore instead of non-standard
> Message-ID:-tags, so we can easily go to preceding discussions?

Certainly! Thanks for pointing this out!

It seems like my git-hook with a perl-script stopped working, as in
the past I have added those Link-tags when applying a patch.

Kind regards
Uffe

