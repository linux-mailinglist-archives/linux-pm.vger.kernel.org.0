Return-Path: <linux-pm+bounces-32763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4065EB2ED51
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 06:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604033B7130
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 04:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63752E339C;
	Thu, 21 Aug 2025 04:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKlf5NVX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162A32DFA39;
	Thu, 21 Aug 2025 04:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755751831; cv=none; b=YawygIaaZpaekA/MLq0XdQt5Jek9n7hlveJsLmC4BLDgzFzXVW+g9jIKOZBvUKrZ4KVchSuRo1bnbdzD/++dcPwNSeTEqF8YlCHrg0F+vplKj32rEkOo5LDEBGkUA/y50oy6HyDxgPkGZnrr5RfOL/bepAhYV3rMPsR7fGh0gR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755751831; c=relaxed/simple;
	bh=UpF5QA6HbdvrWUXvkPpNz8Yu47AUnft8BjwhbRzZQbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EP0v9iegeGDRkarYG4+fhweiwVah4fgNqO/I2YVLle4hi/EtPiJnZqpYiI4hMcH/Mt/5FGqe6bvvcgpPFuHIraJVDEqCn6UL2zPEnDRpZaydXZQhzzUJto2BGK4SAYA3JQInCepRLIjMyYUaZNQ82m9mfwmcUHGUc4iKMuWpDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKlf5NVX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9dc5c6521so259680f8f.1;
        Wed, 20 Aug 2025 21:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755751828; x=1756356628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dtO2gp3iJdG58JTW82ssdRgH9CvjrDF+oqDkonvQAA=;
        b=eKlf5NVX2TZ7TUP4O4Ndu83jcBvLC0Ijlz7XBBgbHGDOMeWFGYF7rjmG1XRoGrc2Hq
         4F8SQ8Pg6oSM0bGbCpndnDcUAzHnGBPIZdXLySaY0o5lfcTSDKwsvrBj+stMAK7mDYQ8
         lECl2P7PzUJ7nnza4GGqSOp49KmS/IFzU7KMz+zoDJHJbNel0wdxJFops2w3oh3pfXBm
         SsnFH4ts+Hur+TMEB27aHt9R5MYvFjqhZJ6sbNxu0L9l0XkMVQdY5LUzUo6Ulvi6vCTi
         YfsDlhFauRj7/rQpc528ksoSPVVjB19ZXQp/Dmit1t5qb54ALf+It5TFBwrFk9Ukglqv
         318w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755751828; x=1756356628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dtO2gp3iJdG58JTW82ssdRgH9CvjrDF+oqDkonvQAA=;
        b=t1KN0/FaW+XUTf5rYkpmqwNkC4iEX46hmlhmlh03M1OSbbPe58+jwiWq2T3wN0VkX0
         LkFb09pJraXgbLUT6hiBdYYBNEfrSHdWf/pfHkpKNv3OR6f/rM7UES10lRqFqwVmpBkZ
         P4+GszSwvlk6dUs6yEvV1qwcDA8f1Qp0yVjBKE8ZYjJmeQTLOUXH7FaQIfxpoN0pnP72
         dGzPlnB7LeXmz1sjvjMG4iZG1AtJitnNV0v3+i/29gFpTZbIKVVothxx9yehnr1mEmiL
         lBBVD0LMmKnDz8n6t+yWNZdvgqp3ZKWT3MbBO45XKmrAz/ribDTAi1eyqNJrGRb+0FPe
         2Cjw==
X-Forwarded-Encrypted: i=1; AJvYcCX6P81+IuSf4Ymop0Psgv+bXJ9c2GldouzESNoEu7LjQACDPblHi/ZPkrtAhgp8byRpP9r5Ot3/+ey/@vger.kernel.org, AJvYcCXFgf02NiVZ90/D8z0GsOi5BVgUOJPn2cvEnAQJx88SyGie1IQesiuTBXEzbpzWE/FCHev+MCW1Pbk=@vger.kernel.org, AJvYcCXJZ6rmc319XOL2JqcwPrNRNR9QpDunAhq03fKy2Kf0Rjwv329kFg4Y16qAC7vWMoSsuIFBIwDPphe02wWM@vger.kernel.org, AJvYcCXJzvFSLgmQp04FwqLxohjrggIb+qI7vErBW6QLZ2C+WqOPAZarbbetRNMTyPsir/FwOIigBtHom8MYEC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlaY7O8HqAcKdtlwRVfE5dj+wHfqZZQ+AHd9qYf9S0wQPn8F2D
	zWtdt2z8M+u03lmeIQMoAVVurjVPKCWp5we7SHFgqEfS9ANV5auY6l0+Q0oTmgo5qE3Z9RpMnnT
	OgcLM2kr0KILeOYMt55D7dslacJqghwA=
