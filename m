Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF3C380286
	for <lists+linux-pm@lfdr.de>; Fri, 14 May 2021 05:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhENDed (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 May 2021 23:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbhENDeb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 May 2021 23:34:31 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02416C061574;
        Thu, 13 May 2021 20:33:20 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id o27so27599470qkj.9;
        Thu, 13 May 2021 20:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dikOEtKsjpSnaSM6EeOCvys/XjUwuAHcvPk4ndAPdHw=;
        b=R8a18YS6HJp3phFIY2QEf9KyEjYwVhdcNOeUaJyfG0KGADoFZ5pz9/xsXV9JlkcuEs
         /Nr0nnynrNh/3r0YE2lk/n1yar78j+m8Z2Fe60fVaF/IL2JasnaR4TpZP7qVqtPyiMD+
         8nMAOWDYFkaIjXgBX5cPZ8IKen5SRatdTarJKG4FSt7C3Q/awJUmaAspZj3d4TfnWkug
         WFvLhAcEgpZsbKJOy2ZwNPmZl+iLnq+IB+jxGYBbqIYRehNUsXBePAuMvu0G7CDGNRow
         0sueRRVqGIZddz3s0UOPYjXcJR29p7CKBdb2rUKNyZ5NB7oEoCyZMF0b2RO/NviwU6AK
         9V8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dikOEtKsjpSnaSM6EeOCvys/XjUwuAHcvPk4ndAPdHw=;
        b=AtMkunXrErGth9XOLYtTCP3f9yTjMPKEWzYo3PIzgD9gQfMxRzq8+hXsrpItJyFX+w
         CePoYTIGV6653rP7hvWvno74WWUp/6YkM8wB9/8JKezCJC5oXw6jV+H7V2bbVT5lbujY
         s/05+wkw13DSCJ5ZknzPd4a682YSyHBqdnll03dCkFIHyq14c/BcSsOC/+GN7X/piieT
         JuAagjgALmvoamhc1XiQmPD078gWEZkpeEHMDAYNMMOx0pqFQL7KLf1AKuaSUUl5RXHU
         OaRhxtNAUtqmIu/wiw4W5X3/3NaXG9NFmtjIMYx6wfiYAWCCJUXNAN3PydsOb/hNfJVp
         +Dow==
X-Gm-Message-State: AOAM530bhk7G/sVhY+49UVr9aYXQe1pGRP/BB7kuRAlO0FK2+eWY+oSo
        qXpqdGSfkW9aITtEpKivGFA=
X-Google-Smtp-Source: ABdhPJxKUhy1wkjiDM88Lx/kWnHYTq+k4qyZ1TgnfXEQA/btpVvWYWl1NPYV9wQnb2DoFgGXCNAICg==
X-Received: by 2002:a05:620a:753:: with SMTP id i19mr27343988qki.320.1620963199268;
        Thu, 13 May 2021 20:33:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v22sm3738581qtq.77.2021.05.13.20.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 20:33:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20210428065440.3704-1-roger.lu@mediatek.com>
 <20210428065440.3704-4-roger.lu@mediatek.com>
 <20210506045115.GA767398@roeck-us.net>
 <7a7a07adedf5d3f430fecf81aed35c6321e5b634.camel@mediatek.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v16 3/7] soc: mediatek: SVS: introduce MTK SVS engine
Message-ID: <ec5f064f-41f1-f8f9-9a6d-fdf02c43cb8d@roeck-us.net>
Date:   Thu, 13 May 2021 20:33:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <7a7a07adedf5d3f430fecf81aed35c6321e5b634.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/13/21 8:10 PM, Roger Lu wrote:
> Hi Guenter,
> 
> Sorry for the late reply and thanks for the notice.
> 
> On Wed, 2021-05-05 at 21:51 -0700, Guenter Roeck wrote:
>> On Wed, Apr 28, 2021 at 02:54:36PM +0800, Roger Lu wrote:
>>> The Smart Voltage Scaling(SVS) engine is a piece of hardware
>>> which calculates suitable SVS bank voltages to OPP voltage table.
>>> Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
>>> when receiving OPP_EVENT_ADJUST_VOLTAGE.
>>>
>>> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
>>> ---
>>>   drivers/soc/mediatek/Kconfig   |   10 +
>>>   drivers/soc/mediatek/Makefile  |    1 +
>>>   drivers/soc/mediatek/mtk-svs.c | 1723
>>> ++++++++++++++++++++++++++++++++
>>>   3 files changed, 1734 insertions(+)
>>>   create mode 100644 drivers/soc/mediatek/mtk-svs.c
>>>
>>
>> [ ... ]
>>
>>> +
>>> +	svsp_irq = irq_of_parse_and_map(svsp->dev->of_node, 0);
>>> +	ret = devm_request_threaded_irq(svsp->dev, svsp_irq, NULL,
>>> svs_isr,
>>> +					svsp->irqflags, svsp->name,
>>> svsp);
>>
>> 0-day reports:
>>
>> drivers/soc/mediatek/mtk-svs.c:1663:7-32: ERROR:
>> 	Threaded IRQ with no primary handler requested without
>> IRQF_ONESHOT
>>
>> I would be a bit concerned about this. There is no primary (hard)
>> interrupt handler, meaning the hard interrupt may be re-enabled after
>> the default hard interrupt handler runs. This might result in endless
>> interrupts.
> 
> Oh, we add IRQF_ONESHOT in "svs_get_svs_mt8183_platform_data()" for
> threaded irq. So, please kindly let us know if we need to set more
> flags or any other potential risks we should be aware. Thanks in
> advance.
> 

After reviewing the code, I think this was actually a false alarm,
at least if svsp->irqflags always includes IRQF_ONESHOT.
The code is kind of unusual, though. Unless I am missing something,
svsp->irqflags is only set in one place and it is always set
to IRQF_TRIGGER_LOW | IRQF_ONESHOT. If there is a remote chance
that the flag is ever different, it would have been better (and less
confusing) to specify IRQF_ONESHOT directly when requesting the
interrupt (because it is always needed, no matter which SOC).
If the flags are always the same, there is no reason for having
the svsp->irqflags variable in the first place.

Thanks,
Guenter
