Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63299A6423
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 10:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfICIo1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Sep 2019 04:44:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44142 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfICIo0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Sep 2019 04:44:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9A52B6058E; Tue,  3 Sep 2019 08:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567500265;
        bh=YuiLybM31Bk+gmnr2VNTbTZAla9U4l2MPe4lZBv0EOo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AMxBdtL3ra39gRR94d0b9/rv9Fd13SSD6hzlIr2M5Udg+hZ7/DFxZ/nlX4yRy2Zwi
         WOxvB/ZHXGE0gwg10orF6k4zAxgAzzqIc6/4qlrp+2Lh2IAjWnl0lBuiri8DT1ufkY
         HDLi/OxVHkWwiJmfiauXEsw4mtVljUEEZW0IJxYg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.206.13.37] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 63DB5602FC;
        Tue,  3 Sep 2019 08:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567500264;
        bh=YuiLybM31Bk+gmnr2VNTbTZAla9U4l2MPe4lZBv0EOo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KYyFDWkN5rhhNRASYJ7GoKb52HX+KWkf9sGodOd5H5GF2GggZzBCUzsmEobUg5FQA
         NIigv4wM/lzYF5pHVN1bXThpfW7W7fgfdVNfzKWzjzlYXmMekUlMKyclQQ6y/B6uTi
         csOVLws36jhUuGOpNY22YLmOFEwwrfL4mASTvmwU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63DB5602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [PATCH v2 3/6] dt-bindings: soc: qcom: Add RSC power domain
 specifier
To:     Rob Herring <robh@kernel.org>
Cc:     swboyd@chromium.org, agross@kernel.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org
References: <20190823081703.17325-1-mkshah@codeaurora.org>
 <20190823081703.17325-4-mkshah@codeaurora.org> <20190827223252.GA26039@bogus>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <6002b812-b575-85c7-41a4-2b9a200b4ff3@codeaurora.org>
Date:   Tue, 3 Sep 2019 14:14:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827223252.GA26039@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/28/2019 4:02 AM, Rob Herring wrote:
> On Fri, Aug 23, 2019 at 01:47:00PM +0530, Maulik Shah wrote:
>> In addition to transmitting resource state requests to the remote
>> processor, the RSC is responsible for powering off/lowering the
>> requirements from CPUs subsystem for the associated hardware like
>> buses, clocks, and regulators when all CPUs and cluster is powered down.
>>
>> The power domain is configured to a low power state and when all the
>> CPUs are powered down, the RSC can lower resource state requirements
>> and power down the rails that power the CPUs.
>>
>> Add PM domain specifier property for RSC controller.
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>> ---
>>   Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
>> index 9b86d1eff219..d0ab6e9b6745 100644
>> --- a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
>> +++ b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
>> @@ -83,6 +83,13 @@ Properties:
>>   	Value type: <string>
>>   	Definition: Name for the RSC. The name would be used in trace logs.
>>   
>> +- #power-domain-cells:
>> +	Usage: optional
>> +	Value type: <u32>
>> +	Definition: Number of cells in power domain specifier. Optional for
>> +		    controllers that may be in 'solver' state where they can
>> +		    be in autonomous mode executing low power modes.
> What's the value? It's always 0?

yes. its value is always 0. i will update definition to mention this in 
next version.

>> +
>>   Drivers that want to use the RSC to communicate with RPMH must specify their
>>   bindings as child nodes of the RSC controllers they wish to communicate with.
>>   
>> @@ -112,6 +119,7 @@ TCS-OFFSET: 0xD00
>>   				  <SLEEP_TCS   3>,
>>   				  <WAKE_TCS    3>,
>>   				  <CONTROL_TCS 1>;
>> +		#power-domain-cells = <0>;
>>   	};
>>   
>>   Example 2:
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.
>>
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

