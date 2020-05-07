Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BD21C7F83
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 03:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgEGBA0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 21:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgEGBA0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 21:00:26 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C198C061A0F;
        Wed,  6 May 2020 18:00:26 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h26so2986630lfg.6;
        Wed, 06 May 2020 18:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x/pZlFx1RwiUZJoCBeew19ILHCP9+NjHgoBLA53ee50=;
        b=RF5u0D9bm1d9Lcf9cSby+XZ8opBSg/msSDr4EVmmJrI/xH8FWeWHoBpoGXaO82LAqv
         Y9JXHttF/5uWtCrvohiqWxX/WyuOwHxnNp2Uz0TF6djsp1KobJmXNB1H+4hR8hRQVWV8
         oM91RdaofZA2D4im2+2y+PVuM+MK7LfVARlZtnP8de27BBUdQrV71xklp2XxIM7lEF6U
         9ckQtqgQdXLUd42FoBqdWEW67Z1FNq32TQJozxZUrCpzKD0x4JWPQ6iObv5KpwZ/SQxl
         XD3V5BbP1IaM9V6BFhvqX2SVlmzjbuQe8ljTXrRh+vRE3LsLDKvftOS+JxXA/MOgKTG6
         9NlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x/pZlFx1RwiUZJoCBeew19ILHCP9+NjHgoBLA53ee50=;
        b=Sf8WgT//PP5U13iWOVZPExExwcaalDGyyZ4Uu8sfKzvdZcWupKHVBLayy30IMsTDce
         BzoCIfHZsQZl/ZvNmbq/qmOlxuhGN/YhWsiJZzrrUYZDNikVxHUmLv411KoYFF1jTViF
         yBVCE973WjtDCVXhaNMa6SDwnxCpeRKNXGTdWkauqeTbez13JhRyv7f82XTSGo30WdCQ
         ALUlN4p5yQWvzs2VXp9OqQd/D+hX5+ndmnJzhiVpHoGd+irudEgzcFmV+rKO5utG2cOn
         kzeAW3dHEmiXsIigSBsr+Bhmzw7AF3qEfF4HrsXpkQm5S5F1fypDVqOkmFTthNqY4VTe
         3J9A==
X-Gm-Message-State: AGi0PuZfwXsFaTI5jL3czjFKSeQlN7ihY7EmKo9UfUBkrrciFWIaeYqy
        bGMYWWiEUr9h9rx5xVRmNXksKzCo
X-Google-Smtp-Source: APiQypIWbwmS6V3GGTaAw2KeMRv/gzBqIq6q9uK4P3B+ValQqQwAUDA9fZyUzDluN1edCymwlzGmnA==
X-Received: by 2002:ac2:5282:: with SMTP id q2mr5720769lfm.100.1588813224087;
        Wed, 06 May 2020 18:00:24 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id t13sm2288000ljd.38.2020.05.06.18.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 18:00:23 -0700 (PDT)
Subject: Re: [PATCH RE-SEND v1] PM / devfreq: Replace strncpy with strscpy
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200227170854.9949-1-digetx@gmail.com>
 <CGME20200417140545epcas1p38cdc6cc5e6059437e611cf7e771d0dbd@epcas1p3.samsung.com>
 <09712864-01a5-e2f9-b55f-e822169d30fc@gmail.com>
 <41092ded-8bb6-726f-6986-fee62a8a1325@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0cd53502-e876-b26d-5a48-092707395509@gmail.com>
Date:   Thu, 7 May 2020 04:00:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <41092ded-8bb6-726f-6986-fee62a8a1325@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

07.05.2020 03:02, Chanwoo Choi пишет:
> Hi Dmitry,
> 
> On 4/17/20 11:04 PM, Dmitry Osipenko wrote:
>> 27.02.2020 20:08, Dmitry Osipenko пишет:
>>> GCC produces this warning when kernel compiled using `make W=1`:
>>>
>>>   warning: ‘strncpy’ specified bound 16 equals destination size [-Wstringop-truncation]
>>>   772 |  strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
>>>
>>> The strncpy doesn't take care of NULL-termination of the destination
>>> buffer, while the strscpy does.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/devfreq/devfreq.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 8494c5f05a73..2011f64bfa3a 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -769,7 +769,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>  	devfreq->dev.release = devfreq_dev_release;
>>>  	INIT_LIST_HEAD(&devfreq->node);
>>>  	devfreq->profile = profile;
>>> -	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
>>> +	strscpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
>>>  	devfreq->previous_freq = profile->initial_freq;
>>>  	devfreq->last_status.current_frequency = profile->initial_freq;
>>>  	devfreq->data = data;
>>>
>>
>> Hello Chanwoo,
>>
>> Do you have any objections to this patch?
>>
> 
> I'm sorry for late reply. I applied it for v5.8-rc1.
> Thanks.

No problems, thank you :)
