Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 436F74F593
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2019 14:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfFVMBi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Jun 2019 08:01:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36713 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfFVMBh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Jun 2019 08:01:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id i21so8317368ljj.3;
        Sat, 22 Jun 2019 05:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=53y8LXMm2nLzyv6UyleKaRsR+DbMLmYCyuAdvnitVr4=;
        b=pAf9lBlHGUoYX1J6Ly9ZXlHQS28Skf7Nu98zzHChFBmr0DToLcv+r6y0nPx21plOpD
         MjujOlJF21bztFyaPBGCGdT8LT81I1YaOw42Kr2GMwHRTt1XAIVWfpBA73ZXUSNtcSuI
         EXWOLRQ8p1jWpJbhqnihaxQ+uj68iMmVlOVA32o3WNqX23ceAXkGHcDUHOfDXaz3rfTp
         njX/GY2mYXOgq/aILIX6epFWHkIZgeYnleiGxoDV4L2ksqcsOKvZBJdGexgABgxJbTiV
         wE+mXnYEjAxE+naTvB6mRjzvPYSfBP8K5i4ezjVhxLB2meduchCmsxWYNGWy88R/gpSh
         5u+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=53y8LXMm2nLzyv6UyleKaRsR+DbMLmYCyuAdvnitVr4=;
        b=PoIkMrWVdLPhmvb3QLmXDhuyjU0NCBH/uzT3pg3EGxAbVtuoQBmWtotl+AiGFrQcVO
         +SshiOY6E1xSCq4jfErFpwMX35AuSR5js4jqv7l4UAaGcBDXySeYl/3FiM5fjTIWxvw8
         v/IQyApvD6pQGpPO3raEHhpYPwwq5UWze0aa58KS4Tr8WMnw7M7x3CF31Za6UUiQVzZe
         dR4C6+4mcLImBODNOBnVNA/e/KrOK7HKwWOXxyVcpW3bC6yUESbi4Rd+KHT7RiOQFpG5
         mebGhVR0M/ozTQ3lAEMvaF4wBw8ld//oxFgvru35L8i9i1doUwKVH55L/DufsENRc14i
         qM5A==
X-Gm-Message-State: APjAAAUMnUDO9HVBeBMtKIfwvZ7lGRW6uC+UmJbDV38kQ+XYCBYnL1Fi
        QJ2eRslT5Ox7B1nmk3TPDz6tZ+c6GMai2QPBBBs=
X-Google-Smtp-Source: APXvYqxqUYANN6f4iJmNqf/ZAES/avQ+3kucHEinYt4pD5hH1mhCNLLoUOy4Cj7vZ9zTLKB4wJD80d14HQbWg48ePeA=
X-Received: by 2002:a2e:8945:: with SMTP id b5mr35029280ljk.93.1561204895480;
 Sat, 22 Jun 2019 05:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190622003449.33707-1-saravanak@google.com> <20190622003449.33707-4-saravanak@google.com>
In-Reply-To: <20190622003449.33707-4-saravanak@google.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sat, 22 Jun 2019 21:00:59 +0900
Message-ID: <CAGTfZH1COWzhDBr63S18md44ypKixstHHsX7cm5LnAhXXbfecA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] PM / devfreq: Add required OPPs support to passive governor
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Absolutely, I agree this approach.
But, I add some comments on below. please check them.

2019=EB=85=84 6=EC=9B=94 22=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 9:36, S=
aravana Kannan <saravanak@google.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Look at the required OPPs of the "parent" device to determine the OPP tha=
t
> is required from the slave device managed by the passive governor. This
> allows having mappings between a parent device and a slave device even wh=
en
> they don't have the same number of OPPs.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/devfreq/governor_passive.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governo=
r_passive.c
> index 3bc29acbd54e..bd4a98bb15b1 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -21,8 +21,9 @@ static int devfreq_passive_get_target_freq(struct devfr=
eq *devfreq,
>         struct devfreq_passive_data *p_data
>                         =3D (struct devfreq_passive_data *)devfreq->data;
>         struct devfreq *parent_devfreq =3D (struct devfreq *)p_data->pare=
nt;
> +       struct opp_table *opp_table =3D NULL, *c_opp_table =3D NULL;

In this function, the base device is passive devfreq device.
So, I think that better to define the 'parent_opp_table' instead of 'opp_ta=
ble'
indicating the OPP table of parent devfreq device. And better to define
just 'opp_table' instead of 'c_opp_table' indicating the passive devfreq de=
vice.
- opp_table -> parent_opp_table
- c_opp_table -> opp_table

>         unsigned long child_freq =3D ULONG_MAX;
> -       struct dev_pm_opp *opp;
> +       struct dev_pm_opp *opp =3D NULL, *c_opp =3D NULL;

Ditto. I think that better to define the variables as following:
- opp -> parent_opp
- c_cpp -> opp

>         int i, count, ret =3D 0;
>
>         /*
> @@ -65,7 +66,20 @@ static int devfreq_passive_get_target_freq(struct devf=
req *devfreq,
>                 goto out;
>         }
>
> -       dev_pm_opp_put(opp);
> +       opp_table =3D dev_pm_opp_get_opp_table(parent_devfreq->dev.parent=
);

devfreq_passive_get_target_freq() is called frequently for DVFS support.
I think that you have to add 'struct opp_table *opp_table' instance to
'struct devfreq'
and then get 'opp_table' instance in the devfreq_add_device().

devfreq_add_device() already get the OPP information by using
dev_pm_opp_get_suspend_opp_freq().
You can add following code nearby dev_pm_opp_get_suspend_opp_freq() in
devfreq_add_device().
- devfreq->opp_table =3D dev_pm_opp_get_opp_table(dev);


> +       if (IS_ERR_OR_NULL(opp_table)) {
> +               ret =3D PTR_ERR(opp_table);
> +               goto out;
> +       }
> +
> +       c_opp_table =3D dev_pm_opp_get_opp_table(devfreq->dev.parent);
> +       if (!IS_ERR_OR_NULL(c_opp_table))
> +               c_opp =3D dev_pm_opp_xlate_opp(opp_table, c_opp_table, op=
p);
> +       if (c_opp) {
> +               *freq =3D dev_pm_opp_get_freq(c_opp);
> +               dev_pm_opp_put(c_opp);
> +               goto out;
> +       }
>
>         /*
>          * Get the OPP table's index of decided freqeuncy by governor
> @@ -92,6 +106,13 @@ static int devfreq_passive_get_target_freq(struct dev=
freq *devfreq,
>         *freq =3D child_freq;
>
>  out:
> +       if (!IS_ERR_OR_NULL(opp_table))
> +               dev_pm_opp_put_opp_table(opp_table);
> +       if (!IS_ERR_OR_NULL(c_opp_table))
> +               dev_pm_opp_put_opp_table(c_opp_table);
> +       if (!IS_ERR_OR_NULL(opp))
> +               dev_pm_opp_put(opp);
> +
>         return ret;
>  }
>
> --
> 2.22.0.410.gd8fdbe21b5-goog
>


--=20
Best Regards,
Chanwoo Choi
