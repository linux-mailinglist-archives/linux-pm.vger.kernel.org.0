Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856A540D438
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 10:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbhIPIFO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 04:05:14 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56481 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235039AbhIPIDU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Sep 2021 04:03:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631779266; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=tP+XNZ/9NH4K4GD+4JVcxuh8dLGXglkOiSbkpJxZE3s=;
 b=PWcNNGEDpy7AYnyIZvRmsTVCPTSYuoGGF4z95qv6Syn9UO2h6OxM2FYqZpGJLRFczKXT/evy
 JlLGfKaojdEfwyGMQ7o1z/SAgPJ0GhdMYPv219b7OYUSHy3ue9RseqZl53HDzoWwYl7g/AD+
 hqTiEcqIrDlRet63utaX3OoLO08=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6142f9a4bd6681d8ed3675a0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Sep 2021 08:00:36
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 92B98C43617; Thu, 16 Sep 2021 08:00:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BBFEBC4360D;
        Thu, 16 Sep 2021 08:00:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 16 Sep 2021 13:30:34 +0530
From:   okukatla@codeaurora.org
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        evgreen@google.com, georgi.djakov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdtipton@codeaurora.org, sibis@codeaurora.org,
        saravanak@google.com, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        okukatla=codeaurora.org@codeaurora.org
Subject: Re: [v7 3/3] arm64: dts: qcom: sc7280: Add EPSS L3 interconnect
 provider
In-Reply-To: <CAE-0n53g=qGoVAMh_me_W0ksp39WUm2CCwAttcAK+Do5nYXq5g@mail.gmail.com>
References: <1629458622-4915-1-git-send-email-okukatla@codeaurora.org>
 <1629458622-4915-4-git-send-email-okukatla@codeaurora.org>
 <CAE-0n51WBdLoJRPs9tWZgdAukJMnkD3V00o7xNYVX77-eToKvw@mail.gmail.com>
 <749157bdb4613ae370adfb7ba055a2a9@codeaurora.org>
 <36fe241f845a27b52509274d007948b1@codeaurora.org>
 <CAE-0n53g=qGoVAMh_me_W0ksp39WUm2CCwAttcAK+Do5nYXq5g@mail.gmail.com>
Message-ID: <49ba33707767f856ff2a868906387b16@codeaurora.org>
X-Sender: okukatla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-09-16 01:10, Stephen Boyd wrote:
> Quoting okukatla@codeaurora.org (2021-09-14 23:26:19)
>> On 2021-09-15 10:35, okukatla@codeaurora.org wrote:
>> > On 2021-09-04 00:36, Stephen Boyd wrote:
>> >> Quoting Odelu Kukatla (2021-08-20 04:23:41)
>> >>> Add Epoch Subsystem (EPSS) L3 interconnect provider node on SC7280
>> >>> SoCs.
>> >>>
>> >>> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
>> >>> ---
>> >>>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 11 +++++++++++
>> >>>  1 file changed, 11 insertions(+)
>> >>>
>> >>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> >>> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> >>> index 53a21d0..cf59b47 100644
>> >>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> >>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> >>> @@ -1848,6 +1848,17 @@
>> >>>                         };
>> >>>                 };
>> >>>
>> >>> +               epss_l3: interconnect@18590000 {
>> >>> +                       compatible = "qcom,sc7280-epss-l3";
>> >>> +                       reg = <0 0x18590000 0 1000>,
>> >>
>> >> Is this supposed to be 0x1000?
>> >>
>> > No, This is 1000 or 0x3E8.
> 
> Wow ok. Why is it the only size that isn't in hex format? Please try to
> be consistent and use hex throughout.
> 
Sure, will update it to hex format in new revision.
>> We have mapped only required registers for L3 scaling, 1000/0x3E8 is
>> suffice.
>> But i will update it to 0x1000 in next revision so that entire clock
>> domain region-0 is mapped.
> 
> Doesn't that conflict with the cpufreq-hw device?
> 
epss_l3 maps (0x18590000, size:0x1000) region which cpufreq-hw does not 
need. I will update size to 0x1000 for this region only.

>> >>> +                             <0 0x18591000 0 0x100>,
>> >>> +                             <0 0x18592000 0 0x100>,
>> >>> +                             <0 0x18593000 0 0x100>;
>> >>> +                       clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc
>> >>> GCC_GPLL0>;
>> >>> +                       clock-names = "xo", "alternate";
>> >>> +                       #interconnect-cells = <1>;
>> >>> +               };
>> >>> +
>> >>>                 cpufreq_hw: cpufreq@18591000 {
>> >>>                         compatible = "qcom,cpufreq-epss";
>> >>>                         reg = <0 0x18591100 0 0x900>,
