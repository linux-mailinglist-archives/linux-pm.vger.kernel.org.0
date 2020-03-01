Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56B84175108
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2020 00:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgCAXhm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Mar 2020 18:37:42 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46397 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbgCAXhm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Mar 2020 18:37:42 -0500
Received: by mail-qv1-f67.google.com with SMTP id bo12so4035794qvb.13
        for <linux-pm@vger.kernel.org>; Sun, 01 Mar 2020 15:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TC7BEViNIrcgBvuSmYhgXNOgon/ByWdiyAfu39Qw0gI=;
        b=sifgC5yjaTaKGjMMp7QGl5KEVty3Byu3M9vc6veJC4Pvx+yyfl2ewt+f7PEvr+2Ua9
         /Zu3+sKj/v8xoetMba3DVOD+gGvu3ukwnaIPbbKr4uo1tDN4GUidaq5FeIerMbMAzst8
         +1swJo7ADn3BNzQSc8mP5zhdo64QRryiOi+NJsNuqCcfMe6zgeVdUF95GZpaHq+9DDF9
         /lmBSdAFqqJtlsfHxRmAG9/619H6+hAQeN/ZL9FVOnzWObEKIIrueVdM0ZzDPlJNP5MV
         Ivp2I6KgQRREU/EoDuTtPASSZSnvQu82GDfSgbWrG12zrhyebAXjqTpjQNPTfyYvi2gA
         nxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TC7BEViNIrcgBvuSmYhgXNOgon/ByWdiyAfu39Qw0gI=;
        b=T8LLzb8Ghw4STD32kVKZizQ0FLRDWLtdzxpRy19iDpPWShF4enUK/ngOvbTO40dhBR
         NKHUuDrUVY2dUSFiSgwUEvLrlrrrsCHXgZA2FjSd47xDADH13C64A2wchuwo6g0sLpSA
         Oyk2m7lXGUYnhze1OjaIF6BfTiiO2ENAOIZx5Bx7U6gaMc7Uaq2759YevTOFrVirXzHf
         5u2ome2wxhAIYEeFDZv1D5XzTa2XE3Z87405Z6GgN9694qNGvzfGqb+3/WOQLS4b0tCQ
         szfGhA/7zmufHbrESbUqbjglmNm7/440yNceKeVqgKfYt6WITLpACtHODfq/TCU7Hplx
         Cu1g==
X-Gm-Message-State: APjAAAWU9Ed4kX4zWlPIZ72FN+Hm3ABWcflSfMrWKNk77xw0DLj4lL7h
        ngBZKEk2x2GL4O4oSJw3lWvNQQ==
X-Google-Smtp-Source: APXvYqzxiOWmMA3NTcZgpNR77r+DSpz2rxbV/GDVOsae/oUiX/qEMP7ZKGXG35a8uPMcbyWud/KObw==
X-Received: by 2002:ad4:48c6:: with SMTP id v6mr12512731qvx.207.1583105861532;
        Sun, 01 Mar 2020 15:37:41 -0800 (PST)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id g185sm9079153qkd.16.2020.03.01.15.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2020 15:37:40 -0800 (PST)
Subject: Re: [Patch v4 6/7] dt-bindings: soc: qcom: Extend RPMh power
 controller binding to describe thermal warming device
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
 <1574254593-16078-7-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFrZ9QM9L4OEFuseRTC+mBqourv11Rcu3Ua95ZPKoNFgng@mail.gmail.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <4ab0463f-0fc3-6717-9b10-2ff7bd745fcd@linaro.org>
Date:   Sun, 1 Mar 2020 18:37:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrZ9QM9L4OEFuseRTC+mBqourv11Rcu3Ua95ZPKoNFgng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2/4/20 12:41 PM, Ulf Hansson wrote:
> On Wed, 20 Nov 2019 at 13:57, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>
>> RPMh power controller hosts mx domain that can be used as thermal warming
>> device. Add #cooling-cells property to the power domain provider node to
>> indicate this.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks! This file does not exist anymore. It has been moved to yaml 
format! I will resend this in the correct file.

> 
> Kind regards
> Uffe
> 
>> ---
>> v3->v4:
>>          - Removed subnode to indicate that mx power domain is a warming
>>            device. Instead #cooling-cells is used as a power domain
>>            provider property to indicate if the provider hosts a power
>>            domain that can be used as a warming device.
>>
>>   Documentation/devicetree/bindings/power/qcom,rpmpd.txt | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>> index bc75bf4..a193d33 100644
>> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>> @@ -19,6 +19,11 @@ Required Properties:
>>   Refer to <dt-bindings/power/qcom-rpmpd.h> for the level values for
>>   various OPPs for different platforms as well as Power domain indexes
>>
>> +Optional Properties
>> + - #cooling-cells: must be 2
>> +       RPMh also hosts power domains that can behave as thermal warming
>> +       device. If so, indicate this by specifying #cooling-cells.
>> +
>>   Example: rpmh power domain controller and OPP table
>>
>>   #include <dt-bindings/power/qcom-rpmhpd.h>
>> --
>> 2.1.4
>>

-- 
Warm Regards
Thara
