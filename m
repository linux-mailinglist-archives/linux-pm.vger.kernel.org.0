Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C249312E4D9
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2020 11:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgABKOe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jan 2020 05:14:34 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40977 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgABKOe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2020 05:14:34 -0500
Received: by mail-io1-f68.google.com with SMTP id c16so34246573ioo.8
        for <linux-pm@vger.kernel.org>; Thu, 02 Jan 2020 02:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vBeGvmCFUCzP36j3jIZNADL3Uzi2UJzrCXsRaiggEfs=;
        b=o3lvVAyE9Xh/rhht5WWaQ0avsGbFgKdsKIhs+4TkV5qyCPFsTsaRgeqvj7Ayj5OWe6
         q5iUTmluhN6YkbWpc5npCIbIjWEv0ah9YW/hxJZTTBNR+DX3VC+FXJLqpqTWU60d7005
         a1BVDuIv7btBp9Oz3jonh7kc5bJIDkBQnj1zIiexDEOit46UD6IjkBeqLST0UH6uRG0E
         PXs4DAyibJ2CWxZoMWoBpWWQgYCOyKjgTHYZVfxBJiGpxCAeyQxEqTmf1xWS0nGyiIIU
         ufk3u6+ZJ/hG8iKxMlArtfBmlLKWFZogmm6y1Zg6d4KYHXiaQVDTD+QPBxMpFKfVLHj7
         RMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vBeGvmCFUCzP36j3jIZNADL3Uzi2UJzrCXsRaiggEfs=;
        b=bVl5mhW2PFyvEqhUDUpfLsdc4E8YTHz7p3mczkPH+yjVPPXlKmlNLW9tw+sZ1ArI2d
         WOadam9kxmaalitIcw38MF9Y3ckTt0tLTlRQfh4rgLgfFVQfbwMqeQQy4/0T26OZpYC9
         h7QF76uw6yriBdS2JPfdLXpdN974IA1VIwCArQkmxG5mUPaWZsmSnc454tmkCcyyqBbz
         Rpn8Pckkez3Gpkg/SW35dlxlX9N9sNe6PCBBk6Qnt5DMHn8piPxhYHdwkcwijSFkbxbI
         lTL+0lYbJ35MN5MeDP4UWxovigCYssj6vx+nM7634h4Awy9veWTkYpukClnIZ/yiNMLk
         rPuQ==
X-Gm-Message-State: APjAAAXIxSUuAIcPuh/qpq+lEwGuEaA3n2UhJuOo3MQNtBSX/pruJZTz
        mG882GlAXgLyx3TvJpeWTvOLXczR51tNvOrse90=
X-Google-Smtp-Source: APXvYqwu/NDnM1yUG1ZOthyk6XYV57p8kMjpibTj38aKaQuF9qmsfXqBpG/fzDR2mf9HeHw3fM5LhMmR8hPLr0eZyiU=
X-Received: by 2002:a6b:7409:: with SMTP id s9mr56420482iog.197.1577960073577;
 Thu, 02 Jan 2020 02:14:33 -0800 (PST)
MIME-Version: 1.0
References: <1573995924-14752-1-git-send-email-aisheng.dong@nxp.com> <CAPDyKFrkRPuJ5+1sdLevY9tqO6CoKQu6eGDKGpbYoqOUaghnPA@mail.gmail.com>
In-Reply-To: <CAPDyKFrkRPuJ5+1sdLevY9tqO6CoKQu6eGDKGpbYoqOUaghnPA@mail.gmail.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Thu, 2 Jan 2020 18:03:13 +0800
Message-ID: <CAA+hA=Rsje8mW6sqfiiYKQzwz_3F88+AdJZoN5ZHShqnOqkUQw@mail.gmail.com>
Subject: Re: [PATCH 1/1] firmware: imx: scu-pd: do not power off console domain
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Fugang Duan <fugang.duan@nxp.com>, ranjani.vaidyanathan@nxp.com
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 19, 2019 at 12:13 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Sun, 17 Nov 2019 at 14:07, Dong Aisheng <aisheng.dong@nxp.com> wrote:
> >
> > Do not power off console domain in runtime pm.
>
> Would it be possible to configure a remote wakeup for the console
> while the device becomes runtime suspended, rather than preventing the
> power off altogether?
>

Remote wakeup usually requires clock and power.
Not sure if this device can support it. Copy module owner (Fugang
Duan) to confirm.

The current lpuart driver seems not support.

Regards
Aisheng

> Kind regards
> Uffe
>
> >
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >  drivers/firmware/imx/scu-pd.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
> > index b556612207e5..770e3681bbbf 100644
> > --- a/drivers/firmware/imx/scu-pd.c
> > +++ b/drivers/firmware/imx/scu-pd.c
> > @@ -85,6 +85,8 @@ struct imx_sc_pd_soc {
> >         u8 num_ranges;
> >  };
> >
> > +int imx_con_rsrc;
> > +
> >  static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
> >         /* LSIO SS */
> >         { "pwm", IMX_SC_R_PWM_0, 8, true, 0 },
> > @@ -173,6 +175,23 @@ to_imx_sc_pd(struct generic_pm_domain *genpd)
> >         return container_of(genpd, struct imx_sc_pm_domain, pd);
> >  }
> >
> > +static void imx_sc_pd_get_console_rsrc(void)
> > +{
> > +       struct of_phandle_args specs;
> > +       int ret;
> > +
> > +       if (!of_stdout)
> > +               return;
> > +
> > +       ret = of_parse_phandle_with_args(of_stdout, "power-domains",
> > +                                        "#power-domain-cells",
> > +                                        0, &specs);
> > +       if (ret)
> > +               return;
> > +
> > +       imx_con_rsrc = specs.args[0];
> > +}
> > +
> >  static int imx_sc_pd_power(struct generic_pm_domain *domain, bool power_on)
> >  {
> >         struct imx_sc_msg_req_set_resource_power_mode msg;
> > @@ -233,6 +252,7 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
> >                       const struct imx_sc_pd_range *pd_ranges)
> >  {
> >         struct imx_sc_pm_domain *sc_pd;
> > +       bool is_off = true;
> >         int ret;
> >
> >         sc_pd = devm_kzalloc(dev, sizeof(*sc_pd), GFP_KERNEL);
> > @@ -251,6 +271,10 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
> >                          "%s", pd_ranges->name);
> >
> >         sc_pd->pd.name = sc_pd->name;
> > +       if (imx_con_rsrc == sc_pd->rsrc) {
> > +               sc_pd->pd.flags = GENPD_FLAG_RPM_ALWAYS_ON;
> > +               is_off = false;
> > +       }
> >
> >         if (sc_pd->rsrc >= IMX_SC_R_LAST) {
> >                 dev_warn(dev, "invalid pd %s rsrc id %d found",
> > @@ -260,7 +284,7 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
> >                 return NULL;
> >         }
> >
> > -       ret = pm_genpd_init(&sc_pd->pd, NULL, true);
> > +       ret = pm_genpd_init(&sc_pd->pd, NULL, is_off);
> >         if (ret) {
> >                 dev_warn(dev, "failed to init pd %s rsrc id %d",
> >                          sc_pd->name, sc_pd->rsrc);
> > @@ -326,6 +350,8 @@ static int imx_sc_pd_probe(struct platform_device *pdev)
> >         if (!pd_soc)
> >                 return -ENODEV;
> >
> > +       imx_sc_pd_get_console_rsrc();
> > +
> >         return imx_scu_init_pm_domains(&pdev->dev, pd_soc);
> >  }
> >
> > --
> > 2.23.0
> >
