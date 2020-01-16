Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0647A13F0B9
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 19:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392480AbgAPSXr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 13:23:47 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:48191 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436593AbgAPSXp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 13:23:45 -0500
Received: from [192.168.1.176] ([37.4.249.101]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N5G1T-1jbQrp2DRt-011Arw; Thu, 16 Jan 2020 19:23:24 +0100
Subject: Re: [PATCH V5 1/4] dt-bindings: Add Broadcom AVS RO thermal
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org
References: <1578941778-23321-1-git-send-email-stefan.wahren@i2se.com>
 <1578941778-23321-2-git-send-email-stefan.wahren@i2se.com>
 <CAL_Jsq+w0KGE-=XkAwpdqh67pH=V34ETCy8X92L_u1=_8xuKCg@mail.gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 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 AQ==
Message-ID: <ca02714a-538e-3057-3fc6-70fb453b411c@i2se.com>
Date:   Thu, 16 Jan 2020 19:23:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+w0KGE-=XkAwpdqh67pH=V34ETCy8X92L_u1=_8xuKCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:9Vjz6FFurzI9PFAe4jG8EbOWh/kFLMdLh4diVZ9YcuDZWiR/lQp
 cLeVq5Kw9rn6HSENvz62R+cKi9K5rRo7dXKY0PvBHlUmO+mKa6MJDrHIWiMZo9xeyDtY815
 ueHWz9DCmP2Plt4VQLBgrC2cbwVVljKvh2fmb0jlfnMgw6Brsv4jlyUrtfU4IvuIwYjE1YL
 sW6FtJXPQ0XPg2jcfXtUw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:J4hVp3gooWA=:/holuA9SH0TcrEUOsjYe3v
 CI7/F7YCDkSMr1MiM81G0o6cxfw47kfS/wGz2if3jyPMVaNggWpwZWSPiLSnqK5pTE04tEqXK
 0dTwHMll3onWKw6yPl/5nXMre5ailVWjKOR/uNPTTXB+hWa8H3ocMUUpuMSAa2Vd8h/0rkdb9
 ohLtdvsOulDSYS+VQV+aOFb7UDTPxa2uGvu7110lWkGuEaiIjjZ3Dtq5NJf35Jal76pO32L5y
 0wWtjKvrgReeJtj1cFol25prc07OJ02BPfW1lHLkut4TwD3hNdG2XAqbHwJgcl3aBtrJ3vDxE
 91lg44nZcGAtTIIUIbpi+QUCiwE8JhZxPpwrUZqh+KMjj79qurW4/FgaBdpXkVQcZQsRDTAyi
 iZ3FZL2XIP9T3+hMCq7bFNWaB3DM3stLeerT9ruFdVzNddMaT4U59gltFo6Nfd2lVz+S3Z8bn
 vg3VP03OzpYHTBaTdba1DsLRmu/2CxSNaZba23DgWU0xPYAgIvPHQE/oxPy7D3zn1n03oBJdv
 9VLeKiF77PYiGs/J+8xZxFrBYQWmbFCWJZx2jbOeS8TsXC5YWuZAc1IpExiClNBN3yHeRfNnB
 5rkTAmUu+mGKNeyyewXszQjZC6zzq3QZ2w6hyM+pru1g1OECtbMCOEsVnGFsi0Qd6GPPAbwlQ
 NXg/BXpaGCLrk9vNWfIdniCTS+n+eBxTbgIsuuP2EIPkGRFwbw89mBwuozkoJEkRQkV2xezYk
 RwG6Ji54AbpdR8NnhnwDgRV7jTofv1qLGtPJJJDsa10+eaJAipaAooFYU/AjDVvIJPcw+eFe3
 +PD+rZM/YX2XjwkQpSp1N14zAJ9j+ILHvGrgj++m4r4rUUIi1dUQmZUyCWq/iUnM2K0hn3573
 oAbeV7iBgEc4hc8n1y+BYqzY9pFzCcyhEInfdQbf8=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

Am 16.01.20 um 18:33 schrieb Rob Herring:
> On Mon, Jan 13, 2020 at 12:56 PM Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> Since the BCM2711 doesn't have a AVS TMON block, the thermal information
>> must be retrieved from the AVS ring oscillator block. This block is part
>> of the AVS monitor which contains a bunch of raw sensors.
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>> ---
>>  .../bindings/thermal/brcm,avs-ro-thermal.yaml      | 45 ++++++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
> The example fails 'make dt_binding_check':
>
> /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.example.dt.yaml:
> thermal: 'reg' is a required property

can you please explain what is the reason for this? The example below
has a reg property. I'm confused.

Best regards
Stefan

>
>> diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
>> new file mode 100644
>> index 0000000..98e7b57
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
>> @@ -0,0 +1,45 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/thermal/brcm,avs-ro-thermal.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Broadcom AVS ring oscillator thermal
>> +
>> +maintainers:
>> +  - Stefan Wahren <wahrenst@gmx.net>
>> +
>> +description: |+
>> +  The thermal node should be the child of a syscon node with the
>> +  required property:
>> +
>> +  - compatible: Should be one of the following:
>> +                "brcm,bcm2711-avs-monitor", "syscon", "simple-mfd"
>> +
>> +  Refer to the the bindings described in
>> +  Documentation/devicetree/bindings/mfd/syscon.txt
>> +
>> +properties:
>> +  compatible:
>> +    const: brcm,bcm2711-thermal
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +examples:
>> +  - |
>> +        avs-monitor@7d5d2000 {
>> +                compatible = "brcm,bcm2711-avs-monitor",
>> +                             "syscon", "simple-mfd";
>> +                reg = <0x7d5d2000 0xf00>;
>> +
>> +                thermal: thermal {
>> +                        compatible = "brcm,bcm2711-thermal";
>> +                        #thermal-sensor-cells = <0>;
> Also this is not documented. That's not caught because
> 'additionalProperties: false' is also needed.
>
> Rob
