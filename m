Return-Path: <linux-pm+bounces-25025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3390AA82DCA
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 19:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1155E882174
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 17:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF61D277028;
	Wed,  9 Apr 2025 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Za4d8Isp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D11277020;
	Wed,  9 Apr 2025 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744220334; cv=none; b=pO3LM9ikkFoRQL9PuDfOa6WJEQ3f/NioawWcQbvqZcrNzNCczOaKUkcBk5R8X7UB8+xx9enHl8oXbcFYVMNFyqslzB1RwYTVZHKM3u754PYVIgECAlvj0SYRKfYgLKkiEY6WkT4PfYbvKAEDIieLsuJ/YmLQAz/dtva9zu7RikI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744220334; c=relaxed/simple;
	bh=nZshXwi1QcuYkN3se0SKyC0JzvBlTbMAFvIp4LJDCDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9l+y6DlhGwjBQJCGEI4afiHuUKjHag0rI38tVO9JTg1xOdWATjmj72JKePkJRsPz7i25txpyQ61gi9FBBTm11tO9M8i3kMNSbHsOSvQNVoZ9jTXpT+WWZJDLytOjvTqDEVK0Qk7L6655UMOGVRjCjufCIcN+YJQQ3uNlsQ4lgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Za4d8Isp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381BBC4CEE7;
	Wed,  9 Apr 2025 17:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744220334;
	bh=nZshXwi1QcuYkN3se0SKyC0JzvBlTbMAFvIp4LJDCDI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Za4d8IspMlX2sDIntlELpZo3BEtXyJpZgb+xE/1Maw2VJZen5E3PhHiyfNh93GD23
	 IOEW9GFxi3MyP5uMdNOKLEtoev+25yMjj/qmoDRFoGJRHFgdnH5XkeOe1uFBCQiMtM
	 1qTJdlkXehdod71j7paYGQeDE2rgE21TbNtowbGEL02gCVHPELURuIBCLy8gxjJmc/
	 0GI3/gPJb4SKIT/C7gKWtvET/Ezgl2+q+m638ZWjnO+7AdXjPWczvSNXIr7U3IAYYh
	 fkMGN6k4Qfp49ujXR+sBs9DNcIAR2ToulBBg5zL9EWEZ82yJeqW4nDlvFc9egK8UyO
	 SAJy5/mhnzSIg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2c2504fa876so1893395fac.0;
        Wed, 09 Apr 2025 10:38:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW57qyRLZlSSgP1p9gpYe+Fd/69ryMOXh8u56PYchSPTLFs2fiQ2AtfVvp3P+XoMHwC7a79owx/d90=@vger.kernel.org, AJvYcCWW8NZGZDTZVje0Qzc9aQFbac7vW9Cmh+z25kZCnuZKsnD0ZqVMRrexzaczVhP/rWSBpd8jl/RDpYGvAYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaZ9G1XFM4vYzlcVp+wi9Brx2yv+8PlBYhLrVGuDyl/FotoJi0
	YLIXyL/ZGSQB9b3dMCYZmdyB+F9bg+ZAu77LdsjEhW0lxlMtCBE+EEMsqn2aJOjYhI2a3B6RfLK
	OjVGX+gaq9JdC+v060kZ193NpcKA=
X-Google-Smtp-Source: AGHT+IGFfNFzXB/WwmXIgjgZoJppXAKjcQ+AGSnKXLYSrbVri6pAj8EQxfnzt48/Ok5RaxVy9sDeOF2tdrpflm4B7uY=
X-Received: by 2002:a05:6870:ff90:b0:296:beb3:aa40 with SMTP id
 586e51a60fabf-2d091bb56e3mr1846767fac.36.1744220333489; Wed, 09 Apr 2025
 10:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250405135308.1854342-1-quic_zhonhan@quicinc.com>
In-Reply-To: <20250405135308.1854342-1-quic_zhonhan@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 19:38:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iWLSSvyei_-KdNZs6iWCgy9f1LpVYcaPSW7ZOig-3=yw@mail.gmail.com>
X-Gm-Features: ATxdqUFz2gT4MZkdsbZ4T4OCv426tFu1HzrLA_WhCAC7-mPwAP3Bksqf-BNXlTg
Message-ID: <CAJZ5v0iWLSSvyei_-KdNZs6iWCgy9f1LpVYcaPSW7ZOig-3=yw@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: menu: Optimize bucket assignment when
 next_timer_ns equals KTIME_MAX
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, christian.loehle@arm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 5, 2025 at 3:53=E2=80=AFPM Zhongqiu Han <quic_zhonhan@quicinc.c=
om> wrote:
>
> Directly assign the last bucket value instead of calling which_bucket()
> when next_timer_ns equals KTIME_MAX, the largest possible value that
> always falls into the last bucket. This avoids unnecessary calculations
> and enhances performance.
>
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> ---
> v1 -> v2:
> - Rebased on top of current next.
> - Following Christian's review suggestions, remove unnecessary code comme=
nts.
> - Link to v1: https://lore.kernel.org/all/20250403092852.1072015-1-quic_z=
honhan@quicinc.com/
>
>  drivers/cpuidle/governors/menu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors=
/menu.c
> index 39aa0aea61c6..52d5d26fc7c6 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -255,7 +255,7 @@ static int menu_select(struct cpuidle_driver *drv, st=
ruct cpuidle_device *dev,
>                  */
>                 data->next_timer_ns =3D KTIME_MAX;
>                 delta_tick =3D TICK_NSEC / 2;
> -               data->bucket =3D which_bucket(KTIME_MAX);
> +               data->bucket =3D BUCKETS - 1;
>         }
>
>         if (unlikely(drv->state_count <=3D 1 || latency_req =3D=3D 0) ||
> --

Applied as 6.16 material, thanks!

