Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923FF581610
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jul 2022 17:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbiGZPHu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jul 2022 11:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239077AbiGZPHn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2022 11:07:43 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6DA2ED6F
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 08:07:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t17so10829422lfk.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 08:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4j32k3q5gP2h8DTfwuWxKk5uDdyOFPJ0xQUuz0jfqs=;
        b=Ks/glCGgvLi4Edpj0iSskb155gEpsPar+bdKbGaHSwcL77DNroIZl+U+NkJH4O/0FH
         wZ7pWG+cO+CpE7V9QEfkw9xZcMUcYGwF3L1zTIofyrrLKYw4s+bagFEp2KdxdoQ9PAM0
         mweQ6pju7xdimUZJCzS9e/oofWeZRacIq2751NNugwuHC2jwQDSNaPpL4VYIdtIufQNs
         AkYmQFAai1OURkqRzPd3EE8qlPuTb6t/ke+DpkNFz2Afzz6S7pfXJ35BiVGd44Ufi89f
         nph4rm1326o1WNBhwr/9gVu2yc9hCwXIleYhPV3ok0BV1l6u8N1feXB1G8reQVE1f2FQ
         OrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4j32k3q5gP2h8DTfwuWxKk5uDdyOFPJ0xQUuz0jfqs=;
        b=wNbculFGVVxY8/aOe1mBLJvpf54RL/i4UFUbubeHlVzpPvPE5DH6S2yEsk+9jgDI3t
         u8+qv9zA+LCx7h/zmTrGONpXOG6vsNIULfC21iCnOngmqjSZqU1N9Dqf7A4z6mmGdb+h
         b10fmUJR8HBbv/orX79i+KMO2K1JMi0EIGSHYMkS2z83c+aPRC6uzGcACP6tEEm8/6ku
         5yylSdAIcOCjN6NbIUqcxPZgvXFoWEZsjuhfQQo5uEhPiA6Rot0l+mj/yNYDNFXGDnK7
         eGqSy+uOW0gtsn4v8kXAjQJgWSJ4DAfz8HR9ASsRfHr0tkFVzeeGpw/N28pdmNdDn2eX
         ehig==
X-Gm-Message-State: AJIora8XUKFy9aS+DQF6qlJnghRzI3rINi+P71ctPSq9ni0NsX2wj2Qd
        meDDDI5omm+xwuOxjbXGT6w22+VY6TiZ5kjtHXFJ/7nM2YQrhBhx
X-Google-Smtp-Source: AGRyM1vxrlG2MG8StfxJEsORszfz8eailae1D+NT2ARAYpo79uf40PuRdHcL7xsbO57ERF8LQy3Bb4Z5sz1TwUediAc=
X-Received: by 2002:ac2:57c1:0:b0:48a:8714:db35 with SMTP id
 k1-20020ac257c1000000b0048a8714db35mr5192800lfo.233.1658848060668; Tue, 26
 Jul 2022 08:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220726083257.1730630-1-martin.kepplinger@puri.sm> <20220726083257.1730630-2-martin.kepplinger@puri.sm>
In-Reply-To: <20220726083257.1730630-2-martin.kepplinger@puri.sm>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Jul 2022 17:07:04 +0200
Message-ID: <CAPDyKFrLLw=y9+t3f_bOH2mw2NVDGJxKE5=+XHY7C6SUzLzUDg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] power: domain: handle genpd correctly when needing interrupts
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     rafael@kernel.org, khilman@kernel.org, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, pavel@ucw.cz,
        kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 26 Jul 2022 at 10:33, Martin Kepplinger
<martin.kepplinger@puri.sm> wrote:
>
> If for example the power-domains' power-supply node (regulator) needs
> interrupts to work, the current setup with noirq callbacks cannot
> work; for example a pmic regulator on i2c, when suspending, usually already
> times out during suspend_noirq:
>
> [   41.024193] buck4: failed to disable: -ETIMEDOUT
>
> So fix system suspend and resume for these power-domains by using the
> "outer" suspend/resume callbacks instead. Tested on the imx8mq-librem5 board,
> but by looking at the dts, this will fix imx8mq-evk and possibly many other
> boards too.
>
> This is designed so that genpd providers just say "this genpd needs
> interrupts" (by setting the flag) - without implying an implementation.
>
> Initially system suspend problems had been discussed at
> https://lore.kernel.org/linux-arm-kernel/20211002005954.1367653-8-l.stach@pengutronix.de/
> which led to discussing the pmic that contains the regulators which
> serve as power-domain power-supplies:
> https://lore.kernel.org/linux-pm/573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm/T/
>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  drivers/base/power/domain.c | 13 +++++++++++--
>  include/linux/pm_domain.h   |  5 +++++
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 5a2e0232862e..58376752a4de 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -130,6 +130,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
>  #define genpd_is_active_wakeup(genpd)  (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
>  #define genpd_is_cpu_domain(genpd)     (genpd->flags & GENPD_FLAG_CPU_DOMAIN)
>  #define genpd_is_rpm_always_on(genpd)  (genpd->flags & GENPD_FLAG_RPM_ALWAYS_ON)
> +#define genpd_irq_on(genpd)            (genpd->flags & GENPD_FLAG_IRQ_ON)
>
>  static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
>                 const struct generic_pm_domain *genpd)
> @@ -2065,8 +2066,15 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>         genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
>         genpd->domain.ops.runtime_resume = genpd_runtime_resume;
>         genpd->domain.ops.prepare = genpd_prepare;
> -       genpd->domain.ops.suspend_noirq = genpd_suspend_noirq;
> -       genpd->domain.ops.resume_noirq = genpd_resume_noirq;
> +
> +       if (genpd_irq_on(genpd)) {
> +               genpd->domain.ops.suspend = genpd_suspend_noirq;
> +               genpd->domain.ops.resume = genpd_resume_noirq;
> +       } else {
> +               genpd->domain.ops.suspend_noirq = genpd_suspend_noirq;
> +               genpd->domain.ops.resume_noirq = genpd_resume_noirq;

As we discussed previously, I am thinking that it may be better to
move to using genpd->domain.ops.suspend_late and
genpd->domain.ops.resume_early instead.

Beside this, I think the $subject patch looks good to me.

[...]

Kind regards
Uffe
