Return-Path: <linux-pm+bounces-4999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2F387DB64
	for <lists+linux-pm@lfdr.de>; Sat, 16 Mar 2024 21:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE7B1F21801
	for <lists+linux-pm@lfdr.de>; Sat, 16 Mar 2024 20:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2C11B963;
	Sat, 16 Mar 2024 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oey36Myn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A05E1BF5C
	for <linux-pm@vger.kernel.org>; Sat, 16 Mar 2024 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710619692; cv=none; b=JQVnQRClaUdogwEV5CXqesfkj2uCBe7+o1hOvI8i4l0ABQWZ3AaSFmpsDyfGhNWgrr32T5b2n26fTOR4SwNJHtioCtkFVZPQHaFGnSJlPkxzqpEIsVTTjTbaMynI5uXePBzkWBKEgxKYoCCjARo2JJ1OXxbp0uthJUNKcZRHjww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710619692; c=relaxed/simple;
	bh=U1gMh+s+a7WJQ50TlopQKqfh4iRR1YUGrowPcQJVT98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHZubvbNMOoNA1avtSE4EPipvqeV3/OE4hrJa7q7H5DFYnenEB1oI3byFx9EwY8gf18L/d8TK19wisP6ARxBXdAq+5RQ6XcXobreBJnlnDAPP3q4/Pp4s70kcWGW6cU4nlEBxI2QrPoa0OTm4g9/dTSKzfFfz/8k/12V0ZZKLF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oey36Myn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78DDC43390
	for <linux-pm@vger.kernel.org>; Sat, 16 Mar 2024 20:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710619691;
	bh=U1gMh+s+a7WJQ50TlopQKqfh4iRR1YUGrowPcQJVT98=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oey36MynIWq6K1t0yYgVXAbCBwwoAjIM53Vlc06ky0HyIvf3/Ddrfmwlb04OpUyNu
	 DvbfAHDkw8bqx/cnrZk21zaV2ug4RV6IACDGbtIAE046EcihW7A9vos6JSiqZ/BuHH
	 0lJNWH25Uq4kVC1hAPIXGZXYQyoWeEJtNMEoKvnK7Yt+9mM1fo76p0s1hhjXqhmOaL
	 okZbfEdrBuNuvfZYPNDNR3kHILIAixVqeB6I6CjeS5yqsNOgGmrw7rPH5LSKBCxygH
	 T7oPDhQVPXosCm7T9aSx8qaY06GBI9+sAFjdRHBe2Z7yPk79iP1Ij8+tgnmln3YJD/
	 KkqhNse/v+I6Q==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a466a27d30aso412255266b.1
        for <linux-pm@vger.kernel.org>; Sat, 16 Mar 2024 13:08:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0ZJHpCyq8s7cdegEF9n9QXHXXAywyTg9B9s1NEtcj8nofmV3Iu6KMAn9WtG2f18Ux8xaA/HYCGbW9R1T3gjlSblPIPm9BLx4=
X-Gm-Message-State: AOJu0YxU63TfIStTU7Sfi6i2EprTr/sUgq7xiZjQEIsdnQOaQtBsc6y6
	pV+ieHddHy45P8JdVmkwun8s7D931D3MKe1ijZS4k1wI4j0Sfc+AwMEu95Gnqz4UqNIdU4k0AHA
	HrkKeVKjTfwyYAnvbG0CnRF66VAzn+C8NbkjU/g==
X-Google-Smtp-Source: AGHT+IFSfMUwxOtll9dxMiGj6hSds8Nzq39+yhJMmOycFs9JN1BVr+RjJUEDs9GFIDRdqXd/S1tEfHo8p6Jpw3fDQaE=
X-Received: by 2002:a17:907:60ca:b0:a44:5477:bb46 with SMTP id
 hv10-20020a17090760ca00b00a445477bb46mr7125461ejc.61.1710619690358; Sat, 16
 Mar 2024 13:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227160928.2671-1-quic_priyjain@quicinc.com>
