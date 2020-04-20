Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318D51B07E1
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 13:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgDTLov (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 07:44:51 -0400
Received: from foss.arm.com ([217.140.110.172]:46918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgDTLov (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Apr 2020 07:44:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B7481FB;
        Mon, 20 Apr 2020 04:44:50 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D42D33F237;
        Mon, 20 Apr 2020 04:44:48 -0700 (PDT)
Date:   Mon, 20 Apr 2020 12:44:46 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     zhang.lyra@gmail.com
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [RFC PATCH v1 2/2] dt-bindings: arm: Add description to the new
 property for-s2idle-only
Message-ID: <20200420114446.GB14343@lakrids.cambridge.arm.com>
References: <20200413070014.12960-1-zhang.lyra@gmail.com>
 <20200413070014.12960-3-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413070014.12960-3-zhang.lyra@gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 13, 2020 at 03:00:14PM +0800, zhang.lyra@gmail.com wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Add a new property for-s2idle-only. The idle-state marked with this
> property will be set with CPUIDLE_FLAG_S2IDLE during initialization
> and it would be expected to be found as deepest state for s2idle
> rather than other cases like play_idle().
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  Documentation/devicetree/bindings/arm/idle-states.yaml | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/idle-states.yaml b/Documentation/devicetree/bindings/arm/idle-states.yaml
> index ea805c1e6b20..cec47b3a447f 100644
> --- a/Documentation/devicetree/bindings/arm/idle-states.yaml
> +++ b/Documentation/devicetree/bindings/arm/idle-states.yaml
> @@ -263,7 +263,6 @@ patternProperties:
>      description: |
>        Each state node represents an idle state description and must be defined
>        as follows.
> -
>        The idle state entered by executing the wfi instruction (idle_standby
>        SBSA,[3][4]) is considered standard on all ARM platforms and therefore
>        must not be listed.
> @@ -283,6 +282,15 @@ patternProperties:
>               lost on state entry, otherwise it is retained.
>          type: boolean
>  
> +      for-s2idle-only:
> +        description:
> +          This indicates that the state only can be found as deepest state
> +          for s2idle rather than other cases like play_idle(). In general,
> +          the state having this property should have longer min-residency
> +          than the cpuidle target min-residency which CPU QoS constraints
> +          defines, to avoid being used by runtime cpuidle.
> +        type: boolean

This is very Linux-specific, and is encoding a policy ratehr than a
property of the state.

As on patch 1, can you please describe the expected properties of this
idle state, with some rationale as to why it's not suited for idle in
general? A real example in the commit message would be very helpful.

Thanks,
Mark.

