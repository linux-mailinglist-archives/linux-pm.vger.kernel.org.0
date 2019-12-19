Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDF31266B6
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 17:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLSQWB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 11:22:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:60888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfLSQWB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 11:22:01 -0500
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EFD424650
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576772520;
        bh=8cHyARGEDs7lTo3LVRUHzaY/3fzYFhr6LHjqGqDD3sQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dNtqxXSb9RXsgjsat5GnJUPwKcZtcZp11VhmiNaiNQsBD9zVMLFpnARICIGeHXLRf
         Ig2mOcrqGHLUKgN4z/gll+WKDOM4FOC+lcazelwP4i5lgO+XQivVuKuuPiFYicaI9i
         Jx4r+RMV71eKLzNjdE67xPINiCnkv+A0ko0ZkqZw=
Received: by mail-lj1-f181.google.com with SMTP id p8so6917610ljg.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 08:22:00 -0800 (PST)
X-Gm-Message-State: APjAAAUuJUf3VZg2vuy9TvQAomS5Kv3K9y5q/OXLHDjbn1ChXN9EFvTa
        ytKX+TcOorZU7sN5QS/eOFR9WFzLx5ovdOf++UA=
X-Google-Smtp-Source: APXvYqxl+K5zBixu/7n+VPaR/qjqPttipninehsXtuq3tlmTV5OThfj30o7TWHIisjKoIrLzeBZl5H8DFoS3neFEJ40=
X-Received: by 2002:a2e:9b05:: with SMTP id u5mr6673387lji.59.1576772518791;
 Thu, 19 Dec 2019 08:21:58 -0800 (PST)
MIME-Version: 1.0
References: <8485366fbf06600d528ac31ef4a873f6717f2fd7.1576770177.git.leonard.crestez@nxp.com>
In-Reply-To: <8485366fbf06600d528ac31ef4a873f6717f2fd7.1576770177.git.leonard.crestez@nxp.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Fri, 20 Dec 2019 01:21:22 +0900
X-Gmail-Original-Message-ID: <CAGTfZH30gYt-o3fJtOKKuUh5Qh0V4xybB3ahH5YVpeD5d=acRg@mail.gmail.com>
Message-ID: <CAGTfZH30gYt-o3fJtOKKuUh5Qh0V4xybB3ahH5YVpeD5d=acRg@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: imx8m-ddrc: Fix argument swap in error print
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Adam Ford <aford173@gmail.com>,
        Martin Kepplinger <martink@posteo.de>,
        Jacky Bai <ping.bai@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, kernel@pengutronix.de,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=EB=85=84 12=EC=9B=94 20=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 12:44,=
 Leonard Crestez <leonard.crestez@nxp.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> When frequency adjustment fails the old/new frequencies are swapped on
> the dev_err call.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/imx8m-ddrc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
> index ecbb1db05ea0..53df7923d893 100644
> --- a/drivers/devfreq/imx8m-ddrc.c
> +++ b/drivers/devfreq/imx8m-ddrc.c
> @@ -258,14 +258,14 @@ static int imx8m_ddrc_target(struct device *dev, un=
signed long *freq, u32 flags)
>         ret =3D imx8m_ddrc_set_freq(dev, freq_info);
>
>         new_freq =3D clk_get_rate(priv->dram_core);
>         if (ret)
>                 dev_err(dev, "ddrc failed freq switch to %lu from %lu: er=
ror %d. now at %lu\n",
> -                       old_freq, *freq, ret, new_freq);
> +                       *freq, old_freq, ret, new_freq);
>         else if (*freq !=3D new_freq)
>                 dev_err(dev, "ddrc failed freq update to %lu from %lu, no=
w at %lu\n",
> -                       old_freq, *freq, new_freq);
> +                       *freq, old_freq, new_freq);
>         else
>                 dev_dbg(dev, "ddrc freq set to %lu (was %lu)\n",
>                         *freq, old_freq);
>
>         return ret;
> --
> 2.17.1
>

If you agree, I want to squash this patch to original patch on
devfreq-next patch
without separate patch applied.

--=20
Best Regards,
Chanwoo Choi
