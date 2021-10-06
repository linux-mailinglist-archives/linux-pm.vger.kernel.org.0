Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49C742422E
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 18:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239269AbhJFQKF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 12:10:05 -0400
Received: from marcansoft.com ([212.63.210.85]:37368 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231768AbhJFQKE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Oct 2021 12:10:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 942A441EA7;
        Wed,  6 Oct 2021 16:08:05 +0000 (UTC)
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
 <20211005155923.173399-4-marcan@marcan.st>
 <bee16b95-964c-f515-a196-cd267391d4eb@canonical.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 3/7] soc: apple: Add driver for Apple PMGR power state
 controls
Message-ID: <48d3996e-9f96-2e68-56f2-d445475cf131@marcan.st>
Date:   Thu, 7 Oct 2021 01:08:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <bee16b95-964c-f515-a196-cd267391d4eb@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/10/2021 16.28, Krzysztof Kozlowski wrote:
>> +static int apple_pmgr_ps_set(struct generic_pm_domain *genpd, u32 pstate)
>> +{
>> +	int ret;
>> +	struct apple_pmgr_ps *ps = genpd_to_apple_pmgr_ps(genpd);
>> +	u32 reg;
>> +
>> +	regmap_read(ps->regmap, ps->offset, &reg);
> 
> MMIO accesses should not fail, but regmap API could fail if for example
> clk_enable() fails. In such case you will write below value based on
> random stack init. Please check the return value here.

Ack, will fix for v2 (as well as the related ones below).

>> +static int apple_pmgr_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
>> +{
>> +	struct apple_pmgr_ps *ps = rcdev_to_apple_pmgr_ps(rcdev);
>> +
>> +	mutex_lock(&ps->genpd.mlock);
> 
> This looks wrong: it can be a spin-lock, not mutex, so you should use
> genpd_lock.

genpd_lock() is not part of the public API, which is why I did it like 
this. This gets decided by whether the GENPD_FLAG_IRQ_SAFE flag is set, 
so it should be a mutex in this case, as that is not set.

> However now I wonder if there could be a case when a reset-controller
> consumer calls it from it's GENPD_NOTIFY_ON notifier? In such case you
> would have this lock taken.

Hm, yeah, I wonder if we'll hit that use case. Probably not, though. I 
mostly expect our drivers to only reset devices on initial probe or in 
some kind of panic recovery scenario, not while doing PM stuff.

>> +static const struct of_device_id apple_pmgr_ps_of_match[] = {
>> +	{ .compatible = "apple,t8103-pmgr-pwrstate" },
>> +	{ .compatible = "apple,pmgr-pwrstate" },
> 
> You call the device/driver "pwrstate", which it seems is "power state".
> These are not power states. These are power controllers or power
> domains. Power state is rather a state of power domain - e.g. on or
> gated. How about renaming it to power domain or pd?

It's a bit confusing. Apple calls these registers "ps" registers, which 
presumably stands for "power state". They can both clockgate and 
powergate devices (where supported), as well as enable auto-PM and also 
handle reset. So they're a bit more complex and higher level than a 
simple power domain, which is why I called the driver "pwrstate", since 
it controls the power state of a specific SoC domain or block. In fact, 
the device PM is controlled via a 4-bit power state index, though right 
now only 0, 4, 15 are used (power gated, clock gated, active). Many 
devices will not support individual power gating and would just 
clockgate at 0, and right now the driver never uses 4, but might in the 
future. If that needs to be exposed to consumers, then it'd have to be 
via genpd idle states.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
