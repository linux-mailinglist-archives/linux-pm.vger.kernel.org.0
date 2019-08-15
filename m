Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D6C8EC66
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2019 15:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbfHONJs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Aug 2019 09:09:48 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40881 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730635AbfHONJs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Aug 2019 09:09:48 -0400
Received: by mail-qt1-f193.google.com with SMTP id e8so2215451qtp.7
        for <linux-pm@vger.kernel.org>; Thu, 15 Aug 2019 06:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=7huYvdsshewvMIXAUcLto4YUXFrnZ5edUxS21q5uS7I=;
        b=iZ4Ro0BuaxRDqYBWsMimS9hxkbaCQMj4D8VBABINtoev/q3CWQpMFtFDYvwO4f+cbd
         pfnWCRWMuHppar4jI+4ZOHH/lzNIlCGAsykvtJHKSf6RQwFyh7KosEqyTdxMQSIDtycI
         KtfHBUN/RLpTqt1x8Qn2EmfKEYmZxm6nF7TcoGX2H+0FdsKitEunM0HwkmLZzm6k2LoZ
         L3jzC1bvsp6f6j7btP6xYa4zEW2TubT3O7JlnuYlDw5PdYjAHbkThazWzpxAIiXLfBvi
         eukncL9X+39mGM92AW8vNi884jOD2noVxBTI8waGVgSGS3BHmlkpqwKigurBIyVBcuIQ
         jyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=7huYvdsshewvMIXAUcLto4YUXFrnZ5edUxS21q5uS7I=;
        b=noAnWLQa9a8cht7ZxuTbtzmCOBqKCTUVMedFH4fr3comzbMMp3WvFSuBwMWf9NPSs4
         IX9W2A6XjqhL+4eCeJ0LBe3Yw6JA7OvGc5x2LtVTlQZpAZvZvNvUldoWQXwCOHgft2Y1
         1SKv0IXUaGZujZggZzhmXxL3KXZXKb9F6zQDRDUsZIGtuzhrAJFMA9YbSe/7X8SerkPQ
         bREKQrk55jyYb212pPHRvGODPjbcxDvK8d5g03ij6cA/Hl2swBWd7KGglwdAFoISc5Bx
         uaLea1o0wtb++q9kXRszFYAhGj6YBmGzDSYPPk1cOJgrr3nhDQMNMUxaPyEXqc4VwN51
         oFMg==
X-Gm-Message-State: APjAAAXYS1I2+2yelmEOLIyE+DQUPKQKqAwdRC6yKvPbMH27RO6j0reA
        lNUKp2uRCdeKIOPW+3wHssRwyE3x1vg=
X-Google-Smtp-Source: APXvYqw0C2NgkGRMI8/Xst8YgbCYiDbqQH8kicIBvUNDjr2Wb1GPGN6fzkroSEfHGfGsWBDjyRR3dw==
X-Received: by 2002:ac8:41d7:: with SMTP id o23mr3868081qtm.268.1565874587133;
        Thu, 15 Aug 2019 06:09:47 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id b127sm1449928qkc.22.2019.08.15.06.09.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 06:09:45 -0700 (PDT)
Subject: Re: [PATCH 0/4] qcom: Model RPMH power domains as thermal cooling
 devices
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        qualcomm-lt@lists.linaro.org, linux-pm@vger.kernel.org
References: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org>
 <efe98b11-9b79-4ecb-5e28-2a62235cf56c@linaro.org>
Cc:     bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        rnayak@codeaurora.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5D555998.6020509@linaro.org>
Date:   Thu, 15 Aug 2019 09:09:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <efe98b11-9b79-4ecb-5e28-2a62235cf56c@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/14/2019 06:52 AM, Daniel Lezcano wrote:
> 
> Hi Thara
> 
> interesting series. Can you describe what use case this series will solve?
> 
> On 10/08/2019 02:58, Thara Gopinath wrote:
>> Certain RPMH power domains can be used to warm up the SoC (mx on sdm845)
>> if the temperature falls below certain threshold. 
> 
> What is the relationship between the temperature fall, the sensor(s)
> location and the warming device(s) in this case?
Hi Daniel,

Thanks for the review!

My understanding is that there are a bunch of hot-spots. If the
temperature sensors in any of these hot-spots, detect a fall
in temperature, a bunch of resources are used to warm up the entire Soc.
In this case a power domain controlled by the resource power manager
hardened (RPMh) is one of these resources used to warm up the Soc.

> 
>> These power domains
>> can be considered as thermal warming devices
>> (opposite of thermal cooling devices).
> 
> Is it possible to elaborate how works the RPMH as a warming device and
> what is the "mx on sdm845"?
RPMh is resource power manager hardened. It takes numbers between 0-15
to set the power domains to require states (like TURBO, NOMINAL etc).
The frequency and voltage of the domains are controlled by the hardware
based on the number(the number of states supported by a power domains
are in fact read from the h/w runtime).
So MX in one such power domain controlled by RPMh on sdm845 which is
used to warm up the SoC as well. MX is modeled as a regular power domain
in the linux-kernel (registered with genpd).

Regards
Thara
> 
>> In kernel, these warming devices can be modeled as a 
>> thermal cooling device. To use these power domains as warming devices
>> require further tweaks in the thermal framework which are out of scope
>> of this patch series.
>>
>> The first patch in this series extends the genpd framework to export out
>> the performance states of a power domain so that when the RPMH power
>> domain is modeled as a cooling device, the number of possible states and
>> current state of the cooling device can be retrieved from the genpd
>> framework.
>>
>> The second patch implements the newly added genpd callback for RPMH power
>> domain driver.
>>
>> The third patch implements the modeling of a RPMH power domain as
>> a cooling device and the final patch adds the device node entry for sdm845
>> to consider RPMHPD MX a cooling device.
>>
>> Thara Gopinath (4):
>>   PM/Domains: Add support for retrieving genpd performance states
>>     information
>>   soc: qcom: rpmhpd: Introduce function to retrieve power domain
>>     performance state count
>>   thermal: qcom: Add RPMHPD cooling device driver.
>>   arm64: dts: qcom: Extend AOSS RPMHPD node
>>
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi    |   7 ++
>>  drivers/base/power/domain.c             |  38 +++++++++
>>  drivers/soc/qcom/rpmhpd.c               |  11 +++
>>  drivers/thermal/qcom/Kconfig            |   7 ++
>>  drivers/thermal/qcom/Makefile           |   1 +
>>  drivers/thermal/qcom/qcom-rpmhpd-cdev.c | 141 ++++++++++++++++++++++++++++++++
>>  include/linux/pm_domain.h               |  18 ++++
>>  7 files changed, 223 insertions(+)
>>  create mode 100644 drivers/thermal/qcom/qcom-rpmhpd-cdev.c
>>
> 
> 


-- 
Regards
Thara
