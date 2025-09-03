Return-Path: <linux-pm+bounces-33705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E596B41DA9
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 13:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C156841EA
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 11:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BEC2FE04C;
	Wed,  3 Sep 2025 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikEzl/oV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8D32FE044;
	Wed,  3 Sep 2025 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900217; cv=none; b=eZpvIuK5ZDU6/Uj/zAwbEWusjWiA999l/4pkc3k3DNA+tv2wrVbKrnvlW3it5Dzk4GDyMWs9CQVzZhBEOrc2I9f47jsHOpwH64jztxdxV9yIVsofHI/COUtNL5JZJa5wQu7tmaDeL3kYIE5XiwVjWsr1noJeTUEMA/p1tq7B0tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900217; c=relaxed/simple;
	bh=g8cSCksMiFRdd3kaqAZZD/Yf8G2DEiQkW0g81nzDkEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBsGq8ka8yrGIJffXKQo0RgPwkQvixwJgKVfMVG3cGLkfccJAPqShXIargUVe4yuTeUpT+XeBiDCB21+h6ZzogXG14Ai4urxX9lFh8iFiJh/fAM+3N8TtT+lD0Qfatqu6mcCE6lowYU7/QGII/+KFs9Ixzb3ZjxwI3szpodGqO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikEzl/oV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D53C4CEF1;
	Wed,  3 Sep 2025 11:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756900216;
	bh=g8cSCksMiFRdd3kaqAZZD/Yf8G2DEiQkW0g81nzDkEQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ikEzl/oVG7SjwQYCSr3E0c6yIUj748Nz9q8efTciaxAkWiLt6hxSXX+1b8NiNef1i
	 +ttRwc6GH36hmjvtGoPXZ1rrj7ZYPXjkZAOvjDbXA38/vqnNFTZZyHcydEAhczd1dk
	 eae/uDXwuYo9ZLkI9Sn/PS9MZWcH2lDUr0wrKbDg9Y0K06soyV1Vak8eyq0r/OEuU4
	 5Lb210K5ImSftUZvI5UUYvDqR5RRi1lqJDaj+vCkJGY3Yh+XJka+2Dz+pMlnCSscBV
	 fwk6GfMP2X9Riq2dH1gt1kG7FXeheFOEhNcoaEcRteVqeDJoO4AmNR3XyFYVPiEOgs
	 3hLAZu6HAYxcg==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-61e74e59d8fso96438eaf.0;
        Wed, 03 Sep 2025 04:50:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULZhgEZXInaVjqoTJNw8GHKaDP13oyrK6C0yJE/n+3l+WRLW7hqTGLl95FzWdhkegnOSRn4GSMUcb+7ig=@vger.kernel.org, AJvYcCX0Vog0snhv+GOu1qAwBNP/6o9N4SflywHzcMg6k70o7CFTQVZugG8+Hb1golFsIlPP6UQ1l5He3hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl2t6GZ/UJtIcZIi4BdYHQWL+3HJfxOPKmvMh20aNidT3D+mqz
	MPmoS6r8uFbqV7i56nNhmLXTRgqw4ulADgqfQ4/SZU3Dn/KRnES2vcsPOX1w/SMLkELwxhQ23t/
	2FjCACi5DtagUuU4UkotYOp0F4MdRogI=
X-Google-Smtp-Source: AGHT+IEAqTInf7oxJtJigJAbEJDLppnFHfvzqfeDApkXrYbyYRvgoByVqKsx/aoivsowIrrBQetTFC7gYvPPXYp22tU=
X-Received: by 2002:a05:6820:1c99:b0:61b:fc6d:91a2 with SMTP id
 006d021491bc7-61e335b8deemr7971427eaf.1.1756900216173; Wed, 03 Sep 2025
 04:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901150653.166978-1-osama.abdelkader@gmail.com>
In-Reply-To: <20250901150653.166978-1-osama.abdelkader@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Sep 2025 13:50:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hrKBNxDeZOKpUXyuZV7LRUX4ov4ifEGDtNMrA8km6uOA@mail.gmail.com>
X-Gm-Features: Ac12FXwx2RN7aMtZi43RRX4aZSxR3MFUR6KJllhYkeysIebSDbYym_nKzc394T8
Message-ID: <CAJZ5v0hrKBNxDeZOKpUXyuZV7LRUX4ov4ifEGDtNMrA8km6uOA@mail.gmail.com>
Subject: Re: [PATCH] thermal: hwmon: replace deprecated strcpy() with strscpy()
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 5:06=E2=80=AFPM Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:
>
> strcpy() is deprecated; use strscpy() instead.

So why is it better to use strscpy() in this particular case?

> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/thermal/thermal_hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hw=
mon.c
> index 0ecccd4d8556..64cc3ab949fe 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -96,7 +96,7 @@ thermal_hwmon_lookup_by_type(const struct thermal_zone_=
device *tz)
>
>         mutex_lock(&thermal_hwmon_list_lock);
>         list_for_each_entry(hwmon, &thermal_hwmon_list, node) {
> -               strcpy(type, tz->type);
> +               strscpy(type, tz->type);
>                 strreplace(type, '-', '_');
>                 if (!strcmp(hwmon->type, type)) {
>                         mutex_unlock(&thermal_hwmon_list_lock);
> --
> 2.43.0
>

