Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BFC55C854
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jun 2022 14:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbiF0Mjv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jun 2022 08:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbiF0Mjq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2022 08:39:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E25CB7EC
        for <linux-pm@vger.kernel.org>; Mon, 27 Jun 2022 05:39:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id q6so18798634eji.13
        for <linux-pm@vger.kernel.org>; Mon, 27 Jun 2022 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xmyY2TbGiQjUSbUXsv4bmxdmwb/1rWQHVm1rbAHDFtc=;
        b=WgCMA45z7oXe99Kbi//PSjt233asrGWvSstR+do7+vDXHYbH9jE8DEWkHR2IR7+3VD
         y1khmDOx6JyNs76tx30VI984zWqUWXybyXShrbzXKUuEp+MZ2KxcvqQVWnDuYrHqv3Au
         b4lmIJGkdBdYipjIbS6xyBdXgpUzF9/nK8+4saPjtHrrE7zE1jIIKGHCBsJSHGJ70A2V
         xMX59jFokLVHnb1zSWxhsf65P2+Vf/Ti+LC6zed1OWjgm2PcRrPQuXB9xwSZRJkhT1oW
         RpDGu63bCEv1Ko8kMZXzNwyVmt3lOUZ3amOTKIUfq4OSSS2iCdXWG9OVt6UncEMPE+fM
         YfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xmyY2TbGiQjUSbUXsv4bmxdmwb/1rWQHVm1rbAHDFtc=;
        b=RdGrYuHW4kDjIVnqLXjZzg3SPh5577Kk4GA3ZzXmChWa0bDUcvHeuLsAWWE/HT4rrW
         Uvxl5JHhjdPVsgVTwclR2udLve08e3SHdzvSP2KGvcfFTgfJUPG5xGZrC0CIXYjKOlr1
         IXYtZqfY5nqo4nMB7Hp6hX+WUYGtbG+JlSrOANOnn64UFNkgPzsmFueQ4bDziVDd22F2
         AgyUu2pbb+c3fwxVE5n4DpGjTvPfB0O13DWlAKXs+bgreSraomRGVd/fds3y3tQR2Xob
         ma0VxO70KYS3uhsyf0laMjP0aAbFynnHiCTw2OY0d2iQ9TJpGk21rPhvroFvLBJyuQc3
         ERiQ==
X-Gm-Message-State: AJIora81a5fiqF6CFjLBVBIX18miBaQG2RvCXPQFLEkmuj1FLTlKSgkg
        6f4+5CcD07f0AfsdtXoc8pe5hg==
X-Google-Smtp-Source: AGRyM1tVT90h6/b8BA4X8bgZvAoehqjtWKBkZx2qsNMgdSgNwycwFWB/bXiCC/6GqZ24Lp0OXWDccA==
X-Received: by 2002:a17:906:1c5:b0:715:7c69:870e with SMTP id 5-20020a17090601c500b007157c69870emr12665051ejj.348.1656333583617;
        Mon, 27 Jun 2022 05:39:43 -0700 (PDT)
Received: from [192.168.0.249] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y24-20020a1709060a9800b006fe8a4ec62fsm4987024ejf.4.2022.06.27.05.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 05:39:43 -0700 (PDT)
Message-ID: <47e1fcb4-237b-b880-b1b2-3910cc19e727@linaro.org>
Date:   Mon, 27 Jun 2022 14:39:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: sdm845: Add CPU BWMON
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thara Gopinath <thara.gopinath@linaro.org>
References: <20220601101140.170504-1-krzysztof.kozlowski@linaro.org>
 <20220601101140.170504-5-krzysztof.kozlowski@linaro.org>
 <bc423d7b-df03-d4e2-2898-0873db710943@quicinc.com>
 <64eb52ee-b3ac-3d94-cfce-ceb1c88dddb6@linaro.org>
 <042cb765-113b-9335-edae-595addf50dd0@quicinc.com>
 <23320e3c-40c3-12bb-0a1c-7e659a1961f2@linaro.org>
 <YrfSWw9Wpq5TsRUt@builder.lan>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YrfSWw9Wpq5TsRUt@builder.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/06/2022 05:28, Bjorn Andersson wrote:
