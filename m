Return-Path: <linux-pm+bounces-2471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB138364CA
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 14:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05841C22050
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 13:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45689DF6E;
	Mon, 22 Jan 2024 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vXDk7cOA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959273D0A9
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931705; cv=none; b=YcEAo/WigGE7/fjUzTVCQKSsBJyYFhgwbXrjyuiqNO5ilKjKfZVhTbomN1nxU6ddG17eT/GbG7+HWdV5+M2X71p/7ogCOtg14jG7aFM/kxKhbd8kCbS7/2/zbt4AVYVcvzKl3EFcW8CGxHg7tIttb6N3EdtsmZ5BfkwAxpPN4dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931705; c=relaxed/simple;
	bh=1RY42wUJ5DilToY52o14SzpTE782BXJr7ZzfgzVy/8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPL4afduXxeLZjBcI8bJQQ+4a7X+geix4iy4GTKdmZ6ggxEq/F5qyWBX/mUmltqcsRlPzlOB5SVW5/ehxnFuql4986KEB4saTkkihVaKSLdD5LUkjGTTcgj/VOg96DuuAC05C3JsGPlAWeaxnN77YtEXYboRLfCQKgEMItsGsIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vXDk7cOA; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5f0629e67f4so31004307b3.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 05:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705931702; x=1706536502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iGOilTuqjcw1mr5eXBiSM5JbzofFFnc7w3m0lwVL+c8=;
        b=vXDk7cOAK/oxr4A9XouWKVqxeNKSpaCmhbZgukg13AlfEJqfH8v787o0CNX8oC8l2l
         m1aukb7QFC0/qvi30n33MhoXxeUDnihW/wD1s02ZSyY6byl7xJJGjMBkH+AZ1ywp9FTL
         b14a3VyiW2zJJvZDtYzXuTp5OdqHDAPJDgTSuEX2Erubgq54n4oYNzmvASFLJYEQBTVI
         EF5GY9B47jYNvuOe0X1h+Zt5oJY4POSajcgQhFvBO7jSRrGZyQdLejvLItcA+voJh6tn
         NRL1aICinzohoqMtqI0e45/rSx4R4HYwI8TejilxId+maLUJ2dn/CIK8B1o8fcGDkWm+
         k7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705931702; x=1706536502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iGOilTuqjcw1mr5eXBiSM5JbzofFFnc7w3m0lwVL+c8=;
        b=D7uzg1Hw9Ff1WnhPuF/RrB33e4GxXyD9+r6AgFSU2ZAyRthCS6BvKLyqO0/HSZfDuZ
         Cis1WEXQ+LfkpkdcE7tubwzF/w098OyVb4mV8byGeqVNl/YI5aKwYfxDxhQ82EnHCcJl
         PsMyfnHbvUAG86OZBP67Y+M3qAhfdZLk/Eo5Om+ZAzH8hG3s1MQlqMSzA84+VizgdANF
         aP5pCpeC9dkYw9ZyPGCEawBcjz61lDf/s19oZuneZY5ZpXEwVnKge33BKZ9TvncoQ0Rl
         ssU5b94iHydiyBHQ4kwZ6cfrDFEfZ+DZlu8dmhdGEPHH8RcGUcvVKbuUym2fFR5CQU6+
         vZrw==
X-Gm-Message-State: AOJu0Yzzg5BGG+QIu1QBHhzqTskIAGYc4nFFtEJHVVmkcQUipnz/6RMm
	7SB0M0a9FhHfC189AGEwQMSxKCZ9XuUeu2sAiLydljtVFYM8MUHqtc0/hmQJaUfQiC9JZ3KR30j
	uMONGIMPg8UYfkN6c4mM2xMHVaHMXlqU6DgaN0Q==
X-Google-Smtp-Source: AGHT+IFa+LfGhrioiCJkuC7X+UFYDQskRS/0P+B4O30wfVtk2DnNiP57dGmVt7wK2/Cm1SiBp4WEPLxpF0n+246UYv0=
X-Received: by 2002:a81:5344:0:b0:5f5:9898:ca3a with SMTP id
 h65-20020a815344000000b005f59898ca3amr3442278ywb.87.1705931702590; Mon, 22
 Jan 2024 05:55:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122100726.16993-1-quic_priyjain@quicinc.com>
In-Reply-To: <20240122100726.16993-1-quic_priyjain@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 22 Jan 2024 15:54:51 +0200
Message-ID: <CAA8EJprUmw-Q1aXUrP-T1dtJE-UUmqgb3RY7_+J4fetJKk11+Q@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/tsens: Add suspend to RAM support for tsens
To: Priyansh Jain <quic_priyjain@quicinc.com>
Cc: Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_manafm@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 12:11, Priyansh Jain <quic_priyjain@quicinc.com> wrote:
>
> Add suspend callback support for tsens which disables tsens interrupts
> in suspend to RAM callback.
> Add resume callback support for tsens which reinitializes tsens hardware
> and enables back tsens interrupts in resume callback.

This describes what the patch does. This is more or less obvious from
the patch itself. Instead it should describe why this is necessary.

