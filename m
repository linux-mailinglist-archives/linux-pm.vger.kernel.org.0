Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2F9442B5F
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 11:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhKBKLJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 06:11:09 -0400
Received: from foss.arm.com ([217.140.110.172]:60122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhKBKLI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Nov 2021 06:11:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E1901FB;
        Tue,  2 Nov 2021 03:08:33 -0700 (PDT)
Received: from bogus (unknown [10.57.46.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 105853F719;
        Tue,  2 Nov 2021 03:08:29 -0700 (PDT)
Date:   Tue, 2 Nov 2021 10:08:27 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linaro-open-discussions@op-lists.linaro.org" 
        <linaro-open-discussions@op-lists.linaro.org>,
        Cristian Marussi <Cristian.Marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        quic_mdtipton@quicinc.com, quic_viveka@quicinc.com,
        grahamr@codeaurora.org, s.nawrocki@samsung.com,
        a.swigon@samsung.com, abel.vesa@nxp.com, digetx@gmail.com,
        treding@nvidia.com, dawei.chien@mediatek.com,
        henryc.chen@mediatek.com
Subject: Re: SCMI protocol for interconnect scaling
Message-ID: <20211102100827.i7aqwmp5mpyskhtv@bogus>
References: <42432cc2-5cb2-ea74-0980-8575e3a343fd@kernel.org>
 <DU2PR08MB723772CAC1CEE69963675CF682839@DU2PR08MB7237.eurprd08.prod.outlook.com>
 <e2c22d54-1a2f-3730-f1a0-276a1027d977@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2c22d54-1a2f-3730-f1a0-276a1027d977@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 01, 2021 at 07:05:29PM +0200, Georgi Djakov wrote:
> 
> On 25.10.21 17:55, Souvik Chakravarty wrote:
> > Thanks Georgi for initiating this.
> > Don’t have too much to add, just some initial thinking on my part below.
> > 
> > > From: Georgi Djakov <djakov@kernel.org>
> > > Sent: Thursday, October 21, 2021 12:06 PM
> > > 
> > > 
> > > Hi all,
> > > 
> > > I am recently getting questions about hooking the interconnect framework to
> > > SCMI, so i am starting a discussion on this problem and see who might be
> > > interested in it.
> > > 
> > > The SCMI spec contains various protocols like the "Performance domain
> > > management protocol". But none of the protocols mentioned in the current
> > > spec (3.0) seem to fit well into the concept we are using to scale interconnect
> > > bandwidth in Linux. I see that people are working in this area and there is
> > > already some support for clocks, resets etc. I am wondering what would be the
> > > right approach to support also interconnect bus scaling via SCMI.
> > 
> > You are right - the current Performance Domain Mgmt. Protocol is not fit for
> > purpose for this requirement.
> > 
> > > 
> > > The interconnect framework is part of the linux kernel and it's goal is to manage
> > > the hardware and tune it to the most optimal power- performance profile
> > > according to the aggregated bandwidth demand between the various endpoints
> > > in the system (SoC). This is based on the requests coming from consumer drivers.
> > > 
> > > As interconnects scaling does not map directly to any of the currently available
> > > protocols in the SCMI spec, i am curious whether there is work in progress on
> > > some other protocol that could support managing resources based on path
> > > endpoints (instead of a single ID). The interconnect framework doesn't populate
> > > every possible path, but it exposes endpoints to client drivers and the path
> > > lookup is dynamic, based on what the clients request. Maybe the SCMI host
> > > could also expose all possible endpoints and let the guest request a path from
> > > the host, based on those endpoints.
> > > 
> > > There are already suggestions to create vendor-specific SCMI protocols for that,
> > > but i fear that we may end up with more than one protocol for the same thing,
> > > so that's why it might be best to discuss it in public and have a common solution
> > > that works for everyone.
> > 
> > +1. If there is a common requirement to be found that is always the best. Vendor specific
> > protocols might end up with extensibility issues once a similar protocol gets
> > supported in a future version of the specification.
> 
> Thanks Souvik! Maybe we should try to implement a vendor protocol as
> a starting point? I am adding more people who might be interested in
> SCMI - folks that have interconnect drivers already merged or in the
> process or doing that. The goal is to see who is interested in this
> and to figure out a list of requirements for the new protocol.

If we are merging any support for this via vendor protocol, I would like
it to support all those vendors with interconnect support merged upstream
using a single protocol rather than per-vendor protocol. i.e. if possible
talk with all those vendors before finalising the vendor protocol.

-- 
Regards,
Sudeep
