Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B3B2BC8C5
	for <lists+linux-pm@lfdr.de>; Sun, 22 Nov 2020 20:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgKVTfZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Nov 2020 14:35:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:57238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727425AbgKVTfZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 22 Nov 2020 14:35:25 -0500
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67CDE20776
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2020 19:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606073724;
        bh=wiUe1+Lsy/9M5RMEJjLWC4PBH0ZPqRMFo8QKQIqJXKk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HEw6m2ZGhVVKdI0PFbm2Ba9r323Dtx3T8uxslrdzAS/B4qj9jLrrpHoF7suuCLwLB
         L/Tf5GDFGNW1K7614cDeTehcTzbwsJyAecAFBap1TmdRwfsvNWSsYUh5a+5MCjeCZ7
         exvkYnevkFRTY7E0n9+ZBp4shKBTaNJH5FizdXuI=
Received: by mail-vk1-f173.google.com with SMTP id e127so1028964vkb.5
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2020 11:35:24 -0800 (PST)
X-Gm-Message-State: AOAM532DKE1k+LjaZ+LLjdlZgE3ay0aiAOhnKd7iHEPHMSFQ29L0mcv3
        oHsZgedXmZ+Md/J12aw736TwpR3dcxlYuPlx5j09AQ==
X-Google-Smtp-Source: ABdhPJz6GEA+NJVOn7wX+dQLLdkTSQgDfCljjld+OKOyV1AD4oN3AUkoEhET5zzrCfH4xWn/XhBEuyP6jaO2ooxsSsY=
X-Received: by 2002:a1f:9d04:: with SMTP id g4mr18940966vke.10.1606073723553;
 Sun, 22 Nov 2020 11:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20200814134123.14566-1-ansuelsmth@gmail.com> <20200814134123.14566-2-ansuelsmth@gmail.com>
In-Reply-To: <20200814134123.14566-2-ansuelsmth@gmail.com>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Mon, 23 Nov 2020 01:05:12 +0530
X-Gmail-Original-Message-ID: <CAHLCerPUi-wHo5WTJZZCKS3hmOTs9e+uixudDSRG4jMFukSZeg@mail.gmail.com>
Message-ID: <CAHLCerPUi-wHo5WTJZZCKS3hmOTs9e+uixudDSRG4jMFukSZeg@mail.gmail.com>
Subject: Re: [RFC PATCH v6 1/8] drivers: thermal: tsens: use get_temp for tsens_valid
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ansuel,

My apologies for being tardy in reviewing this series. Career changes...

On Fri, Aug 14, 2020 at 7:12 PM Ansuel Smith <ansuelsmth@gmail.com> wrote:
>
> Use the driver get_temp function instead of force to use the generic get
> temp function. This is needed as tsens v0 version use a custom function
> to get the real temperature.
>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/thermal/qcom/tsens.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 9af6f71ab640..9fe9a2b26705 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -580,7 +580,6 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
>  {
>         struct tsens_priv *priv = s->priv;
>         int hw_id = s->hw_id;
> -       u32 temp_idx = LAST_TEMP_0 + hw_id;
>         u32 valid_idx = VALID_0 + hw_id;
>         u32 valid;
>         int ret;
> @@ -600,9 +599,9 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
>         }
>
>         /* Valid bit is set, OK to read the temperature */
> -       *temp = tsens_hw_to_mC(s, temp_idx);
> +       ret = priv->ops->get_temp(s, temp);

This is wrong.

.get_temp is set to get_temp_tsens_valid() for v1 and v2 platforms. So
you've just broken all those platforms by creating a recursive loop.

I assume you were trying to use the common interrupt code which
currently uses get_temp_tsens_valid()? I suggest trying to add 8960
support to tsens_hw_to_mC().

>
> -       return 0;
> +       return ret;
>  }
>
>  int get_temp_common(const struct tsens_sensor *s, int *temp)
> --
> 2.27.0
>
