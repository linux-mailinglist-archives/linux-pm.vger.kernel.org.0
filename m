Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A54361008F3
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 17:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKRQNh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 11:13:37 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44522 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfKRQNh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 11:13:37 -0500
Received: by mail-ua1-f67.google.com with SMTP id r22so5422734uam.11
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2019 08:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NOBGWjB9W9cl6b9pfrkUqhdUPzJMZSOyNn3PCn+PlXY=;
        b=ps7FFNxzjiPoJQ9IWxSNspdjSavrBxSIb1/8hgO4fWvVZk3MuL/IzGWMJZlojzw3N0
         fsMp2esNGEi5i7cLybVfBTMe5AUg6rCbtcqdMnTMp8wbzCoKZzhKiLdlhUP9yKiDuUfp
         KKdlty3s6yP+fwKvzjCYP4pIFsukDMiwP7YssOF7Nq68TNAEU5S/N84rdbG85zHFNVV+
         F4a6yxpANHANYfDOXhHn640c6Ov6vGJPOv105ib3SAmGOuAh4PR2naRaNSQQBas0D6Zv
         JpTRJbFuLDa6N7ItMBFdIDDjXI4Jss54WFJME0xUKUeJ/1icuNZ5mvUxAG/qOqlWJktQ
         qFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NOBGWjB9W9cl6b9pfrkUqhdUPzJMZSOyNn3PCn+PlXY=;
        b=XPL23d5xh7gPpKBe3bKKrzZ2mokhhbTVluR1bmLn/t/KA1iP4xPbdYS+e3h0JfIwOP
         hrl6ifvbpch0PvPQt4EJtnVwCV7gM77HC26x1VDvbiOhLw5oZJNMSojBdVRMvqLpwHML
         nmREgSfiIxdHnp08Hr/GWM5gZcnyoBpw8823PRHoGpXNGWHnbuBa367vGZAh6C0GMtiB
         s++sBKxvjgushG2weicvpTWJP6orvVVfm/+wNy+OJGGCLc6HXgYLRNh1HZ0e7+AVA84D
         i6U6DszSHwK+gHfdIiCN9OF4ZNn7OvYmrPw0hD/DDXsJPONDk/2Gd7kX2XoqXROmNO0R
         4AsQ==
X-Gm-Message-State: APjAAAW0hcn4Lp55zvbhlXgWjKKmURpV5qttRS90xmacQpkdR7XzlIuf
        +T+wW+NxzxwXxDq9DiUlSvcXVRz93+YIJohu2kjFwA==
X-Google-Smtp-Source: APXvYqyTTuF9zUwn83r+XQtchUtpg488WrjBXUa0RFM7kN+FgCR66+bwwvVp4jVfObasrgnWGDp1Mqi76P5PIhrTWYs=
X-Received: by 2002:ab0:74cd:: with SMTP id f13mr17698085uaq.104.1574093616414;
 Mon, 18 Nov 2019 08:13:36 -0800 (PST)
MIME-Version: 1.0
References: <1573995924-14752-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1573995924-14752-1-git-send-email-aisheng.dong@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Nov 2019 17:13:00 +0100
Message-ID: <CAPDyKFrkRPuJ5+1sdLevY9tqO6CoKQu6eGDKGpbYoqOUaghnPA@mail.gmail.com>
Subject: Re: [PATCH 1/1] firmware: imx: scu-pd: do not power off console domain
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dong Aisheng <dongas86@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 17 Nov 2019 at 14:07, Dong Aisheng <aisheng.dong@nxp.com> wrote:
>
> Do not power off console domain in runtime pm.

Would it be possible to configure a remote wakeup for the console
while the device becomes runtime suspended, rather than preventing the
power off altogether?

Kind regards
Uffe

>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/firmware/imx/scu-pd.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
> index b556612207e5..770e3681bbbf 100644
> --- a/drivers/firmware/imx/scu-pd.c
> +++ b/drivers/firmware/imx/scu-pd.c
> @@ -85,6 +85,8 @@ struct imx_sc_pd_soc {
>         u8 num_ranges;
>  };
>
> +int imx_con_rsrc;
> +
>  static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
>         /* LSIO SS */
>         { "pwm", IMX_SC_R_PWM_0, 8, true, 0 },
> @@ -173,6 +175,23 @@ to_imx_sc_pd(struct generic_pm_domain *genpd)
>         return container_of(genpd, struct imx_sc_pm_domain, pd);
>  }
>
> +static void imx_sc_pd_get_console_rsrc(void)
> +{
> +       struct of_phandle_args specs;
> +       int ret;
> +
> +       if (!of_stdout)
> +               return;
> +
> +       ret = of_parse_phandle_with_args(of_stdout, "power-domains",
> +                                        "#power-domain-cells",
> +                                        0, &specs);
> +       if (ret)
> +               return;
> +
> +       imx_con_rsrc = specs.args[0];
> +}
> +
>  static int imx_sc_pd_power(struct generic_pm_domain *domain, bool power_on)
>  {
>         struct imx_sc_msg_req_set_resource_power_mode msg;
> @@ -233,6 +252,7 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
>                       const struct imx_sc_pd_range *pd_ranges)
>  {
>         struct imx_sc_pm_domain *sc_pd;
> +       bool is_off = true;
>         int ret;
>
>         sc_pd = devm_kzalloc(dev, sizeof(*sc_pd), GFP_KERNEL);
> @@ -251,6 +271,10 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
>                          "%s", pd_ranges->name);
>
>         sc_pd->pd.name = sc_pd->name;
> +       if (imx_con_rsrc == sc_pd->rsrc) {
> +               sc_pd->pd.flags = GENPD_FLAG_RPM_ALWAYS_ON;
> +               is_off = false;
> +       }
>
>         if (sc_pd->rsrc >= IMX_SC_R_LAST) {
>                 dev_warn(dev, "invalid pd %s rsrc id %d found",
> @@ -260,7 +284,7 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
>                 return NULL;
>         }
>
> -       ret = pm_genpd_init(&sc_pd->pd, NULL, true);
> +       ret = pm_genpd_init(&sc_pd->pd, NULL, is_off);
>         if (ret) {
>                 dev_warn(dev, "failed to init pd %s rsrc id %d",
>                          sc_pd->name, sc_pd->rsrc);
> @@ -326,6 +350,8 @@ static int imx_sc_pd_probe(struct platform_device *pdev)
>         if (!pd_soc)
>                 return -ENODEV;
>
> +       imx_sc_pd_get_console_rsrc();
> +
>         return imx_scu_init_pm_domains(&pdev->dev, pd_soc);
>  }
>
> --
> 2.23.0
>
