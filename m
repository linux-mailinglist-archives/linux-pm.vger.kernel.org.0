Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3B019460A
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 19:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgCZSHZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 14:07:25 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38953 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgCZSHZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 14:07:25 -0400
Received: by mail-vs1-f65.google.com with SMTP id j128so4489067vsd.6
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2020 11:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+88eV5gK0LljhqKdZ1yGcysPszYlI5kB6q6EVwjYtM=;
        b=iajwo6ojaH6PQ0M+kFhP3CIwc4WeldtAB8KkVDaqEJ2XOiscCgtWqKrv9JgYGGrzCN
         9HdQjVQDYrEB0Tpwu/BZBGrA+jNrpOZ5/jUEOE9t1h6DXRmYGPEbeHF4k7AwRlraXoPf
         nkYRKiOHMLvzeuAXL9m/nvB/Uo76yXnDU+Dw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+88eV5gK0LljhqKdZ1yGcysPszYlI5kB6q6EVwjYtM=;
        b=nrtaUxddJgZztY5i++V/EgmoxnxKPT+ai/3OGfmUonT3/1zhHXaCVcJwThiWgkHqdj
         1fd6OCEzAAdRN+bgNZQpA4UKRpjIPKw67dKaLx0NwQZexmlZXK4HipAbn9L2CKZWTKD1
         itgL0f1xExtbYRfdVpyOuJ+A4ajGBGzwUZMHgU6dBZSCVfAytdeBfZ31lTgfwYXaAkq6
         hTlNb4D6J5BBwDyXAxOu31NZRO8NOMwedOBlfb6tqaURH4ivLeZHPNuzY0OWfu5xigAL
         oNLLHL9dQ4tHW7zlAq4MasL0wpGSNnrsC+6Kz/YLSUkWUW1FRTWwelcpbOK8gpWalG6B
         TvrQ==
X-Gm-Message-State: ANhLgQ0H2uKTNDF9pu4c9K/Ndr17RDY36lReWFLLWQkGcuTSC0uWL97m
        0Nmb4fFti3i63QqkmjSIfxDtZqi4SQo=
X-Google-Smtp-Source: ADFU+vtJD5xiZI4Fx8bVkcJ5HxKMjRcXMF3i4w7ol99vn/03/ucPDHEZ3eugoOUhq7jnLjK89MRWRQ==
X-Received: by 2002:a67:a409:: with SMTP id n9mr8249972vse.18.1585246041236;
        Thu, 26 Mar 2020 11:07:21 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id o130sm1356346vke.28.2020.03.26.11.07.19
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 11:07:20 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id r7so1594859vsg.7
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2020 11:07:19 -0700 (PDT)
X-Received: by 2002:a67:1e46:: with SMTP id e67mr8011826vse.106.1585246038937;
 Thu, 26 Mar 2020 11:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190218140210.14631-1-rplsssn@codeaurora.org> <20190218140210.14631-2-rplsssn@codeaurora.org>
In-Reply-To: <20190218140210.14631-2-rplsssn@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 26 Mar 2020 11:07:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XmBQb8yfx14T-tMQ68F-h=3UHog744b3X3JZViu15+4g@mail.gmail.com>
Message-ID: <CAD=FV=XmBQb8yfx14T-tMQ68F-h=3UHog744b3X3JZViu15+4g@mail.gmail.com>
Subject: Re: [PATCH RESEND v1 1/2] drivers: qcom: rpmh-rsc: clear active mode
 configuration for wake TCS
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi

On Mon, 18 Feb 2019 19:32:09 Raju P.L.S.S.S.N <rplsssn@codeaurora.org> wrote:
>
> For RSCs that have sleep & wake TCS but no dedicated active TCS, wake
> TCS can be re-purposed to send active requests. Once the active requests
> are sent and response is received, the active mode configuration needs
> to be cleared so that controller can use wake TCS for sending wake
> requests.
>
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/soc/qcom/rpmh-rsc.c | 77 ++++++++++++++++++++++++++-----------
>  1 file changed, 54 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index 75bd9a83aef0..6cc7f219ce48 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -201,6 +201,42 @@ static const struct tcs_request *get_req_from_tcs(struct rsc_drv *drv,
>         return NULL;
>  }
>
> +static void __tcs_trigger(struct rsc_drv *drv, int tcs_id, bool trigger)

nit: can you rename this to __tcs_set_trigger() so it's a little more
obvious that the last value means trigger/untrigger?

It'd also be nice to really understand why it has to be structured
this way.  It's weird that the two options are "untrigger + retrigger"
and "untrigger"


