Return-Path: <linux-pm+bounces-11360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A5093AC68
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 08:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A829FB22054
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 06:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04FF481A3;
	Wed, 24 Jul 2024 06:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kv+4BCwx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB8623BF;
	Wed, 24 Jul 2024 06:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721801112; cv=none; b=Fyqw3I9CWx6nfQQYfn40Vz3XP3pPP7DbacNebgIjNL5M/fn5+xMcZPR6Bjo91SvixFUh9h5Tubvj5g6KnMBCZroCRfCGYtBPAXAasgz0d47E/b8p6VTveKRyCIHKZaG1V+bTDUC+UTHwHYS7tS16gjT9tE5/BpjREyeizU//25o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721801112; c=relaxed/simple;
	bh=NxVtYJJ3z1OoFhssqyiYJT/N/u7b/FvNj4qvvEapLxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZ4K/Vql3j++fg+wIQTxPK5LVy82HPbGkWkp09QQICdAbb254LA6uTO+sqzBdMOGmCGxCk5B1Ip00vvRWEUG+8REycKrXOINprgMB/D0G3hS54IYDxfmAQgHkD/zoRSawvbfjAGB8bF9Wz2WAisW6xBWZSx2pgQ7tGYL7EgvNzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kv+4BCwx; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5c667b28c82so303865eaf.1;
        Tue, 23 Jul 2024 23:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721801110; x=1722405910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L72rzBlP/G9oUEAncjGrZ3wLUVvLS5Pa33V4pN1/77I=;
        b=Kv+4BCwxGxQTj1Q4Qg3dxmoBIFSGhWE6O53V5Bm4R5L+KYrCm7pmG0DzHeTnaxDxLw
         iQypEHxJV7ZT4wtZLUJMYD4zGMhYUmrDeqhwld8WfOPakS+VJeUEpxH47GmsOG0jm24N
         N4DZo52Rsq1MqYQp/BgG5UE1Ga3L7I8iql2uPYtMdrJ52PdolLAlPkwX/QjWdJUoX6+4
         McU+0yfYRrvLw8L2eCvSevwQ0Jozyqqs3+L8vNktkSvewHsqU8N24FrwdUmf5Cqk6AgP
         ZC633XaviWxEU4G1pfduR2epeYE6nncGmzJbjlY8RcErJ0Ij56zNVVVnhaxMHN3O2t2A
         FWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721801110; x=1722405910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L72rzBlP/G9oUEAncjGrZ3wLUVvLS5Pa33V4pN1/77I=;
        b=dg0k7IqnVZEVn7Ru26q30rSBjRAMUsk/ds9BF91w1WXud/6eTm5HXdbJRYrS3g6/N1
         YBZ04HXrpZA720PlkraAEeOQ/bmL9lk6K5cgaS5rcnelGIaIB7VprlaE7vGjaMXxfdfy
         gtPYYYRbzmLKbF3jWHOZieRZdqnY1GVOkkuBkEe4nvDFDDK6EayWvwgxu+tRnZDtqh9i
         cK+n/eH9fPcLd2DYj6rsKURLS2OsOpfbA5A7WgMpOuDsQZf7Pu4p/0QaJykby4pGqonz
         rpdjSNkbYyfW7og8w/5hUKJPfVQ2fiBInTopWA0UcuTwq9p9r9bV+54FYDVvnhLZBqAp
         0nPg==
X-Forwarded-Encrypted: i=1; AJvYcCUmZqgggcS8saNWp63FBz29tyH3IeQQu5dwmYHLvBR0cnPFOYsgg8hjGdoAAeRuiKoIsCt1rnLKFM7s0vPeK3R4scIy0RoHI/oELWmF6R6UUN1cuMEYe7uamP7UUQrFq1di0DG+qKG1grTYkOP7uarm2wnwdbGoPqexFvhOpp8dL/EkjwUrecIX52lu
X-Gm-Message-State: AOJu0YyxEBMNN8DdnopHATAhgwFmUoj9jPOfBnOAQcK9cI+zOp3P/mY7
	YwcUwPyCCz42NvngraJWTZ5SDHgEWtbk14QbZi3Dus+0AmSFaXMcvM+0m8vd9jSUK+r9DoxR5F6
	JIlnIiqFeMTvCxIRAVSjFYJNHp5A=
X-Google-Smtp-Source: AGHT+IG62pNB/TIqr706ceimvNTt0OCJZA56dGyadNFdz0GmSRDb3F3dRZvy33laMIYf16b44L8ZuOwHdOCUx94M1d8=
X-Received: by 2002:a05:6820:2607:b0:5ce:3ccb:2118 with SMTP id
 006d021491bc7-5d5a20a59camr358135eaf.3.1721801110263; Tue, 23 Jul 2024
 23:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240719120945eucas1p2aa5e35f78daa7ec1ea07f512180db468@eucas1p2.samsung.com>
 <20240719120853.1924771-1-m.majewski2@samsung.com> <20240719120853.1924771-2-m.majewski2@samsung.com>
In-Reply-To: <20240719120853.1924771-2-m.majewski2@samsung.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 24 Jul 2024 11:34:53 +0530
Message-ID: <CANAwSgRe4zmi67tttOiYswRGzU8choBfiYXy1y+-2_ntg_mZ3A@mail.gmail.com>
Subject: Re: [PATCH 1/6] drivers/thermal/exynos: use DEFINE_SIMPLE_DEV_PM_OPS
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"

Hi Mateusz,

On Fri, 19 Jul 2024 at 17:40, Mateusz Majewski <m.majewski2@samsung.com> wrote:
>
> SIMPLE_DEV_PM_OPS is deprecated, as noted next to its definition.
>
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 96cffb2c44ba..9b7ca93a72f1 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -1150,8 +1150,8 @@ static int exynos_tmu_resume(struct device *dev)
>         return 0;
>  }
>
> -static SIMPLE_DEV_PM_OPS(exynos_tmu_pm,
> -                        exynos_tmu_suspend, exynos_tmu_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(exynos_tmu_pm,
> +                               exynos_tmu_suspend, exynos_tmu_resume);
>  #define EXYNOS_TMU_PM  (&exynos_tmu_pm)
>  #else
>  #define EXYNOS_TMU_PM  NULL

You can drop the CONFIG_PM_SLEEP guard and use pm_sleep_ptr macro for
exynos_tmu_pm.

Thanks
-Anand

