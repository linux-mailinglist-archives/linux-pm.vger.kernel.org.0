Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97B1C1559FF
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2020 15:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgBGOs7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Feb 2020 09:48:59 -0500
Received: from foss.arm.com ([217.140.110.172]:40792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGOs7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Feb 2020 09:48:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 637CA328;
        Fri,  7 Feb 2020 06:48:58 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 330BD3F6CF;
        Fri,  7 Feb 2020 06:48:56 -0800 (PST)
Date:   Fri, 7 Feb 2020 14:48:50 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, lsrao@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 5/7] drivers: firmware: psci: Add hierarchical domain
 idle states converter
Message-ID: <20200207144850.GA18655@e121166-lin.cambridge.arm.com>
References: <0d7f7ade-3a1e-5428-d851-f1a886f58712@codeaurora.org>
 <20200204152132.GA44858@bogus>
 <6ff7c82d-4204-a339-4070-0154ab4515f1@codeaurora.org>
 <20200205140603.GB38466@bogus>
 <CAPDyKFoyepN2VX4COMomp1e9dXPozzrgCdcy0paee2jp8Wm3YA@mail.gmail.com>
 <20200205161816.GD38466@bogus>
 <CAPDyKFqaA7oN2+oLS=Puw+jQXke_ErGQAWYuTuU-6PS7mo5YbQ@mail.gmail.com>
 <20200206204514.GB8107@codeaurora.org>
 <20200207111955.GA40103@bogus>
 <CAPDyKFp-zvD1iFcpRaTFiuazxYmLEx0Czf3=TZJxjSCDmmPsvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFp-zvD1iFcpRaTFiuazxYmLEx0Czf3=TZJxjSCDmmPsvA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 07, 2020 at 01:32:28PM +0100, Ulf Hansson wrote:
> [...]
> 
> > > I understand the arguments for using PC vs OSI and agree with it. But
> > > what in PSCI is against Linux knowing when the last core is powering
> > > down when the PSCI is configured to do only Platform Cordinated.
> >
> > Nothing :D. But knowing the evolution and reasons for adding OSI in the
> > PSCI specification and having argued about benefits of OSI over PC for
> > years and finally when we have it in mainline, this argument of using
> > PC for exact reasons why OSI evolved is something I can't understand
> > and I am confused.
> >
> > > There should not be any objection to drivers knowing when all the cores
> > > are powered down, be it reference counting CPU PM notifications or using
> > > a cleaner approach like this where GendPD framwork does everything
> > > cleanly and gives a nice callback. ARM architecture allows for different
> > > aspects of CPU access be handled at different levels. I see this as an
> > > extension of that approach.
> > >
> >
> > One thing that was repeatedly pointed out during OSI patch review was no
> > extra overhead for PC mode where firmware can make decisions. So, just
> > use OSI now and let us be done with this discussion of OSI vs PC. If PC
> > is what you think you need for future, we can revert all OSI changes and
> > start discussing again :-)
> 
> Just to make it clear, I fully agree with you in regards to overhead
> for PC-mode. This is especially critical for ARM SoCs with lots of
> cores, I assume.
> 
> However, the overhead you refer to, is *only* going to be present in
> case when the DTS has the hierarchical CPU topology description with
> "power-domains". Because, that is *optional* to use, I am expecting
> only those SoC/platforms that needs to manage last-man activities to
> use this layout, the others will remain unaffected.

In PC mode not only there is no need but it is wrong to manage
any last-man activity in the kernel. I wonder why we are still
talking about this to be honest.

Code to handle PSCI platform coordinated mode has been/is in
the kernel today and that's all is needed according to the PSCI
specifications.

Thanks,
Lorenzo
