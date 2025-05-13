Return-Path: <linux-pm+bounces-27091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58554AB5B18
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 19:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CB4B7B356C
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11CF2BEC5B;
	Tue, 13 May 2025 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6jJ1uwa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795431D5CDE;
	Tue, 13 May 2025 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747156801; cv=none; b=U2xsD+pya53oeZ+OAaD+8q1uNncqZ8xiwPE4RcxAgKS3aa+sfsQWDOFaqTHN083Z6cSv1M2czzE6p1PJZjtlJE/gjPBHg89AnnH+nqUVZhokyhZvbb07U9lRj4qcIDeJx2dX6g3LkG2Ipk0omwk5ye8cZAtrbHAjMZvrItwjDWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747156801; c=relaxed/simple;
	bh=N7na6PFufzfGQKJuOuksZezPcW1F3v2kAd8IXZgLHzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gz4AFvFYM2oANZVh72OmlE814LI+lYU0WqsTj0mMx4040TzrJL04Plfof1Yd2ixFfWrx5Td/x0TPhixPSGTY3vGI6/RAa6V/xEuM7MgpRffnZ92HNVJEWak1CVcmbtql1QzoOyl0eQVBBkAozQLTkByokfR90bkwcDNTm+ENaDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6jJ1uwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C41C4CEF1;
	Tue, 13 May 2025 17:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747156800;
	bh=N7na6PFufzfGQKJuOuksZezPcW1F3v2kAd8IXZgLHzg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g6jJ1uwa8syyG9vYULiYgEapmOEFRvHxSbsHar9VK/G6rnDhnr6Ast35yWsG9nMjk
	 PVYLneOMxEZBCYnlq578xi0Hb0uRWE+mDpCDn3r3bVJilY1/m+wFhbCg/C8+aEY34Z
	 XGKg/IVTs3Kas99MatQcS/FLeJDviI4QuYKqpR25/TZjyWEiwDejzbFNUgHV0mB/QM
	 ziqzrGrR+OAyXLpES32XYfIG0me15xHXjsArf50E8qks2ugn533EevJU56/UZ3LDfY
	 3Bdw1KiUAOIlYuok3SXeEv47m2sE7AYM/h+g9SD3PYtOAvY+yH/2bg7Jp+sXBPXapl
	 Nr2kCgJILh0og==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-acb5ec407b1so1012727666b.1;
        Tue, 13 May 2025 10:20:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7z50jo4PymF+jt09jPIFWZJvV09YB5D2+yNwGhlttx7sezBB8QfABuZRPC818PpItWtxO63kQ3l+UZEY=@vger.kernel.org, AJvYcCXW4fituomUeqFfj5/fObG4HNld8gPeLw8aZ2tb/C/VbExzmC6MK7A3Na/reOxvlfWetZe7OyZI7vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMRixxXXNB19766mFpp7EkaaxIRddOPPv8u6ncJLeHvs9KLZQM
	lbHBRwy5jlyQMXybX6IaycsjjxFOmgHmvZT/Jg1YmkKPNE1UNiXdv+EK1U8DnYWM051WCYlS3Vn
	gMlDnvbCh7fj4CpGC2b5XZhJV1eE=
X-Google-Smtp-Source: AGHT+IHRAueVku/+OOa5F92B7Rfa3cSGSF3qzAN3N5HYSdsmS0DOPsI4IRLjZ085TGPBZb99BHTsKf/vRHgPm+XVNj8=
X-Received: by 2002:a17:907:d006:b0:ad4:f512:733 with SMTP id
 a640c23a62f3a-ad4f726e946mr29476566b.45.1747156799809; Tue, 13 May 2025
 10:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421030020.3108405-1-zhenglifeng1@huawei.com> <20250421030020.3108405-2-zhenglifeng1@huawei.com>
In-Reply-To: <20250421030020.3108405-2-zhenglifeng1@huawei.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Wed, 14 May 2025 02:19:23 +0900
X-Gmail-Original-Message-ID: <CAGTfZH1T+hvErU6sU-bMOiDfSSTTbt-ygOvEC42B4EaEYvy_tw@mail.gmail.com>
X-Gm-Features: AX0GCFtWGMxVVle0tG4dFX6xiKgLOM9TY0Lg3WlJ6FgGVpA1Nz1CqcVxc5IyOfc
Message-ID: <CAGTfZH1T+hvErU6sU-bMOiDfSSTTbt-ygOvEC42B4EaEYvy_tw@mail.gmail.com>
Subject: Re: [PATCH 1/4] PM / devfreq: governor: Replace sscanf() with
 kstrtoul() in set_freq_store()
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
> Replace sscanf() with kstrtoul() in set_freq_store() and check the result
> to avoid invalid input.
>
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/devfreq/governor_userspace.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/gover=
nor_userspace.c
> index d1aa6806b683..175de0c0b50e 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -9,6 +9,7 @@
>  #include <linux/slab.h>
>  #include <linux/device.h>
>  #include <linux/devfreq.h>
> +#include <linux/kstrtox.h>
>  #include <linux/pm.h>
>  #include <linux/mutex.h>
>  #include <linux/module.h>
> @@ -39,10 +40,13 @@ static ssize_t set_freq_store(struct device *dev, str=
uct device_attribute *attr,
>         unsigned long wanted;
>         int err =3D 0;
>
> +       err =3D kstrtoul(buf, 0, &wanted);
> +       if (err)
> +               return err;
> +
>         mutex_lock(&devfreq->lock);
>         data =3D devfreq->governor_data;
>
> -       sscanf(buf, "%lu", &wanted);
>         data->user_frequency =3D wanted;
>         data->valid =3D true;
>         err =3D update_devfreq(devfreq);
> --
> 2.33.0
>
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

