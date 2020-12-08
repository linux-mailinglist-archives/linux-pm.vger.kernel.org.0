Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41532D2B9E
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 14:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgLHNHL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 08:07:11 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:8240 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgLHNHL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 08:07:11 -0500
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Dec 2020 08:07:09 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607432658;
        s=strato-dkim-0002; d=fossekall.de;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:From:
        Subject:Sender;
        bh=R9pAmrtgxzHV8b9qyJZRtWA5+8mvD2n+XnerwI88DtE=;
        b=mpBQqsCRqqRRPQtBz98b+wGCTmuTp2Sck3rby//y8k4+0YpjPLLiBs30OZghtKRxfz
        Z50xtJllN33oemNVSimnckmOfkCeTPyvN5WWhd0n8znaed54oIHto0zXc5f5JhU82taN
        R8cSHqwQ1yuntYOq1UJExR/NHdqG8I/4iReW1xLfcfiDTurFZOCZT+EFHQY1yM2DBzTn
        eZgYwRJTEgqKLTCQ8WSIxI34hHcQzVcZuaSUGL4lZZ9q+8b8AIhXtlNNQq2wpY92BF6u
        eBOlHfz9SJXLymgDe88CbhbSfvtoCgRmYfN4LxdJoqyEhH6FECd0J1+dB0eUuCFjVht1
        rGpQ==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.6.2 AUTH)
        with ESMTPSA id e07b38wB8CqG20m
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Tue, 8 Dec 2020 13:52:16 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <michael@fossekall.de>)
        id 1kmcTX-0006UW-Jg; Tue, 08 Dec 2020 13:52:15 +0100
Date:   Tue, 8 Dec 2020 13:52:14 +0100
From:   Michael Klein <michael@fossekall.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] Documentation: DT: binding documentation for
 regulator-poweroff
Message-ID: <20201208125214.GA2785@a98shuttle.de>
References: <20201128103958.q6glewhhch7vtczr@gilmour>
 <20201207142756.17819-1-michael@fossekall.de>
 <20201207142756.17819-3-michael@fossekall.de>
 <20201208101358.mwxmlgqonmunb2m2@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201208101358.mwxmlgqonmunb2m2@gilmour>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks for reviewing!

On Tue, Dec 08, 2020 at 11:13:58AM +0100, Maxime Ripard wrote:
>On Mon, Dec 07, 2020 at 03:27:55PM +0100, Michael Klein wrote:
>> Add devicetree binding documentation for regulator-poweroff driver.
>>
>> Signed-off-by: Michael Klein <michael@fossekall.de>
>> ---
>>  .../power/reset/regulator-poweroff.yaml       | 53 +++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml
>> new file mode 100644
>> index 000000000000..8c8ce6bb031a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml
>> @@ -0,0 +1,53 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/reset/regulator-poweroff.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Force-disable power regulators to turn the power off.
>> +
>> +maintainers:
>> +  - Michael Klein <michael@fossekall.de>
>> +
>> +description: |
>> +  When the power-off handler is called, one more regulators are disabled
>> +  by calling regulator_force_disable(). If the power is still on and the
>> +  CPU still running after a 3000ms delay, a WARN_ON(1) is emitted.
>> +
>> +properties:
>> +  compatible:
>> +    const: "regulator-poweroff"
>> +
>> +  regulator-names:
>> +    description:
>> +      Array of regulator names
>> +    $ref: /schemas/types.yaml#/definitions/string-array
>> +
>> +  REGULATOR-supply:
>
>This should be a patternProperties
>
>> +    description:
>> +      For any REGULATOR listed in regulator-names, a phandle
>> +      to the corresponding regulator node
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  timeout-ms:
>> +    description:
>> +      Time to wait before asserting a WARN_ON(1). If nothing is
>> +      specified, 3000 ms is used.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +required:
>> +  - compatible
>> +  - regulator-names
>> +  - REGULATOR-supply
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    regulator-poweroff {
>> +        compatible = "regulator-poweroff";
>> +        regulator-names = "vcc1v2", "vcc-dram";
>> +        vcc1v2-supply = <&reg_vcc1v2>;
>> +        vcc-dram-supply = <&reg_vcc_dram>;
>> +    };
>
>I'm not entirely sure how multiple regulators would work here. I guess
>the ordering is board/purpose sensitive. In this particular case, I
>assume that vcc1v2 would be shut down before vcc-dram?

yes, the regulators are shut down from left to right.

>If so, I would expect that one regulator_force_disable is run, the CPU
>is disabled and you never get the chance to cut vcc-dram.

I assume that any relevant regulator here has enough capacitance on the 
output that provides enough charge to disable any remaining regulators 
(my board has 3*10µF for vcc1v2 and 1*10µF for vcc-dram). But there is 
of course no guarantee, so I'm shutting down the most relevant (in terms 
of current consumption) regulator first.

In any case, if it's deemed unnecessary to allow more than one regulator 
in the driver I could remove the regulator-names property altogether and 
reduce the DT node to:

   regulator-poweroff {
       compatible = "regulator-poweroff";
       poweroff-supply = <&reg_vcc1v2>;
   };

-- 
Michael
