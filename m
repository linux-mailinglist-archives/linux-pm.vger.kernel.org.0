Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B682389ECE
	for <lists+linux-pm@lfdr.de>; Thu, 20 May 2021 09:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhETHWJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 May 2021 03:22:09 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:58782 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229978AbhETHWI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 May 2021 03:22:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621495248; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=PP6IRISXRQzdWCOwZo0gJ9sYB3zmjjObt7BhwdjZXt0=;
 b=S1aWuYYgGPghd4A+wkbcBqbzNUd6FGHnmbp5wbLpv5XuoC0aQ5VGHq2JdLinGas8kfiWbvj7
 h3A2EGF3UIUFiwnAUMMxjdou2Fv2k1oBOloluIgLkdciC2OG6XF/uh/U7l71InjVhnqrsPCI
 rYGve7eRBRRTKoTnfhLOdOK5TEU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60a60db47b5af81b5cfc34c4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 May 2021 07:20:20
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 59D8FC4323A; Thu, 20 May 2021 07:20:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 846B7C433F1;
        Thu, 20 May 2021 07:20:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 May 2021 12:50:18 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     bjorn.andersson@linaro.org, dianders@chromium.org,
        mka@chromium.org, sboyd@kernel.org, agross@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/2] cpufreq: blacklist SC7280 in cpufreq-dt-platdev
In-Reply-To: <20210520035622.e276tqpl4gg5fxhk@vireshk-i7>
References: <1620807083-5451-1-git-send-email-sibis@codeaurora.org>
 <1620807083-5451-2-git-send-email-sibis@codeaurora.org>
 <20210520035622.e276tqpl4gg5fxhk@vireshk-i7>
Message-ID: <6f5b1d0992243ff5d71362f463a5f1cf@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-05-20 09:26, Viresh Kumar wrote:
> On 12-05-21, 13:41, Sibi Sankar wrote:
>> Add SC7280 to cpufreq-dt-platdev blacklist since the actual scaling is
>> handled by the 'qcom-cpufreq-hw' driver.
>> 
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c 
>> b/drivers/cpufreq/cpufreq-dt-platdev.c
>> index 5e07065ec22f..345418b8250e 100644
>> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
>> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
>> @@ -137,6 +137,7 @@ static const struct of_device_id blacklist[] 
>> __initconst = {
>>  	{ .compatible = "qcom,msm8996", },
>>  	{ .compatible = "qcom,qcs404", },
>>  	{ .compatible = "qcom,sc7180", },
>> +	{ .compatible = "qcom,sc7280", },
>>  	{ .compatible = "qcom,sdm845", },
>> 
>>  	{ .compatible = "st,stih407", },
> 
> Applied 1/2. Thanks.
> 
> What do you want to do for 2/2 ? Go through my tree? need an update ?

Lets skip pulling in 2/2 for now. It depends
on a few other changes to land first and the
cpufreq node for sc7280 needs a re-spin.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
