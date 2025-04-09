Return-Path: <linux-pm+bounces-25023-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F3EA82DAF
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 19:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E814676A6
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 17:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D46F2777FF;
	Wed,  9 Apr 2025 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9chif8P"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652BD276033;
	Wed,  9 Apr 2025 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744219879; cv=none; b=pCaleREsEJsk0nCTZ+/3rBtU4Ed7BKFOdYYxleXcxTqU46BODp1uQ4JUCzR5lGYi/EzBKY/u4qjUGU6rrdbSC5L8uoRO/ibqTjUoce52Y0z0pA+X2DKsSf2wVM7OJG5l6NZJht6uQfG/AeRaE8Kvk0jcvSIhmxvLz8wgLweboxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744219879; c=relaxed/simple;
	bh=/KSAzOtM7aiTTYljms4mdtfVBEj2qsQb/69FLyxbRX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LC+HjJgWlCt4NTHVFM1tnjS2olYV/ZGX/IJkcFIWk9kj8H+HObPS3EtpAMewX6XGlSUkfRWREVM6sxYNH5csd3jmDufHYPDXeIkcph7d0U35y0jEYbxatSSAcHDtyozDpWN70TtRJl5mJB2qf9hkpoSEgRrWStPkDyJRLgae4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9chif8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48FDC4CEE2;
	Wed,  9 Apr 2025 17:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744219878;
	bh=/KSAzOtM7aiTTYljms4mdtfVBEj2qsQb/69FLyxbRX4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J9chif8PhEJkEY5oiu29S+j7ER1fjswyP4DQ8EScfj6cQ1EBs1NDViamcukDPmusS
	 2Vg+RPuIP02xVbiFL2LolN+rBcSIpXK7E3+ck8lvUti8VY6AjusRpapPI5TFC4BW1N
	 +5QdRmGogPXSqW5OJnIo57+XWVo+W+72q9jrMQikdh3vx6TKBswTjDaiXEDZiIFH3o
	 dAJXtqccLU8tETgfnWCgO3bPKiAx04o4vrvNG2P1qXYtUrtSGjP7pD6bv2lt8dzjzY
	 5abCy6PPYr4NLKWwZC3iGbBOtppEHNbsOeg0BCOEkatUogLVdUQljLAIDVUpkanIJv
	 Cf0OaVqjeRLaA==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72b82c8230aso1729914a34.2;
        Wed, 09 Apr 2025 10:31:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGMhIaCyXb6poLCvGKii0o2Xging2Co2t0XApRdnhThf1bj/IkJnrQxs8Tl2lSNOjVik3Ssm3soG+sUG4=@vger.kernel.org, AJvYcCUT3csXyfOHoKdGlyzGEMtK7Q6+tdaiy2XGsvezUXdkYENAcfJ4uPwbMjhAH+hnEraw4sPeW62frSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzINNWzYX+JcO5+3KuGSpOfuF89zLtBH08hTDT/Wyhxf04eSUPV
	V0EbxRRklaKNqUtXEgQ/DnWhNDNlczPCT44x4MKSm4VIX8NxDzcMF8Xv6YRm8Sz45vHEg8NeVkd
	dK1GxmAx4aG05SxHCuXqH+d8LoHs=
X-Google-Smtp-Source: AGHT+IEAtVmrDRCPu1hpw3CmGLtl1aASqQX4u/CGbNIqF1wIOqTeHigoWrys7lxDPpwX/kDJ5l3laXTtsSHvA+SMm0E=
X-Received: by 2002:a05:6830:3691:b0:727:3111:1416 with SMTP id
 46e09a7af769-72e70a86f4cmr2491038a34.24.1744219878187; Wed, 09 Apr 2025
 10:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-temp-v1-1-9a391d8c60fd@chromium.org>
In-Reply-To: <20250409-temp-v1-1-9a391d8c60fd@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 19:31:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ixiiSiGvc_8D8YxK22yKOAzkdrNaMNjydOHD7gQVc9tQ@mail.gmail.com>
X-Gm-Features: ATxdqUExT1IilYd9Zre-BtZH4MzFK1pPUNA-4K543ua8c6G3QCNNI1bQ2sg9oYA
Message-ID: <CAJZ5v0ixiiSiGvc_8D8YxK22yKOAzkdrNaMNjydOHD7gQVc9tQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: sysfs: Return ENODATA instead of EAGAIN for reads
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 11:13=E2=80=AFAM Hsin-Te Yuan <yuanhsinte@chromium.o=
rg> wrote:
>
> When userspace nonblocking reads temperature via sysfs, EAGAIN error
> returned by thermal driver will confuse user from the usual meaning of
> EAGAIN, the read would block.

Why would it block?

> Change to throw ENODATA instead of EAGAIN to userspace.

Casting error codes tends to be confusing.

> Also, ENODATA more accurately reflects that data is not currently availab=
le.

It means something else, "try again" vs "no data available (possibly at all=
)".

The error code comes from the thermal driver and if it wants to say
"try again" then this is what it wants to say.

> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
>  drivers/thermal/thermal_sysfs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sy=
sfs.c
> index 24b9055a0b6c515b865e0d7e2db1d0de176ff767..3d1713e053dfb867933d95131=
f1f2491d2ecd07e 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -40,8 +40,11 @@ temp_show(struct device *dev, struct device_attribute =
*attr, char *buf)
>
>         ret =3D thermal_zone_get_temp(tz, &temperature);
>
> -       if (ret)
> +       if (ret) {
> +               if (ret =3D=3D -EAGAIN)
> +                       return -ENODATA;
>                 return ret;
> +       }
>
>         return sprintf(buf, "%d\n", temperature);
>  }
>
> ---
> base-commit: a24588245776dafc227243a01bfbeb8a59bafba9
> change-id: 20250409-temp-6ebd13ad0dbd
>
> Best regards,
> --
> Hsin-Te Yuan <yuanhsinte@chromium.org>
>
>

