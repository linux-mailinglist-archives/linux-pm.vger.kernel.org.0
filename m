Return-Path: <linux-pm+bounces-8625-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD3F8FC876
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 11:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE633282B91
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 09:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C5119049D;
	Wed,  5 Jun 2024 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUIOFJOi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE2E190464
	for <linux-pm@vger.kernel.org>; Wed,  5 Jun 2024 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581492; cv=none; b=DacFtSDPJVNbcd18lOczS86orlaW3morHGU82Ufg3wrfFz6IcpWlZLxZPGILT5WVsTHuUdGmu9znFUbM0sbzih+bMEAF9NFqP8f1uE2YoPq7JIJ8plYwjx15c0+nYUop90oZJbUH9+p5sZ5faH0AnKf3PE7kdacWjThyKlVSeTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581492; c=relaxed/simple;
	bh=ePzuztDHuPKdvkP4ehh0GuJ62NObmegiChh5yskLNR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMUQYhAIFZbG7Rob2DyvtIAbBgMGhg+BFzWnw+2bMbTx9NM7MwAYOIcRo1wmS2DL+TJDMC/1ruUaWn/UH/qjggdIsyJP2bx6ZEr+dMHsUmxfYaYepAEdxhzUgU064PKBiqiS635fKoK1VikggU5QOxVFcnRZh+9UpNonWIm3P8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hUIOFJOi; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-62a2424ecb8so24701317b3.1
        for <linux-pm@vger.kernel.org>; Wed, 05 Jun 2024 02:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717581490; x=1718186290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JOTtqsSBiMIYPcr3wcJusAL3wMa2P2FRkcm2fHRtXEo=;
        b=hUIOFJOi0CMLjRCmjFvSo7qlAwO2z2sCC9iNjWI0Dgmz1AwBzbTLKCvVr2lDfAhsBl
         PLocZ0xpPjLXWENyldODlNNcizLJSEmaehb3NFTc49ycRBxMTnCQksn7XQbu5ZBrZgUa
         n8Ptcf4bp/rc175uWLaAX9yRPCD9g1dDYFbNXAKJCuj9TQaV58+6yh9pFoDU4AlxrGMY
         7tkpH3mXBBo1VSRETvcKa8whQGlkMkwGz/BQ+x5UrHznGQPr/hZJa+gx1btAPn4Kiz/p
         HqW9PDUgVXlreJXQzGYUV/iGLdGzhyDcFRV6zXEd3uYVFGc/h/iDCnM/chhyoeWhgEbF
         LDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717581490; x=1718186290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOTtqsSBiMIYPcr3wcJusAL3wMa2P2FRkcm2fHRtXEo=;
        b=xSgipN+MI6pQy958H6Dp34PSQeJP192Rst792i9HmVgkF9ujYIvg7BojcUFZ5mXXai
         VdiRZ5bXPHNUGxoKklitZhvUQk1D/wu+tm3UIkQVZe9QQu4RL6f6acOoAioalsL74xg/
         B8mRH0s6oevet8+cdPP9lfit7AzeZjcfkS1Cm6nCYKhAHC9ceMXiUIJmpbRzJ3cnHuDV
         XZXJMY11EbP1160ej/8TohqR9L6PxRryG+Kn5VMHNjHItG9UKFnk0Av8p01wRH2yKw94
         +FhUD2KLZvc1AUp8naCdVvTL/FFAmwcNywtbuZtuMHy67Mjw05W94k3fOx3GgyJxyRR3
         pKEw==
X-Gm-Message-State: AOJu0YymNQVNPzIGp29FMGlLVJMaLX9daKTPmlfF+EKplkVLA81cQtnA
	ku+Xg/uBOC+iOgnToES6ww9S/1Q7HBRi16xq4KI7HWhm6pLUHw3liCQEQY51+hcZygUScJ/o0A0
	BRvWcDDgUUEwRH+Mdgs0kWv8JQ3UGMK/Biri0fw==
X-Google-Smtp-Source: AGHT+IHRkg9B5HwstkE85qpKuFZl7TMZct4Uz+cqPwEHmF1AtbLy/FQO0xsmRh4wo7NP687Dp7JaVKDWB0sxuNSDtGI=
X-Received: by 2002:a25:abc3:0:b0:dfa:c847:a2f with SMTP id
 3f1490d57ef6-dfaca9eaa81mr2133038276.30.1717581489957; Wed, 05 Jun 2024
 02:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5e684d7b236904e5f79324a5e5357c2930f7402d.1716974368.git.geert+renesas@glider.be>
In-Reply-To: <5e684d7b236904e5f79324a5e5357c2930f7402d.1716974368.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 5 Jun 2024 11:57:34 +0200
Message-ID: <CAPDyKFqaOgW9hE6O2dtde64PaW0VWKKDztv70aDKNA7fvGWNZg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: renesas: rmobile-sysc: Use for_each_child_of_node_scoped()
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 May 2024 at 11:20, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Use the scoped variant of for_each_child_of_node() to simplify cleanup
> handling.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/renesas/rmobile-sysc.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pmdomain/renesas/rmobile-sysc.c b/drivers/pmdomain/renesas/rmobile-sysc.c
> index cc1f6f8b7a746850..5a1d2da465fb2c6f 100644
> --- a/drivers/pmdomain/renesas/rmobile-sysc.c
> +++ b/drivers/pmdomain/renesas/rmobile-sysc.c
> @@ -237,9 +237,7 @@ static int __init rmobile_add_pm_domains(void __iomem *base,
>                                          struct device_node *parent,
>                                          struct generic_pm_domain *genpd_parent)
>  {
> -       struct device_node *np;
> -
> -       for_each_child_of_node(parent, np) {
> +       for_each_child_of_node_scoped(parent, np) {
>                 struct rmobile_pm_domain *pd;
>                 u32 idx = ~0;
>
> @@ -248,10 +246,8 @@ static int __init rmobile_add_pm_domains(void __iomem *base,
>                 }
>
>                 pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> -               if (!pd) {
> -                       of_node_put(np);
> +               if (!pd)
>                         return -ENOMEM;
> -               }
>
>                 pd->genpd.name = np->name;
>                 pd->base = base;
> --
> 2.34.1
>

