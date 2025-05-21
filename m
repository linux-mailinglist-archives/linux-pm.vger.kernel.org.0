Return-Path: <linux-pm+bounces-27453-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C724BABF31E
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 13:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A21416D607
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 11:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B552641F8;
	Wed, 21 May 2025 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ojN6l3xG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A53A3CF58
	for <linux-pm@vger.kernel.org>; Wed, 21 May 2025 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747827720; cv=none; b=uaBFj2Ifm9oaKjKM4brbu55feSa7eMwkjN/xiCf33wYF/taLRVmGWCxqFSbWakmTymnV1gZ4VS6dSoQp4uiFQZi6P+2gKyWF4PdoGa5sA8e/YwCiOjyRK8AewQ10kmUmTPCEPdENgkmhl8c2HCpgOp6N/neJJWz4Uh7TZxyB5R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747827720; c=relaxed/simple;
	bh=6MZeJpkU6VblQ7OtI/wGvp2r9/BzM6xHr8FeygAttfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jiSxzcFe+rJLTjaEyn9FFwHiqOOraDBizfk/i/baywZa2JMs4P4X5GXPPhviYRDkeBWT7eGDVgbiZ7JM9mZmcJkvZcSdBnCA6rKeQs+GqYBYqCS1FMZ0+475WGMuZgpt1mugGas8ESl6V/uDs5zZnmpxdleAG7VXXOM4LKDNJac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ojN6l3xG; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e7b3410e122so6375274276.2
        for <linux-pm@vger.kernel.org>; Wed, 21 May 2025 04:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747827717; x=1748432517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MZeJpkU6VblQ7OtI/wGvp2r9/BzM6xHr8FeygAttfY=;
        b=ojN6l3xGNzKZAg9Q46XjRplTgKhIWuCl/KVQv+MsW0xC0O5LVPrVXoa7Osca9kbLUc
         WxaFB8U7/OCiS3XxcBUJ2e/6tJkBYuNJz/DfGgcUL0+B3/1Rs1Oo7C+PyOFNVQFl4UAx
         DnB14Ut/P3qRUbjF8mm+yBhi5F2iF41EgJNYaqwzm+anO18P6xBpDRkNkgFLEH4FUAQm
         ncA/lCtwI7b354Sun0oEE7uOYUWAbWVX3+6F/4ivR5t8rNQ/2+QqAvO1P2xEDEqnnqbl
         j41zkJ32wBlFSnuBJgV0NV2bhpl1WW56ZeZdg3Pf2aTUGeAS97RRsHCH0/7i9duOUygh
         KO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747827717; x=1748432517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MZeJpkU6VblQ7OtI/wGvp2r9/BzM6xHr8FeygAttfY=;
        b=UgZBB2CZSNN8CoDqMnY3C1EJWO2utHran1pUmQ6D/Z1WrHNXA8Rf0ICHNcaTug2YJV
         qsRD9fm/JiaesvzoYnbqEtaoLLSB9cc+hPCLDZqa8I4dbo8dwk0+86RWebLgBQFZMPAr
         miMFamqAn6oZZ5rxaBTDpJrg64Ze8ssWPTNhIzbOOPJnpnHq8ectypY80lqTIGdRIxOv
         d4mYNa2VDK96DAcJZgNNzKhCEwsAm6pNL79NeyuX4kOjYsYpOlD/igzGbZclExtx6VvE
         WGVU5RBu472cFZtrvmGhiX51pEHpmkjXE6OG5o139IC/1TGtPBXUlEYvOhPm9hSuIGKd
         CbIA==
X-Forwarded-Encrypted: i=1; AJvYcCVZSWeitAIcKi9m0u91iIpY6SmpVPiPdeb0zTrMqJYgZF29zS8A2loWVju24H2QlB2GJRUyMvpPuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuYXDiKscjdS/3Mo+WcXp6/f8ocofGWYKL8aqoN9pxSk5Qd/1z
	jg+QjSqFINQXDet0yumvoyat7Jka/TouULGHT3YtkE74ggwxEBLJ9R9mCGMX3FiDXvR9Nr9fNx3
	xfTyirWwLX7AloD5Z0DzfgUUr2cNOzHR1mxMfsJBnD2pgKhJQPpHFrsy8rQ==
X-Gm-Gg: ASbGncvC1f61CTR2owKFB9wUClpVTJUcoWNGr3YnT49MZrOSOXqhvxB2q7KL1ojjuTK
	v37+qk0HH1wprKDIdwmrOK4lAU1UFUmX1bs0/WxlutFov35JpIP9UncEMP+EohU6soiU/tsxLb/
	Rz/zYnmWTntucaXRjoqziSuCnNNO981nuS+g==
X-Google-Smtp-Source: AGHT+IEJRa6TVkfzQ58O9FhFkfZAdhxX16+QFG8CIAfdeWEH8fgSALQEibspuxtnsso331LoIjY97FnEoFxQVh+nbuw=
X-Received: by 2002:a05:6902:460d:b0:e79:67c9:b647 with SMTP id
 3f1490d57ef6-e7b69e857dfmr26356893276.16.1747827717440; Wed, 21 May 2025
 04:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ab0476382e3342161beda94a45ddadb49b026dcd.1747760015.git.robin.murphy@arm.com>
 <6f0a38e596c0727d0de13a29c9224f71bc7d30f1.1747760015.git.robin.murphy@arm.com>
 <2393836.usQuhbGJ8B@phil>
In-Reply-To: <2393836.usQuhbGJ8B@phil>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 May 2025 13:41:21 +0200
X-Gm-Features: AX0GCFtZEPdXq2RFpP8dY62bvQ_oqyF_Bdfij7jDVf1Di2-SOIPajRHFWge-u3o
Message-ID: <CAPDyKFpTaRZqdpwFnC5DgLjJAf1YawJ1L5OVgwfjnfs7iNyUhQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pmdomain: rockchip: Relax SMCCC dependency
To: Heiko Stuebner <heiko@sntech.de>
Cc: mark.rutland@arm.com, lpieralisi@kernel.org, sudeep.holla@arm.com, 
	Robin Murphy <robin.murphy@arm.com>, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 20 May 2025 at 20:38, Heiko Stuebner <heiko@sntech.de> wrote:
>
> Am Dienstag, 20. Mai 2025, 19:10:17 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Robin Murphy:
> > Most 32-bit Rockchip platforms do not use PSCI, so having to select
> > ARM_PSCI to satisfy a dependency chain to retain working power domain
> > support is a bit weird and non-obvious. Now that the offending SMCCC AP=
I
> > is properly stubbed out for optional usage, we can relax this again.
> >
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>
>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
> Of course this needs patch1 of this series to get applied
> first.
>
> I think for bisectability, doing this directly in patch1 might
> be less dangerous though?
>

If it helps, I can pick both patches via my pmdomain tree, to make
sure patch1 really gets applied prior to patch2.

Mark, Sudeep, Lorenzo do you see any problems with this?

[...]

Kind regards
Uffe

