Return-Path: <linux-pm+bounces-2483-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B1C836C1A
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 17:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17C50B3251B
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 16:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C035A780;
	Mon, 22 Jan 2024 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1dXNhgZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76B55A10C
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936944; cv=none; b=kaR3umQw7JxjfFTIcpX4ksei1RN/UZrcpPkbAfC6E0UnfGb8JkLhjEgiDOfPDvGn3+MkjzBLf+DkjgmF6UrlIuihR/EHm+bvWy9tNFt4pD+7tZnH1OTcY8n1GIb0xZT9SZd5JwOVRE8NGCwReAXZq/M9s40tQ9qwBfmfJjDplTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936944; c=relaxed/simple;
	bh=kPHw7M7MZ9eEaPEcUx+Jg7AAgahwXs0PTULrhciRfAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELCWwPNcMuyUnnlQiBXinxeXVq3mb/pbeOXGDvL71FNrFfAPOBvd5FiuwcswW90OhISMZrXS9lNlvkzLK/8wN0xOOm5lFGF42J5VVRT/ttKm4i8DwNBA1oSKe6OU76x7oeNICBoqGwwPEDxezc9mhSy6Bcdu0xBZRfxqTtuRfOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S1dXNhgZ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5ffd5620247so12602957b3.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 07:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705936942; x=1706541742; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xhBZ9e9dLCiSrnfGs3nmyAjRoc3LyZMuLRLZxqI/JA4=;
        b=S1dXNhgZI6vB5ZNDtnkwBge5HyKwHTwWvYfpq6G+u6hIbMxrOYi1dKWaWqOeW0Vszg
         QgkuyW69ZV9UPdFRR9lSB/ip7909R2JFhdEbbMAdf/Qcvk2LY06cpGRvLLIKHPkU0+r9
         CXvJPPWTLv0F4EZGg7TM3ExoT2h6qgw91Mxy7bxS40mT4S0njNteHUg8NSIzg/QF5Y/9
         ui4SPDmCRKcEpm9MnapOK8B9ZANe5N5CdVTR4TFkFcBzGhHpaA9kueMM6fUrN1TGA4E3
         TU3++YgsnSpUu7JRLg3uDabLWCGjtx5tmvoJrTqBGgIwgmEeiZ0mj/8fCR2i1gwrJsEa
         p07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705936942; x=1706541742;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhBZ9e9dLCiSrnfGs3nmyAjRoc3LyZMuLRLZxqI/JA4=;
        b=BHueuw0lWQx7tCQCnLq6n7DcdRq/x7HaK7c7xc1n3Ph2kOCF4vb61jneO/D+lt3Lw1
         W4DZxI+OlIXwQBmij4/nN3qBpYEaDgpN6UhIhe3zDl9S/Ig0F6WkcqArN88hnB421Dgj
         bimpxAhalJYldKlQxA1nhycFDJYjBwbY96KmoJhc3TAbPWoS4m8CBz46VhYGOBEt1Xx9
         EerEfH04yEokOMV3Sk1r1o64n6Vtwig0MEYpAG7ecNTb6iryNBMY7aNaY4fsnNnmlQ9U
         QnrPBalzUGoAA4N2Z1LD7NP1qad1Mn/dIvi/zNSkEwZJLVmoNEl5aH8/sw3N0SmB+u5b
         j9JA==
X-Gm-Message-State: AOJu0Yw7yZdqohNZT3JyRHeKnek1CjbrqUcJQAr7RnyiF8AdQdQmSNTs
	jKR4KEHwVTwCPUCoVnKt3VxPesfuguyJA2V0A25LYje0uTPj5Ol5vehojVTtRDvmrLZ+PS/ekCD
	BS9e3ublX65xSL7POnJj6m6IM7J82m+/KETk9nw==
X-Google-Smtp-Source: AGHT+IHd/fvKIUJxwGz07cv8IEIgNcZpwAcQu933thnIQtqo3S8U61IJDJRgX99QNFbuv7Jd6cgESfTtcrmge+nyvPQ=
X-Received: by 2002:a0d:d906:0:b0:5ff:8117:4e7e with SMTP id
 b6-20020a0dd906000000b005ff81174e7emr4242032ywe.70.1705936941994; Mon, 22 Jan
 2024 07:22:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227-topic-pmdomain_sync_cleanup-v1-1-5f36769d538b@linaro.org>
In-Reply-To: <20231227-topic-pmdomain_sync_cleanup-v1-1-5f36769d538b@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 22 Jan 2024 16:21:46 +0100
Message-ID: <CAPDyKFoer83wwCYyXS5S5wM8HcezyUDdxcW3d4Z+za0XpykSAw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Move the unused cleanup to a _sync initcall
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Dec 2023 at 16:21, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> The unused clock cleanup uses the _sync initcall to give all users at
> earlier initcalls time to probe. Do the same to avoid leaving some PDs
> dangling at "on" (which actually happened on qcom!).
>
> Fixes: 2fe71dcdfd10 ("PM / domains: Add late_initcall to disable unused PM domains")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe



> ---
>  drivers/pmdomain/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index a1f6cba3ae6c..18e232b5ed53 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -1109,7 +1109,7 @@ static int __init genpd_power_off_unused(void)
>
>         return 0;
>  }
> -late_initcall(genpd_power_off_unused);
> +late_initcall_sync(genpd_power_off_unused);
>
>  #ifdef CONFIG_PM_SLEEP
>
>
> ---
> base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
> change-id: 20231227-topic-pmdomain_sync_cleanup-ae73d04133ec
>
> Best regards,
> --
> Konrad Dybcio <konrad.dybcio@linaro.org>
>

