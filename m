Return-Path: <linux-pm+bounces-26843-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D56AAEC99
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 22:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47BE1C4131C
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 20:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7C520F081;
	Wed,  7 May 2025 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pov4z9Oi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7306220B7E1;
	Wed,  7 May 2025 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746648079; cv=none; b=WZAixC3MFUW3EHads8KkM1o9+cohaW9xJXTVQ7nNu/chI7SPJiLMy/6acOjmnZhrZOCEa86/HU1OTCprSvQMLkwjDD+SGJT3ye8U/EEX8/CPCAzxkO5WeScnIgwB4XT0/xiqjMpkfjQrCv986lcbGyGtUxAGfMGriFe6MBHxpXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746648079; c=relaxed/simple;
	bh=TxFDFNufo1tIpadTxAY5h2R4vdhyYZ1SwZuwrVYngag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJItl0GNqGcOzuYHmO1bLtWyL3vuWridBLv7MLtd1j2k12+D25PYdYjodvf+h+UBLhqc5e7kiC7TjqZYA04/njSqIbFpiNFQwI2SZrY3qPgHRVGW9vdhwAG0z4xCej8AFTG74UMuLoywSOBiGf0j7SCijYqH68Ul7fxEj+u9A6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pov4z9Oi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC2DC4AF0B;
	Wed,  7 May 2025 20:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746648078;
	bh=TxFDFNufo1tIpadTxAY5h2R4vdhyYZ1SwZuwrVYngag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Pov4z9OixK531d1x3qL81N2ru76VABWcK5GHhyqSqRlol0iPY9OKutWyws+Bm9A2m
	 /VM7Zn2NFPIAosGvndYrHAILsfaDj9FnDCGGn3r2pKSrf23b92AczBRowk6FhFws+G
	 zS3LW7R1t1fSjr5ojjuevHP88vFZoTtjQEqF2rT3Ap9m+1fpbaFoRn9da3UoHVQrLV
	 z95r92osX7mh7roJVQUBdqS/hDj4X/9aceRFBAbetNsxcfGDYT0zZZCmC6HI8ZEINm
	 aa81juQtryEAi4LUpJmGxua805SMPL09uLY7RQKuhLKbT33kkDz+xt99lbJTM1sWqJ
	 xuXpiwAir8D3A==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2d0364e9231so130621fac.1;
        Wed, 07 May 2025 13:01:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXP3bZd90e3WhfFjlo5rMAIylJ23cKKOgVCEnHiAbcv51/EAbFUrqAZqOR/sheYJx32kde8k1gWDq7RvV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnJkztEWQ89RpGK6R9Wo9C4wagXxLK9GNehwsfemlP5wD4DqwT
	wqMwpi5mBnbGLtNseeDIzPXRWSX6V75WWUdsmgeh5L8msuf0/9NbEjmEY1b8M8qsm/933XzWPBk
	BaiTD8h1BPf/yFFXNENkKks+mp8U=
X-Google-Smtp-Source: AGHT+IG7/LrTJVNhR+lMXGFff31jA1ig/WTUeyDW+4sXl3AHnYhPgQ44BzzYOghLmnXJw68dish+XZnxcDs/11NC/S0=
X-Received: by 2002:a05:6870:458a:b0:29e:2caf:8cc with SMTP id
 586e51a60fabf-2db5c115308mr2742440fac.37.1746648078248; Wed, 07 May 2025
 13:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430144635.3714821-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250430144635.3714821-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 22:01:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iLe3UnRGv5=WVEkEXQ7e7Wc4_NSDpORvwDLrkMpbuzZg@mail.gmail.com>
X-Gm-Features: ATxdqUF91BHjj5geTfYOxd5_wtFyfgHuKWvcCzVlZTXg7h47nAPTsH3fakwHNJQ
Message-ID: <CAJZ5v0iLe3UnRGv5=WVEkEXQ7e7Wc4_NSDpORvwDLrkMpbuzZg@mail.gmail.com>
Subject: Re: [rft, PATCH v2 1/1] PM: Don't use "proxy" headers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 4:46=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> v2: fixed obvious missing hrtimer_types.h include (LKP)
>
> It may fail some builds, let's wait for CIs to report any issues before
> applying this. But I also encourage to test it locally as much as possibl=
e.
>
>  include/linux/pm.h | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index f0bd8fbae4f2..938b1b446a5d 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -8,14 +8,15 @@
>  #ifndef _LINUX_PM_H
>  #define _LINUX_PM_H
>
> -#include <linux/export.h>
> -#include <linux/list.h>
> -#include <linux/workqueue.h>
> -#include <linux/spinlock.h>
> -#include <linux/wait.h>
> -#include <linux/timer.h>
> -#include <linux/hrtimer.h>
>  #include <linux/completion.h>
> +#include <linux/export.h>
> +#include <linux/hrtimer_types.h>
> +#include <linux/mutex.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <linux/util_macros.h>
> +#include <linux/wait.h>
> +#include <linux/workqueue_types.h>
>
>  /*
>   * Callbacks for platform drivers to implement.
> --

Applied as 6.16 material, thanks!

