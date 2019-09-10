Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDFB1AEF11
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2019 18:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394014AbfIJQBv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Sep 2019 12:01:51 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42526 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730791AbfIJQBu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Sep 2019 12:01:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id f13so17538382qkm.9
        for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2019 09:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i4GD13AWYtGaucIdPfBacL0HOCS06RwW+OYru26aZGo=;
        b=bFVqYmBJIFyWISBLSfHrMzHiHbX5do/4cERYQDzWJt+PZeUX0OHsy+TSpRVBXTL+aQ
         3OvVTAx2WOC9NxGNNC9S6FV8QWMDIDndDSi7jqkc0qtujb/mOjXJc5BbsLL4O7ILwOLl
         ioI7jRVbci1bxCMndyhJyQ1t7X59S++cBodci18y3HAd1Y/j6ApRGSqlu2EnSogzcaCP
         NdJyhxsV0XKDKjhdMZ64YeSabZD1Li+xXFb79HCd/3i3LEksxFoU/kzsuLi/8LdbqKR5
         wi/J4RsiJiLJJHF/ktI1oaePbrpTMpxPq5h6iC2XB1nngjzzPq6YNTUrNxnc3thwBD+/
         SMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4GD13AWYtGaucIdPfBacL0HOCS06RwW+OYru26aZGo=;
        b=faIqxREoIKhE00I8/ppgEswCSdzQzJZD7uVKEJyju3LgVjeuJKkBe1OdXP+agiR7tE
         5UWdCAD1XORSGoTeYNR0enl6PTB7GO5QRuwnHuZOWhqvmQ7wDs/ODWG+H53j/pSdHVVs
         6Ux2dGX9Mi1x+Qir94c0ZE7gW6SCJpCAPEPY1T9cGO7XP/PU2yBSwYLsZoT5U6xZy++Y
         TRqMt38ol21EmV454LPsUudAQKHSvlb0iYYsEKbn/flz4gY4w+FId+COi0su/5p2CRlq
         0i3GnitX1My2oJW4sW6/6QZcalWU9+AMkOgYn64Fd8LfmJSdDGL0exdmlfPzHrJHjfJl
         uCkQ==
X-Gm-Message-State: APjAAAWavauWIJl9ai8E7QY0hQUzsHnvlOUmLPNyaewLdu54xstzIo7K
        kdCLVJaVQBUAIzvV4ahSAARoAfIflGvHXGuea0ERcA==
X-Google-Smtp-Source: APXvYqy6SzC7+IGaR6kLfQ1kWlTcyoGFIff7HiG5+P8pj2qyHaCRpqTlB6+sj4xNrcQCndtftJ80ILJGtJ0yn8yaSD4=
X-Received: by 2002:a37:2784:: with SMTP id n126mr29003422qkn.302.1568131309763;
 Tue, 10 Sep 2019 09:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566907161.git.amit.kucheria@linaro.org>
 <a4666f8afa39471658602e06758b04a991f80828.1566907161.git.amit.kucheria@linaro.org>
 <5D674C35.6060001@linaro.org>
In-Reply-To: <5D674C35.6060001@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 10 Sep 2019 21:31:38 +0530
Message-ID: <CAP245DWkd4RvH1y1E17sCEndNY=xs+69EJ-41ecRL_EE0Vnkug@mail.gmail.com>
Subject: Re: [PATCH v2 15/15] drivers: thermal: tsens: Add interrupt support
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thara,

Thanks for the review. Please find replies below.

On Thu, Aug 29, 2019 at 9:23 AM Thara Gopinath
<thara.gopinath@linaro.org> wrote:
>
> Hi Amit,
>
> On 08/27/2019 08:14 AM, Amit Kucheria wrote:
> > Depending on the IP version, TSENS supports upper, lower, max, min and
> > critical threshold interrupts. We only add support for upper and lower
> > threshold interrupts for now.
> >
> > TSENSv2 has an irq [status|clear|mask] bit tuple for each sensor while
> > earlier versions only have a single bit per sensor to denote status and
> > clear. At each interrupt, we reprogram the new upper and lower threshold
> > in the .set_trip callback.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/thermal/qcom/tsens-common.c | 377 ++++++++++++++++++++++++++--
> >  drivers/thermal/qcom/tsens-v0_1.c   |  11 +
> >  drivers/thermal/qcom/tsens-v1.c     |  29 +++
> >  drivers/thermal/qcom/tsens-v2.c     |  13 +
> >  drivers/thermal/qcom/tsens.c        |  32 ++-
> >  drivers/thermal/qcom/tsens.h        | 270 ++++++++++++++++----
> >  6 files changed, 669 insertions(+), 63 deletions(-)
> >
> > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > index 06b44cfd5eab9..c549f8e1488ba 100644
> > --- a/drivers/thermal/qcom/tsens-common.c
> > +++ b/drivers/thermal/qcom/tsens-common.c

<snip>

Please snip liberally when only replying to a small part of the patch. :-)

> > +
> > +             spin_unlock_irqrestore(&priv->ul_lock, flags);
> > +
> > +             if (trigger) {
> > +                     dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
> > +                             hw_id, __func__, temp);
> > +                     thermal_zone_device_update(priv->sensor[i].tzd,
> > +                                                THERMAL_EVENT_UNSPECIFIED);
> Why not use thermal_notify_framework? Or do you want to loop over all
> registered trips ?

Mainly so we get a driver call-back to set_trips where we might want
to change behaviour once we cross certain thresholds.

> Another comment I have is regarding support for multiple thermal zone.
> It might not be needed now, but presence of the same sensor can serve
> multiple zones (one for cooling and one for warming) . I am not sure if
> you want to put some infrastructure in place for that as well for
> interrupt handling.

It is premature to add such infrastructure to the driver until we
decide how we're going to implement support for this, IMO.

<snip>
