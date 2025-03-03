Return-Path: <linux-pm+bounces-23307-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB55A4C076
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 13:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8D9188D3F2
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4C31F37D4;
	Mon,  3 Mar 2025 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPIduBF/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5657FBAC;
	Mon,  3 Mar 2025 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005544; cv=none; b=o+kvSl2RtylBRWj/z2y0eskI9If+QA73LMnfuyDNNgyi431AXiEPmUKgsiZPG920bcrMWEJouwiIhgirNO8xFRCoL62au4FjGKpVHiiwk+O1+0PyJDgkhyvytm5ml7hoL+ydcKwnGrO0trc5lNME4wvg982W+hOlpLqoQf+6eh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005544; c=relaxed/simple;
	bh=B86K9mL2DWSBbOS2P/XXx6FWnpdGnhaunsmZn+LgU1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEQJXKy7WDaOUaP3EEMyR38LIWQxZsTLej2MWkSfLn+Z5vqwTYGIhV0wimM9WVqq95HuYWSqN3sDkBkVPtgOJWczo2zJHAd+gE5iOBQasOofH1nbPJtH0b18NQSt6pOu+SZee4kaBHXunoYCzxlhbLljPXK3U+yNMhu0BwDZw5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPIduBF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A9DC4CEE8;
	Mon,  3 Mar 2025 12:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741005544;
	bh=B86K9mL2DWSBbOS2P/XXx6FWnpdGnhaunsmZn+LgU1A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iPIduBF/ryFdMhJVjAcCERxHSX8AW4S7CCuHeo1rsoc4ksIQmmXxMaTZsaoBaXm0t
	 p75PvLX6Rd5cikacEeqPg0KjFR4iK5qKFPqyx1WqUoboTMmU/oQBCZJ09DGA5Cz56t
	 VbdHMcL9bz3qP8u85LX783N3N7dP64HQhMAesZkZ3oCCdDZ/RYbyZlWERcDbOFN27G
	 9sxSsNIfOYeYHTTOMKqxCw3GcFiPIKk91BA6Wphfyta1GfBDu7yrjSkESZ22HF8OuK
	 YsOY/I1HhFIDFAcFjjjb2A09XobR6j1g3uVOIxnAfaqMFBQ0dCBpLd9VroGWKuCWaw
	 szEVuWhkdCVgw==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72726e4f96cso2411224a34.0;
        Mon, 03 Mar 2025 04:39:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJL+UI8pauK0UtuVITxHGTd9uZ6ysjRlWEiiIalRvmdiGjumOJ6HWJ5tPT7zBnDE0dFw3G8VXq@vger.kernel.org, AJvYcCVIISWGXJtt8lfk5trYNxen5IKuBaZtnTSXss/FDRyODUkX132y27KIdwpVHhhXVoKMeX2hITiGiPI=@vger.kernel.org, AJvYcCWgjIW3fel4nBQE+JbF1qFDgXMv9OxTkR2sXS1UGkKrQxq9B0Tuv6WTfbQQQILPeuHNKV2jk1flVK4BUxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdM+q0UMTnbPHAJxhYEOz3u5DFX+YT4FJ6JZbn8QzR4PqH6p71
	Qh/i3NdeFdDBTI4IMgmHlaIIBdUe0g9gW9WC2SEZdfjpEZQwbQhFVf1cOOm7l4fxOsFSDR4Eu+X
	kr/zz5Z0v+MYWt46a/oKJYILUhMw=
X-Google-Smtp-Source: AGHT+IHL7QcHIA/gOliSbHVKnX78oe4T2jnrZGkt3ri8BU4falSM2AKPYFtTywanWJLfm4FpFouSbDhOekSp/JpP7jc=
X-Received: by 2002:a05:6830:388b:b0:727:2a80:e3b9 with SMTP id
 46e09a7af769-728b8306967mr9059477a34.24.1741005543352; Mon, 03 Mar 2025
 04:39:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303034337.3868497-1-haoxiang_li2024@163.com>
In-Reply-To: <20250303034337.3868497-1-haoxiang_li2024@163.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Mar 2025 13:38:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g5RJaHeYqiP3khp2vPyVHj0W35ab4gtBJ0R14nhSqa_A@mail.gmail.com>
X-Gm-Features: AQ5f1Jpbua78r-Y1CAXxGLBF0QiCkuqUxIYIZ26St3GtTy8Yb-YsB_WumRvmuoE
Message-ID: <CAJZ5v0g5RJaHeYqiP3khp2vPyVHj0W35ab4gtBJ0R14nhSqa_A@mail.gmail.com>
Subject: Re: [PATCH] PM: EM: fix an API misuse issue in em_create_pd()
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@kernel.org, 
	dietmar.eggemann@arm.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 4:43=E2=80=AFAM Haoxiang Li <haoxiang_li2024@163.com=
> wrote:
>
> Replace kfree() with em_table_free() to free
> the memory allocated by em_table_alloc().

Ostensibly, this is fixing a problem, but there's no problem described
above.  Please describe it.

> Fixes: 24e9fb635df2 ("PM: EM: Remove old table")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  kernel/power/energy_model.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 3874f0e97651..71b60aa20227 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -447,7 +447,7 @@ static int em_create_pd(struct device *dev, int nr_st=
ates,
>         return 0;
>
>  free_pd_table:
> -       kfree(em_table);
> +       em_table_free(em_table);
>  free_pd:
>         kfree(pd);
>         return -EINVAL;
> --
> 2.25.1
>

