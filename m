Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFBD728EFFD
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 12:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgJOKUT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 06:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgJOKUS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2020 06:20:18 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF38DC061755
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 03:20:18 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id z10so495870vkn.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 03:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eizBoQQKVpNO5IDneAKG8iIJq6JQrygg2otwS/bKlv8=;
        b=OQvcO3zpAjbzKw0Rnyvu/gQRts8P6THqF3lg62XaP6I/q4POFY71HYz1n4dpKhf5TV
         mF7vj/b0UMrD3jY9vts+2HRxlnAnDPTKM5Cqm7DjZ+tpUxdSQ9/Tx004CprkUYxyfL8U
         BgfxfSAaN4NQFBFSrpYkrGIRmT2xl6kT7HMxszbti8IAvqMRa2U4C1eCVtGBNb2UwEjz
         xOPXoM6eFjtkST50rJaR7BgcwdFg5jWSdwNWZ6O+wxN2F8RgwGZYXZ+ZO1TWlWexLShN
         OrwxGynm7LrWUZ9XG5bHz3s0TKZyYwPyJauxmlJnT9Gud7+qwWwDUSuXY+ecIqiEK+P5
         3obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eizBoQQKVpNO5IDneAKG8iIJq6JQrygg2otwS/bKlv8=;
        b=Nj4qNn7/P4joU1SNVI2Av2j0wxjKCtcfWV4DpZEzvTSQrWHEhFBLDa7mXsRD9A7Gng
         os0ZLadewtz5bnx++2BUK8eFM0TvBMn7AuNWsr6Ql6PG2zQk4erg1S0ROjL80ve605yc
         a8Cl0IeGPTiPrECtyxZQqBVcF//Jr3qwifki694Gs/qoGWq/NS1hP1dxsmbTvF/GZLw7
         fUF2veBWankhSF1ojHAuSm1Geg5m9VtSdu5VQOiYP53hNf64V848wyIA7dmhTSP3T8P7
         +mVayy5EA5dFGLbsiBpUwsOSom8L4Y7OVJlGOJ0QcczZD5bWzbeG8RGdwFZvLZ+3JfJr
         Hp4A==
X-Gm-Message-State: AOAM532wxJnBnK6+qz8/Ly4FlvhF1BEoutt2DPtNwomJvHsRxCR2sBmI
        u+1W13/wBtq4fAT1lNuFZfTvBvYxyULQ8NpQzjB2WrmfT5177Q==
X-Google-Smtp-Source: ABdhPJwa4UE+W/NtcGqBaolZiQE1kZsFmYEerbF0AKnlp5/09M8WePaYTt+iFnkDUHww9m/V8zskwO7481+CBeftdJY=
X-Received: by 2002:ac5:c1ca:: with SMTP id g10mr2105330vkk.6.1602757217834;
 Thu, 15 Oct 2020 03:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201012223400.23609-1-ilina@codeaurora.org> <20201012223400.23609-2-ilina@codeaurora.org>
 <CAPDyKFo0KrxQ8W0pawEca0_Ae0gs3OSBzHN2KY85YMnQp3ek8Q@mail.gmail.com> <20201014163120.GJ2908@codeaurora.org>
In-Reply-To: <20201014163120.GJ2908@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Oct 2020 12:19:41 +0200
Message-ID: <CAPDyKFrND192Khga6CEvFBxJjZ+rzM6wAUkyh5LOQvtXLM0osg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / runtime: register device's next wakeup
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lina,

[...]

> >>  5. Runtime PM Initialization, Device Probing and Removal
> >>  ========================================================
> >> @@ -639,6 +648,18 @@ suspend routine).  It may be necessary to resume the device and suspend it again
> >>  in order to do so.  The same is true if the driver uses different power levels
> >>  or other settings for runtime suspend and system sleep.
> >>
> >> +When a device enters idle at runtime, it may trigger the runtime PM up the
> >> +hierarchy. Devices that have an predictable interrupt pattern, may help
> >> +influence a better idle state determination of its parent. For example, a
> >> +display device could get a VSYNC interrupt every 16ms. A PM domain containing
> >> +the device, could also be entering and exiting idle due to runtime PM
> >
> >/containing the device/that has the device attached to it
> >
> >> +coordination. If the domain were also entering runtime idle, we would know when
> >> +the domain would be waken up as a result of the display device waking up. Using
> >> +the device's next_event, the PM domain governor can make a better choice of the
> >> +idle state for the domain, knowing it would be be woken up by the device in the
> >> +near future. This is specially useful when the device is sensitive to its PM
> >> +domain's idle state enter and exit latencies.
> >
> >The above sounds a little hand wavy, can you try to be a little more exact?
> >
> I can try and rephrase this. But what I think I should be saying is that
> if the domain has multiple devices and if some devices are sensitive to
> the exit latency of the domain idle, then knowing the next wakeup would
> help the governor make better domain idle state decision.
>
> >Perhaps, rather than just saying "sensitive to it's PM domain's idle
> >state..", how about explaining that by using the "next event" the
> >governor is able to select a more optimal domain idle state, thus we
> >should avoid wasting energy and better conform to QoS latency
> >constraints.
> >
> QoS is not what we are trying to conform to. We are trying to provide
> residency information to the domain to help it make better choice. Just
> like we use the CPU's next wakeup in the cluster domain governor.

Yep, that makes perfect sense to me as well. Then, please try to
clarify this in the above text.

> >> +
> >>  During system resume, the simplest approach is to bring all devices back to full
> >>  power, even if they had been suspended before the system suspend began.  There
> >>  are several reasons for this, including:
> >> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> >> index 8143210a5c54..53c2b3d962bc 100644
> >> --- a/drivers/base/power/runtime.c
> >> +++ b/drivers/base/power/runtime.c
> >> @@ -122,6 +122,33 @@ u64 pm_runtime_suspended_time(struct device *dev)
> >>  }
> >>  EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
> >>
> >> +/**
> >> + * pm_runtime_set_next_wakeup_event - Notify PM framework of an impending event.
> >> + * @dev: Device to handle
> >> + * @next: impending interrupt/wakeup for the device
> >
> >At what typical points do you expect this function to be called?
> >
> Most likely from at the start of the usecase and periodically when the
> interrupt/work is being handled. I would think this change to a
> different periodicity when the usecase parameters changes.

Alright, thanks for explaining.

>
> >> + */
> >> +int pm_runtime_set_next_event(struct device *dev, ktime_t next)
> >> +{
> >> +       unsigned long flags;
> >> +       int ret = -EINVAL;
> >> +
> >> +       /*
> >> +        * Note the next pending wakeup of a device,
> >> +        * if the device does not have runtime PM enabled.
> >> +        */
> >
> >/s/Note/Store
> >
> >Do you really need to check if runtime PM is enabled? Does it matter?
> >
> Hmm.. This has no meaning without runtime PM. Any reason why we don't
> need the check? I am okay to removing the check.

In principle, I want to avoid unnecessary code, thus I am in favor of
dropping the check. Not a big deal though.

>
> >> +       spin_lock_irqsave(&dev->power.lock, flags);
> >> +       if (!dev->power.disable_depth) {
> >> +               if (ktime_before(ktime_get(), next)) {
> >> +                       dev->power.next_event = next;
> >> +                       ret = 0;
> >> +               }
> >> +       }
> >> +       spin_unlock_irqrestore(&dev->power.lock, flags);
> >> +
> >> +       return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(pm_runtime_set_next_event);

[...]

Kind regards
Uffe
