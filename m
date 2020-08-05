Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D5323C78C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 10:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgHEINR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 04:13:17 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29404 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728231AbgHEINP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Aug 2020 04:13:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596615194; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=XSZLok439pWl7CwEqyvK09XFwTyFBf7GehR5emIIdDA=; b=FUqNk1Rmr5ZPTw8j3IHuzQtilD00QWQB4rRzdb+joT3VV3gQ43zxIWbKk13dGQ75fC3ogbTe
 5Omv+B5vczPniQ7o/AqxdnA6mQoponOLEVWDDA6Nvt8kUECQ/Qb91odfm/08EhCpYX/iv+h2
 xitCJGs4tNCZkh6JVSrEPXV6tdg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-east-1.postgun.com with SMTP id
 5f2a6a19f89b692ba22d805f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 05 Aug 2020 08:13:13
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AB0EDC43391; Wed,  5 Aug 2020 08:13:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,NICE_REPLY_A,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.12] (unknown [61.1.228.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5FDA6C433C9;
        Wed,  5 Aug 2020 08:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FDA6C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 1/3] dt-bindings: power: Introduce
 'assigned-performance-states' property
To:     Stephen Boyd <swboyd@chromium.org>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, ulf.hansson@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1596541616-27688-1-git-send-email-rnayak@codeaurora.org>
 <1596541616-27688-2-git-send-email-rnayak@codeaurora.org>
 <159660954201.1360974.5176671532597020049@swboyd.mtv.corp.google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <98050322-9ba6-303c-4ca4-07baa56ebd80@codeaurora.org>
Date:   Wed, 5 Aug 2020 13:43:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <159660954201.1360974.5176671532597020049@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/5/2020 12:09 PM, Stephen Boyd wrote:
> Quoting Rajendra Nayak (2020-08-04 04:46:54)
>> While most devices within power-domains which support performance states,
>> scale the performance state dynamically, some devices might want to
>> set a static/default performance state while the device is active.
>> These devices typically would also run of a fixed clock and not support
> 
> s/of/off/
> 
>> dyamically scaling the device's performance, also known as DVFS techniques.
> 
> s/dyamically/dynamically/
> 
>> Add a property 'assigned-performance-states' which client devices can
>> use to set this default performance state on their power-domains.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>   .../devicetree/bindings/power/power-domain.yaml    | 47 ++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
>> index ff5936e..48e9319 100644
>> --- a/Documentation/devicetree/bindings/power/power-domain.yaml
>> +++ b/Documentation/devicetree/bindings/power/power-domain.yaml
>> @@ -66,6 +66,16 @@ properties:
>>          by the given provider should be subdomains of the domain specified
>>          by this binding.
>>   
>> +  assigned-performance-states:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description:
>> +       Some devices might need to configure their power domains in a default
>> +       performance state while the device is active. These devices typcially
>> +       would also run of a fixed clock and not support dyamically scaling the
> 
> Same of and dynamically comment.
> 
>> +       device's performance, also known as DVFS techniques. The list of performance
>> +       state values should correspond to the list of power domains specified as part
>> +       of the power-domains property.
> 
> This is different than assigned-clock-rates. I guess that's OK because
> we don't need to assign parents with more specifiers. Maybe it should be
> worded more strongly to clearly state that each cell corresponds to one
> power domain? And that it should match the opp-level inside any OPP
> table for the power domain?

Sure, I'll reword it to make it clear that we need the same number of cells
as power-domains, and as you pointed out below that 0 corresponds to not setting
anything.

For the matching of opp-level inside the OPP table of the power-domain, I don't
think from the power-domain bindings we limit providers with only OPP tables to
support performance states? It could be just a range that the provider manages
internally?

And thanks for catching all my typos :), I'll have them fixed when I re-spin.

> 
>> +
>>   required:
>>     - "#power-domain-cells"
>>   
>> @@ -129,3 +139,40 @@ examples:
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
> 
> I guess <0> means don't set anything?
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
