Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE03C435C82
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 09:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhJUH6e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 03:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhJUH6e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 03:58:34 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71427C06161C
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 00:56:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o24-20020a05600c511800b0030d9da600aeso13398124wms.4
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 00:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mpBk3CGGBQxOjdLo0meuYKa3n7EnDSifXrr7ewVJe00=;
        b=x2dsJWU0DmewCEoW4HMlYFcsU1ENwqA1YmdVjuHsflJ6a4qeIdyB9v10R8IgpLhvfj
         zcGA3WMue61oYUGVvl63bF+d6HOLXZt4zwPc4qx+BC3ospWCTypf3o83PbzgU800Zvj4
         +ke6hur0RkUzRAKzTACpteO9pC3H9baH91enXLkXpl14qXi0DE6wBXEiiAC2FX8uxk2O
         coIz2OzWXqJg0OSOhxtX2lzGc3giqRcio6w+kh7/kPCIdgVTv+lZbkz4hQ4aVyt9JDBw
         /xvuHhDxECyPH2lqBlYg5i/FEx2l+yUs4PA9csb3FCjgcZ/wOFrFbrLEBJaA+Bm9YZ8Y
         y1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mpBk3CGGBQxOjdLo0meuYKa3n7EnDSifXrr7ewVJe00=;
        b=ry6lFun/SPBfrWiQXSCw6hVYOdvDjHG3t1EvGZmObtLriE1fw3s67dTpCcGi0nJn0B
         6w0PMLgrsu7hw8X8aglR/+gxI4OZksRZuPmBLX4nqp1xTbrpUxeLsumgro5CIUeNTulS
         1wLRn+64EFFcdr7ZZNRvCy4LfZ7TpzucV0OPWxgOVJi5mEyl/nurhxdvHJx+gWRlqnHe
         avHfCobrHCPNSfUhAHlsnbUGAqF92Om8Ka16VP/0PMop/kPsWRowsmGvZBs72i/Hbvig
         kvjw496xvx+VwteJmSqw8/xobG2BDN8WFXjTKMFZypBPkcRs2IW8Z7KnimffpdJPXBO7
         rfzg==
X-Gm-Message-State: AOAM533Op14+W33CtgVCfn4FgSMUtvmOSf+zVezvHWVbrewMODpY7zKD
        kRE1FL2J88aWUz5KzdnuoZwuNg==
X-Google-Smtp-Source: ABdhPJybY3RyTkP6/YfSmrtS1StO8NtbG2l9wr76SmhR1UpvBCLux8RfZvaXwwoAjojfFJeSIWITnA==
X-Received: by 2002:a1c:d1:: with SMTP id 200mr4721550wma.86.1634802976877;
        Thu, 21 Oct 2021 00:56:16 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:2a2c:7ed:66a0:d637? ([2a01:e34:ed2f:f020:2a2c:7ed:66a0:d637])
        by smtp.googlemail.com with ESMTPSA id x24sm7738157wmk.31.2021.10.21.00.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 00:56:16 -0700 (PDT)
Subject: Re: [PATCH v2] thermal: imx: implement runtime PM support
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Petr Benes <petrben@gmail.com>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        linux-pm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Zhang Rui <rui.zhang@intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20211019130809.21281-1-o.rempel@pengutronix.de>
 <20211020050459.GE16320@pengutronix.de>
 <CAPwXO5b=z1nhQCo55A_XuK-Es2o7TrL2Vj6AkRSXa3Wxh0s8sA@mail.gmail.com>
 <20211021072000.GC2298@pengutronix.de>
 <afeea08b-6130-3c7c-be03-52691d00be57@linaro.org>
 <20211021074456.GD2298@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <dace17c6-a31a-9b52-3659-5b36e23f530e@linaro.org>
Date:   Thu, 21 Oct 2021 09:56:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211021074456.GD2298@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/10/2021 09:44, Oleksij Rempel wrote:
> On Thu, Oct 21, 2021 at 09:41:35AM +0200, Daniel Lezcano wrote:
>> On 21/10/2021 09:20, Oleksij Rempel wrote:
>>> Hi Petr,
>>>
>>> On Wed, Oct 20, 2021 at 05:53:03PM +0200, Petr Benes wrote:
>>>> On Wed, 20 Oct 2021 at 07:05, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>>>>>
>>>>> Hi Petr and Michal,
>>>>>
>>>>> I forgot to add you for v2 in CC. Please test/review this version.
>>>>
>>>> Hi Oleksij,
>>>>
>>>> It works good. with PM as well as without PM. The only minor issue I found is,
>>>> that the first temperature reading (when the driver probes) fails. That is
>>>> (val & soc_data->temp_valid_mask) == 0) holds true. How does
>>>> pm_runtime_resume_and_get() behave in imx_thermal_probe()?
>>>> Does it go through imx_thermal_runtime_resume() with usleep_range()?
>>>
>>> On the first temperature reading, the PM and part of HW is not
>>> initialized. Current probe sequence is racy and has at least following
>>> issues:
>>> - thermal_zone_device_register is executed before HW init was completed.
>>>   It kind of worked before my patch, becaus part of reinit was done by
>>>   temperature init. It  worked, since the irq_enabled flag was not set,
>>>   but potentially would run enable_irq() two times if device is
>>>   overheated on probe.
>>> - the imx_thermal core is potentially disable after first race
>>>   condition:
>>>   CPU0					CPU1
>>>   thermal_zone_device_register()
>>> 					imx_get_temp()
>>>   					irq_enabled == false
>>> 						power_up
>>> 						read_temp
>>>   power_up
>>>   						power_down
>>>   irq_enabled = true;
>>>
>>>   ... at this point imx_thermal is powered down for some amount of time,
>>>   over temperature IRQ will not be triggered for some amount of time.
>>>
>>> - if some part after thermal_zone_device_register() would fail or
>>>   deferred, the worker polling temperature will run in to NULL pointer.
>>>   This issue already happened...
>>>
>>> After migrating to runtime PM, one of issues started to be visible even
>>> on normal conditions.
>>> I'll send one more patch with reworking probe sequence.
>>
>> Are you planning to send a v3 with this patch? Or a separate patch?
> 
> I'm OK with both variants. What do you prefer?
> 
> I'll do i on top of PM patch to reduce refactoring overhead, if you OK
> about it.

I prefer you resend a couple of patches but change the subject of this
patch to something like "thermal/drivers/imx: Fix disabled sensor after
handling trip temperature" in order to reflect the problem, not the
solution.

btw: nice fix



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
