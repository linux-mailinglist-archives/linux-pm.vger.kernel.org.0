Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9C13E4A36
	for <lists+linux-pm@lfdr.de>; Mon,  9 Aug 2021 18:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhHIQrv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Aug 2021 12:47:51 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31427 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233472AbhHIQrs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Aug 2021 12:47:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628527648; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=yUxHTAvfQ3lFYbw5/P/m+T6OTXizyFzlcN9gu+Rsslw=;
 b=Swfn7cY87fOlCpWWXp+r1cmYX/y9/uzExY1xynlVyoNz71KSQVIT4hDS3Jsv+toJsaDgDzw1
 68uTpDhKMmJSwmSgTWjNl42nVDaphctcddD4H+B/LxLFWz1T5hq9eD5OEWBCCkYK0zUutWCi
 49QKW4vaffZVxc3zstuk9QceIW4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 61115c1ab14e7e2ecba13de2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 09 Aug 2021 16:47:22
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3B055C43217; Mon,  9 Aug 2021 16:47:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F9ACC433D3;
        Mon,  9 Aug 2021 16:47:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Aug 2021 22:17:18 +0530
From:   okukatla@codeaurora.org
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        evgreen@google.com, georgi.djakov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        seansw@qti.qualcomm.com, elder@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [V4 3/3] arm64: dts: qcom: sc7280: Add EPSS L3 interconnect
 provider
In-Reply-To: <CAE-0n52XPJ7COZc7Zy=721-FGPX9D=vSFR_qccL86UXuABuy9Q@mail.gmail.com>
References: <1624015734-16778-1-git-send-email-okukatla@codeaurora.org>
 <1624015734-16778-4-git-send-email-okukatla@codeaurora.org>
 <CAE-0n52XPJ7COZc7Zy=721-FGPX9D=vSFR_qccL86UXuABuy9Q@mail.gmail.com>
Message-ID: <74e3a26642342e88cb93c4e1aee62705@codeaurora.org>
X-Sender: okukatla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-07-09 04:34, Stephen Boyd wrote:
> Quoting Odelu Kukatla (2021-06-18 04:28:54)
>> Add Epoch Subsystem (EPSS) L3 interconnect provider node on SC7280
>> SoCs.
>> 
>> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi 
>> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 38a7f55..7690d7e 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -1153,6 +1153,15 @@
>>                         };
>>                 };
>> 
>> +               epss_l3: interconnect@18590000 {
>> +                       compatible = "qcom,sc7280-epss-l3";
>> +                       reg = <0 0x18590000 0 1000>, <0 0x18591000 0 
>> 0x100>,
>> +                               <0 0x18592000 0 0x100>, <0 0x18593000 
>> 0 0x100>;
>> +                       clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc 
>> GCC_GPLL0>;
>> +                       clock-names = "xo", "alternate";
>> +                       #interconnect-cells = <1>;
>> +               };
> 
> Is this inside the soc node? Because it should be but then the next 
> node
> is called 'interconnect' and has no address so that is probably outside
> the soc node. Please put nodes with a reg property like this into the
> soc node.
> 
no, will move this into soc node in v5.
>> +
>>                 clk_virt: interconnect {
>>                         compatible = "qcom,sc7280-clk-virt";
>>                         #interconnect-cells = <2>;
