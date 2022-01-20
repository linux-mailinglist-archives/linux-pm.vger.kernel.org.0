Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75607494925
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jan 2022 09:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbiATIJN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jan 2022 03:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiATIJM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jan 2022 03:09:12 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F373C061574
        for <linux-pm@vger.kernel.org>; Thu, 20 Jan 2022 00:09:12 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id c3so2896237qtc.8
        for <linux-pm@vger.kernel.org>; Thu, 20 Jan 2022 00:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VCrnjmg62GINPJxRBMFr0Mam1wLzssanbuVrozbPcEE=;
        b=IdMLEYbasyzvUJ8ifVCqq6vY8Yki2lKWPdHsMkQFsa5jr8QTOXWjUO98RZccFK9bdc
         UgT3AOpH/qVbV/OkW+PIDlXWppB1luFnQQbSXsm5rL3hlq5IR5WtHqBa+vdCWYFEvO6a
         FDeiuaXJAa/0rLzeqYHPag0gFnsxz5LfjK5CJsF/MxpCD1vDOhMFNoTNX2O6oGjkHIHM
         h9JnTpiRUORmnqllSfuO6feTPjLhOCH+edR6cKfdhi0gC4ZwBghAjkB+V1qP0ZOaaHWC
         rloIuRmT/sPGCt3dWh13rG0gu/4CuzSxGYxyWX0V82JGs9ZqbUDKODY+tMiT0G7ULE+V
         5m1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VCrnjmg62GINPJxRBMFr0Mam1wLzssanbuVrozbPcEE=;
        b=luY1R8LZp+JkiCyUmwxWSG17RhJz+CA++5xmQbMLHSi+Ojktc2XbFd6oWbT/4soP/r
         7/ojC4gXeZbaYMmQdgyj0opoHdzdkHOllF3wwmAyEEuKnAAo7pQC+WXwzhaC85rQlU+p
         xAjdvbpNDrU605bGYSvF0HMJDPpf3AgVUa/BRUx1gdniOQD6+CRiCoh6+uRZDTWoVnH9
         uuOOZ9q/E0mxBtIxx+MZCaKOCQOdRdDsU9FNt+ckjJ45NpZo5QoSY/B4KhUh6KfrYefi
         eQLnEyFX7+N01h9au4UgUyEHDTuOUnKNfDCHX1R6uR6d7oReNlcTgJGsSXflsXNMXt8V
         u7JQ==
X-Gm-Message-State: AOAM532AjI/tzo4ehcpK/yWByjTxEfYxkP5YoOHUMrTpENA6XbqLsNRO
        FU20qCa26fJO4LreVHolCm2voPnyXtu6VybZQtSdiA==
X-Google-Smtp-Source: ABdhPJyH16XTeQbj+Ng5ACHle2fNBs8VgBUnu4zQyKUVb2Jt7X/4r0kND9VMEVKsknbMDszMT76UHuWbNQI5/6H8w6M=
X-Received: by 2002:ac8:5c82:: with SMTP id r2mr10479803qta.682.1642666151600;
 Thu, 20 Jan 2022 00:09:11 -0800 (PST)
MIME-Version: 1.0
References: <20220114095529.1754065-1-dmitry.baryshkov@linaro.org> <CAHLCerM8N4nos3bguO5q6bW_JhNtxa8TyC_E-_M9UK3b78my3A@mail.gmail.com>
In-Reply-To: <CAHLCerM8N4nos3bguO5q6bW_JhNtxa8TyC_E-_M9UK3b78my3A@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 20 Jan 2022 11:09:00 +0300
Message-ID: <CAA8EJpoYRXyok7pXLCKdhpo4eamm6xw0wnjJzTy6=HkDReBT2w@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/tsens: register thermal zones as hwmon sensors
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 20 Jan 2022 at 10:12, Amit Kucheria <amitk@kernel.org> wrote:
>
> On Fri, Jan 14, 2022 at 3:25 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > Register thermal zones as hwmon sensors to let userspace read
> > temperatures using standard hwmon interface.
>
> What is the usecase for this? Simply to use existing hwmon tools to
> read temperatures of the various thermal zones?

Yes. To be able to monitor CPU temperatures using the common sensor
interface (like we do on e.g. x86).
Several other thermal drivers also register their thermal zones as
hwmon (QorIQ, Mediatek, Allwinner, Tegra30, etc).

>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/thermal/qcom/tsens.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> > index 99a8d9f3e03c..c13093e8a642 100644
> > --- a/drivers/thermal/qcom/tsens.c
> > +++ b/drivers/thermal/qcom/tsens.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/thermal.h>
> >  #include "tsens.h"
> > +#include "../thermal_hwmon.h"
> >
> >  /**
> >   * struct tsens_irq_data - IRQ status and temperature violations
> > @@ -1060,6 +1061,10 @@ static int tsens_register(struct tsens_priv *priv)
> >                 priv->sensor[i].tzd = tzd;
> >                 if (priv->ops->enable)
> >                         priv->ops->enable(priv, i);
> > +
> > +               if (devm_thermal_add_hwmon_sysfs(tzd))
> > +                       dev_warn(priv->dev,
> > +                                "Failed to add hwmon sysfs attributes\n");
> >         }
> >
> >         /* VER_0 require to set MIN and MAX THRESH
> > --
> > 2.34.1
> >



-- 
With best wishes
Dmitry
