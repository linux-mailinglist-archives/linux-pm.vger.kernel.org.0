Return-Path: <linux-pm+bounces-39974-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9ACCE5228
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 16:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4127030052E3
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 15:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BDF2C0F97;
	Sun, 28 Dec 2025 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PcvCiOS7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9BD28D8E8
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766937104; cv=none; b=cPhIr74rXYBpcJn7qU+59kGhLZbF8tuXeEB8wh8OCu6Rk+UNQbxtg6OmBJfPK0FsisHi4JTI4MHgot4QOj4nN6fohkREAsDt7vUNAlfInZsAgsjhG3cBWllJ/JLgRpLpd7hYfKyYFDyBpHPgLFtdqsla0Z7tK6Z83JjB/18TEQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766937104; c=relaxed/simple;
	bh=UPBdwscMbeewUmZS1YlHhhaecNMpTlEwPf4hXKqUXHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BsxgZu8W7VuiZI2wyE+7XPqPJ/uYGaDM7bBZf4fZbW2Y1qxp0WPe+czsSiAALMk/JQvs0bJd/DQ+lCUmLw+h9DxbO/84BL/4PUTQL2lSTU4bHFhP4aUE7f0jTB5Hz/2uFcLfyJiY+uq1/Ps87xPG4XOY4hNr3hGnANIjJnA23n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PcvCiOS7; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59a10df8027so10919260e87.0
        for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 07:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766937101; x=1767541901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vMOElam5lFCQ00bwoN+FTpOkP8287mrJpVz34H2qYuM=;
        b=PcvCiOS73VXBn6sRUI444KBAO4fdbHDHkyCBrg6DWDD4JyRDbwpFpQ4LCC1bvghGNa
         10GsuO/8Ywny8uh+D7+bYNA/q0b08kjJv4/NGj69EfW+Xv8tJLLSsVBKCvkMAoG8W2wK
         mWrGHVM7IPqgC3RdQjihLokW8i4tHquXiUB0pojSmZCv/iqCRP6HrzW09AM4X2S8HWZs
         m6YsnsvBglvQe9i6j0ogBfmFwb/9tPKKmOJMgBvFO6VsgP0IDUz+rWIQAyGNijafHnaE
         JymhUEpJ91CIrQjUrmTI6tnmOXh3cJ3XAuffGXnJ4W1CEvstW836H+++YFP1tjlYOZ45
         zkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766937101; x=1767541901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMOElam5lFCQ00bwoN+FTpOkP8287mrJpVz34H2qYuM=;
        b=PsIxOjdr38LejUMQ3UqSJp1TaigoWhQxPbXgRwFuoD1AFQl8yYmwWZolXG+31F12Sc
         /62I+47PfNWAs4SACjAIvW/oncOVkmXXo03FVRRqPZFsXmHYxmYxgp5Czyzy4DvO8Rov
         0T3OjWQ9fmLVRj4WIEucgjq2j0QQPVNQV9TYjcWYYtexPB2XsxE7n+xwB5xUgZBvGKx5
         lZzAgQkXMuNccM9ykaySd/FPQW5DMU3W19cZDfEe/UmuoYnZvyaOn5NVN0I3cZ/LJYrR
         dlGauJusyQIesF+oMQirOioLSm8I59gT2jFncEhxI7Ngr8I9y6c2n4jWqd/zfgchOXx0
         hUtg==
X-Forwarded-Encrypted: i=1; AJvYcCUAbuIKKHVVMdGCoJ8OxKNF/CBEmlEyDkWR4dAJcZUxi+abHRkX7Ab1yIr4KmAv2vcyAiYot+HfTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEnrBEk98nwP+ipt9pTdRWeDoEkBduX7JZPpAWnM+hNq/BzoFJ
	mCjXVq+QqzIVjaeZfEVqjdChVqQ6fHaUbKv5QJboep8+CpDVoILwtoCIdsHPONQzXfJEm92uZr1
	ZVrxcCPCOCaHAk2EMpeGVqrgLBuFKX+CUUxjz21vwsQPS3fQUVfV4
X-Gm-Gg: AY/fxX6GbJBSiRdZAhlF07qVV3tlEqyES7DWFnkyYXsnVxjOVZIXIC83/k95OfB+074
	yRfPOO+W7ZlRKaLYdPaf+tolXtqihqIVO3W4upsz3GUzhKZaH1fgnLR3EZWL9QjtJs9VTPmYpHP
	iq/YfDKVBQ/sTtOJ67HK8MLvk+EiVEGSjmt+4CngJVZH4rRieOGQ00xpLXx7DaJmGhZMnGZTxE9
	jhMFGjFw7RHFgGZYDRXwEgtAT+F/XG3pSKjEpuvCg+ZulagKVN3IVl2/Kvu9Uc2PCq042/k
X-Google-Smtp-Source: AGHT+IHLUFVsnwRwkLFb3Tq4L6Zc3f/V8NutlxDmQ4VBL3ts9a5/EsxCVdAPRyCi+loA38VXEQC6iUojrpiM88ffZ7E=
X-Received: by 2002:a2e:a913:0:b0:37b:ba96:ce07 with SMTP id
 38308e7fff4ca-38121596892mr81755101fa.15.1766937100554; Sun, 28 Dec 2025
 07:51:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211040252.497759-1-vulab@iscas.ac.cn>
In-Reply-To: <20251211040252.497759-1-vulab@iscas.ac.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Sun, 28 Dec 2025 16:51:04 +0100
X-Gm-Features: AQt7F2q4HOmCP3AtHKfQGHLB3c99yZpMtVEIsP3Gmo2gfisxBcr_gBvsZWBQEl4
Message-ID: <CAPDyKFrPZqwDmgFuPfbpX+FF3-r9F-r+9+Mm5v8z5Wb7TQJvmg@mail.gmail.com>
Subject: Re: [PATCH v4] pmdomain: imx: Fix reference count leak in imx_gpc_probe()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Dec 2025 at 05:03, Wentao Liang <vulab@iscas.ac.cn> wrote:
>
> of_get_child_by_name() returns a node pointer with refcount incremented.
> Use the __free() attribute to manage the pgc_node reference, ensuring
> automatic of_node_put() cleanup when pgc_node goes out of scope.
>
> This eliminates the need for explicit error handling paths and avoids
> reference count leaks.
>
> Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Applied for fixes, thanks!

Kind regards
Uffe


>
> ---
> Change in V4:
> - Fix typo error in code
>
> Change in V3:
> - Ensure variable is assigned when using cleanup attribute
>
> Change in V2:
> - Use __free() attribute instead of explicit of_node_put() calls
> ---
>  drivers/pmdomain/imx/gpc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index f18c7e6e75dd..56a78cc86584 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -403,13 +403,12 @@ static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap,
>  static int imx_gpc_probe(struct platform_device *pdev)
>  {
>         const struct imx_gpc_dt_data *of_id_data = device_get_match_data(&pdev->dev);
> -       struct device_node *pgc_node;
> +       struct device_node *pgc_node __free(device_node)
> +               = of_get_child_by_name(pdev->dev.of_node, "pgc");
>         struct regmap *regmap;
>         void __iomem *base;
>         int ret;
>
> -       pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
> -
>         /* bail out if DT too old and doesn't provide the necessary info */
>         if (!of_property_present(pdev->dev.of_node, "#power-domain-cells") &&
>             !pgc_node)
> --
> 2.34.1
>
>

