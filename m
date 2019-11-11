Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9CC1F7666
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 15:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfKKObT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 09:31:19 -0500
Received: from foss.arm.com ([217.140.110.172]:46140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbfKKObT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Nov 2019 09:31:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 005A831B;
        Mon, 11 Nov 2019 06:31:19 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 196583F52E;
        Mon, 11 Nov 2019 06:31:16 -0800 (PST)
Date:   Mon, 11 Nov 2019 14:31:11 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 00/13] cpuidle: psci: Support hierarchical CPU
 arrangement
Message-ID: <20191111143111.GA10020@bogus>
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
 <CAPDyKFpiMK_P+4+n9wHc+68X6j44XOoTm=J8OXz5HkqoMxOsOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpiMK_P+4+n9wHc+68X6j44XOoTm=J8OXz5HkqoMxOsOg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 11, 2019 at 12:00:52PM +0100, Ulf Hansson wrote:
> On Tue, 29 Oct 2019 at 17:44, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Changes in v2:
> >         - Avoid to affect the non-OSI path with specific changes for OSI. This
> >         forced me to re-order the series and a caused more or less minor changes
> >         to most of the patches.
> >         - Updated the DT bindings for PSCI to clarify and to include the "psci"
> >         name of the PM domain to attach to.
> >         - Replaced patch1 with another patch from Sudeep, solving the same
> >         problem, but in a different way.
>
> Hi Sudeep and Lorenzo,
>
> Apologize for nagging you about reviews, again. Can you please have a
> look at the new version!?

I will take a look later this week, sorry for the delay.

--
Regards,
Sudeep
