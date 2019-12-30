Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 095E212D323
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2019 19:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfL3SJd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Dec 2019 13:09:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbfL3SJc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Dec 2019 13:09:32 -0500
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 257D021D7D;
        Mon, 30 Dec 2019 18:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577729372;
        bh=CIxky4h0LVYFSbOfjb+Wx3SNAnNGLt1D4UQk5UmNk1c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vlN+7jezkIv4FXDqX/nz1VaDVfc0s34AOc7VRoXixFBvyBf2NS7UAvciKl5f4JrS2
         COyw+4rmt4XdgJO7vLxLwTnzzegkh9+Of/s9YxdiQYIZmhvTVWwkokqMsc0fFhJJxn
         v3XwBo0Id+PIVVPcAWYLHjWEznXovcBggYYfbJzU=
Received: by mail-lj1-f169.google.com with SMTP id j26so34086104ljc.12;
        Mon, 30 Dec 2019 10:09:32 -0800 (PST)
X-Gm-Message-State: APjAAAX1r2MxcVz5HRDCf84rVfVONk6OlhIApDFY8J6k1TXsCV3Fbssq
        p7RgpnjCLOe3l4+Nhme5x0PnztDLwNkgyIRrb7s=
X-Google-Smtp-Source: APXvYqxAdJs6SJdFryPxW5wX+hRhHZJW2xGaMVjcJOAmu8Z8ylrrHPwlJUTmAdPyoyHqqnMnIhBmj+nLKuPGfSg7On4=
X-Received: by 2002:a2e:a361:: with SMTP id i1mr37666609ljn.29.1577729370158;
 Mon, 30 Dec 2019 10:09:30 -0800 (PST)
MIME-Version: 1.0
References: <20191230084731.15776-1-yuehaibing@huawei.com> <CAGTfZH36sbTn++gKq+cQOXAutXQbyjbzZ_0VeU2Y037hWnROqA@mail.gmail.com>
In-Reply-To: <CAGTfZH36sbTn++gKq+cQOXAutXQbyjbzZ_0VeU2Y037hWnROqA@mail.gmail.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Tue, 31 Dec 2019 03:08:53 +0900
X-Gmail-Original-Message-ID: <CAGTfZH34ufvwco8w6GN8E=KUuSeCfjFk4bR7PnotbLso0UNzoA@mail.gmail.com>
Message-ID: <CAGTfZH34ufvwco8w6GN8E=KUuSeCfjFk4bR7PnotbLso0UNzoA@mail.gmail.com>
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

On Tue, Dec 31, 2019 at 2:35 AM Chanwoo Choi <chanwoo@kernel.org> wrote:
>
> On Mon, Dec 30, 2019 at 5:58 PM YueHaibing <yuehaibing@huawei.com> wrote:
> >
> > Fix inconsistent IS_ERR and PTR_ERR in imx8m_ddrc_probe().
> > Detected using Coccinelle.
> >
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/devfreq/imx8m-ddrc.c | 24 ++++++++++++++++++------
> >  1 file changed, 18 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
> > index 53df792..bc82d36 100644
> > --- a/drivers/devfreq/imx8m-ddrc.c
> > +++ b/drivers/devfreq/imx8m-ddrc.c
> > @@ -395,15 +395,27 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
> >         }
> >
> >         priv->dram_core = devm_clk_get(dev, "core");
> > +       if (IS_ERR(priv->dram_core)) {
> > +               ret = PTR_ERR(priv->dram_core);
> > +               dev_err(dev, "failed to fetch core clock: %d\n", ret);
>
> If there is no special reason, just use 'get' instead of ' fetch' word.
> s/fetch/get

Usually, use 'verb' included in function name to show the debug message.
But, Again thinking. the original comment used 'fetch' word. Please
ignore my comment

Applied it.

(snip)

Best Regards,
Chanwoo Choi
