Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E06727AA30
	for <lists+linux-pm@lfdr.de>; Mon, 28 Sep 2020 11:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgI1JE2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Sep 2020 05:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1JE2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2020 05:04:28 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200E9C061755
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2020 02:04:28 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id r78so1378763vke.11
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2020 02:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S7pENcmmNgOoqlL1+ZG5YXU2ecSXuvsW0dZ6tL5rYFY=;
        b=iqd29t5mDGOgpna+dqL33C997s6TDn5QnSW5JQ985xPlvVqWhqjJ3+MsFOzijTtu6n
         2oXQ0eov4XdPLwRGfZDm+5jkLPNiYkJhccH0RmK7ZdLMV8cophAkURcQutBN5v8VLgNj
         t6lxjxwGkr4iQSEyVhfTIU+sM2FRd008Xy8uapCYwAapPl7ph5Pt3X1P+yHe2WJDz/G2
         fnCP2PVWQZvU0UJzQSahopKJGCPQXFmeI2i8Pr0/9tNjrTzllqGCiAEQ8OqrO7rjILSP
         9RRvUloZ3yo/feovRLhHw3bxDTOGfsEfFHRiOmy4S4ascfWtajKpCUQpl4DtZa0kru4k
         PK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S7pENcmmNgOoqlL1+ZG5YXU2ecSXuvsW0dZ6tL5rYFY=;
        b=n6tCMhDUT9r+snmtKsEdjTsRMpgJPyKA9rKIx7sWb/abn1buEwI750BWzIaTVUwi4M
         WLGNS751596Yxps1U7U6RgHw2NdjuJpifGk6J79ve8O5B9+jO3UFShAyqj8xwvubpIFb
         sH/X/shQ46rDNxmCwJE7rRUv18GhbneDYkwnWBqDMLWBXuAWM85zAadO76PMLFMV5wae
         LXIE6MRX44+6XxXZMp4oHIE7Vh74imKMxJp7BpdQvuChGpgx9xeeRUH6oc8Tzgtm3q5u
         mMMxKt+QPWKRCrsvPPjf9ZWWk9K2X0v9OqnFb59o0VCwX4Kz8Kpg/RPDj6bwGZT3xzUM
         udtg==
X-Gm-Message-State: AOAM530HlwsWtWDBarzOi/vTswirxwHdrGhqFHBsYVzwRv9oSHW1HLOw
        0+cBpV1NYJmxSsC5Yhg9whEZ69SBoorUzeianQPx8g==
X-Google-Smtp-Source: ABdhPJxHK8RbAlpRwlzO6tBh7XUOKN1wlZhR3fkmpMHAJ9DGs5PSbq3MYA1AOvuE9l+LIbKbS8k0TJrL/PCnHO7DnDg=
X-Received: by 2002:a1f:6ec4:: with SMTP id j187mr4294515vkc.15.1601283867298;
 Mon, 28 Sep 2020 02:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200924110449.329523-1-ulf.hansson@linaro.org>
 <20200924110449.329523-4-ulf.hansson@linaro.org> <DB6PR0402MB2760BD51916BEA5DB80A268188360@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <CAPDyKFrrLq6mPCsSoRBBmgMxSvC4xeiSedi1c5CsEWF=+f73mw@mail.gmail.com> <DB6PR0402MB2760B91DB92A5307E12D59BB88360@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB2760B91DB92A5307E12D59BB88360@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Sep 2020 11:03:51 +0200
Message-ID: <CAPDyKFrb7pv__AOpDRtf-psr9x_pseSCnPG1xe7pxs88m42JFQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PM / Domains: Add support for PM domain on/off
 notifiers for genpd
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 25 Sep 2020 at 16:30, Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: [PATCH v2 3/3] PM / Domains: Add support for PM domain on/off
> > notifiers for genpd
> >
> > On Fri, 25 Sep 2020 at 08:08, Peng Fan <peng.fan@nxp.com> wrote:
> > >
> > > Hi Ulf,
> > >
> > > > Subject: [PATCH v2 3/3] PM / Domains: Add support for PM domain
> > > > on/off notifiers for genpd
> > > >
> > > > A device may have specific HW constraints that must be obeyed to,
> > > > before its corresponding PM domain (genpd) can be powered off - and
> > > > vice verse at power on. These constraints can't be managed through
> > > > the regular runtime PM based deployment for a device, because the
> > > > access pattern for it, isn't always request based. In other words,
> > > > using the runtime PM callbacks to deal with the constraints doesn't work
> > for these cases.
> > >
> > > Could the notification be added before/after power on, and
> > > before/after power off? not just after power on and before power off?
> > >
> > > Our SoC has a requirement that before power on/off the specific
> > > module, the corresponding clk needs to be on to make sure the hardware
> > > async bridge could finish handshake.
> >
> > Thanks for your comments!
> >
> > May I ask, to be sure - does the clock correspond to the genpd provider or is it
> > a clock for the genpd consumer device?
>
> It is the clock for the genpd consumer device.
>
> >
> > If the former, couldn't the clock be managed from the ->power_on|off()
> > callbacks for the genpd provider?
>
> Sadly not former.
>
> Our current solution is to add a clock property to the power domain node(NXP ARM SIP
> based power domain driver), and when power_on/off, we enable/disable the clocks.
>
> But we are moving to use SCMI power domain, and leave the clock in Linux,
> Scmi power domain driver is a generic driver, and we are not able to mix clock
> parts in the driver which is bad.
>
> Your patch gives me a light that if we could use notification to let consumer
> device driver do the clock enable/disable for each power on and power off.
> That would be great.

Thanks for clarifying. Let me re-spin the patch to address your points.

[...]

Kind regards
Uffe
