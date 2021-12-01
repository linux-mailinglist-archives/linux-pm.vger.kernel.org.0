Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51085465ABD
	for <lists+linux-pm@lfdr.de>; Thu,  2 Dec 2021 01:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244225AbhLBA04 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 19:26:56 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:37396 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354459AbhLBA0A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Dec 2021 19:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638404558; x=1669940558;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dnRwlM2g208wpzcQ1fHoMh5ABTusv5pFo5cTKx90whg=;
  b=kncdNOxYf208rZVjZrcZg30qfZKMFiEZv/74daCnx8/yXDiXpyYFuqrS
   huHp1zfQneudO79BLpDrQNEAKFbZO5fneZT5Zmb4P3+Dn7/3MClL/97/Q
   5NbjuLuipqQF2jVM75WkWJFNNsv0N+cnV+d5AQLsHKJNxphqjxdbv9Ftz
   f/SkE8AA81kPEGAHuu4EEy5+2cqabiWxUb92Ziw5bgmayDUTHTFxrBcH6
   pP+BFiKPnPk6DD0g1pXVLk/uoyaSb+vetEW3yMFdeiNqAmrwGt0rBVslo
   GVJMCfPkrfVtQLYiNhl/lpK5smauJfTq1ILmV8YfeqKsXd2H+KBPoVwKB
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,280,1631548800"; 
   d="scan'208";a="291192492"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2021 08:11:51 +0800
IronPort-SDR: ZHEwQSl4PePNCIY/hOl2cKuzPkmQ6ehHumgcBxoxi3XK8nQ7YUzWHDzV72H8IOmSlxBbWYu6Pi
 HtvrC9kAi01aaVBRBNgJHGIC+kCaanKgAEu+K0tKhLV2tMZonUIK8DqqQVjvz5UzLD7zwbNugc
 qWszMp8lbVETNUFSSKt+aPAuSF+qQKPbgheVxg/RpNUFAiy/GNltc+4WWjgiAl/7QxT5+M2kr4
 XCYgTj5c1bEGjd4nmmDvSPU/r5uumJHzUrUSA4YW3V6MFXEPkGEnFT4JKHVPn4tFi+g8ZQaIl0
 TMcJaHsTu1gY3vh5YFQj0TMC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 15:46:34 -0800
IronPort-SDR: PgLlZ0Aag+aDCJ+wa6iot+CAR9E2yBmUSR+MU5J6TPONNcqrR6/H4oB02qX2PrZv/XD41LJp7S
 DdaLeF8eayyHp2aK/9y+G9lQoXK0z5gi1xWdLoHWSba5pHsfKZ1V7/AVjk6W2TmHihzRGp0Kn3
 RxS42Ek7vzBXGXvaFWoUdoTCaxROiJXIOPPylGkOSvciBgDEHE1wCPEwUavbS5rqjiZS0cEv74
 wRmO76xa42wEX1VLMrSSwvsmINFWbYQCZ8FFlydPzNkHGH779ApfPD+AZzxT9YvD+n0g0jAKH8
 h18=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 16:11:50 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J4GHn3XNdz1RtVn
        for <linux-pm@vger.kernel.org>; Wed,  1 Dec 2021 15:58:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1638403091; x=1640995092; bh=dnRwlM2g208wpzcQ1fHoMh5ABTusv5pFo5c
        TKx90whg=; b=Smg8tZ+TvJgoqFK7osdFry7pC21BK7S3yr15mJQjwB/VT9nSMYr
        7iIvDU9l8vFruHz8R0A0SVuly46XttI5hP7+kfC5nbW0dAzvHaZXyz4ZDsmfd3qB
        D0Ph8lgqh06/wHt+lro2VpDTfjRFCGMvRHXyhklU38zB6iPfugAApaDMw29xaH6x
        Pocm/LRy1wZ1rAlLDlzn9u7axyibnyRJDEalhSezz+2Wqhp77ULG7HlRPACEG+Q7
        fSVIANXzSmOc7Dv7ZW8aIyMLJPlNNQjybxvXCKMmPtm/7CIV298EqCCQ+BEWWo6h
        LcJe0ZNh1pNmkNb9fwaGI9bsqmnIs91czqw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UN94xf4UbPXx for <linux-pm@vger.kernel.org>;
        Wed,  1 Dec 2021 15:58:11 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J4GHc4pQzz1RtVl;
        Wed,  1 Dec 2021 15:58:04 -0800 (PST)
