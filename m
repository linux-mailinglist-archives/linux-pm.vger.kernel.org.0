Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA57424147
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 17:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbhJFP2D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 11:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhJFP2D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 11:28:03 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90F2C061746;
        Wed,  6 Oct 2021 08:26:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 33AE13FA5E;
        Wed,  6 Oct 2021 15:26:04 +0000 (UTC)
Subject: Re: [PATCH 1/7] dt-bindings: arm: apple: Add apple,pmgr binding
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
 <20211005155923.173399-2-marcan@marcan.st>
 <18818eff-87d7-6a53-a4fd-7f3cbf625a0e@canonical.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <57991dac-196e-a76d-831a-d4ac166bfe29@marcan.st>
Date:   Thu, 7 Oct 2021 00:26:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <18818eff-87d7-6a53-a4fd-7f3cbf625a0e@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/10/2021 15.56, Krzysztof Kozlowski wrote:
>> diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
>> new file mode 100644
>> index 000000000000..0304164e4140
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
>> @@ -0,0 +1,74 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/apple/apple,pmgr.yaml#
> 
> Please don't store all Apple-related bindings in bindings/arm/apple, but
> instead group per device type like in most of other bindings. In this
> case - this looks like something close to power domain controller, so it
> should be in bindings/power/

This is a controller that, right now, is only used to instantiate device 
power management controls, but the controller itself is just a generic 
syscon device. Depending on the register range, it could conceivably 
encompass other register types (e.g. clock selects) within it, though 
I'm not sure I want to do that right now. Apple calls several of these 
different register sets as a whole a "PMGR". So I'm not sure if it 
really qualifies as "just" a power domain controller. If we want to 
restrict this to the power state portion of PMGR, then it might make 
sense to call it something more specific...

See arm/rockchip/pmu.yaml for the setup this is modeled after.

> No power-domain-cells? Why? What exactly this device is going to do?
> Maybe I'll check the driver first.... :)

It's a syscon, it does nothing on its own. All the work is done by the 
child nodes and the driver that binds to those.

>> +additionalProperties: true
> 
> additionalProperties: false

Fixed for v2.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
