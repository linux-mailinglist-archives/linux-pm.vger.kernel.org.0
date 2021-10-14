Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF75242D3CE
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 09:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhJNHid (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 03:38:33 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:55850
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230072AbhJNHid (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 03:38:33 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BB2DA3FFF8
        for <linux-pm@vger.kernel.org>; Thu, 14 Oct 2021 07:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634196987;
        bh=3dBHQ0CCwS4iqRIss5gN00T/QO/pYW+4oQWUdLki5wU=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=NfZ1IBpWJFjHA431BtAXCXUs9jwHZyJuC1RMb72biZiCbP5pfnVFE6z4tbedelVoo
         pw0arGbpJrx1qAhzr9quu/QNuLEJ7wbvAgzZzLEVS91lT+iWkQO1EYiNBaCdVDhjW2
         rqPtboiPGMCjinYdyfz3Muy4nyI9x3ZqkhuD5b9fe1ShfvFvWT0+0LLWnKjFuKJJ0B
         Yl+CzRPMJRUgQDFBEBSgPKQzO45teVQ3oQW21xkDUZV5KLslE7ka+VzSyN50QVIjD7
         PjUiwwrGH+w5/ZViPQ5ZcDjQ0Sbyua0clIi1YApQrEJVRYT7UDuz5VUda6Hv/eNm1F
         aJdCyYsaD6vPw==
Received: by mail-lf1-f69.google.com with SMTP id br42-20020a056512402a00b003fd94a74905so3769756lfb.7
        for <linux-pm@vger.kernel.org>; Thu, 14 Oct 2021 00:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3dBHQ0CCwS4iqRIss5gN00T/QO/pYW+4oQWUdLki5wU=;
        b=d7ZPQ/BBy/TzDhQ0h8d3TFUWzBvHjOQ5cPdEDiX0o6+hSUTSirMjlmbx26wK+uoTU3
         t+DvR5UQ63kqBq213lpDzgi5d4GA5f2TZd9Y33mfvHraMJVwS98a6DQWKXLGeNmAJgcs
         K1GFPB0Ljesk/+KYOfziIagSHK12KRmODwJPWJTWnat/Yo9gRN+jeC9/f1Dlz7Z3L0Px
         hVFmnLuUnynp+XehGzgCgSBTj4d00Tvzyf8DRTwR8zmSyHEO95SiX5f5LRRRyqn0HZ0Q
         OSuFd7hThJbYnD0Po8caU7swioD/InsZGJTqUhs9+hdtGMeMey8ZQ4f0zCRT/xrrbytS
         WwFg==
X-Gm-Message-State: AOAM531yCikDv5Cr62JyafSElpUmNUELKlelW89ynjD5m6i2AFvcpzLY
        pIsxeasWZ4borNNzI5EY+gOHPVwQ5IxF5ozGDBx2hH9ps7LO4c8NtX6tBIpjpwuwl7y2jIXmO2R
        2GOIV5L8V+UPmpUUA/U4700sfp+D5UxQg3yJO
X-Received: by 2002:a2e:3005:: with SMTP id w5mr4290257ljw.228.1634196987030;
        Thu, 14 Oct 2021 00:36:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsQsq/0kwEUVa9aO6xG/cThkpvqL7ggL6yk+veaubzi/nCENc7uw5xGlJJejFOv/z5TAeGtw==
X-Received: by 2002:a2e:3005:: with SMTP id w5mr4290229ljw.228.1634196986778;
        Thu, 14 Oct 2021 00:36:26 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id f6sm200698ljo.36.2021.10.14.00.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 00:36:26 -0700 (PDT)
To:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211011165707.138157-1-marcan@marcan.st>
 <20211011165707.138157-7-marcan@marcan.st>
 <a9f6898d-bd76-b94e-52fc-98e9da1a04bd@canonical.com>
 <2a6f14e5-fbc9-4b9a-9378-a4b5200bc3fb@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [RFC PATCH 6/9] memory: apple: Add apple-mcc driver to manage MCC
 perf in Apple SoCs
Message-ID: <f81467d4-74b2-176d-06bf-f04e073efce4@canonical.com>
Date:   Thu, 14 Oct 2021 09:36:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2a6f14e5-fbc9-4b9a-9378-a4b5200bc3fb@marcan.st>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/10/2021 08:59, Hector Martin wrote:
> On 12/10/2021 18.19, Krzysztof Kozlowski wrote:
>>> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>>> +/*
>>> + * Apple SoC MCC memory controller performance control driver
>>> + *
>>> + * Copyright The Asahi Linux Contributors
>>
>> Copyright date?
> 
> We've gone over this one a few times already; most copyright dates 
> quickly become outdated and meaningless :)
> 
> See: 
> https://www.linuxfoundation.org/blog/copyright-notices-in-open-source-software-projects/
> 
>>> +static int apple_mcc_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	struct device_node *node = dev->of_node;
>>
>> By convention mostly we call the variable "np".
> 
> Ack, I'll change it for v2.
> 
>>> +	mcc->reg_base = devm_platform_ioremap_resource(pdev, 0);
>>> +	if (IS_ERR(mcc->reg_base))
>>> +		return PTR_ERR(mcc->reg_base);
>>> +
>>> +	if (of_property_read_u32(node, "apple,num-channels", &mcc->num_channels)) {
>>
>> Don't you have a limit of supported channels? It cannot be any uint32...
> 
> Today, it's max 8. But if come Monday we find out Apple's new chips have 
> 16 channels and otherwise the same register layout, I'd much rather not 
> have to change the driver...

OK, however if the driver ever receives different DT with a different
value, it will accept it unconditionally and go via address space. I am
just saying that being conservative on received values is safer, but I
am fine with skipping this problem. At the end we trust DT that it will
always match the kernel, don't we? Oh wait, someone can use DT from
other kernel in this one...

> 
>>> +		dev_err(dev, "missing apple,num-channels property\n");
>>
>> Use almost everywhere dev_err_probe - less code and you get error msg
>> printed.
> 
> Heh, I didn't know about that one. Thanks!
> 
>>> +
>>> +	dev_info(dev, "Apple MCC performance driver initialized\n");
>>
>> Please skip it, or at least make it a dev_dbg, you don't print any
>> valuable information here.
> 
> Ack, I'll remove this.
> 
>>> +static struct platform_driver apple_mcc_driver = {
>>> +	.probe = apple_mcc_probe,
>>> +	.driver = {
>>> +		.name = "apple-mcc",
>>> +		.of_match_table = apple_mcc_of_match,
>>> +	},
>>> +};
>>
>> module_platform_driver() goes here.
> 
> Ack, will fix for v2.
> 
>>
>>> +
>>> +MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
>>> +MODULE_DESCRIPTION("MCC memory controller performance tuning driver for Apple SoCs");
>>> +MODULE_LICENSE("GPL v2");
>>
>> I think this will be "Dual MIT/GPL", based on your SPDX.
> 
> Ah, I didn't realize that was a valid option for MODULE_LICENSE. I guess 
> anything containing "GPL" works with EXPORT_SYMBOL_GPL?

I don't think exporting symbols is related to how you license your code.


Best regards,
Krzysztof
