Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30247372FAE
	for <lists+linux-pm@lfdr.de>; Tue,  4 May 2021 20:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhEDS0X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 May 2021 14:26:23 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50016 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhEDS0X (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 May 2021 14:26:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620152728; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=AGxnYvOgR2pNLyl/9J+8rJW0dfDmPrj1VhzVa4Wrq/c=;
 b=nMLrn3oq1fYurXQcjTVIOG8wHj4rvfwqGfEMMvG+MQt5vA4/jmENTOMxSwkgwgYncLGcUeGI
 yJYZx0/FVlC+QG9u6v+1mym+g98Lny1gUdmVNIZ8MJZVyikzcpewiZ/UhCtYbFCZPHLvkipD
 UCEUJjEvLHcbo4O3/B188tSnUcc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60919188c39407c327cff0ad (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 May 2021 18:25:12
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 91604C433D3; Tue,  4 May 2021 18:25:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF320C433F1;
        Tue,  4 May 2021 18:25:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 04 May 2021 23:55:10 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     bjorn.andersson@linaro.org, viresh.kumar@linaro.org,
        swboyd@chromium.org, agross@kernel.org, robh+dt@kernel.org,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org, mka@chromium.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7280: Add cpu OPP tables
In-Reply-To: <20210504144215.svmrmmsy4jtoixzv@bogus>
References: <1619792901-32701-1-git-send-email-sibis@codeaurora.org>
 <1619792901-32701-3-git-send-email-sibis@codeaurora.org>
 <20210504144215.svmrmmsy4jtoixzv@bogus>
Message-ID: <1fc9fb8d9a94909ff9b7b76d598bd266@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Sudeep,

Thanks for the review!

On 2021-05-04 20:12, Sudeep Holla wrote:
> On Fri, Apr 30, 2021 at 07:58:21PM +0530, Sibi Sankar wrote:
>> Add OPP tables required to scale DDR/L3 per freq-domain on SC7280 
>> SoCs.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 135 
>> +++++++++++++++++++++++++++++++++++
>>  1 file changed, 135 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi 
>> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 0bb835aeae33..90220cecb368 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> 
> 
> [...]
> 
>> @@ -248,6 +273,116 @@
>>  		};
>>  	};
>> 
>> +	cpu0_opp_table: cpu0_opp_table {
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		cpu0_opp1: opp-300000000 {
>> +			opp-hz = /bits/ 64 <300000000>;
>> +			opp-peak-kBps = <800000 9600000>;
>> +		};
>> +
>> +		cpu0_opp2: opp-691200000 {
>> +			opp-hz = /bits/ 64 <691200000>;
>> +			opp-peak-kBps = <800000 17817600>;
>> +		};
>> +
>> +		cpu0_opp3: opp-806400000 {
>> +			opp-hz = /bits/ 64 <806400000>;
>> +			opp-peak-kBps = <800000 20889600>;
>> +		};
>> +
>> +		cpu0_opp4: opp-940800000 {
>> +			opp-hz = /bits/ 64 <940800000>;
>> +			opp-peak-kBps = <1804000 24576000>;
>> +		};
>> +
>> +		cpu0_opp5: opp-1152000000 {
>> +			opp-hz = /bits/ 64 <1152000000>;
>> +			opp-peak-kBps = <2188000 27033600>;
>> +		};
>> +
>> +		cpu0_opp6: opp-1324800000 {
>> +			opp-hz = /bits/ 64 <1324800000>;
>> +			opp-peak-kBps = <2188000 33792000>;
>> +		};
>> +
>> +		cpu0_opp7: opp-1516800000 {
>> +			opp-hz = /bits/ 64 <1516800000>;
>> +			opp-peak-kBps = <3072000 38092800>;
>> +		};
>> +
>> +		cpu0_opp8: opp-1651200000 {
>> +			opp-hz = /bits/ 64 <1651200000>;
>> +			opp-peak-kBps = <3072000 41779200>;
>> +		};
>> +
>> +		cpu0_opp9: opp-1804800000 {
>> +			opp-hz = /bits/ 64 <1804800000>;
>> +			opp-peak-kBps = <4068000 48537600>;
>> +		};
>> +
>> +		cpu0_opp10: opp-1958400000 {
>> +			opp-hz = /bits/ 64 <1958400000>;
>> +			opp-peak-kBps = <4068000 48537600>;
>> +		};
>> +	};
>> +
> 
> NACK, this breaks if there is a mismatch from what is read from the 
> hardware
> and what is presented in this table above. Either add it from the some
> bootloader or other boot code to this table reading from the 
> hardware/firmware
> or find a way to link them without this.
> 
> Sorry I had warned long back about this when such links were discussed 
> as
> part of interconnect binding.

Not sure why this warrants a NACK,
as this was consensus for mapping
cpu freq to DDR/L3 bandwidth votes.
(We use the same solution on SDM845
and SC7180). The opp tables are
optional and when specified puts in
votes for DDR/L3. In the future the
table can be safely dropped when more
useful devfreq governors are upstreamed.

cpufreq: qcom: Don't add frequencies without an OPP

I guess your main concern for breakage
is ^^ commit? The original design is
to list a super set of frequencies
supported by all variants of the SoC
along with the required DDR/L3 bandwidth
values. When we run into non-documented
frequency we just wouldn't put in bw
votes for it which should be fine since
the entire opp_table is optional. If
this is the reason for the NACK I can
try get it reverted with Matthias's ack.


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
