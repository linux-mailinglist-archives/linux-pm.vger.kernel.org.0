Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB7471F30
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 20:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388664AbfGWSY1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 14:24:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52118 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731036AbfGWSY1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 14:24:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 88F5E60A0A; Tue, 23 Jul 2019 18:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563906265;
        bh=EFiHryTk48H4pBRZaqKt3GMJoO19kZx4TVSiPsgIF5E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=B3TxerMcIuLVm2qeDzI0jP/nUXB5eVsbg9xR4yEjBGpJfcgTjgtuYrTT2UXD7OkTC
         oIwEe0F263s1kSiKdwk4Zbc+Bxm2B8DkUcBE7B1YTfLONEmtJVX+3RwpQAvcEmvbpn
         hLFZr1RXsK8eMBW3VXd7MrI38LvSoW3CFf/gVgeo=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A455602F8;
        Tue, 23 Jul 2019 18:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563906264;
        bh=EFiHryTk48H4pBRZaqKt3GMJoO19kZx4TVSiPsgIF5E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Sdr+knqWLxpSEJk8xow/oBUvhh5Ur560ZsQBjnw9tMD6AOwGmCOYn7uh4jgWyzn8c
         4d1wtk98h4d9f719QbtsqjQfrrTN8rXX+0lfchOdbkoq045UlQ9g66fGgC4gY9jnBP
         Xv1vGL+FIMeJ+pXHibTcwNp0FnnKhKUwnOuGd7eU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A455602F8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
Subject: Re: [PATCH 2/2] arm64: dts: sdm845: Redefine interconnect provider DT
 nodes
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     georgi.djakov@linaro.org, robh+dt@kernel.org, evgreen@google.com,
        ilina@codeaurora.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <1563568344-1274-1-git-send-email-daidavid1@codeaurora.org>
 <1563568344-1274-3-git-send-email-daidavid1@codeaurora.org>
 <20190721191305.GI7234@tuxbook-pro>
From:   David Dai <daidavid1@codeaurora.org>
Message-ID: <0ecba781-ad08-0f09-f4a8-83473569a4c5@codeaurora.org>
Date:   Tue, 23 Jul 2019 11:24:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190721191305.GI7234@tuxbook-pro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks for looking over this, Bjorn.

On 7/21/2019 12:13 PM, Bjorn Andersson wrote:
> On Fri 19 Jul 13:32 PDT 2019, David Dai wrote:
>
>> Add the DT nodes for each of the Network-On-Chip interconnect
>> buses found on SDM845 based platform and redefine the rsc_hlos
>> child node as a bcm-voter device to better represent the hardware.
>>
>> Signed-off-by: David Dai <daidavid1@codeaurora.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 61 ++++++++++++++++++++++++++++++++++--
>>   1 file changed, 58 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index e7d78bc..204222e 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -610,6 +610,62 @@
>>   			#power-domain-cells = <1>;
>>   		};
>>   
>> +		aggre1_noc: interconnect@16e0000 {
>> +			compatible = "qcom,sdm845-aggre1_noc";
>> +			reg = <0 0x16e0000 0 0xd080>;
> Please pad the address to 8 digits and keep nodes sorted by address.
Will fix.
>> +			#interconnect-cells = <1>;
>> +			qcom,bcm-voter = <&apps_bcm_voter>;
>> +		};
>> +
>> +		aggre2_noc: interconnect@1700000 {
>> +			compatible = "qcom,sdm845-aggre2_noc";
>> +			reg = <0 0x1700000 0 0x3b100>;
>> +			#interconnect-cells = <1>;
>> +			qcom,bcm-voter = <&apps_bcm_voter>;
>> +		};
>> +
>> +		config_noc: interconnect@1500000 {
>> +			compatible = "qcom,sdm845-config_noc";
>> +			reg = <0 0x1500000 0 0x5080>;
>> +			#interconnect-cells = <1>;
>> +			qcom,bcm-voter = <&apps_bcm_voter>;
>> +		};
> [..]
>>   		qfprom@784000 {
>>   			compatible = "qcom,qfprom";
>>   			reg = <0 0x00784000 0 0x8ff>;
>> @@ -2801,9 +2857,8 @@
>>   				};
>>   			};
>>   
>> -			rsc_hlos: interconnect {
>> -				compatible = "qcom,sdm845-rsc-hlos";
>> -				#interconnect-cells = <1>;
>> +			apps_bcm_voter: bcm_voter {
> No '_' in node names, so bcm-voter.
Ok.
>
> Apart from this nits this looks good.
>
> Regards,
> Bjorn
>
>> +				compatible = "qcom,sdm845-bcm-voter";
>>   			};
>>   		};
>>   
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

