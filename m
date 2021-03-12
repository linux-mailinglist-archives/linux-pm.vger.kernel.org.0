Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF75033927A
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 16:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhCLPyL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 10:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhCLPx5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 10:53:57 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA94C061761
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 07:53:57 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j18so2046068wra.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Mar 2021 07:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nf/x3zdOo4NltH5YdliW8QtzzVE+SJmh6Ofm5Su6NTI=;
        b=DPoPxHIC42Nu7DXh2UsEAnJWPFfA50NY9vRtjTTu52q/y2IropDXGPAanOKL276Dux
         /yBBODZK/+F0U2WDPTSeqONqwea06TkjA00UKGmBvd7aIMO1N3odzUpf12f0jNO4IQ70
         NBNbtrI7KpVb1DMvauN+htMpb4eQ5TgBoY81JaKbJ+mZQ11eFi0Yxr9/Zmc8tAS9Ar7O
         1fGOK1KCMrQ8AUsSNR/VgkUIPziYbegKu35VvAVMrjcyRSc4xI7Lgrn/9iyqltNROjOP
         1s3UGwvKG+1cr2Dd12gq1GxOVY3tuYQiNAizic26XSjKGLZdMuXSQBr0N+fgfPMDXDHL
         E5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nf/x3zdOo4NltH5YdliW8QtzzVE+SJmh6Ofm5Su6NTI=;
        b=i9uHC9c/dG/oSa9V0hzJ8AfA0GLYW2IcJ4NSMar8vFblmS3YqVCm3wAmaWdu2gPwM2
         HuBELfmEHD+jVf45rZGtHD657OD3aV7eGn7KbkUa0lSjUkJOxYd+sXPbCmeehnTbMrzf
         XJrGrxcJXFDu0ZEFCQdUR48aE3tXDJsTgA6qEH/elJjI0fMQQ52G31fuU20C4KnjQA5q
         TPGHQ0OFp66cb68bwNL7HkXmfU6UVGBVvRLE2HDmK8nzyd4c8nExSUnST8kQnlEmp6Nb
         jDibB/JTWWHv0tk4YKCquAyz8AKQZx5DWwKTdCjzEJbHSGLT+60nowDl5Qy4MHkgRayS
         4Pxg==
X-Gm-Message-State: AOAM532Ja5URTrZ2A01lU1+VQr/t127W1YPgu1jSsI8RJxCrcf9US+3U
        5tcY4yshK3ajjV4unkneGU1q+Q==
X-Google-Smtp-Source: ABdhPJyOgIySm2XuuxssRqoflifsys8dPKXZGlhOXbB4SqKGDnrsUhWWwqynyp7g5FQ058K4gPpjoQ==
X-Received: by 2002:a5d:4903:: with SMTP id x3mr14701303wrq.143.1615564435935;
        Fri, 12 Mar 2021 07:53:55 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:cc8a:6653:68f4:ff69? ([2a01:e34:ed2f:f020:cc8a:6653:68f4:ff69])
        by smtp.googlemail.com with ESMTPSA id h22sm2964654wmb.36.2021.03.12.07.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 07:53:55 -0800 (PST)
Subject: Re: [PATCH 2/3] thermal/drivers/devfreq_cooling: Use device name
 instead of auto-numbering
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rui.zhang@intel.com, amitk@kernel.org, linux-pm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
References: <20210310114600.27178-1-daniel.lezcano@linaro.org>
 <20210310114600.27178-2-daniel.lezcano@linaro.org>
 <8f17dc8b-3259-8e6a-f46b-b97495ecd550@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <345395f7-006d-c879-a777-c24d79ae9e23@linaro.org>
Date:   Fri, 12 Mar 2021 16:53:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8f17dc8b-3259-8e6a-f46b-b97495ecd550@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/03/2021 12:15, Lukasz Luba wrote:
> 
> 
> On 3/10/21 11:45 AM, Daniel Lezcano wrote:
>> Currently the naming of a cooling device is just a cooling technique
>> followed by a number. When there are multiple cooling devices using
>> the same technique, it is impossible to clearly identify the related
>> device as this one is just a number.
>>
>> For instance:
>>
>>   thermal-devfreq-0
>>   thermal-devfreq-1
>>   etc ...
>>
>> The 'thermal' prefix is redundant with the subsystem namespace. This
>> patch removes the 'thermal prefix and changes the number by the device
> 
> missing ' after 'thermal
> 
>> name. So the naming above becomes:
>>
>>   devfreq-5000000.gpu
>>   devfreq-1d84000.ufshc
>>   etc ...
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

> ---------------------------------------------------------
> 
> We should allocate tmp buffer for it, to not loose the meaningful part
> of that string name or end up with only the same prefix, like for the
> first 3 from top:
> 
> devfreq-18321000.qco
> 
> or for the GPU:
> devfreq-3d00000.qcom
> 
> This is tricky area and vendors might put any non-meaningful prefix.
> 
> The rest of the code looks OK, only this name construction part.

That requires a change in the thermal_core code to replace the strlcpy
into the cdev->type by a kstrdup.

Otherwise the name will be truncated in any case by the underlying
thermal_cooling_device_register() function.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
