Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050C1250E83
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 04:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgHYCEb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 22:04:31 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42123 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgHYCEa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 22:04:30 -0400
Received: by mail-io1-f68.google.com with SMTP id g13so10881300ioo.9;
        Mon, 24 Aug 2020 19:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=blgkJC98PTiLtQ7EY6Ja7z8tjOvIr37IMYyL+0fqpwo=;
        b=WawycbwqP3wOhBa311N3fBUh7TapoyjOya12OO4DEeNUZWeNp3211IItQtO2LdoJZC
         D1r1/gg9+N3HmBIx3c9tVQhobxTl741GjDpr/yqtyiXthSK6Hc8lGNVN2C4qyHCTLA1l
         xYO7n2LW+af3KELTncRa987H7xul6lt41YRPgChsc1M/h7SRbatKNb3eTjYJ/7QMCKEw
         P2D5blaELV+sn+fr31CEcWTrJHMM5gcCFLfMYYljEjqCgovKmJwgpaffe7W8utoQamS5
         vA+zCgnW3I1cP3Lo6k/MA6IrdvWfpHBqQdzNLEl7sitbyeZ93vnOC6H/y0qz2wUIxBFg
         7blQ==
X-Gm-Message-State: AOAM5328Tj+egEC6CQMUAez6DjRa/QhZJ+T9bDdh9dk2YEvVJnT1YDNJ
        k8QkbRAfvNgZW17OEcO6Xg==
X-Google-Smtp-Source: ABdhPJyaaWTqX7Y2GueUjwPPkPW4DfUqOiYuBmQTQM2DxYEqy0LyZ3MAI8PjozuIA/FocPvW4hlGqw==
X-Received: by 2002:a6b:6204:: with SMTP id f4mr7200166iog.56.1598321068966;
        Mon, 24 Aug 2020 19:04:28 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id q19sm8336663ilj.85.2020.08.24.19.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:04:27 -0700 (PDT)
Received: (nullmailer pid 3780329 invoked by uid 1000);
        Tue, 25 Aug 2020 02:04:23 -0000
Date:   Mon, 24 Aug 2020 20:04:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v2 2/2] dt-bindings: cpufreq: add bindings for MediaTek
 cpufreq HW
Message-ID: <20200825020423.GA3775564@bogus>
References: <1597302475-15484-1-git-send-email-hector.yuan@mediatek.com>
 <1597302475-15484-3-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597302475-15484-3-git-send-email-hector.yuan@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 13, 2020 at 03:07:55PM +0800, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add devicetree bindings for MediaTek HW driver.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  .../bindings/cpufreq/cpufreq-mediatek-hw.yaml      |   61 ++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> new file mode 100644
> index 0000000..59bb24e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cpufreq/cpufreq-mediatek-hw.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek's CPUFREQ Bindings
> +
> +maintainers:
> +  - Hector Yuan <hector.yuan@mediatek.com>
> +
> +description:
> +  CPUFREQ HW is a hardware engine used by MediaTek
> +  SoCs to manage frequency in hardware. It is capable of controlling frequency
> +  for multiple clusters.
> +
> +properties:
> +  compatible:
> +    const: mediatek,cpufreq-hw
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    description: |
> +      Addresses and sizes for the memory of the HW bases in each frequency domain.
> +
> +  reg-names:
> +    items:
> +      - const: "freq-domain0"
> +      - const: "freq-domain1"

Not all that useful of a name given it's based on the index.

> +    description: |
> +      Frequency domain name.
> +
> +  "#freq-domain-cells":
> +    const: 1
> +    description: |
> +      Number of cells in a freqency domain specifier.

What's this for?

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - "#freq-domain-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        cpufreq_hw: cpufreq@11bc00 {
> +            compatible = "mediatek,cpufreq-hw";
> +            reg = <0 0x11bc10 0 0x8c>,
> +               <0 0x11bca0 0 0x8c>;
> +            reg-names = "freq-domain0", "freq-domain1";
> +            #freq-domain-cells = <1>;
> +        };
> +    };
> +
> -- 
> 1.7.9.5
