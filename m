Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68D242D321
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 08:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhJNHBj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 03:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhJNHBj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 03:01:39 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95C6C061570;
        Wed, 13 Oct 2021 23:59:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id D151C41AC8;
        Thu, 14 Oct 2021 06:59:26 +0000 (UTC)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
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
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [RFC PATCH 6/9] memory: apple: Add apple-mcc driver to manage MCC
 perf in Apple SoCs
Message-ID: <2a6f14e5-fbc9-4b9a-9378-a4b5200bc3fb@marcan.st>
Date:   Thu, 14 Oct 2021 15:59:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a9f6898d-bd76-b94e-52fc-98e9da1a04bd@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/10/2021 18.19, Krzysztof Kozlowski wrote:
>> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>> +/*
>> + * Apple SoC MCC memory controller performance control driver
>> + *
>> + * Copyright The Asahi Linux Contributors
> 
> Copyright date?

We've gone over this one a few times already; most copyright dates 
quickly become outdated and meaningless :)

See: 
https://www.linuxfoundation.org/blog/copyright-notices-in-open-source-software-projects/

>> +static int apple_mcc_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *node = dev->of_node;
> 
> By convention mostly we call the variable "np".

Ack, I'll change it for v2.

>> +	mcc->reg_base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(mcc->reg_base))
>> +		return PTR_ERR(mcc->reg_base);
>> +
>> +	if (of_property_read_u32(node, "apple,num-channels", &mcc->num_channels)) {
> 
> Don't you have a limit of supported channels? It cannot be any uint32...

Today, it's max 8. But if come Monday we find out Apple's new chips have 
16 channels and otherwise the same register layout, I'd much rather not 
have to change the driver...

>> +		dev_err(dev, "missing apple,num-channels property\n");
> 
> Use almost everywhere dev_err_probe - less code and you get error msg
> printed.

Heh, I didn't know about that one. Thanks!

>> +
>> +	dev_info(dev, "Apple MCC performance driver initialized\n");
> 
> Please skip it, or at least make it a dev_dbg, you don't print any
> valuable information here.

Ack, I'll remove this.

>> +static struct platform_driver apple_mcc_driver = {
>> +	.probe = apple_mcc_probe,
>> +	.driver = {
>> +		.name = "apple-mcc",
>> +		.of_match_table = apple_mcc_of_match,
>> +	},
>> +};
> 
> module_platform_driver() goes here.

Ack, will fix for v2.

> 
>> +
>> +MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
>> +MODULE_DESCRIPTION("MCC memory controller performance tuning driver for Apple SoCs");
>> +MODULE_LICENSE("GPL v2");
> 
> I think this will be "Dual MIT/GPL", based on your SPDX.

Ah, I didn't realize that was a valid option for MODULE_LICENSE. I guess 
anything containing "GPL" works with EXPORT_SYMBOL_GPL?

Thanks for the review!

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
