Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71D4113CC95
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 19:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAOSwd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 13:52:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52256 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAOSwd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 13:52:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so1104963wmc.2
        for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2020 10:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XMwpJSuyZ/FJ/sJx/+w9y/4HNCxOgFXw/UXY4aq2WoU=;
        b=qu4RTOSOAaM231BIk+Gd9jxiiS0xXv2RWp1ir13Qn7H8OIyyXq14zcANZzg0Irp4tF
         XDYbAS5WLZpfyRUiV6s/toMSDIUnd9c2TGqdP+60O4MJzSFFEeEie7TB5IQH1eH2srdd
         NbqWnsvqY5TuOOCGGEE8fJDkgsWy6EFwg25G9Avmp0SGtJrE4waENJBbBME5sGCVrrIf
         9wiJp+dsliYyNlHoLPAx60wsIUwq79XPIwOL2OZ+HNHzfOQ0xAxi4siutlnk7fNIDiVB
         rdWw4xMJsGE50fgQnEL83M13ZGQc/P8tWLGoW0BA1CCL/oVzI7gUfKW5KujytfDVD9tG
         o6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XMwpJSuyZ/FJ/sJx/+w9y/4HNCxOgFXw/UXY4aq2WoU=;
        b=ghOAR2La/WvLMQdEjIlnEnEiYvDiecb+ktp2BvMJRR1+EiRvlH52kqve7ntTN2cxWL
         /gZMhAxdEV+h/L5K0YJ2aaEhsxyFtYprpTqW0rRZk2FtLX+1M84iwQAJEFd85DfgmkS1
         +u8GQinSX+octsNUtoerh/vWGCMlLazhKLIkCp6MbF7ysnmFKPkZr03Zl17SDS0brTQJ
         mECX2swrVTNCalwR0kILdCUxI2bQQE6dZW7DDZlOy/pR9GI8PgftUIRkl87izYjAopU7
         +AIlErDTrYCfEuJd8nbtH6H47Rus8SFfml+N+khzRqEQeo7on8Y2oNAvohh28AsCoUPM
         AHWg==
X-Gm-Message-State: APjAAAVwJ2HEN8Lx2Qyam7NPSm4bU80EfFGCHQrwPE3gacAy0XNmmMwT
        +NQnukOWtuBdnur4sTUMEbKQGElVwLvbew==
X-Google-Smtp-Source: APXvYqzzJxDd+ZXrpJJKX4rQf3c4d6SpIn6ogVXfeTlcn6k+uCD0u5K3Fp2sFEJBbd42XpYHJWBRZQ==
X-Received: by 2002:a1c:6809:: with SMTP id d9mr1466698wmc.70.1579114350101;
        Wed, 15 Jan 2020 10:52:30 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:ac8b:fcee:b80:ebae? ([2a01:e34:ed2f:f020:ac8b:fcee:b80:ebae])
        by smtp.googlemail.com with ESMTPSA id n67sm981471wmf.46.2020.01.15.10.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 10:52:29 -0800 (PST)
Subject: Re: [PATCH 1/2] thermal: rcar_thermal: Remove temperature bound
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     linux-pm@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
References: <20200114222945.3128250-1-niklas.soderlund+renesas@ragnatech.se>
 <20200114222945.3128250-2-niklas.soderlund+renesas@ragnatech.se>
 <a98baf8f-e2ef-d77d-ff3c-f5838e268dd7@linaro.org>
 <20200115134559.GA945270@oden.dyn.berto.se>
 <d7c7bb44-897d-a3a3-c203-d87ffb7de9be@linaro.org>
 <20200115183940.GA979534@oden.dyn.berto.se>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <710eeff0-e8f4-5f03-836a-6a2e87e415e8@linaro.org>
Date:   Wed, 15 Jan 2020 19:52:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115183940.GA979534@oden.dyn.berto.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/01/2020 19:39, Niklas Söderlund wrote:
> Hi Daniel,
> 
> On 2020-01-15 19:15:11 +0100, Daniel Lezcano wrote:
>> On 15/01/2020 14:45, Niklas Söderlund wrote:
>>> Hi Daniel,
>>>
>>> Thanks for your feedback.
>>>
>>> On 2020-01-15 14:24:30 +0100, Daniel Lezcano wrote:
>>>> On 14/01/2020 23:29, Niklas Söderlund wrote:
>>>>> The hardware manual states that the operation of the sensor is not
>>>>> guaranteed outside the range of -40°C to 125°C, not that the readings
>>>>> are invalid. Remove the bound check and try to deliver temperature
>>>>> readings even if we are outside the guaranteed operation range.
>>>>
>>>> And what if the sensor is returning crap in this out-of-range operation?
>>>
>>> I'm not sure what is worse, reporting an untrue (but still outside the 
>>> guaranteed operation range) extreme temperature or failing with -EIO.  
>>> The view of the hardware guys is that it's better to report what the 
>>> sensor indicates then to return -EIO.
>>
>> I don't get the point.
>>
>> What happens if we read the sensor while it is above or below the limits?
> 
> The manual describes the read outs as being +/- 2°C from the true 
> temperature for the guaranteed operating range. Outside this range the 
> difference between the true temperature and the read out temperature 
> might be larger than 2°C.

Ok, I see the point now. I guess in any case the SoC won't be working
very well outside of these operating range also.

It would be interesting to add in the core code a warning when reaching
the sensor's operating range. Please replace the code deletion in your
patches by a comment keeping the range values for reference if we add a
sensor boundaries property later.

Thanks
  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

