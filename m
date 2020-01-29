Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08A3114CC11
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 15:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgA2OFb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 09:05:31 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:13029 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726314AbgA2OFa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jan 2020 09:05:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580306730; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=OYXu3ND/s2/4ySCf9M0xA490SGByupUTGY02AD+jy9Y=;
 b=b8KzDnsaPdCMMKft1kO/TuUzZ1kCLIYrPg6+2Pc35nORp6Atu6Jlhj8X9Bc83RCyBGkac8yu
 2f7An8UtcESNmRFCNivrv8km5gf3A4TVkSkdHTtSDDHGYjFk+Ndw0TIAZJsnYDK/QL/uePSF
 /fhIaozOciWbP0TodC4bGUgBxfs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e319124.7fede9397650-smtp-out-n02;
 Wed, 29 Jan 2020 14:05:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 20A7AC447A4; Wed, 29 Jan 2020 14:05:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 44569C433CB;
        Wed, 29 Jan 2020 14:05:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Jan 2020 19:35:21 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org
Subject: Re: [RFC v3 09/10] arm64: dts: qcom: sdm845: Add cpu OPP tables
In-Reply-To: <20200129012411.GI46072@google.com>
References: <20200127200350.24465-1-sibis@codeaurora.org>
 <20200127200350.24465-10-sibis@codeaurora.org>
 <20200129012411.GI46072@google.com>
Message-ID: <4f2b98a1dae3bc737a43a1e46255657b@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Matthias,

Thanks for the review!

On 2020-01-29 06:54, Matthias Kaehlcke wrote:
> Hi Sibi,
> 
> On Tue, Jan 28, 2020 at 01:33:49AM +0530, Sibi Sankar wrote:
>> Add OPP tables required to scale DDR/L3 per freq-domain on SDM845 
>> SoCs.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 453 
>> +++++++++++++++++++++++++++
>>  1 file changed, 453 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi 
>> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index c036bab49fc03..8cb976118407b 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -199,6 +199,12 @@
>>  			qcom,freq-domain = <&cpufreq_hw 0>;
>>  			#cooling-cells = <2>;
>>  			next-level-cache = <&L2_0>;
>> +			operating-points-v2 = <&cpu0_opp_table>,
>> +					      <&cpu0_ddr_bw_opp_table>,
>> +					      <&cpu0_l3_bw_opp_table>;
>> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC &mem_noc 
>> SLAVE_EBI1>,
>> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> 
> This apparently depends on the 'Split SDM845 interconnect nodes and
> consolidate RPMh support' series
> (https://patchwork.kernel.org/project/linux-arm-msm/list/?series=226281),
> which isn't mentioned in the cover letter.
> 
> I also couldn't find a patch on the lists that adds the 'osm_l3'
> interconnect node for SDM845. The same is true for SC7180 (next
> patch of this series). These patches may be available in custom trees,
> but that isn't really helpful for upstream review.

yeah I missed adding the interconnect
refactor dependency and the nodes.

> 
> I would suggest to focus on landing the dependencies of this series,
> before proceding with it (or at least most of them), there are plenty
> and without the dependencies this series isn't going to land, it also
> makes it hard for testers and reviewers to get all the pieces

yes I understand but wanted the series
out asap because since there are a few
points where we still havn't reached
a consensus on.

> together. In particular the last post of the series 'Add
> required-opps support to devfreq passive gov'
> (https://patchwork.kernel.org/cover/11055499/) is from July 2019 ...

https://lore.kernel.org/lkml/CAGTfZH37ALwUHd8SpRRrBzZ6x1-++YtzS60_yRQvN-TN6rOzaA@mail.gmail.com/

The pending patch for lazy linking
was posted a while back. Now that
it has a tested-by, majority of the
series should go in since the devfreq
maintainers wanted the series pulled
in.

> 
> Thanks
> 
> Matthias

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
