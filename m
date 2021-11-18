Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3D14553D4
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 05:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242983AbhKREfj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 23:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242003AbhKREff (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 23:35:35 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208E9C061766
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 20:32:36 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id g91-20020a9d12e4000000b0055ae68cfc3dso8726371otg.9
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 20:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=B1GHlSxyaRxlM6QqGIgPsfvK+moo6MYqxVcaJfv1WLY=;
        b=k3TC4i0KTeX+GBhz4hPNuSrLTFCb3M3evhjfaIdMUjZzkL4pyMF6tbojoCYPGKuJ8U
         2uZh+HxrPxO2ipZTiC84eabAiQ57+yjAl/iE8eWz9RQap88fzeNSV+rqkCOEdOFit5LC
         N4roGuoKBLAySWr9N6jLkk9JkbBPp0xoXLUdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=B1GHlSxyaRxlM6QqGIgPsfvK+moo6MYqxVcaJfv1WLY=;
        b=a9S/L/PybqNXHOTOmokg5sZZrLzxkC+v+FQ62uuk9hoKoFhdkm81Ji1zGGaMrvOb1A
         mx43bptQCwhnhi7yTc94tH/FsAVKSyWZgE/d8MFfQURukMJ+JHvXack315sSLsBwgKIH
         mwgG6aFiZjQA0CshdZxgzOshzY3gufZuTReCY+VjCy4Rd+17I70c07/4sO5LoOjPQCsm
         Lwdl+Z7GatSXiYqBqFhaPBwsD3FmMp5I/EthSd4FIwr0tWBX48k4jSIlDg4714VVr9GX
         6YFSe/s0tiTQoZR1DZUzVb/H1ennab8OVVEl2t/oaBcvJMUrO9QrHEwvWjLeB7pXQC7z
         3tig==
X-Gm-Message-State: AOAM533erXR9M0Bx3FCbuCBGP9hgoNsR2WHrEMOTCBIeGJk0uRXvfeFM
        N7dEJwHoIaYyqxE/kihAR16TX/jwGjJNnKDbVSj8xw==
X-Google-Smtp-Source: ABdhPJzHIJM+rhbSaR1gBNASFm5KARBhXgQ93bd8m9lSQsMq0HdBz34Mcfq6WEULgCGln6BdvLoRV3HJo+N+52jpOX8=
X-Received: by 2002:a05:6830:30b7:: with SMTP id g23mr17878018ots.159.1637209955291;
 Wed, 17 Nov 2021 20:32:35 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Nov 2021 20:32:34 -0800
MIME-Version: 1.0
In-Reply-To: <76b103ec-7034-e6c1-1ab4-174cf16f9fc8@linaro.org>
References: <20211117020346.4088302-1-swboyd@chromium.org> <76b103ec-7034-e6c1-1ab4-174cf16f9fc8@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 17 Nov 2021 20:32:34 -0800
Message-ID: <CAE-0n53HNSRTdADO1dbQTyLafyajUTatMq5tsLeNDLQ4g95YpA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: qcom-hw: Use optional irq API
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Thara Gopinath (2021-11-17 18:55:17)
> Hello Stephen,
>
> Thanks for the patch
>
> On 11/16/21 9:03 PM, Stephen Boyd wrote:
> > Use platform_get_irq_optional() to avoid a noisy error message when the
> > irq isn't specified. The irq is definitely optional given that we only
> > care about errors that are -EPROBE_DEFER here.
> >
> > Cc: Thara Gopinath <thara.gopinath@linaro.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >   drivers/cpufreq/qcom-cpufreq-hw.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > index a2be0df7e174..b442d4983a22 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > @@ -382,9 +382,11 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
> >        * Look for LMh interrupt. If no interrupt line is specified /
> >        * if there is an error, allow cpufreq to be enabled as usual.
> >        */
> > -     data->throttle_irq = platform_get_irq(pdev, index);
> > -     if (data->throttle_irq <= 0)
> > -             return data->throttle_irq == -EPROBE_DEFER ? -EPROBE_DEFER : 0;
> > +     data->throttle_irq = platform_get_irq_optional(pdev, index);
> > +     if (data->throttle_irq == -ENXIO)
> > +             return 0;
> > +     if (data->throttle_irq < 0)
> > +             return data->throttle_irq;
>
> Here the idea is to return only -EPROBE_DEFER error. Else return a 0 ,
> so that cpufreq is enabled even if lmh interrupt is inaccessible. The
> above check returns errors other than -EPROBE_DEFER as well. So I would
> say make irq optional and keep the below check
>
> if (data->throttle_irq <= 0)
>         return data->throttle_irq == -EPROBE_DEFER ? -EPROBE_DEFER : 0;

I'd like to catch other errors, for example, DT has an irq specified
that is outside the range of irqs available. If the DT is correct, then
it will either have a valid irq and this will return a >= 0 value or
nothing will be specified and we'll get back -ENXIO now. Do you have
some scenario where my patch fails to work?
