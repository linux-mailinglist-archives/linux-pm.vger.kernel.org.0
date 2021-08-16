Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13273EDC8A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 19:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhHPRpT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 13:45:19 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:15132 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229733AbhHPRpS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Aug 2021 13:45:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629135887; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=oBRpgmRfal3yOf5d6tDI7ihar3q0Qj4qbAwiCJ/VpfM=;
 b=cKMOuJN5G6uwriygs4w2J6BkJrABIbeef/zhhcgsrOJeGAsUpYc1oRUTCmsK0Q3SkIXKf6Zf
 TUKUO3fKAbQ52AvDN1NKhqH16/gJTBLSaNpQ6dMb6JDpjyNqsNtxgeAWFuA7OEiS03Li+vaJ
 oI9CHVzgDCyN0401FDJlUmaY2U4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 611aa3feb3873958f593c9f4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 16 Aug 2021 17:44:30
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3C370C43460; Mon, 16 Aug 2021 17:44:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 948B2C4338F;
        Mon, 16 Aug 2021 17:44:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Aug 2021 23:14:28 +0530
From:   okukatla@codeaurora.org
To:     Georgi Djakov <djakov@kernel.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        mdtipton@codeaurora.org, sibis@codeaurora.org,
        saravanak@google.com, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [v6 3/3] arm64: dts: qcom: sc7280: Add EPSS L3 interconnect
 provider
In-Reply-To: <544023fc-f440-53bb-3308-33a1782aac19@kernel.org>
References: <1628577962-3995-1-git-send-email-okukatla@codeaurora.org>
 <1628577962-3995-4-git-send-email-okukatla@codeaurora.org>
 <544023fc-f440-53bb-3308-33a1782aac19@kernel.org>
Message-ID: <8fea4d2cb86f0e6240f9559a88a7e33a@codeaurora.org>
X-Sender: okukatla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-08-10 18:03, Georgi Djakov wrote:
> Hi Odelu,
> 
> On 10.08.21 9:46, Odelu Kukatla wrote:
>> Add Epoch Subsystem (EPSS) L3 interconnect provider node on SC7280
>> SoCs.
>> 
>> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi 
>> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 53a21d0..e78f055 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -586,6 +586,15 @@
>>   			qcom,bcm-voters = <&apps_bcm_voter>;
>>   		};
>>   +		epss_l3: interconnect@18590000 {
> 
> This DT node should be moved after apps_rsc: rsc@18200000
> and before cpufreq@18591000
> 
Thanks for review! will address this in next revision.
>> +			compatible = "qcom,sc7280-epss-l3";
>> +			reg = <0 0x18590000 0 1000>, <0 0x18591000 0 0x100>,
>> +				<0 0x18592000 0 0x100>, <0 0x18593000 0 0x100>;
> 
> Please align to the open parenthesis, to be consistent with the rest of
> the file.
> 
will address this in next revision.
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
>> +			clock-names = "xo", "alternate";
>> +			#interconnect-cells = <1>;
>> +		};
>> +
>>   		ipa: ipa@1e40000 {
>>   			compatible = "qcom,sc7280-ipa";
> 
> Thanks,
> Georgi
