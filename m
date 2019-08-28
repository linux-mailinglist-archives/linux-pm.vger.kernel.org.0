Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E70659F777
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 02:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfH1AiX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 20:38:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41994 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfH1AiW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2019 20:38:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id i30so472124pfk.9
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2019 17:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=utsYMkwVoSizITt4YbHTUmv+k4tk0KmV+gl/onKzAqI=;
        b=NQEo+F/7u1jPySypwH1kvFEus3KZN8bDS/Wj78hgYCrtY4078b1Usou7aFhsp9JzCN
         XczJCXkENBrVdJ6vV91vo4pyAQ6tQsug0j2bPvbQ0Zwc5N3BUgSP9XQX+ilHbURst6AQ
         ED88l7MZ/BdHBUoWDMO7oMRijRPlyziURt6nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=utsYMkwVoSizITt4YbHTUmv+k4tk0KmV+gl/onKzAqI=;
        b=VlZjKo6mLl0LU9miG5txyMPto9TawavIol33t7VxeciRYkJMO2k8zQXQoydvaTKB5K
         fVjQn/jlr5LhLTNRveqoAf26yecB8QrZv+W5yEhVRsccmAaZqlY0/hBz33SyhGvdXmLl
         zBgPNlwQhOykrqJhrcAlV6nDf0bCpWwYJHhXgmU4M6XOTvNkuQQRZGZOu/ZizxggHHkB
         r8bb4Q1X9fDs/Pv1te2Hjj6nkAJmN+K8ko8wqYPZMIvfYdI10BTR7ezwLCALbCN/PniZ
         LpEXHCUXAqzVklk5koYNapglSaXELs1AIna9IOKuZeW7DJJXUt42G4ApnW0rKhblgGeL
         iGHw==
X-Gm-Message-State: APjAAAXdxSB4mR5lmPKepycoWAVh/Z/ejQZFoeqxCbZ1DSCZ3TziiDC7
        jZmCHmdf1aP3QrSuc/oy3yAVgZ1QfOhC1A==
X-Google-Smtp-Source: APXvYqzuuRjLT7jMd+lRTGZeGQ8r+Oitk7DUPIH/k1da4g5htcxsWSidsOCp4Q3zP5gzZo7VtEbwGA==
X-Received: by 2002:a17:90a:6d43:: with SMTP id z61mr1556131pjj.32.1566952701873;
        Tue, 27 Aug 2019 17:38:21 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j1sm463965pgl.12.2019.08.27.17.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 17:38:21 -0700 (PDT)
Message-ID: <5d65ccfd.1c69fb81.95798.20d8@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <64a3d07ebe5c4cfb4643d91f5f6605e8a4ffa48b.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org> <64a3d07ebe5c4cfb4643d91f5f6605e8a4ffa48b.1566907161.git.amit.kucheria@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 14/15] drivers: thermal: tsens: Create function to return sign-extended temperature
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.w.gonzalez@free.fr, masneyb@onstation.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 27 Aug 2019 17:38:20 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Amit Kucheria (2019-08-27 05:14:10)
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/t=
sens-common.c
> index ea2c46cc6a66a..06b44cfd5eab9 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -84,13 +84,43 @@ static inline int code_to_degc(u32 adc_code, const st=
ruct tsens_sensor *s)
>         return degc;
>  }
> =20
> +/**
> + * tsens_hw_to_mC - Return sign-extended temperature in mCelsius.
> + * @s:     Pointer to sensor struct

sensor? This isn't golang!

> + * @field: Index into regmap_field array pointing to temperature data
> + *
> + * This function handles temperature returned in ADC code or deciCelsius
> + * depending on IP version.
> + *
> + * Return: Temperature in milliCelsius on success, a negative errno will
> + * be returned in error cases
> + */
> +static int tsens_hw_to_mC(struct tsens_sensor *s, int field)
> +{
> +       struct tsens_priv *priv =3D s->priv;
> +       u32 temp =3D 0;
> +       int ret;
> +
> +       ret =3D regmap_field_read(priv->rf[field], &temp);
> +       if (ret)
> +               return ret;
> +
> +       if (priv->feat->adc) {
> +               /* Convert temperature from ADC code to milliCelsius */

Nitpick: Move this comment above the if and drop the braces.

> +               return code_to_degc(temp, s) * 1000;
> +       }
> +
> +       /* deciCelsius -> milliCelsius along with sign extension */
> +       return sign_extend32(temp, priv->tempres) * 100;
> +}
> +
>  int get_temp_tsens_valid(struct tsens_sensor *s, int *temp)
>  {
>         struct tsens_priv *priv =3D s->priv;
>         int hw_id =3D s->hw_id;
>         u32 temp_idx =3D LAST_TEMP_0 + hw_id;
>         u32 valid_idx =3D VALID_0 + hw_id;
> -       u32 last_temp =3D 0, valid, mask;
> +       u32 valid;
>         int ret;
> =20
>         ret =3D regmap_field_read(priv->rf[valid_idx], &valid);
> @@ -310,6 +328,10 @@ int __init init_common(struct tsens_priv *priv)
>                         goto err_put_device;
>                 }
>         }
> +
> +       /* Save away resolution of signed temperature value for this IP */
> +       priv->tempres =3D priv->fields[LAST_TEMP_0].msb - priv->fields[LA=
ST_TEMP_0].lsb;
> +

Why not just calculate this in the function that uses it? Is there a
reason to stash it away in the struct?

>         for (i =3D 0, j =3D VALID_0; i < priv->feat->max_sensors; i++, j+=
+) {
>                 priv->rf[j] =3D devm_regmap_field_alloc(dev, priv->tm_map,
>                                                       priv->fields[j]);
