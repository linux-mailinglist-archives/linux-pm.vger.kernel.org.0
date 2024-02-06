Return-Path: <linux-pm+bounces-3486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DED84B89F
	for <lists+linux-pm@lfdr.de>; Tue,  6 Feb 2024 15:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61771C247FB
	for <lists+linux-pm@lfdr.de>; Tue,  6 Feb 2024 14:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AA5133431;
	Tue,  6 Feb 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SWXIoCxE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B06133429
	for <linux-pm@vger.kernel.org>; Tue,  6 Feb 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231362; cv=none; b=YFMsVB2BBgsXNQVcgX3R1/i8WE59Eh0j6Di/9l1lZUAGfDXySf07HNbNyuw2ZrwvuS70NVMj00JpWs6JU40axwPmYRyYfDe2lEdYDkAW2hpcVManXjJWIoxG1Avk8v6JwnOPebTU6QyUVKyBwX/4uOfExyRxM2djQzFoe/4VMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231362; c=relaxed/simple;
	bh=hXolM7uNjrqi4kvTV1pVtTTaI60yBGc/tHdLQl6Jd68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpH80O8s1k89am0kLvq18FLVPMU2VQWb3BLKPadI69dCKFOVRZnNJ3PtzFdS7UeViaDHLq16IwT0UqeTBc54xEmvPPHmCxj7Jdw9iLFiYYX889BP7qSFWX94+QNJOPTilSayo125L0udcAZ1HRzHedYzyxw3jXsOirldqOr+4h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SWXIoCxE; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-59a8ee08c23so2234878eaf.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Feb 2024 06:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707231360; x=1707836160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JKCZke1KMPopQ9RKPdCxdFTkVP9U+Bz1cnxAljvkmYE=;
        b=SWXIoCxEkE7gxoZcd8yCWS72shPdnhLgjxYmrAxh70zJq6Zs1JgzBCAdIkaR/biSgI
         ywQFPM5Y6+jBqrWmro71jC/IJc+wxykVMpO3flRlJuK25WD2ommgk2PZqyXjCjnWCY1R
         Hbf7gB6yG2liZyOIlwZiC/AModrZ2tkV8PkpzPb3/xe3chWfScZPrqCEEPCFkW5sOUjD
         BfPvMw743aVPDaUEOaQ0opBMlZXofY2aOEymKPaSfB2im/pALYen31TL1w9yYCxN14sv
         WW9thKxlSxszgcBlFd6Ay9OC5WWNjbGhweW1fLsIE2u2HQ7Qfbbp8k4mzEYTtIK4kUq0
         0k0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231360; x=1707836160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKCZke1KMPopQ9RKPdCxdFTkVP9U+Bz1cnxAljvkmYE=;
        b=T0MZ0F2nCdYGXNEqltJbBQPsVkjk3wHoosCCnPPxrs7YATk65BoL0iJqQaXi084EsJ
         rTAVO6+Q1lwdHGkeQc76hYg4davosQK+O5FwFQEph5LyotDf3Xi7jtLl636xaPJuWaKS
         roUh41uWr9929hQmuJgJWy1abl04D4pNbmeudOdE3eEFaBqPvrdPFls+Id0a9jVnoV0Q
         mX1RPY4nza8GWQ0PG/Zzo6wSczn19CHg3otuoz1+lWczqt3MD8vCc1conMdvx76nFviR
         SHPTtgDFoDkGX2PLC+EdYZlkdzZPmpd1YIQPwSK9jF+Qz6KWLpLfIIWA3frQRZ5sgveJ
         SvbA==
X-Gm-Message-State: AOJu0YxCstGJuQ1C3uX1VIAgJ6Sya7TD3cmEF6MzfhAk9cOsmBohNmVb
	0x7Huoo41mikBn5ZBbRYsRW7Yx2RhXO/1xFFbMiRzJmXIB67ZtTnrKnAN4Jt3P101urRs+iFc08
	uam6wvCgTnizDoGTtK0v+JpV9WMd1i5IYhASQtg==
X-Google-Smtp-Source: AGHT+IEjZNrhvqIStbF4U44ytlGPmSnzsLH2enASrVkowIdVD2zLnzSWnYbwn6i/81EJzWZPXL1iPryIbri0vd8KjCI=
X-Received: by 2002:a05:6359:4113:b0:176:40fb:cf3a with SMTP id
 kh19-20020a056359411300b0017640fbcf3amr2357172rwc.14.1707231360167; Tue, 06
 Feb 2024 06:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <da6af483-5ee9-45cd-922e-d9d5364674dc@web.de> <CAMuHMdUxn4Ne7kmEfONz8Uk3Why3m9r83GdM5RzTxm_4Gj_a6g@mail.gmail.com>
 <6e397bf2-1d45-434f-8619-58a737a138e3@web.de>
In-Reply-To: <6e397bf2-1d45-434f-8619-58a737a138e3@web.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 6 Feb 2024 15:55:24 +0100
Message-ID: <CAPDyKFrVgHKXrps5wB3yhOK6JFdBeW8zzYHcQJC1RVs8PXJgOw@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: mediatek: Use devm_platform_ioremap_resource()
 in init_scp()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, 
	Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Feb 2024 at 10:21, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 6 Feb 2024 10:05:34 +0100
> Subject: [PATCH v2] pmdomain: mediatek: Use devm_platform_ioremap_resource() in init_scp()
>
> A wrapper function is available since the commit 7945f929f1a77a1c8887a97ca07f87626858ff42
> ("drivers: provide devm_platform_ioremap_resource()").
>
> * Thus reuse existing functionality instead of keeping duplicate source code.
>
> * Delete a local variable which became unnecessary with this refactoring.
>
>
> This issue was transformed by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> v2:
> The transformation pattern was adjusted based on advices by known contributors.
>
> Examples:
> * Doug Anderson
> * Geert Uytterhoeven
> * Robin Murphy
>
>
>  drivers/pmdomain/mediatek/mtk-scpsys.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/mediatek/mtk-scpsys.c b/drivers/pmdomain/mediatek/mtk-scpsys.c
> index b374d01fdac7..59a7a8c261ed 100644
> --- a/drivers/pmdomain/mediatek/mtk-scpsys.c
> +++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
> @@ -425,7 +425,6 @@ static struct scp *init_scp(struct platform_device *pdev,
>                         bool bus_prot_reg_update)
>  {
>         struct genpd_onecell_data *pd_data;
> -       struct resource *res;
>         int i, j;
>         struct scp *scp;
>         struct clk *clk[CLK_MAX];
> @@ -441,8 +440,7 @@ static struct scp *init_scp(struct platform_device *pdev,
>
>         scp->dev = &pdev->dev;
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       scp->base = devm_ioremap_resource(&pdev->dev, res);
> +       scp->base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(scp->base))
>                 return ERR_CAST(scp->base);
>
> --
> 2.43.0
>

