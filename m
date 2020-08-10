Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C899324061A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Aug 2020 14:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgHJMpO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Aug 2020 08:45:14 -0400
Received: from foss.arm.com ([217.140.110.172]:55908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgHJMpO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Aug 2020 08:45:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92B9B30E;
        Mon, 10 Aug 2020 05:45:13 -0700 (PDT)
Received: from bogus (unknown [10.37.12.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB6DD3F718;
        Mon, 10 Aug 2020 05:45:11 -0700 (PDT)
Date:   Mon, 10 Aug 2020 13:45:09 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     ansuelsmth@gmail.com
Cc:     'Viresh Kumar' <viresh.kumar@linaro.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        'Rob Herring' <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: R: [RFC PATCH v2 2/2] dt-bindings: cpufreq: Document Krait CPU
 Cache scaling
Message-ID: <20200810124509.GC31434@bogus>
References: <20200807234914.7341-1-ansuelsmth@gmail.com>
 <20200807234914.7341-3-ansuelsmth@gmail.com>
 <20200810080146.GA31434@bogus>
 <061301d66f07$8beae690$a3c0b3b0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <061301d66f07$8beae690$a3c0b3b0$@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 10, 2020 at 01:15:24PM +0200, ansuelsmth@gmail.com wrote:
>
>
> > -----Messaggio originale-----
> > Da: Sudeep Holla <sudeep.holla@arm.com>
> > Inviato: lunedì 10 agosto 2020 10:02
> > A: Ansuel Smith <ansuelsmth@gmail.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>; Rafael J. Wysocki
> > <rjw@rjwysocki.net>; Rob Herring <robh+dt@kernel.org>; linux-
> > pm@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Oggetto: Re: [RFC PATCH v2 2/2] dt-bindings: cpufreq: Document Krait CPU
> > Cache scaling
> >
> > On Sat, Aug 08, 2020 at 01:49:12AM +0200, Ansuel Smith wrote:
> > > Document dedicated Krait CPU Cache Scaling driver.
> > >
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  .../bindings/cpufreq/krait-cache-scale.yaml   | 92
> > +++++++++++++++++++
> > >  1 file changed, 92 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/cpufreq/krait-
> > cache-scale.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/cpufreq/krait-cache-
> > scale.yaml b/Documentation/devicetree/bindings/cpufreq/krait-cache-
> > scale.yaml
> > > new file mode 100644
> > > index 000000000000..f10b1f386a99
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/cpufreq/krait-cache-
> > scale.yaml
> > > @@ -0,0 +1,92 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/cpufreq/krait-cache-scale.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Krait Cpu Cache Frequency Scaling dedicated driver
> > > +
> > > +maintainers:
> > > +  - Ansuel Smith <ansuelsmth@gmail.com>
> > > +
> > > +description: |
> > > +  This Scale the Krait CPU Cache Frequency and optionally voltage
> > > +  when the Cpu Frequency is changed (using the cpufreq notifier).
> > > +
> > > +  Cache is scaled with the max frequency across all core and the cache
> > > +  frequency will scale based on the configured threshold in the dts.
> > > +
> > > +  The cache is hardcoded to 3 frequency bin, idle, nominal and high.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: qcom,krait-cache
> > > +
> >
> > How does this fit in the standard cache hierarchy nodes ? Extend the
> > example to cover that.
> >
>
> I think i didn't understand this question. You mean that I should put
> in the example how the standard l2 cache nodes are defined?
>

I was referring to something like below which I found now in
arch/arm/boot/dts/qcom-msm8974.dtsi:
	L2: l2-cache {
		compatible = "cache";
		cache-level = <2>;
		qcom,saw = <&saw_l2>;
	};

> > > +  clocks:
> > > +    description: Phandle to the L2 CPU clock
> > > +
> > > +  clock-names:
> > > +    const: "l2"
> > > +
> > > +  voltage-tolerance:
> > > +    description: Same voltage tollerance of the Krait CPU
> > > +
> > > +  l2-rates:
> > > +    description: |
> > > +      Frequency the L2 cache will be scaled at.
> > > +      Value is in Hz.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +    items:
> > > +      - description: idle
> > > +      - description: nominal
> > > +      - description: high
> > > +
> >
> > Why can't you re-use the standard OPP v2 bindings ?
> >
>
> Isn't overkill to use the OPP v2 bindings to represent the the microvolt
> related to the le freq? Is the OPP v1 sufficient?

Should be fine if it is allowed. v2 came out in the flow of my thought
and was not intentional.

> Also I can't find a way to reflect this specific case where the l2 rates
> are changed based on the cpu freq value? Any idea about that?
>

OK, I am always opposed to giving such independent controls in the kernel
as one can play around say max cpu freq and lowest cache or vice-versa
and create instabilities. IMO this should be completely hidden from OS.
But I know these are old platforms, so I will shut my mouth ;)

--
Regards,
Sudeep
