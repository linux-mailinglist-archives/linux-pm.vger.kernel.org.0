Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4463D1776FF
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 14:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgCCN3r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 08:29:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39028 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgCCN3r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 08:29:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so4340556wrn.6;
        Tue, 03 Mar 2020 05:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hicGAyZ5CpHfmsbw4Kl9cPGuNpt8g32PuytU/UcEDL8=;
        b=CV1elQMgZLhBpuFfL5DjPopxXqFjooMD4nNFS/3zO/mg/Y0/qPPlbnp33SZup+b6Xn
         R0cE9JzQP4R+zgJnfJFQeNA7dybshykF3a2Ldu9qefqWJuiMHnZSFlgqQpSJtEsRyXab
         qAGDJu1tgLL/6+jZDbiLPhijElTtaRK5jMYuE82RT5dC2hH+bHvuAP9EdL3BBOjQkmxT
         IqqyonwLWKq58HGm6CL1MVGtHWy1+FBRHWDoYPPWKlVhP9gL8EQOMMNbZGEZrl7vM5RD
         qncE4ethqNSxzsEB357sbW5pZKYYUinUGRcUtKfY65TpSbFeZUURs1wPKt6vMXtGRShc
         wPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hicGAyZ5CpHfmsbw4Kl9cPGuNpt8g32PuytU/UcEDL8=;
        b=B0I+pBRyERpcphZ6LbOgvprf5w8MAWJiv1sPM5AC3awdlw3KTkGkLX7OxpVPIZiURU
         AM5BuM5zrZmZmjY/PV3Bro0qceBDBGZv56B3QcNkJUCqrMN2f1b3XF3CpEzpvHY39rG8
         Br79LahWoMWlOyZkAY4Vt48Z81NAtv8aDYVaF0x7cSOH8HZhhAVJDPl/vXIYWa29u9TS
         7Pmuttt7RDCNvuxH4wkPMRm7NegER+YE52oNKVOYHT2+td5zRKB0Ea2zsQzkx+yTk+iz
         RHSzw1EnQ2PZfIL4/Vn+Ykb/0JNlm7YF28RzF1Bptgf0ySOgKT46v03wTBe0ZciGa9t5
         CQJA==
X-Gm-Message-State: ANhLgQ2MoEKt5w3eVarxLKyNNjjBqnPkjB4XuhYXLzz09j63mg5c3rS4
        HOAXh4Mpa1DTLKP9Shpbl7u332QjfKYDxPkoZvE=
X-Google-Smtp-Source: ADFU+vuFtNgxjbewAK+JcEL9uWLOVuASSCsfonI72+FgdQg4t/bXLC/G4KfOc+tj4z3cmF6C36Db39T7GycrQg3xlxQ=
X-Received: by 2002:adf:9dcc:: with SMTP id q12mr5802969wre.164.1583242185866;
 Tue, 03 Mar 2020 05:29:45 -0800 (PST)
MIME-Version: 1.0
References: <20200302205700.29746-1-daniel.baluta@oss.nxp.com>
 <20200302205700.29746-2-daniel.baluta@oss.nxp.com> <CAFQqKeU8YF+aZVTafj3ZiPvNUsx3nK-8cdr8eJUm=_9_2TkRQg@mail.gmail.com>
In-Reply-To: <CAFQqKeU8YF+aZVTafj3ZiPvNUsx3nK-8cdr8eJUm=_9_2TkRQg@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 3 Mar 2020 15:29:34 +0200
Message-ID: <CAEnQRZBNMRNYOKwqweuZCeOYgMGh9DprRvz2ci3EOQPxqN3fhg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] PM / domains: Introduce multi PM domains helpers
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

Hello Ranjani,

On Mon, Mar 2, 2020 at 11:24 PM Sridharan, Ranjani
<ranjani.sridharan@intel.com> wrote:

>> + */
>> +struct dev_multi_pm_domain_data *dev_multi_pm_attach(struct device *dev)
>> +{
>> +       struct dev_multi_pm_domain_data *mpd, *retp;
>> +       int num_domains;
>> +       int i;
>> +
>> +       num_domains = of_count_phandle_with_args(dev->of_node, "power-domains",
>> +                                                "#power-domain-cells");
>> +       if (num_domains < 2)
>
> Hi Daniel,
>
> Just out of curiosity, should it be an error when num_domains is 1? Is it an error because the expectation is that the caller would use dev_pm_domain_attach() in that case?

NULL here doesn't really mean an error. It means that we don't need to
handle Power domains because as you said the caller
already used dev_pm_domain_attach.

Similar with this:

$ drivers/base/power/domain.c +2504

int genpd_dev_pm_attach(struct device *dev)

         / * Devices with multiple PM domains must be attached separately, as we
           * can only attach one PM domain per device.
          */
        if (of_count_phandle_with_args(dev->of_node, "power-domains",
                                    "#power-domain-cells") != 1)
               return 0;

Will update the description for when this function returns a NULL.

>
>> +               return NULL;
>> +
>> +       mpd = devm_kzalloc(dev, GFP_KERNEL, sizeof(*mpd));
>> +       if (!mpd)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       mpd->dev = dev;
>> +       mpd->num_domains = num_domains;
>> +
>> +       mpd->virt_devs = devm_kmalloc_array(dev, mpd->num_domains,
>> +                                           sizeof(*mpd->virt_devs),
>> +                                           GFP_KERNEL);
>> +       if (!mpd->virt_devs)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       mpd->links = devm_kmalloc_array(dev, mpd->num_domains,
>> +                                       sizeof(*mpd->links), GFP_KERNEL);
>> +       if (!mpd->links)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       for (i = 0; i < mpd->num_domains; i++) {
>> +               mpd->virt_devs[i] = dev_pm_domain_attach_by_id(dev, i);
>> +               if (IS_ERR(mpd->virt_devs[i])) {
>> +                       retp = (struct dev_multi_pm_domain_data *)
>> +                               mpd->virt_devs[i];
>
> Should retp be PTR_ERR(mpd->virt_devs[i]) here?

PTR_ERR returns a long but our function needs to return struct
dev_multi_pm_domain_data *.

> Thanks,
> Ranjani
