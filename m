Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93E62721D3
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 23:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392208AbfGWVsq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 17:48:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57028 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387536AbfGWVsq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 17:48:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6300D616B9; Tue, 23 Jul 2019 21:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563918524;
        bh=5ix73QHqveowLXL16nuaNqEWRnZIi/XLIasDmiBAzrc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=icosjBBYXilZ22YSaViYQIThCfNYIolHFhna54owpNC1coDY6r319hsNEY8zKD4MT
         60gtJMjPYVEfDKuxCspGps0JOiZ9shEPZ3OcOhyxEUAoqKuzeAf2iH/h/IPSQBwJbI
         +vVBV8wpUPMHiPivll6iAQJ8tQPm2KzcjE7fPg2I=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.46.162.237] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F17560ACE;
        Tue, 23 Jul 2019 21:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563918523;
        bh=5ix73QHqveowLXL16nuaNqEWRnZIi/XLIasDmiBAzrc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=d4BQoIRc0GXboHLejSCzWqnFfrATSWbEXMuQbJPf/GLEvwfHDIYLoyaPUhHhuemZt
         iOObIA2Rq3UzuS2PDXIJPzgNZCwQlEp4Dq6DwZxGzy6BAbIRGF2fTCuUIbiaBCIDpI
         AKH4MAVqLmQhreqZuXLC/OleintuvaY1aRo8QTGE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F17560ACE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Update Qualcomm SDM845 DT
 bindings
To:     Stephen Boyd <swboyd@chromium.org>, bjorn.andersson@linaro.org,
        georgi.djakov@linaro.org, robh+dt@kernel.org
Cc:     evgreen@google.com, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1563568344-1274-1-git-send-email-daidavid1@codeaurora.org>
 <1563568344-1274-2-git-send-email-daidavid1@codeaurora.org>
 <5d371ce7.1c69fb81.9650.8239@mx.google.com>
From:   David Dai <daidavid1@codeaurora.org>
Message-ID: <8c181f08-559b-5d77-a617-65cfd3d5da55@codeaurora.org>
Date:   Tue, 23 Jul 2019 14:48:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d371ce7.1c69fb81.9650.8239@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks for the feedback Stephen, much appreciated!

On 7/23/2019 7:42 AM, Stephen Boyd wrote:
> Quoting David Dai (2019-07-19 13:32:23)
>> Redefine the Network-on-Chip devices to more accurately describe
>> the interconnect topology on Qualcomm's SDM845 platform. Each
>> interconnect device can communicate with different instances of the
>> RPMh hardware which are described as RSCs(Resource State Coordinators).
>>
>> Signed-off-by: David Dai <daidavid1@codeaurora.org>
>> ---
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.txt b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.txt
>> new file mode 100644
>> index 0000000..2cf7da2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.txt
>> @@ -0,0 +1,32 @@
>> +Qualcomm BCM-Voter interconnect driver binding
>> +-----------------------------------------------------------
>> +
>> +The Bus Clock Manager (BCM) is a dedicated hardware accelerator
>> +that manages shared system resources by aggregating requests
>> +from multiple Resource State Coordinators (RSC). Interconnect
>> +providers are able to vote for aggregated thresholds values from
>> +consumers by communicating through their respective RSCs.
>> +
>> +Required properties :
>> +- compatible : shall contain only one of the following:
>> +                       "qcom,sdm845-bcm-voter",
>> +
>> +Examples:
>> +
>> +apps_rsc: rsc@179c0000 {
> But there isn't a reg property.
I'll change this to the generic example with just apps_rsc: rsc {
>
>> +       label = "apps_rsc";
> Is label required?
>
>> +       compatible = "qcom,rpmh-rsc";
>> +
>> +       apps_bcm_voter: bcm_voter {
>> +               compatible = "qcom,sdm845-bcm-voter";
>> +       };
>> +}
>> +
>> +disp_rsc: rsc@179d0000 {
>> +       label = "disp_rsc";
>> +       compatible = "qcom,rpmh-rsc";
>> +
>> +       disp_bcm_voter: bcm_voter {
>> +               compatible = "qcom,sdm845-bcm-voter";
>> +       };
>> +}
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>> index 5c4f1d9..27f9ed9 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>> @@ -4,21 +4,43 @@ Qualcomm SDM845 Network-On-Chip interconnect driver binding
>>   SDM845 interconnect providers support system bandwidth requirements through
>>   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
>>   able to communicate with the BCM through the Resource State Coordinator (RSC)
>> -associated with each execution environment. Provider nodes must reside within
>> -an RPMh device node pertaining to their RSC and each provider maps to a single
>> -RPMh resource.
>> +associated with each execution environment. Provider nodes must point to at
>> +least one RPMh device child node pertaining to their RSC and each provider
>> +can map to multiple RPMh resources.
>>   
>>   Required properties :
>>   - compatible : shall contain only one of the following:
>> -                       "qcom,sdm845-rsc-hlos"
>> +                       "qcom,sdm845-aggre1_noc",
>> +                       "qcom,sdm845-aggre2_noc",
>> +                       "qcom,sdm845-config_noc",
>> +                       "qcom,sdm845-dc_noc",
>> +                       "qcom,sdm845-gladiator_noc",
>> +                       "qcom,sdm845-mem_noc",
>> +                       "qcom,sdm845-mmss_noc",
>> +                       "qcom,sdm845-system_noc",
>>   - #interconnect-cells : should contain 1
>> +- reg : shall contain base register location and length
>> +- qcom,bcm-voter : shall contain phandles to bcm voters
>>   
>>   Examples:
>>   
>> -apps_rsc: rsc {
>> -       rsc_hlos: interconnect {
>> -               compatible = "qcom,sdm845-rsc-hlos";
>> -               #interconnect-cells = <1>;
>> -       };
>> +aggre1_noc: interconnect@16e0000 {
>> +       compatible = "qcom,sdm845-aggre1_noc";
>> +       reg = <0x16e0000 0xd080>;
>> +       interconnect-cells = <1>;
>> +       qcom,bcm-voter = <&apps_bcm_voter>;
>>   };
>>   
>> +mmss_noc: interconnect@1740000 {
>> +       compatible = "qcom,sdm845-mmss_noc";
>> +       reg = <0x1740000 0x1c1000>;
>> +       interconnect-cells = <1>;
>> +       qcom,bcm-voter = <&apps_bcm_voter>, <&disp_bcm_voter>;
>> +};
>> +
>> +mem_noc: interconnect@1380000 {
>> +       compatible = "qcom,sdm845-mem_noc";
>> +       reg = <0 0x1380000 0 0x27200>;
>> +       #interconnect-cells = <1>;
>> +       qcom,bcm-voter = <&apps_bcm_voter>, <&disp_bcm_voter>;
>> +};
> How does a consumer target a particular RSC? For example, how can
> display decide to use the disp_bcm_voter node from mem_noc here? Maybe
> you can add that consumer to the example?

I was thinking that the association between the bcm voters and the icc 
nodes would be handled by the interconnect provider, and that there 
would be a set of display specific icc nodes with their own unique IDs 
that the consumers could reference. I will mention this as part of the 
description and provide an example.

Ex: interconnects = <&mmss_noc MASTER_MDP0_DISP &mem_noc SLAVE_EBI_DISP>;

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

