Return-Path: <linux-pm+bounces-11748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75224942CA4
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 12:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A611C1C21DBD
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 10:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343E11AC43C;
	Wed, 31 Jul 2024 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYZQhOwn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FFD1A8C0C;
	Wed, 31 Jul 2024 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423557; cv=none; b=I4i9XPhMCqhdhuioc3S60j6fJCV+HlJcsCu2THYcHNy4IAurhKfqi70G9PxioBgG4VEChPoTZyalAvhE8EWU+a9O9jAJehwGaleadSt+A3o1Y2xgfOAebz8OiV/bjLcJ7qY+yDRd1mOaXN39C3/hsGPuOlaOSXLsVC6nuRaVVts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423557; c=relaxed/simple;
	bh=WAt+uKUcWmsl15ThUfwoCHfKCOypKIoAIzDoID2uCro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOFUHjVVx+pdMcv8FkIdeRuYs1e2ms2HdNSi+8VhLYUx4JLrQv+Q8QelQf1/lPrOuAVr4q2d3KW+1c1+/XplwVtIh8qGE5Gka41J0yD1hqvXJg+7s3zT3SYUULP/vRzue88qSvtOBIqii6wrPSQ1wzfxS1bn36jsqJKEzx1Q9ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYZQhOwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A88C4AF10;
	Wed, 31 Jul 2024 10:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423556;
	bh=WAt+uKUcWmsl15ThUfwoCHfKCOypKIoAIzDoID2uCro=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MYZQhOwnMd7DGLOMs49T9UkHY7p+38xxoap4wFimL58ep0kXeKmhKehWIF6+V1YvO
	 Qp08ixMRHLJfvw0MZxIUX1ICqMYqYELvWEeu48g3Tit+MgDxRby9ryviAmGoB/3ffD
	 ptGFN24Cmjhb47ZJGz1MWQo6emMDNmZCv9odI81Gz6SoEVjd9RWUzLU86/u7sSQxRf
	 FdS+4un6uQPnxz46Y50YmbfYewRKsorylo+G3rewR0F9AN/eVNi5zNa4Oxr/X1P0CU
	 rpAJ31zd4L8gST8XG0GP6jf6VKK9BSDIy4qI6iJ3RAw6iZhiYxRn2RKetCS52kGK4R
	 V+ZHlIxgWEiJQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-26123e59c8aso666179fac.1;
        Wed, 31 Jul 2024 03:59:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUQiQj8Rjzwd24h5pRTX9TTZeO/3kRpdXExSSi9s8t4kOWgB9EoRHfcEg8s3U9ORt18DHosUhK4jQ=@vger.kernel.org, AJvYcCUwF5kGyKOujh1lNgIwtCPcWIiX8H6RsbB8Bg/WgcPNEiUycFC/H9coYk2BPrf0B/46d+eLX+ghgjY=@vger.kernel.org, AJvYcCXEPzC02uG1foDHsYhb32GloajRWVw5stdEq12gjLhTh6JWMqPK36jNJDXrR6tRb/bHwustmdah3Ry+YTfK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1/HnO8moItt747SmBJLIPFlTKPjH7BO1X5Arl1HN4Jr40pOU6
	HxQRqUFW+MSXaEjIhmVpvH7XR/9NRUu4/Ln1WVSuQgF3zBuodnN6lbqb4RoU43ZmfPJdxREbRG5
	RWd+RW7eQkO4XXEiiMwP5OsgBgk4=
X-Google-Smtp-Source: AGHT+IEnDZbw2dFh8GGsUt2bFDG9W3nBtCNuFqKxK18Y/P1eEfHY17D0uoNuEG4z99VyYqLxmmpsTcZJjxYb2hp3wh4=
X-Received: by 2002:a4a:df47:0:b0:5d5:bc1f:daa with SMTP id
 006d021491bc7-5d5bc1f0f75mr10929184eaf.1.1722423555797; Wed, 31 Jul 2024
 03:59:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731095223.2778-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20240731095223.2778-1-ilpo.jarvinen@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 31 Jul 2024 12:59:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gv3xe=bmGQVDuk_wMczA5u0ASvBOQJSKShW=nAfg7hxQ@mail.gmail.com>
Message-ID: <CAJZ5v0gv3xe=bmGQVDuk_wMczA5u0ASvBOQJSKShW=nAfg7hxQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] docs: thermal: Remove extra parenthesis
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:52=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> thermal_zone_device_register() prototype in the thermal zone device
> interface documentation has double closing parenthesis. Remove one
> of them.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  Documentation/driver-api/thermal/sysfs-api.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentati=
on/driver-api/thermal/sysfs-api.rst
> index 6c1175c6afba..63ed1801ac40 100644
> --- a/Documentation/driver-api/thermal/sysfs-api.rst
> +++ b/Documentation/driver-api/thermal/sysfs-api.rst
> @@ -43,7 +43,7 @@ temperature) and throttle appropriate devices.
>                                       int trips, int mask, void *devdata,
>                                       struct thermal_zone_device_ops *ops=
,
>                                       const struct thermal_zone_params *t=
zp,
> -                                     int passive_delay, int polling_dela=
y))
> +                                     int passive_delay, int polling_dela=
y)
>
>      This interface function adds a new thermal zone device (sensor) to
>      /sys/class/thermal folder as `thermal_zone[0-*]`. It tries to bind a=
ll the
> --

I was about to apply this, but then I realized that the function in
question doesn't even exist any more.

Let me have a look at this file.

