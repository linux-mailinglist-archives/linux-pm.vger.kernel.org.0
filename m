Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E578F128EFB
	for <lists+linux-pm@lfdr.de>; Sun, 22 Dec 2019 18:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfLVRCI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Dec 2019 12:02:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfLVRCI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 22 Dec 2019 12:02:08 -0500
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B23A206CB;
        Sun, 22 Dec 2019 17:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577034126;
        bh=7ONFh0kZJmzuqCNXxjuaoUtDhcEsJZHLiZEAM52lyQg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rDi0QTD/hppNg0CPLYMm4egb4jl/fgzlgDqDn9HxBp3ha4GjiIyuJfpKGWwFwuxX8
         9+/AxFvGgoxDbOGspH3Y/cZg9EEpSeu3hhYLwITnN/CcPJxqayRQnNcsrsVIfULbA9
         ObV1KYoIK+g0C6VQYW8wBTcMVfyxRPcAXRPkH3v4=
Received: by mail-lj1-f178.google.com with SMTP id l2so15525026lja.6;
        Sun, 22 Dec 2019 09:02:06 -0800 (PST)
X-Gm-Message-State: APjAAAVgxwu3PdrgVDcmN2cyQwmqfukbFy0W0GQyxqOj2MCYGC/19VUo
        8SF5HGTxDMYsJuumPU/17lWesJj4uIE1HlPNVrU=
X-Google-Smtp-Source: APXvYqyC9+LU1Pe65Jvyg37Hc8D1YRGHPNz0KmwUIPogk4brK+16jbaChw+KYgiPWXlZ37c8cHAJmUWfLbxvEmBNEnQ=
X-Received: by 2002:a2e:2d01:: with SMTP id t1mr10672001ljt.36.1577034124863;
 Sun, 22 Dec 2019 09:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20191221181855.31380-1-tiny.windzz@gmail.com> <20191221181855.31380-2-tiny.windzz@gmail.com>
In-Reply-To: <20191221181855.31380-2-tiny.windzz@gmail.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Mon, 23 Dec 2019 02:01:28 +0900
X-Gmail-Original-Message-ID: <CAGTfZH2vqk1R9Hkv4DjO8ktmpHEW+mV-+xreUHPyp6ZT2D7AxA@mail.gmail.com>
Message-ID: <CAGTfZH2vqk1R9Hkv4DjO8ktmpHEW+mV-+xreUHPyp6ZT2D7AxA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM / devfreq: exynos-bus: add missing
 exynos_bus_disable_edev in exynos_bus_profile_init
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Please use capital letter for the first char of patch title
and better to edit the patch title as following:
Actually, it is difficult to understand the role by only reading
the function name. It depends on only this driver.
So, better to edit it as following because devfreq-event
is standard name in linux kernel. I think it is easy to understand
what the patch does.

- PM / devfreq: exynos-bus: Disable the devfreq-event device when failed


2019=EB=85=84 12=EC=9B=94 22=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 3:21, =
Yangtao Li <tiny.windzz@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The exynos_bus_profile_init process may fail, but the devfreq event devic=
e
> remains enabled. Call devfreq_event_disable_edev on the error return path=
.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/devfreq/exynos-bus.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 7f5917d59072..5e54eaf3cfc6 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -335,10 +335,14 @@ static int exynos_bus_profile_init(struct exynos_bu=
s *bus,
>         ret =3D exynos_bus_set_event(bus);
>         if (ret < 0) {
>                 dev_err(dev, "failed to set event to devfreq-event device=
s\n");
> -               return ret;
> +               goto err_disable_edev;
>         }
>
>         return 0;
> +
> +err_disable_edev:

err_edev is enough instead of 'err_disable_edev'

> +       exynos_bus_disable_edev(bus);

exynos_bus_disable_edev() has return value for detecting the error.
Need to add following warning message.

if (ret < 0)
     dev_warn(dev, "failed to disable the devfreq-event devices\n");


> +       return ret;
>  }
>
>  static int exynos_bus_profile_init_passive(struct exynos_bus *bus,
> --
> 2.17.1
>


--
Best Regards,
Chanwoo Choi
