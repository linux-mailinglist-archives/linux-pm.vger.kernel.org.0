Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD34314CBA6
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 14:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgA2Npk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 08:45:40 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:34736 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726358AbgA2Npk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jan 2020 08:45:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580305539; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ojDBEpX51W6sDTBSjLkh/H0P2Fm3q0j1K0tU3d1S4Bg=;
 b=QPXYdqiilueYeBZ3Tf/GFnGtYBSrTKnTTPHYgOddXA+KgSYeGk/PJ39rfnu8xsaJ8WengwCj
 7dX7OA39IaLM+l71s79hep5ZC2fUrVZjJe04fJhRFT3QP0WEEOt2/9CExl9IuK6hvaWWT3mM
 fnevT0s3JxCVee/yK+AWRWYjvjw=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e318c82.7f5224421068-smtp-out-n02;
 Wed, 29 Jan 2020 13:45:38 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1AB02C447A1; Wed, 29 Jan 2020 13:45:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49A95C433CB;
        Wed, 29 Jan 2020 13:45:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Jan 2020 19:15:37 +0530
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
        ulf.hansson@linaro.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [RFC v3 01/10] arm64: dts: qcom: sdm845: Add SoC compatible to
 MTP
In-Reply-To: <20200128204005.GE46072@google.com>
References: <20200127200350.24465-1-sibis@codeaurora.org>
 <20200127200350.24465-2-sibis@codeaurora.org>
 <20200128204005.GE46072@google.com>
Message-ID: <538227707b751f67fd773f6ebfa908d8@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Matthias,
Thanks for the review!

On 2020-01-29 02:10, Matthias Kaehlcke wrote:
> Hi Sibi,
> 
> On Tue, Jan 28, 2020 at 01:33:41AM +0530, Sibi Sankar wrote:
>> Add missing SoC compatible to SDM845 MTP board file.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts 
>> b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> index 09ad37b0dd71d..54087847794aa 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> @@ -13,7 +13,7 @@
>> 
>>  / {
>>  	model = "Qualcomm Technologies, Inc. SDM845 MTP";
>> -	compatible = "qcom,sdm845-mtp";
>> +	compatible = "qcom,sdm845-mtp", "qcom,sdm845";
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Since this is v3 already I think you can omit the RFC tag in the next
> revision of the series.

Yeah would like to drop the RFC
but every version seems to have
a feature which we havn't reached
a consensus on.

v1: CPUfreq passive governor
v2: New bandwidth bindings
v3: Multiple opp tables per device

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
