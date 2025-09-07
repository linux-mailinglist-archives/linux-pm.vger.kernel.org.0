Return-Path: <linux-pm+bounces-34106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE55B47B39
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 14:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F78189BBF1
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 12:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257F3262D0C;
	Sun,  7 Sep 2025 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eA8lNtjT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014B323C8A0
	for <linux-pm@vger.kernel.org>; Sun,  7 Sep 2025 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757247536; cv=none; b=Zi9VeRTIHSgFKpKvicaNTyXKdZF7jsEuIc1vBer9athdHX44h7fWiWVLkc58lwiRRBNzEPDdJ3lZbv89FjOw1BxfThUtSSTSJi1Xb7k7Ah+a3LIE6ZLB/fgMIzM7E/xLnULc6kvkNodQeMjb63HBcPPmKAiZneLFHg21Fl3HPkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757247536; c=relaxed/simple;
	bh=VMcolvRnv2ySwj1t9qCMocoqfo7oalvhv07Toabmu88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTl/qzblITVWbBXTGxBCHkJiijkLnHbMWU3EFmUiKmIicQfV2HrV1NGAxGLg7537dKab/SG8vJPcavApGhi4oj29SnQsUzQwbyYLBLJnxCKKOR0DS1xbEN2J0yr8nMK7nrFrJaL1QgiuBv/9AZ7HnmyFxUOHEAoIPL/7reLk7MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eA8lNtjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8212DC4CEF8
	for <linux-pm@vger.kernel.org>; Sun,  7 Sep 2025 12:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757247535;
	bh=VMcolvRnv2ySwj1t9qCMocoqfo7oalvhv07Toabmu88=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eA8lNtjTFOYW/RbaFqrjWUPtPdVP9PFX5a0rXZcvM0LRwupjAPFKSMu3kgBZO0SOg
	 mqnTkDhJDf2IJHScjJThi7te9ekEYSyXjCv0y39Yly/LJIHF8Rzsf/uO1sRTF0Y5p3
	 nuaHraH9M990XtAilxGzJBY7nRLg6kANRspnsl3J/9a/OZL/Y4a82oWCzSsTVO3wkj
	 H3h0Bdp2HtUKxPupdlskXn4be1OQqXAelGi3knk3+BUXxsLfdEW5HWsyXx1JLwOEAA
	 uRuWNWE4xWs1SyVcJgH730Is6v7OuhYqmQysGjoHFfIeRtRKUKOs8tBGbp9Bi4gohj
	 HV/2VpEPFDn/A==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-61e74e59d8fso1552665eaf.0
        for <linux-pm@vger.kernel.org>; Sun, 07 Sep 2025 05:18:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZIoVA0EBrKAQiG1rnEi8cg2GP42a/2oyaU5MEKwWmUOVEo/L/xZ8qrElNmjFlSO5DAHcjvPoDyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+rfk8FT2tI3ZfxF2/dJE0ouGa654S6Z4YvA0rI48zYrNnUhP
	KKoGMTua1a+qFm5BcozAJhezJRA5S0zAkQ8nhnDEKNCtmWSaKhbJxECFilkyH+8xA5rIhsxRYKV
	EAgDkbAIDeJvWZuusNPy+j+4n55kgc2s=
X-Google-Smtp-Source: AGHT+IHl2OY8EiSPU85z1jl2ZMBcZTE1MRWtLCcojkYDt1BV5DCk2SqybEkFKG/rxT3x5Qg4ZUfLJ51teGaVt8MqpKI=
X-Received: by 2002:a05:6820:2adc:b0:61e:68b9:cb0d with SMTP id
 006d021491bc7-61ff9051c1fmr3961607eaf.0.1757247534922; Sun, 07 Sep 2025
 05:18:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907113302.3353584-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20250907113302.3353584-1-kaushlendra.kumar@intel.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Sun, 7 Sep 2025 21:18:17 +0900
X-Gmail-Original-Message-ID: <CAGTfZH3asUpV6HGW3EJohvzoydraty4W62t=1Ugpy1OOUFnfuQ@mail.gmail.com>
X-Gm-Features: Ac12FXzEhQmkieaEURjf1nsdtg3T2O5scoSN3fsNNSVOzx5C12HXWsW_IS3_4y0
Message-ID: <CAGTfZH3asUpV6HGW3EJohvzoydraty4W62t=1Ugpy1OOUFnfuQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM / devfreq: Fix memory leak in devfreq_event_add_edev()
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Applied it. Thanks.

On Sun, Sep 7, 2025 at 8:34=E2=80=AFPM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Add missing kfree() call to prevent memory leak when device_register()
> fails in devfreq_event_add_edev(). The allocated edev structure was not
> being freed in the error path, causing a memory leak.
>
> When device_register() fails, the edev structure allocated earlier in
> the function needs to be freed before calling put_device() to avoid
> leaking memory.
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
> Changes in v2:
> - moved kfree after put_device based on review feedback
> ---
>  drivers/devfreq/devfreq-event.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-ev=
ent.c
> index 70219099c604..34406c52b845 100644
> --- a/drivers/devfreq/devfreq-event.c
> +++ b/drivers/devfreq/devfreq-event.c
> @@ -328,6 +328,7 @@ struct devfreq_event_dev *devfreq_event_add_edev(stru=
ct device *dev,
>         ret =3D device_register(&edev->dev);
>         if (ret < 0) {
>                 put_device(&edev->dev);
> +               kfree(edev);
>                 return ERR_PTR(ret);
>         }
>         dev_set_drvdata(&edev->dev, edev);
> --
> 2.34.1
>
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

