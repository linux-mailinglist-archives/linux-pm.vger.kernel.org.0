Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FA155E61C
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jun 2022 18:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347801AbiF1PUb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jun 2022 11:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344555AbiF1PUa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2022 11:20:30 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F67032EF5;
        Tue, 28 Jun 2022 08:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656429629; x=1687965629;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/kH8GubTfw963zb0YPRUYAeVknTxA6TmZdDQvBJ+pxU=;
  b=WctqYpubYecF1m1/WaUyXho1eyUF2D6qg27p/xuaefrDrzNMjQzDz5Eu
   FgmcJ2FIEvYGdu91QnPEghU61ai+HL4ru2ci9B6urlzb/BtmPBg27CDd/
   JWGNPo6Qd0cd3UJyD+V+gvO1V2amOjF5pqRswbITkPifhZ6/dM2TbIK81
   E=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Jun 2022 08:20:29 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 08:20:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 28 Jun 2022 08:20:28 -0700
Received: from [10.216.26.50] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 28 Jun
 2022 08:20:22 -0700
Message-ID: <1cb53abf-067a-25d2-1596-fe3961725e93@quicinc.com>
Date:   Tue, 28 Jun 2022 20:50:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: sdm845: Add CPU BWMON
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Andy Gross <agross@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Thara Gopinath" <thara.gopinath@linaro.org>
References: <20220601101140.170504-1-krzysztof.kozlowski@linaro.org>
 <20220601101140.170504-5-krzysztof.kozlowski@linaro.org>
 <bc423d7b-df03-d4e2-2898-0873db710943@quicinc.com>
 <64eb52ee-b3ac-3d94-cfce-ceb1c88dddb6@linaro.org>
 <042cb765-113b-9335-edae-595addf50dd0@quicinc.com>
 <23320e3c-40c3-12bb-0a1c-7e659a1961f2@linaro.org>
 <YrfSWw9Wpq5TsRUt@builder.lan>
 <47e1fcb4-237b-b880-b1b2-3910cc19e727@linaro.org>
 <59b5115e-0fe5-dbe1-552b-c29e771c0583@quicinc.com>
 <c43d4c9e-54d6-7b00-0ff7-e114850302ad@linaro.org>
 <173717b1-9cd9-9298-3a20-7dd3d95339af@quicinc.com>
 <9b6486b7-418a-0102-213d-f6a5451c8c7c@linaro.org>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <9b6486b7-418a-0102-213d-f6a5451c8c7c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/28/2022 7:32 PM, Krzysztof Kozlowski wrote:
