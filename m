Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1BA1FBCA4
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 19:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgFPRTc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 13:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgFPRTb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 13:19:31 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D5DC06174E
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 10:19:30 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id d27so16114336qtg.4
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2020 10:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wWTEVC4IvADhgC8WKAFdPBJMykXtWuEzpH/Aah85Qcs=;
        b=fd+q13dnpRb7sosklNefJkvA0FgEtbX+514cFpXpLhhiNOAvyS/H0qQcCQx7cfQRZa
         4rh9Q/ZoLUFe0x7JUpc361CfeuZK/IAZud2gStzhirNsoDffnc2VZVHaTihzVXmP3wqE
         W4h4PmzaSlA5SXNbb1860nwCQOOwf1EZw5Pz89AXzvU86IydYIKA3GHIBnmWdy+vpU9t
         3+kfMcxSKGu00Aa0iG7gvZtvRzhO/TbhNKd1QkdN/KFxYeqijSeeAI55jwazR6hriiRB
         56xUWZXy6kVPqQ57aqcuOMqHTxnV3wxH1D+rVTeNzAtv4xr0oH4BCIBYKjVdllNkMxPT
         q9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wWTEVC4IvADhgC8WKAFdPBJMykXtWuEzpH/Aah85Qcs=;
        b=XeHeP4dqsm4VRGccCrxfoKqIhKZP7TZKw9cVqEK8Q6M+8cA9fcs9e2ADyhF4DGxxfd
         5AbDw7ZwVZRKQBnoTcWGveecBRn+oOAgfWstMkJac2iRMnBtKN2j1QFC2d/rWveGudiK
         ZpVd1Q8wINPQ3uaXAg+n88FNNs83LHvY7uCrr+iA8qYRvARRhcEZKLjdsnhbf5lA+ZCX
         F6iaVPbcaRtd4FtODFnM2rpDlPTmxNHplI88zgfMk890gytwUj5NsoN7ApGK1XQ8caj+
         fJQZ0uLdGaNuq45AmmiYmGaE08POiZfwM7XHjloT9bZROmzFNVHKRbugo8sGwqksuMde
         jVbg==
X-Gm-Message-State: AOAM530W86+dpNl/H2+TnvpY4rohayhbnIrNHfBmUpsqCQBIcl9o8hvy
        sINTY87Qs6N9pmvlO6jG9yR2BA==
X-Google-Smtp-Source: ABdhPJy8Ml+SRDOIpfMU19h6AyD4PHxw4EEAdOlfy7DVyy6x5lPuP4K3JL/v7tdCndKeai3czWUJcg==
X-Received: by 2002:ac8:339b:: with SMTP id c27mr21285530qtb.210.1592327969918;
        Tue, 16 Jun 2020 10:19:29 -0700 (PDT)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id q187sm14335126qka.34.2020.06.16.10.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 10:19:29 -0700 (PDT)
Subject: Re: [PATCH v6 2/6] soc: qcom: rpmhpd: Introduce function to retrieve
 power domain performance state count
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, Rob Herring <robh@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200604015317.31389-1-thara.gopinath@linaro.org>
 <20200604015317.31389-3-thara.gopinath@linaro.org>
 <CAPDyKFqxV20Fv2X7wJ5zKa_csDgSBL5KN9HtrA6+EFpgYPhxyg@mail.gmail.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <6ce39992-2b24-ba55-521b-6f27e52b9f6e@linaro.org>
Date:   Tue, 16 Jun 2020 13:19:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqxV20Fv2X7wJ5zKa_csDgSBL5KN9HtrA6+EFpgYPhxyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/16/20 5:21 AM, Ulf Hansson wrote:
> On Thu, 4 Jun 2020 at 03:53, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>
>> Populate .get_performance_state_count in genpd ops to retrieve the count of
>> performance states supported by a rpmh power domain.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks Ulf for all the reviews.
> 
> Kind regards
> Uffe
> 


-- 
Warm Regards
Thara