In-Reply-To: <20240227160928.2671-1-quic_priyjain@quicinc.com>
From: Amit Kucheria <amitk@kernel.org>
Date: Sun, 17 Mar 2024 01:37:58 +0530
X-Gmail-Original-Message-ID: <CAHLCerModb=01WX=q6XU0XO8dr5EaSQ5RaBoFLFc_=vpOGAgaw@mail.gmail.com>
Message-ID: <CAHLCerModb=01WX=q6XU0XO8dr5EaSQ5RaBoFLFc_=vpOGAgaw@mail.gmail.com>
Subject: Re: [PATCH v3] thermal/drivers/tsens: Add suspend to RAM support for tsens
To: Priyansh Jain <quic_priyjain@quicinc.com>
Cc: Thara Gopinath <thara.gopinath@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_manafm@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 9:40=E2=80=AFPM Priyansh Jain <quic_priyjain@quicin=
c.com> wrote:
>
> As part of suspend to RAM, tsens hardware will be turned off.
> While resume callback, re-initialize tsens hardware.
>
> Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
> ---
> V2 -> V3: Remove suspend callback & interrupt enablement part from
> resume callback.
> V1 -> V2: Update commit text to explain the necessity of this patch
>
>  drivers/thermal/qcom/tsens-v2.c |  1 +
>  drivers/thermal/qcom/tsens.c    | 40 +++++++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens.h    |  6 +++++
>  3 files changed, 47 insertions(+)
>
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens=
-v2.c
> index 29a61d2d6ca3..0cb7301eca6e 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -107,6 +107,7 @@ static const struct reg_field tsens_v2_regfields[MAX_=
REGFIELDS] =3D {
>  static const struct tsens_ops ops_generic_v2 =3D {
>         .init           =3D init_common,
>         .get_temp       =3D get_temp_tsens_valid,
> +       .resume         =3D tsens_resume_common,
>  };

Please add resume callbacks for the other tsens hardware too and make
sure that your reinit function handles them too.

>
>  struct tsens_plat_data data_tsens_v2 =3D {
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 6d7c16ccb44d..396c1cd71351 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -17,6 +17,7 @@
>  #include <linux/pm.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/suspend.h>
>  #include <linux/thermal.h>
>  #include "../thermal_hwmon.h"
>  #include "tsens.h"
> @@ -1193,6 +1194,45 @@ static int tsens_register_irq(struct tsens_priv *p=
riv, char *irqname,
>         return ret;
>  }
>
> +#ifdef CONFIG_SUSPEND
> +static int tsens_reinit(struct tsens_priv *priv)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&priv->ul_lock, flags);
> +
> +       /* in VER_0 TSENS need to be explicitly enabled */
> +       if (tsens_version(priv) =3D=3D VER_0)
> +               regmap_field_write(priv->rf[TSENS_EN], 1);
> +
> +       /*
> +        * Re-enable the watchdog, unmask the bark.
> +        * Disable cycle completion monitoring
> +        */
> +       if (priv->feat->has_watchdog) {
> +               regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
> +               regmap_field_write(priv->rf[CC_MON_MASK], 1);
> +       }
> +
> +       /* Re-enable interrupts */
> +       if (tsens_version(priv) >=3D VER_0_1)
> +               tsens_enable_irq(priv);
> +
> +       spin_unlock_irqrestore(&priv->ul_lock, flags);
> +
> +       return 0;
> +}
> +
> +int tsens_resume_common(struct tsens_priv *priv)
> +{
> +       if (pm_suspend_target_state =3D=3D PM_SUSPEND_MEM)
> +               tsens_reinit(priv);
> +
> +       return 0;
> +}
> +
> +#endif /* !CONFIG_SUSPEND */
> +
>  static int tsens_register(struct tsens_priv *priv)
>  {
>         int i, ret;
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index cb637fa289ca..7a147d9d8544 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -635,6 +635,12 @@ int init_common(struct tsens_priv *priv);
>  int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
>  int get_temp_common(const struct tsens_sensor *s, int *temp);
>
> +#ifdef CONFIG_SUSPEND
> +int tsens_resume_common(struct tsens_priv *priv);
> +#else
> +#define tsens_resume_common            NULL
> +#endif
> +
>  /* TSENS target */
>  extern struct tsens_plat_data data_8960;
>
> --
> 2.17.1
>

