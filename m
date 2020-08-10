Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECA4240317
	for <lists+linux-pm@lfdr.de>; Mon, 10 Aug 2020 10:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgHJIB4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Aug 2020 04:01:56 -0400
Received: from foss.arm.com ([217.140.110.172]:53928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgHJIB4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Aug 2020 04:01:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A2FF1FB;
        Mon, 10 Aug 2020 01:01:55 -0700 (PDT)
Received: from bogus (unknown [10.37.12.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8976E3F7BB;
        Mon, 10 Aug 2020 01:01:53 -0700 (PDT)
Date:   Mon, 10 Aug 2020 09:01:46 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/2] dt-bindings: cpufreq: Document Krait CPU
 Cache scaling
Message-ID: <20200810080146.GA31434@bogus>
References: <20200807234914.7341-1-ansuelsmth@gmail.com>
 <20200807234914.7341-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807234914.7341-3-ansuelsmth@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Aug 08, 2020 at 01:49:12AM +0200, Ansuel Smith wrote:
> Document dedicated Krait CPU Cache Scaling driver.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/cpufreq/krait-cache-scale.yaml   | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml b/Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml
> new file mode 100644
> index 000000000000..f10b1f386a99
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cpufreq/krait-cache-scale.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Krait Cpu Cache Frequency Scaling dedicated driver
> +
> +maintainers:
> +  - Ansuel Smith <ansuelsmth@gmail.com>
> +
> +description: |
> +  This Scale the Krait CPU Cache Frequency and optionally voltage
> +  when the Cpu Frequency is changed (using the cpufreq notifier).
> +
> +  Cache is scaled with the max frequency across all core and the cache
> +  frequency will scale based on the configured threshold in the dts.
> +
> +  The cache is hardcoded to 3 frequency bin, idle, nominal and high.
> +
> +properties:
> +  compatible:
> +    const: qcom,krait-cache
> +

How does this fit in the standard cache hierarchy nodes ? Extend the
example to cover that.

> +  clocks:
> +    description: Phandle to the L2 CPU clock
> +
> +  clock-names:
> +    const: "l2"
> +
> +  voltage-tolerance:
> +    description: Same voltage tollerance of the Krait CPU
> +
> +  l2-rates:
> +    description: |
> +      Frequency the L2 cache will be scaled at.
> +      Value is in Hz.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    items:
> +      - description: idle
> +      - description: nominal
> +      - description: high
> +

Why can't you re-use the standard OPP v2 bindings ?

--
Regards,
Sudeep
