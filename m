Return-Path: <linux-pm+bounces-13966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 328CB9741DA
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 20:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F32A1C25475
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 18:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4521A08C4;
	Tue, 10 Sep 2024 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kt/PJ30/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37DF19ABCE;
	Tue, 10 Sep 2024 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725992234; cv=none; b=iT/8cmQaPf7bcPhqwxUpMK0AbD9z5/v18NCnpsuaFGdLBurV/jE2KPKGzg38AYjkmlHsJSaTUviYtXfLievtMZSeqssBhjokMG7OkG6tXZ+IlNABj1IMKv4G4vcL0ClLQIMnSNtOW2QohnEDi3Xmdy50wz75ZT1PXQUnAZwuAno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725992234; c=relaxed/simple;
	bh=Av47JBqIMel8pnzyd1psadtkEZ7h2mHZiNrDkpnn9sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXVTd0+eh9kdUzK8ADi+IlrSvjRjX0ykRsNslRBlfht3VEGj8ClMVDr6CSX1EA8h9X4EYC1xNZhrAlnK94EjM87xyfYHwOYB/TYF1HZ4Dl688kaILYvSat8A8n92WmVCK4Bs5kcg2judK618xgkFpj8D8ngyYax1CKX4AWfXWy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kt/PJ30/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55618C4AF0B;
	Tue, 10 Sep 2024 18:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725992234;
	bh=Av47JBqIMel8pnzyd1psadtkEZ7h2mHZiNrDkpnn9sA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kt/PJ30/Cxb4wFw7QznVS74EjFfwbVUk2YHxS+GcO8oEaRYicdYZ9r5FP+bqW/lQL
	 sCs9D8JpC3UEWkx/xDZz1V2mO7Cz/P9AZs0n1s7l9X4SV3Mqwx0LR2zgfgiXKJ3A5X
	 yksgfPsE91I0l1ytuVk4W4mH4ANlo7CdVpMBbTjDWH7aj+/7inAAK/MAdv9u0RJ0CE
	 yTlN771EaMWOklCnMguLsF5ppaDjczFRmBBbu8EcivVCa5coNNvF37E7tF1FpX/Zb9
	 9pbRGV7Pgb2Bi6yRIpz1xutVNUl5CqpZyzZ7OCMHB1YTzzZMjklwjM+CylRapsomXQ
	 cuIqs8LPdsRWQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-277dd761926so3800349fac.2;
        Tue, 10 Sep 2024 11:17:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4RgbeZ2bqBnLUVoAhNk/qA7LL4D30WtYci6XyHoGSD8aJ1QwAf3i95IPXKeDIOQRKg6xAdu0wzvg=@vger.kernel.org, AJvYcCVRAEE4TJmuC8zJiqLx54XBrQA+4AR5aZdlEyy71bKH1gXF0lPw+Vwos9eRXgE3gzlWVleXrAOlBp+k16E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWHYt6FDi5PGnmG6k1HLGIJZZ1BLl3081l4xJSjTKfcYcW69uF
	zn67n/T+OuT9jjsA6x7g98uXPc3LdUZCEuPP2nmUhglZ18DDnX3nWrfk4xJqFK3+eVVv7FFK3sA
	TtFcyvzQgncfD2ePXtjohUm3jAS8=
X-Google-Smtp-Source: AGHT+IEeYO5s/ZCYXb5YyAbzRWMGjfGy+I6cPKvTnJtvulEDvKApH3QfL4YtfaNvr/Apn/u013u2kVuzuBXTVe2H6bA=
X-Received: by 2002:a05:6871:7512:b0:268:9d81:24b7 with SMTP id
 586e51a60fabf-27b82fc714fmr15257645fac.29.1725992233687; Tue, 10 Sep 2024
 11:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905184848.318978-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240905184848.318978-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Sep 2024 20:17:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jkV4xcuKpLkGUzDc6PMfjBuS67hDr1MxMybus+d_cUrw@mail.gmail.com>
Message-ID: <CAJZ5v0jkV4xcuKpLkGUzDc6PMfjBuS67hDr1MxMybus+d_cUrw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] PM: hibernate: Remove unused stub for saveable_highmem_page()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 8:48=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> When saveable_highmem_page() is unused, it prevents kernel builds
> with clang, `make W=3D1` and CONFIG_WERROR=3Dy:
>
> kernel/power/snapshot.c:1369:21: error: unused function 'saveable_highmem=
_page' [-Werror,-Wunused-function]
>  1369 | static inline void *saveable_highmem_page(struct zone *z, unsigne=
d long p)
>       |                     ^~~~~~~~~~~~~~~~~~~~~
>
> Fix this by removing unused stub.
>
> See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> inline functions for W=3D1 build").
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  kernel/power/snapshot.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 405eddbda4fc..30894d8f0a78 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1365,11 +1365,6 @@ static unsigned int count_highmem_pages(void)
>         }
>         return n;
>  }
> -#else
> -static inline void *saveable_highmem_page(struct zone *z, unsigned long =
p)
> -{
> -       return NULL;
> -}
>  #endif /* CONFIG_HIGHMEM */
>
>  /**
> --

Applied as 6.12 material, thanks!

