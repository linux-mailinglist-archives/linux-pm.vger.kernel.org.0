Return-Path: <linux-pm+bounces-30054-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F41AF77CA
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 16:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8084A0B55
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 14:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4E92ED848;
	Thu,  3 Jul 2025 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVG7aDkf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77682D9EEA;
	Thu,  3 Jul 2025 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553627; cv=none; b=UVB9O79Jp3CkWUKCaBMXe3x47ieHip+9whMHGg45Kgjc/NC7iI+f6i6bamtw1D0wfro5SO6MOPa9viMfq2+cvT/fQm3axgVA3XMf0IdSg4Ro1xJNFl8MoVMjEZ/UVOkY21FyaPjcymwTqMzDDjDxh58BWibe/eMzdxaIkJBYHrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553627; c=relaxed/simple;
	bh=XXMeCgokzx98niMoHTPrXBV55pjM60kvk0FrPv49lWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3jdMnQTeUSf1LqezTzcN99bNPELlwhpbRjSdvuOtgrUsFVNeMkWwZr9Hnm7pbZpKPvr284lNqIvbe+Id32viOX5VLW1nkIZskCnqUIxhycvIY95mpoOmknkfTW04QYvNcv846YVien5+BTAZBmuI9u0+QNYxWnVHe48N5nGPiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVG7aDkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C194C4CEE3;
	Thu,  3 Jul 2025 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751553627;
	bh=XXMeCgokzx98niMoHTPrXBV55pjM60kvk0FrPv49lWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dVG7aDkfbqbYdrBECpZWIgyJ6KluK5azY975xciI3A7wR38tzG8rdvP7qV0XQtYKz
	 1u1o28cgz2tJGpnfy9BGFEerFYI5PrtfxT7IOhm5QN9MLoI8VvhspASlBU0NWVgjF0
	 WG7YNRfJ+W1exvu7Y4yYE8gV/lfcIZKXe35peLpB/1cH4RecJOXq5NlkA72o+mAouv
	 wnEcWhKgFM2W34EMIdSOSq3tGOzuyRGcBew8mKHehZg5K1Zuwl97zE9NItiTzN5myv
	 ue7kCHOSuxbPEGjCoTaq9CcApU/jJsP/tgRw7j87urhmWpJvjQQYh+9WHe0CuN/pf4
	 3YDZRYx0l+Yog==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-611e455116aso10373eaf.1;
        Thu, 03 Jul 2025 07:40:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0RRzixmJPZiVDLVE/8ycXH4FXpWVec1nMZO5b9snbGV40bux6mQevDVambWrQs+Wt/V15A8upPcI=@vger.kernel.org, AJvYcCXzQUtd3fHGk9LwR+txYbnZ4GpE1hb/c07wVNc1ONl1FB02Mf5ZStFecWWnU+zREJeOQtSh99oDSPOQWco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPg6IkNiYxAGIjpxQr8q2VOEQNw43trS7WjQWCV37h1HGk1uWk
	K7zYwS5mj0xuOISSz3UAQkevxniYqU+4GTVvXglw7qz+tER63yZZ718+8Uxfk414zaoPKkQKjbW
	0H8TQWlOEfVr2C9Q76DQ4xWRJn0SQbBs=
X-Google-Smtp-Source: AGHT+IER/sMuSGQEFAsoM82w38J6W3Ql7R2iTp4LsFImGUU9KDmwJNRGkTiL9vgKh7Lzcas4txH5n+sYaJcmN2NRFfU=
X-Received: by 2002:a4a:e90a:0:b0:611:4bfe:610a with SMTP id
 006d021491bc7-6120122b7camr5001293eaf.8.1751553626457; Thu, 03 Jul 2025
 07:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619035355.33402-1-zhangzihuan@kylinos.cn> <20250619035355.33402-3-zhangzihuan@kylinos.cn>
In-Reply-To: <20250619035355.33402-3-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 16:40:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hyBg3mVhfERkTLUnARLrsGarvtKOnL=RrL9VGF5DNLsg@mail.gmail.com>
X-Gm-Features: Ac12FXy5NQqYWXStnmleOPfeHm086ElU3e2sj0kpZeHMiJ10XoXafFZGiwitG90
Message-ID: <CAJZ5v0hyBg3mVhfERkTLUnARLrsGarvtKOnL=RrL9VGF5DNLsg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] PM: freezer: Print tasks stuck in D-state during freeze
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: rafael@kernel.org, pavel@kernel.org, len.brown@intel.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 5:54=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.c=
n> wrote:
>
> To help diagnose freezing delays caused by tasks stuck in D-state, this
> patch adds logging for tasks that are stuck in D-state during each retry
> of the freezer loop.  Such tasks are not killable and cannot be frozen,
> which can cause the system suspend process to retry many times
> before aborting.  This message can help developers identify which
> user-space or kernel tasks are blocking the freeze process.
>
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  kernel/power/process.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 87616ca710ac..4007f621c2ad 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -55,6 +55,9 @@ static int try_to_freeze_tasks(bool user_only)
>                         if (p =3D=3D current || !freeze_task(p))
>                                 continue;
>
> +                       if (retry > 1 && READ_ONCE(p->__state) =3D=3D TAS=
K_UNINTERRUPTIBLE)
> +                               sched_show_task(p);
> +

This is going to be too noisy IMV.  Any chance to rate limit it somehow?

>                         todo++;
>                 }
>                 read_unlock(&tasklist_lock);
> --
> 2.25.1
>

