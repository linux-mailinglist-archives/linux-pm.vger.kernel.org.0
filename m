Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEC615305C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2020 13:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgBEMHd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Feb 2020 07:07:33 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:27299 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726277AbgBEMHd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Feb 2020 07:07:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580904453; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Rw6fpPoaZ9TjeIMYqlvtFgTZBBMNHEMBUrNzr/IGp5k=; b=KJJ25gaIVRQZ9LjIfY8BlDbv1qfTYNC+P/Si0Ay/7kOjvasuzoCwskU3MaHFLqZYYuvyFq7e
 VSS/qmtrZFMt5t42kGX8iiEBN3mnN1j/7MLN4Das4s/Q/kZ2xOBES1t4wTGYOnurffHCyoLz
 dT+UbvV34sJJOZ+w+BWhDlyDAWo=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3ab001.7fc5a6c5e500-smtp-out-n02;
 Wed, 05 Feb 2020 12:07:29 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2830CC447A2; Wed,  5 Feb 2020 12:07:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.206.13.37] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1DF5BC43383;
        Wed,  5 Feb 2020 12:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1DF5BC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [PATCH v3 6/7] arm64: dts: qcom: sc7180: Add cpuidle low power
 states
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     swboyd@chromium.org, agross@kernel.org, david.brown@linaro.org,
        sudeep.holla@arm.com, Lorenzo.Pieralisi@arm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org
References: <1580736940-6985-1-git-send-email-mkshah@codeaurora.org>
 <1580736940-6985-7-git-send-email-mkshah@codeaurora.org>
 <20200204231509.GB18972@google.com>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <b07c9989-b44a-969c-4c4a-9f9465781e45@codeaurora.org>
Date:   Wed, 5 Feb 2020 17:37:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200204231509.GB18972@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 2/5/2020 4:45 AM, Matthias Kaehlcke wrote:
> On Mon, Feb 03, 2020 at 07:05:39PM +0530, Maulik Shah wrote:
>> Add device bindings for cpuidle states for cpu devices.
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7180.dtsi | 78 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 78 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> index 8011c5f..0aa0ced 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> @@ -86,6 +86,9 @@
>>   			compatible = "arm,armv8";
>>   			reg = <0x0 0x0>;
>>   			enable-method = "psci";
>> +			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
>> +					   &LITTLE_CPU_SLEEP_1
>> +					   &CLUSTER_SLEEP_0>;
> These entries are deleted again by the next patch in this series ('arm64:
> dts: qcom: sc7180: Convert to the hierarchical CPU topology layout').
> What is the point in adding them in the first place?

Clubbed 6th and 7th patch in v4 series.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
