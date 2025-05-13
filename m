Return-Path: <linux-pm+bounces-27093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFBBAB5B79
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 19:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2520A4A5B32
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 17:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673812BF3FA;
	Tue, 13 May 2025 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVyCnQsZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2C72BF3F4;
	Tue, 13 May 2025 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747158102; cv=none; b=WwAfQsB4aBGbp898a0xraWXaK6GA7OMiiZbb6oC1Sr4nq+zyOiBoCY/dw3ljd7pspWq3R7U10q0k05bAQ49NmendYdICf8NJcYvsnv3aoYO7rw+yIvQU4hdxoTInL8xn7fGo8kGT18QsoyVEQfXbw1NnZ60j1dK7BIKhhQiqbm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747158102; c=relaxed/simple;
	bh=lodSkokCzewmwBZ7sCK2KeY61Keq4Ip3p8zTSyrnqRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=su/o3Q63zXl1/mvHQYlJMo/J98USyNhgjpFJLYWTRkNXYHIb7ggsMdQIdAOKWoG629oVrcQ3ZsE+irB/rUwHi3buedUWeJBosMzKM461TqEjBISmMspRq2K/4LftpRdc8w7l4eP62op5nDwLDtxg6eVYNwg1d1fh5vyJ+Q5HM5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVyCnQsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87A6C4AF0B;
	Tue, 13 May 2025 17:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747158100;
	bh=lodSkokCzewmwBZ7sCK2KeY61Keq4Ip3p8zTSyrnqRI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QVyCnQsZ8Bn3U/HhluJ7X/wIR3YLNXoOnkKtTBPkXMyZjdMMzZ9aEbyK4tWcPLpPO
	 G6TlnUlSli/PEONGXFz8yuA/UqhzF+S3MciHY8+5LlzuBW83KEnkX5g3Z2S0xFLmGj
	 2PVtWItf8xJ9qciWTFtJU1bmbkHnFdYccgcr2y2iCYkQKxBaMCQYOVPntz4gYAOjLL
	 C1l5akkz/PKrBNZMz0FTdDR3bA5lGJEu79rz7qzblUZWv9+SE8t7f9KjtOaZRA4Lh6
	 a6vrf4fpzlIjZqVlzMuhsYN4k7fi20dpYjMM56anQH0uWe8PIjh91kUpf5z1Q6VYUU
	 OmCcdXK+SViIg==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5fbf0324faaso12008737a12.1;
        Tue, 13 May 2025 10:41:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMatZddP6uyrqMezv4E526zrlusK/GKucI4E3FRS6nJt9Jg4bzcLMDJYfZLkQ3usoNtTnQPWdPkr4=@vger.kernel.org, AJvYcCWRD11im6LND0or6f8joTm/1FAF8lJRDp2Au/8tEKaLLd4TVelqhKSiELgl8c0zEZGFmM87PYPJtx2YukU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVXKSeZ7M5lMw71HAzRiHOkXvjd92dKsnToVWMa+QAoWxErQmw
	Rl1Fidswf4PQOF45E4Kv6ovtvirLDySujGvVHgB7Pt0RwH19xtojz6xPo77gBBVm0hjRHxfkboZ
	feCqeuTeGFdP/VfnA1C20/y+HraI=
X-Google-Smtp-Source: AGHT+IENH+DF+jnveE876jSVolUoIkssdXKIEeOQFUSGCdqaulRY0XxW9T0X+ZXI0D/YtoC2RzfKKUqOAt4UHaHka3A=
X-Received: by 2002:a17:907:3906:b0:ad4:f43e:1d54 with SMTP id
 a640c23a62f3a-ad4f75535a9mr39421166b.41.1747158099662; Tue, 13 May 2025
 10:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421030020.3108405-1-zhenglifeng1@huawei.com> <20250421030020.3108405-4-zhenglifeng1@huawei.com>
In-Reply-To: <20250421030020.3108405-4-zhenglifeng1@huawei.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Wed, 14 May 2025 02:41:02 +0900
X-Gmail-Original-Message-ID: <CAGTfZH1q60p5yhgm=0r+X6=NLbjidwGdL6AB=E2LgwP3kR15Jg@mail.gmail.com>
X-Gm-Features: AX0GCFsUfnIms0i8iKVp7CnyAG7RKl8edGxbPPFDLazXT7pP1FB4X4suTJ2f1IU
Message-ID: <CAGTfZH1q60p5yhgm=0r+X6=NLbjidwGdL6AB=E2LgwP3kR15Jg@mail.gmail.com>
Subject: Re: [PATCH 3/4] PM / devfreq: Remove redundant devfreq_get_freq_range()
 calling in devfreq_add_device()
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com, cenxinghai@h-partners.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Applied it. Thanks

On Mon, Apr 21, 2025 at 12:01=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huawei.=
com> wrote:
>
> The calling of devfreq_get_freq_range() in devfreq_add_device() is
> redundant because min_freq and max_freq are never used. Remove it.
>
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/devfreq/devfreq.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 2810c84b9f8a..18e3f7e063a4 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -804,7 +804,6 @@ struct devfreq *devfreq_add_device(struct device *dev=
,
>  {
>         struct devfreq *devfreq;
>         struct devfreq_governor *governor;
> -       unsigned long min_freq, max_freq;
>         int err =3D 0;
>
>         if (!dev || !profile || !governor_name) {
> @@ -872,8 +871,6 @@ struct devfreq *devfreq_add_device(struct device *dev=
,
>                 goto err_dev;
>         }
>
> -       devfreq_get_freq_range(devfreq, &min_freq, &max_freq);
> -
>         devfreq->suspend_freq =3D dev_pm_opp_get_suspend_opp_freq(dev);
>         devfreq->opp_table =3D dev_pm_opp_get_opp_table(dev);
>         if (IS_ERR(devfreq->opp_table))
> --
> 2.33.0
>
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

