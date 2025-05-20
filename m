Return-Path: <linux-pm+bounces-27428-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8593EABE2B2
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 20:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106E91BC18B6
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 18:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A765280A55;
	Tue, 20 May 2025 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KabN3m8A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32091280014;
	Tue, 20 May 2025 18:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765707; cv=none; b=hc2tYhksUdyvaqHMrzWsdqPHI7ufW5kMpZUATrK0WjmDJJamNLLI/rNO4gfyQyruMKzb4Ftg3sggRCXg6/ul19NjvE06NH/buFjuDLdMwruddEHYiFUEs5HY/IdLT2kxXIjC0Qu8Mp5yPqzN6BzXrA2xYbosGJ178M+A3OPtyHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765707; c=relaxed/simple;
	bh=Oh+ozRH8AQMk1Jb1BacF6n/ihKBHkHpapFNRAZvVOZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8AxBz+0wHRgvzvVGtvRKtlN/y9mgcFwtzgswX7G3VqQbuP3qfS0+UQ9YHCyoJ+cCr4hOatRag1S4rdlizrGDoW/sWsAiia1DsyCzRLVjWZatpIGbZWqLmK7GDWd2LaFSPeD/Nhgmq7Bw9Eyt7/9W4bQdLN/EWhl1lQNAeIw7v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KabN3m8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8C2C4CEF1;
	Tue, 20 May 2025 18:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747765706;
	bh=Oh+ozRH8AQMk1Jb1BacF6n/ihKBHkHpapFNRAZvVOZE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KabN3m8Aw3zZxEyxdGMwC47DMZNBoFV2ViaKJAhuQ/u+bW9LwBEHluK5HzwSnbftO
	 l8bkbWoCKhyP2/xCBNSa3aI73Gih/A2Z2tWg1pfz5IxMEyrA6z01NjfCnME31/uPPx
	 Elnzlw6cArDWFoUPNrTboGb4bZgGGYb7Xx9Cc/GN+Gt/kXfL25lDMXEmpfQpCCuCG2
	 hnktsG77ejE+Xumg3XN8FxnSwSeZBZAFg+pNCQ4TR7ZLJfg1vVY5dAOELpjUw4c1p/
	 gHjAvYPruYKUvH2LU+PVPrBY4JNaid8Xzv4b43/TqhptehN2DvF1NfoDTcBX84RSgY
	 /ANR4/rISguSg==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-40331f302f1so3867898b6e.2;
        Tue, 20 May 2025 11:28:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVq9MR/hxjd4TJoKpYumbqusZYMOcC3CgzjnGVcsTesMbZ3bvrsW/Qfe61+ncqtS7pWIMmJa2qEg/nAEWg=@vger.kernel.org, AJvYcCXn7U1QXiCGGjnItEHtCOMMXrCp+n56SAKatlB3k+aAnh2nwn/MqxEbcUSuHyUbaxgLDW6ue8zXLFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSbA1xUK/7dYJZoAIXxdTIkD1zyNgeRuN2dbuE8QFJaaZ+s4d6
	4twppEnmp4SEZWBJyvFgEL4GVmJzx81tGB0fXsai7ZWl3RY915Xwwsauf4vCHX0ADbTrqRTrSI3
	V415kOQs32iPEwbo7rXnrVntszR6Wo/g=
X-Google-Smtp-Source: AGHT+IHUWBgovbnQBup2K25sSKTbKau3dBTRCvED87qiec8fCfdEaJsIHLdYccrxO4AUMXP2EbznX8MOrYpB5EDpK2E=
X-Received: by 2002:a05:6808:6d0:b0:3fb:a7d0:3b1f with SMTP id
 5614622812f47-404d88a65b2mr9913404b6e.39.1747765706030; Tue, 20 May 2025
 11:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512-temp-v2-1-048be58eaaa5@chromium.org>
In-Reply-To: <20250512-temp-v2-1-048be58eaaa5@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 May 2025 20:28:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gqe2SVU3kTkb3V25kax1dyfW5HjcmJba1bcCcS-BxkdQ@mail.gmail.com>
X-Gm-Features: AX0GCFvngb3zaLTCdGMCDoQ7oil8hZwqO52U3TwhpJ_nKhx55gtiLB6nA1eCGZI
Message-ID: <CAJZ5v0gqe2SVU3kTkb3V25kax1dyfW5HjcmJba1bcCcS-BxkdQ@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: sysfs: Return ENODATA instead of EAGAIN for reads
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 7:53=E2=80=AFAM Hsin-Te Yuan <yuanhsinte@chromium.o=
rg> wrote:
>
> According to POSIX spec, EAGAIN returned by read with O_NONBLOCK set
> means the read would block. Hence, the common implementation in
> nonblocking model will poll the file when the nonblocking read returns
> EAGAIN. However, when the target file is thermal zone, this mechanism
> will totally malfunction because thermal zone doesn't implement sysfs
> notification and thus the poll will never return.
>
> For example, the read in Golang implemnts such method and sometimes
> hangs at reading some thermal zones via sysfs.
>
> Change to throw ENODATA instead of EAGAIN to userspace.
>
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
> Changes in v2:
> - Modify commit message to make it clear
> - Link to v1: https://lore.kernel.org/r/20250409-temp-v1-1-9a391d8c60fd@c=
hromium.org
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

I would prefer to do

if (ret =3D=3D -EAGAIN)
        return -ENODATA;

if (ret)
        return ret;

here or even

if (!ret)
        return sprintf(buf, "%d\n", temperature);

if (ret =3D=3D -EAGAIN)
        return -ENODATA;

return ret;

if you want to optimize for the success case.

>
>         return sprintf(buf, "%d\n", temperature);
>  }
>
> ---

