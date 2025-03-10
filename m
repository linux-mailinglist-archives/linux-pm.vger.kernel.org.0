Return-Path: <linux-pm+bounces-23797-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC66EA5AFA5
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 00:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16DF117154B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 23:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB852222B3;
	Mon, 10 Mar 2025 23:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDQRnl4h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59F21E0E0A;
	Mon, 10 Mar 2025 23:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741650714; cv=none; b=kFuSciFxZYT80Y+KttdkMx6eg3cfTAKaA/yqwgML2FsdG86VFDi851ddNXcmcqMHLmlWoyqd9HraovPiiMpCRoNLrdafoFKFF7NIrXfVkkOi/34zkjZKO8qHYUMMmhzTqP4dQq8yEG+pcXmJAvxMwL3sYdI3q6EpMPsU76r1Hjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741650714; c=relaxed/simple;
	bh=fqnuG4n1ZLeWPMVCoXutRFuQkEoJdtShTULuQ7AtRqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9nLfhd2VWl6M8vlm8HLFX2wRHG2SEVM/fS+blaa7TZkk0YL3JFcYQibWoPOf8pXWn9YZ5JvuGWAm0aYLLnhMd8wy0AKvXFI2Lcmbgp80APjES5vKPazuJCeL41leBz04YESyZohZp3gfXI/8gT7YeySvSW8kdkC4FlQqu7o5a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDQRnl4h; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e86b92d3b0so38208396d6.2;
        Mon, 10 Mar 2025 16:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741650711; x=1742255511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxxVGtgrzM8qlhkaDMjd8sfiXHFLuReyiy0Zxdl8BrY=;
        b=gDQRnl4ho+VVWzt/JIjaYr4LnMTfyYn5lOZFm7jK71lHj/0bB9GYBWBOJuqW28NkyV
         GPE4Vf3aYssftPeatvbn2tePz64EhW7UPUJzbNV0jj1OkHK5+dRtYneG6j08abpoyiIR
         hzGJ7HlM9dKTpQELHne2dk3C65aY/MZIWa17T9jw1POSY4wZ/mq1zDuNIEHYPrdhTQtq
         fTd7z5uHSTlc8oO+WMdDF/MYuaPBqdLrDOflvAPl0CcfhNc/zjx65jiKvlPfV1p+J45A
         Kx7yr7ITeJCIaEF9B7cwE9+fD+NyU7H43MzgRtLAbHuNLNos0c9RKDZrZ19Hq2CDNHo2
         AK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741650711; x=1742255511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxxVGtgrzM8qlhkaDMjd8sfiXHFLuReyiy0Zxdl8BrY=;
        b=VG9oEY8oMA06yEhjTkvfcOVUix4saBGB5ka1Ge1K7cN5xciCFtOaJSpT6nbBa8fNup
         0Hj8rUngjebpBk/xBUObmqtDhlJPsMh/IZHhV+ZAwOs+GzVNCWoeL7p/ifoKoNmZx/A1
         r8uIPcinayPU0hxG2YcH/9aHMQO7dAyDrrTchqn7/QA5LdNNjYGgFhkCvggHfQIS0jw2
         KCKXeZn8e33kiyrfMN4aI1hxw0bSxRIQkhobyZ0kCiQiYAIZmqe7dIM/QB2oh8qcE9hw
         2bZvvRLoyoAEvMR4XB4lim3J44Yd3aYGgTx0w11x1RNBFmrM5ZdvDMWuyEd+dyn/ukl3
         mxjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa32oHP5Kd9ce3jws1I8JwcqRNkigCYbndAiGWddG6RS1W8z5SRq8+5amcZHPCp3oBuQPZTd1BON8=@vger.kernel.org, AJvYcCUjl6wS+tGF151Wb1yNEOaZE41TK/ErMn7vsHeAeGndARbZ8ogDjU9OJie1u7rYIfTXH9ubHaRNSsA=@vger.kernel.org, AJvYcCXWnt9YHeMn6fYvIukfYzW/aVx39bnUSf+V3ajbDLKYvccX6OmAgKLhmrsaafjd4EXqkpgZJzERdD1j6MU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3pY+rsbiQbCF5DC6RQ1b6YbqPor+/pLngdGWN0hr6tMM/nSM4
	okcATt+qizFnapyTdPlQA6B0uiPjAx0cgyAnE2cFjCaez2v4rK+fTLX6SXXSKufBdj5hZOZyzUV
	9Zp1sYmbnWlG4ZWGYyoMWUtLyFz8=
X-Gm-Gg: ASbGnctqSlJLEbUM6cu2hqrHwgGa2xSQqN/7V+SVK/u1myktVdjDbnEGqSrFTHiaqA5
	qtKSNT/PbanBXVNgEsEW7K306vZbF3j/jy4SE1Al4mCsPJzAAKDqk7gmElBZ64PPrJkrS/z+bLi
	rlpnvHwR/o7qgTHGe06QehvJuIFnE=
X-Google-Smtp-Source: AGHT+IFR9c399P6QCIgAXiSyHwuxatnd+SinGlQ6G2H4ZOIE7ikS1RraIGt0rrSp3CjOm8nlWiJEnt4RahFHRk8k4T0=
X-Received: by 2002:a05:6214:262c:b0:6e8:9dc9:1c03 with SMTP id
 6a1803df08f44-6e90064d603mr215572476d6.21.1741650711708; Mon, 10 Mar 2025
 16:51:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309112114.1177361-1-lkml@antheas.dev> <20250309112114.1177361-8-lkml@antheas.dev>
In-Reply-To: <20250309112114.1177361-8-lkml@antheas.dev>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 10 Mar 2025 16:51:40 -0700
X-Gm-Features: AQ5f1JoezgHUCzfHoGUWHVPLMG0yNv1h9eqxpaxRjeeENZKz4e__h0Kr-m91hN4
Message-ID: <CAFqHKT=_fDEhqRg_JDwmFaTOmfpjfsbAMEYcumS41Lu9MXv5bA@mail.gmail.com>
Subject: Re: [PATCH v3 07/12] platform/x86: oxpec: Rename ec group to tt_toggle
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Joaquin Ignacio Aramendia <samsagax@gmail.com>, Kevin Greenberg <kdgreenberg234@protonmail.com>, 
	Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>, 
	Eileen <eileen@one-netbook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 4:21=E2=80=AFAM Antheas Kapenekakis <lkml@antheas.de=
v> wrote:
>
> Currently, the EC group is used for the turbo button. However, the next
> patch in the series adds support for the LED button in X1 devices, which
> is only applicable for X1 devices. Therefore, rename it to prepare for
> adding the second group.
>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/oxpec.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index dd6d333ebcfa..9cb024325da5 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -888,18 +888,18 @@ static const struct hwmon_channel_info * const oxp_=
platform_sensors[] =3D {
>         NULL,
>  };
>
> -static struct attribute *oxp_ec_attrs[] =3D {
> +static struct attribute *oxp_tt_toggle_attrs[] =3D {
>         &dev_attr_tt_toggle.attr,
>         NULL
>  };
>
> -static struct attribute_group oxp_ec_attribute_group =3D {
> +static struct attribute_group oxp_tt_toggle_attribute_group =3D {
>         .is_visible =3D tt_toggle_is_visible,
> -       .attrs =3D oxp_ec_attrs,
> +       .attrs =3D oxp_tt_toggle_attrs,
>  };
>
>  static const struct attribute_group *oxp_ec_groups[] =3D {
> -       &oxp_ec_attribute_group,
> +       &oxp_tt_toggle_attribute_group,
>         NULL
>  };
>
> --
> 2.48.1
>

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>

