Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 126E01034B
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 01:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfD3X3B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 19:29:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43590 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfD3X3B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 19:29:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id e67so7813261pfe.10;
        Tue, 30 Apr 2019 16:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pyMMSM+fgLxcULxr3o3ubN2tbBmzJbfDcFZgE1qRVpM=;
        b=pK5kLEoN76oBaCrVQaxWTbbivV84cg7cfUG/G8dHO9NvOFRYJiM5FTnMLEKOf3jIrB
         EAIYIOwKT8cpzIzUvx8mZtPxWcKL4g0DpruOl1fo8bv3mUeZZivLSj20e4DBUiFRyiK6
         Vh9/fkx78iy/iCpSx1EeXfNqGNgHMKBhnlPgXxyz1JUGX+ckmea3Ln1y4BTcGq0Tw3Kw
         E0eJWK+rhh8KJf5ScvMpAsTaaY1bOSXn901djE5EXUBUmHHIgJ5LxvXDBkginF2z7Nmj
         53XBeIWbI7/p4OGS3n13VkUyyHhJDeV//Mg7L3zOKxtN6baB+1x4RpmU7gcNpTiwE6R4
         muTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pyMMSM+fgLxcULxr3o3ubN2tbBmzJbfDcFZgE1qRVpM=;
        b=ki8g1w3uASYVYxhbpKwRhk6fV3v0RWA9t7dRMgiNk5p0Bbe8lyg3jtvoHezrde7PZV
         y0zoituy96LhzkWI8AGuWylINex+e2s2+hx4SdWZ/HMAfa7CZgv/ikYScvWcI2FW5u+q
         q5lUCqZBIuqemuchnyCcCG5ZMRvnSqkq4zEP7WKJkgMk/FEJBts6IIVwOxU+Io2obcI8
         Yz43cuoK15PUuj8UeVSeChNW17hHhwRTdvqjQC+OHKGY5mNiWExjfh77fMFMPkQR/lB4
         a+J5skcs4e3l7K8mH13YV5pO3nH+BVk/iHJNIT104MoVaJp0meVkYVsOnhdhAwk19m9I
         mGBw==
X-Gm-Message-State: APjAAAVSiqlVzzwc4lyzoG03rCaVto4Wh6bFaucSC2TK/idVbxZwdtBs
        1giBbMQvJ4PbT6IcPT82DE1u9nwY
X-Google-Smtp-Source: APXvYqx7y6GOjqZLNyaIYGc+H3Attof7wOD6qPcJ54YeQp4/Jzyu1VslMgO7P2qeteEZd8aJu3vmTg==
X-Received: by 2002:a62:2587:: with SMTP id l129mr35576226pfl.151.1556666939953;
        Tue, 30 Apr 2019 16:28:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g32sm2635151pgl.16.2019.04.30.16.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 16:28:58 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] dt-bindings: power: supply: Add bindings for
 Microchip UCS1002
To:     Rob Herring <robh@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-pm@vger.kernel.org,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20190430064557.28469-1-andrew.smirnov@gmail.com>
 <20190430064557.28469-4-andrew.smirnov@gmail.com>
 <20190430161542.GB731@roeck-us.net> <20190430223236.GA10236@bogus>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8e4fa5ae-9547-83b3-d2f6-3a7b7ad32cbf@roeck-us.net>
Date:   Tue, 30 Apr 2019 16:28:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430223236.GA10236@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/30/19 3:32 PM, Rob Herring wrote:
> On Tue, Apr 30, 2019 at 09:15:42AM -0700, Guenter Roeck wrote:
>> On Mon, Apr 29, 2019 at 11:45:57PM -0700, Andrey Smirnov wrote:
>>> Add bindings for Microchip UCS1002 Programmable USB Port Power
>>> Controller with Charger Emulation.
>>>
>>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>>> Cc: Enric Balletbo Serra <enric.balletbo@collabora.com>
>>> Cc: Chris Healy <cphealy@gmail.com>
>>> Cc: Lucas Stach <l.stach@pengutronix.de>
>>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: devicetree@vger.kernel.org
>>> Cc: Sebastian Reichel <sre@kernel.org>
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: linux-pm@vger.kernel.org
>>> ---
>>>   .../power/supply/microchip,ucs1002.txt        | 27 +++++++++++++++++++
>>>   1 file changed, 27 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
>>> new file mode 100644
>>> index 000000000000..021fd7aba75e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
>>> @@ -0,0 +1,27 @@
>>> +Microchip UCS1002 USB Port Power Controller
>>> +
>>> +Required properties:
>>> +- compatible		: Should be "microchip,ucs1002";
>>> +- reg			: I2C slave address
>>> +
>>> +Optional properties:
>>> +- interrupts-extended	: A list of interrupts lines present (could be either
>>> +			  corresponding to A_DET# pin, ALERT# pin, or both)
> 
> Just make this 'interrupts'. Support for 'interrupts-extended' is
> implied.
> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
>>> +- interrupt-names	: A list of interrupt names. Should contain (if
>>> +			  present):
>>> +			  - "a_det" for line connected to A_DET# pin
>>> +			  - "alert" for line connected to ALERT# pin
>>> +			  Both are expected to be IRQ_TYPE_EDGE_BOTH
>>> +Example:
>>> +
>>> +&i2c3 {
>>> +	charger@32 {
>>> +		compatible = "microchip,ucs1002";
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&pinctrl_ucs1002_pins>;
>>
>> Document the above ? Or is that optional ?
> 
> I would have said to document this, but recently we had some discussion
> about allowing this to be implied when there's only a 'default' entry.
> We'll add it automatically for schemas.
> 

Good to know. Thanks for the information!

Guenter
