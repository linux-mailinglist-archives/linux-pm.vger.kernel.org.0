Return-Path: <linux-pm+bounces-12143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D12C95026B
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 12:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8AE4B25834
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 10:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C95618991F;
	Tue, 13 Aug 2024 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UtWaRyiq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4861B189BB2
	for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723544782; cv=none; b=Vp/X3nesZVZKmqQH+F5q9R97UO2cvhDM/wz9mzUyc9fyK364APeTly0PrCkhZwFQbBGQaafVjpsp/uqStdfe17r4QCKF2z//wTQfxf8LfF9+ZCbgRQcutCkFKtIHq75/roQ2IvX92eHnuYX0R647knLpRLnnVAuh52xbIEiJCJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723544782; c=relaxed/simple;
	bh=z0SE0DRkQDPcBo47RwO5BjzEzk1vYFugQPsVneEsATs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDENKZfhii0cL5YRbE3NkBogvfNHnR715Rc6OXszRv8m8rtDWJ7GzLQdXMIt0WDE1cOTUcLeYHCe/s+GwZzuJMxcCW256bwbQtm1LLu/eSVVq86kRhff5jemXSgsayRMftjgRb4NpWs4jliObx0VqHKk1mWFr8SkDi3gtjan/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UtWaRyiq; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a80eab3945eso139430366b.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 03:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723544780; x=1724149580; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MdQQgLvLwClHzzWB9/M5yoQQbZvzDEedy+o4MY6Z6/o=;
        b=UtWaRyiqFndtgCuJNk8TU4Cd6x82gt0qIo7kf1eAsbCp3PVsMz4B12o6uLmfZGVY6V
         2Ftl/EfmFoHKzOuvaC0hgByfnDYF80PpK6QgjKq+lbjMZakm3HeyAQbpd+u1AU3BI4DE
         VovGftBlMShgtF1tSMAwNDOizQu/p6fbt7X/SIeCk5yd83ISYvxTfRrnJptZcUfHBKuw
         XaNqMrZs8cObaXQmlQKYT3d+QVUogylVNky6oAHYU50Luo0E7uFJN21XkmY/BGLs7VT3
         DiWmV0T+HO02KOYD8iKfJMwEI11PZXO2dU8pa1XXywuS/yw2nCwvF80mTpCOG23dByup
         ifHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723544780; x=1724149580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MdQQgLvLwClHzzWB9/M5yoQQbZvzDEedy+o4MY6Z6/o=;
        b=Wn92JbbbJRF/zQRJfrJvGCxZ/Dt3o21Eh+BT16X3Q/9+6jiQXrmCFP6ElXsHhPhCCH
         1eEJzgQP7V5oROW2Nh55YpZZbgH+hZGGatCQT/+JegXHUBLvTqe+veNU6UExYKVS18L/
         MdMNf10u8t8qod1h26tUHhyEJjJ6tKplMiMhfHXkNRi/nvaM9uYUSxNSgKWCh9QKa0fG
         GvkadiGwL9MPjnNIOcVBxYMSfslvJ+3h800R0jsKSlPXETOzIownN3RE8nzRgVECSPcK
         YMJf/nqJ/6HCyu19rIkrCMxJv6PGxyxWlpq8vKbJ/NgnwJw7INxMucUzl5hDJrbQyVCT
         hz+w==
X-Forwarded-Encrypted: i=1; AJvYcCVVip0WNZtEbKnM2U7okiF9juZUaLPK9Xd7EG7tuVQrwA5Mi/UtGmpABSUEVyOJaEDZ5yeB2gG7JdHw3M5DP9oTNdSEcoGKaEQ=
X-Gm-Message-State: AOJu0Yx8ZrdFQyd9eC/vJvKTVwphbdqJEaLy9VXUwCCQ3fyJGEqo55Sv
	H+KTEllan2KmiCtwbp+gVTWEM4VBnhon7QTvz2XlH5wwdZv9PeAh8/NLvi1PJwxaOCBCutb0Q4h
	ULbTKcKCUuawA53oH025yDNbz6SyNPyRjCS98eA==
X-Google-Smtp-Source: AGHT+IHx6zPYh3qSfj3N85WmIDiWhbodIIrS72DAI3Ue6S5ByNRdNzF61bpT+HPkFh24apaBN1cdRGQUtDwUFhZq0r0=
X-Received: by 2002:a17:907:7212:b0:a77:dd1c:6273 with SMTP id
 a640c23a62f3a-a80ed1b5b03mr184722966b.12.1723544779522; Tue, 13 Aug 2024
 03:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808042858.2768309-1-make24@iscas.ac.cn>
In-Reply-To: <20240808042858.2768309-1-make24@iscas.ac.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 13 Aug 2024 12:25:42 +0200
Message-ID: <CAPDyKFqZ1nkhEYEOMtYNxOqkV9npXvuQB93PepAGYSmmpDUkyA@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: imx8m-blk-ctrl: Fix NULL pointer dereference
To: Ma Ke <make24@iscas.ac.cn>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, geert+renesas@glider.be, arnd@arndb.de, peng.fan@nxp.com, 
	u.kleine-koenig@pengutronix.de, marex@denx.de, 
	benjamin.gaignard@collabora.com, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Aug 2024 at 06:29, Ma Ke <make24@iscas.ac.cn> wrote:
>
> Check bc->bus_power_dev = dev_pm_domain_attach_by_name() return value using
> IS_ERR_OR_NULL() instead of plain IS_ERR(), and fail if bc->bus_power_dev
> is either error or NULL.
>
> In case a power domain attached by dev_pm_domain_attach_by_name() is not
> described in DT, dev_pm_domain_attach_by_name() returns NULL, which is
> then used, which leads to NULL pointer dereference.
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: 1a1da28544fd ("soc: imx: imx8m-blk-ctrl: Defer probe if 'bus' genpd is not yet ready")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> index ca942d7929c2..d46fb5387148 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -212,7 +212,7 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         bc->bus_power_dev = dev_pm_domain_attach_by_name(dev, "bus");
> -       if (IS_ERR(bc->bus_power_dev)) {
> +       if (IS_ERR_OR_NULL(bc->bus_power_dev)) {
>                 if (PTR_ERR(bc->bus_power_dev) == -ENODEV)
>                         return dev_err_probe(dev, -EPROBE_DEFER,
>                                              "failed to attach power domain \"bus\"\n");

The corresponding else clause uses PTR_ERR(bc->bus_power_dev), would
that trigger a splat too?

> --
> 2.25.1
>

Kind regards
Uffe

