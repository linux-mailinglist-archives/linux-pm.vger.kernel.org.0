Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4678B9975
	for <lists+linux-pm@lfdr.de>; Sat, 21 Sep 2019 00:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbfITWDu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Sep 2019 18:03:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32954 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfITWDt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Sep 2019 18:03:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so5446576pfl.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2019 15:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=/EQwbpIsvd1cytDYn0HntBTy9k3TGtcIL0KkXrfCaiQ=;
        b=YDPl0GG4EI8wJoWxtR1nfBaelslT8/kTPV7iNWiqqjHZFPISQDIQWQD016P911qdJQ
         aibMH+xB7INC43BG0DInOi9+0rmKL4zekRRgR+Jc/n8EqKcu9d8kiSxm7tYnV3EuqysS
         6xevhW6w/zrCEkrmond8+1jcLyEjxrtllbKg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=/EQwbpIsvd1cytDYn0HntBTy9k3TGtcIL0KkXrfCaiQ=;
        b=gCrB82Cw0XQQjCJL5wWpM3NKEGk4lYz18q0q8pO7T0BcgFh2WJJgsX7/m15kN6zrK/
         yyiscASXWV5M/SC/RTdc414zyA2Q+l7EY6nrCMo0v6nHue5kmyIZ9VApR4yJLR635PW+
         LHHtM8qNQ105Fpwk2E95NsDPgcCa3tjJU0X27BIhEyId7n8o07fNyy9eRTn+W7KFZ1XS
         dkblkxAhiVlwGndBC5Sj04XC21MtJEV7PGid3IsSYUjifOa5VXGfIcK1blrjz7lEhnu/
         PAIdKwVnvbFMtm4AK4YnnekY7Sx3cmbOcDry7SWJX5rjbqv6y1Yl3k1Id2DgbdHwL3DD
         DFvg==
X-Gm-Message-State: APjAAAWbTdV8BQlRVKBq5YMTPyAvDbJ2xfWLAcs+3igiOxEZ533ibMDq
        qiLLgJ24WMsP9qvWCfIzsncSl7la9VM=
X-Google-Smtp-Source: APXvYqyBgz+MphNZfB4Kvgk3Xd1zPioLjL8mQsK1TqROI5tdB+AxFL4uyLGMg25Kl2Cgn2fDtdeeHA==
X-Received: by 2002:a17:90a:8c89:: with SMTP id b9mr7128649pjo.45.1569017027567;
        Fri, 20 Sep 2019 15:03:47 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z2sm4706797pfq.58.2019.09.20.15.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 15:03:47 -0700 (PDT)
Message-ID: <5d854cc3.1c69fb81.4264c.bab8@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aa318f9ba4aa3fd13b05201743acc1ab2c1a0db1.1569015835.git.amit.kucheria@linaro.org>
References: <cover.1569015835.git.amit.kucheria@linaro.org> <aa318f9ba4aa3fd13b05201743acc1ab2c1a0db1.1569015835.git.amit.kucheria@linaro.org>
Cc:     linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        masneyb@onstation.org
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v4 14/15] drivers: thermal: tsens: Create function to return sign-extended temperature
User-Agent: alot/0.8.1
Date:   Fri, 20 Sep 2019 15:03:46 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Amit Kucheria (2019-09-20 14:52:29)
> Hide the details of how to convert values read from TSENS HW to mCelsius
> behind a function. All versions of the IP can be supported as a result.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Just one nit below.

>  drivers/thermal/qcom/tsens-common.c | 50 +++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/t=
sens-common.c
> index ea2c46cc6a66..6b6b3841c2d0 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -310,6 +331,7 @@ int __init init_common(struct tsens_priv *priv)
>                         goto err_put_device;
>                 }
>         }
> +
>         for (i =3D 0, j =3D VALID_0; i < priv->feat->max_sensors; i++, j+=
+) {
>                 priv->rf[j] =3D devm_regmap_field_alloc(dev, priv->tm_map,
>                                                       priv->fields[j]);

Drop this hunk?

