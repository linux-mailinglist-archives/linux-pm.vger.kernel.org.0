Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9A4C4F5D6
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2019 15:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfFVNKs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Jun 2019 09:10:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44396 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFVNKr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Jun 2019 09:10:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id k18so8390894ljc.11;
        Sat, 22 Jun 2019 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=JKJ7NdLuEooMFWo6LA3qa+n1zarZyBvo2gr/w64oEhU=;
        b=cqTqJkmkzCJZgmZraBOEPTF4KFzVDxCz/wKOmehscUGO3xmmVvpoNvDfAFfDtJgdhd
         6afLLU5VEDA0WzPYHeGc4SvNbWt3fkZewR/vK/epUG5aLa2FgLUtBnVfgEVhS/NTRHxI
         UEoOyERmH5DWxyHzaKLt3jEMin17d7R3511BrX9Eqn0nmV5iwOQF9H05uRovkUpYp+iq
         A3bmmp9lvnD3+eLNnWbGwR2/OHfhFpTGaaLu1yqWgZWJDaiGzIwpoQFs6x+itvhLI5hd
         dR3x0ahsaq2djScI0cbXG0kavaXkRXWyd0AwH6eeQ5plXpsjrdy0lzTyF9Li3tVTTXOh
         42/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=JKJ7NdLuEooMFWo6LA3qa+n1zarZyBvo2gr/w64oEhU=;
        b=kSCJJ1YzA70yUS4pE2YIgn7JA0GVaXE52yLcDjDapqT/Kf4TacENQm551egLUqnT6W
         Li1CDuTwY73jorFbQ1qpND5HazITD7ici9ZfZ6eizzXie1FSwkxP0wPzJaMPxx7z3ekR
         vFgxyco9PPz+pWHnuxrfU5/bWx1vB/u/X8p5dUmlOLCEnOQqPKC9jDCypWLS5FbqHCL7
         dKPFBCQI6BYwMsSxe9Q7v2qGSX96e89KVQ92uqwHGM2N6spsTAzv1qSVCxZZMDtV4QpI
         rw9SjNM18i/3PWoTxruREbyVpKfTDrlqKbAso+tx22GaAnJkV0mIgeW4Anu4s0ts58wu
         OOPA==
X-Gm-Message-State: APjAAAUVeshEkWuR29o6XVQ7pfKBIp84k9hy7hyr9qhyJXO5JJ9bEb/F
        6jvi7dOBuf71Iit7CWNjqyv32n6wCtnmQi5wFgk=
X-Google-Smtp-Source: APXvYqynjFLmTvY2JnFGiymi/s20MlB0RGAJBCuFJ20xD8lz5r0YsMLTewzKzTDqvog/w8S1ySij9keN4DPpz60sff4=
X-Received: by 2002:a2e:8945:: with SMTP id b5mr35153457ljk.93.1561209044837;
 Sat, 22 Jun 2019 06:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190614095328eucas1p24009b3a07322fd12e49eabb7a08baf50@eucas1p2.samsung.com>
 <20190614095309.24100-1-l.luba@partner.samsung.com> <20190614095309.24100-10-l.luba@partner.samsung.com>
In-Reply-To: <20190614095309.24100-10-l.luba@partner.samsung.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sat, 22 Jun 2019 22:10:08 +0900
Message-ID: <CAGTfZH35X0zE2LhGWJJp2xZNNk1ew7zNMoMqL+eZ5rcBFcPvew@mail.gmail.com>
Subject: Re: [PATCH v10 09/13] drivers: devfreq: events: add Exynos PPMU new events
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, keescook@chromium.org,
        Tony Lindgren <tony@atomide.com>, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>,
        willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

2019=EB=85=84 6=EC=9B=94 14=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 6:54, L=
ukasz Luba <l.luba@partner.samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> Define new performance events supported by Exynos5422 SoC counters.
> The counters are built-in in Dynamic Memory Controller and provide
> information regarding memory utilization.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/event/exynos-ppmu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/=
exynos-ppmu.c
> index c2ea94957501..ce658c262c27 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -89,6 +89,12 @@ static struct __exynos_ppmu_events {
>         PPMU_EVENT(d1-cpu),
>         PPMU_EVENT(d1-general),
>         PPMU_EVENT(d1-rt),
> +
> +       /* For Exynos5422 SoC */
> +       PPMU_EVENT(dmc0_0),
> +       PPMU_EVENT(dmc0_1),
> +       PPMU_EVENT(dmc1_0),
> +       PPMU_EVENT(dmc1_1),
>  };
>
>  static int exynos_ppmu_find_ppmu_id(struct devfreq_event_dev *edev)
> --
> 2.17.1
>

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

--=20
Best Regards,
Chanwoo Choi
