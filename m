Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2A742424A
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 18:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhJFQNG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 12:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239335AbhJFQNF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 12:13:05 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637A7C061755;
        Wed,  6 Oct 2021 09:11:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1C27B41EA7;
        Wed,  6 Oct 2021 16:11:06 +0000 (UTC)
Subject: Re: [PATCH 3/7] soc: apple: Add driver for Apple PMGR power state
 controls
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20211005155923.173399-1-marcan@marcan.st>
 <20211005155923.173399-4-marcan@marcan.st>
 <59334bc1f64926f8106a9b1e885dd88971d34117.camel@pengutronix.de>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <2f590036-52db-bcdc-571a-361dd8b8dc19@marcan.st>
Date:   Thu, 7 Oct 2021 01:11:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <59334bc1f64926f8106a9b1e885dd88971d34117.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/10/2021 18.24, Philipp Zabel wrote:
>> +static int apple_pmgr_reset_reset(struct reset_controller_dev *rcdev, unsigned long id)
>> +{
>> +	int ret;
>> +
>> +	ret = apple_pmgr_reset_assert(rcdev, id);
>> +	if (ret)
>> +		return ret;
>> +
>> +	usleep_range(APPLE_PMGR_RESET_TIME, 2 * APPLE_PMGR_RESET_TIME);
> 
> Is this delay known to be long enough for all consumers using the
> reset_control_reset() functionality? Are there any users at all?

I tested this for UART and ANS outside of Linux, and found that even 
back to back register writes worked, so the 1us thing is already 
conservative. I have no idea if we'll run into some weirdo block that 
needs more time, though. If we do then this will have to be bumped or 
turned into a property.

> Is it ok for a genpd transition to happen during this sleep?

I expect consumers to call reset while the device is active; it won't 
even work without that, as the reset is synchronous and just doesn't 
take effect while clock gated (at least for UART). See the dev_err()s 
that fire when that happens.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
