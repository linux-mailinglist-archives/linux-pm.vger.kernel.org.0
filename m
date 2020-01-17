Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35B59140089
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 01:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbgAQAHQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 19:07:16 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:37422 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387963AbgAQAHO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 19:07:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579219633; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=SHwNB49es+tEFhU72L5syNc/xMu/TcvkZcGp1768lCc=; b=esOf5+2P5QtMrYpLGbv9st+FyyRpHjaPTI5TX1bgefkhYNI/f5iWAnOmB7eLEeNc2wxHeczN
 zDDfrbQGzIRR0glytJ4bNw7or5jqfztg4DNIbR37zMametNor9AUCICSpQo24c0ef9Vmcx9u
 qes+Df+j0vxsWo6VmktgMiZG0rQ=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e20faae.7fa15424e998-smtp-out-n01;
 Fri, 17 Jan 2020 00:07:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 66DA5C447A2; Fri, 17 Jan 2020 00:07:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.46.162.237] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2CFD3C433CB;
        Fri, 17 Jan 2020 00:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2CFD3C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
Subject: Re: [PATCH v2 3/6] dt-bindings: interconnect: Update Qualcomm SDM845
 DT bindings
To:     Rob Herring <robh@kernel.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, sboyd@kernel.org, ilina@codeaurora.org,
        seansw@qti.qualcomm.com, elder@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <1578630784-962-1-git-send-email-daidavid1@codeaurora.org>
 <1578630784-962-4-git-send-email-daidavid1@codeaurora.org>
 <20200115144942.GA15075@bogus>
From:   David Dai <daidavid1@codeaurora.org>
Message-ID: <04723e50-dc73-269b-d861-30e5f1c97adb@codeaurora.org>
Date:   Thu, 16 Jan 2020 16:07:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200115144942.GA15075@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 1/15/2020 6:49 AM, Rob Herring wrote:
> On Thu, Jan 09, 2020 at 08:33:01PM -0800, David Dai wrote:
>> Redefine the Network-on-Chip devices to more accurately describe
>> the interconnect topology on Qualcomm's SDM845 platform. Each
>> interconnect device can communicate with different instances of the
>> RPMh hardware which are described as RSCs(Resource State Coordinators).
>>
>> Signed-off-by: David Dai <daidavid1@codeaurora.org>
>> ---
>>   .../bindings/interconnect/qcom,sdm845.yaml         | 49 ++++++++++++++++++----
>>   1 file changed, 40 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
>> index 61e0097..6741a12 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
>> @@ -13,21 +13,44 @@ description: |
>>      SDM845 interconnect providers support system bandwidth requirements through
>>      RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
>>      able to communicate with the BCM through the Resource State Coordinator (RSC)
>> -   associated with each execution environment. Provider nodes must reside within
>> -   an RPMh device node pertaining to their RSC and each provider maps to a
>> -   single RPMh resource.
>> +   associated with each execution environment. Provider nodes must point to at
>> +   least one RPMh device child node pertaining to their RSC and each provider
>> +   can map to multiple RPMh resources.
>>    
>>   properties:
>> +  reg:
>> +    maxItems: 1
>> +
>>     compatible:
>>       enum:
>> -      - qcom,sdm845-rsc-hlos
>> +      - qcom,sdm845-aggre1-noc
>> +      - qcom,sdm845-aggre2-noc
>> +      - qcom,sdm845-config-noc
>> +      - qcom,sdm845-dc-noc
>> +      - qcom,sdm845-gladiator-noc
>> +      - qcom,sdm845-mem-noc
>> +      - qcom,sdm845-mmss-noc
>> +      - qcom,sdm845-system-noc
>>   
>>     '#interconnect-cells':
>>       const: 1
>>   
>> +  qcom,bcm-voter-names:
>> +    items:
>> +      - const: apps
>> +      - const: disp
> If these are always the names, why do you need them?
Disp and apps bcm voters are the only ones supported for sdm845, but the 
number of voters and voter names may be different for other non-sdm845 
based boards.
>> +
>> +  qcom,bcm-voters:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: |
>> +      List of phandles to qcom,bcm-voter nodes that are required by
>> +      this interconnect to send RPMh commands.
> Is the max length 2?
For sdm845, yes.
>> +
>>   required:
>>     - compatible
>> +  - reg
>>     - '#interconnect-cells'
>> +  - qcom,bcm-voters
>>   
>>   additionalProperties: false
>>   
>> @@ -35,9 +58,17 @@ examples:
>>     - |
>>         #include <dt-bindings/interconnect/qcom,sdm845.h>
>>   
>> -      apps_rsc: rsc {
>> -              rsc_hlos: interconnect {
>> -                      compatible = "qcom,sdm845-rsc-hlos";
>> -                      #interconnect-cells = <1>;
>> -              };
>> +      mem_noc: interconnect@1380000 {
>> +             compatible = "qcom,sdm845-mem-noc";
>> +             reg = <0 0x01380000 0 0x27200>;
>> +             #interconnect-cells = <1>;
>> +             qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> +
>> +      mmss_noc: interconnect@1740000 {
>> +             compatible = "qcom,sdm845-mmss-noc";
>> +             reg = <0 0x01740000 0 0x1c1000>;
>> +             #interconnect-cells = <1>;
>> +             qcom,bcm-voter-names = "apps", "disp";
>> +             qcom,bcm-voters = <&apps_bcm_voter>, <&disp_bcm_voter>;
>>         };
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
