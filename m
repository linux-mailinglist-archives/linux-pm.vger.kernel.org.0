Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782F441772C
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 16:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346937AbhIXPAJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Sep 2021 11:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346908AbhIXPAI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Sep 2021 11:00:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 236C261029;
        Fri, 24 Sep 2021 14:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632495515;
        bh=20AbCBZuSDql+ve28WJSzyhEyZAUyiUtZkQ6CpM/gFQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tz2R6kw0IEjVJnI5XSuoOA6gzRiuZufxcmGLYjlBlFJZqDtEEYHzdPI5tV0MJngFJ
         wl/MarBkMv1XujagKDpjYAc2DXiJ0690qcDPrk2BhxxJ5MEWo5D4EH/pmUWcqYmWtm
         WdFPyq1yIlQy4/JIJEiD5/NEFKgHuJAd3oPB8aIoJS54fZeszWVM/AF8tBh+i70GT8
         gbpyguk0OYBW9Y1453edmffB9K22F3ca3K/4fOUNyvW/EoDurEwG5+M8nZdlS5QV6Y
         kwJoft4spC0m4CIIvApVUyil7dSIAV65TY1zynsR0UWsphC5rR6hEFC5YLJ7yY4JdJ
         vjcU9sE+M5rDg==
Subject: Re: [PATCH v2 2/3] interconnect: qcom: sdm660: Add missing a2noc qos
 clocks
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20210824043435.23190-1-shawn.guo@linaro.org>
 <20210824043435.23190-3-shawn.guo@linaro.org> <YU3hoXHap5DsjTOm@builder.lan>
From:   Georgi Djakov <djakov@kernel.org>
Message-ID: <9b660924-1f07-8723-b66c-182ca06629d2@kernel.org>
Date:   Fri, 24 Sep 2021 17:58:28 +0300
MIME-Version: 1.0
In-Reply-To: <YU3hoXHap5DsjTOm@builder.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24.09.21 17:33, Bjorn Andersson wrote:
> On Mon 23 Aug 23:34 CDT 2021, Shawn Guo wrote:
> 
>> It adds the missing a2noc clocks required for QoS registers programming
>> per downstream kernel[1].  Otherwise, qcom_icc_noc_set_qos_priority()
>> call on mas_ufs or mas_usb_hs node will simply result in a hardware hang
>> on SDM660 SoC.
>>
>> [1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/sdm660-bus.dtsi?h=LA.UM.8.2.r1-04800-sdm660.0#n43
>>
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Georgi, do you intend to pull this patch in for v5.15-rc?
> 
> I.e. should I pick up the dts change for v5.15 as well.

Yes, i have just sent a pull request with this included, so please
pull the dts change as a fix for v5.15-rc. Sorry for not mentioning
it explicitly.
I assume that not all bootloaders are leaving the qos clocks enabled,
so if this is fixing a hardware hang, should we also backport it into
stable? This is probably more of a question to the people actively
using this board?

Thanks,
Georgi

> Regards,
> Bjorn
> 
>> ---
>>   drivers/interconnect/qcom/sdm660.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
>> index c89c991a80a0..661eb3635d21 100644
>> --- a/drivers/interconnect/qcom/sdm660.c
>> +++ b/drivers/interconnect/qcom/sdm660.c
>> @@ -174,6 +174,16 @@ static const struct clk_bulk_data bus_mm_clocks[] = {
>>   	{ .id = "iface" },
>>   };
>>   
>> +static const struct clk_bulk_data bus_a2noc_clocks[] = {
>> +	{ .id = "bus" },
>> +	{ .id = "bus_a" },
>> +	{ .id = "ipa" },
>> +	{ .id = "ufs_axi" },
>> +	{ .id = "aggre2_ufs_axi" },
>> +	{ .id = "aggre2_usb3_axi" },
>> +	{ .id = "cfg_noc_usb2_axi" },
>> +};
>> +
>>   /**
>>    * struct qcom_icc_provider - Qualcomm specific interconnect provider
>>    * @provider: generic interconnect provider
>> @@ -811,6 +821,10 @@ static int qnoc_probe(struct platform_device *pdev)
>>   		qp->bus_clks = devm_kmemdup(dev, bus_mm_clocks,
>>   					    sizeof(bus_mm_clocks), GFP_KERNEL);
>>   		qp->num_clks = ARRAY_SIZE(bus_mm_clocks);
>> +	} else if (of_device_is_compatible(dev->of_node, "qcom,sdm660-a2noc")) {
>> +		qp->bus_clks = devm_kmemdup(dev, bus_a2noc_clocks,
>> +					    sizeof(bus_a2noc_clocks), GFP_KERNEL);
>> +		qp->num_clks = ARRAY_SIZE(bus_a2noc_clocks);
>>   	} else {
>>   		if (of_device_is_compatible(dev->of_node, "qcom,sdm660-bimc"))
>>   			qp->is_bimc_node = true;
>> -- 
>> 2.17.1
>>

