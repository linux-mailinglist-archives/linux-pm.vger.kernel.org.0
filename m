Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BEF4285FC
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 06:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhJKEok (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 00:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhJKEoj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 00:44:39 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A8CC061570;
        Sun, 10 Oct 2021 21:42:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B05B941EF0;
        Mon, 11 Oct 2021 04:42:32 +0000 (UTC)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20211005155923.173399-1-marcan@marcan.st>
 <20211005155923.173399-3-marcan@marcan.st>
 <b5b3fcb4-077b-d33d-03cc-ac0611cb56a1@canonical.com>
 <5b89aed0-f9b7-fdba-16d8-a8bd9e2d7437@marcan.st>
 <6e92a8d3-798a-267a-d24e-6b9ff0c3c645@canonical.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 2/7] dt-bindings: power: Add apple,pmgr-pwrstate binding
Message-ID: <60b3f115-8549-9080-774b-f2c8b98ce6d0@marcan.st>
Date:   Mon, 11 Oct 2021 13:42:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6e92a8d3-798a-267a-d24e-6b9ff0c3c645@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/10/2021 22.12, Krzysztof Kozlowski wrote:
>>>> +  power-domains:
>>>> +    description:
>>>> +      Reference to parent power domains. A domain may have multiple parents,
>>>> +      and all will be powered up when it is powered.
>>>
>>> How many items?
>>
>> One or more (if there are none the property should not exist). I guess
>> that should be encoded.
> 
> Probably this should not go without any constraints. Are you sure it
> could have more than one? It would mean more than one parent.

Yes, at least that is the way Apple describes it in their device tree. 
As I understand it, this is basically a dependency tree of SoC blocks 
that need to be powered up/clocked for a downstream device to work. In 
other words, it's not just a pure clock/power tree, but also represents 
blocks of logic that are shared between devices. So, for example, the 
ADT has relationships like these:

SIO_BUSIF parents: (none)
SIO       parents: SIO_BUSIF
PMS_BUSIF parents: (none)
PMS       parents: (none)
AUDIO_P   parents: SIO
SIO_ADMA  parents: SIO, PMS
MCA0      parents: AUDIO_P, SIO_ADMA

That said, we know some of the data from the ADT is dodgy and doesn't 
match the true hardware (see also the dependency from SIO to SIO_BUSIF 
there, but not from PMS to PMS_BUSIF, which feels wrong), so as we learn 
more about the real relationships between these domains we'll adjust the 
devicetree to better reflect the hardware layout.

There is also the case that even if technically a downstream device 
depends on two domains (directly), the existing genpd infrastructure 
doesn't handle that automatically like it does the single domain case, 
so it ends up making sense to just have some extra domain-domain 
dependencies to keep a bunch of boilerplate manual genpd handling code 
out of device drivers.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
