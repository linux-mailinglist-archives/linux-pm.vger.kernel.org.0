Return-Path: <linux-pm+bounces-34103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3DBB47A3E
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 11:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B99427AD37D
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 09:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC25221554;
	Sun,  7 Sep 2025 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/0JXwJ9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4E41C8606
	for <linux-pm@vger.kernel.org>; Sun,  7 Sep 2025 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757238418; cv=none; b=BqDIBZd4vW5CAw1vz8rWMGwnIQFi96Kkxqrg99RogSKBflMVyEcdvEeW7O8KXOrZNY+IQcddA1n3v315dJF5C0wllB4cNQbmyXTNeGamJivzEbLSLcHUjClutiX2oSa1vv8ZnjWDzU+vqd8eYOpeCxyB+UabNJoCEmT7beTCRaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757238418; c=relaxed/simple;
	bh=Qf7jeC/zsIcbJUV9qMCuo5yFMGr09d0Q4hRuCIv5+XU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m558g4+2Gxp+CLaHOoj2jE/I+/hUWf4Wgem04lyksCcZrzcwdDcvEGJv1dtwhVqqY31gD4mQALku0jtPclO5zS7oYeVBWnzXyCgudcB3xi6/RulMsJ3K02Qrvw5vFnZlNd61UvAjKfntHjkbqs67xJlWGxyCy9uloxtGVu9+nnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/0JXwJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64505C4CEFA
	for <linux-pm@vger.kernel.org>; Sun,  7 Sep 2025 09:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757238417;
	bh=Qf7jeC/zsIcbJUV9qMCuo5yFMGr09d0Q4hRuCIv5+XU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G/0JXwJ9zNYePZNqHU6sm6P62Um/wiXmURdBjHV6tzHSu9DNGyeLV94NJJnoUumBB
	 J8YuPtrDp5fVjaf3+SJbenPN2HmelO4pjFKKKYB4+oFI8x4z8J9he85mkAI9hMeZWp
	 i/RcVb/B70wQ6QZsexk+7D7vNWEDqEVXoqCM3THxESeiflbiBMug11xxvwdxfmpJrV
	 zx4LqFpSC0kGz9U6ypQvGWRE1iMiE1bLjxuSzYxMGK0I9IAkvZjpKnhrqELG9fBDFp
	 Ob308TRvZBezHM+j9I7qFQ8/x/39voiGJs2JUXXp+FTc46rveuMvX2lz6YqaF8yeXC
	 9CvzLBiPu+7Vw==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-61bc52fd7a4so3575843eaf.0
        for <linux-pm@vger.kernel.org>; Sun, 07 Sep 2025 02:46:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXaorQiGJaBn/W0ODMaBfnISIPgWgspCyIFZhxAJaysDDq8IQNj1dAwP9L5qDnDF/HrKqsWNHsiLg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Wdb4jd/IAAPtgvR72FgOtROEEWDfJs+f9tW1LGzPfQYYzMD+
	BLWxYiC5C4h3wLmVs9SyeYGnqztfA6kCxcBGv6gaRJ3pnWMr5+1lSQsModeE3M2cFBYmlKqNT5v
	UvhuFlLVP7MTj5WvPfFd8iUQ2RTPiaLU=
X-Google-Smtp-Source: AGHT+IH60PWrGls7gEsxGA6QKeZRjM1/Yr5loLfKIoClOsf75oeEu8Xlqt3SUcRTFF8Y2Y75knoahvTKAAV2PXvKW/o=
X-Received: by 2002:a05:6820:498e:b0:61b:f98a:2f19 with SMTP id
 006d021491bc7-61ff9607385mr3508858eaf.2.1757238416764; Sun, 07 Sep 2025
 02:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907085942.3278910-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20250907085942.3278910-1-kaushlendra.kumar@intel.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Sun, 7 Sep 2025 18:46:19 +0900
X-Gmail-Original-Message-ID: <CAGTfZH12WSf0osq__7LGnNe9tsmC-+G1HPfJgY6j2eTmXAT_nQ@mail.gmail.com>
X-Gm-Features: Ac12FXz080nd73ILKbAempbiTDYSQL2EogFFOecdpTXVimTWCTiAuzFsAwCGXcE
Message-ID: <CAGTfZH12WSf0osq__7LGnNe9tsmC-+G1HPfJgY6j2eTmXAT_nQ@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: Fix memory leak in devfreq_event_add_edev()
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Sep 7, 2025 at 6:01=E2=80=AFPM Kaushlendra Kumar
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
>  drivers/devfreq/devfreq-event.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-ev=
ent.c
> index 70219099c604..f0e7c31fac5e 100644
> --- a/drivers/devfreq/devfreq-event.c
> +++ b/drivers/devfreq/devfreq-event.c
> @@ -327,6 +327,7 @@ struct devfreq_event_dev *devfreq_event_add_edev(stru=
ct device *dev,
>         dev_set_name(&edev->dev, "event%d", atomic_inc_return(&event_no))=
;
>         ret =3D device_register(&edev->dev);
>         if (ret < 0) {
> +               kfree(edev);
>                 put_device(&edev->dev);

I think that kfree(edev) should be executed after put_device(&edev->dev);.

>                 return ERR_PTR(ret);
>         }
> --
> 2.34.1
>
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