Message-ID: <0cbaad0b-bab0-177e-48ef-5c4f6dd4391a@opensource.wdc.com>
Date:   Thu, 2 Dec 2021 08:58:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 12/14] dt-bindings: ata: Convert Broadcom SATA to YAML
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>
References: <20211201205110.41656-1-f.fainelli@gmail.com>
 <20211201205110.41656-13-f.fainelli@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211201205110.41656-13-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021/12/02 5:51, Florian Fainelli wrote:
> Convert the Broadcom SATA3 AHCI controller Device Tree binding to YAML
> to help with validation.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/ata/brcm,sata-brcm.txt           | 45 ---------
>  .../bindings/ata/brcm,sata-brcm.yaml          | 91 +++++++++++++++++++
>  2 files changed, 91 insertions(+), 45 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
> deleted file mode 100644
> index b9ae4ce4a0a0..000000000000
> --- a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -* Broadcom SATA3 AHCI Controller
> -
> -SATA nodes are defined to describe on-chip Serial ATA controllers.
> -Each SATA controller should have its own node.
> -
> -Required properties:
> -- compatible         : should be one or more of
> -			"brcm,bcm7216-ahci"
> -			"brcm,bcm7425-ahci"
> -			"brcm,bcm7445-ahci"
> -			"brcm,bcm-nsp-ahci"
> -			"brcm,sata3-ahci"
> -			"brcm,bcm63138-ahci"
> -- reg                : register mappings for AHCI and SATA_TOP_CTRL
> -- reg-names          : "ahci" and "top-ctrl"
> -- interrupts         : interrupt mapping for SATA IRQ
> -
> -Optional properties:
> -
> -- reset: for "brcm,bcm7216-ahci" must be a valid reset phandle
> -  pointing to the RESCAL reset controller provider node.
> -- reset-names: for "brcm,bcm7216-ahci", must be "rescal".
> -
> -Also see ahci-platform.txt.
> -
> -Example:
> -
> -	sata@f045a000 {
> -		compatible = "brcm,bcm7445-ahci", "brcm,sata3-ahci";
> -		reg = <0xf045a000 0xa9c>, <0xf0458040 0x24>;
> -		reg-names = "ahci", "top-ctrl";
> -		interrupts = <0 30 0>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		sata0: sata-port@0 {
> -			reg = <0>;
> -			phys = <&sata_phy 0>;
> -		};
> -
> -		sata1: sata-port@1 {
> -			reg = <1>;
> -			phys = <&sata_phy 1>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
> new file mode 100644
> index 000000000000..4098d56872ae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/brcm,sata-brcm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom SATA3 AHCI Controller
> +
> +description:
> +  SATA nodes are defined to describe on-chip Serial ATA controllers.
> +  Each SATA controller should have its own node.
> +
> +maintainers:
> +  - Florian Fainelli <f.fainelli@gmail.com>
> +
> +allOf:
> +  - $ref: sata-common.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - brcm,bcm7216-ahci
> +          - const: brcm,sata3-ahci
> +      - items:
> +          - enum:
> +              - brcm,bcm7445-ahci
> +          - const: brcm,sata3-ahci
> +      - items:
> +          - enum:
> +              - brcm,bcm7425-ahci
> +          - const: brcm,sata3-ahci
> +      - items:
> +          - const: brcm,bcm-nsp-ahci
> +      - items:
> +          - const: brcm,bcm63138-ahci
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: ahci
> +      - const: top-ctrl
> +
> +  interrupts: true
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - brcm,bcm7216-ahci
> +then:
> +  properties:
> +    resets: true
> +    reset-names:
> +      items:
> +        - const: rescal
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sata@f045a000 {
> +        compatible = "brcm,bcm7445-ahci", "brcm,sata3-ahci";
> +        reg = <0xf045a000 0xa9c>, <0xf0458040 0x24>;
> +        reg-names = "ahci", "top-ctrl";
> +        interrupts = <0 30 0>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        sata0: sata-port@0 {
> +            reg = <0>;
> +            phys = <&sata_phy 0>;
> +        };
> +
> +        sata1: sata-port@1 {
> +            reg = <1>;
> +            phys = <&sata_phy 1>;
> +        };
> +    };
> 

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Rob,

Will take this through your tree ?

-- 
Damien Le Moal
Western Digital Research