X-Gm-Gg: ASbGnct1BB+EYi0glILJzV5aiQALoo2Re7fdXb9HPnseQTBddebG9SzYUa8kf19Prqe
	8/3AK/FciYI5P5eBGW5WaPVofj1fJWNY+MjBZOxidPZWXFlrR5xmqw1p8qwwX+v2ddxXR6DOwz0
	TiWFLoGIFnPaNlBmG6FzFYI0bmn2v/0nL8SszqYe+CNebBVq0IRKHphOPNb8ubTbb1gf0hM+vwF
	97covmaMNfG4whA8Y4=
X-Google-Smtp-Source: AGHT+IGYecgy9j572GZwpeAgWSoV3mseOhv6g1iDfgwoDh9FQ1EL/Iny+JK2np6zkwE9E5Tijf8v1e6C3NJH07riTbo=
X-Received: by 2002:a05:6000:144d:b0:3b9:7c00:b6a8 with SMTP id
 ffacd0b85a97d-3c496028fe5mr742205f8f.41.1755751828104; Wed, 20 Aug 2025
 21:50:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820114231.150441-1-clamor95@gmail.com> <20250820114231.150441-5-clamor95@gmail.com>
 <20250820-spinning-arrogance-31b71d969bb8@spud>
In-Reply-To: <20250820-spinning-arrogance-31b71d969bb8@spud>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 21 Aug 2025 07:50:16 +0300
X-Gm-Features: Ac12FXyqEn6pzjt3rR9t2N0ja6nKMmgk5yQvgEV89ksNAHwqJ8_loYldvESgGtU
Message-ID: <CAPVz0n35onsKZGjWDFGX+h7AoOxkd9S4QsR3ABNGxzcj6iXs9Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] dt-bindings: thermal: tegra: add Tegra114 soctherm header
To: Conor Dooley <conor@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Thierry Reding <treding@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 20 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 22:4=
4 Conor Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Aug 20, 2025 at 02:42:29PM +0300, Svyatoslav Ryhel wrote:
> > This adds header for the Tegra114 SOCTHERM device tree node.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../dt-bindings/thermal/tegra114-soctherm.h   | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644 include/dt-bindings/thermal/tegra114-soctherm.h
> >
> > diff --git a/include/dt-bindings/thermal/tegra114-soctherm.h b/include/=
dt-bindings/thermal/tegra114-soctherm.h
> > new file mode 100644
> > index 000000000000..b605e53284fe
> > --- /dev/null
> > +++ b/include/dt-bindings/thermal/tegra114-soctherm.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +/*
> > + * This header provides constants for binding nvidia,tegra114-soctherm=
.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_THERMAL_TEGRA114_SOCTHERM_H
> > +#define _DT_BINDINGS_THERMAL_TEGRA114_SOCTHERM_H
> > +
> > +#define TEGRA114_SOCTHERM_SENSOR_CPU 0
> > +#define TEGRA114_SOCTHERM_SENSOR_MEM 1
> > +#define TEGRA114_SOCTHERM_SENSOR_GPU 2
> > +#define TEGRA114_SOCTHERM_SENSOR_PLLX 3
>
> > +#define TEGRA114_SOCTHERM_SENSOR_NUM 4
>
> Why is this "NUM" sensor not in the driver?
> hint: if this is the number of sensors, remove it from the binding ;)
>

It must have got here by accident, thank you for pointing

> > +
> > +#define TEGRA_SOCTHERM_THROT_LEVEL_NONE 0
> > +#define TEGRA_SOCTHERM_THROT_LEVEL_LOW  1
> > +#define TEGRA_SOCTHERM_THROT_LEVEL_MED  2
> > +#define TEGRA_SOCTHERM_THROT_LEVEL_HIGH 3
> > +
> > +#endif
> > --
> > 2.48.1
> >

