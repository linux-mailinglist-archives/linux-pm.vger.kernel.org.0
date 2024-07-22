Return-Path: <linux-pm+bounces-11314-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC0E93958B
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 23:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E4A1F22253
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 21:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6343C684;
	Mon, 22 Jul 2024 21:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aekZUnLU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047A03A1B6
	for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2024 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721684101; cv=none; b=BmxcP6WLQNoJsxGcfVBk6h2KEO5CrGBNmltE0Cc5USCo+TiBvsLenr5dJNz+6NtcOdFEIRk8VJCkscKO6sww9rvLvNRDYx58fs1JGppWbYhUlTB2xRWV0I8VKBlGzQlU1uWlHVXJFk0pYD5YFgWeGPb828pv81y6D7ua2JJJVZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721684101; c=relaxed/simple;
	bh=DavKR6zlsHTTROZB3HzBGry3JUwnrQbFua6WuPnbWp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXGohx6L99eq+tuRFxPXkuRn0ufZqtlVsDYdZWa7EMVxJ+xpr2cZRPU/4hu3JK0z+Iy/FK1+aHkxRtJha3ecQEwUFfU25erq8HWBXApVEMSYU6ALF3BrfLobLioXtHB2+QBxRlUrRg1+4aNBxBnLIIIBw1PyDTvlberlJrzmOLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aekZUnLU; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-66c7aeac627so17500927b3.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2024 14:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721684099; x=1722288899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bew7kISzf+Slt4HQdKRNoanuwNUVw3tMPgUQzbpwb8I=;
        b=aekZUnLUk6aVQQAgVJgBppyLsk0PRN9IP3rzKx7ylYE8JRGyYy+TrkHglCYMPWxMn8
         BZV5RWHtRN9Wa5gHBRlg2ui7OFf1DHkwgfYCxjYn49ixRz+spE2wri8jSAuokf4loICb
         hC86S5Vh2YXwlasYBV+eXXPSJjz9/KRyPgHF2/hmoxxvWQhoSHng7XRORlBep+dl5AVy
         HOgnuCgYkBjj8GzDshFwr9Xt7Atw8kltCkl6Wkwu7pO19e6M7L9CY/qdt33ESL5S/S5n
         +PKY5X8+G5OnYSaPlSBTBp/SV8zikL2ovoFwnX8hchTla+I2sOpLBNvUPTLDswDMGDTy
         rBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721684099; x=1722288899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bew7kISzf+Slt4HQdKRNoanuwNUVw3tMPgUQzbpwb8I=;
        b=QEbDM2hqeFfpUQqdKZAyO6sd58ZlDLlse2OBuOuHURhnd5TzfmW4dyU7bYWBCkrnJ5
         /DvLZvAuwIe3ylvEh6MIzXHicMDt8n5szKbp7ldtHaES6XWqlXcYRcy1FaKXfLYoPXtb
         fHvrHIZQdtjtDENffBl+6ea2TfTk8LleSsjImWsMqfUB1gSSaz/ux83MvZOdGWlBp9Fz
         HGfit3CBoz6bQlMwu/TD1ByxlU1JtPo67qSvPEUPUo+M+0m8Pz4R96L9JQdfUz2t5OQc
         CEp7Jt+GbrcPJkKXhMvZbGbD7i0VqY7JN0v4c1ys6lMJ6zLYBNqjIpx3KxOM2MNdkSc1
         TEOQ==
X-Gm-Message-State: AOJu0YxlNwUS4/ddYhyECizQX/zZMa7qnxch9pNqCIs5XRxGKvnzOG6H
	+lSt0G6jluK8cgtASV4wkjKmJC2yaflnm4NuBRIANM9r5+zhtuqsD33hIKHPlb1diLLrt1Ac/lG
	GilJITlGEa1hm7j+rfGQsx6VZxPAacN5K8hi3Lg==
X-Google-Smtp-Source: AGHT+IE0ltDhbLmGYW/fyUnYlpSuwc7uDLK7DxqB7eIHLb7TN7siloOmPdFA3AK/XHiKBZ174IJiHQAZ67jbE8WFQIA=
X-Received: by 2002:a05:690c:298:b0:66a:843c:4c58 with SMTP id
 00721157ae682-66a843c5e32mr107931177b3.34.1721684098995; Mon, 22 Jul 2024
 14:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240719120949eucas1p1b061c716ac55b4a79ba57c407c0b2d91@eucas1p1.samsung.com>
 <20240719120853.1924771-1-m.majewski2@samsung.com> <20240719120853.1924771-7-m.majewski2@samsung.com>
In-Reply-To: <20240719120853.1924771-7-m.majewski2@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 22 Jul 2024 16:34:48 -0500
Message-ID: <CAPLW+4=MSeYjWs4GbriiY2rj8FsZ0_GGVRqfxV9GH4VxDREKCQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] dt-bindings: thermal: samsung,exynos: remove outdated
 information on trip point count
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 7:10=E2=80=AFAM Mateusz Majewski
<m.majewski2@samsung.com> wrote:
>
> This is not true as of commit 5314b1543787 ("thermal/drivers/exynos: Use
> set_trips ops").
>
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  .../bindings/thermal/samsung,exynos-thermal.yaml           | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-the=
rmal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-therma=
l.yaml
> index 4363ee625339..5a82764a4dbb 100644
> --- a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.ya=
ml
> +++ b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.ya=
ml
> @@ -40,11 +40,8 @@ properties:
>    interrupts:
>      description: |
>        The Exynos TMU supports generating interrupts when reaching given
> -      temperature thresholds. Number of supported thermal trip points de=
pends
> -      on the SoC (only first trip points defined in DT will be configure=
d)::
> -       - most of SoC: 4
> -       - samsung,exynos5433-tmu: 8
> -       - samsung,exynos7-tmu: 8
> +      temperature thresholds. The trip points will be set dynamically in
> +      runtime, which means there is no limit on the number of trip point=
s.
>      maxItems: 1
>
>    reg:
> --
> 2.45.1
>
>

