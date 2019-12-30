Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABFC12D2C7
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 18:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfL3Rfm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Dec 2019 12:35:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfL3Rfm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Dec 2019 12:35:42 -0500
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CE832080A;
        Mon, 30 Dec 2019 17:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577727340;
        bh=YjZsLJP99nDwq2E3J4ovBTUTnTY/uRPMv60bV8MttJk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l2pi99460cTcBY4y9/wxHor/yeLmALERgqd9fiCZPcmgvFQXSUyw1EmP01I5vNlf2
         3wR6zLvyb6oLzP79GH9JbBWEQggDkypZq1sLy3ZpRX4wBaYtDUAcWqGU1WCXgKxJPN
         NqKRFP+WOci6rj6qPx03rD6Xog+rEYpJfYIlZmoo=
Received: by mail-lj1-f170.google.com with SMTP id l2so34003132lja.6;
        Mon, 30 Dec 2019 09:35:40 -0800 (PST)
X-Gm-Message-State: APjAAAUibNS1VuQZOP05QOsJMgXT9cX9Irl5M8wf9/hyjmitZn2Zxw0M
        KLoGJeRe/zEaJwS5rX9UOb33SB+YB1pCykYMoj8=
X-Google-Smtp-Source: APXvYqx7UTyUxh3G/Zh1ouhGolU28zgq58fP5O3EjtUGcFor7aORmjygYWFwL0U0IdRcWmbTP0VNKmbMEvWbVqGjvJs=
X-Received: by 2002:a05:651c:106f:: with SMTP id y15mr13370428ljm.63.1577727338476;
 Mon, 30 Dec 2019 09:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20191230084731.15776-1-yuehaibing@huawei.com>
In-Reply-To: <20191230084731.15776-1-yuehaibing@huawei.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Tue, 31 Dec 2019 02:35:02 +0900
X-Gmail-Original-Message-ID: <CAGTfZH36sbTn++gKq+cQOXAutXQbyjbzZ_0VeU2Y037hWnROqA@mail.gmail.com>
Message-ID: <CAGTfZH36sbTn++gKq+cQOXAutXQbyjbzZ_0VeU2Y037hWnROqA@mail.gmail.com>
Subject: Re: [PATCH -next] PM / devfreq: imx8m-ddrc: Fix inconsistent IS_ERR
 and PTR_ERR
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 30, 2019 at 5:58 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix inconsistent IS_ERR and PTR_ERR in imx8m_ddrc_probe().
> Detected using Coccinelle.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/devfreq/imx8m-ddrc.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
> index 53df792..bc82d36 100644
> --- a/drivers/devfreq/imx8m-ddrc.c
> +++ b/drivers/devfreq/imx8m-ddrc.c
> @@ -395,15 +395,27 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
>         }
>
>         priv->dram_core = devm_clk_get(dev, "core");
> +       if (IS_ERR(priv->dram_core)) {
> +               ret = PTR_ERR(priv->dram_core);
> +               dev_err(dev, "failed to fetch core clock: %d\n", ret);

If there is no special reason, just use 'get' instead of ' fetch' word.
s/fetch/get

> +               return ret;
> +       }
>         priv->dram_pll = devm_clk_get(dev, "pll");
> +       if (IS_ERR(priv->dram_pll)) {
> +               ret = PTR_ERR(priv->dram_pll);
> +               dev_err(dev, "failed to fetch pll clock: %d\n", ret);

ditto.

> +               return ret;
> +       }
>         priv->dram_alt = devm_clk_get(dev, "alt");
> +       if (IS_ERR(priv->dram_alt)) {
> +               ret = PTR_ERR(priv->dram_alt);
> +               dev_err(dev, "failed to fetch alt clock: %d\n", ret);

ditto.

> +               return ret;
> +       }
>         priv->dram_apb = devm_clk_get(dev, "apb");
> -       if (IS_ERR(priv->dram_core) ||
> -               IS_ERR(priv->dram_pll) ||
> -               IS_ERR(priv->dram_alt) ||
> -               IS_ERR(priv->dram_apb)) {
> -               ret = PTR_ERR(priv->devfreq);
> -               dev_err(dev, "failed to fetch clocks: %d\n", ret);
> +       if (IS_ERR(priv->dram_apb)) {
> +               ret = PTR_ERR(priv->dram_apb);
> +               dev_err(dev, "failed to fetch apb clock: %d\n", ret);

ditto.

>                 return ret;
>         }
>
> --
> 2.7.4
>
>


-- 
Best Regards,
Chanwoo Choi
