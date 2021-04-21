Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005253674C3
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 23:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238497AbhDUV0E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 17:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbhDUV0E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Apr 2021 17:26:04 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C34EC06174A;
        Wed, 21 Apr 2021 14:25:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u21so65612012ejo.13;
        Wed, 21 Apr 2021 14:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ny2kEnyo7Qi04YTjwjJRHOQYn7iwOMQlxio8u8f9oME=;
        b=TGhZcmSHGvFBWiziBTPgqew8rGLP8dO2lOjqCvxfmV5bxYjSEgZMU+GMsOiBli/hhm
         b0yA1DipTvvzshC9i+tbvH7TWeVtvk9U6lkuteE/q9XK/m/0SJ8vDUm82QyLefp+CuKs
         EIefupkNUxDTFRvuu+fJmj+UyGqLsG4Dp8vLHpY5ykSYpA3tcyBgf+RrMSeaKhOoQVXJ
         FhZBjbSJlT0PYe+UL9y7cYOVyaxHFYTHqAOREde6iBCAvpFjM37SuiVrpjYymaaXxO+F
         1sdm3niazY8jYO9HI32KARky2fW2g/e9fuYowGARyCyeDn8rgZ/OVITpP7DD1PifYqLZ
         n8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ny2kEnyo7Qi04YTjwjJRHOQYn7iwOMQlxio8u8f9oME=;
        b=t43O+l6Ux9xYPELphR6ZJ0JhEj5QEJAwbZMs4S2T7VDOqUOxU3sH5rhMUs5IQsL0pl
         iNDwKf+nEI5OKed0QGmPkyfiHAJZ/Oz41hKqS1IL2YngqCfCT5sT8B/hh0JSMNYIXpxr
         TcZ5seAE2VvcIxVbQbFcMflhqPp0V1dLtmmYAo48tlGADeizhPM/V5EbgLHjtK1HuMCh
         S/iK3ZykWHRsHt4L9wrYcqjt71lvMfzL7+/HSz/BNJUTf+MgnJ175epfR0FuTZkoAUMF
         03Tps2UYAi51ib+CZJk/N6Nb1BXReioJdYZlf41H4jDDmeHjSlOpJWBBp4i2Wkjk0NYz
         fgyQ==
X-Gm-Message-State: AOAM5325H5+k0Rd5NucRzmQcnTd5ErFd1u8clIWXESbRGDiAJYav3MzR
        0lNvtzvlFm/Do1+L4db0v1E=
X-Google-Smtp-Source: ABdhPJxHp/YPbTxnqWQSu7qWAhxJI0ZWNOda59M46PXcOUGBpKMOBetJiJNE1r2BHu2yXMOC/N0cQQ==
X-Received: by 2002:a17:906:f41:: with SMTP id h1mr25243745ejj.399.1619040328314;
        Wed, 21 Apr 2021 14:25:28 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k14sm453192edr.75.2021.04.21.14.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 14:25:27 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: rockchip-thermal: Support the RK3568 SoC
 compatible
To:     Ezequiel Garcia <ezequiel@collabora.com>, linux-pm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Finley Xiao <finley.xiao@rock-chips.com>, kernel@collabora.com
References: <20210421200445.32977-1-ezequiel@collabora.com>
 <557ae27c-1d62-69e0-7ae6-921571059f9f@gmail.com>
 <31272ad0e6a5274080831406796960506c6a6912.camel@collabora.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <ca5d55ef-e364-be7a-5ad6-81f039c691e6@gmail.com>
Date:   Wed, 21 Apr 2021 23:25:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <31272ad0e6a5274080831406796960506c6a6912.camel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/21/21 11:06 PM, Ezequiel Garcia wrote:
> On Wed, 2021-04-21 at 22:46 +0200, Johan Jonker wrote:
>> On 4/21/21 10:04 PM, Ezequiel Garcia wrote:
>>> Add a new compatible for the thermal sensor device on RK3568 SoCs.
>>>
>>> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
>>> ---
>>>  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>>> index 7f94669e9ebe..346e466c2006 100644
>>> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>>> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>>> @@ -9,6 +9,7 @@ Required properties:
>>>     "rockchip,rk3328-tsadc": found on RK3328 SoCs
>>>     "rockchip,rk3368-tsadc": found on RK3368 SoCs
>>>     "rockchip,rk3399-tsadc": found on RK3399 SoCs
>>
>>> +   "rockchip,rk3568-tsadc": found on RK3568 SoCs
>>
>> This is still a text document.
>> rob+dt has now scripts that check for undocumented compatibility
>> strings, so first convert rockchip-thermal.txt to YAML and then add this
>> in a separated patch.
>>
> 
> Is it a showstopper to convert devicetree bindings to YAML for driver submission?

You now that hardware best, so try to fix the documents as well.
The new norm is YAML, so aim for that.
Try to submit a complete package of YAML, driver (and dts nodes) for review.
New nodes should not generate more notifications then we already have.

Johan
> 
> Thanks,
> Ezequiel
> 

