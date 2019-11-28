Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0569110CEC4
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 20:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfK1TQi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 14:16:38 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42489 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1TQi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 14:16:38 -0500
Received: by mail-ua1-f65.google.com with SMTP id 31so8489516uas.9
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2019 11:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5wX6nC/YJw5YE+55HDTs3wT2pEfI76Dlm8jJmHMxkZM=;
        b=pcqNI9Eonn2OlLZ3h+S501B1xboLrOP+r52iUTl+U9YQFNQiXkmjdS+AmqmMhB4+du
         MCX0ESxbpXcnylEs8IBdQrYbzMWshiI2LmoKiAGMmUDYzClG3E+xI6ltgklBGQcStpWY
         xX0rJWB8NiRv8PeMcfAipKqswWPPzY3CCb3UQ0y3zui86YFMj0sxrXLn/dn1oGygTgib
         fAWW+DNXwv/cDwXdJOqaEtOTjCrdCIwliyPtkGqgFUQ2httAilWkyEzMK5KJS0q/Zwnu
         fyjOWUHUQviz/F6VvOlBLm00v7XW7TjGRcW6VBBs1n9MSM6xdBFknrhx0GOqvLONfT9+
         hU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wX6nC/YJw5YE+55HDTs3wT2pEfI76Dlm8jJmHMxkZM=;
        b=QtSSeFnpus1siaDsYc9yiK1jE/35yd9uBO3I3YzhTNTH2XcUoeOvJffaJt8+xy0Dh7
         liFvdyUWgulHWggKlNKoun1zSmELxCrE8/4NFGogtGyibskJT+NHWhejhCipY07VaqXw
         O9Q5P8hk3bzCTLsMcVQKFoxUmlEbl6atoyfVdpJLiITx5Tcu6ouaCEB+8TNQ1qjokkPz
         2/7+zeVmaInfksO4VkdTCr3inv/8QHJXb3x98OrxBa9RSyvQzIbGeOfE/LtIeSU1wleX
         VIJbVFvjnmADnycGtzHKX62ZnKWFxxfhj7nLTCAvsjYnxMYAaK+m7kRvi1Q+uVfsOrRl
         gz/w==
X-Gm-Message-State: APjAAAX57sOaCt3DG8WzXoX427govvrqp8CKCTENXIMuBtA5Fr8qHjly
        x66nIl1asdG/sTFlK9TyOoJR1kOIwiUPLbITEaujrg==
X-Google-Smtp-Source: APXvYqzLOzPzCzbLNz+cpCN8k1sRhGK9V2X4moK5B38d2PlC7WkrZJzucE21bHM/SQsOiI+wL0lLNIT72YRPGUgHYSc=
X-Received: by 2002:ab0:7684:: with SMTP id v4mr7274678uaq.94.1574968597182;
 Thu, 28 Nov 2019 11:16:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573499020.git.amit.kucheria@linaro.org>
 <c08cf285b8696c4fd00706b85cd3c88d12f97df3.1573499020.git.amit.kucheria@linaro.org>
 <5dcdd754.1c69fb81.27caf.7022@mx.google.com>
In-Reply-To: <5dcdd754.1c69fb81.27caf.7022@mx.google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 29 Nov 2019 00:46:26 +0530
Message-ID: <CAHLCerN1n7c76MicKWCWE8aSpxrwrMEuN1mAtPwXykFWi2vEuQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] drivers: thermal: tsens: Add watchdog support
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sivaa@codeaurora.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 15, 2019 at 4:08 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Amit Kucheria (2019-11-11 11:21:28)
> > TSENS IP v2.3 onwards adds support for a watchdog to detect if the TSENS
> > HW FSM is frozen. Add support to detect and restart the FSM in the
>
> Maybe 'frozen' is an ambiguous term? Maybe 'stuck' or 'has stopped
> making progress'?

Alright, let's keep Disney out of this. Will use 'stuck'.

> > driver. The watchdog is configured by the bootloader, we just enable the
> > feature in the kernel.
>
> Does it work to enable it if we don't configure it in the bootloader?

TBH, I don't know. Getting modified firmware to test this will be a
bit of a challenge.

> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/thermal/qcom/tsens-common.c | 41 +++++++++++++++++++++++++++++
> >  drivers/thermal/qcom/tsens-v2.c     | 10 +++++++
> >  drivers/thermal/qcom/tsens.h        | 12 +++++++++
> >  3 files changed, 63 insertions(+)
> >
> > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > index 2989cb952cdb..9432518502a7 100644
> > --- a/drivers/thermal/qcom/tsens-common.c
> > +++ b/drivers/thermal/qcom/tsens-common.c
> > @@ -794,6 +820,21 @@ int __init init_common(struct tsens_priv *priv)
> >                 }
> >         }
> >
> > +       if (tsens_version(priv) > VER_1_X &&  ver_minor > 2) {
> > +               /* Watchdog is present only on v2.3+ */
> > +               for (i = 0, j = WDOG_BARK_STATUS; j <= CC_MON_MASK; i++, j++) {
>
> The variable 'i' is not actually used in this loop. What's going on?

Sorry, left over from a botched copy-paste job from the loop above
this. Will fix.

>
> > +                       priv->rf[j] = devm_regmap_field_alloc(dev, priv->tm_map,
> > +                                                             priv->fields[j]);
> > +                       if (IS_ERR(priv->rf[j])) {
> > +                               ret = PTR_ERR(priv->rf[j]);
> > +                               goto err_put_device;
> > +                       }
> > +               }
> > +               /* Enable WDOG and disable cycle completion monitoring */
> > +               regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
> > +               regmap_field_write(priv->rf[CC_MON_MASK], 1);
> > +       }