> On 28/06/2022 15:15, Rajendra Nayak wrote:
>>
>>
>> On 6/28/2022 4:20 PM, Krzysztof Kozlowski wrote:
>>> On 28/06/2022 12:36, Rajendra Nayak wrote:
>>>>
>>>> On 6/27/2022 6:09 PM, Krzysztof Kozlowski wrote:
>>>>> On 26/06/2022 05:28, Bjorn Andersson wrote:
>>>>>> On Thu 23 Jun 07:58 CDT 2022, Krzysztof Kozlowski wrote:
>>>>>>
>>>>>>> On 23/06/2022 08:48, Rajendra Nayak wrote:
>>>>>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>>>>>>>> index 83e8b63f0910..adffb9c70566 100644
>>>>>>>>>>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>>>>>>>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>>>>>>>> @@ -2026,6 +2026,60 @@ llcc: system-cache-controller@1100000 {
>>>>>>>>>>>       			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>>>>>>       		};
>>>>>>>>>>>       
>>>>>>>>>>> +		pmu@1436400 {
>>>>>>>>>>> +			compatible = "qcom,sdm845-cpu-bwmon";
>>>>>>>>>>> +			reg = <0 0x01436400 0 0x600>;
>>>>>>>>>>> +
>>>>>>>>>>> +			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>>>>>> +
>>>>>>>>>>> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>>>>>>>>>>> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>>>>>>>>>>> +			interconnect-names = "ddr", "l3c";
>>>>>>>>>>
>>>>>>>>>> Is this the pmu/bwmon instance between the cpu and caches or the one between the caches and DDR?
>>>>>>>>>
>>>>>>>>> To my understanding this is the one between CPU and caches.
>>>>>>>>
>>>>>>>> Ok, but then because the OPP table lists the DDR bw first and Cache bw second, isn't the driver
>>>>>>>> ending up comparing the bw values thrown by the pmu against the DDR bw instead of the Cache BW?
>>>>>>>
>>>>>>> I double checked now and you're right.
>>>>>>>
>>>>>>>> Atleast with my testing on sc7280 I found this to mess things up and I always was ending up at
>>>>>>>> higher OPPs even while the system was completely idle. Comparing the values against the Cache bw
>>>>>>>> fixed it.(sc7280 also has a bwmon4 instance between the cpu and caches and a bwmon5 between the cache
>>>>>>>> and DDR)
>>>>>>>
>>>>>>> In my case it exposes different issue - under performance. Somehow the
>>>>>>> bwmon does not report bandwidth high enough to vote for high bandwidth.
>>>>>>>
>>>>>>> After removing the DDR interconnect and bandwidth OPP values I have for:
>>>>>>> sysbench --threads=8 --time=60 --memory-total-size=20T --test=memory
>>>>>>> --memory-block-size=4M run
>>>>>>>
>>>>>>> 1. Vanilla: 29768 MB/s
>>>>>>> 2. Vanilla without CPU votes: 8728 MB/s
>>>>>>> 3. Previous bwmon (voting too high): 32007 MB/s
>>>>>>> 4. Fixed bwmon 24911 MB/s
>>>>>>> Bwmon does not vote for maximum L3 speed:
>>>>>>> bwmon report 9408 MB/s (thresholds set: <9216000 15052801>
>>>>>>> )
>>>>>>> osm l3 aggregate 14355 MBps -> 897 MHz, level 7, bw 14355 MBps
>>>>>>>
>>>>>>> Maybe that's just problem with missing governor which would vote for
>>>>>>> bandwidth rounding up or anticipating higher needs.
>>>>>>>
>>>>>>>>>> Depending on which one it is, shouldn;t we just be scaling either one and not both the interconnect paths?
>>>>>>>>>
>>>>>>>>> The interconnects are the same as ones used for CPU nodes, therefore if
>>>>>>>>> we want to scale both when scaling CPU, then we also want to scale both
>>>>>>>>> when seeing traffic between CPU and cache.
>>>>>>>>
>>>>>>>> Well, they were both associated with the CPU node because with no other input to decide on _when_
>>>>>>>> to scale the caches and DDR, we just put a mapping table which simply mapped a CPU freq to a L3 _and_
>>>>>>>> DDR freq. So with just one input (CPU freq) we decided on what should be both the L3 freq and DDR freq.
>>>>>>>>
>>>>>>>> Now with 2 pmu's, we have 2 inputs, so we can individually scale the L3 based on the cache PMU
>>>>>>>> counters and DDR based on the DDR PMU counters, no?
>>>>>>>>
>>>>>>>> Since you said you have plans to add the other pmu support as well (bwmon5 between the cache and DDR)
>>>>>>>> how else would you have the OPP table associated with that pmu instance? Would you again have both the
>>>>>>>> L3 and DDR scale based on the inputs from that bwmon too?
>>>>>>>
>>>>>>> Good point, thanks for sharing. I think you're right. I'll keep only the
>>>>>>> l3c interconnect path.
>>>>>>>
>>>>>>
>>>>>> If I understand correctly, <&osm_l3 MASTER_OSM_L3_APPS &osm_l3
>>>>>> SLAVE_OSM_L3> relates to the L3 cache speed, which sits inside the CPU
>>>>>> subsystem. As such traffic hitting this cache will not show up in either
>>>>>> bwmon instance.
>>>>>>
>>>>>> The path <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>
>>>>>> affects the DDR frequency. So the traffic measured by the cpu-bwmon
>>>>>> would be the CPU subsystems traffic that missed the L1/L2/L3 caches and
>>>>>> hits the memory bus towards DDR.
>>>>
>>>> That seems right, looking some more into the downstream code and register definitions
>>>> I see the 2 bwmon instances actually lie on the path outside CPU SS towards DDR,
>>>> first one (bwmon4) is between the CPUSS and LLCC (system cache) and the second one
>>>> (bwmon5) between LLCC and DDR. So we should use the counters from bwmon4 to
>>>> scale the CPU-LLCC path (and not L3), on sc7280 that would mean splitting the
>>>> <&gem_noc MASTER_APPSS_PROC 3 &mc_virt SLAVE_EBI1 3> into
>>>> <&gem_noc MASTER_APPSS_PROC 3 &gem_noc SLAVE_LLCC 3> (voting based on the bwmon4 inputs)
> 
> For sdm845 SLAVE_LLCC is in mem_noc, so I guess mc_virt on sc7280?

thats correct,

> 
>>>> and <&mc_virt MASTER_LLCC 3 &mc_virt SLAVE_EBI1 3> (voting based on the bwmon5 inputs)
>>>> and similar for sdm845 too.
>>>>
>>>> L3 should perhaps still be voted based on the cpu freq as done today.
>>>
>>> This would mean that original bandwidth values (800 - 7216 MB/s) were
>>> correct. However we have still your observation that bwmon kicks in very
>>> fast and my measurements that sampled bwmon data shows bandwidth ~20000
>>> MB/s.
>>
>> Right, thats because the bandwidth supported between the cpu<->llcc path is much higher
>> than the DDR frequencies. For instance on sc7280, I see (2288 - 15258 MB/s) for LLCC while
>> the DDR max is 8532 MB/s.
> 
> OK, that sounds right.
> 
> Another point is that I did not find actual scaling of throughput via
> that interconnect path:
> <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_LLCC 3>

Shouldn't this be <&gladiator_noc MASTER_APPSS_PROC 3 &gladiator_noc SLAVE_LLCC 3> on sdm845?

> 
> so I cannot test impact of bwmon that way.
> 
> Best regards,
> Krzysztof
