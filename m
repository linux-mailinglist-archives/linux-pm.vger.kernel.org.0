Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0D52B5EE1
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 13:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgKQMJE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 07:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKQMJE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2020 07:09:04 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F857C0617A6
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 04:09:02 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id m6so5745647wrg.7
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 04:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R8dAViY8msWj5ESa9dcD3pUSNcXzBcfrUpBmPTelzyc=;
        b=ZEd4OKYk3irAFmWaAXOmUTa8XmNwL88+FAsivIc4nfLbCqetziHZqTzfXNo9txn3sO
         nTTc0D7HQdG0IeDZ4LcGxJtIhgyssJ4uYSV10b/W8p6LrijC/ZPTH9CdthDuZhEbSe2w
         DCtQrW9qjekN74A0u9xZ//F7yFZkKtVEfICMxXJAgzu5oh39+205XNjI8qYBitBfwWRN
         Y7xUVSoTFce9h3yS/88QC82d8h6MUwlGXQwnJ5WtdzrPFSTnI4jO3hbEfQejQG3Kul9S
         F7CZoTwyGi0aqdE8iLVThZOMwH3FRg/PHBbHi2nl3smAx9/CR5kJVGJqt5k0cCrKS2fh
         Csqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R8dAViY8msWj5ESa9dcD3pUSNcXzBcfrUpBmPTelzyc=;
        b=NdQflctFSHHSdKaJqgfo72u+UwE+urJNC5yukhaTiM9ffOIyKPFZ8L5e3Pjkv4UK9L
         9qBGn6CHfprWv6UnB7VOLq7Q3GKgqw0HYsx/f+oxZHL/79kiNAwboWIBkGfIxw7hMSEc
         rBvBQTFWvlLNm0ywvR1hy2DgZ4/OsWbX6KrvWmAHi97M42o54ze5QGTePPXa0tCWBnF1
         /W23a/gvGmMOuS4UD85lSH89gQBhWT2383jqaLIYzuCeeiPdgkyLnTJ3Kk81vYAnGx0n
         25wh5zhVwCbK5J1kj4XHgw8QiJs9wgEi7NqGDgnUNGDdyLDIqteci7ZFQVgZXpynvMXa
         SpAg==
X-Gm-Message-State: AOAM533q4SrLF5V/f/UyoH+EHLPR15/NYkcSQL2Xh3sSni/KLCpxja8u
        Di+bVEKHRip2PfmmkwwR2QKFiQ==
X-Google-Smtp-Source: ABdhPJzvnQM767MDO2iPjxVy07/dEBSpvVqRLyRjykXZJG0tG5GIdts8miBt60QlPflRrcE7z4INDg==
X-Received: by 2002:adf:cf0b:: with SMTP id o11mr24131017wrj.162.1605614940689;
        Tue, 17 Nov 2020 04:09:00 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6186:703a:2abc:2187? ([2a01:e34:ed2f:f020:6186:703a:2abc:2187])
        by smtp.googlemail.com with ESMTPSA id u5sm22560954wro.56.2020.11.17.04.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 04:09:00 -0800 (PST)
Subject: Re: [PATCH] thermal: Fix NULL pointer dereference issue
To:     Zhang Rui <rui.zhang@intel.com>,
        Mukesh Ojha <mojha@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     amitk@kernel.org
References: <1605544181-5348-1-git-send-email-mojha@codeaurora.org>
 <4e28affd89ba8a852e0fb7ace076458b3d43839a.camel@intel.com>
 <f8c436ae-0f4c-5d2e-51a8-0e856fbf8f44@linaro.org>
 <fd11744b16a91428303fe848ef8f72fd8f5c9a5e.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ae8a6805-7071-269d-f49a-7e1051cfb399@linaro.org>
Date:   Tue, 17 Nov 2020 13:08:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fd11744b16a91428303fe848ef8f72fd8f5c9a5e.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/11/2020 12:27, Zhang Rui wrote:
> On Tue, 2020-11-17 at 09:57 +0100, Daniel Lezcano wrote:
>> On 17/11/2020 08:18, Zhang Rui wrote:
>>> On Mon, 2020-11-16 at 21:59 +0530, Mukesh Ojha wrote:
>>>> Cooling stats variable inside
>>>> thermal_cooling_device_stats_update()
>>>> can get NULL. We should add a NULL check on stat inside for
>>>> sanity.
>>>>
>>>> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
>>>> ---
>>>>  drivers/thermal/thermal_sysfs.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/thermal/thermal_sysfs.c
>>>> b/drivers/thermal/thermal_sysfs.c
>>>> index a6f371f..f52708f 100644
>>>> --- a/drivers/thermal/thermal_sysfs.c
>>>> +++ b/drivers/thermal/thermal_sysfs.c
>>>> @@ -754,6 +754,9 @@ void
>>>> thermal_cooling_device_stats_update(struct
>>>> thermal_cooling_device *cdev,
>>>>  {
>>>>  	struct cooling_dev_stats *stats = cdev->stats;
>>>>  
>>>> +	if (!stats)
>>>> +		return;
>>>> +
>>>
>>> May I know in which case stats can be NULL?
>>> The only possibility I can see is that cdev->ops->get_max_state()
>>> fails
>>> in cooling_device_stats_setup(), right?
>>
>> A few lines below, the allocation could fail.
>>
>>         stats = kzalloc(var, GFP_KERNEL);
>>         if (!stats)
>>                 return;
>>
>> Some drivers define themselves as a cooling device state to let the
>> userspace to act on their power. The screen brightness is one example
>> with a cdev with 1024 states, the resulting stats table to be
>> allocated
>> is very big and the kzalloc is prone to fail.
>>
> Oh, right.
> As we're not going to fix the cdev, so I think we do need this patch,
> right?

If the allocation fails at this level if initialization there is clearly
something wrong. I'm wondering if it would make sense to report back an
error and make thermal_cooling_device_register to fail.

Having an allocation failing and silently ignore it sounds like not very
robust IMO.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
