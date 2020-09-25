Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EC8278642
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 13:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgIYLst (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 07:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgIYLst (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2020 07:48:49 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAC8C0613D3
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2020 04:48:49 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id c25so571509vkm.1
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2020 04:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bOpX08TIm3AOFTz7k77ObUqDMIC27zNLgskbqhvk3SA=;
        b=PACLZu7q59wk8Az8cg9u6s88T2SjRUmZWHyp1N0U0G5a3NhuafqvY+nnQIz4jwHzKZ
         JdBWjVnR7lTpQMYe2ucg7FDdeN/XtVwC0R4lDX/2qDcHquqOeS5NcREMzCelxwmfg3Fr
         sBd4sxyvhLLvFYfYzJn4MuyMj7JmUkd8TgbCDts23DFzsE9FoEnTOlgEnGv5My0efX/W
         9pCVtYMYG4HCYJOp6GbENz2C1YSDG/yNY336BmDJ/O1JvxhGKG5wnAV/79fqZeH1/R48
         MTOLEI+oQyeoDTH0YRQ0w7GfXXDXa1WaR06bv3F1Hjw86Fbmd4YNU3PRUWTH8B0YZ95y
         PtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bOpX08TIm3AOFTz7k77ObUqDMIC27zNLgskbqhvk3SA=;
        b=A2PvTN238u6xkW/mQaJbRqUJtfnqjVzd+7Aj6kl3WreIHSUsMRdsEwPZ9fWr+JqJuJ
         wZeAWLiDKfiJocalT6igSuN1NQQ3uPFovqSXq3nJ4sj1/gPdLkl1YXEFQQf1bAnTKbt5
         sKC4HNvvupUy6Lo6t3V3pv6tvInJ6Fi7mvU55g/lV/CzKQg8bbebiWxe6cf4qKflWgWo
         o6Ntn1ILCd4CqQ4lZz0GQ2fm8xQlpFytQWg84AsVQADhSf6vMDeD/Z5GaKnCzd/qBR76
         b2RXCe41hvMCdP+u6pHFc/52khgFasxJkWBUrSGUqOTIyn3sJwNngXUs+xnV2qgvggHp
         OmZg==
X-Gm-Message-State: AOAM531W/9iv967Vw8XzL0VO+fUUQ3ABfuymYlq6zeZCjvix0f5RA3av
        1Rhbf57s8XFcPCqg1gHVrkEavFuqARSKsH8JGrwOVg==
X-Google-Smtp-Source: ABdhPJz+HJM37xvIxMDhO2iRf+bRH1sI4QfxVFpQTT+NhZrnx4AVfL/rS86Oam7VXSlyg989p2LZVUIUwQqzVxFAYO4=
X-Received: by 2002:a1f:964c:: with SMTP id y73mr2404723vkd.8.1601034528439;
 Fri, 25 Sep 2020 04:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200924110449.329523-1-ulf.hansson@linaro.org>
 <20200924110449.329523-4-ulf.hansson@linaro.org> <DB6PR0402MB2760BD51916BEA5DB80A268188360@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB2760BD51916BEA5DB80A268188360@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 25 Sep 2020 13:48:12 +0200
Message-ID: <CAPDyKFrrLq6mPCsSoRBBmgMxSvC4xeiSedi1c5CsEWF=+f73mw@mail.gmail.com>
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

On Fri, 25 Sep 2020 at 08:08, Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Ulf,
>
> > Subject: [PATCH v2 3/3] PM / Domains: Add support for PM domain on/off
> > notifiers for genpd
> >
> > A device may have specific HW constraints that must be obeyed to, before its
> > corresponding PM domain (genpd) can be powered off - and vice verse at
> > power on. These constraints can't be managed through the regular runtime
> > PM based deployment for a device, because the access pattern for it, isn't
> > always request based. In other words, using the runtime PM callbacks to deal
> > with the constraints doesn't work for these cases.
>
> Could the notification be added before/after power on, and before/after power
> off? not just after power on and before power off?
>
> Our SoC has a requirement that before power on/off the specific module,
> the corresponding clk needs to be on to make sure the hardware async
> bridge could finish handshake.

Thanks for your comments!

May I ask, to be sure - does the clock correspond to the genpd
provider or is it a clock for the genpd consumer device?

If the former, couldn't the clock be managed from the ->power_on|off()
callbacks for the genpd provider?

>
> So we need clk_prepare_on/off to guard power on and power off as below:
>
> clk_prepare_on
> power on
> clk_prepare_off
>
> clk_prepare_on
> power off
> clk_prepare_off
>
> Thanks,
> Peng.
>

[...]

Kind regards
Uffe
