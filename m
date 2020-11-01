Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141B52A1F3A
	for <lists+linux-pm@lfdr.de>; Sun,  1 Nov 2020 16:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgKAPpF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Nov 2020 10:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgKAPpF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Nov 2020 10:45:05 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA42C0617A6;
        Sun,  1 Nov 2020 07:45:04 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id m8so6216555ljj.0;
        Sun, 01 Nov 2020 07:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=BF6aA5CIfaBcjhWZUFgNy7TEYYJ3FC7M7UBxQrI1c2M=;
        b=PMe0bwOlnUxyD3/4NXV4dHSLJp+kB6g8F0K4enKTClEXWbQqNWg66XVNbUaJupxYep
         /0uh9Cu3aghYoOt4VMuvNLpxBZKqEJzthOGTDlRRT+6/L3//bq2oPwO3861J9dGJgvxQ
         GZYca37o9/20gTP9N/ySBekCgb/r+kkfdSICywZorBblSBhSdBqjJggwMpqTRV2xS4t+
         fJGh3Jas6TqpCHepa5itTTS9G8PzJNRYVyWxAitZ5CPXihW0n4RUU2qtdB/H0+8+0uG4
         GQ1SZayNLeQSxkG6V4F8lxkMPMgUFCvCb8Gh1N90zdEyxB8uOVEnDbE4S5IlWfTbDdML
         WZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=BF6aA5CIfaBcjhWZUFgNy7TEYYJ3FC7M7UBxQrI1c2M=;
        b=mA20EPcIRQA604vhyXzeP8T93/szmCK7ek/PplgGswLAo59MnSlvJvrdPjdmNiN0Pu
         vOAGEhks2/fA5b76Ax4mVpN/ayRfnaOFa4jHr32U6oEKsisE6yuZlKVf8cFdJkgmpOPB
         7Xzib4nLMkYbu51GO8F8RQSc98ZjIWZ27426lvWM3gAYJWNxsOIEtee7wCKRX5Z8t7D/
         1bApLEve7AhqBQPuP+T39W9GUwcAlfIdF4+6doZKs2QDSpDNtdZaWUEBfYPlb9XD2Qm4
         q1FFoOPbv6ImqGT7tNtacgXxdCKYhNzgyyxYeTznuYdXFby41krgnSCdw/eYPPDdFHr7
         Kj+g==
X-Gm-Message-State: AOAM5309XFNcyRCp85PbI7EJLhEpTVYGtM/sVzduHbBr47BtWeMNxXn3
        Ef7hZDy0u5NVpFbx4kfvUQsedGYqpa1VKarvcUY=
X-Google-Smtp-Source: ABdhPJwUv35pXb2B/fbHSYe/6UQxWAyeoft5VglqYDISVC9YYpFQBagRZ95bYPoGxVl6T7ANZzL62Do8nBGrFGjXR8U=
X-Received: by 2002:a2e:681a:: with SMTP id c26mr5152150lja.56.1604245503006;
 Sun, 01 Nov 2020 07:45:03 -0800 (PST)
MIME-Version: 1.0
References: <20201025221735.3062-1-digetx@gmail.com> <20201025221735.3062-52-digetx@gmail.com>
 <CAGTfZH1PV4r-pD=zTKD71nQb5+UobJKa5mBv-Nb2ZgSubkscjA@mail.gmail.com> <2ebd184c-60e8-19e2-9965-19481ced1c70@gmail.com>
