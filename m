Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 500EC1171ED
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 17:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfLIQjm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 11:39:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34430 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIQjm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 11:39:42 -0500
Received: by mail-wm1-f67.google.com with SMTP id f4so293454wmj.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Dec 2019 08:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3hp3KIVViBlYhyNaxrQl/vOkp9Qr78/nmkZd7Vwi7tg=;
        b=vsiWXLrWyVbcwcS7ZiXaXHR3M7KOaWBmRTiwOrW04ZcHZvE72+qzn0vh4ep/pc/c/U
         Cjil0/XIe9DOELtOf5sfPwMnrYK0kn3StloVXgO07qeDORV5HV7HW2RJkAOQ6+FU4MKq
         ZWfI+6TTalyqYdo8ZnGaBTwSEfh5Knu5w3Yyc7dDuonu5ByZPHeQLCvQpSffOGgjMG7M
         5MnZRxBF1vCTmLfa+88BBvM41ZuOFnqGex7XT+CFoDX8BvKaVTPo34nWSj/qG/yJ5H96
         oDaaDxEzubVznraRqIdY9sU7u9ziZQfzar2jpqwOIvZVla+pVYAke+YzjV42GE1rb8Bp
         q/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3hp3KIVViBlYhyNaxrQl/vOkp9Qr78/nmkZd7Vwi7tg=;
        b=aB1mX1rzF42uq4ze4n77ikfQWvam5QlHfkoqRK3YzIWXz+9eVynIUMHCDkFCUes/YL
         HZUyZ5rjDqYYRZhJA+l1ttdqhWq2wHqfn/BRBLeoy7nmLfHRiEJP2S6cefwhbTLnEC+s
         s0kTfgsp1LR16+TZNY0Ez5N9pVzK8keGyWi1Eq9sOPOdQ66GokVfsdY/gG8pk9Ampx5j
         upkdTwKizbBEftcGT011fthMTaMgAU+uzihTnNwd3esVbkTWxVEqgmx8MmnJpzkTUOLg
         Tb5gltsqIFKObUGJuI8xaCwvv2j9QNsMRRajOqx6/U0c20iyhVSuLio1MVHqI6J8PdZK
         7VzQ==
X-Gm-Message-State: APjAAAVNzhyBbiqFSpswByJ9I3xa88EkFHQ/OjT1R4XMHlChZkyxqXWp
        j8bu9OpD/Zd4lXWnk1NX5TlO1L/WRYM=
X-Google-Smtp-Source: APXvYqzCsTYkRZsdb5Zy6bN+XZcrT25UqtdvQHSJ/dB24vO3nnRPRKjzUMVwS7jqcMuFnzUPT9Lrzw==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr25063009wmc.78.1575909578840;
        Mon, 09 Dec 2019 08:39:38 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:3114:25b8:99b8:d7fe? ([2a01:e34:ed2f:f020:3114:25b8:99b8:d7fe])
        by smtp.googlemail.com with ESMTPSA id x6sm354559wmi.44.2019.12.09.08.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 08:39:38 -0800 (PST)
Subject: Re: [PATCH v2 1/2] thermal: armada: fix register offsets for AXP
To:     Zak Hays <zak.hays@lexmark.com>
Cc:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1575485367-18262-1-git-send-email-zhays@lexmark.com>
 <BN8PR10MB3379A954079A4ECF574E80DE8C5D0@BN8PR10MB3379.namprd10.prod.outlook.com>
 <e2ed2a04-83c0-b346-4de0-0f92d6dd7fbf@linaro.org>
 <BN8PR10MB33792C7BA3B1D002AEDD25E08C580@BN8PR10MB3379.namprd10.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6c4e79ab-313c-5bb5-1489-329d916bd947@linaro.org>
Date:   Mon, 9 Dec 2019 17:39:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <BN8PR10MB33792C7BA3B1D002AEDD25E08C580@BN8PR10MB3379.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/12/2019 17:31, Zak Hays wrote:
> Hi Daniel,
> 
>> Hi Zak,
>>
>> what patch to pick up? V2 or V2?
> I'm not sure I entirely understand your question. There are two patches:
> 
> Zachary Hays  thermal: armada: fix register offsets for AXP
> Zachary Hays  thermal: armada: clear reset in armadaxp_init

I'm seeing multiple posting of the V2 and reply to V2 with I guess a
changelog added.

It is very difficult to deal with patches when it is unclear, duplicate
series with different changelog.

In the future, post a resend version explaining what was missing, so it
is easier to understand what is happening. Or send a V3.

> Version 2 of each patch updates the commit message to add a "Signed-off-by"
> and cleans up the commit message per Miquèl's earlier comments. Otherwise the
> patches are the same as they were in version 1. The patch below is version 2 of that first patch.
> 
> Does that answer your question?
>>
>> What email is the correct one?
>>
>>        Zachary Hays <zhays@lexmark.com>
>> or
>>        Zak Hays <zak.hays@lexmark.com>
>>
> Both addresses route to the same place but "Zachary Hays <zhays@lexmark.com>" is preferable. Sorry for the confusion.
> 
>> Also waiting for Miquel to ack the patch.
>>
>> Thanks
>>
>> -- Daniel
>>
>>
>> On 05/12/2019 15:19, Zak Hays wrote:
>>> As shown in its device tree, Armada XP has the control1 register at
>>> 0x184d0, not 0x182d0.
>>>
>>> Signed-off-by: Zachary Hays <zhays@lexmark.com>
>>> ---
>>> v2: update commit title and add "Signed-off-by"
>>> ---
>>>  drivers/thermal/armada_thermal.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
>>> index 709a22f455e9..88363812033c 100644
>>> --- a/drivers/thermal/armada_thermal.c
>>> +++ b/drivers/thermal/armada_thermal.c
>>> @@ -578,7 +578,7 @@ static const struct armada_thermal_data armadaxp_data = {
>>>         .coef_m = 10000000ULL,
>>>         .coef_div = 13825,
>>>         .syscon_status_off = 0xb0,
>>> -       .syscon_control1_off = 0xd0,
>>> +       .syscon_control1_off = 0x2d0,
>>>  };
>>>
>>>  static const struct armada_thermal_data armada370_data = {
>>> --
>>> 2.7.4
>> >


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

