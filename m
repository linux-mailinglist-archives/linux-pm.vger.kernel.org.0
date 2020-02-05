Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C309E153276
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2020 15:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgBEOGI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Feb 2020 09:06:08 -0500
Received: from foss.arm.com ([217.140.110.172]:47628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbgBEOGI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Feb 2020 09:06:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 865C431B;
        Wed,  5 Feb 2020 06:06:07 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5626F3F68E;
        Wed,  5 Feb 2020 06:06:05 -0800 (PST)
Date:   Wed, 5 Feb 2020 14:06:03 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, agross@kernel.org, david.brown@linaro.org,
        Lorenzo.Pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org, ulf.hansson@linaro.org,
        rjw@rjwysocki.net, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 5/7] drivers: firmware: psci: Add hierarchical domain
 idle states converter
Message-ID: <20200205140603.GB38466@bogus>
References: <1580736940-6985-1-git-send-email-mkshah@codeaurora.org>
 <1580736940-6985-6-git-send-email-mkshah@codeaurora.org>
 <20200203170832.GA38466@bogus>
 <0d7f7ade-3a1e-5428-d851-f1a886f58712@codeaurora.org>
 <20200204152132.GA44858@bogus>
 <6ff7c82d-4204-a339-4070-0154ab4515f1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ff7c82d-4204-a339-4070-0154ab4515f1@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 05, 2020 at 05:53:00PM +0530, Maulik Shah wrote:
>
> On 2/4/2020 8:51 PM, Sudeep Holla wrote:
> > On Tue, Feb 04, 2020 at 10:22:42AM +0530, Maulik Shah wrote:
> > > On 2/3/2020 10:38 PM, Sudeep Holla wrote:
> > > > On Mon, Feb 03, 2020 at 07:05:38PM +0530, Maulik Shah wrote:
> > > > > From: Ulf Hansson <ulf.hansson@linaro.org>
> > > > >
> > > > > If the hierarchical CPU topology is used, but the OS initiated mode isn't
> > > > > supported, we need to rely solely on the regular cpuidle framework to
> > > > > manage the idle state selection, rather than using genpd and its
> > > > > governor.
> > > > >
> > > > > For this reason, introduce a new PSCI DT helper function,
> > > > > psci_dt_pm_domains_parse_states(), which parses and converts the
> > > > > hierarchically described domain idle states from DT, into regular flattened
> > > > > cpuidle states. The converted states are added to the existing cpuidle
> > > > > driver's array of idle states, which make them available for cpuidle.
> > > > >
> > > > And what's the main motivation for this if OSI is not supported in the
> > > > firmware ?
> > > Hi Sudeep,
> > >
> > > Main motivation is to do last-man activities before the CPU cluster can
> > > enter a deep idle state.
> > >
> > Details on those last-man activities will help the discussion. Basically
> > I am wondering what they are and why they need to done in OSPM ?
>
> Hi Sudeep,
>
> there are cases like,
>
> Last cpu going to deepest idle mode need to lower various resoruce
> requirements (for eg DDR freq).
>

In PC mode, only PSCI implementation knows the last man and there shouldn't
be any notion of it in OS. If you need it, you may need OSI. You are still
mixing up the things. NACK for any such approach, sorry.

--
Regards,
Sudeep
