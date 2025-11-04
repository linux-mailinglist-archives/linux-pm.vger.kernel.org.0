Return-Path: <linux-pm+bounces-37374-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6ACC3216D
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 17:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 310EE4ECC92
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 16:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F19D333726;
	Tue,  4 Nov 2025 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tn5XBqtv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070B733344C
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274058; cv=none; b=R+OIeSQIXURGAZmWA7C35b+5cEKGch1az/yLLLkesWmJ/Y+hjBdfqciOx17WhJPOW8wka1zB/F5gxS/OygyBtzZxyqRzKEjKawXGohJ6/OQCi1mpBYu+0CS/WONyf89Vmen8Udps16pJzw5znpBhC5qpcfkqWrLxGxxl1rWtBGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274058; c=relaxed/simple;
	bh=a8zjnlZJoP75Gcp3unqAhRNeNHZZuPHHbDlOcyOC1Ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQGeNrMpcIkHfUCxo3XpU30xl/FdWG0pkNwzBbMqlF9LGXqg+V4zm9I+Q82Nmwa4Vellmxa95pru3IaATCf/7soPtXi7BAqX61kadjkBj7IFXrSN/04D7Pz8xJJ6BekhLwrX5uM15ga6CGE1cc4RCRzhL3rTSCuhTV887Ns94Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tn5XBqtv; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-786572c14e3so39619507b3.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 08:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762274055; x=1762878855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EeY/Q1vjgJqdUpxoN7I5OLtGxJW4ljCXvqhX1XWJkyQ=;
        b=tn5XBqtvJGKyjMeeYb+FMDXgjPt/GJuVrq3OqqMgC+IpQH6JgcYtcnS9COHnqLqyBT
         GbbzoBS+tgJLMtwvWaDQIvcWRjpBzr4C38m+IVJrhTQ5ppd0CcMw5gjr6v1PYvxjsEOq
         mtMRzliYCEPA9289aGvhp1sTw8i1ST96lNQ5zvRYWqiSw5qLqaxGX9bxlRNXvYBZvieF
         iFmrfcsjaeWRIC1G0/BqcTGTTjVUgqUDc+8Ca6qGSYL7SPwzb8y2rJpyoZq4aprRFFvN
         6ZYCOj12OaVPp86W80o5WD07DCOduUq5hMS5rWmukOWoe13HsxELhOQYI72O2YuHfKRM
         nRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762274055; x=1762878855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EeY/Q1vjgJqdUpxoN7I5OLtGxJW4ljCXvqhX1XWJkyQ=;
        b=OZLC9Vb0E56XoeOKZQQ9JHBNbYhTcW813vLShmseMuuqftBPnR3QYJV7JEmThSaG8x
         kK2JT5No0NYds/I3sdOnm8uVqrBwt8Sm93K4uL0zGQ7IYR4t3vdFN1YMUFnu0mFxRLks
         WMAGclXY4b0ZD1O8lCvDVky8pKloJrKjeby3MMfjf8vXrFmdC0Jh0wfhRn4mqMir/eyo
         AHkZd1ok8u6b70cup1mCmYqEU6QVNSGFHzrOgmAQMVq5Xun38bwoQiN/fEOg2LETI0Ly
         MMX2fcToE/JbzH8t7jO+pnYcKSMIjCXRCDGdJsPnULYtDYVdzqd9vbOAX2jcoVbRaRo2
         1B3w==
X-Forwarded-Encrypted: i=1; AJvYcCVZVNWAz6Khi+EssuuqZx3a678gJYDKUU4AKq8raWoNW0bpH9/egstMc6TJH8pYNZVHzhH2BBtILQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjPNCETey5BzgOrNnIe/UnoIqrRP5IcgGMYJj3IrOsNBxBZuLa
	1bkL0ebwGZRJr8tl8Cu8M6ioU0AYB8k3d8L0T4rbOU0jJ0Q8Kw8QZp+S/lQoYGbfS9bHYzj2/Ws
	SjBK+p09gIUQJnmLL/i/LiCxccLgmySmQsvwPiz4npw==
X-Gm-Gg: ASbGncsq5Ksa0ZYYhbzBn+DWLIbw3Y5BKNESrhvPZcmA+FR/Pcj0+zpNMSL+ujhB9gX
	o/rf7yescanigEadR/qdL/AmhIqqKeSU0YrwdV0gzc0H4yUz8eJR/LhtD2/r1eqNnHLxCDcrYFL
	l9UQGgMwc5yHlm9o99UWPAqo+orREm1yvIoS/gvl4ev2P3TPyESHtMJ2AXnnMfNkhDunsNeJQd8
	skhVXIXRVHa2l9HjivCSZ5hF1Lu4Phuhr7OF5pLRkib22TUsQmYculMZ9Hpuw==
X-Google-Smtp-Source: AGHT+IF0Z/yNF7yi6Lz9tQRkNyi37+NTyOPEnzyNmvGQXNJdjD0tMjSSXuyBHzY73wkfo4eUOH3v52Gvr3xMHkvavMo=
X-Received: by 2002:a05:690c:4882:b0:786:802b:d7ff with SMTP id
 00721157ae682-786a41efce2mr752787b3.59.1762274054906; Tue, 04 Nov 2025
 08:34:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028031623.43284-1-linmq006@gmail.com>
In-Reply-To: <20251028031623.43284-1-linmq006@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Nov 2025 17:33:38 +0100
X-Gm-Features: AWmQ_bk9KtCzO_f_YWM_AynJxSlgpLBL58lIquCitQc40-GRB32NM5WebMbg_Tg
Message-ID: <CAPDyKFqiNeO==u0j=VTKmWaG8VdMR-mS84QoLjrussfMYrr1mw@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: gpc: fix reference count leak in imx_gpc_remove
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lucas Stach <l.stach@pengutronix.de>, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Oct 2025 at 04:16, Miaoqian Lin <linmq006@gmail.com> wrote:
>
> of_get_child_by_name() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe

> ---
>  drivers/pmdomain/imx/gpc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index 33991f3c6b55..a34b260274f7 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -536,6 +536,8 @@ static void imx_gpc_remove(struct platform_device *pdev)
>                         return;
>                 }
>         }
> +
> +       of_node_put(pgc_node);
>  }
>
>  static struct platform_driver imx_gpc_driver = {
> --
> 2.39.5 (Apple Git-154)
>

