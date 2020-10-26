Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64639298FAF
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 15:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781854AbgJZOnf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 10:43:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43277 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781707AbgJZOnf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 10:43:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id k68so8168606otk.10;
        Mon, 26 Oct 2020 07:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=74NpB+ncVlKrP7/+pX9mfTv3pJwYCtaEYPifAGAuZRY=;
        b=B6ayycrH2ATm/0nZyT3ybTYmuEATru6DbStAG5BKNbvt1YR23TVHnHCbWXKe+1rMmL
         oYhGJueD3HErfl3+ev9FZ8IP5Sacpi2s/JDCn/4xcmEqySgCzkWVureOfDJHW3j3TL+2
         4DSHRtwtfejjGJfvNFMWb8Fwdy1geu7OTAXtc5l++BRax7FT3YAV7laUE2YRa6iLRm5I
         KM4medqgSU052XhtYZGKoTpesC8jyJFZuTqUpZdk4jcoChp3QZcNwTeEWywuBXqjRsRA
         5snQJS9+U5VpzjH0yIo+yhjoPHl3RTTnv++kOQwTJDjp89vFKBBemFs6md8Y3YqIw88r
         ytbw==
X-Gm-Message-State: AOAM532WRY6a3qS1gkqjDVjZ+J1Xhn338c3iZMzjKy85Z7j4leHNQFQy
        drVJrRAUA46iGdjHUezx9A==
X-Google-Smtp-Source: ABdhPJx643e6YSFwa4eCq3ms+ySX5scLZkDbbeGgbNa2FyFZkP+aHr03EKWv7YizneEFuNm4nPoewg==
X-Received: by 2002:a05:6830:1308:: with SMTP id p8mr3168163otq.330.1603723412700;
        Mon, 26 Oct 2020 07:43:32 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k64sm4066920oif.43.2020.10.26.07.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 07:43:32 -0700 (PDT)
Received: (nullmailer pid 130337 invoked by uid 1000);
        Mon, 26 Oct 2020 14:43:31 -0000
Date:   Mon, 26 Oct 2020 09:43:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     sre@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power/supply: Add ltc4162-l-charger
Message-ID: <20201026144331.GA123160@bogus>
References: <20201021141030.27751-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201021141030.27751-1-mike.looijmans@topic.nl>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 21, 2020 at 04:10:30PM +0200, Mike Looijmans wrote:
> Add support for the LTC4162-L Li-Ion battery charger. The driver allows
> reading back telemetry and to set some charging options like the input
> current limit.
> 
> This adds the devicetree bindings.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>  .../bindings/power/supply/ltc4162-l.yaml      | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> new file mode 100644
> index 000000000000..a23dd6f3fae0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2020 Topic Embedded Products
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/supply/ltc4162-l.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Linear Technology (Analog Devices) LTC4162-L Charger
> +
> +maintainers:
> +  - Mike Looijmans <mike.looijmans@topic.nl>
> +
> +description: |
> +  The LTC ® 4162-L is an advanced monolithic synchronous step-down switching
> +  battery charger and PowerPath (TM) manager that seamlessly manages power
> +  distribution between input sources such as wall adapters, backplanes, solar
> +  panels, etc., and a rechargeable Lithium-Ion/Polymer battery.
> +
> +  Specifications about the charger can be found at:
> +    https://www.analog.com/en/products/ltc4162-s.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - lltc,ltc4162-l
> +
> +  reg:
> +    maxItems: 1
> +    description: I2C address of the charger.
> +
> +  lltc,rsnsb:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Battery sense resistor in milli Ohm.
> +    minimum: 1
> +
> +  lltc,rsnsi:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Input current sense resistor in milli Ohm.
> +    minimum: 1

These should have a unit suffix as defined in property-units.txt. 
There's not one for milli Ohms, does micro Ohms give you enough range? 
If not, you can add it though that's discouraged simply so that we don't 
have differring units in each binding for the same thing.

Rob
