Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201F43AC307
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 08:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhFRGEO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 02:04:14 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:51691 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232383AbhFRGEO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Jun 2021 02:04:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623996125; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=diQVGTKWxVl8pROsUPH7uMBRC5qSN2k/dc63nuVFOtY=; b=tiokWvHcvuJOOUP0eCLbxaLoRPE2URQFZA1gdXKK5m5HaDtAWl0u0I4fIv/No4MWYWEy1SFF
 l7E+gJjgDBAq/pmTQpGNJgAo5eJncUshZMZih4finQH9+f/LS6ti5WkyZhvr09K7tZgIMWMk
 rV6M1NMSETI69YFF3E6FL6o14QM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60cc36dced59bf69cc4629ae (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Jun 2021 06:02:04
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 64608C43460; Fri, 18 Jun 2021 06:02:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.50.13.151] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BBBFFC433F1;
        Fri, 18 Jun 2021 06:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BBBFFC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: Introduce
 'assigned-performance-states' property
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>
References: <1622095949-2014-1-git-send-email-rnayak@codeaurora.org>
 <1622095949-2014-2-git-send-email-rnayak@codeaurora.org>
 <CAPDyKFpc2Kh8y-=2F6kBmw74wReVP5QcYOfu1y9AguOvzTQtPg@mail.gmail.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <4245f8c0-bafb-3c80-ff4b-8db4855f1432@codeaurora.org>
Date:   Fri, 18 Jun 2021 11:31:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpc2Kh8y-=2F6kBmw74wReVP5QcYOfu1y9AguOvzTQtPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 6/15/2021 8:35 PM, Ulf Hansson wrote:
> On Thu, 27 May 2021 at 08:13, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>>
>> While most devices within power-domains which support performance states,
>> scale the performance state dynamically, some devices might want to
>> set a static/default performance state while the device is active.
>> These devices typically would also run off a fixed clock and not support
>> dynamically scaling the device's performance, also known as DVFS techniques.
>> Add a property 'assigned-performance-states' which client devices can
>> use to set this default performance state on their power-domains.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> 
> Rajendra, I think this is ready to be re-spinned on top of the latest
> changes for genpd that Rafael recently queued [1].

Thanks Ulf, yes, I plan to re-spin these based on the recent discussions,
re-using the existing required-opps bindings soon.
  
> If you would prefer me to do it, then please let me know. Otherwise I
> will be awaiting a new version from you.
> 
> Kind regards
> Uffe
> 
> [1]
> https://lore.kernel.org/linux-pm/CAJZ5v0i0FD-F7tN=AJNEY5HVVTCNuciLT4hCqdoS5bgF5WdmaA@mail.gmail.com/
> 
>> ---
>>   .../devicetree/bindings/power/power-domain.yaml    | 50 ++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
>> index aed51e9..88cebf2 100644
>> --- a/Documentation/devicetree/bindings/power/power-domain.yaml
>> +++ b/Documentation/devicetree/bindings/power/power-domain.yaml
>> @@ -66,6 +66,19 @@ properties:
>>         by the given provider should be subdomains of the domain specified
>>         by this binding.
>>
>> +  assigned-performance-states:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description:
>> +       Some devices might need to configure their power domains in a default
>> +       performance state while the device is active. These devices typically
>> +       would also run off a fixed clock and not support dynamically scaling the
>> +       device's performance, also known as DVFS techniques. The list of performance
>> +       state values should correspond to the list of power domains specified as part
>> +       of the power-domains property. Each cell corresponds to one power-domain.
>> +       A value of 0 can be used for power-domains with no performance state
>> +       requirement. In case the power-domains have OPP tables associated, the values
>> +       here would typically match with one of the entries in the OPP table.
>> +
>>   required:
>>     - "#power-domain-cells"
>>
>> @@ -131,3 +144,40 @@ examples:
>>               min-residency-us = <7000>;
>>           };
>>       };
>> +
>> +  - |
>> +    parent4: power-controller@12340000 {
>> +        compatible = "foo,power-controller";
>> +        reg = <0x12340000 0x1000>;
>> +        #power-domain-cells = <0>;
>> +    };
>> +
>> +    parent5: power-controller@43210000 {
>> +        compatible = "foo,power-controller";
>> +        reg = <0x43210000 0x1000>;
>> +        #power-domain-cells = <0>;
>> +        operating-points-v2 = <&power_opp_table>;
>> +
>> +        power_opp_table: opp-table {
>> +            compatible = "operating-points-v2";
>> +
>> +            power_opp_low: opp1 {
>> +                opp-level = <16>;
>> +            };
>> +
>> +            rpmpd_opp_ret: opp2 {
>> +                opp-level = <64>;
>> +            };
>> +
>> +            rpmpd_opp_svs: opp3 {
>> +                opp-level = <256>;
>> +            };
>> +        };
>> +    };
>> +
>> +    child4: consumer@12341000 {
>> +        compatible = "foo,consumer";
>> +        reg = <0x12341000 0x1000>;
>> +        power-domains = <&parent4>, <&parent5>;
>> +        assigned-performance-states = <0>, <256>;
>> +    };
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>> of Code Aurora Forum, hosted by The Linux Foundation
>>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
