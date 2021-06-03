Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAA0399F99
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 13:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhFCLO4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 07:14:56 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:15870 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhFCLO4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 07:14:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622718781; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GSIWIrf7ywppJJEjkvvgmI/loYH+nKK5DHzj6GSDzZq57+PvtWDDls/YivsbUswtXd
    oAsyBWduYB/L8WPpVgEB1d8H5velnvnHVwZymvkPtQYFgL+DCDUcISzN7JpM3xAk2RS6
    0A/4LgtOnGqdvLomLIzg4FTeLvNd5xWo/nqVYHop/lPKA1nhhNM206PtDzdnR++ElJCg
    oGW3ywxfnU3/FfIYY15pbaHf0o8MqAdBbtKzBCPmXj1WLDlG0SA/IlgpZfN/WWM6E/OE
    Vf5lIC5UyBa1CkAfSfPFv4nR9WJb5+IYx5BkmWyJpSnuAHHP+sapCcIW/51GskUElo91
    4URw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622718781;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ue0OX8ADzmc6O49R/68CxDuotQxVkzYCVDwMD9Zjyew=;
    b=m571De8fYbcy6PGk8anztXMe9D1WXZvtyg+mpfYhlq408PplGM927k7LsZnUHITyUx
    6Jirf/3SiU0U9d7HGKNcpWkIwlNW4jNCV0IEb1UWX35AKjrgNIKkQktLvlDzZHDQQKWB
    MEaHVZR8poLVTQ+hnTgL5FweJYigRFOZi+TPionhS63QQiWeFMEFw0qsi7WVB+Sa4jVF
    cpfTNLPMd4ViX0tlx5xmCLqeJ1r9Z6XLNEfAIr96/ejX1Tx55kWMo+5lmmp+8MJKScdz
    86w46m16i2WISyqWOkkRwXBEW065zGylPsiNY2/xwyRrVl82LNaBo8381XhMXXUoXIXr
    d+9g==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622718781;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ue0OX8ADzmc6O49R/68CxDuotQxVkzYCVDwMD9Zjyew=;
    b=QXJL6SKEzt4kO+MHcbuIQgzf3ZLGLJ0bH7rva7kaInFdkuQqZBV+WaeGLWcZjkvAZL
    +9SXnNgZysGAs0ZuBtB6y9JydoSKFcQRGhuxPYdv8bqlYvvYuhRUWva9dmizURn1oTlU
    vFE06Cde3nMPdHjhKGDxWpfNGekyUQp/b1ck5zUm7qhFhHVmAigBSMm2+ZMQWm75T25A
    V2c0hGl1MIfps76jXfBtXDbXmH8VLCPgfYI9cDzPZzkMgrJen3453OVMZFHvgG2jkujt
    ZfQedUU2FoT71ks4VwuX4wJP6NhYzcWIawgfb92DRXx17RUKgtT5ME3tk8z2NI8oDlFL
    I2zw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j6IczEbIo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x53BD06ws
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 3 Jun 2021 13:13:00 +0200 (CEST)
Date:   Thu, 3 Jun 2021 13:12:55 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] PM: domains: Avoid boilerplate code for DVFS in
 subsystem/drivers
Message-ID: <YLi5N06Qs+gYHgYg@gerhold.net>
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603093438.138705-1-ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 03, 2021 at 11:34:34AM +0200, Ulf Hansson wrote:
> Various discussions on LKML have pointed out that many subsystem/drivers for
> devices that may be attached to a genpd and which manages DVFS/OPP though the
> genpd performance states, would need very similar updates.
> 
> More precisely, they would likely have to call dev_pm_opp_set_rate|opp() to
> drop and restore OPPs (which propagates upwards into performance states votes
> in genpd), every time their devices should enter/exit a low power state, via
> their device PM callbacks.
> 
> Rather than having to add the boilerplate code for these things into the
> subsystems/drivers, this series implements the logic internally into genpd.
> 
> Concerns have been raised about this approach, mostly by myself, around that it
> limits flexibility. On the other hand, it starts to look like more and more
> people are requesting this to be manged internally in genpd, for good reasons.
> So, I think it's worth to give this a try.
> 
> In the long run, if it turns out that the flexibility was indeed needed, we can
> always deal with that as special cases on top.
> 

Do I understand your patch set correctly that you basically make the
performance state votes conditional to the "power-on" vote of the device
(which is automatically toggled during runtime/system PM)?

If yes, I think that's a good thing. It was always really confusing to me
that a device can make performance state votes if it doesn't actually
want the power domain to be powered on.

What happens if a driver calls dev_pm_genpd_set_performance_state(...)
while the device is suspended? Will that mess up the performance state
when the device resumes?

I think this might also go into the direction of my problem with the OPP
core for CPU DVFS [1] since the OPP core currently does not "power-on"
the power domains, it just sets a performance state. I got kind of stuck
with all the complexity of power domains in Linux so I think we never
solved that.

Stephan

[1]: https://lore.kernel.org/linux-pm/20200826093328.88268-1-stephan@gerhold.net/
