Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A79C14DA62
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2020 13:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgA3MHb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jan 2020 07:07:31 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42838 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3MHb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jan 2020 07:07:31 -0500
Received: by mail-vs1-f68.google.com with SMTP id b79so1877391vsd.9
        for <linux-pm@vger.kernel.org>; Thu, 30 Jan 2020 04:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LrkIvDvrNXYWHApNqe3t61PUBGUIMYiDzggTQKjPxz0=;
        b=sFCCJFuWVSJeb5LMccXSELteBog3WeJAUjCP+M82bP5zcHgntWGf5eu98A+9HO4iFJ
         EVae15g3toaBDW44ND2EmfOMpKAofWS2XSfbVZqumZz75g0tE/wFnhbhXoEK+taNV2rS
         SyThsNgOT8H+jCROTyAg+K8vldBOLi7c4uKFAfH5MoC3IPUm7gfj27eynoDP5fLBcjhq
         oN/b4IZIGWABAUkVieVZJf5KFiHIof+0F1rGynGFjyIc9NQvdA+/tG8caQNmZ0p8x87t
         TW2VnuZcxFyn0EGijnwVueGbH5xMXJXm4UqLC3dF6hams4bXmHIPPiKeQjXhcMew4Jzd
         uR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrkIvDvrNXYWHApNqe3t61PUBGUIMYiDzggTQKjPxz0=;
        b=r83dVa0QBN9vbD9uaqKCkGI6XUWEbdLDc486ZyTsBwRB4r2F/qtxZl2x0tgrX4crfi
         XtuB0c11/z4eYVv2zDPsFGrNsh57u+EW0OHFNQV0cK0mqsi3WCbk1wRydZwDbzQeiyzf
         eLpcGYg1DwnL9/Sb1FiAytho2Mth1EIkpiCt5rxL6vyc0dbD+xY2RQt7YLrOXze1cOAI
         mGMiCWdElKhGLiKNldaRDkew7jCsg6hEQhoaMMXVXL9hPzLd5AVY7JBLoz2T33wMkNUO
         jU70ZTLhVezq099vV4pob7JHC54IX/Ptw3vWWjqrT1v0Ct9w6ceIbMUXRWNtsuwu8nbh
         OmIw==
X-Gm-Message-State: APjAAAX0bUBbkIzoBBGBEpOr+O8HmBPCpfv5CD3y8xNOgZN9VsHkUBEC
        kGzJ71B5cAT3JkixKjZz1iBFF2B2Ql3km7bf5M5DjQ==
X-Google-Smtp-Source: APXvYqxtqo70QcFPYTVimXTCqifsu0/mGCuNJFYaeYoR46HT/Z2WmXrOgW+KG0m7N8gxKtPkObLWWEYYt7WL1psSR8c=
X-Received: by 2002:a67:e99a:: with SMTP id b26mr2815388vso.27.1580386049096;
 Thu, 30 Jan 2020 04:07:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577976221.git.amit.kucheria@linaro.org>
 <9e3527ac0f6baa64aeda8eb634ca5020ea7478e5.1577976221.git.amit.kucheria@linaro.org>
 <20200102194552.GD988120@minitux>
