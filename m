Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F664253BC
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 15:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241164AbhJGNMo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 09:12:44 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35780
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241118AbhJGNMh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 09:12:37 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8CC8C3FFD9
        for <linux-pm@vger.kernel.org>; Thu,  7 Oct 2021 13:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633612243;
        bh=JhSvZ4bZ9XDCLRxn5WXaBJyzQncLRhcDh11CxYaApWU=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=SQRww+CWPi/Q2poXGMn6psrMEj+mkI4ulRfIKaTDI/o4eRN+80ZrPrMGCf5L1+HFJ
         iPfifVGNDcCAusIJAFWrcCi1E6KhQcYoeAfbYW3OYnHy+eaipA173pWYSzlu3Xm3CQ
         GfIDX4iWcEtlyo+LyV/SoslxUoJqJu/KEK7PNd+A9hQHbyZgGeJRxkuj81Q8reK13n
         c05FMx6GsCJl+GifABM41Eruy9YrkEfssnIb+BFChN1xfyrSbtapu5LXl3+tlCTY7M
         7ntnP0VIShhej0fU8IyLuZlDj7sH/m/lBduBe6vhZGa1YJ/qYWQC+FsefDakNaADYd
         hjvA72BltRGvA==
Received: by mail-wr1-f71.google.com with SMTP id r21-20020adfa155000000b001608162e16dso4637706wrr.15
        for <linux-pm@vger.kernel.org>; Thu, 07 Oct 2021 06:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JhSvZ4bZ9XDCLRxn5WXaBJyzQncLRhcDh11CxYaApWU=;
        b=ckJtCT/WeSgx92w6lR+3eoeV6IrZKwDM83aP/FbVGDtxnYW0WsXGMDwWEOXOoH6ybb
         heF0WyH2noUSY4v61RvPwWX/C1MSp1mhWWLbA8EMUkBsN9Ygm8cHyGIuIp813N17s6Hm
         qwSkrVNQyNFUu4GFecK0lR7D5tJwmzSpTazlEVl7s9L6uwXQWxf4LiGNGmW19+umcIyQ
         4t5YFSEB0ipxC6LTgS8vQA0IN1EiJhDB8w/DWDf6Z86tfPNX37dQpvsbFvKq5UCmSqwc
         aTo20enDQOgugPeJJFLLMTt8iP7DzRqyeM2LJlz5vH3vYfbSHDC4vAxe01Z24dqLNWNm
         MjzA==
X-Gm-Message-State: AOAM5337RUNUwOT51y6BzqaOTHXAYaa+G5hguBfQ+wxSf76QlpQ833+Q
        leqID+Xlxw7QT/j8c8iY+OfnbKQE9mPjcm61eAZb4ydM6onzNyl19rZXfPssYiHR59dPxa5Ok7W
        Sd3cKIEO+6bzOgaXaeI2PMXufOr856fVMPb6T
X-Received: by 2002:a1c:ac86:: with SMTP id v128mr4569215wme.3.1633612241796;
        Thu, 07 Oct 2021 06:10:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLwRYPKIpB+6rBu8rzxazPdAbZRZWVT14g4gFsnMg69geQZ9M20oFRASa/T2iiTTB4yzVtpw==
X-Received: by 2002:a1c:ac86:: with SMTP id v128mr4568961wme.3.1633612239499;
        Thu, 07 Oct 2021 06:10:39 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id v16sm2571457wrq.39.2021.10.07.06.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 06:10:39 -0700 (PDT)
Subject: Re: [PATCH 1/7] dt-bindings: arm: apple: Add apple,pmgr binding
To:     Hector Martin <marcan@marcan.st>,
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
 <57991dac-196e-a76d-831a-d4ac166bfe29@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <a5d52d94-4d42-6842-a40f-db25d2581929@canonical.com>
Date:   Thu, 7 Oct 2021 15:10:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <57991dac-196e-a76d-831a-d4ac166bfe29@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/10/2021 17:26, Hector Martin wrote:
> On 06/10/2021 15.56, Krzysztof Kozlowski wrote:
>>> diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
>>> new file mode 100644
>>> index 000000000000..0304164e4140
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
>>> @@ -0,0 +1,74 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/arm/apple/apple,pmgr.yaml#
>>
>> Please don't store all Apple-related bindings in bindings/arm/apple, but
>> instead group per device type like in most of other bindings. In this
>> case - this looks like something close to power domain controller, so it
>> should be in bindings/power/
> 
> This is a controller that, right now, is only used to instantiate device 
> power management controls, but the controller itself is just a generic 
> syscon device. Depending on the register range, it could conceivably 
> encompass other register types (e.g. clock selects) within it, though 
> I'm not sure I want to do that right now. Apple calls several of these 
> different register sets as a whole a "PMGR". So I'm not sure if it 
> really qualifies as "just" a power domain controller. If we want to 
> restrict this to the power state portion of PMGR, then it might make 
> sense to call it something more specific...
> 
> See arm/rockchip/pmu.yaml for the setup this is modeled after.
> 

Makes sense now and actually few other designs including Samsung Exynos
have it as well.


Best regards,
Krzysztof
