Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F5C1F7EB8
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jun 2020 00:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgFLWHB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Jun 2020 18:07:01 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44206 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLWHB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jun 2020 18:07:01 -0400
Received: by mail-io1-f67.google.com with SMTP id p20so11815045iop.11;
        Fri, 12 Jun 2020 15:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AFTBDnDYy+M7RhfFn//fyAlUc4RiakiijMDm4TTAat4=;
        b=GN5XDZK6PWJURh3mJ1fZM3YPJrD9hgWZn39QTRB7s+MS7qNM4lJI4/Sc1vqqcf2M6v
         OOem0khBOwp1a8C2rXzrCRL9DNb2LI1X2mBLdSivdhFuTe/fTXPkA//YDHcjpo+7lq6p
         7KLkfnz8SFK1uQI1Uk/zK+05+x2Xd5pIdU07ObZp0wZ6LmS/zab0evnpUVojVdS+eKTi
         D98daJmW5a3U2kYT/nmlH/ckIumoFXTgqQok0FBz/Qmu1wgjGzLog9i+apbb5adgMnac
         MBdYj9ugKq8Vap0BGg756jTruIi7poEmvXofRAd26vI5FlyGUGr/073/cOr3+GoDAt82
         X7Rg==
X-Gm-Message-State: AOAM530RvYQfEWrz30t5LuOukwaOSPF16TR8eiq2TPRHozUNgHj1UJRK
        6VYJxt7j8fNti7BHOhxs8g==
X-Google-Smtp-Source: ABdhPJw7l3FBkxqdICIq95CjK0SeG1RmP/x/92/27ZBszGzLCWTWKwfrnVt8vk5s0XIyr3PZ52fAPg==
X-Received: by 2002:a02:cc56:: with SMTP id i22mr10163617jaq.31.1591999620332;
        Fri, 12 Jun 2020 15:07:00 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id a2sm3652028iln.38.2020.06.12.15.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 15:06:59 -0700 (PDT)
Received: (nullmailer pid 3897847 invoked by uid 1000);
        Fri, 12 Jun 2020 22:06:58 -0000
Date:   Fri, 12 Jun 2020 16:06:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel =?iso-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>
Cc:     linux-pm@vger.kernel.org, sre@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] dt-bindings: power: reset: add yaml bindings for
 LinkStation power off
Message-ID: <20200612220658.GB3888887@bogus>
References: <2886932.VqVLtP53aq@tool>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2886932.VqVLtP53aq@tool>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 11, 2020 at 10:29:22PM +0200, Daniel González Cabanelas wrote:
> Add Linkstation poweroff bindings documentation. 
> 
> Signed-off-by: Daniel González Cabanelas <dgcbueu@gmail.com>
> ---
> Changes in v2:
>   - Changed the required properties and description to adjust to the new
>     driver now enabling the WoL feature on the device.
> 
>  .../power/reset/linkstation-poweroff.yaml     | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/linkstation-poweroff.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/linkstation-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/linkstation-poweroff.yaml
> new file mode 100644
> index 0000000000..475eab8225
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/linkstation-poweroff.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/linkstation-poweroff.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Buffalo Linkstation poweroff driver

This is a binding for h/w, not a driver.

> +
> +maintainers:
> +  - Daniel González Cabanelas <dgcbueu@gmail.com>
> +
> +description: |
> +  This driver is used to add the power off function to some Buffalo
> +  LinkStations (ARM MVEBU boards). They use an output pin at the ethernet PHY
> +  (LED2/INTn) to inform the board if the power off operation must be performed
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
> +  phy-handle,intn:

'phy-handle' is not a vendor.

> +    description: Phandle to a node of the ethernet PHY used for the power
> +      function.
> +    $ref: /schemas/types.yaml#/definitions/phandle

Is there more than 1 ethernet phy? If not, then I don't see why you need 
this binding at all. Use the top level compatible and find the ethernet 
phy in the tree.

> +
> +required:
> +  - compatible
> +  - phy-handle,intn
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    poweroff {
> +        compatible = "linkstation,power-off";
> +        phy-handle,intn = <&ethphy0>;
> +    };
> -- 
> 2.27.0
> 
> 
> 
> 
