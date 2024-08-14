Return-Path: <linux-pm+bounces-12203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02652951ACE
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 14:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F661C20328
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 12:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0C21B0120;
	Wed, 14 Aug 2024 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k7sR6p68"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86CA1A00F3
	for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638464; cv=none; b=UW5P6ikydbdMgmCtwmLZ/tk7JQet1Q1bIrb0yoYmG2tptXOFGwiDt9e7XmdU6HBfdL/QBxXp0CTEXygDZsrv3poDWttNqORmr4+O+jyQUeSGJdTrr1WPVkbkncxtFrgbV2zvhlSNzu7qCuRTpLE1ZN9jg2IWcKHo9WCA8XIzMR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638464; c=relaxed/simple;
	bh=MCOk87ltZF6H24V4o3EuaT8TEO85EAEEdjQr/69xPv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElpIJbpVAyjbWgXMAqJ8rqgBrcjmALF1Bbx3qTHtpTJhsYimqSr4WqfcmplKUj1gHIcMFI5wbBgCNh6inFEJUpeSOyRpeVXvENfzdjKiPJOZc2Z/3wDiKWOWlMtOUtFvZfeQnMsx7fFRorfnqA1MiyVuHpNrfC+NcL7G7rz4bwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k7sR6p68; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e115c8aa51fso572866276.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 05:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723638462; x=1724243262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9qLRZtDKTr0jSAm7vgxxCmZiYCAFJZ6KbzLPsYTR78E=;
        b=k7sR6p68TNyMvDbNuMi7MIKE0abbXQn+tQJsMWlCcQRm1R5fMzmTfypX41WMOYjiMn
         zx9gEpYHfZVzaOuSyWHfIxsg9oLRCUq1gXAT0QBhM3Zd/cJ5jDREDxKVLZzD2drB2bcR
         vbFEQSW0E8HVdsvvfjqSBnClpAoU936DP+W9NLT3yJ+7CJ8+Q+2teJN0vvUWdgJZdHmt
         xmAtrCLeDqRbwsEbibskG4NtDptg52e0Txg7itMHQVCRYibigmTXRcGo86d1WDsZUFzx
         ybNZ1goL6WeghuM+j+1FXXhdgGoyltSPAopUaWQ2S9UBPCE8uUhmlsureH4cjYPMYN5G
         Gdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723638462; x=1724243262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qLRZtDKTr0jSAm7vgxxCmZiYCAFJZ6KbzLPsYTR78E=;
        b=somvzbFyb++QzV0SIxOfiDeO5+8gtuvqNiAh9lq31afvkN+Qznz/SeP7kmd4EMfsWP
         aHOLBM8uGMZ3g1vCpBgWYDcTGrMMSGr8ovzP3pcBCZm2zOdRxenchuKJE0nKRb1Ed3nT
         +j9tPvHr46lqvFszay1Wc1wTM4b5/B7dyeUreK0CDqe/yT8EJVQopn6s/Pc6zU9Aqy5X
         2MUhMHlJEpjtLlNfLE0kcTerwb8Ax1Amtg+Gyfj19VnRZDrAr7qSiCGOp75JaknC4bfZ
         AZ+uKcgdkh04OtzIM2DOc/WwohOX6KbmgsD08XAiHEH8zkIdugkclCcCGpJNgCG2V+kn
         7BUA==
X-Forwarded-Encrypted: i=1; AJvYcCWtT0HUDBkqGA8kT7E6sH6F9RKWjfFa224n1+VzkLk0hlEqHYfqFF1Tx0mcksPNF8bcREGIC0FYYXvjTFHJmGVtSlOFyQ7LY28=
X-Gm-Message-State: AOJu0Ywuu4lPtcv3fAucuFK1gfXHuw3wfif9ajm3h47mjIxD7a3WNG5t
	0maoRwa4puocHcS44P5uR1Puyrb7kh4OOYpbpM5n/avExCl0lLcJmOejpUFHfBaP23d9HfDRW+R
	ugQ0jequ5mFrNRK/MrFuD/s18UIS3KvUpERCqjQ==
X-Google-Smtp-Source: AGHT+IGZNeDFwFKcA5hs1O9iOJjIbT4kC9fliekBbf25Kpj2PSN73rKcDwW575WyFIjWIU4Us23LFsHtHqbVvg9DljI=
X-Received: by 2002:a05:6902:2e0d:b0:e08:8d4e:ccc1 with SMTP id
 3f1490d57ef6-e1155bdce60mr2569783276.54.1723638461945; Wed, 14 Aug 2024
 05:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813085748.2144637-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240813085748.2144637-1-peng.fan@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 14 Aug 2024 14:27:06 +0200
Message-ID: <CAPDyKFo_R3=MK9pRzzG2mV4s3HZKGuoZ1kxoNVLwGAqFirupNw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx: wait SSAR when i.MX93 power domain on
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Aug 2024 at 10:49, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> With "quite" set in bootargs, there is power domain failure:
> "imx93_power_domain 44462400.power-domain: pd_off timeout: name:
>  44462400.power-domain, stat: 4"
>
> The current power on opertation takes ISO state as power on finished
> flag, but it is wrong. Before powering on operation really finishes,
> powering off comes and powering off will never finish because the last
> powering on still not finishes, so the following powering off actually
> not trigger hardware state machine to run. SSAR is the last step when
> powering on a domain, so need to wait SSAR done when powering on.
>
> Since EdgeLock Enclave(ELE) handshake is involved in the flow, enlarge
> the waiting time to 10ms for both on and off to avoid timeout.
>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Should we add a stable and a fixes tag for this too?

Kind regards
Uffe

> ---
>
> V1:
>  Downstream R-b tag kept
>
>  drivers/pmdomain/imx/imx93-pd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/imx93-pd.c b/drivers/pmdomain/imx/imx93-pd.c
> index 1e94b499c19b..d750a7dc58d2 100644
> --- a/drivers/pmdomain/imx/imx93-pd.c
> +++ b/drivers/pmdomain/imx/imx93-pd.c
> @@ -20,6 +20,7 @@
>  #define FUNC_STAT_PSW_STAT_MASK                BIT(0)
>  #define FUNC_STAT_RST_STAT_MASK                BIT(2)
>  #define FUNC_STAT_ISO_STAT_MASK                BIT(4)
> +#define FUNC_STAT_SSAR_STAT_MASK       BIT(8)
>
>  struct imx93_power_domain {
>         struct generic_pm_domain genpd;
> @@ -50,7 +51,7 @@ static int imx93_pd_on(struct generic_pm_domain *genpd)
>         writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
>
>         ret = readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
> -                                !(val & FUNC_STAT_ISO_STAT_MASK), 1, 10000);
> +                                !(val & FUNC_STAT_SSAR_STAT_MASK), 1, 10000);
>         if (ret) {
>                 dev_err(domain->dev, "pd_on timeout: name: %s, stat: %x\n", genpd->name, val);
>                 return ret;
> @@ -72,7 +73,7 @@ static int imx93_pd_off(struct generic_pm_domain *genpd)
>         writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
>
>         ret = readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
> -                                val & FUNC_STAT_PSW_STAT_MASK, 1, 1000);
> +                                val & FUNC_STAT_PSW_STAT_MASK, 1, 10000);
>         if (ret) {
>                 dev_err(domain->dev, "pd_off timeout: name: %s, stat: %x\n", genpd->name, val);
>                 return ret;
> --
> 2.37.1
>

