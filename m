Return-Path: <linux-pm+bounces-16870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D85A79B90CE
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 12:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D83228245A
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 11:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB0319D8A8;
	Fri,  1 Nov 2024 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W+wvP0iR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C01A19C551
	for <linux-pm@vger.kernel.org>; Fri,  1 Nov 2024 11:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462235; cv=none; b=F0t7WQ3aiM59fYEt5+Feo14GMYcRi3UBdhCBEeAKQCw+oaPRLP780pW+9xM8XZpvlvAgW7mPaOo82AAL/A48W9eWqSyvSkGGv/WQDHi48L4QXImXjIqTv7UK/Me8Gtx1XDx715jdVLQ4VFpG92U/DwWsmsHHJNQTa1Eiogqdipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462235; c=relaxed/simple;
	bh=jcU/orumlgsJbKSrF/Nm/W+DgTU2zdH6jx1nkml6CZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6Qrnx96Gaxsv5FPJl0Bu0mVM8oQ3RuGsXjahbGozj7+7lu7LoeeBS/M2+cErqtdRn/zCycTWo0ReYMmZSuqTZ8Fg1b628xMB+fEg12JONlaIp/6PPtIiBsig965MqkvL2gZdNT9StDd8XD2jz5DLMN5/00YWfxPGowgVHT9wtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W+wvP0iR; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e35bf59cf6so28042627b3.0
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2024 04:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730462232; x=1731067032; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AyPmo8da7gVQeFsoekZ63qpPCKXE92H2RSDUtfff7nM=;
        b=W+wvP0iRisWC95frYnQDDKVpK1IMLAGryk7hBidywJfu6dWqh0qTrBWd/1yDWwbLqk
         FMTluEtPIuhOm/59QHNsaZToDcamu4m26DFzmgbWTer720MD65X5T1zwxtbiP9BqV+9d
         GAEcBXjl30mKOP3rKVyBaKqAqCbx1YDxyRGpB3Ax0pFpHpqVqDKXsDiQ3ZAy7ProAkRP
         hTNML4k1KyrvhmaBOWB6Frp+Jg2PTzmApvRlJlJVIHxJemh0zvtjyWGGR7f5eHzEg3yi
         w7iiJE6JIOLTRKgQvHUbEBlW82eYtoHWD0Hv3Yu2xsmvn3cY1qiwjXo0S+G6Rb+QcSEH
         L3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730462232; x=1731067032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AyPmo8da7gVQeFsoekZ63qpPCKXE92H2RSDUtfff7nM=;
        b=Q/l42SUrhgptKdHVIVCQ4n9U03uNdDUsbxRZV8kV2noz6TrFmehxeozbAbLWmBYgX3
         VqxHNNW2Y2FzqKRYDCqx8pIlvilyifK+gdlwHsHspPxw84F+xVw6HXzQmWei2WHh0Byw
         1u67II9j0GsyMjgkAgzET4xHY2O2D4O5g2+bV1d1k4zTn9g9oyNwAqjm5xXFkjqa2+v+
         faP+RqYQepiSulabS542dmzIRxzUJLEZOydDCjFjeGc/FrP4s5wEFe4Ewj9nbCsnpBI0
         1Akvo43Kdue/MqmLXD7x0RuBIWPeNATaIsR096IQ5u6zdX8oYnmF99j6Hd/eWtSv3cve
         uIiw==
X-Forwarded-Encrypted: i=1; AJvYcCUkhBqHXr/hGMs0uqJCe0JMjEibcxDnG2+I7IA8Jh6+Zj2HcGDhN6iY/JkFCSh1YfvltX5/+5F/VQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuQbqHYzU0YEka+28d8G+T5W1n7DbzzTgSSVeSqm0e94u9PCb1
	dM0JPRZW63zIu3THxxj9aabg2iA8Nr7BCMUnD/y0FPBXkWLZ7HSP4RjnaGvtJbk86MIJkpvTdtn
	BBRHZJRYZ8m+KiPOTskCTfhQAjudsSlNT1RlWZw==
X-Google-Smtp-Source: AGHT+IGjFViHhhsIEjWSeBRVVF02vu14Au/x1uufAjiQ0eyy+Lk2WKoLfjrFanaJSgIrSL/w8V1/5Fi83AtDrIju8t8=
X-Received: by 2002:a05:690c:d18:b0:6db:d02f:b2c4 with SMTP id
 00721157ae682-6ea64308628mr27197277b3.7.1730462231906; Fri, 01 Nov 2024
 04:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101101252.1448466-1-peng.fan@oss.nxp.com>
In-Reply-To: <20241101101252.1448466-1-peng.fan@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 1 Nov 2024 12:56:36 +0100
Message-ID: <CAPDyKFqmeCCkv5Yr0K9P9eToYTYsQmQUYmbbJvoOJ0O5t5tsjQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx93-blk-ctrl: correct remove path
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	"open list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 11:02, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> The check condition should be 'i < bc->onecell_data.num_domains', not
> 'bc->onecell_data.num_domains' which will make the look never finish
> and cause kernel panic.
>
> Also disable runtime to address
> "imx93-blk-ctrl 4ac10000.system-controller: Unbalanced pm_runtime_enable!"
>
> Fixes: e9aa77d413c9 ("soc: imx: add i.MX93 media blk ctrl driver")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/imx/imx93-blk-ctrl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> index 904ffa55b8f4..b10348ac10f0 100644
> --- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> @@ -313,7 +313,9 @@ static void imx93_blk_ctrl_remove(struct platform_device *pdev)
>
>         of_genpd_del_provider(pdev->dev.of_node);
>
> -       for (i = 0; bc->onecell_data.num_domains; i++) {
> +       pm_runtime_disable(&pdev->dev);
> +
> +       for (i = 0; i < bc->onecell_data.num_domains; i++) {
>                 struct imx93_blk_ctrl_domain *domain = &bc->domains[i];
>
>                 pm_genpd_remove(&domain->genpd);
> --
> 2.37.1
>

