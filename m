Return-Path: <linux-pm+bounces-29987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72075AF61C2
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 20:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE241C23B4C
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 18:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450F12F7CE5;
	Wed,  2 Jul 2025 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHMBKh2W"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210F32F7CE0
	for <linux-pm@vger.kernel.org>; Wed,  2 Jul 2025 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481886; cv=none; b=d7o7Q10Lt3Qc/JAB/QjevHSvp3YpA/CvGyzTQQbHD8VOJOIl2ti26rIUiwPkiaPPvMysFwbAZ3NMkU1MfBh75rqWi19RKWpIfOBn+jCUTJRM8oVrWsEedmG7X3GR0fExKfMU0R/bQaJ2m9J+TirnMOUlGSKsW3qBNtctd7eh5VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481886; c=relaxed/simple;
	bh=piXMAu0ij/hHlIjGmZgZoINM+YMS/n3NyDcVpYdeVm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gD/djgsmhNCwVjFqZKxRwjc4PrZjD+rFoZj3V6RHxFfwFlCoT4xlhoVUpIXEl1FmjJSLhFGCbKLtK11QUhXgSK91qEUcS2Sl739iLmq1W2FGxGruVO1dGkrH9bdmYV3QJFWEddTyP0jH2ffp+aJwrokP/dnlKN4KU1gZDxy8HIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHMBKh2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25BCC4CEE7
	for <linux-pm@vger.kernel.org>; Wed,  2 Jul 2025 18:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751481885;
	bh=piXMAu0ij/hHlIjGmZgZoINM+YMS/n3NyDcVpYdeVm8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DHMBKh2W0anTWAhcbaBl83B7r9SMYyjKdBiatrv5ncl0JGrMkqVKUkdQB2Qzyv9a7
	 YDs7cPErYydopqsCO1swJRQ0o5877H7gRG1vFmxvO8+MNO9cL2h36vq2rx0w8vJ740
	 FdH3MMA88nH29vrogiXEBPJ6/+Ddl1kxppU3sOeTuFdSvZvl/y4Ya3sK9Jn740mQn+
	 lw0Og5AQh6B2cF5bFS44HWtAUNYjOVq4ma2xg2iUo25j4N06TqXTRhJEpfBTaMHmTm
	 uXwf9WBh1bXuOVEPRUvnCrqPn3YZ+V21QfN2r90RHjORh8hzYzesRBTIhnKYHdbyjM
	 EeWHKZFKR5FNg==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-61208b86d75so364112eaf.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Jul 2025 11:44:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjW5trIvIe8d5hP5GZ0nSQphr20opvi9JqE9KGXu5ucQrxJIyTbSltXDOlNMXJN/Im5q5Ui4TDDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxC/VvYUC2bxSdoPkOuwavf63pmtU9FUOWDhg4kzobA1fHBwKQ8
	Q1PNoS8lnbf35D0w39xoBFXdSZWsdNPNEpw5Xh/RGNKBmuILGzbwQBM2vpqJGRC4yUc8OnuAtJW
	yCOAkFR5DTPRz+9FGpmYz2UdVt/2/1lI=
X-Google-Smtp-Source: AGHT+IFWyGuikxOdRsZsHe5yjcNQg0ppnwlG3BzE7y6ygCoLCsOvtwV9+cysGMDgdxruKzrqeAPH8NO4JLvv8yRaoSg=
X-Received: by 2002:a05:6820:a01:b0:611:b142:20ed with SMTP id
 006d021491bc7-6120134dc7bmr3213079eaf.7.1751481885019; Wed, 02 Jul 2025
 11:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f63c67bee0e0ae498236cff4374feae2a624d410.camel@kylinos.cn>
In-Reply-To: <f63c67bee0e0ae498236cff4374feae2a624d410.camel@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 20:44:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0grKkaPpCCCx+jHy4gDL0qN6pDmeyRkhP2=7A9gA3USuQ@mail.gmail.com>
X-Gm-Features: Ac12FXyvURnv-YOAOlOsIJMEgNGkIgM-Me6y3NcXVXm_UQzdszLKIEcNyatjYRY
Message-ID: <CAJZ5v0grKkaPpCCCx+jHy4gDL0qN6pDmeyRkhP2=7A9gA3USuQ@mail.gmail.com>
Subject: Re: [PATCH v2] hiberbate: init image_size depend on totalram_pages
To: lijun <lijun01@kylinos.cn>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 9:33=E2=80=AFAM lijun <lijun01@kylinos.cn> wrote:
>
> From cd88cf1ef77c48a85dd54eea696f8936553bd757 Mon Sep 17 00:00:00 2001
> From: Li Jun <lijun01@kylinos.cn>
> Date: Mon, 12 May 2025 10:39:27 +0800
> Subject: [PATCH v2] hiberbate: init image_size depend on totalram_pages
>
> Some automatically loaded applications greedily occupy
> memory, when total memory is 8GB, the image_size is 3GB,
> when total memory is 16GB, the image_size is 6GB, when
> total memory is 32GB, the image_size is 12GB. some
> of these applications,user may not use them. They occupy
> a large amount of image space, resulting in S4 time of
> over 100 seconds or even more. Limit the size of image_size
> to control the time of hibernation and wake-up,making S4
> more user-friendly.
>
> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---
>  kernel/power/snapshot.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 2af36cfe35cd..197976d75879 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -135,10 +135,20 @@ void __init hibernate_reserved_size_init(void)
>   * try to create the smallest image possible.
>   */
>  unsigned long image_size;
> -
> +#define MEM_8G 8388608 // KB

This could be written as (8 * 1024 * 1024) if I'm not mistaken.

> +#define MEM_8G_PAGES   MEM_8G / PAGE_SIZE

But PAGE_SIZE is in bytes.

> +#define MEM_16G_PAGES  MEM_8G_PAGES * 2
> +#define MEM_32G_PAGES  MEM_8G_PAGES * 4
>  void __init hibernate_image_size_init(void)
>  {
> -   image_size =3D ((totalram_pages() * 2) / 5) * PAGE_SIZE;
> +   if (totalram_pages() >=3D MEM_32G_PAGES)
> +       image_size =3D ((totalram_pages() * 1) / 20) * PAGE_SIZE;
> +   else if (totalram_pages() >=3D MEM_16G_PAGES)
> +       image_size =3D ((totalram_pages() * 1) / 10) * PAGE_SIZE;
> +   else if (totalram_pages() >=3D MEM_8G_PAGES)
> +       image_size =3D ((totalram_pages() * 1) / 5) * PAGE_SIZE;
> +   else
> +       image_size =3D ((totalram_pages() * 2) / 5) * PAGE_SIZE;

Can you please describe this magic a bit?

>  }
>
>  /*
> --

