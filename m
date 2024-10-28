Return-Path: <linux-pm+bounces-16576-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2819B31C2
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 14:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC991C21929
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 13:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4F81DA636;
	Mon, 28 Oct 2024 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NyTVySn/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354B72AE8C
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122444; cv=none; b=NJAqf5FAWGLBQiuKseDrNf/L4r/98UkFSB4B1wWBAG8ruRtEodWzXvwdJ3m7F3G5WCqKsl/mWWPTX+IM5iqYuKQLpiFUX/huI/4xQ1uvH7O+3JKj3RcCQVPJ9x73TKN+dUCIRiKZlRTyp/ZWGgGRxtC0W8g4718wjRrHNJdATmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122444; c=relaxed/simple;
	bh=Hkuw0HsMZTAZzklGG+SikM47Il8Z/dFPLYepO7YC7uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JaKWuRRePZ2Pr+v710PlNeuxIIRLzKvKxekApxSLTGn0Llm8l4/TpiGXGrqcI52DRrj793pV5DrGIhlgPRedqk1jvQmIiGkPwWrtUlJh3tETr+xBHg4OY0hCf7SGkz2ppbjgm9iCs5brJr5YE9iJpX9Obt2zAhuS4an+xn1dldc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NyTVySn/; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e39bf12830so30737267b3.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 06:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730122441; x=1730727241; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SYzKzo66BsIMu267mtmk0h5Sc03Gos4rGGJcCGOcJ3w=;
        b=NyTVySn/a4X4rsWFgjV2jYHKDYMFaTtHiA2YY61hovGuftbkuMZAxxGxOAn/Z3QkaV
         JH3ntNhALj/ar5LjiI6CTIFYaryWrVqr0JuY7MXvsJGveFL46Q/nvvQRnNemEWYoZv2a
         cPAdXMJWm11xLbqYHuwoSE7OWSo4wzkf+s4K+9CSn1LOVnNYhkRf/kin92AS80vLrZUB
         v+ZHHruxJwuttKJ4VK7inU/wGfsjqZ7soP/FTbTYHSk9Lw/Tm8HwQohI4OZzYhr+rS9+
         wodSnDRgqjIx+KfQk8fQA4W2rbPTwClj8h6asw90PldjaXxXmhfTORAESQuU8HIEAotx
         xXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730122441; x=1730727241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYzKzo66BsIMu267mtmk0h5Sc03Gos4rGGJcCGOcJ3w=;
        b=G1Upz+sFy6/MsaboX1n7ey/ju9ydJZsTZUkR7Jdmpjy2icl+4+pkdSPl0ib5Ep1Gtf
         maJ+ztpykV0GrWOze0k5FjuXbe9qoEkDdrTQmxXFOCK/nwbMsuTF/+0WL9im/WJSoQGY
         ZJq6sFMTAD1xLXbWLlbfCjaEPNlU97oGkTKVyhJPUsCjQQCbSA1Eryt1PzG2FJGOPxkN
         tk3VZB5xkmLjbqneoEwGrrQIxTtJHHzrmZIOg42qF0kqW40chOEGirUbTvsLTwWVIL6n
         zAZ7wio03hNmZaK4nUZXNy6uTd7Vs3nRNj/6RINauL+VKNZPq4poQ6Bf4WYz8XSUYiCe
         gCdA==
X-Forwarded-Encrypted: i=1; AJvYcCWmEcK9/3Xp9lQDpLz8xkq+7vkzIprOlmoBIcOSvBHPOJKfHJQs8PuaEJzR2YXN9iv02wf25r1Fsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEV03EHFMj+4InxoJ8IzOo8sylprFkvKBpbRcEdI7SI78esGkH
	cUNK8Kb0vz2txlGMXgRa5vIMoRfeCb8y4Q9wtA2xpYZZH2W/ruLxPK2ca8BLPCN3O2J86WNoDkA
	v5sjfCwv9vbGSj7B1bLefqB6d2As/S1isHdcGuw==
X-Google-Smtp-Source: AGHT+IGGrnEkq2Csv9Fhr7cK77KAAx+dwPKc2XqpKhV7C1rM6wW93+Gue8eEnm4PDIutRTr2OvSsfClmR3e9JZ5bqVs=
X-Received: by 2002:a05:690c:6b0a:b0:6e2:451c:df02 with SMTP id
 00721157ae682-6e9d8aa1064mr68679197b3.16.1730122441097; Mon, 28 Oct 2024
 06:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024094930.3221729-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20241024094930.3221729-1-dario.binacchi@amarulasolutions.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Oct 2024 14:33:25 +0100
Message-ID: <CAPDyKFqqCWt5oCj6qBuP_oZ=O1kmkfMirYETPXEeW-AmiA9P+g@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: fix "sd_count" field setting
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Michael Trimarchi <michael@amarulasolutions.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Oct 2024 at 11:49, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> The "sd_count" field keeps track of the number of subdomains with power
> "on," so if pm_genpd_init() is called with the "is_off" parameter set to
> false, it means that the power domain is already on, and therefore its
> "sd_count" must be 1.

genpd_sd_counter_inc() is being called when adding subdomains. Doesn't
that work correctly for you?

>
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>

Kind regards
Uffe

> ---
>
>  drivers/pmdomain/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 5ede0f7eda09..2df6dda98021 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2221,7 +2221,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>         genpd_lock_init(genpd);
>         genpd->gov = gov;
>         INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
> -       atomic_set(&genpd->sd_count, 0);
> +       atomic_set(&genpd->sd_count, is_off ? 0 : 1);
>         genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
>         genpd->device_count = 0;
>         genpd->provider = NULL;
> --
> 2.43.0
>

