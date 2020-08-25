Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3497F251C9F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 17:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgHYPu0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 11:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbgHYPuZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Aug 2020 11:50:25 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0274D207BC;
        Tue, 25 Aug 2020 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598370625;
        bh=kkJkXhmioIJQwsukGCwJD/oWEwK9HwwT7ICNctF3euE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iepPZMUxPPfNV4NgNQvKYw0bKlAp+7ff2+icC5HJDfMTos6esrkPTtqMOCHQw+xKh
         J+a0izz+d2S5jk2Ch/ERGJZd8ZXaRCpkI5mT16bZHcFof/vxMgzKyvSp2C0LN6ToU5
         Ze9SAt6kOgakUjZJJOcd2OI8hQRX8747inBg5RoA=
Received: by mail-ot1-f45.google.com with SMTP id n23so997868otq.11;
        Tue, 25 Aug 2020 08:50:24 -0700 (PDT)
X-Gm-Message-State: AOAM530P/8tJNuKGnB+K7A33DwtwLfw5iz+tFIXtrswUXLMTL+0Q0Y/U
        +WOBrHJUHr3w1UGByBBLjC33Xsm+yx9cwoafiA==
X-Google-Smtp-Source: ABdhPJzwQ9ZH34bliWvfQGeu3USdo0K8TRmckV2s4StillhPTdBNCd1F3rQthdZKBSrONLJMcgBLlGMcftceTr+YEvg=
X-Received: by 2002:a9d:32e5:: with SMTP id u92mr6653653otb.107.1598370624203;
 Tue, 25 Aug 2020 08:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200811123115.8144-1-finley.xiao@rock-chips.com>
 <20200824230956.GA3500214@bogus> <c3f54e18-8683-8bd9-90fa-e3465cddf8e8@arm.com>
 <13b84e7e-adfe-5939-e78d-0a20fce0a92e@linaro.org>
In-Reply-To: <13b84e7e-adfe-5939-e78d-0a20fce0a92e@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 25 Aug 2020 09:50:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJO7PFYMpO-eDaCOzz5MxyjkfOScw9Q_ZzF=bEswCweGA@mail.gmail.com>
Message-ID: <CAL_JsqJO7PFYMpO-eDaCOzz5MxyjkfOScw9Q_ZzF=bEswCweGA@mail.gmail.com>
Subject: Re: [PATCH v1] thermal/of: Introduce k-po, k-pu and k-i for a thermal zone
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org, Tao Huang <huangtao@rock-chips.com>,
        Tony Xie <tony.xie@rock-chips.com>,
        Liang Chen <cl@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 25, 2020 at 3:44 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 25/08/2020 10:25, Lukasz Luba wrote:
> > Hi Rob,
> >
> > On 8/25/20 12:09 AM, Rob Herring wrote:
> >> On Tue, Aug 11, 2020 at 08:31:15PM +0800, Finley Xiao wrote:
> >>> The default value for k_pu is:
> >>>      2 * sustainable_power / (desired_temperature - switch_on_temp)
> >>> The default value for k_po is:
> >>>      sustainable_power / (desired_temperature - switch_on_temp)
> >>> The default value for k_i is 10.
> >>>
> >>> Even though these parameters of the PID controller can be changed
> >>> by the following sysfs files:
> >>>      /sys/class/thermal/thermal_zoneX/k_pu
> >>>      /sys/class/thermal/thermal_zoneX/k_po
> >>>      /sys/class/thermal/thermal_zoneX/k_i
> >>>
> >>> But it's still more convenient to change the default values by
> >>> devicetree,
> >>> so introduce these three optional properties. If provided these
> >>> properties,
> >>> they will be parsed and associated with the thermal zone via the thermal
> >>> zone parameters.
> >>>
> >>> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> >>> ---
> >>>   Documentation/devicetree/bindings/thermal/thermal.txt | 14
> >>> ++++++++++++++
> >>
> >> Bindings should be a separate file and this one is a DT schema now.
> >>
> >>>   drivers/thermal/thermal_of.c                          |  7 +++++++
> >>>   2 files changed, 21 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt
> >>> b/Documentation/devicetree/bindings/thermal/thermal.txt
> >>> index f78bec19ca35..ebe936b57ded 100644
> >>> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> >>> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> >>> @@ -165,6 +165,20 @@ Optional property:
> >>>               2000mW, while on a 10'' tablet is around
> >>>               4500mW.
> >>>   +- k-po:            Proportional parameter of the PID controller when
> >>> +            current temperature is above the target.
> >>> +  Type: signed
> >>> +  Size: one cell
> >>> +
> >>> +- k-pu:            Proportional parameter of the PID controller when
> >>> +            current temperature is below the target.
> >>> +  Type: signed
> >>> +  Size: one cell
> >>> +
> >>> +- k-i:            Integral parameter of the PID controller.
> >>> +  Type: signed
> >>> +  Size: one cell
> >>
> >> What's PID?
> >>
> >> I know nothing about the sysfs params, but the binding needs to stand on
> >> it's own and needs enough detail to educate me.
> > Sorry for the delay, I missed that patch.
> > These parameters are the coefficients for the
> > Proportional-Integral-Derivative (PID) controller [1], which is the
> > core of the Intelligent Power Allocation (IPA) thermal governor.
>
> Just a few words to elaborate a bit for Rob who may not have time to
> digest the whole concept from Wikipedia :)
>
> The PID is an regulation loop where the input is compared to the output.
>
> For example when driving a car and you aim a speed cruise of 90km/h. You
> press the accelerator and watch the current speed. The smaller the
> current speed is, the stronger you will push the accelerator. And the
> closer to the cruise speed the car is, the lesser you push the
> accelerator until the car stabilize to the cruise to speed.
>
> The k-* describes how strong you push the accelerator and release it.
>
> In the thermal framework, that has an impact on how brutal the
> mitigation acts and depending on them it results in a flat temperature
> curve or a sawtooth aspect.
>
> These coefficient depends on the ambient temperature (casing, room
> temperature), the heat sink and the load. Depending on the use cases,
> you may want to change their values at runtime.
>
> From my POV, setting these values in the DT does not really make sense.

I pretty much always agree with not putting things in DT. :)

Rob
