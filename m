Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCA139A8EB
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 19:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbhFCRSh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 13:18:37 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:26280 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbhFCRQo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 13:16:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622740488; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SyHaEX0FZUr5c3fx8FfvxZxTWKGEK/uKOAnlYdhGFmtKX4DwZPs4uN3HMduv6UpGTp
    lp3IY/ia8n2t+6ayrf3T3tpdZRjAazE8Le8C5n7WiGclscOB4EejoYZAHy6i4LJXXXT7
    qzVkMXwR4Ja/23uaq1ytmh2MJWErWdAyVycJ+wGktEXza2SLvBppo5inShHVk6jEYnRP
    aJznZfh7HQOKL9rCHrobNdu3R+PxYVg3irysZUpjn60BA9SVQZ2G9XNaz1RVD1c/MZ80
    omh7SesOnPBcSF8i4RCyZvl5MhbhQxMAu9eIKXPj6n4bZQotJwrPPaQDccDV3xJw2KAd
    TTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622740488;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=aGsr5xhE8wZXDPlW8QkvEO6FM7MTgESxpocQzqWAyCg=;
    b=NUZUdK+LkBTZUnJymo/z3UHH2STfdX/x8lMmDEx1u8w2oHFwDmboivkxrwZHQlnF7L
    LM6pWM1x0RpXrMMpCOaVGO9mLuYohG4K4b23DVRTZUMJrDK06kO7G5q85IEkJf46yU0Y
    5ESywPD0ofVJuss5o/f+PaohRBTEoDyI86JkddZLvH6ENu40/i0JfKP/XtUjJCcchO9O
    tI8Ee3BgbLk55zLEObfQAcdvlZiyWZJ20qInvOyN8NmNO4dssyeIz+SBL3HSETChxDFl
    He6FcDU62himYAjxT/XuuIox922/8Imd6icwOul5lFLlRMImxac645nH85radDH4cpS1
    PgEQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622740488;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=aGsr5xhE8wZXDPlW8QkvEO6FM7MTgESxpocQzqWAyCg=;
    b=XPDvi91TT2qiqInTvYHDUh+VH+GCoZLOo+GBCXCuxojBq9nHuZoRa7LvIEvEe2w9mh
    ZLdynUCek7vpXcyP1iiwJD01Oga7xidtQ4qRMjuFoCK/dCOMMaYNnIKhoonJiqwPQrtH
    lOTIf55iQ2uMKoYxc1WVY87HryIPsKGuBQgQK4nHARbV/srhxEewJ40482nnnLoJBm+R
    u+ClbY7A+pbVeoA1UzqteS3K59NBGqw1QN0WoBMiM1fCyKSO85n7+1l70xUoineQc+h8
    sPutVAgz/SSepXch8DIW27NVNLalNerHRfoqlX8ljgj7Hp+Y0Jp/VTYpqB4i8XEeiGxb
    aU5Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j6IczEbIo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x53HEmAHs
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 3 Jun 2021 19:14:48 +0200 (CEST)
Date:   Thu, 3 Jun 2021 19:14:43 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] PM: domains: Avoid boilerplate code for DVFS in
 subsystem/drivers
Message-ID: <YLkOAyydZMnxkEy+@gerhold.net>
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
 <YLi5N06Qs+gYHgYg@gerhold.net>
 <CAPDyKFqQ==zPwXjBxKAX9m38YfxFViqLTz8autnZc1suT5cayg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqQ==zPwXjBxKAX9m38YfxFViqLTz8autnZc1suT5cayg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 03, 2021 at 05:27:30PM +0200, Ulf Hansson wrote:
> On Thu, 3 Jun 2021 at 13:13, Stephan Gerhold <stephan@gerhold.net> wrote:
> > I think this might also go into the direction of my problem with the OPP
> > core for CPU DVFS [1] since the OPP core currently does not "power-on"
> > the power domains, it just sets a performance state. I got kind of stuck
> > with all the complexity of power domains in Linux so I think we never
> > solved that.
> 
> Hmm, that issue is in a way related.
> 
> Although, if I understand correctly, that was rather about at what
> layer it makes best sense to activate the device (from runtime PM
> point of view). And this was needed due to the fact that the
> corresponding genpd provider, requires the PM domain to be power on to
> allow changing a performance state for it. Did I get that correct?
> 

Yes, mostly. But I guess I keep coming back to the same question:

When/why does it make sense to vote for a "performance state" of
a power domain that is or might be powered off?

"Powered off" sounds like the absolutely lowest possible performance
state to me, it's just not on at all. And if suddenly a device comes and
says "I want performance state X", nothing can change until the power
domain is also "powered on".

I think my "CPU DVFS" problem only exists because in many other
situations it's possible to rely on one of the following side effects:

  1. The genpd provider does not care if it's powered on or not.
     (i.e. it's always-on or implicitly powers on if state > 0).
  2. There is some other device that votes to keep the power domain on.

And that's how the problem relates to my comment for this patch series ...

>
> >
> > Do I understand your patch set correctly that you basically make the
> > performance state votes conditional to the "power-on" vote of the device
> > (which is automatically toggled during runtime/system PM)?
> 
> The series can be considered as a step in that direction, but no, this
> series doesn't change that behaviour.
> 
> Users of dev_pm_genpd_set_performance_state() are still free to set a
> performance state, orthogonally to whether the PM domain is powered on
> or off.
> 
> >
> > If yes, I think that's a good thing. It was always really confusing to me
> > that a device can make performance state votes if it doesn't actually
> > want the power domain to be powered on.
> 
> I share your view, it's a bit confusing.
> 
> Just adding the condition internally to genpd to prevent the caller of
> dev_pm_genpd_set_performance() from succeeding to set a new state,
> unless the genpd is powered on, should be a rather simple thing to
> add.
> 
> However, to change this, we first need to double check that all the
> callers are making sure they have turned on the PM domain (typically
> via runtime PM).
> 

... because if performance state votes would be conditional to the
"power-on" vote of the device, it would no longer be possible
to rely on the side effects mentioned above. So this would most
certainly break some code that (incorrectly?) relies on these side
effects, but would also prevent such code.

My (personal) feeling so far is that just dropping performance votes
during runtime/system suspend just makes the entire situation even more
confusing.

> >
> > What happens if a driver calls dev_pm_genpd_set_performance_state(...)
> > while the device is suspended? Will that mess up the performance state
> > when the device resumes?
> 
> Good question. The idea is:
> 
> If genpd in genpd_runtime_suspend() are able to drop an existing vote
> for a performance state, it should restore the vote in
> genpd_runtime_resume(). This also means, if there is no vote to drop
> in genpd_runtime_suspend(), genpd should just leave the vote as is in
> genpd_runtime_resume().
> 

But the next time the device enters runtime suspend that vote would be
dropped, wouldn't it? That feels kind of strange to me.

Stephan
