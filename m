Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2922B3AD54F
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jun 2021 00:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229466AbhFRWle (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 18:41:34 -0400
Received: from relay05.th.seeweb.it ([5.144.164.166]:50905 "EHLO
        relay05.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhFRWld (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 18:41:33 -0400
X-Greylist: delayed 16206 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Jun 2021 18:41:31 EDT
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 0B4E23F403;
        Sat, 19 Jun 2021 00:39:01 +0200 (CEST)
Subject: Re: [RESEND PATCH v4 2/3] soc: qcom: spm: Implement support for
 SAWv4.1, SDM630/660 L2 AVS
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        jamipkettunen@somainline.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20210618180907.258149-1-angelogioacchino.delregno@somainline.org>
 <20210618180907.258149-3-angelogioacchino.delregno@somainline.org>
 <YM0bM60FNof8d6ki@gerhold.net>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <1e0c47e6-01be-298d-8823-f34a55f4ee3f@somainline.org>
Date:   Sat, 19 Jun 2021 00:39:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YM0bM60FNof8d6ki@gerhold.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 19/06/21 00:17, Stephan Gerhold ha scritto:
> On Fri, Jun 18, 2021 at 08:09:06PM +0200, AngeloGioacchino Del Regno wrote:
>> Implement the support for SAW v4.1, used in at least MSM8998,
>> SDM630, SDM660 and APQ variants and, while at it, also add the
>> configuration for the SDM630/660 Silver and Gold cluster L2
>> Adaptive Voltage Scaler: this is also one of the prerequisites
>> to allow the OSM controller to perform DCVS.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> ---
>>   drivers/soc/qcom/spm.c | 28 +++++++++++++++++++++++++++-
>>   1 file changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
>> index 0c8aa9240c41..843732d12c54 100644
>> --- a/drivers/soc/qcom/spm.c
>> +++ b/drivers/soc/qcom/spm.c
>> @@ -32,9 +32,28 @@ enum spm_reg {
>>   	SPM_REG_SEQ_ENTRY,
>>   	SPM_REG_SPM_STS,
>>   	SPM_REG_PMIC_STS,
>> +	SPM_REG_AVS_CTL,
>> +	SPM_REG_AVS_LIMIT,
>>   	SPM_REG_NR,
>>   };
>>   
>> +static const u16 spm_reg_offset_v4_1[SPM_REG_NR] = {
>> +	[SPM_REG_AVS_CTL]	= 0x904,
>> +	[SPM_REG_AVS_LIMIT]	= 0x908,
>> +};
>> +
>> +static const struct spm_reg_data spm_reg_660_gold_l2  = {
>> +	.reg_offset = spm_reg_offset_v4_1,
>> +	.avs_ctl = 0x1010031,
>> +	.avs_limit = 0x4580458,
>> +};
>> +
>> +static const struct spm_reg_data spm_reg_660_silver_l2  = {
>> +	.reg_offset = spm_reg_offset_v4_1,
>> +	.avs_ctl = 0x101c031,
> 
> I was just randomly looking for the same value in downstream and it
> looks like Qualcomm reverted something here to the same value as for
> the gold cluster, claiming "stability issues":
> 
> https://source.codeaurora.org/quic/la/kernel/msm-4.4/commit/?h=LA.UM.8.2.r2-04600-sdm660.0&id=5a07b7336a1b3fa6a3ac67470805259c5026206e
> 
> The commit seems still present in recent qcom tags. I cannot say
> anything about this, but could you confirm if you are intentionally
> not also doing the same as qcom did in that commit?
> 

I am intentionally not doing the same as that commit; 4 out of 6 devices
experienced random lockups with the values you mentioned (4x SDM630,
2x SDM636, of which all SDM630 and one SDM636 device are affected).

> Thanks,
> Stephan
> 

