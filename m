Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99832C61AB
	for <lists+linux-pm@lfdr.de>; Fri, 27 Nov 2020 10:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgK0J1Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Nov 2020 04:27:25 -0500
Received: from foss.arm.com ([217.140.110.172]:35744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbgK0J1Y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Nov 2020 04:27:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 007CC1478;
        Fri, 27 Nov 2020 01:27:24 -0800 (PST)
Received: from [10.57.26.227] (unknown [10.57.26.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5176D3F71F;
        Fri, 27 Nov 2020 01:27:21 -0800 (PST)
Subject: Re: [RFC 1/2] dt-bindings: thermal: sprd: Add virtual thermal
 documentation
To:     gao.yunxiao6@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org, robh+dt@kernel.org,
        javi.merino@kernel.org
Cc:     linux-pm@vger.kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        "jeson.gao" <jeson.gao@unisoc.com>
References: <1606466112-31584-1-git-send-email-gao.yunxiao6@gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <724ddf78-483c-2cf3-441c-4885af8425a9@arm.com>
Date:   Fri, 27 Nov 2020 09:27:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1606466112-31584-1-git-send-email-gao.yunxiao6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/27/20 8:35 AM, gao.yunxiao6@gmail.com wrote:
> From: "jeson.gao" <jeson.gao@unisoc.com>
> 
> virtual thermal node definition description in dts file
> 
> Signed-off-by: jeson.gao <jeson.gao@unisoc.com>
> ---
>   .../thermal/sprd-virtual-thermal.yaml         | 38 +++++++++++++++++++
>   1 file changed, 38 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/thermal/sprd-virtual-thermal.yaml
> 
> diff --git a/Documentation/devicetree/bindings/thermal/sprd-virtual-thermal.yaml b/Documentation/devicetree/bindings/thermal/sprd-virtual-thermal.yaml
> new file mode 100644
> index 000000000000..3e3d2282e2a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sprd-virtual-thermal.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/sprd-virtual-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Spreadtrum virtual thermal driver bindings
> +
> +maintainers:
> +  - Yunxiao Gao <gao.yunxiao6@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: sprd,virtual-thermal
> +
> +  reg:
> +    description: specify the virtual sensor id.
> +    maxItems: 1
> +
> +  thmzone-names:
> +    description: specify per-core thermal zone name.
> +
> +required:
> +  - compatible
> +  - reg
> +  - thmzone-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    virtual_sensor: virtual-sensor@1 {
> +      compatible = "sprd,virtual-thermal";
> +      reg = <1>;
> +      thmzone-names = "ank0-thmzone","ank1-thmzone","ank2-thmzone",
> +                      "ank3-thmzone","ank4-thmzone","ank5-thmzone","prometheus6-tzone0",
> +                      "prometheus6-tzone1","prometheus7-thmzone";
> +    };
> 

It's coming back. There were attempts to solve this problem.
Javi tried to solved this using hierarchical thermal zones [1].
It was even agreed (IIRC during LPC) but couldn't continue. Then Eduardo
was going to continue this (last message at [3]). Unfortunately, 
development stopped.

I also have out-of-tree similar implementation for my Odroid-xu4,
which does no have an 'SoC' sensor, but have CPU sensors and needs
some aggregation function to get temperature.

I can pick up Javi's patches and continue 'hierarchical thermal zones'
approach.

Javi, Daniel, Rui what do you think?

Regards,
Lukasz

[1] https://lwn.net/Articles/666015/
[2] 
https://patchwork.kernel.org/project/linux-pm/patch/1448464186-26289-2-git-send-email-javi.merino@arm.com/
[3] 
https://patchwork.kernel.org/project/linux-pm/patch/1448464186-26289-3-git-send-email-javi.merino@arm.com/
[4] 
https://patchwork.kernel.org/project/linux-pm/patch/1448464186-26289-4-git-send-email-javi.merino@arm.com/
[5] 
https://patchwork.kernel.org/project/linux-pm/patch/1448464186-26289-5-git-send-email-javi.merino@arm.com/
