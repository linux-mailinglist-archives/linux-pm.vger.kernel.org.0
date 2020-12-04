Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68022CF39B
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 19:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgLDSHC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 13:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbgLDSHC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 13:07:02 -0500
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE059C061A52;
        Fri,  4 Dec 2020 10:06:21 -0800 (PST)
Received: by mail-vk1-xa43.google.com with SMTP id 145so1472250vky.2;
        Fri, 04 Dec 2020 10:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QRr0ZNZnscQyUTRMXdBCHRyqUplZRl6ao3xQwu2hQ2c=;
        b=SwFYmamExdBbtafEcD80BWi/4ObSmCg6tPhL99ALH+TnOB+ciAjv+wwX/Rx9Y9eC7H
         tuadWc23kn14xUXEg1v3Ht60WGKcZwF0iTCnlZkrZJrfxEEACzjeRp7jZTIzxqBHq5Vb
         oMmxp23xbsPtovYk43rZfQT92XRfOv9w3pId1E9p6vzwd5Xay51g6NMOPte9LtqDHhib
         VKjHegbVtHakbwLvSDU1nwA7+/mGR8ncPyIia2HoZUuHl/VmBmNA2aX4X32ROouN61iS
         tc/vogbnG+rOCZDSfE0WW9Uf2m8hApyPYKyC9hOKmSba1xrrIl2nzRiqoLP5gAFoA+8K
         TPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRr0ZNZnscQyUTRMXdBCHRyqUplZRl6ao3xQwu2hQ2c=;
        b=N/Mr14vcuiQNqrNITcM0DwP/QpH4N4Sgf1uswcQd9zwAuiZey9SpudPvFmUay9+n6K
         IPo+CI5zHUHJGUwnL2OqMinRJvaoDnPjnyDh7Gn0ZWuhyb02i9+OakGnJ0/s0wDQAT6h
         Wi9Ha3C5T8YdWiTCwXTi8kfLYOOcG1vLAD4FubQKbWV5RJdRIG/5L28FdrUDxfYciAXd
         B/QNpTt2CjXmeFvzq3JFGO/8u14xvBsUjcogVvzyoTPtzt+LQHzoSusKISJEQTGLGKKN
         W0qyw7nrf/faPNCMMpVD/a/yo7T/F/xNyRH/CCUsZlTAuBouz920VN/f4B10GHsraEVx
         NZyg==
X-Gm-Message-State: AOAM532MCR8Mj2kGRj8Bb7SqIZr5SIZdXXtZh2bg7sgPVLnaR1sQN3Zm
        Gicuu7aJpqv/qe1o1WsL5aDr8RuFRYoYeTjfLio=
X-Google-Smtp-Source: ABdhPJyusVJ4WEj3a2Jdt5TrXQ+w/i8ds4OcB/ET0MCxSaqFofz6EYNZnNg1a/Z82p839eKaiwoJf6wxgSL+s55Y0dg=
X-Received: by 2002:a1f:e7c2:: with SMTP id e185mr4937438vkh.23.1607105180783;
 Fri, 04 Dec 2020 10:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20201017133718.31327-1-kholk11@gmail.com> <20201017133718.31327-3-kholk11@gmail.com>
 <24ad51dd-ff54-35af-a7bc-92d8cfa30c48@linaro.org>
In-Reply-To: <24ad51dd-ff54-35af-a7bc-92d8cfa30c48@linaro.org>
From:   AngeloGioacchino Del Regno <kholk11@gmail.com>
Date:   Fri, 4 Dec 2020 19:06:09 +0100
Message-ID: <CAK7fi1ZC8F57WmDg57tAS=b++ewjPcMhBXmeuM7Cjqkp-5Zu9Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] interconnect: qcom: Add SDM660 interconnect
 provider driver
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, marijns95@gmail.com,
        Konrad Dybcio <konradybcio@gmail.com>, martin.botka1@gmail.com,
        MSM <linux-arm-msm@vger.kernel.org>, phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il giorno mar 3 nov 2020 alle ore 17:24 Georgi Djakov
<georgi.djakov@linaro.org> ha scritto:
>
> On 10/17/20 16:37, kholk11@gmail.com wrote:
> > From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> >
> > Introduce a driver for the Qualcomm interconnect busses found in
> > the SDM630/SDM636/SDM660 SoCs.
> > The topology consists of several NoCs that are controlled by a
> > remote processor that collects the aggregated bandwidth for each
> > master-slave pairs.
> >
> > On a note, these chips are managing the "bus QoS" in a "hybrid"
> > fashion: some of the paths in the topology are managed through
> > (and by, of course) the RPM uC, while some others are "AP Owned",
> > meaning that the AP shall do direct writes to the appropriate
> > QoS registers for the specific paths and ports, instead of sending
> > an indication to the RPM and leaving the job to that one.
> >
> > Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
> > ---
> >  drivers/interconnect/qcom/Kconfig  |   9 +
> >  drivers/interconnect/qcom/Makefile |   2 +
> >  drivers/interconnect/qcom/sdm660.c | 922 +++++++++++++++++++++++++++++
> >  3 files changed, 933 insertions(+)
> >  create mode 100644 drivers/interconnect/qcom/sdm660.c
> >
> [..]> +static const struct of_device_id sdm660_noc_of_match[] = {
> > +     { .compatible = "qcom,sdm660-a2noc", .data = &sdm660_a2noc },
> > +     { .compatible = "qcom,sdm660-bimc", .data = &sdm660_bimc },
> > +     { .compatible = "qcom,sdm660-cnoc", .data = &sdm660_cnoc },
> > +     { .compatible = "qcom,sdm660-gnoc", .data = &sdm660_gnoc },
> > +     { .compatible = "qcom,sdm660-mnoc", .data = &sdm660_mnoc },
> > +     { .compatible = "qcom,sdm660-snoc", .data = &sdm660_snoc },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(of, sdm660_noc_of_match);
> > +
> > +static struct platform_driver sdm660_noc_driver = {
> > +     .probe = qnoc_probe,
> > +     .remove = qnoc_remove,
> > +     .driver = {
> > +             .name = "qnoc-sdm660",
> > +             .of_match_table = sdm660_noc_of_match,
>
> Just noticed that here we should set the sync_state callback:
>                 .sync_state = icc_sync_state,
>
> I will fix it up before applying. Are you planning to send a patch
> that adds the DT nodes?
>
> Thanks,
> Georgi
>
I'm sorry for the extremely late reply... Anyway, yes, we have lots of
patches that are bringing up almost the entire feature set in the
SDM630/660 SoCs and we are waiting for them to get merged in
before sending the DT updates.

Cheers,
Angelo

> > +     },
> > +};
> > +module_platform_driver(sdm660_noc_driver);
> > +MODULE_DESCRIPTION("Qualcomm sdm660 NoC driver");
> > +MODULE_LICENSE("GPL v2");
