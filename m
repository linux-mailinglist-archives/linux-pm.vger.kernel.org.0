Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3831C1CC6E0
	for <lists+linux-pm@lfdr.de>; Sun, 10 May 2020 07:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgEJFEH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 May 2020 01:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgEJFEH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 May 2020 01:04:07 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5D4C061A0C
        for <linux-pm@vger.kernel.org>; Sat,  9 May 2020 22:04:07 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x17so6659142wrt.5
        for <linux-pm@vger.kernel.org>; Sat, 09 May 2020 22:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fMfXctNlL6jggVpctm5yKd5bO5aYj/Ukk1/xc4g0anQ=;
        b=unw6A2WzLP70FElsOM7jgSTx9oGtC5JkPZVh6L1BHfeoswkaUVg1X7olpbxAgWujC1
         dEGIZgr3xra5Jzh1Ip6nI+5vx8yf6mzcA79lo4D2+PNhs0GKqQz+zFvDfPHn1/tJeUnT
         BBBFglwAG0/BP/WtvApDKtlCzMX4r2760wTpqigYTXOklB4nJt5V9P75CTXyocKMzI5L
         cwYYyLTvE0F11e5VsdiuXeFBh0yIaD9Zdr+KGYOEl7P4poUF/iizZDKaJaTDA01sJoJC
         FAVEgF/vyroSw0pZ4fDLOtCl87/+qbBKtRUamMiBDZ546Dt8Vmasl8qgLMh5LA2EXahl
         Jpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fMfXctNlL6jggVpctm5yKd5bO5aYj/Ukk1/xc4g0anQ=;
        b=eqh2/iJjOB5fV0ax0Hlp58oWVQJ+P0Cu0gDNfGevDqp6a/eO4TvqgPJRRpU27TY5bB
         tzoA9CBGVqtwP0/7axt1hJYZSukcYLkEiTKoUlOjhigzPMav4F59dvZZADE5mBBYWi1R
         TP+1fdg6aNY+Ldl1r30f6/n3JWrj7DXj8+AhZRRibZ9d6DfLMQAuCDWn29p7oe29jdSU
         2dT+0BCpScYzoQ2xKciELVrUx1uCzojM0zJFGMMF7q7FY67WdVec1R5CHhV0isqdWUwv
         MbI2JMClsBbeAF9SvfktvGvGS5DLuiD56DFvZn10VRBoQnck9LxGdJZ6cpI3Z94HfnOJ
         QObQ==
X-Gm-Message-State: AGi0PuZy8IRxYCWtxiLtTqX8BpHXIM5MgvqAiUvA3yFDYmz4WKVHZfzF
        D3PpLdGoTD+xGM5MIDwwa4Yu1A==
X-Google-Smtp-Source: APiQypI/OXGsaB2m+yte2cbCx3OK5ii35NFz7CItumc1IsG8OUkm7D2H4mlgE5OfhtEtOMuxf+n9aQ==
X-Received: by 2002:adf:f38c:: with SMTP id m12mr11405350wro.167.1589087045651;
        Sat, 09 May 2020 22:04:05 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a840:1368:1b45:2406? ([2a01:e34:ed2f:f020:a840:1368:1b45:2406])
        by smtp.googlemail.com with ESMTPSA id o26sm9095053wro.83.2020.05.09.22.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 22:04:04 -0700 (PDT)
Subject: Re: [PATCH V3 2/2] thermal: Add HiSilicon Kunpeng thermal driver
To:     Zhou Wang <wangzhou1@hisilicon.com>,
        "shenyang (M)" <shenyang39@huawei.com>, rui.zhang@intel.com,
        amit.kucheria@verdurent.com
Cc:     linux-pm@vger.kernel.org, linuxarm@huawei.com
References: <1587455093-33876-1-git-send-email-shenyang39@huawei.com>
 <1587455093-33876-3-git-send-email-shenyang39@huawei.com>
 <53ca3883-9155-c023-7916-10ec8cccf977@linaro.org>
 <0be585d3-1180-7b42-8b51-392a34793f70@huawei.com>
 <b1739246-3639-a6c1-6c0d-275eb2ab0d16@linaro.org>
 <5EB65D33.80105@hisilicon.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <96c7578e-25cf-d258-6505-8c1c631dbe82@linaro.org>
Date:   Sun, 10 May 2020 07:04:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5EB65D33.80105@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/05/2020 09:35, Zhou Wang wrote:
> On 2020/4/28 22:02, Daniel Lezcano wrote:
>> On 28/04/2020 13:58, shenyang (M) wrote:
>>> On 2020/4/27 20:13, Daniel Lezcano wrote:
>>>> On 21/04/2020 09:44, Yang Shen wrote:
>>>>> Support HiSilicon Kunpeng tsensor. the driver will report the max
>>>>> temperature for each core.
>>>>
>>>> As this is a new driver, can you give a bit more details of the hardware
>>>> in this description.
>>>>
>>>> A subsidiary question, why do you want to aggregate the temperatures in
>>>> this driver ?
>>>>
>>>
>>> OK. In fact, there are five temperature sensors distributed in the SOC.
>>> And our strategy is to collect all temperatures and return the max to
>>> the interface.
>>
>> The aggregation should be done in the thermal framework not in the driver.
>>
>> Why not create one sensor per thermal zone, so giving the opportunity to
>> create different configurations with different cooling device ?
> 
> Hi Daniel,
> 
> In our SoC, we use IMU(Intelligent Management Unit) which is an out of band
> management processor to control cooling device. We use fans to cool CPU, one
> fan is for one SoC. So getting one temperature for one SoC is enough here.
> 
> We also want to report temperature of the SoC from kernel thermal subsystem,
> so users get get SoC temperature from sysfs or user space tool, like Im-sensor.
> The goal of this driver is just to do this.

Are you saying you don't care of any cooling devices from the kernel as
the IMU is taking care of it ?

Do you have a pointer to a DT where the thermal zones are defined?

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
