Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BED1711F878
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2019 16:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfLOPbg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Dec 2019 10:31:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:57806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfLOPbg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 15 Dec 2019 10:31:36 -0500
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F3302465B;
        Sun, 15 Dec 2019 15:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576423895;
        bh=LgHeGbyJrYWU3ryipXZAEWbKr4XnV0pc7CZo8nwe71o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i5Cutc5J5C/5aYfb3pnqldlule1dkMTiFtdLJQQf0csa7oyzCh7cQOCYG07GcSVZ9
         IqhCNmw8CkN/a/xa4PpC8UyV1eVrvlsHUwUDR3+xpHamO7llyTLZV0IjgaarW3NFPu
         smNpvbffdnRweEOQ/u/ZeoB1inTYavFVuPAUA4iU=
Received: by mail-lj1-f178.google.com with SMTP id h23so3967503ljc.8;
        Sun, 15 Dec 2019 07:31:35 -0800 (PST)
X-Gm-Message-State: APjAAAVsIYOgOb/Muw/9yMUEjVfjYTAUGVU8EbdnvV8zjQ2UWTG9nmvH
        BocPKACnfdoRNuJvziYnELhBgiDEObBzqUZqH0A=
X-Google-Smtp-Source: APXvYqw2DbqZ9mPFhwyFC3xGwQKN0FgHbG3yv4TEKTv/RS3DYTfQCkrygxKAvb9/4K7Pve0MBgrcu0ELakg7Nt6nOu8=
X-Received: by 2002:a05:651c:208:: with SMTP id y8mr16919184ljn.36.1576423893690;
 Sun, 15 Dec 2019 07:31:33 -0800 (PST)
MIME-Version: 1.0
References: <20191214181130.25808-1-tiny.windzz@gmail.com>
In-Reply-To: <20191214181130.25808-1-tiny.windzz@gmail.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Mon, 16 Dec 2019 00:30:57 +0900
X-Gmail-Original-Message-ID: <CAGTfZH2CS6o-zaHXReKJXzxsU_jfYKg2WL7uGpzyaFNhgTSVbg@mail.gmail.com>
Message-ID: <CAGTfZH2CS6o-zaHXReKJXzxsU_jfYKg2WL7uGpzyaFNhgTSVbg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / devfreq: rockchip-dfi: add missing of_node_put()
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
> of_node_put needs to be called when the device node which is got
> from of_parse_phandle has finished using.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/devfreq/event/rockchip-dfi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event=
/rockchip-dfi.c
> index 5d1042188727..45b190e443d8 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -200,6 +200,7 @@ static int rockchip_dfi_probe(struct platform_device =
*pdev)
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

Applied it. Better to use the capital letter for first char of sentence.

--=20
Best Regards,
Chanwoo Choi
