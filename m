Return-Path: <linux-pm+bounces-29996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519C0AF6411
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 23:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC444A845A
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 21:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06720243964;
	Wed,  2 Jul 2025 21:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5vN7RTm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6E92DE705
	for <linux-pm@vger.kernel.org>; Wed,  2 Jul 2025 21:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751492084; cv=none; b=gM7KIXRujqdvL+tSHFsZrr+65c2ov++HxDRb8DxtTxrghmK+HklRj+nId9WY0SdGBUQ7FCNYErqVYUYtgC7Y/Zz0RlVBHJMjL5k2lAPywj7sW7mNi2c075yDrakbtIXnYP4G2LOeRntg/6FumX30VVCdvj9X5qVFE6lKTTdgPK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751492084; c=relaxed/simple;
	bh=dIvSAKAz9GvFL8eF8f11r9vPU2RPP8HamslypNFwZD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbPPo91JyOsKLIrGjZI15///jTVLSs34+9Tu96Z+BIUBGiDpebJqkPV/lwxonVGVNnYwdPOUp4B4uwPY6gUjab9u1owNR5mpw/bjCy+f732K/QW9Z3lSctaBl+zrsrf1IJ2kmC0uz7dInHryKqc9TQcY1fdSgmPxh/EKJM0iKu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g5vN7RTm; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4e8135adfccso1822140137.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Jul 2025 14:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751492081; x=1752096881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpucKaFQXs24/Gdxy0fvjSfjmEgyvs47syPRCcBg2xY=;
        b=g5vN7RTmr2dk4axdoF6+fBQYjrqtuzDSkkKwE2qN3D5++wg+EINlYQpHCEZgregjir
         PxB6BYNEx95JWOEouYFbV6CC1xmgglD/C3teLwafmArJFhrb+N8Fv55Awyz4Xr9eakbl
         3/07rxUR45dHdjSYE9nzNqO4iQ2eRnjXrliXriidpAEy2SRAt6etWelOwEjy2ZhW7deB
         IlC/WW5Nb65916AW1UmUusK/HlDf3ab+WImdDlMzv7mCE5N6wgENWumi8K3xYGclnWFQ
         o0pqanBauyiXZ3revWzSysJm8NnBU7LLp4Ttx8L+gAliYCtjx5IULcf8SYcDydZ9V2fp
         Nhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751492081; x=1752096881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpucKaFQXs24/Gdxy0fvjSfjmEgyvs47syPRCcBg2xY=;
        b=ovcgdjSh7xBJRXXmmv/QhZQA4jeSlxFN5SFrkf1O/Bl6F2CssiPo8WGICIlLxnyA8t
         NB1GaBWBdnJjcNveGsRR+tVoHt0Eo2xjfXaVTVsKzmGEH6jMgn6RRR9KFBhzU9IvgriL
         MziaCpcJvH8f5U5mS+oZoqLbWU9xk18nWNlepiLdOGf05IXZSIpvTnji1Is5Ml5WXs8Q
         6V+uqaQgqrW4W79mZsZI7RVYkEvJ2ir5LgiwFN/lxcbmN6PvBGT7NEA7MXQttnJbitHi
         PcHFJ+oQdOyn8aoBoZplVzSFJDriLztc79sLtQcZPZGVLZ7r765dzSmMw55OuDmLFua5
         QiYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMuRSaTKMtAlOrtZVI8bVSbUeoOV0CAiIaxcSfaZabT2ZGny6vgwbuFokFMSMFfbwBTy2G/UP4kA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9+bQ9UPMF4z5NKue8zAxbljyp56exlRC0t4b9ljggnq6Ntybi
	gcRHIwco7jBC6owwZP5bnY15NBDscWbRyFLQMbP9KnXus+pxQCqrvc+aFRUQfAljBm+d/iMozSO
	s3t/3C452NIaUPQ0hkCGVQtj3HzF0t7lyjFHgWzis
X-Gm-Gg: ASbGncvo0Lwog83BRVGnJdpHUpbMsSBkar9abV4C65omlLuWyD4IEpgQZLM9UyAhz5v
	TXaXfMJZdV0Bw/vWLy4u+53Pb2wEjP8T1VeUbecJU17Yhf2LwGG+jxH5kjLStQROQxvO/2lY2Ji
	txE1nwT1ZdoTr/b2WGQ+TzsqbpIVKz9Ej08Mv3yHyXiyLjI8yOCgBKZRK1JvcHapxOn9Z3b4yi
X-Google-Smtp-Source: AGHT+IH1fp/oO8knYExoVI4CZr0MWB4CCN3Ddzd0DoffyBdgk98L0zPZn5aGpXX4Klhx4XnOgbiAKitEu5ixJn7kSp4=
X-Received: by 2002:a05:6102:5486:b0:4e5:59ce:471b with SMTP id
 ada2fe7eead31-4f1613c8319mr3578113137.23.1751492080860; Wed, 02 Jul 2025
 14:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <20250701114733.636510-18-ulf.hansson@linaro.org> <2025070205-ignore-passive-17b4@gregkh>
 <aGWH2mH6iZJ3s3lL@pollux>
In-Reply-To: <aGWH2mH6iZJ3s3lL@pollux>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 2 Jul 2025 14:34:04 -0700
X-Gm-Features: Ac12FXzxNwy9Q8y7eUa-yNyxqV22KlOcq4v5ePhyN7HxiHMeoKsg2U5kRHPewzA
Message-ID: <CAGETcx_yVXgvmbDFYe+Nbdp18D-m14W8xO_G9RyAujpag+M9ow@mail.gmail.com>
Subject: Re: [PATCH v3 17/24] driver core: Export get_dev_from_fwnode()
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Michael Grzeschik <m.grzeschik@pengutronix.de>, 
	Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Peng Fan <peng.fan@oss.nxp.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Johan Hovold <johan@kernel.org>, Maulik Shah <maulik.shah@oss.qualcomm.com>, 
	Michal Simek <michal.simek@amd.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Hiago De Franco <hiago.franco@toradex.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 12:26=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Wed, Jul 02, 2025 at 09:34:12AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jul 01, 2025 at 01:47:19PM +0200, Ulf Hansson wrote:
> > > It has turned out get_dev_from_fwnode() is useful at a few other plac=
es
> > > outside of the driver core, as in gpiolib.c for example. Therefore le=
t's
> > > make it available as a common helper function.
> > >
> > > Suggested-by: Saravana Kannan <saravanak@google.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
> > > Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62=
A,Xilinx ZynqMP ZCU106
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  drivers/base/core.c    | 8 ++++++--
> > >  include/linux/device.h | 1 +
> > >  2 files changed, 7 insertions(+), 2 deletions(-)
> > >
> >
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> I'm a bit concerned about exporting get_dev_from_fwnode() -- at least wit=
hout a
> clear note on that this helper should be used with caution.
>
> AFAIK, a struct fwnode_handle instance does not have a reference count fo=
r its
> struct device pointer.
>
> Hence, calling get_dev_from_fwnode() with a valid fwnode handle is not en=
ough.

Not enough for what?

> The caller also needs to ensure that the device the fwnode has a pointer =
to has
> not been released yet.

Why? The point of the API is to give you the driver core's notion of
the primary device that corresponds to a fwnode at that instant.

There's no refcount needed for that. This is just a simpler way than
looping through all the devices to find the first device that has that
specific fwnode.

It's only the device that needs to be ref counted because the caller
needs to do stuff with it.

-Saravana

