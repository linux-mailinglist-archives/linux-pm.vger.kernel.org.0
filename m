Return-Path: <linux-pm+bounces-27094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D542AB5B89
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 19:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25AC64673EA
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 17:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0B82BF3EA;
	Tue, 13 May 2025 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hb9msAFl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42742BF3DD;
	Tue, 13 May 2025 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747158272; cv=none; b=sIlBJbUMoiC9YKPc7pijpvXXi6h1/6lSgI0E6/N1ceRD+6xTO8ZH7DtcKJe1WESCCftCWkf3drVsZwXrmJ/uEneanYNDdA0PxKfp/AZffbd0X1108ct2s3xoQuEcTgfixpJthEpuNdHMV/eWWVZcHge7uhitN2giwyZLKMx8JmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747158272; c=relaxed/simple;
	bh=ek/ek1r2leg10fKYqskkfY6Yj/yFydq6VLXELxcG3cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNQ83fSAukmSBdRUXzdffE6TBwJ/J+90kYV7pBmdeDUYYHJV4fZwZ8DVdlVI3k0zA8nWTPf2eKT9oAYkasEvJ1cGPNFk5zOz0F59jhQomBGi1rh80fxF5Sh7RhKWrJC/DaGNxV0LPRv2aJVzOBsX0Q1DSXdqx0wKZkrvmYAE8gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hb9msAFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6D6C4AF0C;
	Tue, 13 May 2025 17:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747158271;
	bh=ek/ek1r2leg10fKYqskkfY6Yj/yFydq6VLXELxcG3cM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Hb9msAFl6NrL8AU8hOKAAHbNDtJPY/QWQ6EZQFcff79HgTlXUYya300SHVpELpfWs
	 OEiXHG2Yc3G0tAT1DgF78qmwMO2yQ9HtPpb1xlx1xjvG/RgIAMUA2TQLbAxzSKULw3
	 sZb1rJthzDstc2gm/ot0IiI8PkXOfXxOuZCqtLS4sEAspf3tK5FdSaH4cfXugrfw75
	 N0iKPdELzVIEu8YA+jlYz1NYRFGPyy72WcoEozqOMjjG36BrsQCcFu0UYhMDkUITO9
	 NUya2tm1XfvIHPNrSKxTAE/Ty261ys1HraBc4ex/olEyHSy4yD/BqVilo6dKhHCJyW
	 JCFrZqnpvmWKQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso981930166b.3;
        Tue, 13 May 2025 10:44:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVc0X3V0wLLtMoljP5oqpM34hrhjQntnk0y8w1YurlZRfwmb5z+xgW4pCK64UfiaU047cE6WGdHl6/P6YQ=@vger.kernel.org, AJvYcCXLGVJCpzb2pEgMf5WE4edNGSufDbDdX5cUHkUsyYQMS/qVlqtHE5nUK6NkuRVuAWRuAZilNUC+zbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YySSTGGmBlXQx959n7Mk4VlddPGOK9kvtWa3h1VcXdVcN2QXp8L
	Fo8bNsImAIjE05At94e+cZgSOiZcDzLjm008pwdyyqfCl3TIt6Aujcti0jcqtrTRi4a6hW158ZA
	5FzbgiEK17LWaeY/llC3EGm/dyYQ=
X-Google-Smtp-Source: AGHT+IGDQg2/ujaYsgeIkkaUImBCSETDe0uxi7H0F8V5A4SxiHphFNgm4sYVZzdAuDNFNZD0hBPBiLaFo1+Y6vQ/Wac=
X-Received: by 2002:a17:907:d084:b0:ad2:5525:f28e with SMTP id
 a640c23a62f3a-ad4f747d6d8mr47541766b.39.1747158270281; Tue, 13 May 2025
 10:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421030020.3108405-1-zhenglifeng1@huawei.com> <20250421030020.3108405-5-zhenglifeng1@huawei.com>
In-Reply-To: <20250421030020.3108405-5-zhenglifeng1@huawei.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Wed, 14 May 2025 02:43:53 +0900
X-Gmail-Original-Message-ID: <CAGTfZH0jQ7j7_u=tMpe32n8RzG5sZk7ze5vOAnkbh5mxmba_EA@mail.gmail.com>
X-Gm-Features: AX0GCFsYuHefu24yCGMbtOC4XVMd5C6H5-X36XgniCWk0nDXE5z013xpWuu-8Jk
Message-ID: <CAGTfZH0jQ7j7_u=tMpe32n8RzG5sZk7ze5vOAnkbh5mxmba_EA@mail.gmail.com>
Subject: Re: [PATCH 4/4] PM / devfreq: Check governor before using governor->name
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com, cenxinghai@h-partners.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Applied it. Thanks.

On Mon, Apr 21, 2025 at 12:01=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huawei.=
com> wrote:
>
> Commit 96ffcdf239de ("PM / devfreq: Remove redundant governor_name from
> struct devfreq") removes governor_name and uses governor->name to replace
> it. But devfreq->governor may be NULL and directly using
> devfreq->governor->name may cause null pointer exception. Move the check =
of
> governor to before using governor->name.
>
> Fixes: 96ffcdf239de ("PM / devfreq: Remove redundant governor_name from s=
truct devfreq")
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/devfreq/devfreq.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 18e3f7e063a4..46f3a8053197 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1376,15 +1376,11 @@ int devfreq_remove_governor(struct devfreq_govern=
or *governor)
>                 int ret;
>                 struct device *dev =3D devfreq->dev.parent;
>
> +               if (!devfreq->governor)
> +                       continue;
> +
>                 if (!strncmp(devfreq->governor->name, governor->name,
>                              DEVFREQ_NAME_LEN)) {
> -                       /* we should have a devfreq governor! */
> -                       if (!devfreq->governor) {
> -                               dev_warn(dev, "%s: Governor %s NOT presen=
t\n",
> -                                        __func__, governor->name);
> -                               continue;
> -                               /* Fall through */
> -                       }
>                         ret =3D devfreq->governor->event_handler(devfreq,
>                                                 DEVFREQ_GOV_STOP, NULL);
>                         if (ret) {
> --
> 2.33.0
>
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

