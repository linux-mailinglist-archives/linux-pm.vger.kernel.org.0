Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF164241DB
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 17:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbhJFPyI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 11:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbhJFPyI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 11:54:08 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD28C061746;
        Wed,  6 Oct 2021 08:52:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 75FCF3FA5E;
        Wed,  6 Oct 2021 15:52:09 +0000 (UTC)
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
References: <20211005155923.173399-1-marcan@marcan.st>
 <20211005155923.173399-3-marcan@marcan.st>
 <CAL_JsqJenHAOw4gApzGpuj-8nZjkYhmBg0qBj-DV+CEJ7zXuVw@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 2/7] dt-bindings: power: Add apple,pmgr-pwrstate binding
Message-ID: <f95f6d61-8809-e668-0458-453a8dfbe641@marcan.st>
Date:   Thu, 7 Oct 2021 00:52:07 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJenHAOw4gApzGpuj-8nZjkYhmBg0qBj-DV+CEJ7zXuVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/10/2021 09.58, Rob Herring wrote:
> On Tue, Oct 5, 2021 at 10:59 AM Hector Martin <marcan@marcan.st> wrote:
>> Future SoCs are expected to use backwards compatible registers, and the
>> "apple,pmgr-pwrstate" represents any such interfaces (possibly with
>> additional features gated by the more specific compatible), allowing
>> them to be bound without driver updates. If a backwards incompatible
>> change is introduced in future SoCs, it will require a new compatible,
>> such as "apple,pmgr-pwrstate-v2".
> 
> Is that because past SoCs used the same registers? I don't see how
> else you have any insight to what future SoCs will do.
> 
> Normally we don't do 1 node per register type bindings, so I'm a bit
> leery about doing 1 node per domain.

Yes, we can trace a pretty clear lineage from past SoCs. Plus Apple 
folks themselves have confirmed that this is an explicit policy:

https://twitter.com/stuntpants/status/1442276493669724160

Already within this SoC we have two PMGR instances with different 
register sets (one covers all devices that stay on during system sleep), 
although I am only instantiating one in our devicetree at the moment. 
And of course there is the A14, which is the same generation as the M1 
and has exactly the same register format, but a different set of domains.

Having sub-nodes describing individual power domains has some prior art 
(e.g. power/rockchip,power-controller.yaml). In that case the nodes are 
all managed by the parent node, and use the hierarchical format, but the 
hierarchical format cannot handle multi-parent nodes (which we do have, 
or at least Apple describes them that way). Since we really have no 
"top-level" implementation specifics to worry about, I think it makes 
sense to just bind to single nodes at this point, which makes the driver 
very simple since it doesn't have to perform any bookkeeping for 
multiple domains.

I realize this is all kind of "not the way things are usually done", but 
I don't want to pass up on the opportunity to have one driver last us 
multiple SoCs if we have the chance, and it's looking like it should :-)

Note that as new features are implemented (e.g. auto-PM, which I will 
add to this driver later), that also naturally lends itself to 
forwards-compat, as SoCs without those features at all simply wouldn't 
request them in the DT. In this case an "apple,auto-pm" flag would 
enable that for domains where we want it, and those that don't support 
it (or a hypothetical past SoC without the feature at all) would simply 
not use it.

>> +properties:
>> +  $nodename:
>> +    pattern: "^power-controller@[0-9a-f]+$"
> 
> Drop this and define this node in the syscon schema with a $ref to this schema.

Ack, makes sense.

>> +  apple,domain-name:
>> +    description: |
>> +      Specifies the name of the SoC device being controlled. This is used to
>> +      name the power/reset domains.
>> +    $ref: /schemas/types.yaml#/definitions/string
> 
> No other power domain binding needs this, why do you?

Because they all hardcode the domain names in the drivers for every SoC :-)

Without a name of some sort in the devicetree, all our genpds would have 
to use numeric register offsets or the like, which seems quite ugly.

> I prefer 1 complete example in the MFD schema rather than piecemeal examples.

Sure. Would we leave this schema without examples then?

> As the child nodes are memory mapped devices, size should be 1. Then
> address translation works (though Linux doesn't care (currently)).

This requires all the reg properties to also declare the reg size, right?

One thing I wonder is whether it would make sense to allow 
#power-domain-cells = <1> and then be able to declare consecutive ranges 
of related power registers in one node. This would be useful for e.g. 
the 9 UARTs, the 4 SPI controllers, the 6 MCAs, the 5 I2C controllers, 
the 5 PWM controllers, etc (which all have uniform parents and features 
and are consecutive, so could be described together). I'm not sure if 
it's worth it, thoughts?

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
