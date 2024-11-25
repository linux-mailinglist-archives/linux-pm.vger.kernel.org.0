Return-Path: <linux-pm+bounces-18071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 333CE9D87A0
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64B1162C0D
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D9B1D5175;
	Mon, 25 Nov 2024 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNxPid+1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7C81D5172;
	Mon, 25 Nov 2024 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543884; cv=none; b=XxxglhMyKRsZJNBZiqNXTzbFmi9QaIKB8rUVEU5342t7XRDVrQQxc5IO0EeXP9+edfiouhrKHaVSDAWQFTTWI1Wn3/HEWdleQTayxpeaW+i6c1uwOgowDnyDjt5SgtHL3C7cC9mjCjC/YzSaepTnHzPIGToHtN2Kg5p9rYUfpJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543884; c=relaxed/simple;
	bh=2xTc35I6thzQLxndB6Oqp6UXDYaoWGlcGj/Q4rqRyds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9Zcm1Ku6FfrVZyquyWDQKSwQdmivMmKs4vS8MStbj3JZCv8lVC4N6aI4HEzmtRdscNBM0NCodTPZQtYbin8c9Wtu88HecGtD9uuHXuPCruSNJ5cPGNJEPJsO6EHgH/fCTaXorLj6Wd0kY9Ivdzi1S8BglTB4qTemGGvQovtcXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNxPid+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4B6C4CED2;
	Mon, 25 Nov 2024 14:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543884;
	bh=2xTc35I6thzQLxndB6Oqp6UXDYaoWGlcGj/Q4rqRyds=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kNxPid+1cVN0fi4x18puBFX/Ao+jSFRpjzyLpet6Hu5zUoEt2PuTfU5NfQEF/6YUR
	 ITmRDFA3qzr/+3Xv4mne6nogx5Jpe58iZ5dFIUgDpUgxWR2u5Q9p5WkmqOngIxqhIc
	 wr5gpmJLJRGQvJJGyLKGz/9j0lRaqCq+dZ7xUp/A5jXBhrKzZ5SGyOsF9cXVtFYWxg
	 8RZU64iBnI0ifR6PQlt4dxe4IqpxRtiQCDf8LZguOBKc76L1BQMrLep9L5K0p9I2Et
	 jnCBKUzNKIIOucS6bxixYMTIfaUQKxhZwKhBkfKZnh+7YtXZpcFKBZpxLWLCwnxOh/
	 xq1FQi8n+E/Pw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2689e7a941fso2614668fac.3;
        Mon, 25 Nov 2024 06:11:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCHR229XhPFOEorOD7YoFVSlqHF/Eusij7X6zupid8yy5D1HX5E640Q0j+AwmRAKrxoM15xMHb@vger.kernel.org, AJvYcCWxbLUmqkTpLacybNvnxkDdEBv3wJ7zGJ3gCaihM/15oalLAIHYBe/3zO1F5jDhEe8VYvO67WRk3ZKpH/c=@vger.kernel.org, AJvYcCXnlEZ3ZhdhcP9qBS6BzLnd67qjceIeBpI6mXeoPbBiepStr3vp6d37lOl6rzPOlDKKser3AY2u40w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSoW9fJQkjOMND8fg2qTdirixqGKXJFxvCZyeBo2/3kKD37SFK
	dleZSfsGSuEOKDmM5Q/pUrdUp/t8Pj+gatJqLxKoP5/uoZ4izxubwK/UtJkafk3oymOGgGdmQGX
	E3uuwDVOscr3T+HV83NqIVoMl4rA=
X-Google-Smtp-Source: AGHT+IHwD0ONTDAPv/44fpKZqgmGDncHi5ACNYkjLPoiuWZk/rrHR1ziCylC8yybGghptvN1cpM6MEjbHYmnAhl1/x4=
X-Received: by 2002:a05:6870:b153:b0:295:ed17:3ec0 with SMTP id
 586e51a60fabf-29720c5dee4mr9676711fac.24.1732543883562; Mon, 25 Nov 2024
 06:11:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114200213.422303-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20241114200213.422303-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Nov 2024 15:11:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hcqw37cVT4Hd2f8Rv-HEnZX=+N+2zR0hGhDD9nPxJ2zA@mail.gmail.com>
Message-ID: <CAJZ5v0hcqw37cVT4Hd2f8Rv-HEnZX=+N+2zR0hGhDD9nPxJ2zA@mail.gmail.com>
Subject: Re: [PATCH] thermal: int3400: Fix display of current_uuid for active policy
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 4:42=E2=80=AFAM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> When the current_uuid attribute is set to active policy UUID, reading
> back the same attribute is displaying uuid as "INVALID" instead of active
> policy UUID on some platforms before Ice Lake.
>
> In platforms before Ice Lake, firmware provides list of supported thermal
> policies. In this case user space can select any of the supported thermal
> policy via a write to attribute "current_uuid".
>
> With the 'commit c7ff29763989 ("thermal: int340x: Update OS policy
> capability handshake")', OS policy handshake is updated to support
> Ice Lake and later platforms. But this treated priv->current_uuid_index=
=3D0
> as invalid. This priv->current_uuid_index=3D0 is for active policy.
> Only priv->current_uuid_index=3D-1 is invalid.
>
> Fix this issue by treating priv->current_uuid_index=3D0 as valid.
>
> Fixes: c7ff29763989 ("thermal: int340x: Update OS policy capability hands=
hake")
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> CC: stable@vger.kernel.org # 5.18+
> ---
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/dr=
ivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index b0c0f0ffdcb0..f547d386ae80 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -137,7 +137,7 @@ static ssize_t current_uuid_show(struct device *dev,
>         struct int3400_thermal_priv *priv =3D dev_get_drvdata(dev);
>         int i, length =3D 0;
>
> -       if (priv->current_uuid_index > 0)
> +       if (priv->current_uuid_index >=3D 0)
>                 return sprintf(buf, "%s\n",
>                                int3400_thermal_uuids[priv->current_uuid_i=
ndex]);
>
> --

Applied as 6.13-rc material, thanks!