In-Reply-To: <2ebd184c-60e8-19e2-9965-19481ced1c70@gmail.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Mon, 2 Nov 2020 00:44:26 +0900
Message-ID: <CAGTfZH0=6R02euOR3JHgA0iLq5++Yvp3Z_wBCEs7bzkfuorEFQ@mail.gmail.com>
Subject: Re: [PATCH v6 51/52] PM / devfreq: tegra30: Support interconnect and
 OPPs from device-tree
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On Mon, Nov 2, 2020 at 12:23 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 01.11.2020 17:39, Chanwoo Choi =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Hi Dmitry,
> >
> > On Mon, Oct 26, 2020 at 7:22 AM Dmitry Osipenko <digetx@gmail.com> wrot=
e:
> >>
> >> This patch moves ACTMON driver away from generating OPP table by itsel=
f,
> >> transitioning it to use the table which comes from device-tree. This
> >> change breaks compatibility with older device-trees in order to bring
> >> support for the interconnect framework to the driver. This is a mandat=
ory
> >> change which needs to be done in order to implement interconnect-based
> >> memory DVFS. Users of legacy device-trees will get a message telling t=
hat
> >> theirs DT needs to be upgraded. Now ACTMON issues memory bandwidth req=
uest
> >> using dev_pm_opp_set_bw(), instead of driving EMC clock rate directly.
> >>
> >> Tested-by: Peter Geis <pgwipeout@gmail.com>
> >> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> ...
> >>  static int tegra_devfreq_get_dev_status(struct device *dev,
> >> @@ -655,7 +643,7 @@ static int tegra_devfreq_get_dev_status(struct dev=
ice *dev,
> >>         stat->private_data =3D tegra;
> >>
> >>         /* The below are to be used by the other governors */
> >> -       stat->current_frequency =3D cur_freq;
> >> +       stat->current_frequency =3D cur_freq * KHZ;
> >
> > I can't find any change related to the frequency unit on this patch.
> > Do you fix the previous bug of the frequency unit?
>
> Previously, OPP entries that were generated by the driver used KHz
> units. Now, OPP entries are coming from a device-tree and they have Hz
> units. This driver operates with KHz internally, hence we need to
> convert the units now.

OK. Thanks.

>
> >>
> >>         actmon_dev =3D &tegra->devices[MCALL];
> >>
> >> @@ -705,7 +693,7 @@ static int tegra_governor_get_target(struct devfre=
q *devfreq,
> >>                 target_freq =3D max(target_freq, dev->target_freq);
> >>         }
> >>
> >> -       *freq =3D target_freq;
> >> +       *freq =3D target_freq * KHZ;
> >
> > ditto.
> >
> >>
> >>         return 0;
> >>  }
> >> @@ -773,13 +761,22 @@ static struct devfreq_governor tegra_devfreq_gov=
ernor =3D {
> >>
> >>  static int tegra_devfreq_probe(struct platform_device *pdev)
> >>  {
> >> +       u32 hw_version =3D BIT(tegra_sku_info.soc_speedo_id);
> >>         struct tegra_devfreq_device *dev;
> >>         struct tegra_devfreq *tegra;
> >> +       struct opp_table *opp_table;
> >>         struct devfreq *devfreq;
> >>         unsigned int i;
> >>         long rate;
> >>         int err;
> >>
> >> +       /* legacy device-trees don't have OPP table and must be update=
d */
> >> +       if (!device_property_present(&pdev->dev, "operating-points-v2"=
)) {
> >> +               dev_err(&pdev->dev, "OPP table not found, cannot conti=
nue\n");
> >> +               dev_err(&pdev->dev, "please update your device tree\n"=
);
> >> +               return -ENODEV;
> >> +       }
> >
> > As you mentioned, it breaks the old dtb. I have no objection to improvi=
ng
> > the driver. Instead, you need confirmation from the Devicetree maintain=
er.
>
> Older DTBs will continue to work, but devfreq driver won't. We already
> did this for other Tegra drivers before (CPUFREQ driver for example) and
> Rob Herring confirmed that there is no problem here.

OK.

>
> > And,
> > I recommend that you use dev_pm_opp_of_get_opp_desc_node(&pdev->dev)
> > to check whether a device contains opp-table or not.
>
> I'm not sure what are the benefits, this will make code less
> expressive/readable and we will need to add extra of_node_put(), which
> device_property_present() handles for us.
>
> Could you please give the rationale?

IMO, 'operating-points-v2' word was defined on OPP core. I think that
the external user
of OPP better to use the public helper function instead of using the
interval definition
or value of OPP core directly. Basically, I prefer the provided helper
function if there.
But, it is not critical and doesn't affect the operation. If you want
to keep, it is ok.

>
> >> +
> >>         tegra =3D devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL)=
;
> >>         if (!tegra)
> >>                 return -ENOMEM;
> >> @@ -821,11 +818,29 @@ static int tegra_devfreq_probe(struct platform_d=
evice *pdev)
> >>                 return err;
> >>         }
> >>
> >> +       tegra->opp_table =3D dev_pm_opp_get_opp_table(&pdev->dev);
> >> +       if (IS_ERR(tegra->opp_table))
> >> +               return dev_err_probe(&pdev->dev, PTR_ERR(tegra->opp_ta=
ble),
> >> +                                    "Failed to prepare OPP table\n");
> >
> > As I knew, each device can contain the opp_table on devicetree.
> > It means that opp_table has not depended to another device driver.
> > Did you see this exception case with EPROBE_DEFER error?
>
> OPP core will try to grab the clock reference for the table and it may
> cause EPROBE_DEFER. Although, it shouldn't happen here because we have
> devm_clk_get() before the get_opp_table(), hence seems the deferred
> probe indeed shouldn't happen in this case.

It is my missing point. If there, you're right.
Could you provide the code point to check the clock reference on the OPP co=
re?

--=20
Best Regards,
Chanwoo Choi