In-Reply-To: <20200102194552.GD988120@minitux>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 30 Jan 2020 17:37:18 +0530
Message-ID: <CAHLCerO0B5pfWVxZ=3NzCYX3uL_6vS=jF9uxu0=XNgJoLOmpoQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] drivers: thermal: tsens: Add critical interrupt support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 3, 2020 at 1:15 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 02 Jan 06:54 PST 2020, Amit Kucheria wrote:
> [..]
> > @@ -189,6 +197,9 @@ static void tsens_set_interrupt_v1(struct tsens_priv *priv, u32 hw_id,
> >       case LOWER:
> >               index = LOW_INT_CLEAR_0 + hw_id;
> >               break;
> > +     case CRITICAL:
> > +             /* No critical interrupts before v2 */
> > +             break;
>
> You need to break harder, right now you're just attempting to write
> "enable" to VER_MAJOR in this case.

Will fix.

>
> >       }
> >       regmap_field_write(priv->rf[index], enable ? 0 : 1);
> >  }
> [..]
> > @@ -321,6 +357,64 @@ static inline u32 masked_irq(u32 hw_id, u32 mask, enum tsens_ver ver)
> >       return 0;
> >  }
> >
> > +/**
> > + * tsens_critical_irq_thread - Threaded interrupt handler for critical interrupts
>
> () on the function name to denote it being a function.

Will fix.

>
> > + * @irq: irq number
> > + * @data: tsens controller private data
> > + *
> > + * Check all sensors to find ones that violated their critical threshold limits.
> > + * Clear and then re-enable the interrupt.
> > + *
> > + * The level-triggered interrupt might deassert if the temperature returned to
> > + * within the threshold limits by the time the handler got scheduled. We
> > + * consider the irq to have been handled in that case.
> > + *
> > + * Return: IRQ_HANDLED
> > + */
> > +irqreturn_t tsens_critical_irq_thread(int irq, void *data)
> > +{
> > +     struct tsens_priv *priv = data;
> > +     struct tsens_irq_data d;
> > +     unsigned long flags;
> > +     int temp, ret, i;
> > +
> > +     for (i = 0; i < priv->num_sensors; i++) {
> > +             const struct tsens_sensor *s = &priv->sensor[i];
> > +             u32 hw_id = s->hw_id;
> > +
> > +             if (IS_ERR(s->tzd))
> > +                     continue;
> > +             if (!tsens_threshold_violated(priv, hw_id, &d))
> > +                     continue;
> > +             ret = get_temp_tsens_valid(s, &temp);
> > +             if (ret) {
> > +                     dev_err(priv->dev, "[%u] %s: error reading sensor\n", hw_id, __func__);
> > +                     continue;
> > +             }
> > +
> > +             spin_lock_irqsave(&priv->ul_lock, flags);
>
> You meant crit_lock here?

Good catch, will fix.

>
> But perhaps more importantly, why do you need a lock here?

I'm reading and changing interrupt state registers in this section and
there can be multiple interrupts occurring simultaneously. Without a
lock, the interrupt threads could potentially stomp over each other's
register state.

Having said that, I think I found a potential problem in porting the
downstream driver code. Basically, we only need critical interrupt to
enable watchdog support. The critical interrupt HW line can be
asserted by watchdog and by actual critical interrupts. One to one
mapping of tsens critical interrupts to trip type CRITICAL in Linux
leads to a HW shutdown. And we can use the trip type PASSIVE with
multiple ranges of temperatures to handle several levels of trip.

So I'll change the code below to mask the critical interrupts in the
event it is triggered and only use the irq thread to handle watchdog
interrupts.

> > +
> > +             tsens_read_irq_state(priv, hw_id, s, &d);
> > +
> > +             if (d.crit_viol &&
> > +                 !masked_irq(hw_id, d.crit_irq_mask, tsens_version(priv))) {
> > +                     tsens_set_interrupt(priv, hw_id, CRITICAL, false);
> > +                     if (d.crit_thresh > temp) {
> > +                             dev_dbg(priv->dev, "[%u] %s: re-arm upper\n",
> > +                                     hw_id, __func__);
> > +                     } else {
> > +                             dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
> > +                                     hw_id, __func__, temp);
> > +                     }
> > +                     tsens_set_interrupt(priv, hw_id, CRITICAL, true);
> > +             }
> > +
> > +             spin_unlock_irqrestore(&priv->crit_lock, flags);
> > +     }
> > +
> > +     return IRQ_HANDLED;
> > +}
> [..]
> > @@ -125,6 +125,28 @@ static int tsens_register(struct tsens_priv *priv)
> >               goto err_put_device;
> >       }
> >
> > +     if (priv->feat->crit_int) {
> > +             irq_crit = platform_get_irq_byname(pdev, "critical");
> > +             if (irq_crit < 0) {
> > +                     ret = irq_crit;
> > +                     /* For old DTs with no IRQ defined */
> > +                     if (irq_crit == -ENXIO)
> > +                             ret = 0;
> > +                     goto err_crit_int;
> > +             }
> > +             ret = devm_request_threaded_irq(&pdev->dev, irq_crit,
> > +                                             NULL, tsens_critical_irq_thread,
> > +                                             IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>
> You should omit the IRQF_TRIGGER_HIGH here, it will be provided by the
> system configuration (DT).

Will fix.

>
> > +                                             dev_name(&pdev->dev), priv);
> > +             if (ret) {
> > +                     dev_err(&pdev->dev, "%s: failed to get critical irq\n", __func__);
> > +                     goto err_crit_int;
> > +             }
> > +
> > +             enable_irq_wake(irq_crit);
> > +     }
> > +
> > +err_crit_int:
> >       enable_irq_wake(irq);
> >
> >  err_put_device:
> > diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> [..]
> > @@ -460,6 +526,8 @@ struct tsens_context {
> >   * @srot_map: pointer to SROT register address space
> >   * @tm_offset: deal with old device trees that don't address TM and SROT
> >   *             address space separately
> > + * @ul_lock: lock while processing upper/lower threshold interrupts
>
> This looks like an unrelated fixup to a previous patch? Please keep it
> separate.

Will remove.


> > + * @crit_lock: lock while processing critical threshold interrupts
> >   * @rf: array of regmap_fields used to store value of the field
> >   * @ctx: registers to be saved and restored during suspend/resume
> >   * @feat: features of the IP
> > @@ -479,6 +547,9 @@ struct tsens_priv {
> >       /* lock for upper/lower threshold interrupts */
> >       spinlock_t                      ul_lock;
> >
> > +     /* lock for critical threshold interrupts */
> > +     spinlock_t                      crit_lock;
>
> You're lacking a spin_lock_init() of this.

Will fix.

> > +
> >       struct regmap_field             *rf[MAX_REGFIELDS];
> >       struct tsens_context            ctx;
> >       struct tsens_features           *feat;
> > @@ -500,6 +571,7 @@ int tsens_enable_irq(struct tsens_priv *priv);
> >  void tsens_disable_irq(struct tsens_priv *priv);
> >  int tsens_set_trips(void *_sensor, int low, int high);
> >  irqreturn_t tsens_irq_thread(int irq, void *data);
> > +irqreturn_t tsens_critical_irq_thread(int irq, void *data);
>
> I think you should squash tsens.c and tsens-common.c into one file, so
> you don't need to keep adding these extern declarations for every
> function - separate of this series of course.

Agreed. The separation no longer makes sense.

Thanks for the review.