> On Thu 23 Jun 07:58 CDT 2022, Krzysztof Kozlowski wrote:
> 
>> On 23/06/2022 08:48, Rajendra Nayak wrote:
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>>> index 83e8b63f0910..adffb9c70566 100644
>>>>>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>>> @@ -2026,6 +2026,60 @@ llcc: system-cache-controller@1100000 {
>>>>>>    			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>    		};
>>>>>>    
>>>>>> +		pmu@1436400 {
>>>>>> +			compatible = "qcom,sdm845-cpu-bwmon";
>>>>>> +			reg = <0 0x01436400 0 0x600>;
>>>>>> +
>>>>>> +			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
>>>>>> +
>>>>>> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
>>>>>> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>>>>>> +			interconnect-names = "ddr", "l3c";
>>>>>
>>>>> Is this the pmu/bwmon instance between the cpu and caches or the one between the caches and DDR?
>>>>
>>>> To my understanding this is the one between CPU and caches.
>>>
>>> Ok, but then because the OPP table lists the DDR bw first and Cache bw second, isn't the driver
>>> ending up comparing the bw values thrown by the pmu against the DDR bw instead of the Cache BW?
>>
>> I double checked now and you're right.
>>
>>> Atleast with my testing on sc7280 I found this to mess things up and I always was ending up at
>>> higher OPPs even while the system was completely idle. Comparing the values against the Cache bw
>>> fixed it.(sc7280 also has a bwmon4 instance between the cpu and caches and a bwmon5 between the cache
>>> and DDR)
>>
>> In my case it exposes different issue - under performance. Somehow the
>> bwmon does not report bandwidth high enough to vote for high bandwidth.
>>
>> After removing the DDR interconnect and bandwidth OPP values I have for:
>> sysbench --threads=8 --time=60 --memory-total-size=20T --test=memory
>> --memory-block-size=4M run
>>
>> 1. Vanilla: 29768 MB/s
>> 2. Vanilla without CPU votes: 8728 MB/s
>> 3. Previous bwmon (voting too high): 32007 MB/s
>> 4. Fixed bwmon 24911 MB/s
>> Bwmon does not vote for maximum L3 speed:
>> bwmon report 9408 MB/s (thresholds set: <9216000 15052801>
>> )
>> osm l3 aggregate 14355 MBps -> 897 MHz, level 7, bw 14355 MBps
>>
>> Maybe that's just problem with missing governor which would vote for
>> bandwidth rounding up or anticipating higher needs.
>>
>>>>> Depending on which one it is, shouldn;t we just be scaling either one and not both the interconnect paths?
>>>>
>>>> The interconnects are the same as ones used for CPU nodes, therefore if
>>>> we want to scale both when scaling CPU, then we also want to scale both
>>>> when seeing traffic between CPU and cache.
>>>
>>> Well, they were both associated with the CPU node because with no other input to decide on _when_
>>> to scale the caches and DDR, we just put a mapping table which simply mapped a CPU freq to a L3 _and_
>>> DDR freq. So with just one input (CPU freq) we decided on what should be both the L3 freq and DDR freq.
>>>
>>> Now with 2 pmu's, we have 2 inputs, so we can individually scale the L3 based on the cache PMU
>>> counters and DDR based on the DDR PMU counters, no?
>>>
>>> Since you said you have plans to add the other pmu support as well (bwmon5 between the cache and DDR)
>>> how else would you have the OPP table associated with that pmu instance? Would you again have both the
>>> L3 and DDR scale based on the inputs from that bwmon too?
>>
>> Good point, thanks for sharing. I think you're right. I'll keep only the
>> l3c interconnect path.
>>
> 
> If I understand correctly, <&osm_l3 MASTER_OSM_L3_APPS &osm_l3
> SLAVE_OSM_L3> relates to the L3 cache speed, which sits inside the CPU
> subsystem. As such traffic hitting this cache will not show up in either
> bwmon instance.
> 
> The path <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>
> affects the DDR frequency. So the traffic measured by the cpu-bwmon
> would be the CPU subsystems traffic that missed the L1/L2/L3 caches and
> hits the memory bus towards DDR.
> 
> 
> If this is the case it seems to make sense to keep the L3 scaling in the
> opp-tables for the CPU and make bwmon only scale the DDR path. What do
> you think?

The reported data throughput by this bwmon instance is beyond the DDR
OPP table bandwidth, e.g.: 16-22 GB/s, so it seems it measures still
within cache controller, not the memory bus.

Best regards,
Krzysztof
