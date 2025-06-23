Return-Path: <linux-pm+bounces-29353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEFFAE483A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 17:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BCE1B621FC
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099D8279DBF;
	Mon, 23 Jun 2025 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qh3DLwXx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5970279DA5;
	Mon, 23 Jun 2025 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691539; cv=none; b=BlJInVy+2P2tujAKWio+UCjbfkavGUMrVl8iHqMIaaP/MigxIe0Lib1zk9HdV6OzOK/eKLx2ASsGxHav07RxMbggyTiO4YW+rI0uTDfNWIyJyQbQzQ8mgdklhnpLDSCA5mLXPQYHk/GAOISEc/HyBPZa0IbxfaCVH9+9uuNyvsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691539; c=relaxed/simple;
	bh=12ZF/3Iz/jRD7RCu2S2dOBg4sjwvSJtH7M61B9OeA48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ienbWmm5oYGrCBJ2ut44X8q/LRhaMVXpQj7OVYQzEeyntF4eCj8RY84G4DG2UC3fZzTrU5kWlPfzhCn+a4ZzySGw8qNBAAxMXxqx1ycfCQiu8PGBkM/p0kM6gc1fv5Aqs6qV1UaFsLCoJJzFBSgg0eU3jRPHEkoYmOEU+vwi37w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qh3DLwXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702C2C4AF0B;
	Mon, 23 Jun 2025 15:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750691539;
	bh=12ZF/3Iz/jRD7RCu2S2dOBg4sjwvSJtH7M61B9OeA48=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qh3DLwXx/NSlPRvOnJnOFWoQy7rDiK/fTVDmINqCDKUFPLm7IPD94ZTP4WhRA1Mys
	 0gM0x0Ylhdx7/AQ3A3H8y8lEcGRSHSNNlHNk5ylYbidaAfSXlrtqKhUJhiX8qgHqQB
	 yO5LdL1iKGyy1clLfWC8BpK42U9YqKFqqjAhmeMosFVcBAvt3yly0IOUFDCD2GPkJb
	 nA6idP7jul+vVcOPJG7yPHHz2YsS4b+L1BGyq/xYV5QprPsPqSX8bph+MYkQ++Lxhz
	 BAnebiqvJpizcnmCJCgggNXJjC/l9KYF9wa+aR6zpB1ZHPO08S1NWpCpKmWK/MkLGD
	 PW/ECNZM/Shhg==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-40aa391ce1aso968731b6e.2;
        Mon, 23 Jun 2025 08:12:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWYIQ1IPTBqYxv/kikdCod6ybFXtsaWW+8vBmGtY0cGTBYq5HJMv5I9SLd1nbgo9nayo7DZjI506ns=@vger.kernel.org, AJvYcCXZbu9+NlCSG+O/0nVEVr5NzFzutWWrKADFC7Gfj77apKvtcHDahSoaum+Y4zPsBVc2a/HK/XKA07axJKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytbs02OmmHMYAn9I0wGKrgbLJUXazmdbdQAwm58rWR+TcfnWPH
	9CWEwcjChICMAhxZMUX3VInU+Gzxdw/tsdlpCMdsTHjAn1IqSffSXqQagf6pf12JM+kwR32fl1g
	dWK2nhwwnkwsCkxkvJB/0kBwNlWNYSXw=
X-Google-Smtp-Source: AGHT+IEBml7id1FC3IcQeJHdDnN3Cd9NMilzSCz3He8y6icp7TSWvpJKDcau8RHB2WVp/w+RzAfect7ghiJ5r405u2o=
X-Received: by 2002:a05:6808:1393:b0:40a:a8ad:bc23 with SMTP id
 5614622812f47-40ac6f548b9mr9153054b6e.28.1750691538763; Mon, 23 Jun 2025
 08:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623133402.3120230-1-zhenglifeng1@huawei.com> <20250623133402.3120230-8-zhenglifeng1@huawei.com>
In-Reply-To: <20250623133402.3120230-8-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Jun 2025 17:12:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hizEYaJw77feqAoHJWYuANvbdxZ6BbogZ52sTU2eKTUA@mail.gmail.com>
X-Gm-Features: AX0GCFtgPB5gTucv4-tiZOvPfCU6hXae24gBOBT_WjKzdXsriDQmIoZKGSe3bac
Message-ID: <CAJZ5v0hizEYaJw77feqAoHJWYuANvbdxZ6BbogZ52sTU2eKTUA@mail.gmail.com>
Subject: Re: [PATCH 7/7] cpufreq: Exit governor when failed to start old governor
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, ionela.voinescu@arm.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 3:34=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huawei.c=
om> wrote:
>
> Detect the result of starting old governor in cpufreq_set_policy(). If it
> fails, exit the governor and clear policy->governor.
>
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 7b82ffb50283..2b431845a8a3 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2715,10 +2715,12 @@ static int cpufreq_set_policy(struct cpufreq_poli=
cy *policy,
>         pr_debug("starting governor %s failed\n", policy->governor->name)=
;
>         if (old_gov) {
>                 policy->governor =3D old_gov;
> -               if (cpufreq_init_governor(policy))
> +               if (cpufreq_init_governor(policy)) {
>                         policy->governor =3D NULL;
> -               else
> -                       cpufreq_start_governor(policy);
> +               } else if (cpufreq_start_governor(policy)) {
> +                       cpufreq_exit_governor(policy);

This may introduce a governor module reference imbalance AFAICS.

> +                       policy->governor =3D NULL;
> +               }
>         }
>
>         return ret;
> --

