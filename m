Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF11129AB11
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 12:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899534AbgJ0Low (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 07:44:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41805 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899486AbgJ0Low (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 07:44:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id p15so1369220ljj.8
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2020 04:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NKXVtQRhqagZQAkGN2W1r/CUszER6qzeZtOHDlRrqn4=;
        b=fW7NqyIph+Nn8mGEu9V1uwUGYoy6nts7mEFrythNqvP/l2nGPY5XnLB2JLC96UgwgZ
         l5yXsJDpHZyJKXwk7F9ssXT8InoDBfJYefvOQknkzPhlu9ER3Kl4YNB3H5aOYhpZuNT7
         U+/JPB97W5Wxr+Eo3MimVgIJEZmwF9adk3YSyN4D7hLqyHjEATJdJ0K1ko4jNJ7Brk7l
         oZH2OZb3AQszudeCb2Qb+MkO3bCWFw+PfghE3sWYD/YCw4Qvma0+1BdEgX3lREOEZJrN
         LC35XI0oxzA6VOpa5F23ZmYKafG3vTElE/VlMiMFqH+GswMKQvTpBzG6glx4ogGV0tT1
         2HeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NKXVtQRhqagZQAkGN2W1r/CUszER6qzeZtOHDlRrqn4=;
        b=sHaSXwPxtW9J9GkoGd28UyWU8las5qCf/oWRqq5RPaHDIEO5WqK6XsTYfYYkr2dvX5
         ah0ieL42XilxUCa9epieSwvR7MhE1ys8reTileXKt9jY+qhtoYz7nUXJdUe5yxzua8VX
         +v/vZDWft4Kabfnrwr+AuaR93NZqDj2Ohl0Gh4MPTqALGCT7HNc/XyVja/sVpIf46FOg
         xe5uE7qrWjNO62oysHdr7EITuoncp8r9RMkxvhrQLdNBMrTpXSfz90rUMdiDac/jxSC6
         XriQ7t4ZJP3/ByX2uHa4ikMKuBIR3bSY8jBC9MCWQ0CtPL24CbGWBZJhsZ8KvvQfkCZJ
         DZjg==
X-Gm-Message-State: AOAM532wcETchuMlnYqewQuWuiA6NuLrRVOGY9YZhOALLsQYadvjK2Ce
        JWG9Aw0TIx6ED0jXe/O/E7OxYH4RI+EvLW7J
X-Google-Smtp-Source: ABdhPJy/6JB5yZr+L+7Zi/fCCdLWihujbyQ88x+NHcw4mMdCTGPYA/XF7NrDBR3fy0+yUA/KMDYU7A==
X-Received: by 2002:a05:651c:103b:: with SMTP id w27mr861302ljm.323.1603799089228;
        Tue, 27 Oct 2020 04:44:49 -0700 (PDT)
Received: from [192.168.1.211] ([188.162.64.248])
        by smtp.gmail.com with ESMTPSA id g17sm147697lfj.291.2020.10.27.04.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 04:44:48 -0700 (PDT)
Subject: Re: [PATCH] interconnect: qcom: use icc_sync state for sm8[12]50
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20201027102731.951421-1-dmitry.baryshkov@linaro.org>
 <20047ef9-c84e-2923-f878-5f29dc3dda2a@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <551f8589-c58d-a999-7dad-4ced7ccd2ac3@linaro.org>
Date:   Tue, 27 Oct 2020 14:44:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20047ef9-c84e-2923-f878-5f29dc3dda2a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/10/2020 14:24, Georgi Djakov wrote:
> Hi Dmitry,
> 
> Thanks for the patch!
> 
> On 10/27/20 12:27, Dmitry Baryshkov wrote:
>> In addition to the rest of Qcom interconnect drivers use icc_sync_state
>> for SM8150/SM8250 interconnect drivers to notify the interconnect
>> framework when all consumers are probed and there is no need to keep the
>> bandwidth set to maximum anymore.
> 
> Should we add Fixes: tag?

Good question. I'd point Fixes: to sync_state commit. I'd add that to 
v2, also moving bcm registration.

> 
> Thanks,
> Georgi
> 
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/interconnect/qcom/sm8150.c | 1 +
>>   drivers/interconnect/qcom/sm8250.c | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
>> index 9218efed04a0..30fb6567fe19 100644
>> --- a/drivers/interconnect/qcom/sm8150.c
>> +++ b/drivers/interconnect/qcom/sm8150.c
>> @@ -627,6 +627,7 @@ static struct platform_driver qnoc_driver = {
>>   	.driver = {
>>   		.name = "qnoc-sm8150",
>>   		.of_match_table = qnoc_of_match,
>> +		.sync_state = icc_sync_state,
>>   	},
>>   };
>>   module_platform_driver(qnoc_driver);
>> diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
>> index 9b58946f7898..49c5ee2e70f0 100644
>> --- a/drivers/interconnect/qcom/sm8250.c
>> +++ b/drivers/interconnect/qcom/sm8250.c
>> @@ -643,6 +643,7 @@ static struct platform_driver qnoc_driver = {
>>   	.driver = {
>>   		.name = "qnoc-sm8250",
>>   		.of_match_table = qnoc_of_match,
>> +		.sync_state = icc_sync_state,
>>   	},
>>   };
>>   module_platform_driver(qnoc_driver);
>>


-- 
With best wishes
Dmitry
