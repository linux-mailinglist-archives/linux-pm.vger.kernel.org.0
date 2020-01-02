Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 923F112EA9F
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2020 20:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgABTsO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jan 2020 14:48:14 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:14307 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728296AbgABTsN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2020 14:48:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577994492; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=zCeVTXfeHOc9Puc7jwFcPwhAJ0vkF2Yg4hc25BMVGUs=; b=iMSp8Aq+HTdeXIUef7N+p3EM2OMZeJSZ4GjqE8fncEO0K3Yq+69OJw/AFO3fPnrA+k2/NXFG
 Qbqu+ESW2qDgMDGSa3S/JpMNiqP287kuVpPJN1KBkAPHlHuKhlmkdOuleaapFVdvbJNU9Iu/
 Cxx0EeZFGoK2YgubMIM/lhESHlc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0e48f6.7fe16d085f48-smtp-out-n03;
 Thu, 02 Jan 2020 19:48:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E7229C4479D; Thu,  2 Jan 2020 19:48:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.250] (75-31-75-218.lightspeed.sntcca.sbcglobal.net [75.31.75.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6A7A8C43383;
        Thu,  2 Jan 2020 19:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A7A8C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
Subject: Re: [PATCH v1 1/4] dt-bindings: interconnect: Update Qualcomm SDM845
 DT bindings
To:     Rob Herring <robh@kernel.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, sboyd@kernel.org, ilina@codeaurora.org,
        seansw@qti.qualcomm.com, elder@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <1576475925-20601-1-git-send-email-daidavid1@codeaurora.org>
 <1576475925-20601-2-git-send-email-daidavid1@codeaurora.org>
 <20191226184526.GA18040@bogus>
From:   David Dai <daidavid1@codeaurora.org>
Message-ID: <5ee5c85e-64e3-9494-b033-5b6dec4a5152@codeaurora.org>
Date:   Thu, 2 Jan 2020 11:48:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191226184526.GA18040@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks for your time.

On 12/26/2019 10:45 AM, Rob Herring wrote:
> On Sun, Dec 15, 2019 at 09:58:42PM -0800, David Dai wrote:
>> Redefine the Network-on-Chip devices to more accurately describe
>> the interconnect topology on Qualcomm's SDM845 platform. Each
>> interconnect device can communicate with different instances of the
>> RPMh hardware which are described as RSCs(Resource State Coordinators).
>>
>> As part of updating the DT bindings, convert the existing sdm845 bindings
>> to DT schema format using json-schema.
> Too many things in one patch. Convert to schema in one patch and then
> add new stuff in separate patch(es).

Ok.

>> Signed-off-by: David Dai <daidavid1@codeaurora.org>
>> ---
>>   .../bindings/interconnect/qcom,bcm-voter.yaml      |  45 +++++++++
>>   .../bindings/interconnect/qcom,sdm845.txt          |  24 -----
>>   .../bindings/interconnect/qcom,sdm845.yaml         | 108 +++++++++++++++++++++
>>   3 files changed, 153 insertions(+), 24 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
>> new file mode 100644
>> index 0000000..74f0715
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
>> @@ -0,0 +1,45 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interconnect/qcom,bcm-voter.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm BCM-Voter Interconnect
>> +
>> +maintainers:
>> +  - David Dai <daidavid1@codeaurora.org>
>> +
>> +description: |
>> +    The Bus Clock Manager (BCM) is a dedicated hardware accelerator
>> +    that manages shared system resources by aggregating requests
>> +    from multiple Resource State Coordinators (RSC). Interconnect
>> +    providers are able to vote for aggregated thresholds values from
>> +    consumers by communicating through their respective RSCs.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,sdm845-bcm-voter
>> +
>> +required:
>> +  - compatible
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    apps_rsc: interconnect@179c0000 {
>> +        compatible = "qcom,rpmh-rsc";
>> +
>> +        apps_bcm_voter: bcm_voter {
>> +            compatible = "qcom,sdm845-bcm-voter";
>> +        };
>> +    };
>> +
>> +    disp_rsc: interconnect@179d0000 {
>> +        compatible = "qcom,rpmh-rsc";
>> +
>> +        disp_bcm_voter: bcm_voter {
>> +            compatible = "qcom,sdm845-bcm-voter";
>> +        };
>> +    };
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>> deleted file mode 100644
>> index 5c4f1d9..0000000
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>> +++ /dev/null
>> @@ -1,24 +0,0 @@
>> -Qualcomm SDM845 Network-On-Chip interconnect driver binding
>> ------------------------------------------------------------
>> -
>> -SDM845 interconnect providers support system bandwidth requirements through
>> -RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
>> -able to communicate with the BCM through the Resource State Coordinator (RSC)
>> -associated with each execution environment. Provider nodes must reside within
>> -an RPMh device node pertaining to their RSC and each provider maps to a single
>> -RPMh resource.
>> -
>> -Required properties :
>> -- compatible : shall contain only one of the following:
>> -			"qcom,sdm845-rsc-hlos"
>> -- #interconnect-cells : should contain 1
>> -
>> -Examples:
>> -
>> -apps_rsc: rsc {
>> -	rsc_hlos: interconnect {
>> -		compatible = "qcom,sdm845-rsc-hlos";
>> -		#interconnect-cells = <1>;
>> -	};
>> -};
>> -
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
>> new file mode 100644
>> index 0000000..1aec321
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
>> @@ -0,0 +1,108 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interconnect/qcom,sdm845.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title:  Qualcomm SDM845 Network-On-Chip Interconnect
>> +
>> +maintainers:
>> +  - David Dai <daidavid1@codeaurora.org>
>> +
>> +description: |
>> +   SDM845 interconnect providers support system bandwidth requirements through
>> +   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
>> +   able to communicate with the BCM through the Resource State Coordinator (RSC)
>> +   associated with each execution environment. Provider nodes must point to at
>> +   least one RPMh device child node pertaining to their RSC and each provider
>> +   can map to multiple RPMh resources.
>> +
>> +properties:
>> +  reg:
>> +    maxItems: 1
>> +
>> +  compatible:
>> +    enum:
>> +      - qcom,sdm845-aggre1-noc
>> +      - qcom,sdm845-aggre2-noc
>> +      - qcom,sdm845-config-noc
>> +      - qcom,sdm845-dc-noc
>> +      - qcom,sdm845-gladiator-noc
>> +      - qcom,sdm845-mem-noc
>> +      - qcom,sdm845-mmss-noc
>> +      - qcom,sdm845-system-noc
>> +
>> +  '#interconnect-cells':
>> +    const: 1
>> +
>> +  qcom,bcm-voters:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: |
>> +      List of phandles to qcom,bcm-voter nodes that are required by
>> +      this interconnect to send RPMh commands.
>> +
>> +  qcom,bcm-voter-names:
>> +    $ref: /schemas/types.yaml#/definitions/string-array
> Don't need a type for *-names.

Ok.

>> +    description: |
>> +      Names for each of the qcom,bcm-voters specified.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - '#interconnect-cells'
>> +  - qcom,bcm-voters
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +      #include <dt-bindings/interconnect/qcom,sdm845.h>
>> +
>> +      mem_noc: interconnect@1380000 {
>> +             compatible = "qcom,sdm845-mem-noc";
>> +             reg = <0 0x01380000 0 0x27200>;
>> +             #interconnect-cells = <1>;
>> +             qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> +
>> +      dc_noc: interconnect@14e0000 {
>> +             compatible = "qcom,sdm845-dc-noc";
>> +             reg = <0 0x014e0000 0 0x400>;
>> +             #interconnect-cells = <1>;
>> +             qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> +
>> +      config_noc: interconnect@1500000 {
>> +             compatible = "qcom,sdm845-config-noc";
>> +             reg = <0 0x01500000 0 0x5080>;
>> +             #interconnect-cells = <1>;
>> +             qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> +
>> +      system_noc: interconnect@1620000 {
>> +             compatible = "qcom,sdm845-system-noc";
>> +             reg = <0 0x01620000 0 0x18080>;
>> +             #interconnect-cells = <1>;
>> +             qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> +
>> +      aggre1_noc: interconnect@16e0000 {
>> +             compatible = "qcom,sdm845-aggre1-noc";
>> +             reg = <0 0x016e0000 0 0xd080>;
>> +             #interconnect-cells = <1>;
>> +             qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> +
>> +      aggre2_noc: interconnect@1700000 {
>> +             compatible = "qcom,sdm845-aggre2-noc";
>> +             reg = <0 0x01700000 0 0x3b100>;
>> +             #interconnect-cells = <1>;
>> +             qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
>> +
>> +      mmss_noc: interconnect@1740000 {
>> +             compatible = "qcom,sdm845-mmss-noc";
>> +             reg = <0 0x01740000 0 0x1c1000>;
>> +             #interconnect-cells = <1>;
>> +             qcom,bcm-voters = <&apps_bcm_voter>;
>> +      };
> Examples are just examples, not an enumeration of all possible nodes.
>
> Also, when is qcom,bcm-voters more than 1 phandle.
The mmss_noc could potentially support more than one bcm-voter, I'll 
reduce the number of examples and show the simple case and an example 
with multiple bcm-voters.
>
> Rob

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
