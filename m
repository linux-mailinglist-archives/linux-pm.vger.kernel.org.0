Return-Path: <linux-pm+bounces-12206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F67951B4D
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 15:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056CB1C21584
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 13:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839731AE05E;
	Wed, 14 Aug 2024 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wyq7uAAS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B51566A
	for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640493; cv=none; b=NvEjJMwq866K6lMaP6qzMgSr8VaXac6XJ42KCKM5LuKHgsz93tp+Up36D3T1lSZNKGrAXKkbsjSDXH7SysJK7COSVSUP9R9HTLXnlDn2kuAHP4jeBIv2Koj8uLzvcAFRd9JIc/MU5HJi2XVLOV1raubNLQ2qXV0CMcGjvFEWFJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640493; c=relaxed/simple;
	bh=q/uJbkjsZVe1udBwRTk4Z0NblBdsbyD+dlaoHPUzTfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzQnBR3syAxDGqIwWoa7b/Mz1hOMrycGQiPdCOZ6e9we+O4qlHAyqpJ/B2azeQCzYwUm9AAOgWJutXfLnpvA4wb3p30YXdBDSruRtsErd57tzhH95CbVa88HsG9awtdjhql99mOq/FEF+DH/ZI6lacUHWWfZpdLC5YLiaPni5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wyq7uAAS; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e0bf9602db6so6412793276.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 06:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723640491; x=1724245291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7jfobO0h8PCWvLzZDgipywq+q6ry4w+xtSJdMM8OsI8=;
        b=wyq7uAASsaengzfHPU49sQat/HWe/WmS1L2lwZ9yYY2j3EedHaQqDLk3ZkuNxcF8ss
         S5Ob9Cw96H22xFbaLJO/oEPdsESjpW3vc9HvvGzSon8+6KqZ76LDwBr6EdCcHnbhaCwg
         iNNnAPenqd2k8ECjACCeG1RhuGRm2Siz33T2Zm1B11LrEgLwfNn+mltmnyV5Mcshb1gw
         A8MlisojbKlFsYNgkcwQAyosiWM0xtm2vugCDrgvPIP/1bO+VxdLJXAQH9qPupM4iM8Z
         ON0bie1ck1YaWWsPOmAgerNSipCuAsOzcwLiFqYkRP0KmyIz2+avqycYiTzAOCWuqwBs
         OKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723640491; x=1724245291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7jfobO0h8PCWvLzZDgipywq+q6ry4w+xtSJdMM8OsI8=;
        b=KUuUHjg7X+tu5PBS/a6JKkAtwfS+OMUN9XUyJ7HTgHCkdrbQh4jwqPWD0O4Rs7UALD
         m9XmRW2Mg6WK7TW6OuucBOeDuQa1EJZS6uh5TNzgX4HgJywgeD2YEBD3e2zvGvoHlYpc
         WTHIk+8l/4a8jBzOeJYfV1Nb+lbIkrAtjvNSwLw/y1bYgTeNk/SC6vkP9Ie9M0CQihVH
         SP2mqpz/QOuvpFgP4Mh+hRZEjntzORWB/zt5EHqyw5uknk8OU8ELsa1081edOWqXJrfN
         PaSJ1/LSFRYipNhdhJ5bvuVlm5M04Z5hllOn7qT9j6/nqrN5ifjqHJX0/thynYSXpk+V
         A5Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVY068dEcIfZ2I8XRR0O7LjsRsrRlDVnULdymWysCm5DjSUPP1Vw4pCdT7jgc+Ss8YT3GmuHkxODscuRBMDmswDyq5Yts+ZvZM=
X-Gm-Message-State: AOJu0YwXF7FMVA6Vacyfde3yDM45cm5Kr5lT3X4g8T3IQYCd7Uj81s8f
	edvLSENNg9jobFKknDL7tgnsWhI9Mhd2s1zX1CI2bvLM8rH05wAr0Ax7suwzXtWgI0klopIXif5
	aIfuza61iXTU1Vk0CjKOEulPv9EWyednM1nqtDg==
X-Google-Smtp-Source: AGHT+IHrp4Xh3i1XqddMFLTNR0pu3w38VmxhIBnGcCEYDdONQahxkdZEFtRyur/hzKD2ig6aNbR/s73+CN6uArFqY3M=
X-Received: by 2002:a05:6902:2201:b0:e0b:c402:b03f with SMTP id
 3f1490d57ef6-e1155ae6007mr2993583276.27.1723640489000; Wed, 14 Aug 2024
 06:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814124740.2778952-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240814124740.2778952-1-peng.fan@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 14 Aug 2024 15:00:52 +0200
Message-ID: <CAPDyKFrUyEfSsEdjfXGLX5NJuWaGNBZg1D+kCR=EikG42_eL0w@mail.gmail.com>
Subject: Re: [PATCH V2] pmdomain: imx: wait SSAR when i.MX93 power domain on
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>, Stable@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 14:38, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> With "quiet" set in bootargs, there is power domain failure:
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
> Cc: <Stable@vger.kernel.org>
> Fixes: 0a0f7cc25d4a ("soc: imx: add i.MX93 SRC power domain driver")
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for fixes, thanks!

Kind regards
Uffe

> ---
>
> V2:
>  Add Fixes tag and Cc stable (Per Ulf's comment)
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