> +{
> +       u32 enable;
> +
> +       /*
> +        * HW req: Clear the DRV_CONTROL and enable TCS again
> +        * While clearing ensure that the AMC mode trigger is cleared
> +        * and then the mode enable is cleared.
> +        */
> +       enable = read_tcs_reg(drv, RSC_DRV_CONTROL, tcs_id, 0);
> +       enable &= ~TCS_AMC_MODE_TRIGGER;
> +       write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
> +       enable &= ~TCS_AMC_MODE_ENABLE;
> +       write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
> +
> +       if (trigger) {
> +               /* Enable the AMC mode on the TCS and then trigger the TCS */
> +               enable = TCS_AMC_MODE_ENABLE;
> +               write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
> +               enable |= TCS_AMC_MODE_TRIGGER;
> +               write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
> +       }
> +}
> +
> +static inline void enable_tcs_irq(struct rsc_drv *drv, int tcs_id, bool enable)
> +{
> +       u32 data;
> +
> +       data = read_tcs_reg(drv, RSC_DRV_IRQ_ENABLE, 0, 0);
> +       if (enable)
> +               data |= BIT(tcs_id);
> +       else
> +               data &= ~BIT(tcs_id);
> +       write_tcs_reg(drv, RSC_DRV_IRQ_ENABLE, 0, data);
> +}
> +
>  /**
>   * tcs_tx_done: TX Done interrupt handler
>   */
> @@ -237,6 +273,21 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
>                 }
>
>                 trace_rpmh_tx_done(drv, i, req, err);
> +
> +               /*
> +                * if wake tcs was re-purposed for sending active
> +                * votes, clear AMC trigger & enable modes and
> +                * disable interrupt for this TCS
> +                */
> +               if (!drv->tcs[ACTIVE_TCS].num_tcs) {
> +                       __tcs_trigger(drv, i, false);

I assume that the reason that the code originally didn't try to
"untrigger" in the interrupt handler is that it's slow (it uses
write_tcs_reg_sync).  If that's true then maybe you shouldn't do the
untrigger here for the case when you're on a borrowed TCS.  Can't you
just do the untrigger later when you reprogram the TCS for someone
else's use?


> +                       /*
> +                        * Disable interrupt for this TCS to avoid being
> +                        * spammed with interrupts coming when the solver
> +                        * sends its wake votes.
> +                        */
> +                       enable_tcs_irq(drv, i, false);

Should you be doing this under the spinlock?  You're doing a
read-modify-write of the RSC_DRV_IRQ_ENABLE register which seems like
it could race with someone trying to enable an IRQ if the borrowed TCS
type has more than one TCS (so you could be trying to start a transfer
on one TCS while one is finishing on another).

It would be somewhat hard for this to happen, but I don't _think_ it's
impossible.  Specifically:

1. Two threads can call rpmh_write() at the same time.

2. Both threads call into rpmh_rsc_send_data() w/out holding any locks.

3. Both threads call into tcs_write() w/out holding any locks.

4. Both threads call get_tcs_for_msg() w/out holding any locks.

5. Both threads notice they need to borrow the wake TCS.

6. Both threads call rpmh_rsc_invalidate().  There are locks in here,
but nothing stops both threads from returning 0 (not -EAGAIN) since
nobody has claimed the wake TCS by setting 'tcs_in_use' yet.

Assuming that there are more than one wake TCSs it is possible that
both transfers can be happening at the same time and I believe it's
even possible (though you'd need crazy timing) for one thread to hit
the interrupt handler and finish at the same time that the other
thread starts.


Assuming we care about the case of having zero-active TCS and
more-than-one-wake TCS, it'd be nice to fix.  If we don't care about
this case, it should be documented in the code.  Funny enough, most of
the time having zero-active TCS and more-than-one-wake TCS doesn't buy
us much with the current code because the 2nd thread will return
-EAGAIN from rpmh_rsc_invalidate() assuming that the 1st thread
manages to set "tcs_in_use" before the 2nd thread gets there.


Overall the locking involved with borrowing a wake TCS is really
tricky if you want to close all corner cases.  I need to constantly
refer to my series adding documentation to have any chance here.

https://lore.kernel.org/r/20200311161104.RFT.v2.5.I52653eb85d7dc8981ee0dafcd0b6cc0f273e9425@changeid

I'd love review feedback on that!  Some of this stuff maybe becomes
easier to understand if we don't have Maulik's flushing series and we
can always assume that writing active TCSs and writing sleep/wake TCSs
never happen at the same time (I think traditionally sleep/wake TCSs
only get written from special PM code when we know nothing else is
running).


-Doug
