Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7803C1266BD
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 17:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfLSQW0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 11:22:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:33242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfLSQW0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Dec 2019 11:22:26 -0500
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 637D524650
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 16:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576772545;
        bh=8OuFFD1TFHDoCrgZRL1h9iYeu7sAdMLkzDh6ZazxVv0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xW+MceaUkzQchW0YpKJ9RQZctcv7phmV5BbEr2UTMV3tWzq6oC23a2pVM69DyMaZH
         fLB/SN7iS/gyl+SSuEPGQrX1rrwa1SUozRB2vkRf/TjMIgZ43Csm3xwy8mf0IWJBkC
         5/npyR1EtgqpSVWueQBqBT1B1YPusOFO0eJuK08A=
Received: by mail-lf1-f44.google.com with SMTP id b15so4780839lfc.4
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 08:22:25 -0800 (PST)
X-Gm-Message-State: APjAAAVN2zRUXw8V56kSKczeQ/QS2LC4inB1ahZa5Jjjsg+0m6kjhOdD
        n4w928KhheOS3VIWr/QCMEYmwC7PIANVvoZhRzk=
X-Google-Smtp-Source: APXvYqze9h9zYParr2EHk1MaY5ARIQ4YV1nSXLXSOoiPLwUieUFE8IclP58x/cxSU7P/mdd88b/5nuQQmcrPbf86df0=
X-Received: by 2002:ac2:5444:: with SMTP id d4mr6177339lfn.49.1576772543571;
 Thu, 19 Dec 2019 08:22:23 -0800 (PST)
MIME-Version: 1.0
References: <9e89485ca173e1d118748dbe5cfc7068f74079bf.1576769985.git.leonard.crestez@nxp.com>
In-Reply-To: <9e89485ca173e1d118748dbe5cfc7068f74079bf.1576769985.git.leonard.crestez@nxp.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Fri, 20 Dec 2019 01:21:47 +0900
X-Gmail-Original-Message-ID: <CAGTfZH3BNkq4Rz9qgBwXABsPyaiE6V+3ApEfCdS67AZK957jVw@mail.gmail.com>
Message-ID: <CAGTfZH3BNkq4Rz9qgBwXABsPyaiE6V+3ApEfCdS67AZK957jVw@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: imx8m-ddrc: Remove unused defines
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

2019=EB=85=84 12=EC=9B=94 20=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 12:43,=
 Leonard Crestez <leonard.crestez@nxp.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> The IMX_SIP_DDR_DVFS_WAIT_CHANGE and IMX_SIP_DDR_FREQ_SET_HIGH defines
> are not used so they can be removed.
>
> Fixes: 518e99e2a22e ("PM / devfreq: Add dynamic scaling for imx8m ddr con=
troller")
>
> Reported-by: Shawn Guo <shawn.guo@kernel.org>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/imx8m-ddrc.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
> index fea169619c59..ecbb1db05ea0 100644
> --- a/drivers/devfreq/imx8m-ddrc.c
> +++ b/drivers/devfreq/imx8m-ddrc.c
> @@ -13,16 +13,10 @@
>  #include <linux/clk-provider.h>
>  #include <linux/arm-smccc.h>
>
>  #define IMX_SIP_DDR_DVFS                       0xc2000004
>
> -/* Values starting from 0 switch to specific frequency */
> -#define IMX_SIP_DDR_FREQ_SET_HIGH              0x00
> -
> -/* Deprecated after moving IRQ handling to ATF */
> -#define IMX_SIP_DDR_DVFS_WAIT_CHANGE           0x0F
> -
>  /* Query available frequencies. */
>  #define IMX_SIP_DDR_DVFS_GET_FREQ_COUNT                0x10
>  #define IMX_SIP_DDR_DVFS_GET_FREQ_INFO         0x11
>
>  /*
> --
> 2.17.1
>

Applied it. Thanks.

--=20
Best Regards,
Chanwoo Choi
