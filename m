Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F1E6660DA
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jan 2023 17:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbjAKQmx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Jan 2023 11:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbjAKQmb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jan 2023 11:42:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB831146F
        for <linux-pm@vger.kernel.org>; Wed, 11 Jan 2023 08:41:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D52A2B81C88
        for <linux-pm@vger.kernel.org>; Wed, 11 Jan 2023 16:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BA9C4339C
        for <linux-pm@vger.kernel.org>; Wed, 11 Jan 2023 16:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673455302;
        bh=HAiGsZVdZ7bRLRhnBgYD+v8uX7S+LNMDjafB7ePSsPE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=srRV6h7579FD9/vtNnis7ZrO/GqsYNLwbmDaz24PDJNMbgv7klXK5jutPYQbMun9x
         tBedsxB0fRKJeMO7hY8AQ3SO1b2q+cBiisk6pMe1/sPCLKTuo+QNncc9KX/fishber
         +rzZlvNLXfbt65doUfW4pk1HT/ke7Uxreq4UdPet3DkhVoEEEPfB+wI1k6jj6RknOg
         JR5KN6Op46lVZRYRSS0rxHJwTZLq9d2vWDzQMottX/72pmUV38GoE3W3ncKbd15/E4
         E247tYUiGwI3bP1a4HpfHkIx4MJqQyoGqJCspRsPfmDlBVgMU0khNACZMd5/wDjuq8
         NvAbeyRXfFo8g==
Received: by mail-vs1-f53.google.com with SMTP id k4so16289275vsc.4
        for <linux-pm@vger.kernel.org>; Wed, 11 Jan 2023 08:41:42 -0800 (PST)
X-Gm-Message-State: AFqh2koUpEP9tOy0tOjk1HYXtGzkD9zc2qVJ9iezThmjqPFR2IryCbrw
        0/weh9hn7ISc1mRtev0y5y1QmfSO79EV8KZQrpe2qw==
X-Google-Smtp-Source: AMrXdXvGpcHrbGd1IktlEVtMp91mJzkaHY2rmPBAfofBvI8ZkhzTqUJSC534yKEI2uGlNiqT2NU+6cYF8rHr+kVIjU4=
X-Received: by 2002:a05:6102:374d:b0:3d0:af13:3b6 with SMTP id
 u13-20020a056102374d00b003d0af1303b6mr1504766vst.65.1673455301431; Wed, 11
 Jan 2023 08:41:41 -0800 (PST)
MIME-Version: 1.0
References: <20230110103420.2430518-1-daniel.lezcano@kernel.org>
In-Reply-To: <20230110103420.2430518-1-daniel.lezcano@kernel.org>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Wed, 11 Jan 2023 22:11:30 +0530
X-Gmail-Original-Message-ID: <CAHLCerOcDkUfb_SA6_XcrpYY9Zj2rmC973jApBpPJyXwEh1wVw@mail.gmail.com>
Message-ID: <CAHLCerOcDkUfb_SA6_XcrpYY9Zj2rmC973jApBpPJyXwEh1wVw@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/qcom: Remove duplicate set next trip
 point interrupt code
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 10, 2023 at 4:04 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> The tsens driver reprogram the next trip points in the irq
> handler. This function then call thermal_zone_device_update().
>
> However, thermal_zone_device_update() calls thermal_zone_set_trips()
> and from there it calls the backend 'set_trips' ops. This one in turn
> reprogram the next trip points (low/high).
>
> Consequently, the code setting the next trip points interrupt in the
> interrupt handle is not needed and could be removed.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>

Acked-by: Amit Kucheria <amitk@kernel.org>

> ---
>  drivers/thermal/qcom/tsens.c | 46 +-----------------------------------
>  1 file changed, 1 insertion(+), 45 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index b5b136ff323f..58693ee8c430 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -472,52 +472,8 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
>                         continue;
>                 if (!tsens_threshold_violated(priv, hw_id, &d))
>                         continue;
> -               ret = get_temp_tsens_valid(s, &temp);
> -               if (ret) {
> -                       dev_err(priv->dev, "[%u] %s: error reading sensor\n",
> -                               hw_id, __func__);
> -                       continue;
> -               }
>
> -               spin_lock_irqsave(&priv->ul_lock, flags);
> -
> -               tsens_read_irq_state(priv, hw_id, s, &d);
> -
> -               if (d.up_viol &&
> -                   !masked_irq(hw_id, d.up_irq_mask, tsens_version(priv))) {
> -                       tsens_set_interrupt(priv, hw_id, UPPER, disable);
> -                       if (d.up_thresh > temp) {
> -                               dev_dbg(priv->dev, "[%u] %s: re-arm upper\n",
> -                                       hw_id, __func__);
> -                               tsens_set_interrupt(priv, hw_id, UPPER, enable);
> -                       } else {
> -                               trigger = true;
> -                               /* Keep irq masked */
> -                       }
> -               } else if (d.low_viol &&
> -                          !masked_irq(hw_id, d.low_irq_mask, tsens_version(priv))) {
> -                       tsens_set_interrupt(priv, hw_id, LOWER, disable);
> -                       if (d.low_thresh < temp) {
> -                               dev_dbg(priv->dev, "[%u] %s: re-arm low\n",
> -                                       hw_id, __func__);
> -                               tsens_set_interrupt(priv, hw_id, LOWER, enable);
> -                       } else {
> -                               trigger = true;
> -                               /* Keep irq masked */
> -                       }
> -               }
> -
> -               spin_unlock_irqrestore(&priv->ul_lock, flags);
> -
> -               if (trigger) {
> -                       dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
> -                               hw_id, __func__, temp);
> -                       thermal_zone_device_update(s->tzd,
> -                                                  THERMAL_EVENT_UNSPECIFIED);
> -               } else {
> -                       dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
> -                               hw_id, __func__, temp);
> -               }
> +               thermal_zone_device_update(s->tzd, THERMAL_EVENT_UNSPECIFIED);
>
>                 if (tsens_version(priv) < VER_0_1) {
>                         /* Constraint: There is only 1 interrupt control register for all
> --
> 2.34.1
>
