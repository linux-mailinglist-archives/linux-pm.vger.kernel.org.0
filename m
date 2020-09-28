Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D305527B418
	for <lists+linux-pm@lfdr.de>; Mon, 28 Sep 2020 20:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgI1SIn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Sep 2020 14:08:43 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38343 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgI1SIn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2020 14:08:43 -0400
Received: by mail-oi1-f195.google.com with SMTP id 26so2345077ois.5;
        Mon, 28 Sep 2020 11:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9gjZpAUg+lukgwa91PU9QLyJNWUzL1GmQgOGvCZaNJM=;
        b=ErTxKopLoyr0gbUw81gEhL1Nf+vHnbXLr/Vn5Tc73WR/3rhsy6J+FqwvzBVdwtdR9D
         QNOxAKMliSdsveUZDkBnIAEKzqFy2hU/75m19TPeycKOZczQnFYWVmFSU2KVN1edsk/d
         L6kScfQR3gvtCiaaEBQDXoiWHbr38bxlKAWqdJymcaf6vsOWGDcfF4y8IgV3roNmEikM
         QDTIj/HMk1zu0mN5CM2FqFaWqOwLq9sxzPFI+3j4sjPA6e6Fe484eO+QsTyANiy46PYg
         Kz8+u9QvweHtlmT9+3KEAXEe2rv0ve5YRDBKx/Tg0o2ck44LSfKT18R8oMaSccvEQSJs
         NvLw==
X-Gm-Message-State: AOAM530+uAUROMMeeZA8x7/ziut9N+txT88WxaiK9kzLSGruPHX87q2Q
        oJ/e2wsopsHbn7KlP1fdZQ==
X-Google-Smtp-Source: ABdhPJwrBgZVNmjaPU0ab1HL1HHJf7wpcsCzOpm8Ng+xGeo2goi7bNL4LamFeo621mttXG4W4wksCA==
X-Received: by 2002:aca:ed0a:: with SMTP id l10mr74873oih.9.1601316520952;
        Mon, 28 Sep 2020 11:08:40 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m11sm2227019ooe.43.2020.09.28.11.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 11:08:40 -0700 (PDT)
Received: (nullmailer pid 3005882 invoked by uid 1000);
        Mon, 28 Sep 2020 18:08:39 -0000
Date:   Mon, 28 Sep 2020 13:08:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: devfreq: Document L2 Krait CPU Cache
 devfreq driver
Message-ID: <20200928180839.GB2999374@bogus>
References: <20200927160515.6480-1-ansuelsmth@gmail.com>
 <20200927160515.6480-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927160515.6480-2-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Sep 27, 2020 at 06:05:13PM +0200, Ansuel Smith wrote:
> Document dedicated L2 Krait CPU Cache devfreq scaling driver.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/devfreq/krait-cache-devfreq.yaml | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/krait-cache-devfreq.yaml
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/krait-cache-devfreq.yaml b/Documentation/devicetree/bindings/devfreq/krait-cache-devfreq.yaml
> new file mode 100644
> index 000000000000..099ed978e022
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/krait-cache-devfreq.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cpufreq/krait-cache-devfreq.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DEVFREQ driver for Krait L2 Cpu Cache Frequency Scaling

Bindings are for h/w devices, not collections of properties for some 
driver. Define a binding for L2 cache and add on to it what you need.

> +
> +maintainers:
> +  - Ansuel Smith <ansuelsmth@gmail.com>
> +
> +description: |
> +  This Scale the Krait CPU L2 Cache Frequency and optionally voltage
> +  when the Cpu Frequency is changed (using the cpufreq notifier).
> +
> +  Cache is scaled with the max frequency across all core and the cache
> +  frequency will scale based on the configured threshold in the dts.
> +
> +  The cache thresholds can be set to 3+ frequency bin, idle, nominal and
> +  high.
> +
> +properties:
> +  compatible:
> +    const: qcom,krait-cache
> +
> +  clocks:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"

'clocks' already has a type defined. You just need how many and what 
each entry is.

> +    description: Phandle to the L2 CPU clock
> +
> +  clock-names:
> +    const: "l2"
> +
> +  voltage-tolerance:
> +    description: Same voltage tolerance of the Krait CPU

Needs a vendor prefix and unit suffix.

> +
> +  l2-cpufreq:
> +    description: |
> +      Threshold used by the driver to scale the L2 cache.
> +      If the max CPU Frequency is more than the set frequency,
> +      the driver will transition to the next frequency bin.
> +      Value is in kHz
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 3
> +    items:
> +      - description: idle
> +      - description: nominal
> +      - description: high
> +
> +  l2-supply:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    description: Phandle to the L2 regulator supply.
> +
> +  opp-table: true
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - voltage-tolerance
> +  - l2-cpufreq
> +
> +examples:
> +  - |
> +    qcom-krait-cache {
> +      compatible = "qcom,krait-cache";
> +      clocks = <&kraitcc 4>;
> +      clock-names = "l2";
> +      l2-cpufreq = <384000 600000 1200000>;
> +      l2-supply = <&smb208_s1a>;
> +
> +      operating-points = <

Not documented and generally deprecated.

> +        /* kHz    uV */
> +        384000  1100000
> +        1000000  1100000
> +        1200000  1150000
> +      >;
> +    };
> -- 
> 2.27.0
> 
