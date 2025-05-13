Return-Path: <linux-pm+bounces-27092-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73180AB5B72
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 19:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC303BD36B
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 17:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD192BE7CA;
	Tue, 13 May 2025 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICU9Bwsr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43C72BE7B8;
	Tue, 13 May 2025 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157994; cv=none; b=Q+bQas/Y3SAwtIv41ESx3AdXJTK77v8TzOTIKiV8SDegviNJx0atI2C88unCdGE43/q56rtDYkcJggO0LmJijPHG1ElMZz97gn8Zan3VIlaXkTuQ+3XGSU3aDjJP8cqICxLgwJZxxK5yCBNbVACd1wFE4VuA6F/SmpoOG8nVBfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157994; c=relaxed/simple;
	bh=JBO2B5TsA/L/+cT743TpVRtjxPkZzQj3g9iV6SmgWdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulVkuKD0VWUm0fIW7ANhiXi4WW8nuhVHNaYsUdh5bUUbrSvofjDrPdh7NtFQJLroRnszK2N3yYT56AQVMAVc3Ay5SwT2nEVAtpwfL9I//wa9lj4gNWVWYsz+XkbUra1s8wSp1juSyWqJx4x9Tp83WyAm+oHg/d+DUzvS+CYhUSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICU9Bwsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F131C4CEEF;
	Tue, 13 May 2025 17:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747157994;
	bh=JBO2B5TsA/L/+cT743TpVRtjxPkZzQj3g9iV6SmgWdU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ICU9BwsrkBrWF9miapRGUzk4Op3TI2eFx9bvawrI1BbnAGaaqJSzaTDUHBzLMgrBE
	 0dS2fuAjBAoAFPg+UdmOPLdU8pSKNJ5DiuN1B6q9BrdiQkytjP1jCWm8SMWGDYV+AH
	 eFXPdXeg4hpjiy3YXtZbIS6XYNCbUVyHsZwX6HhjyjWGzsAUYGQJZF4ohkVBe6+GEZ
	 Q/2sbroNDjn+TRk56DZmimIzFtNb+9ko0sNazsQeZygousU6BR5PfkaTdgZ9Th91pi
	 csVnDR4yJALC83b1Q59z5mdAM0hKqkQOU1qxGXTYPnurzZztQSUmMxZ6MSMiXwVvJg
	 jo3t+BLKSAEuQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f5bef591d6so12375238a12.1;
        Tue, 13 May 2025 10:39:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUiwnEGuPTz76lzArcK+XmWa8wbtfP/yGFz5CfdMOmOdgqX7b9s33nMPj6erAfoRFIMGI6l8fKFafM=@vger.kernel.org, AJvYcCXFpguxo8aElipOLD6FWnv7QOJCNqYdOm4K+QEoyh/yuwlheDeXIqUeCnlk8QqQIA/q/edInN7XR5/CxJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAKRNE4beQ5hv6b97VyeJb7WJ/Jrn475ZwyDQ/A8NMBLw/O9Z9
	+eNizQLy84awPySXfjNqANVNEeX8nGo1hlBH2lWqBXGt97Xt8CtD3FSakZRdPsv7LQ+HFogJ/I6
	vgTQcgsRelOow5ZbRn0QMoIUmk7I=
X-Google-Smtp-Source: AGHT+IGWyrCNV45055zfuZ/3xIJ/yyJb5GmdMzMjElfcOOsmbymHqModFVVA/oMQQmd4ODkorO8kcqIIENhXcbuGs7s=
X-Received: by 2002:a17:907:d084:b0:ad2:5525:f28e with SMTP id
 a640c23a62f3a-ad4f747d6d8mr46163266b.39.1747157993157; Tue, 13 May 2025
 10:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421030020.3108405-1-zhenglifeng1@huawei.com> <20250421030020.3108405-3-zhenglifeng1@huawei.com>
In-Reply-To: <20250421030020.3108405-3-zhenglifeng1@huawei.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Wed, 14 May 2025 02:39:15 +0900
X-Gmail-Original-Message-ID: <CAGTfZH1-CRv-7Uf-vSqocC_QZQ4HRXOV9OyP_LJie3g3KcczSw@mail.gmail.com>
X-Gm-Features: AX0GCFvOtAQ6ppkOqqnywQzE-DGYzkrp9_WXdL5pO8TqcK7IIfxro6X41AcFS6A
Message-ID: <CAGTfZH1-CRv-7Uf-vSqocC_QZQ4HRXOV9OyP_LJie3g3KcczSw@mail.gmail.com>
Subject: Re: [PATCH 2/4] PM / devfreq: Limit max_freq with scaling_min_freq
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com, cenxinghai@h-partners.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Applied it. Thanks.

On Mon, Apr 21, 2025 at 12:00=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huawei.=
com> wrote:
>
> Limit max_freq in devfreq_get_freq_range() with scaling_min_freq to avoid
> showing an unreachable freq when reading it.
>
> Use macro clamp to simplify code.
>
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/devfreq/devfreq.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 98657d3b9435..2810c84b9f8a 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -152,11 +152,8 @@ void devfreq_get_freq_range(struct devfreq *devfreq,
>                                 (unsigned long)HZ_PER_KHZ * qos_max_freq)=
;
>
>         /* Apply constraints from OPP interface */
> -       *min_freq =3D max(*min_freq, devfreq->scaling_min_freq);
> -       *max_freq =3D min(*max_freq, devfreq->scaling_max_freq);
> -
> -       if (*min_freq > *max_freq)
> -               *min_freq =3D *max_freq;
> +       *max_freq =3D clamp(*max_freq, devfreq->scaling_min_freq, devfreq=
->scaling_max_freq);
> +       *min_freq =3D clamp(*min_freq, devfreq->scaling_min_freq, *max_fr=
eq);
>  }
>  EXPORT_SYMBOL(devfreq_get_freq_range);
>
> --
> 2.33.0
>
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

