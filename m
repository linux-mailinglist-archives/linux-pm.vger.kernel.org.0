Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CE241790E
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 18:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344009AbhIXQrh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Sep 2021 12:47:37 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:44711 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344010AbhIXQrg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Sep 2021 12:47:36 -0400
Received: by mail-oi1-f178.google.com with SMTP id e24so5323244oig.11
        for <linux-pm@vger.kernel.org>; Fri, 24 Sep 2021 09:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QL1Nkjj0tNEOxNaK4NrjVesmuxMkfYvFU1I8QUE+fDY=;
        b=VffHxPZuc4fcm1TC94R9s3DjLG3nbPWSmnX3LfCyNjzI1x3/YrFsvfaO151BxwhHfe
         rZJjT8zv26+8UnoNIU63RGKjKx9lB2c7/I0woMjxJ22IkY6WKIpKE1c2wrFhoJx/yWI8
         3QA5XLLO1Gb8CHwBf8tnELNjUQjN1ezma4l4fSTg3aa5BXKj2jml+Epd85+6S4n0nCC+
         fOWRbIFyc5I1p6muXBJrsxe5mlkXN9uf/1EwifpcBKUvxQ91JqrvSynCneXaBB1dVtkA
         RfxotpP62ZJ8nnGQpC7rBk4+HsLNWrrcNnpIhRm9L826xI4KGIoFe8VA9WzQt6BiLywu
         fnNQ==
X-Gm-Message-State: AOAM532dTBB3rnG7qyK9Z5YINleeFU/Ozs9YtNaw22htavZyec38br21
        Z+W/cqAojPyUM9lrjJONLZCLN2yCFquaTVJifVQoMIrE
X-Google-Smtp-Source: ABdhPJzNOKfuq5cFl4j1IqGcG5J8E6i2AWe4fVmBlq39QqtCkHIGLN4LssoL4Z+kORoioplYElnxnoWCQHVRBSwM4ac=
X-Received: by 2002:a05:6808:1816:: with SMTP id bh22mr2206888oib.69.1632501963273;
 Fri, 24 Sep 2021 09:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210917072022.3234272-1-dedekind1@gmail.com> <20210917072022.3234272-2-dedekind1@gmail.com>
In-Reply-To: <20210917072022.3234272-2-dedekind1@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Sep 2021 18:45:52 +0200
Message-ID: <CAJZ5v0gns1EunzRfgDAHDS22aeAXnG_3aiFX3Px=crtER00Gtg@mail.gmail.com>
Subject: Re: [PATCH 1/1] intel_idle: enable interrupts before C1 on Xeons
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 17, 2021 at 9:20 AM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> Enable local interrupts before requesting C1 on the last two generations of
> Intel Xeon platforms: Sky Lake, Cascade Lake, Cooper Lake, Ice Lake.
> This decreases average C1 interrupt latency by about 5-10%, as measured with
> the 'wult' tool.
>
> The '->enter()' function of the driver enters C-states with local interrupts
> disabled by executing the 'monitor' and 'mwait' pair of instructions. If an
> interrupt happens, the CPU exits the C-state and continues executing
> instructions after 'mwait'. It does not jump to the interrupt handler, because
> local interrupts are disabled. The cpuidle subsystem enables interrupts a bit
> later, after doing some housekeeping.
>
> With this patch, we enable local interrupts before requesting C1. In this case,
> if the CPU wakes up because of an interrupt, it will jump to the interrupt
> handler right away. The cpuidle housekeeping will be done after the pending
> interrupt(s) are handled.
>
> Enabling interrupts before entering a C-state has measurable impact for faster
> C-states, like C1. Deeper, but slower C-states like C6 do not really benefit
> from this sort of change, because their latency is a lot higher comparing to
> the delay added by cpuidle housekeeping.
>
> This change was also tested with cyclictest and dbench. In case of Ice Lake,
> the average cyclictest latency decreased by 5.1%, and the average 'dbench'
> throughput increased by about 0.8%. Both tests were run for 4 hours with only
> C1 enabled (all other idle states, including 'POLL', were disabled). CPU
> frequency was pinned to HFM, and uncore frequency was pinned to the maximum
> value. The other platforms had similar single-digit percentage improvements.
>
> It is worth noting, that this patch affects 'cpuidle' statistics a tiny bit.
> Before this patch, C1 residency did not include the interrupt handling time, but
> with this patch, it will include it. This is similar to what happens in case of
> the 'POLL' state, which also runs with interrupts enabled.
>
> Suggested-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index e6c543b5ee1d..0b66e25c0e2d 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -88,6 +88,12 @@ static struct cpuidle_state *cpuidle_state_table __initdata;
>
>  static unsigned int mwait_substates __initdata;
>
> +/*
> + * Enable interrupts before entering the C-state. On some platforms and for
> + * some C-states, this may measurably decrease interrupt latency.
> + */
> +#define CPUIDLE_FLAG_IRQ_ENABLE                BIT(14)
> +
>  /*
>   * Enable this state by default even if the ACPI _CST does not list it.
>   */
> @@ -127,6 +133,9 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
>         unsigned long eax = flg2MWAIT(state->flags);
>         unsigned long ecx = 1; /* break on interrupt flag */
>
> +       if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE)
> +               local_irq_enable();
> +
>         mwait_idle_with_hints(eax, ecx);
>
>         return index;
> @@ -698,7 +707,7 @@ static struct cpuidle_state skx_cstates[] __initdata = {
>         {
>                 .name = "C1",
>                 .desc = "MWAIT 0x00",
> -               .flags = MWAIT2flg(0x00),
> +               .flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_IRQ_ENABLE,
>                 .exit_latency = 2,
>                 .target_residency = 2,
>                 .enter = &intel_idle,
> @@ -727,7 +736,7 @@ static struct cpuidle_state icx_cstates[] __initdata = {
>         {
>                 .name = "C1",
>                 .desc = "MWAIT 0x00",
> -               .flags = MWAIT2flg(0x00),
> +               .flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_IRQ_ENABLE,
>                 .exit_latency = 1,
>                 .target_residency = 1,
>                 .enter = &intel_idle,
> --

Applied as 5.16 material, thanks!
