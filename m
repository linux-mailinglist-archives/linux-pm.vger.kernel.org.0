Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEE61776C7
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 14:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgCCNRf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 08:17:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54545 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgCCNRf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 08:17:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id i9so1733810wml.4;
        Tue, 03 Mar 2020 05:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x1haolJvTMTs4qAKKQpFP8pY7Ez4bO8I0NW3W3vGhjY=;
        b=OuocMO5bejjzlYN7dgw8I+8i7eYd2hQHN4Z6zRclkIyqy204aGYP9hBgL0OfmqkUs2
         VwkGfDLA7OjW5W7CCKViNtEZZaKACTs29/be0YTbgm/2tmmJdc+zsgurpV68PSrI4n0y
         qZGu/h11pBgohxtCnuw9NS+/rL/fghbF5xQ9vGE6m3ZCWB4kYe1/SQko1ja8UCdmqBMb
         wMtj0pF8zR9m+qrZJof85tZdKOtQBz+s9o0hc2wRsHqnPExf3XHgaNSMhvoJxkLgV23j
         plKLYqojWrxfJGa8HkPldn1PPKxCakR7AHxQ8v1Qd88GfCwh9lu8b/GzjTgtAxKvVLgD
         qWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x1haolJvTMTs4qAKKQpFP8pY7Ez4bO8I0NW3W3vGhjY=;
        b=gjspNOzcHZj56hjMed/8JCTBxZsPZwpCkIM7lgp/4uPNljMOpLKG23PiDi8c7VQGzw
         kmVUGdn8vlhkZGlXz23YIDt5SvsArRHgjn02dB3vMBJqOtdvtHs3w3+eROtKQb1LrzuC
         AgZWYREP4zY2MFxYoAY/xFjHhP3ngMhotxOYQrkOi6naU+ZDwQ/lJX01tRrCEV5EEQSN
         bi0tMn718w52MGdWq2nmvma9qlK2nMJdBHEWsREWlLg26S46aL8sOMk0fSoyhOt47xoq
         ClqUzO9yNJwiO6KrSYAOpIAjT7UQ3aR1Cu4gEfGQrbrhIJx1eIK/sOnAXzdF7u0mow/D
         73nw==
X-Gm-Message-State: ANhLgQ2Slm0ctOd3oKSXotO7GLcXNDMmzPivSscGjq7sayVWFBG1x7DM
        g19vBjvnXcuHGbRkbzmclbfxyvN5NtkjszSKuVM=
X-Google-Smtp-Source: ADFU+vtrqxh9biAxeykoHsq+WDr8PQuEooauex3an4mdH3DhWCElhBl6tZ0babeoVFgVsf3/xOOvr2qyvHAvbWS8TDs=
X-Received: by 2002:a1c:9e51:: with SMTP id h78mr4179705wme.44.1583241453088;
 Tue, 03 Mar 2020 05:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20200302205700.29746-1-daniel.baluta@oss.nxp.com>
 <20200302205700.29746-3-daniel.baluta@oss.nxp.com> <CAFQqKeUSf_KJ3MBumZTEEUc+kUdLnL5y=kvQ2x75FziJUECqpA@mail.gmail.com>
