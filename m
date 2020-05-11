Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977AE1CDEC2
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 17:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgEKPWe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 11:22:34 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40762 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgEKPWe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 11:22:34 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04BFMWVS026970;
        Mon, 11 May 2020 10:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589210552;
        bh=c2A2Z7mFBWQfoc2u8gxJWPjiTh6Whjhz3OnLPssiSVQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZDKvPlp4XTPW9HuB8aPMF6WJFtL+301BufiKjZ6bATKspoQpsVwGiq5yzSiWsg5Ql
         qX+cCv4IPrVlab5iwRPha3xXPjm3LDNuloYnetgaArUNTxXJD5Y+0S5izFN02/gfMW
         UrdmC/O8mc9i0gmoPxdGYZ/WlIYt5WhNGbxaMPAw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04BFMWtf022906
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 May 2020 10:22:32 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 11
 May 2020 10:22:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 11 May 2020 10:22:32 -0500
Received: from [10.250.38.163] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04BFMUX5039149;
        Mon, 11 May 2020 10:22:30 -0500
Subject: Re: [PATCH v2] dt-bindings: power: Convert bq27xxx dt to yaml
To:     Dan Murphy <dmurphy@ti.com>, <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
References: <20200507183013.27261-1-dmurphy@ti.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <a5eae705-672b-acef-8850-0811a6ea13fb@ti.com>
Date:   Mon, 11 May 2020 11:22:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507183013.27261-1-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/7/20 2:30 PM, Dan Murphy wrote:
> Convert the bq27xxx.txt to yaml format
> 
> CC: Pali Rohár <pali@kernel.org>
> CC: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../bindings/power/supply/bq27xxx.txt         | 56 ------------
>  .../bindings/power/supply/bq27xxx.yaml        | 86 +++++++++++++++++++
>  2 files changed, 86 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/supply/bq27xxx.txt
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> deleted file mode 100644
> index 4fa8e08df2b6..000000000000
> --- a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -TI BQ27XXX fuel gauge family
> -
> -Required properties:
> -- compatible: contains one of the following:
> - * "ti,bq27200" - BQ27200
> - * "ti,bq27210" - BQ27210
> - * "ti,bq27500" - deprecated, use revision specific property below
> - * "ti,bq27510" - deprecated, use revision specific property below
> - * "ti,bq27520" - deprecated, use revision specific property below
> - * "ti,bq27500-1" - BQ27500/1


This doesn't look right, these are two parts, we should be specific in
DT, so:

ti,bq27500
ti,bq27501

should be separate like that.

Andrew


> - * "ti,bq27510g1" - BQ27510-g1
> - * "ti,bq27510g2" - BQ27510-g2
> - * "ti,bq27510g3" - BQ27510-g3
> - * "ti,bq27520g1" - BQ27520-g1
> - * "ti,bq27520g2" - BQ27520-g2
> - * "ti,bq27520g3" - BQ27520-g3
> - * "ti,bq27520g4" - BQ27520-g4
> - * "ti,bq27521" - BQ27521
> - * "ti,bq27530" - BQ27530
> - * "ti,bq27531" - BQ27531
> - * "ti,bq27541" - BQ27541
> - * "ti,bq27542" - BQ27542
> - * "ti,bq27546" - BQ27546
> - * "ti,bq27742" - BQ27742
> - * "ti,bq27545" - BQ27545
> - * "ti,bq27411" - BQ27411
> - * "ti,bq27421" - BQ27421
> - * "ti,bq27425" - BQ27425
> - * "ti,bq27426" - BQ27426
> - * "ti,bq27441" - BQ27441
> - * "ti,bq27621" - BQ27621
> -- reg: integer, I2C address of the fuel gauge.
> -
> -Optional properties:
> -- monitored-battery: phandle of battery characteristics node
> -    The fuel gauge uses the following battery properties:
> -    + energy-full-design-microwatt-hours
> -    + charge-full-design-microamp-hours
> -    + voltage-min-design-microvolt
> -  Both or neither of the *-full-design-*-hours properties must be set.
> -  See Documentation/devicetree/bindings/power/supply/battery.txt
> -
> -Example:
> -
> -	bat: battery {
> -		compatible = "simple-battery";
> -		voltage-min-design-microvolt = <3200000>;
> -		energy-full-design-microwatt-hours = <5290000>;
> -		charge-full-design-microamp-hours = <1430000>;
> -	};
> -
> -	bq27510g3: fuel-gauge@55 {
> -		compatible = "ti,bq27510g3";
> -		reg = <0x55>;
> -		monitored-battery = <&bat>;
> -	};
> diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> new file mode 100644
> index 000000000000..54f497c291f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/power/supply/bq27xxx.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: TI BQ27XXX fuel gauge family
> +
> +maintainers:
> +  - Pali Rohár <pali@kernel.org>
> +  - Andrew F. Davis <afd@ti.com>
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +description: |
> +  Support various Texas Instruments fuel gauge devices that share similar
> +  register maps and power supply properties
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,bq27200 - BQ27200
> +      - ti,bq27210 - BQ27210
> +      - ti,bq27500 - deprecated, use revision specific property below
> +      - ti,bq27510 - deprecated, use revision specific property below
> +      - ti,bq27520 - deprecated, use revision specific property below
> +      - ti,bq27500-1 - BQ27500/1
> +      - ti,bq27510g1 - BQ27510-g1
> +      - ti,bq27510g2 - BQ27510-g2
> +      - ti,bq27510g3 - BQ27510-g3
> +      - ti,bq27520g1 - BQ27520-g1
> +      - ti,bq27520g2 - BQ27520-g2
> +      - ti,bq27520g3 - BQ27520-g3
> +      - ti,bq27520g4 - BQ27520-g4
> +      - ti,bq27521 - BQ27521
> +      - ti,bq27530 - BQ27530
> +      - ti,bq27531 - BQ27531
> +      - ti,bq27541 - BQ27541
> +      - ti,bq27542 - BQ27542
> +      - ti,bq27546 - BQ27546
> +      - ti,bq27742 - BQ27742
> +      - ti,bq27545 - BQ27545
> +      - ti,bq27411 - BQ27411
> +      - ti,bq27421 - BQ27421
> +      - ti,bq27425 - BQ27425
> +      - ti,bq27426 - BQ27426
> +      - ti,bq27441 - BQ27441
> +      - ti,bq27621 - BQ27621
> +
> +  reg:
> +    maxItems: 1
> +    description: integer, I2C address of the fuel gauge.
> +
> +  monitored-battery:
> +    description: |
> +       phandle of battery characteristics node.
> +       The fuel gauge uses the following battery properties:
> +       - energy-full-design-microwatt-hours
> +       - charge-full-design-microamp-hours
> +       - voltage-min-design-microvolt
> +       Both or neither of the *-full-design-*-hours properties must be set.
> +       See Documentation/devicetree/bindings/power/supply/battery.txt
> +
> +required:
> +  - compatible
> +  - reg
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      bat: battery {
> +        compatible = "simple-battery";
> +        voltage-min-design-microvolt = <3200000>;
> +        energy-full-design-microwatt-hours = <5290000>;
> +        charge-full-design-microamp-hours = <1430000>;
> +      };
> +
> +      bq27510g3: fuel-gauge@55 {
> +        compatible = "ti,bq27510g3";
> +        reg = <0x55>;
> +        monitored-battery = <&bat>;
> +      };
> +    };
> 
