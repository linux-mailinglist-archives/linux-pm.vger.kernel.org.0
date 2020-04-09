Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF41B1A3630
	for <lists+linux-pm@lfdr.de>; Thu,  9 Apr 2020 16:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgDIOrX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Apr 2020 10:47:23 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:38954 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgDIOrW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Apr 2020 10:47:22 -0400
Received: by mail-wr1-f50.google.com with SMTP id p10so12214484wrt.6
        for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2020 07:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZZS9U1ArwsTmsSPlfGJd5HeXSHO0SdvQfFd8dx+1UVk=;
        b=pPPYIThhwzhDNkp6VOJ+CbRbSQJHdOGFcH+VYBuGxQPgg1cFdXyhYy0Y10a2nwGDrG
         LaQ5HlQ4lKwgKEl37rk7qWOVSIrNnk1s3P6VBPxmBwXz+J8bXLpDfObMzOCsZL/Di4Yl
         OlYOtrzoZrkE7LDvGnHaXNL+cimv0xXrBbz/CFq39SZjL+kIbuRdxY41dGh++w20t6Fg
         BzklAUcwdMcaUoQKUISJuK83qod9vHrQApnRJ3LDtblxM40cSvVdBXaLtx/C0iF30rL5
         r8BGtK6xTqAMDXmIDGud7+pxNot89WTdTL2d6IvihKpj272J310TY7FX8Io96nBNrIyp
         4oQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZZS9U1ArwsTmsSPlfGJd5HeXSHO0SdvQfFd8dx+1UVk=;
        b=M5JKVzwZH0BQ1YG3tPia7ovN7sKdJ1LPi+5SK52g3V7+Gb/0cdDT2U6SmFB8/6EicL
         9TKm1Jh9wkqawYPLhPkKNzZByQIRqVUnjqVlK9Z0aSU1CmE6aG12Eh82sWcJMAfDgSIZ
         pdttb3HqHPfVk9AACiwiu33yM2G/BzFng5m2wXmpZF9PLkatPYjpdcRk10HLbB7h1F7C
         a0IfD3GtkXp6/ifcr/rwEbmht9HihSVO+Vi9rDAQiwo4hm65ratvCAsjZEnCuxWNRahh
         G7QnmZMYE0mf15H2UlBqPXcVcJ1VBNdjR6a/o9GVOceMW7mGTfyj4iBMl/KWOw8TZD41
         qa5w==
X-Gm-Message-State: AGi0PuYPIoaRsikpQdqyzcG3RhgutYhzQavcU3aif+glqRMmHFqUZPqp
        R2pmx14WoYwoQgREq2p75fo7SHjQHfk=
X-Google-Smtp-Source: APiQypK/poVrrLLEc2SNT/FoCaqqeJDqSdaOa5up0mRVX6coNjeR1Ww0pzfAVxRyFxqkdfoGHAOMLQ==
X-Received: by 2002:a5d:4d12:: with SMTP id z18mr14869150wrt.67.1586443639710;
        Thu, 09 Apr 2020 07:47:19 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:4e:2ab3:ef46:7bda? ([2a01:e34:ed2f:f020:4e:2ab3:ef46:7bda])
        by smtp.googlemail.com with ESMTPSA id n4sm3897949wmi.20.2020.04.09.07.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 07:47:19 -0700 (PDT)
Subject: Re: [PATCH v6 0/4] thermal: k3: Add support for bandgap sensors
To:     Tero Kristo <t-kristo@ti.com>, "J, KEERTHY" <j-keerthy@ti.com>,
        rui.zhang@intel.com, robh+dt@kernel.org
Cc:     amit.kucheria@verdurent.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, mark.rutland@arm.com
References: <20200407055116.16082-1-j-keerthy@ti.com>
 <3c69e3c6-5549-e891-fde6-95a2ecc49f77@linaro.org>
 <0817f9ee-c72f-3e9f-00cf-e8ddaf608020@ti.com>
 <e7dd6470-5992-8d22-5d0c-7532a47a400c@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3221f241-7118-a586-1789-d427791215c6@linaro.org>
Date:   Thu, 9 Apr 2020 16:47:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e7dd6470-5992-8d22-5d0c-7532a47a400c@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/04/2020 16:37, Tero Kristo wrote:
> On 09/04/2020 17:07, J, KEERTHY wrote:
>>
>>
>> On 4/9/2020 7:19 PM, Daniel Lezcano wrote:
>>>
>>> Hi Keerthy,
>>>
>>> On 07/04/2020 07:51, Keerthy wrote:
>>>> Add VTM thermal support. In the Voltage Thermal
>>>> Management Module(VTM), K3 AM654 supplies a voltage
>>>> reference and a temperature sensor feature that are gathered in the
>>>> band
>>>> gap voltage and temperature sensor (VBGAPTS) module. The band
>>>> gap provides current and voltage reference for its internal
>>>> circuits and other analog IP blocks. The analog-to-digital
>>>> converter (ADC) produces an output value that is proportional
>>>> to the silicon temperature.
>>>>
>>>> Add support for bandgap sensors. Currently reading temperatures
>>>> is supported.
>>>
>>> How do you want to proceed? Shall I take patches 1 & 2 ?
>>
>> +Tero
>>
>> Hi Tero,
>>
>> Can you pull 3 & 4? Or Daniel can take all 4?
> 
> Let me pull the DT patches, that way we avoid any conflicts in the
> arm64/dts tree. There has been quite a bit of traffic on that front
> lately and we did mess up something with the current merge window already.
> 
> I believe you are picking the driver side changes to 5.8?

Applied patches 1 & 2

Thanks

  -- Daniel



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
