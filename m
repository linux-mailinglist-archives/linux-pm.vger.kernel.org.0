Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F16C11F87E
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2019 16:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLOPcY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Dec 2019 10:32:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfLOPcY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 15 Dec 2019 10:32:24 -0500
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4C1B24654;
        Sun, 15 Dec 2019 15:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576423943;
        bh=cBaLB/vop1iNW5EhmBkuBZLdeEQ64p17vwMy2jCwDGo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XA8CAtgrWX4w9Beb1YGF1wTUZcDXjZ1RjuIwfwqVeruPPYzo1qLQX9qOVjZ8JwUyz
         56Xm98KclPXV2PrUbpJdbQyHqFqWXTFm2aPiLLkhN8tPUFTQeRc5hDTtQh8dRSgn2V
         x+n8M1c9ScFSp5c+xJv3QcJxMLc1N66X2KnumnPA=
Received: by mail-lf1-f47.google.com with SMTP id r14so2478926lfm.5;
        Sun, 15 Dec 2019 07:32:22 -0800 (PST)
X-Gm-Message-State: APjAAAUtd7e6L91n7i6pZtG6Ojj4GlSx67xe5clra5E3xQWd4MSikxD9
        1+A73E97Z8iQ6RCityJBX7t1D1kqN1sVdDDU/OA=
X-Google-Smtp-Source: APXvYqwtZTuPvb0XLqwarOMLvnGJwFkyoyUE7GOqxC5WmEgFBzD3rfzhdfcEmZj679sERXVXciR3s09yLubr+ptFvNg=
X-Received: by 2002:ac2:531b:: with SMTP id c27mr13906871lfh.91.1576423941027;
 Sun, 15 Dec 2019 07:32:21 -0800 (PST)
MIME-Version: 1.0
References: <20191215135315.30656-1-tiny.windzz@gmail.com>
In-Reply-To: <20191215135315.30656-1-tiny.windzz@gmail.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Mon, 16 Dec 2019 00:31:44 +0900
X-Gmail-Original-Message-ID: <CAGTfZH0AEQT-GZX9EOPDcrxRVEdd0JC3iwwWmmn0CGuKDXHohw@mail.gmail.com>
Message-ID: <CAGTfZH0AEQT-GZX9EOPDcrxRVEdd0JC3iwwWmmn0CGuKDXHohw@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: rockchip-dfi: convert to devm_platform_ioremap_resource
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=EB=85=84 12=EC=9B=94 15=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 10:53,=
 Yangtao Li <tiny.windzz@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Use devm_platform_ioremap_resource() to simplify code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/devfreq/event/rockchip-dfi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event=
/rockchip-dfi.c
> index 5d1042188727..cc5d4c01af0b 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -177,7 +177,6 @@ static int rockchip_dfi_probe(struct platform_device =
*pdev)
>  {
>         struct device *dev =3D &pdev->dev;
>         struct rockchip_dfi *data;
> -       struct resource *res;
>         struct devfreq_event_desc *desc;
>         struct device_node *np =3D pdev->dev.of_node, *node;
>
> @@ -185,8 +184,7 @@ static int rockchip_dfi_probe(struct platform_device =
*pdev)
>         if (!data)
>                 return -ENOMEM;
>
> -       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       data->regs =3D devm_ioremap_resource(&pdev->dev, res);
> +       data->regs =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(data->regs))
>                 return PTR_ERR(data->regs);
>
> --
> 2.17.1
>

Applied it.

--=20
Best Regards,
Chanwoo Choi
