Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E4E428638
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 07:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhJKFeh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 01:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhJKFeg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 01:34:36 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F179CC061570;
        Sun, 10 Oct 2021 22:32:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 398A7424EC;
        Mon, 11 Oct 2021 05:32:30 +0000 (UTC)
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
 <20211005155923.173399-7-marcan@marcan.st>
 <77ae3bb1-6da5-3ec6-de33-5e5f661b6145@canonical.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 6/7] tty: serial: samsung_tty: Support runtime PM
Message-ID: <46109820-904b-4e87-5134-7d045dbbe57e@marcan.st>
Date:   Mon, 11 Oct 2021 14:32:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <77ae3bb1-6da5-3ec6-de33-5e5f661b6145@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/10/2021 16.43, Krzysztof Kozlowski wrote:
> On 05/10/2021 17:59, Hector Martin wrote:
>> +	pm_runtime_get_noresume(&pdev->dev);
>> +	pm_runtime_set_active(&pdev->dev);
>> +	pm_runtime_enable(&pdev->dev);
>> +
> 
> You need to cleanup in error paths (put/disable).

There are none though, this function always returns success past this point.

>>   	if (port) {
>> +		pm_runtime_get_sync(&dev->dev);
> 
> 1. You need to check return status.
> 2. Why do you need to resume the device here?

As Rafael mentioned, this is basically disabling PM so the device is 
enabled when not bound (which seems to be expected behavior). Not sure 
what I'd do if the resume fails... this is the remove path after all, 
it's not like we're doing anything else with the device at this point.

>> +
>>   		s3c24xx_serial_cpufreq_deregister(to_ourport(port));
>>   		uart_remove_one_port(&s3c24xx_uart_drv, port);
>> +
>> +		pm_runtime_disable(&dev->dev);
> 
> Why disabling it only if port!=NULL? Can remove() be called if
> platform_set_drvdata() was not?

Good question, I'm not entirely sure why these code paths have a check 
for NULL there. They were already there, do you happen to know why? To 
me it sounds like remove would only be called if probe succeeds, at 
which point drvdata should always be set.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
