Return-Path: <linux-pm+bounces-26946-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE154AB1552
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 15:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4653B1B0B
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 13:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B6E28F935;
	Fri,  9 May 2025 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSryorsI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9344D26B0A0
	for <linux-pm@vger.kernel.org>; Fri,  9 May 2025 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746797661; cv=none; b=JOR+RKuC42wBvDe+v8c7Xrl9Z/OgXdd8+kwccnZMIHbbFX4ehDFnt2hU+NXBCZgyLJBIVo8yHswKY9ugeB+KHhvcsXzzx+eZzRNWCDiMy0SAuBATejyeKbfQ37SdPcMkcnCJt58hQkFJdt3Z1nbOC7H2BEsOpJ5YTpKjVButiBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746797661; c=relaxed/simple;
	bh=E/IaQ9NSACbbKPDFmmWJvz9BV26oLBKWGNw0CE9So9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7JfjLGZBS8BJRh5WhZUarrK8/6IH67FvE1W3VJ6AndPIuJeAga7srZc3pqxT6pShNo2W/RyuHPguC1PVuZnuRQnW8DpURWQ83XcoFqixeTBUqco5HYOKlqN0uJJcDJ9oSd9qM2xtKSlkLkJ7VR8LxSJSS/yWxNoHh7qnzCLWKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSryorsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA15C4CEE4
	for <linux-pm@vger.kernel.org>; Fri,  9 May 2025 13:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746797661;
	bh=E/IaQ9NSACbbKPDFmmWJvz9BV26oLBKWGNw0CE9So9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bSryorsIRgdgUjReNdS0cUw6og0STKRGogH1XIa3AiJnJ3pp1C9ucAS0u8Ub60INX
	 FCLyVxC9zr1z4h9KE6rKvLybWdIMZG142eCBzA9JaOmRzxdisEmAK4rcb1Tc9eItY2
	 Gkz5ApKsV0pfCQ3sRpGAzKCGCIpF8NxDSd4HTrOj1oguoQlRdwguFhITGb/stpMSKi
	 4TmMZrGFi0Q9HdHyE/K8ouujUy47yTnUbY40FhmYHaqqYctyFNbbAc8nggR9yG48zR
	 yjsj1TRwq39M3Y8XTyHwSfeW3HJAVKjqjO/EMeMR0WyIkBMH39dd7oBcjDJoM3fdyy
	 T48ckxqQfHIww==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72fffa03ac6so1642426a34.3
        for <linux-pm@vger.kernel.org>; Fri, 09 May 2025 06:34:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVc3Txp2W5sRsHuC9FjUC55RurTpshDjik32N2XvaQpd1liej+CIWBudB7pBZf9kUygdnbTK0twRw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbmx8Emggz13fZoiStK3l3meX9pbq27NUI82O1L2epYF6AdK9w
	wZ9JLjvF82yq9kjtvYvOw5VaUTlB47tpLE9W3b73Im8GF3opya6izlst+YEZemzkkRJEFDJD/uH
	WYQ+Trii5LOn3J5mPqrOS/6Bwy4M=
X-Google-Smtp-Source: AGHT+IEqk3MCmtKa1O+bc3ZI56E8C0a35qsvcjurlfglxahQ42zZBtEHfVBHPC6K6+rG6BEgOih8InZ7DdZfh6LaUww=
X-Received: by 2002:a05:6870:f147:b0:296:5928:7a42 with SMTP id
 586e51a60fabf-2dba4341040mr1716248fac.22.1746797660422; Fri, 09 May 2025
 06:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0468b1df921c304755cf9c137bc8c44dc0082b44.camel@kylinos.cn>
In-Reply-To: <0468b1df921c304755cf9c137bc8c44dc0082b44.camel@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 15:34:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iuxmo6=MxDBcy19AAH2D+cePsj3+sPtKb2UN58krX-pA@mail.gmail.com>
X-Gm-Features: ATxdqUHsdwo1NjmXY_3VbWS-VRzHUEnGQ157ppXYuHdtXyAyBNTotC3i4_o1zD4
Message-ID: <CAJZ5v0iuxmo6=MxDBcy19AAH2D+cePsj3+sPtKb2UN58krX-pA@mail.gmail.com>
Subject: Re: [PATCH] hibernate: init minimum image size in hibernate
To: lijun <lijun01@kylinos.cn>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 4:17=E2=80=AFAM lijun <lijun01@kylinos.cn> wrote:
>
> From c7240c0614f793e96ab6a18cc9b42e820360d979 Mon Sep 17 00:00:00 2001
> From: Li jun <lijun01@kylinos.cn>
> Date: Wed, 7 May 2025 17:58:22 +0800
> Subject: [PATCH] hibernate: init minimum image size in hibernate
>
> the image_size =3D 2/5 * totalram_pages,in hibernate_image_size_init
> PM: Allocated 2908160 kbytes in 0.10 seconds
> PM: Wrote 3000464 kbytes in 4.13 seconds
> PM: Read 3000464 kbytes in 5.67 seconds
> the image_size =3D 0,in hibernate_image_size_init,
> PM: Allocated 817872 kbytes in 1.76 seconds,
> PM: Wrote 908368 kbytes in 1.16 seconds,
> PM: Read 908368 kbytes in 1.82 seconds,
> 0.10 + 4.13 + 5.76 =3D 9.99
> 1.76 + 1.16 + 1.82 =3D 4.74
> Reduced time by 53%, the test is in 8G mem,if the mem is 16G or more,
> this can reduce more time. the image_size =3D0, just shrink more
> NR_SLAB_RECLAIMABLE, NR_ACTIVE_ANON, NR_INACTIVE_ANON, NR_ACTIVE_FILE,
> NR_INACTIVE_FILE pages, S4 is still normal.
> When the users use s4 first, they are unlikely to read document because
> s4 take long time and then echo 0 > image_size, they may not use S4
> anymore. but s4 is so great beacause it can save power and preserve
> the working environment, especially for moblile devices.
> So from the user's perspective, init image_size to 0 is more
> user-friendly.

That's not as simple as it seems because your image write/read numbers
above don't include the time needed to push user pages to swap and
pull them in after hibernation and the rate at which they are swapped
out and faulted in is way less than the image read/write speed.

What matters is the time it takes the system to get to the point when
the user will be able to do work again after restoring its state from
a hibernation image and if a lot of pages need to be faulted in, that
may be much longer than the image reading time.

So reducing the default image size to 0 is not such a great idea after all.

> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---
>  kernel/power/snapshot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 30894d8f0a78..4299a1e4205c 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -138,7 +138,7 @@ unsigned long image_size;
>
>  void __init hibernate_image_size_init(void)
>  {
> -       image_size =3D ((totalram_pages() * 2) / 5) * PAGE_SIZE;
> +       image_size =3D 0;
>  }
>
>  /*
> --
> 2.25.1
>
>
>

