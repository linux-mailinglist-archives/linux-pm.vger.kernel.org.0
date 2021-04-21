Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D56B367508
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 00:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243705AbhDUWNY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 18:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbhDUWNX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Apr 2021 18:13:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50EAC06174A;
        Wed, 21 Apr 2021 15:12:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id v6so64408453ejo.6;
        Wed, 21 Apr 2021 15:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R+7lOBqLD5Z6bTcs4+c+UgzXRm2npxKYFhj46LfCB+M=;
        b=RnLNg4giHfH1ktF1ZYjXkxbfCpDfkSVazNzxCmpJ2H+gAtqqpTP0zuLNXXtZeRK41Q
         VPO7hFAJPPpWbcwIJqMw9xycXohInbfOaaQGDLsZVEDra6ECEY5LRmu11L1kWBQQ9Byg
         nSh05Zb5tYVk6lMiuxkCmdBI+VbTOoY8CAPCfnY/eOhAQfddZC0baDWQaCN0wdCHPtNy
         kDcPP93R0TalPoVut7B6cJCU5XQyH7vN3bwXArfYTU5tqVqwsXnmkxiPIprAlOKe+ILN
         d63OeuZf74MFE5AmEtuRzFbVrgayct3HLHAYmpSUQBR513m3b/X/jSZ0MswAcSMfKzNA
         kyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R+7lOBqLD5Z6bTcs4+c+UgzXRm2npxKYFhj46LfCB+M=;
        b=DIXa0PSCUexO3qRBov5FduspSEcFw9at8Da+VZ1sKUyEUL6bl7b56fYxd0g/91BFfc
         nrc6J003uRuRS8n5a2cPCeo4oAdrrLCSXX1l6CE9njXg9p1J2fxD4OcdYWFQnMKG8wyR
         FG/v6x7Ha72iFM7tT1qHjjCFEJMr6AMcisVcjlu+Xmrwrgi7ceOfe44qFAqw0zn7C2hr
         5r1+rFqTrgi5siZC/L5OK7SxUKJfhif7BFUqtJw71q22k2cIw+mTZyGS3fBsw29DfRda
         EVrjDXCedh+EIxHc2tm68aTtWNZ2T81GJUfpoi//8L9hJHiAEnPc9jcgg303O08F+O0q
         fykA==
X-Gm-Message-State: AOAM531JiVuv2ULWtU30VK9R02RxR2AkQ+X3eNvv0KPGzWyA05EV0YSb
        ltKtN8qFvEI7/6M7SzUnHY4=
X-Google-Smtp-Source: ABdhPJwnO50+gnpA5Ec9ZaKtMRJev8c9mYapkUNSr2Ko1H5jXHxGgWECrUE+oV3mG0u03kYyKSE36Q==
X-Received: by 2002:a17:907:270f:: with SMTP id w15mr54666ejk.462.1619043168600;
        Wed, 21 Apr 2021 15:12:48 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id n2sm560459edi.32.2021.04.21.15.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 15:12:48 -0700 (PDT)
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
 <ca5d55ef-e364-be7a-5ad6-81f039c691e6@gmail.com>
 <bf0771cec69e11bf4622421a3aa8f2092da42429.camel@collabora.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <31c2e531-96d0-a1c1-644c-28c60eb40cf4@gmail.com>
Date:   Thu, 22 Apr 2021 00:12:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <bf0771cec69e11bf4622421a3aa8f2092da42429.camel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/21/21 11:56 PM, Ezequiel Garcia wrote:
> On Wed, 2021-04-21 at 23:25 +0200, Johan Jonker wrote:
>> On 4/21/21 11:06 PM, Ezequiel Garcia wrote:
>>> On Wed, 2021-04-21 at 22:46 +0200, Johan Jonker wrote:
>>>> On 4/21/21 10:04 PM, Ezequiel Garcia wrote:
>>>>> Add a new compatible for the thermal sensor device on RK3568 SoCs.
>>>>>
>>>>> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>>>>> index 7f94669e9ebe..346e466c2006 100644
>>>>> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>>>>> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>>>>> @@ -9,6 +9,7 @@ Required properties:
>>>>>     "rockchip,rk3328-tsadc": found on RK3328 SoCs
>>>>>     "rockchip,rk3368-tsadc": found on RK3368 SoCs
>>>>>     "rockchip,rk3399-tsadc": found on RK3399 SoCs
>>>>
>>>>> +   "rockchip,rk3568-tsadc": found on RK3568 SoCs
>>>>
>>>> This is still a text document.
>>>> rob+dt has now scripts that check for undocumented compatibility
>>>> strings, so first convert rockchip-thermal.txt to YAML and then add this
>>>> in a separated patch.
>>>>
>>>
>>> Is it a showstopper to convert devicetree bindings to YAML for driver submission?
>>
>> You now that hardware best, so try to fix the documents as well.
> 
> Well, not really. I'm just forward porting the driver from downstream kernels,
> so we can support this new SoC. Not really a hardware _expert_ for all the
> devices I plan to be pushing.
> 
>> The new norm is YAML, so aim for that.
> 
> I am aware of that. In fact, at Collabora we encourage all the kernel
> developers to convert to YAML, if/when possible.
> 
>> Try to submit a complete package of YAML, driver (and dts nodes) for review.
> 
> The devicetree for RK3566 and RK3568 is under discussion, in fact it was submitted today.
> Rockhip is leading that, and doing a great job already :)
> 
> Meanwhile, I'd like to merge the small drivers (thermal, pmic, dwmac, io-domains and so on),
> so they are ready when the devicetree lands.
> 

> Most if not all of these devices just need a new compatible string. It would really delay
> things if I aim to convert all those bindings docs to YAML first, so let's please avoid that...
> ... unless it's a new hard-rule that DT maintainers have agreed on.

Every driver group has it's own delay time, so better do it right in one
run.
Mostly people tend to 'forget' documentation and then someone else has
to clean up the mess. So I propose that the person that submits a new
driver also fixes the documentation. The norm is now YAML, so this serie
has more work then other, so be it. Others can help you with it if you ask.

Johan

> 
> Having said that, if you want to help the RK3568 bringup adventure,
> converting the bindings to YAML, that would be really appreciated! Of course, I know
> you've converted plenty of them already, and I already appreciate that :)
> 
> Thanks,
> Ezequiel
> 

