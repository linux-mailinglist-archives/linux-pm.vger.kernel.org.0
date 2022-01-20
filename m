Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDC0494C0C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jan 2022 11:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376481AbiATKuf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jan 2022 05:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiATKqy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jan 2022 05:46:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8746C061574
        for <linux-pm@vger.kernel.org>; Thu, 20 Jan 2022 02:46:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3801C61519
        for <linux-pm@vger.kernel.org>; Thu, 20 Jan 2022 10:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979EEC36AE7
        for <linux-pm@vger.kernel.org>; Thu, 20 Jan 2022 10:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642675612;
        bh=k+uQQQF7GQAwh9UXBPTIV58+RXFCR7Pd2Rz5cvZglN4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uPp0e8zapeU+w6K2MlVMA+YysP/dabxvXISTGCXtgxNTb/koXAF/FRfWvFOGAkKKG
         jKjhqTLxU5wAL0g6IaaFqHgewabyt/8yxAhePV+hKSh3ba8ymnqjIYfRvzcvipVFBJ
         plsi4FeXJNaGjaKYDFYDCm1qo7n2jBWL5Jlqq8cNLzwoWl9kIwajIpe9ZDuBDAxH2r
         iuKeoYLX5i0Mo3YMqbNBeMP8feKun39YZPpPG11Yww7J65CW1GNmYsHa9zdlgWse9u
         RVffbV/a2yRNEioBNtepigXjQHo61Eeq5FtaK6b5zSrLFuc36JRWNw96YBEJlfLUOZ
         QCu0UbDXYKxOw==
Received: by mail-lf1-f49.google.com with SMTP id bu18so20019925lfb.5
        for <linux-pm@vger.kernel.org>; Thu, 20 Jan 2022 02:46:52 -0800 (PST)
X-Gm-Message-State: AOAM5329sW7vu+TA37Yzjfa4uVfyhJGKzZ2Fd8kEmevNVooHQR4WL6Qd
        c2ZurQZrPGZCTpUYqlh4lODYq60aYKgxYad3wCMFTw==
X-Google-Smtp-Source: ABdhPJxHdz1sSl6DZamoq/5yN4GrTCEPRNTOuwn+s5//0QZBhQs+EYn7MaYBJxodo/VLzLE3tdxyE6IZ171L2SljYfY=
X-Received: by 2002:a2e:904e:: with SMTP id n14mr29339084ljg.28.1642675610651;
 Thu, 20 Jan 2022 02:46:50 -0800 (PST)
MIME-Version: 1.0
References: <20220114095529.1754065-1-dmitry.baryshkov@linaro.org>
In-Reply-To: <20220114095529.1754065-1-dmitry.baryshkov@linaro.org>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Thu, 20 Jan 2022 16:16:39 +0530
X-Gmail-Original-Message-ID: <CAHLCerOJQ_rf+dz8BE9YqK_X7YfJMO9VoEVXedkrkRrn1Ef8+w@mail.gmail.com>
Message-ID: <CAHLCerOJQ_rf+dz8BE9YqK_X7YfJMO9VoEVXedkrkRrn1Ef8+w@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/tsens: register thermal zones as hwmon sensors
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
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

On Fri, Jan 14, 2022 at 3:25 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Register thermal zones as hwmon sensors to let userspace read
> temperatures using standard hwmon interface.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/thermal/qcom/tsens.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 99a8d9f3e03c..c13093e8a642 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -19,6 +19,7 @@
>  #include <linux/slab.h>
>  #include <linux/thermal.h>
>  #include "tsens.h"
> +#include "../thermal_hwmon.h"

Just a nit, but can you move this above the tsen.h along with other
system headers?

With that, feel free to add

Acked-by: Amit Kucheria <amitk@kernel.org>

>
>  /**
>   * struct tsens_irq_data - IRQ status and temperature violations
> @@ -1060,6 +1061,10 @@ static int tsens_register(struct tsens_priv *priv)
>                 priv->sensor[i].tzd = tzd;
>                 if (priv->ops->enable)
>                         priv->ops->enable(priv, i);
> +
> +               if (devm_thermal_add_hwmon_sysfs(tzd))
> +                       dev_warn(priv->dev,
> +                                "Failed to add hwmon sysfs attributes\n");
>         }
>
>         /* VER_0 require to set MIN and MAX THRESH
> --
> 2.34.1
>
