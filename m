Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7107D2B9916
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 18:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgKSRNc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 12:13:32 -0500
Received: from foss.arm.com ([217.140.110.172]:35512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727513AbgKSRNb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Nov 2020 12:13:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 016C61396;
        Thu, 19 Nov 2020 09:13:31 -0800 (PST)
Received: from bogus (unknown [10.57.54.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 465353F718;
        Thu, 19 Nov 2020 09:13:28 -0800 (PST)
Date:   Thu, 19 Nov 2020 17:13:22 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v8 2/3] dt-bindings: arm: cpus: Document
 'mediatek,freq-domain' property
Message-ID: <20201119171322.2gxrv5h7sqwllgsv@bogus>
References: <1603700349-5922-1-git-send-email-hector.yuan@mediatek.com>
 <1603700349-5922-3-git-send-email-hector.yuan@mediatek.com>
 <20201028150858.GA4029348@bogus>
 <65a4e167-9d2c-7fcb-5373-33af5e002333@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65a4e167-9d2c-7fcb-5373-33af5e002333@arm.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 19, 2020 at 03:23:20PM +0000, Lukasz Luba wrote:
> 
> 
> On 10/28/20 3:08 PM, Rob Herring wrote:
> > On Mon, Oct 26, 2020 at 04:19:08PM +0800, Hector Yuan wrote:
> > > From: "Hector.Yuan" <hector.yuan@mediatek.com>
> > > 
> > > Add devicetree documentation for 'mediatek,freq-domain' property specific
> > > to Mediatek CPUs. This property is used to reference the CPUFREQ node
> > > along with the domain id.
> > > 
> > > Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> > > ---
> > >   Documentation/devicetree/bindings/arm/cpus.yaml |    6 ++++++
> > >   1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> > > index 1222bf1..e995b26 100644
> > > --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> > > @@ -255,6 +255,12 @@ properties:
> > >         where voltage is in V, frequency is in MHz.
> > > +  mediatek,freq-domain:
> > > +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> > > +    description:
> > > +      CPUs supporting freq-domain must set their "mediatek,freq-domain" property
> > > +      with phandle to a cpufreq_hw node followed by the domain id.
> > 
> > This needs to be a common binding shared with SCMI domains.
> 
> Would it be accurate to create a new binding file:
> Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.txt
> ?
>

Nope, Rob already asked to unify all such bindings and generalise it.
Here is my attempt[1] and this must just use it or help to enhance that
in order to make use of that binding.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/lkml/20201116181356.804590-1-sudeep.holla@arm.com
