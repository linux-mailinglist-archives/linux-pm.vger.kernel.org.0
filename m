Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96B043F7AC
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 09:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhJ2HLj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 03:11:39 -0400
Received: from marcansoft.com ([212.63.210.85]:49316 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhJ2HLj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 Oct 2021 03:11:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 02A34424B9;
        Fri, 29 Oct 2021 07:09:04 +0000 (UTC)
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Mark Kettenis <kettenis@openbsd.org>
References: <20211025144718.157794-1-marcan@marcan.st>
 <20211025144718.157794-3-marcan@marcan.st>
 <YXhINE00HG6hbQI4@robh.at.kernel.org>
 <c0f2587c-ab69-8194-e618-ce7919c1aeb1@marcan.st>
 <CAL_JsqJbVcqy8n0EroV=nFZoJ_WAr+JbrDf-c1jso856NghC2A@mail.gmail.com>
 <CAJKOXPfDAnECHzGDTisuujT-rGvUqVp4a5WTOQ196yTqwLKHuA@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 2/8] dt-bindings: arm: apple: Add apple,pmgr binding
Message-ID: <0614b9ba-79f8-afc5-793d-6d465df51bed@marcan.st>
Date:   Fri, 29 Oct 2021 16:09:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfDAnECHzGDTisuujT-rGvUqVp4a5WTOQ196yTqwLKHuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/10/2021 23.51, Krzysztof Kozlowski wrote:
> On Wed, 27 Oct 2021 at 16:44, Rob Herring <robh@kernel.org> wrote:
>>
>> On Tue, Oct 26, 2021 at 10:38 PM Hector Martin <marcan@marcan.st> wrote:
>>>
>>> On 27/10/2021 03.25, Rob Herring wrote:
>>>> On Mon, Oct 25, 2021 at 11:47:12PM +0900, Hector Martin wrote:
>>>>> +  compatible:
>>>>> +    items:
>>>>> +      - enum:
>>>>> +          - apple,t8103-pmgr
>>>>> +          - apple,t8103-minipmgr
>>>>> +      - const: apple,pmgr
>>>>> +      - const: syscon
>>>>> +      - const: simple-mfd
>>>>
>>>>
>>>> 'simple-mfd' means 'there's nothing in this node that any of the child
>>>> nodes depend on'. You should be somewhat certain as dropping it later
>>>> creates compatibility issues.
>>>
>>> Hmm, I see simple-mfd turns this into a bus which I guess allows child
>>> nodes to be probed without the parent node doing anything special (then
>>> we use syscon_node_to_regmap to get the syscon instantiated). Do you
>>> have a example use case for doing this without simple-mfd?
>>
>> Drivers calling of_platform_populate or devm_of_platform_populate.
>>
>> That of course does mean you need a driver. We could probably make the
>> syscon driver call these if needed.
>>
> 
> Hi Hector,
> 
> I thought I mentioned this with your v1, maybe the comment got lost.
> We have it for Exynos PMU:
> drivers/soc/samsung/exynos-pmu.c
> arch/arm/boot/dts/exynos-syscon-restart.dtsi (extending node from
> arch/arm/boot/dts/exynos5420.dtsi)
> Maybe you can base on that.

Ah, I remember the discrete power domains but I missed this syscon.

I see this is mostly used for poweroff/reboot, which makes sense in this 
context. For pmgr though, the binding only describes the uniform power 
state registers, so I think I'm comfortable leaving it as a simple-mfd. 
Other pmgr sub-blocks will probably end up as separate nodes with 
different bindings anyway (e.g. whatever I do for the clock muxes, need 
to see how that ties in with audio which I think is the only consumer so 
far).

If things get more complicated in future SoCs then we can change how we 
do it on those, of course :)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