In-Reply-To: <CAFQqKeUSf_KJ3MBumZTEEUc+kUdLnL5y=kvQ2x75FziJUECqpA@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 3 Mar 2020 15:17:21 +0200
Message-ID: <CAEnQRZBOpYASGTuBQ2Fz6Lg=L5otR2r8yr=XhsWSCHjmaB_L8w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] ASoC: SOF: Use multi PM domains helpers
To:     "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>, rjw@rjwysocki.net,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-pm@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, khilman@kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Paul Olaru <paul.olaru@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 2, 2020 at 11:26 PM Sridharan, Ranjani
<ranjani.sridharan@intel.com> wrote:
>
>
>
> On Mon, Mar 2, 2020 at 1:00 PM Daniel Baluta <daniel.baluta@oss.nxp.com> wrote:
>>
>> From: Daniel Baluta <daniel.baluta@nxp.com>
>>
>> Use dev_multi_pm_attach / dev_multi_pm_detach instead of the hardcoded
>> version.
>>
>> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>> ---
>>  sound/soc/sof/imx/imx8.c | 54 +++++-----------------------------------
>>  1 file changed, 6 insertions(+), 48 deletions(-)
>>
>> diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
>> index b692752b2178..ca740538a2d5 100644
>> --- a/sound/soc/sof/imx/imx8.c
>> +++ b/sound/soc/sof/imx/imx8.c
>> @@ -51,10 +51,7 @@ struct imx8_priv {
>>         struct imx_sc_ipc *sc_ipc;
>>
>>         /* Power domain handling */
>> -       int num_domains;
>> -       struct device **pd_dev;
>> -       struct device_link **link;
>> -
>> +       struct dev_multi_pm_domain_data *mpd;
>>  };
>>
>>  static void imx8_get_reply(struct snd_sof_dev *sdev)
>> @@ -207,7 +204,6 @@ static int imx8_probe(struct snd_sof_dev *sdev)
>>         struct resource res;
>>         u32 base, size;
>>         int ret = 0;
>> -       int i;
>>
>>         priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>>         if (!priv)
>> @@ -218,39 +214,9 @@ static int imx8_probe(struct snd_sof_dev *sdev)
>>         priv->sdev = sdev;
>>
>>         /* power up device associated power domains */
>> -       priv->num_domains = of_count_phandle_with_args(np, "power-domains",
>> -                                                      "#power-domain-cells");
>> -       if (priv->num_domains < 0) {
>> -               dev_err(sdev->dev, "no power-domains property in %pOF\n", np);
>> -               return priv->num_domains;
>> -       }
>> -
>> -       priv->pd_dev = devm_kmalloc_array(&pdev->dev, priv->num_domains,
>> -                                         sizeof(*priv->pd_dev), GFP_KERNEL);
>> -       if (!priv->pd_dev)
>> -               return -ENOMEM;
>> -
>> -       priv->link = devm_kmalloc_array(&pdev->dev, priv->num_domains,
>> -                                       sizeof(*priv->link), GFP_KERNEL);
>> -       if (!priv->link)
>> -               return -ENOMEM;
>> -
>> -       for (i = 0; i < priv->num_domains; i++) {
>> -               priv->pd_dev[i] = dev_pm_domain_attach_by_id(&pdev->dev, i);
>> -               if (IS_ERR(priv->pd_dev[i])) {
>> -                       ret = PTR_ERR(priv->pd_dev[i]);
>> -                       goto exit_unroll_pm;
>> -               }
>> -               priv->link[i] = device_link_add(&pdev->dev, priv->pd_dev[i],
>> -                                               DL_FLAG_STATELESS |
>> -                                               DL_FLAG_PM_RUNTIME |
>> -                                               DL_FLAG_RPM_ACTIVE);
>> -               if (!priv->link[i]) {
>> -                       ret = -ENOMEM;
>> -                       dev_pm_domain_detach(priv->pd_dev[i], false);
>> -                       goto exit_unroll_pm;
>> -               }
>> -       }
>> +       priv->mpd = dev_multi_pm_attach(&pdev->dev);
>> +       if (IS_ERR(priv->mpd))
>> +               return PTR_ERR(priv->mpd);
>>
>>         ret = imx_scu_get_handle(&priv->sc_ipc);
>>         if (ret) {
>> @@ -329,25 +295,17 @@ static int imx8_probe(struct snd_sof_dev *sdev)
>>  exit_pdev_unregister:
>>         platform_device_unregister(priv->ipc_dev);
>>  exit_unroll_pm:
>
> Can we also rename the label to exit_pm_detach maybe? It is no longer an unroll anymore right?

Sure, will do in v2.
