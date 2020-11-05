Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7A22A8528
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 18:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgKERmd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 12:42:33 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36562 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKERmd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 12:42:33 -0500
Received: by mail-oi1-f195.google.com with SMTP id d9so2530863oib.3;
        Thu, 05 Nov 2020 09:42:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RsDQV1h3v+QR+nJVsOOAKQRY7siph12863Hmx7NzMy4=;
        b=jCMxFvfOKHrSyhxnzrtw4IWrQp3H82JSgITimRpV+OVBzDpixbpPyZkueE0yO2S9YT
         6fgZnC0djuykU70M0AlqeRBgksZGFkrsV2FRG4inLGgDsY2mvlfvOgrCxIBu0oZlAOxi
         aP1qCV63WteMPJRCgs9clpQD6xKRYkYhhbzHoTvJGLOVb+HpuXQhSL2RP79lVR0CoRM2
         8CIJ3/6wy7vEJ2jbtimTCgWCxgGcXuSvLXhVeUc7J8fnqntH0CRgvslfYJLQNDxIXBUm
         Nya+oTPrryzroG5gBS8NTComKY3ow8PpEKUVHk8kfUCbxqjrnsTn/7fOkb7x+abUKJp5
         NCLw==
X-Gm-Message-State: AOAM530OIhQv6E6br6zLi3g7arodr1CeE3GrWuzi5XEogpfEGvzTIhLi
        jcOnuo/KeQBd2Fhpu6NlcUrnz27QeBBy6Zw1FtQ3uiCr
X-Google-Smtp-Source: ABdhPJxFMtYdKzx2PpH20eL8m0AO+NQuRxEz8f/hfqFfPFW+kP9XJQbsjdnbm126mHFRwytDq2Or7OZhFLuDEkrBWh8=
X-Received: by 2002:aca:30d7:: with SMTP id w206mr347615oiw.69.1604598152198;
 Thu, 05 Nov 2020 09:42:32 -0800 (PST)
MIME-Version: 1.0
References: <20201007001934.18606-1-stanimir.varbanov@linaro.org>
 <CAJZ5v0hxdxV6pB5q94qCEmeDXOMJQzL3b8ZokgTn00i0MbykvQ@mail.gmail.com> <e24794e5-419c-ad5f-c281-12a6e15cfa4c@linaro.org>
In-Reply-To: <e24794e5-419c-ad5f-c281-12a6e15cfa4c@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Nov 2020 18:42:20 +0100
Message-ID: <CAJZ5v0htFwyDhJS3spKf73v=PX5dTCT2+Piotf4=NyGe+9g6Tw@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Use pmruntime sync variant to put suppliers
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 8, 2020 at 3:08 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Rafael,
>
> On 10/7/20 5:37 PM, Rafael J. Wysocki wrote:
> > On Wed, Oct 7, 2020 at 2:20 AM Stanimir Varbanov
> > <stanimir.varbanov@linaro.org> wrote:
> >>
> >> Calling pm_runtime_put_sync over a device with suppliers with device
> >> link flags PM_RUNTIME | RPM_ACTIVE it is observed that the supplier
> >> is not put (turned off) at the end, but instead put asynchronously.
> >
> > Yes, that's by design.
> >
> >> In some case This could lead to issues for the callers which expects
> >> that the pmruntime sync variants should also put the suppliers
> >> synchronously.
> >
> > Why would anyone expect that to happen?
>
> It is logical to me that when I call pm_runtime_put_sync the device and
> its suppliers are put synchronously. If I want to put device and its
> suppliers asynchronously I'd use pm_runtime_put. Is that wrong assumption?

The handling of suppliers is analogous to the handling of parents and
the parents are suspended asynchronously when a child suspends.

The difference between _put() and _put_sync() only applies to the
device passed in as the argument.

> >> Also the opposite rpm_get_suppliers is already using pmruntime _sync
> >> variant of the API.
> >
> > Yes, it does, because that is necessary.
> >
> >> Correct this by changing pmruntime_put to pmruntime_put_sync in
> >> rpm_put_suppliers.
> >
> > It is not a correction, but a change in behavior without good enough
> > rationale, as it stands.
>
> In my driver case I want to deal with a recovery of a crash in remote
> processor (the remote processor is used to control and program hardware
> blocks and also to communicate with host processor through shared
> memory). To restart the remote processor I have to disable clocks and
> turn off few power domains (one of the power domains is made a supplier
> of my main device) in order to complete the cold-boot.

PM-runtime doesn't guarantee you the behavior that you'd like to see here.

> The problem I'm facing with this design is that when I call
> runtime_put_sync (to disable device's clocks and turn off power domain)
> the clocks are disabled (part of pmruntime_suspend callback) but the
> pmdomain (the device supplier) is not turned synchronously. I workaround
> this by checking the supplier device via pm_runtime_active() until it
> becomes inactive and the continue with rest of the steps.

This is not a use case for PM-runtime at all.

PM-runtime is all about going low-power opportunistically, whereas you
want to enforce power down.

> From my point of view this check for supplier activity should be part of
> pmruntime API.

But the API is not what you should be using for this purpose in the first place.