>
> Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
> ---
>  drivers/thermal/qcom/tsens-v2.c |  2 +
>  drivers/thermal/qcom/tsens.c    | 93 +++++++++++++++++++++++++++++++--
>  drivers/thermal/qcom/tsens.h    |  7 +++
>  3 files changed, 98 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index 29a61d2d6ca3..1b74db6299c4 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -107,6 +107,8 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>  static const struct tsens_ops ops_generic_v2 = {
>         .init           = init_common,
>         .get_temp       = get_temp_tsens_valid,
> +       .suspend        = tsens_suspend_common,
> +       .resume         = tsens_resume_common,
>  };
>
>  struct tsens_plat_data data_tsens_v2 = {
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 6d7c16ccb44d..603ccb91009d 100644
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
> @@ -1153,7 +1154,7 @@ static const struct thermal_zone_device_ops tsens_of_ops = {
>  };
>
>  static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
> -                             irq_handler_t thread_fn)
> +                             irq_handler_t thread_fn, int *irq_num)
>  {
>         struct platform_device *pdev;
>         int ret, irq;
> @@ -1169,6 +1170,7 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
>                 if (irq == -ENXIO)
>                         ret = 0;
>         } else {
> +               *irq_num = irq;
>                 /* VER_0 interrupt is TRIGGER_RISING, VER_0_1 and up is ONESHOT */
>                 if (tsens_version(priv) == VER_0)
>                         ret = devm_request_threaded_irq(&pdev->dev, irq,
> @@ -1193,6 +1195,85 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
>         return ret;
>  }
>
> +static int tsens_reinit(struct tsens_priv *priv)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&priv->ul_lock, flags);
> +
> +       /* in VER_0 TSENS need to be explicitly enabled */
> +       if (tsens_version(priv) == VER_0)
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
> +       if (tsens_version(priv) >= VER_0_1)
> +               tsens_enable_irq(priv);
> +
> +       spin_unlock_irqrestore(&priv->ul_lock, flags);
> +
> +       return 0;
> +}
> +
> +int tsens_suspend_common(struct tsens_priv *priv)
> +{
> +       switch (pm_suspend_target_state) {
> +       case PM_SUSPEND_MEM:
> +               if (priv->combo_irq > 0) {
> +                       disable_irq_nosync(priv->combo_irq);
> +                       disable_irq_wake(priv->combo_irq);
> +               }
> +
> +               if (priv->uplow_irq > 0) {
> +                       disable_irq_nosync(priv->uplow_irq);
> +                       disable_irq_wake(priv->uplow_irq);
> +               }
> +
> +               if (priv->crit_irq > 0) {
> +                       disable_irq_nosync(priv->crit_irq);
> +                       disable_irq_wake(priv->crit_irq);
> +               }
> +               break;
> +       default:
> +               break;
> +       }
> +       return 0;
> +}
> +
> +int tsens_resume_common(struct tsens_priv *priv)
> +{
> +       switch (pm_suspend_target_state) {
> +       case PM_SUSPEND_MEM:
> +               tsens_reinit(priv);
> +               if (priv->combo_irq > 0) {
> +                       enable_irq(priv->combo_irq);
> +                       enable_irq_wake(priv->combo_irq);
> +               }
> +
> +               if (priv->uplow_irq > 0) {
> +                       enable_irq(priv->uplow_irq);
> +                       enable_irq_wake(priv->uplow_irq);
> +               }
> +
> +               if (priv->crit_irq > 0) {
> +                       enable_irq(priv->crit_irq);
> +                       enable_irq_wake(priv->crit_irq);
> +               }
> +               break;
> +       default:
> +               break;
> +       }
> +       return 0;
> +}
> +
>  static int tsens_register(struct tsens_priv *priv)
>  {
>         int i, ret;
> @@ -1227,15 +1308,19 @@ static int tsens_register(struct tsens_priv *priv)
>
>         if (priv->feat->combo_int) {
>                 ret = tsens_register_irq(priv, "combined",
> -                                        tsens_combined_irq_thread);
> +                                        tsens_combined_irq_thread,
> +                                        &priv->combo_irq);
>         } else {
> -               ret = tsens_register_irq(priv, "uplow", tsens_irq_thread);
> +               ret = tsens_register_irq(priv, "uplow",
> +                                        tsens_irq_thread,
> +                                        &priv->uplow_irq);
>                 if (ret < 0)
>                         return ret;
>
>                 if (priv->feat->crit_int)
>                         ret = tsens_register_irq(priv, "critical",
> -                                                tsens_critical_irq_thread);
> +                                                tsens_critical_irq_thread,
> +                                                &priv->crit_irq);
>         }
>
>         return ret;
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index cb637fa289ca..268bf56105be 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -582,6 +582,11 @@ struct tsens_priv {
>         const struct reg_field          *fields;
>         const struct tsens_ops          *ops;
>
> +       /* For saving irq number to re-use later */
> +       int                             uplow_irq;
> +       int                             crit_irq;
> +       int                             combo_irq;
> +
>         struct dentry                   *debug_root;
>         struct dentry                   *debug;
>
> @@ -634,6 +639,8 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mo
>  int init_common(struct tsens_priv *priv);
>  int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
>  int get_temp_common(const struct tsens_sensor *s, int *temp);
> +int tsens_suspend_common(struct tsens_priv *priv);
> +int tsens_resume_common(struct tsens_priv *priv);
>
>  /* TSENS target */
>  extern struct tsens_plat_data data_8960;
> --
> 2.17.1
>
>


-- 
With best wishes
Dmitry

