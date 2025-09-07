Return-Path: <linux-pm+bounces-34098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7B8B47893
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 03:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAFF1885DDA
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 01:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B9D17BED0;
	Sun,  7 Sep 2025 01:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txGJve11"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D861096F;
	Sun,  7 Sep 2025 01:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757208896; cv=none; b=VY3dt5dW9bIKKZJfUBo9c8kSobkYYSWhWfe1Gg+jlDS9ltwwI9T5Jr2XrYuhl7mte3e96nRHDRedE0lWqKL81n2rvqhkwk5NBo1AUQfoBt79q7EI9MpRuq3NHxXDTDiNBflTRgjeID4PRpWvO+ZRFj9CIKMWAw0y/B62Wwb3C+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757208896; c=relaxed/simple;
	bh=YvrMVck9GuxvJbknpdd53Wuad3w7da3ygVsD0daNaFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHwEo+0SLVhW/hYpDgI0yV0LX+4wSacRb5iip2OipMpbyt4TI4OyU1Nrbx0c+pkpE/4i7K9i0lTBpxGx+4D0htJRyJXfrcDMHGtYYgY3XAes4M3f9sTZQD2okn6P7x+e1poG8zaj+pNUHvhV7qgVxk6g/HBLYpuN7wEi+uzHpK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txGJve11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF0DC4CEF8;
	Sun,  7 Sep 2025 01:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757208895;
	bh=YvrMVck9GuxvJbknpdd53Wuad3w7da3ygVsD0daNaFU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=txGJve11Mwh7eufsDkQ6YhkkhUh94pIrBGtVPdAnzbntW7hbiIXW4e8lPUKfm/P4t
	 Ml4xYGAuWZVSAUUylGknI1s46OjUfeZOuamp7JzzDncBM34j/kLEJiwrDI7LwNbQeJ
	 1XBKGX0Omk9dGHrd+i92FDg/DqysEHCnGK+Qy4sqQ2wkJLLeQMmMQQOksYilVqKn2J
	 9OCNaJvKGaFYlJh9QuLngXCZ4zI6Jmif1VNlqsSnzAB2CemiVXVfZ2aqOPR0AJ3mhI
	 0EBxBw0U6QTOUxWywc1vfid0FLjiZ7+sHg5KwWTO36jVcUjKmrMaDQoBnSsDZixuX9
	 sXaXf2Pipopug==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-322f0a39794so153477fac.2;
        Sat, 06 Sep 2025 18:34:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSI7ElHoaKstW4pq+wjeMBfKE211i3cdznAf7z125bEU5I3pdyjS5RJfYkTx0srDsEguitjABVuW0wvK8=@vger.kernel.org, AJvYcCXJNNyhqb1Hqm6ShG48XS3KKnnBV8hEmFDqSHCqWOYkxrAXpu0CNPm1a5CVlrS8yKn4H7USIncYvSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqCvyLD4P71HwHqUqkfIJ5kRZdwQIyZSe6S9foDgLKpgOImvhe
	xNISV18VsiPrmSU1I/SaLC3UgcXj/n7rFsOYhDxFeF0xMJ22l3Ge0yhhXcwp4usMb7akUcaVAK6
	L+DeGN2xOO2TqtChZfOHsCzq/Cwc+VNg=
X-Google-Smtp-Source: AGHT+IGVjcrk3nT2danIlz7M5YYs7s1I1c3e4MPWm1eVrv+/cRM7jUsuwRVAQ3f8OvC5Mf7Lx0jfXbVvOb81naROdro=
X-Received: by 2002:a05:6808:3095:b0:439:af0a:dc9e with SMTP id
 5614622812f47-43b29bed1e4mr1448155b6e.12.1757208894866; Sat, 06 Sep 2025
 18:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903121452.387023-1-liaoyuanhong@vivo.com>
In-Reply-To: <20250903121452.387023-1-liaoyuanhong@vivo.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Sun, 7 Sep 2025 10:34:16 +0900
X-Gmail-Original-Message-ID: <CAGTfZH2ch56uca-x7TLTYu3Q0q-j+1nCsSOjUV0R7XQ3XLQ7CA@mail.gmail.com>
X-Gm-Features: Ac12FXycPiT7p52rG1BVVS6XsIIvHEkvuEPHCNNS6J9fihNz-L7KMPQrOiCUex0
Message-ID: <CAGTfZH2ch56uca-x7TLTYu3Q0q-j+1nCsSOjUV0R7XQ3XLQ7CA@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: mtk-cci: avoid redundant conditions
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Applied it.

Thanks.

On Wed, Sep 3, 2025 at 9:15=E2=80=AFPM Liao Yuanhong <liaoyuanhong@vivo.com=
> wrote:
>
> While 'if (i <=3D 0) ... else if (i > 0) ...' is technically equivalent t=
o
> 'if (i <=3D 0) ... else ...', the latter is vastly easier to read because
> it avoids writing out a condition that is unnecessary. Let's drop such
> unnecessary conditions.
>
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/devfreq/mtk-cci-devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-=
devfreq.c
> index 22fe9e631f8a..693c59c8037a 100644
> --- a/drivers/devfreq/mtk-cci-devfreq.c
> +++ b/drivers/devfreq/mtk-cci-devfreq.c
> @@ -86,7 +86,7 @@ static int mtk_ccifreq_set_voltage(struct mtk_ccifreq_d=
rv *drv, int new_voltage)
>                                                       soc_data->sram_max_=
volt);
>                                 return ret;
>                         }
> -               } else if (pre_voltage > new_voltage) {
> +               } else {
>                         voltage =3D max(new_voltage,
>                                       pre_vsram - soc_data->max_volt_shif=
t);
>                         ret =3D regulator_set_voltage(drv->proc_reg, volt=
age,
> --
> 2.34.1
>
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

