Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13E829EC55
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 13:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbgJ2M7n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 08:59:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53586 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgJ2M7n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 08:59:43 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09TCxWOt060532;
        Thu, 29 Oct 2020 07:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603976372;
        bh=DuPjch7pBzi0EzyZ8z8R+8wUMcuh8oDMffXLxKjBsGE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=jDTVa0GBkfvebo23IdhoKaBAecBs+/aRUbvK3SB8I/rjLDCGH1Enwzx33GcJJas5h
         lr1ykNA30uydFuAoN3f1bmCfqYgj3s5CnZ0WQcOe5Vrtu9uy0zp1DCOmrXiDSxbzIT
         7WlcRw/MMTzqszMvjqSy7ATIboBMHcz225aj+5dY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09TCxW2Z075614
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 07:59:32 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 29
 Oct 2020 07:59:32 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 29 Oct 2020 07:59:32 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09TCxW3m052759;
        Thu, 29 Oct 2020 07:59:32 -0500
Date:   Thu, 29 Oct 2020 07:59:32 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vireshk@kernel.org>,
        <robh+dt@kernel.org>, <sboyd@kernel.org>, <rafael@kernel.org>,
        <sudeep.holla@arm.com>, <daniel.lezcano@linaro.org>,
        <Dietmar.Eggemann@arm.com>
Subject: Re: [PATCH 1/4] dt-bindings: opp: Introduce opp-sustainable bindings
Message-ID: <20201029125932.fvhaj6fsgt3qvmoc@gloomily>
References: <20201028140847.1018-1-lukasz.luba@arm.com>
 <20201028140847.1018-2-lukasz.luba@arm.com>
 <20201028214713.zttk47qtua5jhieo@pureness>
 <5b3a99a8-6972-5c60-6cc5-00ec84387b97@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5b3a99a8-6972-5c60-6cc5-00ec84387b97@arm.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10:04-20201029, Lukasz Luba wrote:
> 
> 
> On 10/28/20 9:47 PM, Nishanth Menon wrote:
> > On 14:08-20201028, Lukasz Luba wrote:
> > > Add opp-sustainable as an additional property in the OPP node to describe
> > > the sustainable performance level of the device. This will help to
> > > estimate the sustainable performance of the whole system.
> > > 
> > > Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> > > ---
> > >   Documentation/devicetree/bindings/opp/opp.txt | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > > index 9847dfeeffcb..cd01028de305 100644
> > > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > > @@ -154,6 +154,10 @@ Optional properties:
> > >   - opp-suspend: Marks the OPP to be used during device suspend. If multiple OPPs
> > >     in the table have this, the OPP with highest opp-hz will be used.
> > > +- opp-sustainable: Marks the OPP as sustainable. This property can be used for
> > > +  estimating sustainable performance of the whole system. If multiple OPPs in
> > > +  the table have this, the OPP with highest opp-hz will be used.
> > 
> > 
> > By "sustainable", do you mean sustainable across Process, Voltage and
> > Temperature corners upto the max rated operational Power-ON hours
> > without IDLE state being achieved on the processor?
> 
> Yes, in case of CPU: running 100% without idle at that particular OPP.
> Running above that OPP would lead to cross control temperature.

We need to tighten the definitions a lot more here and add that to the
binding. What we are stating, if I am not misunderstanding is an OPP
that is guaranteed by SoC vendor that across Process Voltage and
Temperature corners - aka across the entire production spectrum
for the part number, *all* devices will operate at this OPP for the
mandated power-on-hours rating without hitting IDLE.

Example: So -40C to 125C, across the process (hot/cold/nominal), 100s of
thousands/millions of units can operate upto 125,0000 power-on-hours
while running a tight deadloop OR maybe high processing function or even
cpuburn[1]?


Can you give me one SoC vendor and part that guarantees this? I am
wondering if this is all theoretical... There are tons of parameters
that come into play for "reliability" "sustainability" etc. Those are
tricky terminology that typically makes legal folks pretty happy to
debate for decades..

just my 2 cents.
> 
> > 
> > OR do you mean to leave it up to interpretation?
> 
> I can tell how I would use them. There is thermal governor IPA, which
> needs sustainable power either form DT or uses internal algorithm to
> estimate it based on lowest allowed freq OPPs. Then it estimated
> internal coefficients based on that value, which is not optimal
> for lowest OPPs. When some higher OPP could be marked as sustainable,
> it would lead to better estimation and better power budget split.

Seeing your series, I got an idea about how you plan on using it, I
just think we need to be more precise in our definition..

[1] https://patrickmn.com/projects/cpuburn/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
