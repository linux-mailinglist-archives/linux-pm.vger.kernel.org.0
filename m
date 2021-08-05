Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AF73E1AB8
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 19:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239957AbhHERrr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 13:47:47 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:34071 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhHERrr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Aug 2021 13:47:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628185652; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=twDWcYvXpXMj28plsG6TYmw0mB6jklivM6KZ+CaQRIQ=;
 b=sdroU9j43i1AQSb/bqMCjeyj69pQ45O5xD8Kdi/1nwTTZrmHTu9EYtHjkyI5cufCAh/CWN0X
 yb6W1sWyizrFYCYCdWaLMnsHgmw3FiveU+Hf4gDctQm+WQRy3bc5hzDbFs3MnO9vSTQ8C8Jp
 iqW+mrzmjGhR+OFyB74XKSRCz/A=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 610c242bb4dfc4b0efcbff56 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 05 Aug 2021 17:47:23
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7D896C433F1; Thu,  5 Aug 2021 17:47:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 56ED7C4338A;
        Thu,  5 Aug 2021 17:47:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Aug 2021 23:17:20 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     bjorn.andersson@linaro.org, mka@chromium.org, robh+dt@kernel.org,
        viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, tdas@codeaurora.org
Subject: Re: [PATCH 2/4] cpufreq: qcom: Re-arrange register offsets to support
 per core L3 DCVS
In-Reply-To: <CAE-0n53cH749NC9JPqJvMZGBQf47AZ3qY66eoqk2CiQHvuumkg@mail.gmail.com>
References: <1627581885-32165-1-git-send-email-sibis@codeaurora.org>
 <1627581885-32165-3-git-send-email-sibis@codeaurora.org>
 <CAE-0n53cH749NC9JPqJvMZGBQf47AZ3qY66eoqk2CiQHvuumkg@mail.gmail.com>
Message-ID: <352d549f40dfa2ae51589649652d2e97@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Stephen,

Thanks for taking time to review
the series.

On 2021-08-05 00:31, Stephen Boyd wrote:
> Quoting Sibi Sankar (2021-07-29 11:04:43)
>> Qualcomm SoCs (starting with SM8350) support per core voting for L3 
>> cache
>> frequency.
> 
> And the L3 cache frequency voting code can't be put into this cpufreq
> driver?

Yes, it could have gone either into
the cpufreq driver or l3 interconnect
provider driver. Taniya/Odelu preferred
the latter, because of the need for other
clients to vote for l3 frequencies in
the future. The other option to prevent
register re-arrangement would involve
using syscons from the cpufreq node, which
really wasn't necessary since there
wasn't any register overlap between the
two drivers.

> 
>> So, re-arrange the cpufreq register offsets to allow access for
>> the L3 interconnect to implement per core control. Also prevent 
>> binding
>> breakage caused by register offset shuffling by using the 
>> SM8250/SM8350
>> EPSS compatible.
>> 
>> Fixes: 7dbd121a2c58 ("arm64: dts: qcom: sc7280: Add cpufreq hw node")
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  drivers/cpufreq/qcom-cpufreq-hw.c | 23 +++++++++++++++++++----
>>  1 file changed, 19 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c 
>> b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index f86859bf76f1..74ef3b38343b 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -28,6 +28,7 @@ struct qcom_cpufreq_soc_data {
>>         u32 reg_volt_lut;
>>         u32 reg_perf_state;
>>         u8 lut_row_size;
>> +       bool skip_enable;
>>  };
>> 
>>  struct qcom_cpufreq_data {
>> @@ -257,19 +258,31 @@ static const struct qcom_cpufreq_soc_data 
>> qcom_soc_data = {
>>         .reg_volt_lut = 0x114,
>>         .reg_perf_state = 0x920,
>>         .lut_row_size = 32,
>> +       .skip_enable = false,
>>  };
>> 
>>  static const struct qcom_cpufreq_soc_data epss_soc_data = {
>> +       .reg_freq_lut = 0x0,
>> +       .reg_volt_lut = 0x100,
>> +       .reg_perf_state = 0x220,
>> +       .lut_row_size = 4,
>> +       .skip_enable = true,
>> +};
>> +
>> +static const struct qcom_cpufreq_soc_data epss_sm8250_soc_data = {
>>         .reg_enable = 0x0,
>>         .reg_freq_lut = 0x100,
>>         .reg_volt_lut = 0x200,
>>         .reg_perf_state = 0x320,
>>         .lut_row_size = 4,
>> +       .skip_enable = false,
>>  };
>> 
>>  static const struct of_device_id qcom_cpufreq_hw_match[] = {
>>         { .compatible = "qcom,cpufreq-hw", .data = &qcom_soc_data },
>>         { .compatible = "qcom,cpufreq-epss", .data = &epss_soc_data },
>> +       { .compatible = "qcom,sm8250-cpufreq-epss", .data = 
>> &epss_sm8250_soc_data },
>> +       { .compatible = "qcom,sm8350-cpufreq-epss", .data = 
>> &epss_sm8250_soc_data },
>>         {}
>>  };
>>  MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
>> @@ -334,10 +347,12 @@ static int qcom_cpufreq_hw_cpu_init(struct 
>> cpufreq_policy *policy)
>>         data->res = res;
>> 
>>         /* HW should be in enabled state to proceed */
> 
> It looks odd that we're no longer making sure that the clk domain is
> enabled when we probe the driver. Why is that OK?

On newer EPSS hw it's no longer
required to perform the additional
hw enable check. IIRC we don't do
that on corresponding downstream
kernels as well.

> 
>> -       if (!(readl_relaxed(base + data->soc_data->reg_enable) & 0x1)) 
>> {
>> -               dev_err(dev, "Domain-%d cpufreq hardware not 
>> enabled\n", index);
>> -               ret = -ENODEV;
>> -               goto error;
>> +       if (!data->soc_data->skip_enable) {
>> +               if (!(readl_relaxed(base + data->soc_data->reg_enable) 
>> & 0x1)) {
>> +                       dev_err(dev, "Domain-%d cpufreq hardware not 
>> enabled\n", index);
>> +                       ret = -ENODEV;
>> +                       goto error;
>> +               }
>>         }
>> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
