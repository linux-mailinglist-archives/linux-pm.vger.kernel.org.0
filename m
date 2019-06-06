Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4572837689
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 16:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfFFOY5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 10:24:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33020 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfFFOY5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jun 2019 10:24:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id h17so1476633pgv.0;
        Thu, 06 Jun 2019 07:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LQYAX0Ik20hq3rHNgG5ZoN3VJukEDz/h1qNn+gur0Yc=;
        b=F0Urs0vjcvUPDMVH3ss6E1lfrrwePnXPxS8VxAk0ZhxTaiOp2GopcOz+9v2JPv28Iw
         +50FxoFHRhkOJr+V3RH5kiVJfd12zbyz6nfYplWizlqtM9WRo9SICFXhlYSa7JwJDdhV
         yS/wDnHjjQIVg0EqcEwJJ/L04dpSBEj2S44oYVJCZjS41P2Ui2h/sq+LxHz8vYotig+7
         T1u26tOcmZu2XrzhQA7HSZESCustX+qkH9JVBclpOby1ERexv1I3xqHoCUe0DM//sP4F
         xcrupJrBV0oNaihnsK5ieWESk2BJaiFBmSfxzRhczFMz1mfmiOY5GyzmxUmnWPbqSM9X
         re1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LQYAX0Ik20hq3rHNgG5ZoN3VJukEDz/h1qNn+gur0Yc=;
        b=TpDnqc7LHB/+VFYWYsFsDv5U+PDRRgod26Kv2jkuaEDN6naxSG733VNBQjjUqgiQcq
         uBA5pzuIQKDkqKV37BkRxw7PXmXu9zjD+pLyZF7WQ0wPROIK4y/BZJ2rFe5Q6EvHNMVy
         dpt3OeLTr3N9C2gxjGPdidiRuo9bHAWJI52SKwGpdTwXpklFO8ouCWz084hVbwLKU76k
         wVfTRw0CvRs/L652LI2joh5nZ/9ig9d4N/xe9wDkj1nq4yNbZVSxq81f2JZrPv/wP91c
         w9IEArT5uGezjkZCTEq5qu8AzSTYT0Uadfi67a+DSCNP2wbLWEKz+eL6dbB0iNnqeIVC
         nE4w==
X-Gm-Message-State: APjAAAVTSrPJulkMzDaAyKzTCL+Apcf+2DRZBkrjj5443/zodLJ9rQN1
        JpJ3yUbYRHMCW25ljY/Fm1U=
X-Google-Smtp-Source: APXvYqxNWKZP/TTBjt3l/KT4pko8KyN1r7pV04OfzznlgsWnlokhYtmWgnbnadbK+gXJWYrmQ5quAQ==
X-Received: by 2002:a17:90a:290b:: with SMTP id g11mr161148pjd.122.1559831096095;
        Thu, 06 Jun 2019 07:24:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id f11sm2884243pjg.1.2019.06.06.07.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 07:24:55 -0700 (PDT)
Date:   Thu, 6 Jun 2019 07:24:53 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drivers: thermal: tsens: remove redundant u32
 comparison with less than zero
Message-ID: <20190606142450.GA7846@localhost.localdomain>
References: <20190531105708.15312-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190531105708.15312-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

hey Colin,

On Fri, May 31, 2019 at 11:57:08AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The u32 variable hw_id is unsigned and cannot be less than zero so
> the comparison with less than zero is always false and hence is redundant
> and can be removed.
>=20
> Addresses-Coverity: ("Unsigned compared against 0")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks for the patch but the commit that introduced this has been
reverted. I pushed an update on my -next branch to silence this in the
linux-next tree too.

> ---
>  drivers/thermal/qcom/tsens-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/t=
sens-common.c
> index 928e8e81ba69..f4419f45025d 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -69,7 +69,7 @@ bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_=
id)
>  	u32 val;
>  	int ret;
> =20
> -	if ((hw_id > (priv->num_sensors - 1)) || (hw_id < 0))
> +	if (hw_id > (priv->num_sensors - 1))
>  		return -EINVAL;
>  	ret =3D regmap_field_read(priv->rf[SENSOR_EN], &val);
>  	if (ret)
