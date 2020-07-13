Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B145121DFD0
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 20:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgGMSgi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 14:36:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39883 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgGMSgi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 14:36:38 -0400
Received: by mail-io1-f67.google.com with SMTP id f23so14591977iof.6;
        Mon, 13 Jul 2020 11:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3UGvQbUMACoG6FusERtLEKApCKDY3BG4pPYGTvjSnXw=;
        b=fHbVqTSHyKL/KVHghVpu3yOYO8aKdWJ6rp+A6zpoW4AmC1moFy/lY7Ok+MAMthz+J4
         ZxJQTQu0xXF7KfI5jC8CENVy5Y7IATOzzacErWULkPECdUdikHSyYWjAf79TqhwqToov
         sgcET+DOsIB4ct6snUmkPHkotFB/Ska9tE5MsBp20bxldjYJMY+XWFX/qSigQ8hhZgj5
         WKdKq3sqwzLRGux5cL2cqHz7YjBuaaw8xQFrZRKkQd7af8yKGCpjNttaIcJ6/bP7ka4d
         74gny5Se3G9yKJ6a2O9xlkZWxMgn2aLUWRn70P9w3kVEgL2qezeENvR/1nXHxJ362r8a
         vCKA==
X-Gm-Message-State: AOAM533Ul5B7YpxiW2cLCP4hfls44nUEtN2pAbGHLoymN7W8JqT/ybXt
        azhDloSGytkRp3rolq6qnnyb+97KaQ==
X-Google-Smtp-Source: ABdhPJwlLcZvlXjaK0WV6RoZRmrbEb+BVeQEkO60kA5Qv+K6ncL582YMAzNgzE1tcPZhtZExKuKelQ==
X-Received: by 2002:a6b:2b17:: with SMTP id r23mr1161061ior.36.1594665397089;
        Mon, 13 Jul 2020 11:36:37 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y12sm5748560iot.49.2020.07.13.11.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 11:36:36 -0700 (PDT)
Received: (nullmailer pid 510535 invoked by uid 1000);
        Mon, 13 Jul 2020 18:36:35 -0000
Date:   Mon, 13 Jul 2020 12:36:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel =?iso-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>
Cc:     linux-pm@vger.kernel.org, sre@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: power: reset: add yaml bindings for
 LinkStation power off
Message-ID: <20200713183635.GA503416@bogus>
References: <2774047.62mrzoXREp@tool>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2774047.62mrzoXREp@tool>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 13, 2020 at 12:26:56PM +0200, Daniel González Cabanelas wrote:
> Add Linkstation poweroff bindings documentation. 
> 
> Signed-off-by: Daniel González Cabanelas <dgcbueu@gmail.com>
> ---
> Changes in v3:
>   - "phy-handle,intn" property deleted. Now autodetection used.
>   - Cosmetic changes
> Changes in v2:
>   - Changed the required properties and description to adjust to the new
>     driver now enabling the WoL feature on the device.
> 
>  .../power/reset/linkstation-poweroff.yaml     | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/linkstation-poweroff.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/linkstation-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/linkstation-poweroff.yaml
> new file mode 100644
> index 0000000000..8845333ca4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/linkstation-poweroff.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)

As I said before:

GPL-2.0-only

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/linkstation-poweroff.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Buffalo Linkstation poweroff Binding
> +
> +maintainers:
> +  - Daniel González Cabanelas <dgcbueu@gmail.com>
> +
> +description: |
> +  Some Buffalo LinkStations (ARM MVEBU boards) use an output pin at the ethernet
> +  PHY (LED2/INTn) to inform the board if the power off operation must be performed
> +  at restart time. This pin is ORed with the power switch and allows the WOL
> +  function to be also used.
> +
> +  When the power-off handler is called, the ethernet PHY INTn ouptut is set to
> +  LOW state. If the restart command is executed then the PHY INTn output is
> +  forced to HIGH state.
> +
> +properties:
> +  compatible:
> +    const: linkstation,power-off
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    poweroff {
> +        compatible = "linkstation,power-off";
> +    };

This is not what I was suggesting in the last version. You don't need a 
binding for this. Use the root node compatible string.

Your driver initcall needs to check the root compatible and create a 
platform device if it matches.

Rob
