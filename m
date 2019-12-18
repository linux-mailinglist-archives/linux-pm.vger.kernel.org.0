Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06600124481
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2019 11:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLRK0A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 05:26:00 -0500
Received: from foss.arm.com ([217.140.110.172]:40824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfLRK0A (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Dec 2019 05:26:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA48E30E;
        Wed, 18 Dec 2019 02:25:59 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDE7F3F6CF;
        Wed, 18 Dec 2019 02:25:57 -0800 (PST)
Date:   Wed, 18 Dec 2019 10:25:53 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 00/14] cpuidle: psci: Support hierarchical CPU
 arrangement
Message-ID: <20191218102553.GA27906@bogus>
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
 <CAPDyKFoTKAs-sFZWNgY+Ym8-hQ_Ks2Qa+g3EtgfMPhEstHTddw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoTKAs-sFZWNgY+Ym8-hQ_Ks2Qa+g3EtgfMPhEstHTddw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 18, 2019 at 08:36:38AM +0100, Ulf Hansson wrote:
> Sudeep, Lorenzo,
>
> On Wed, 11 Dec 2019 at 16:43, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Changes in v4:
> >         - Mover the check for OSI support from psci_dt_attach_cpu() to the
> >         caller's side of it.
> >         - Add comment in the code about using the deepest idle state as the
> >         triggering point for the domain state selection.
> >         - Folded in a patch to enable support for CPU hotplug.
>
> I believe I should have addressed all your provided inputs for this
> version, unless you find something new, of course.
>

I have marked this for a review before this Christmas, Lorenzo is off for
a while but he has mentioned to me few things to look for. I will do so
before Christmas for sure. Sorry for the delay.

--
Regards,
Sudeep
