Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66154241FA
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 17:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbhJFQBj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 12:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbhJFQBi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 12:01:38 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5D9C061746;
        Wed,  6 Oct 2021 08:59:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 46D773FA5E;
        Wed,  6 Oct 2021 15:59:40 +0000 (UTC)
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
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 2/7] dt-bindings: power: Add apple,pmgr-pwrstate binding
Message-ID: <5b89aed0-f9b7-fdba-16d8-a8bd9e2d7437@marcan.st>
Date:   Thu, 7 Oct 2021 00:59:37 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b5b3fcb4-077b-d33d-03cc-ac0611cb56a1@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/10/2021 16.05, Krzysztof Kozlowski wrote:
>> +  IP cores belonging to a power domain should contain a
>> +  "power-domains" property that is a phandle for the
>> +  power domain node representing the domain.
> 
> Skip this last paragraph - it is obvious in usage of power domains.
> Specific bindings should not duplicate generic knowledge.

Ack, I'll drop it.

>> +properties:
>> +  $nodename:
>> +    pattern: "^power-controller@[0-9a-f]+$"
> 
> Usually we call nodes as power-domain.

I had it as that originally, but these aren't power domains. These are 
power management domains (they can clock *and* power gate separately, 
where supported) plus also do reset management. So I wasn't sure if it 
was really fair calling them "power-domain" at that point.

>> +  power-domains:
>> +    description:
>> +      Reference to parent power domains. A domain may have multiple parents,
>> +      and all will be powered up when it is powered.
> 
> How many items?

One or more (if there are none the property should not exist). I guess 
that should be encoded.

>> +
>> +  apple,domain-name:
> 
> Use existing binding "label".

Ah, I'd missed that one! I'm glad there's an existing binding for this 
already.

> Your parent schema should include this one for evaluating children.

Yup, I'll do it like that for v2.

Thanks!


-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
