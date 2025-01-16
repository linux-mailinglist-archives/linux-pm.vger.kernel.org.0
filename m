Return-Path: <linux-pm+bounces-20560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A7BA13EE2
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 17:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED507A3BA4
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF04722CBC7;
	Thu, 16 Jan 2025 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQqkZraB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C921822CA11;
	Thu, 16 Jan 2025 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043781; cv=none; b=ZosNVuLcGICAOxo1gDtlOqt/0js50GjdTpg9/kpydOKTOgi/9BppojZK85qENTmpHbq1/zygYOdIG1kZlX94AX/uy+5sbie+FwqN1BsJVmS7ickAG3Ieq0unwudQjsJ3XmlCCD3BYK6Ocap66J6LIJvN8qJ0xQpyHSRE/CnBYKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043781; c=relaxed/simple;
	bh=tqC5mWdfKsetS6Kuu5kdfwCAXxkso0iXjQNhrOizkoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBvuU8yFC2HKGiLTXWFXF1hOKtUA2uJfw8K7GoRVr1H2UzkYUGzoJpLAJMAiMONERSqIDAb3opOYHnMDZPNFBUaletoseMNVG5kzas6PGW4fws+rboJxgTmtQJCYt/IVXcvHDw3VndmJHpytE4QdzynHMZsvZTHHJm5yuss6dIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQqkZraB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DE0C4AF09;
	Thu, 16 Jan 2025 16:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737043781;
	bh=tqC5mWdfKsetS6Kuu5kdfwCAXxkso0iXjQNhrOizkoI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kQqkZraBi3DxpuJbae+rzfWt5czrlJcxsv+PP/62arCnaysPZey3a8ZLnAFh8QnOZ
	 vNpCQUJLBXUFoO2pNIWH5pqE25W0j6wqJwey+Nx7GXVpg5/7qJYVd0XAyguR7PG+PL
	 FWXRqmPQypgPy+o/rSrSJGzmAfSH3woLEkCVp3SyBXIRey3C+cTsb5ASC2Q4JjjsMt
	 pZB3K3Vcohv5GfwCgiwibi1ylT2cGKszWaS/rKdsT4cflbVHw4T4OdTd3pK9mHOK+P
	 Rzm+yQ9qkh2/j3j5hq72GJlpXiKJyFf+1Y20y1pxJmlq5xof4Fu6dhLis837Nfi4Kt
	 lgGECq4WGA3JA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-29fae583cc8so617106fac.1;
        Thu, 16 Jan 2025 08:09:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGOM9bGnrwgPJ6DWmmdvobOqNbpFfhqq1lrHE9oOj5MxCir/qwNoOUrtY8O7vIfMGe1SCEIAtxM1o=@vger.kernel.org, AJvYcCXn61YxXRgJXwCLLxad/fz07mfmMqzD8MvXf85OYo9O1Duyw6AphznoK9hVgwXnivPZgwnv/8fqr2vd6dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKg4lKM9JwzHcpoDob//fZCUeFvQfdhGsmh2SGmkCby1Drroey
	Bt6Ip1/5bjDTfmxDa+qunvpROw3Vv7O4UsZPEc6ffuLOiyvUCDw6YK62JIiJ2OduRjmv1EJSYCD
	nnKTTUPzP6b/AFsOXVh7pB7LjXlE=
X-Google-Smtp-Source: AGHT+IHco1OYPdR8zhDc0R68C1grJDmSnxwP9rNltK5VvbQUXp6UbMEb1hqshAg+l6GML/3QKMvC0FDYtQPQOpUlgds=
X-Received: by 2002:a05:6871:a015:b0:29f:96b3:df91 with SMTP id
 586e51a60fabf-2b1869c1879mr4675030fac.1.1737043780525; Thu, 16 Jan 2025
 08:09:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116154354.149297-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250116154354.149297-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 Jan 2025 17:09:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0izBnSGjmjO7T+_gEhrSib0==_bRXnsLEdzEjbH0cZDqg@mail.gmail.com>
X-Gm-Features: AbW1kvY0m9go1tOqRmuamjHnEcYphLxh0xNHrMKSQmCWyzC-08ECwE0hksluUfw
Message-ID: <CAJZ5v0izBnSGjmjO7T+_gEhrSib0==_bRXnsLEdzEjbH0cZDqg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PM: Revert "Add EXPORT macros for exporting PM functions"
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 4:44=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The introduced macros are not doing what they intend for, namely
> they won't eliminate the code when CONFIG_PM=3Dn.

I don't think they have ever been expected to eliminate the code then.
They just don't export the symbols in that case.

> Also there were no users of them for all this time.

This actually is a good argument for dropping stuff.

> Drop them for good and to avoid possible misleading.
>
> This reverts commit 41a337b40e983db4f0e1602308109f2b93687a06.
>
> Reported-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: elaborated commit message (Greg), Cc'ed to the original author
>  include/linux/pm.h | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 08c37b83fea8..5dae93817141 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -384,12 +384,8 @@ const struct dev_pm_ops name =3D { \
>
>  #ifdef CONFIG_PM
>  #define _EXPORT_DEV_PM_OPS(name, license, ns)          _EXPORT_PM_OPS(na=
me, license, ns)
> -#define EXPORT_PM_FN_GPL(name)                         EXPORT_SYMBOL_GPL=
(name)
> -#define EXPORT_PM_FN_NS_GPL(name, ns)                  EXPORT_SYMBOL_NS_=
GPL(name, "ns")
>  #else
>  #define _EXPORT_DEV_PM_OPS(name, license, ns)          _DISCARD_PM_OPS(n=
ame, license, ns)
> -#define EXPORT_PM_FN_GPL(name)
> -#define EXPORT_PM_FN_NS_GPL(name, ns)
>  #endif
>
>  #ifdef CONFIG_PM_SLEEP
> --

