Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71512973F7
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 09:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfHUHx0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 03:53:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45004 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfHUHxZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 03:53:25 -0400
Received: by mail-lf1-f68.google.com with SMTP id v16so1057887lfg.11
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 00:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4WkbNxIuQHcMyi/6jdTaT2GJS3hfGOuis/4XMY+Hqv0=;
        b=XJpPbfj8P9QJPx+MXLpw/Zpk11zobJZrO2DKY2mgHVIboqYEIp2ho60EdmJ3Y6AYhx
         QSp2QIWv3+2jDYAwohs4rK6Vso5/KH0plNFbkiVQOUBT0vvmNKlwTtmxhBUeNyVviVPx
         n0fZo6b8dEC6PfFj/iWpjszsR9aKv8/foAkPe46cmiTYeN3GdlFzCc3FTBNrpw6P2R76
         OT8VBJsJZ11Equt8nnFkW29jpyKvGrmiU9lOd3X/v46bDxzBHa36K1mJnZ5TV0a6SHaW
         cM/oolufmA0f6Y6h+Se5FCifYLechXV2U57q5/+CIRUGI5wzReLVnaH0QEGrl+dt23hj
         sLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4WkbNxIuQHcMyi/6jdTaT2GJS3hfGOuis/4XMY+Hqv0=;
        b=YgGzIKkoSTS/JgHMV3xfdieTNvqCfCugYJvfEUh824cj5ciPTScxpGIGwC4o2bokfO
         PpA2f1/BAsPETNB+BVB5/QFQeRCV3xR30y/j4CPlPeqmQbLfTRsHAa18SECdLqEJCQHX
         ixDryIo6CB+IiROd7tn18aeNX8q3XkCOLHc7WvctG/6cAIZlWU+6anJC7T/hUhMvzu04
         zOtJjsYZOYAExsZa89Uk7tJh0BQ8Fnw5jGakljIjsywUOcNofzV72etyemvQwBQD7kld
         QOJhfKGPa2fOn++42JlWZdJvbzkqzQ93oWKuXuSEBbqHuE3LhDxOQSu/g+kKWuiPiAKx
         lmMA==
X-Gm-Message-State: APjAAAVG5UDQyi4oXDK0mUD0k08hBNICFPZPpugKrqy4gxwz6hqG2Yzg
        itPbO2fZHvyv63MmbYRTDz9Yw3gXbFk=
X-Google-Smtp-Source: APXvYqyhZXLsc3Atd+lyJOsKNYthp6F6CwMZKFd5dNFZ+MASXA4v3XjQhoGKDCwuBYhc8sOqNq42Ww==
X-Received: by 2002:ac2:4ac4:: with SMTP id m4mr17369662lfp.172.1566374003532;
        Wed, 21 Aug 2019 00:53:23 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id p28sm3254972lfh.55.2019.08.21.00.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 00:53:22 -0700 (PDT)
Subject: Re: [PATCH 1/2] venus: use on-chip interconnect API
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Aniket Masule <amasule@codeaurora.org>,
        Linux PM list <linux-pm@vger.kernel.org>
References: <20190814084701.25455-1-stanimir.varbanov@linaro.org>
 <20190814084701.25455-2-stanimir.varbanov@linaro.org>
 <cc85f55c-3d21-c3b2-6848-e48513263e39@linaro.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <939ace85-e006-db6d-02d2-b55385fa5043@linaro.org>
Date:   Wed, 21 Aug 2019 10:53:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cc85f55c-3d21-c3b2-6848-e48513263e39@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Georgi,

Thanks for the review!

On 8/20/19 12:34 PM, Georgi Djakov wrote:
> Hi Stan,
> 
> On 8/14/19 11:47, Stanimir Varbanov wrote:
>> This aims to add a requests for bandwidth scaling depending
>> on the resolution and framerate (macroblocks per second). The
>> exact value ff the requested bandwidth is get from a
> 
> s/ff/of/
> 
>> pre-calculated tables for encoder and decoder.
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  drivers/media/platform/qcom/venus/core.c    | 34 +++++++++++
>>  drivers/media/platform/qcom/venus/core.h    | 14 +++++
>>  drivers/media/platform/qcom/venus/helpers.c | 67 ++++++++++++++++++++-
>>  3 files changed, 114 insertions(+), 1 deletion(-)
> 
> It looks like venus can be built-in, so how about the case when venus is
> built-in and the interconnect provider is a module? Maybe add a dependency in
> Kconfig to depend on INTERCONNECT || !INTERCONNECT?

yes, I forgot about that dependency.

> 
>>
>> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
>> index 0acc7576cc58..19cbe9d5d028 100644
>> --- a/drivers/media/platform/qcom/venus/core.c
>> +++ b/drivers/media/platform/qcom/venus/core.c
>> @@ -5,6 +5,7 @@
>>   */
>>  #include <linux/clk.h>
>>  #include <linux/init.h>
>> +#include <linux/interconnect.h>
>>  #include <linux/ioctl.h>
>>  #include <linux/list.h>
>>  #include <linux/module.h>
>> @@ -239,6 +240,14 @@ static int venus_probe(struct platform_device *pdev)
>>  	if (IS_ERR(core->base))
>>  		return PTR_ERR(core->base);
>>  
>> +	core->video_path = of_icc_get(dev, "video-mem");
>> +	if (IS_ERR(core->video_path))
>> +		return PTR_ERR(core->video_path);
>> +
>> +	core->cpucfg_path = of_icc_get(dev, "cpu-cfg");
>> +	if (IS_ERR(core->cpucfg_path))
>> +		return PTR_ERR(core->cpucfg_path);
>> +
>>  	core->irq = platform_get_irq(pdev, 0);
>>  	if (core->irq < 0)
>>  		return core->irq;
>> @@ -273,6 +282,10 @@ static int venus_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		return ret;
>>  
>> +	ret = icc_set_bw(core->cpucfg_path, 0, kbps_to_icc(1000));
>> +	if (ret)
>> +		return ret;
>> +
>>  	ret = hfi_create(core, &venus_core_ops);
>>  	if (ret)
>>  		return ret;
>> @@ -355,6 +368,9 @@ static int venus_remove(struct platform_device *pdev)
>>  	pm_runtime_put_sync(dev);
>>  	pm_runtime_disable(dev);
>>  
>> +	icc_put(core->video_path);
>> +	icc_put(core->cpucfg_path);
>> +
> 
> Do you have any plans to scale the bandwidth on suspend/resume too?

Yes, we definitely need that in suspend/resume, but I guess the plan
should be add it once we implement pm_runtime autosuspend functionality
in order to easily test that.

-- 
regards,
Stan
