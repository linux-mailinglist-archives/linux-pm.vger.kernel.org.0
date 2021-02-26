Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCCB325F78
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 09:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhBZIwm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 03:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhBZIwm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 03:52:42 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC75C061574
        for <linux-pm@vger.kernel.org>; Fri, 26 Feb 2021 00:52:01 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k66so7076428wmf.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Feb 2021 00:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4I/9T27v5fuw5VieFV0ytWcSNAk1Bbl6fxq7D/9O4Aw=;
        b=Jfw6tP2FVDpP7xS8MbqMlicPR0GZnIVCgiPOcK/MiszbWN4L4KBSdO2/h25VIMSeG+
         7SAwS2q8Z7P7hrGER2mdTBRT+q3vSFnUVkeBj0HKYrJXd4mYDNLP2/ale6YrMg77bPz0
         cYNXpUSSVzBgaTjGEEnvD3AM5sC0dr0P4pJs0MKmJ6VJrXscOFoCFmXm67XVlGZkroIf
         TaP6BORXDmqVcynMjwc/tOSyFlPPV86DiB3empT8quFbYyXauzuVEM5kbtqChu5KNtvY
         465h+fe4lpEQPLCTH3jrcXW9iHfbdBl9PyMrmL6Jr6pVxOt8ZneYJOpwGsa8EOXudSNN
         vDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4I/9T27v5fuw5VieFV0ytWcSNAk1Bbl6fxq7D/9O4Aw=;
        b=bzU6uc+cARYpGFpa/6peJGxVPz2lvG1MbHyMuUmYf0BqTJ7PJaAlLrDLbLn9wFxHYS
         3oqi2OvzplHNsN2I7qnXoL7Sig4UH3rnZZA40P2gl0s2WdBxas4JRSsijNSaq9s+Jzco
         K5XdBDLQuktQ4oFnCpy0cEwojiUpgTFmWN9rCoukY3I7mbfoVe/O4tnEOKqB/qD9og71
         aE176K1uvfjh1ndIXGtMufxJS5fpB3W2GqNYqexxtZSa19oA7aKIJ7/DL6TWukNBweoP
         jejmI2juTGC7Sh9wpORQA5pmDzjw0lJXv8lVUpzhau0lpWXimDs9t2WmWDx5BR1b4EcR
         5i5Q==
X-Gm-Message-State: AOAM532sbYjtgN4akA6/BvavbkSdb8/ao5RysrDyKf6r7l3DwtZBWO4Y
        NcSsWsK16GfQi0sikeZShFqD9jDgNHQZ3A==
X-Google-Smtp-Source: ABdhPJxHPYGVqRr09nDy1S17EJWwgU6sW5Cb/LJlPKbA3dZHEnjVzSLya6Tdt5HY+7+SnowqHW6fVw==
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr1706548wmh.137.1614329520071;
        Fri, 26 Feb 2021 00:52:00 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:f137:d18c:50a6:cc6a? ([2a01:e34:ed2f:f020:f137:d18c:50a6:cc6a])
        by smtp.googlemail.com with ESMTPSA id j16sm12393890wra.17.2021.02.26.00.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 00:51:59 -0800 (PST)
Subject: Re: [PATCH v2 3/9] devfreq: Use HZ macros
To:     Chanwoo Choi <cwchoi00@gmail.com>, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
 <20210224144222.23762-3-daniel.lezcano@linaro.org>
 <0db79cd7-f062-b31b-2a6c-ecf8dadaf572@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <09954745-5b39-8718-ca79-3e92a85e5ace@linaro.org>
Date:   Fri, 26 Feb 2021 09:51:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0db79cd7-f062-b31b-2a6c-ecf8dadaf572@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/02/2021 07:08, Chanwoo Choi wrote:
> 
> 
> On 21. 2. 24. 오후 11:42, Daniel Lezcano wrote:
>> HZ unit conversion macros are available in units.h, use them and
>> remove the duplicate definition.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Reviewed-by: Christian Eggers <ceggers@arri.de>
>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>   drivers/devfreq/devfreq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index bf3047896e41..b6d63f02d293 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -26,6 +26,7 @@
>>   #include <linux/hrtimer.h>
>>   #include <linux/of.h>
>>   #include <linux/pm_qos.h>
>> +#include <linux/units.h>
>>   #include "governor.h"
>>     #define CREATE_TRACE_POINTS
>> @@ -33,7 +34,6 @@
>>     #define IS_SUPPORTED_FLAG(f, name) ((f & DEVFREQ_GOV_FLAG_##name)
>> ? true : false)
>>   #define IS_SUPPORTED_ATTR(f, name) ((f & DEVFREQ_GOV_ATTR_##name) ?
>> true : false)
>> -#define HZ_PER_KHZ    1000
>>     static struct class *devfreq_class;
>>   static struct dentry *devfreq_debugfs;
>>
> 
> I changed the patch title with 'PM /' prefix as following
> in order to keep the consistent patch style if there are no any special
> objection.
> - PM / devfreq: Use HZ macros
> 
> Applied it.

It should not compile. This patch and others depend on 1/9.

It would make sense to merge all of them through linux-pm.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
