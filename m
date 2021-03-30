Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCB234E55F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 12:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhC3KXX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Mar 2021 06:23:23 -0400
Received: from foss.arm.com ([217.140.110.172]:56452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231812AbhC3KWy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Mar 2021 06:22:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9802ED1;
        Tue, 30 Mar 2021 03:22:53 -0700 (PDT)
Received: from bogus (unknown [10.57.57.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 288FC3F792;
        Tue, 30 Mar 2021 03:22:52 -0700 (PDT)
Date:   Tue, 30 Mar 2021 11:22:44 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Sudeep.Holla@arm.com,
        Hector Yuan <hector.yuan@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v11 2/2] dt-bindings: cpufreq: add bindings for MediaTek
 cpufreq HW
Message-ID: <20210330102244.7dkzemtgrm7epmpv@bogus>
References: <1615549235-27700-1-git-send-email-hector.yuan@mediatek.com>
 <1615549235-27700-3-git-send-email-hector.yuan@mediatek.com>
 <20210324160750.GA3154702@robh.at.kernel.org>
 <20210330025643.mbeb7oqumv75o3y5@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330025643.mbeb7oqumv75o3y5@vireshk-i7>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 30, 2021 at 08:26:43AM +0530, Viresh Kumar wrote:
> On 24-03-21, 10:07, Rob Herring wrote:
> > On Fri, Mar 12, 2021 at 07:40:35PM +0800, Hector Yuan wrote:
> > > From: "Hector.Yuan" <hector.yuan@mediatek.com>
> > > 
> > > Add devicetree bindings for MediaTek HW driver.
> > > 
> > > Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> > > ---
> > >  .../bindings/cpufreq/cpufreq-mediatek-hw.yaml      |  127 ++++++++++++++++++++
> > >  1 file changed, 127 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> > > new file mode 100644
> > > index 0000000..0f3ad47
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> > > @@ -0,0 +1,127 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/cpufreq/cpufreq-mediatek-hw.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: MediaTek's CPUFREQ Bindings
> > > +
> > > +maintainers:
> > > +  - Hector Yuan <hector.yuan@mediatek.com>
> > > +
> > > +description:
> > > +  CPUFREQ HW is a hardware engine used by MediaTek
> > > +  SoCs to manage frequency in hardware. It is capable of controlling frequency
> > > +  for multiple clusters.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: mediatek,cpufreq-hw
> > > +
> > > +  reg:
> > > +    minItems: 1
> > > +    maxItems: 2
> > > +    description: |
> > > +      Addresses and sizes for the memory of the
> > > +      HW bases in each frequency domain.
> > > +
> > > +  "#performance-domain-cells":
> > 
> > A common binding schema for this and 'performance-domains' needs to land 
> > first.
> 
> Sudeep, what happened to the series you had on this ? This patchset
> has been blocked for a long time now, can we get that merged soonish
> somehow ?

Sorry, it slipped through the cracks. I posted this as a fix for SCMI which
we fixed it later. This got de-prioritised in my todo list. Sorry for that.
I think main problem I had is to write a proper select statement in YAML
scheme to check the DT nodes when it is present. I couldn't get anything
similar for reference from clocks.

I had "select: false" which I knew was not acceptable as it can't go throw
dt_bindings_check. I am happy if someone wants to pick up and work on that
to push the change or provide suggestions that I can try out. I am unable
to spend more time trying to understand whole YAML schema ATM.

-- 
Regards,
Sudeep
