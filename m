Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD1011F87C
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2019 16:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLOPcK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Dec 2019 10:32:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:58310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfLOPcK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 15 Dec 2019 10:32:10 -0500
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6138206D3;
        Sun, 15 Dec 2019 15:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576423929;
        bh=LsdE1olfUWAg8NbQgwIIgsdHBueTtS886MJUXIF7248=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1JbZ8zWQwRQdlNDMhXLyawJKgoPkUq82atf12KDHnNl4Ez+XlVN9k5/BersF7i2xF
         doZmwRzrKjAQ2ft+LIC+WmQZmTy/ptRyJm6TL6/K3u4BKX9xyo4vfHzi6NYKe40szC
         eA1aZs7ybyYhmC+WBYJjDX7IklYj62Rd6EirCuII=
Received: by mail-lj1-f178.google.com with SMTP id d20so3947331ljc.12;
        Sun, 15 Dec 2019 07:32:08 -0800 (PST)
X-Gm-Message-State: APjAAAVmdqniUdjEu7Q1hpV0r7vG0PZaTmK8mMV0VZ/k+A32o0JZ6wHc
        I/nD7jr7SHtPSQ9EjYq4hDNcZEBbhyexsEzLv+I=
X-Google-Smtp-Source: APXvYqyWeNlmS1ZKv6+Ukw2JuBgBJGRUtDQIF2wJpsNpVrW3pbEJ53qh+dW02vND3+h1b34iKThbbVA7gJWofj5IECg=
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr16917581ljg.82.1576423927151;
 Sun, 15 Dec 2019 07:32:07 -0800 (PST)
MIME-Version: 1.0
References: <20191214181130.25808-1-tiny.windzz@gmail.com> <20191214181130.25808-2-tiny.windzz@gmail.com>
In-Reply-To: <20191214181130.25808-2-tiny.windzz@gmail.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Mon, 16 Dec 2019 00:31:30 +0900
X-Gmail-Original-Message-ID: <CAGTfZH0XQ_V6i3+=nksK5E38XX+Qk5nvZfeb0ec4kVb6-Jn5ZQ@mail.gmail.com>
Message-ID: <CAGTfZH0XQ_V6i3+=nksK5E38XX+Qk5nvZfeb0ec4kVb6-Jn5ZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM / devfreq: rk3399_dmc: add missing of_node_put()
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

2019=EB=85=84 12=EC=9B=94 15=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 3:12, =
Yangtao Li <tiny.windzz@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> of_node_put() needs to be called when the device node which is got
> from of_parse_phandle has finished using.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/devfreq/rk3399_dmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index 2e65d7279d79..2f1027c5b647 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -372,6 +372,7 @@ static int rk3399_dmcfreq_probe(struct platform_devic=
e *pdev)
>         node =3D of_parse_phandle(np, "rockchip,pmu", 0);
>         if (node) {
>                 data->regmap_pmu =3D syscon_node_to_regmap(node);
> +               of_node_put(node);
>                 if (IS_ERR(data->regmap_pmu))
>                         return PTR_ERR(data->regmap_pmu);
>         }
> --
> 2.17.1
>

Applied it.

--=20
Best Regards,
Chanwoo Choi
