Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E0F287559
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 15:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbgJHNmF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 09:42:05 -0400
Received: from foss.arm.com ([217.140.110.172]:58262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbgJHNmF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Oct 2020 09:42:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A55C1063;
        Thu,  8 Oct 2020 06:42:04 -0700 (PDT)
Received: from localhost (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDFF33F71F;
        Thu,  8 Oct 2020 06:42:03 -0700 (PDT)
Date:   Thu, 8 Oct 2020 14:42:02 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, daniel.lezcano@linaro.org,
        chris.redpath@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: Add devicetree binding for
 cpu-performance-dependencies
Message-ID: <20201008134153.GA20268@arm.com>
References: <20200924095347.32148-1-nicola.mazzucato@arm.com>
 <20200924095347.32148-2-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924095347.32148-2-nicola.mazzucato@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi guys,

On Thursday 24 Sep 2020 at 10:53:46 (+0100), Nicola Mazzucato wrote:
[..]
> diff --git a/Documentation/devicetree/bindings/arm/cpu-perf-dependencies.yaml b/Documentation/devicetree/bindings/arm/cpu-perf-dependencies.yaml
> new file mode 100644
> index 000000000000..c7a577236cd6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cpu-perf-dependencies.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/cpu-perf-dependencies.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: CPU Performance Dependencies
> +
> +maintainers:
> +  - Nicola Mazzucato <nicola.mazzucato@arm.com>
> +
> +description: |+
> +  This optional node provides information to OSPM of cpu performance
> +  dependencies.
> +  Each list represents a set of CPUs which have performance level
> +  dependencies and can assumed to be roughly at the same performance
> +  level coordinated by hardware and/or firmware.
> +  Example: Describing CPUs in the same clock domain.

I'm continuing here a conversation started in v1 on the characteristics of
cpu-perf-dependencies and whether this binding actually describes the
hardware.

In the way I see this, the answer is clearly yes and it is information
that we need in the device tree, beyond the presence of SCMI as cpufreq
driver, and beyond the way it will be consumed by EAS/thermal/etc.

I link this to whether software will do the aggregation of per CPU
information in establishing the next frequency to be requested from the
driver/hardware for all dependent CPUs, or whether hardware is able to
receive the per CPU information on different channels and do the
aggregation itself.

This software aggregation is the typical way currently supported in
cpufreq, but hardware aggregation will be needed the more we see
hardware features for performance/power control.

But support for hardware aggregation involves having per-cpu channels
to convey the frequency request for that CPU. But currently the device
tree only gives us the ability to describe the information to be used
for sending frequency requests and as a result the kernel considers
CPUs as dependent only if they use the same controls for those CPUs.
So we currently can have hardware aggregation, but we lose all
information about what CPUs actually ended up having the same frequency,
because they are actually using the same clocks.

Therefore this new binding is needed for when hardware/firmware is better
equipped to make a decision about the clock rate for a group of CPUs, when
information is given about each CPU. The usefulness comes from informing
the software that some CPUs will have the same clock and therefore it
does describe a hardware characteristic of the system. In some cases
counters will help observe what was the frequency that was eventually
granted by hardware.

Knowing what CPUs actually use the same clock is very useful for the
scheduler (EAS, frequency invariance) and thermal.

Hope it helps,
Ionela.
