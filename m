Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE3C459158
	for <lists+linux-pm@lfdr.de>; Mon, 22 Nov 2021 16:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239761AbhKVP2k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Nov 2021 10:28:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239771AbhKVP2j (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Nov 2021 10:28:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D35B60F48;
        Mon, 22 Nov 2021 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637594733;
        bh=Dvp+HhTrhkQyvZ3Oi3ekjS9nvlbLN+xCqwLYoQL7qw4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=InyxsYWEW1pg35ixtAQ384nfnPcSgAE/Gv+4653Phc2tHKb30qPEHMNIO94mqf+yQ
         wm1KHNOuqhGxyuNuMGdVX3Ny8Ztg/5Ssjg8QGsANYmHj4qR56Uq3SlAm7NQH/no1gg
         diNdvMYTMLWpORufL+xgtu26JbW9mKYJah+dM0Psk24BVHEUdvdbTCynsniinpEPA9
         y1EyT/tGTc6OPo2HIXah5owTpZEulRlO7GDsOcYFF/0/WDBzN6M5Bt6+BsyhJap6CZ
         utzChOYz80M72kCfLQx0F7dKx+EhuYVk5ZfY/rJXiaIY+2OQXOAQun8b+76DKGoGgc
         /ZDYHAr2pY1ug==
Message-ID: <68544192-0c4f-ed64-27a2-0bfe2d7805b5@kernel.org>
Date:   Mon, 22 Nov 2021 17:25:27 +0200
MIME-Version: 1.0
Subject: Re: [v8 3/3] arm64: dts: qcom: sc7280: Add EPSS L3 interconnect
 provider
Content-Language: en-US
To:     bjorn.andersson@linaro.org,
        Odelu Kukatla <okukatla@codeaurora.org>,
        georgi.djakov@linaro.org, evgreen@google.com,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, mdtipton@codeaurora.org, sibis@codeaurora.org,
        saravanak@google.com, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
References: <1634812857-10676-1-git-send-email-okukatla@codeaurora.org>
 <1634812857-10676-4-git-send-email-okukatla@codeaurora.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <1634812857-10676-4-git-send-email-okukatla@codeaurora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21.10.21 13:40, Odelu Kukatla wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider node on SC7280
> SoCs.
> 
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>

Acked-by: Georgi Djakov <djakov@kernel.org>

> ---
>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index d74a4c8..0b55742 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3687,6 +3687,14 @@
>   			};
>   		};
>   
> +		epss_l3: interconnect@18590000 {
> +			compatible = "qcom,sc7280-epss-l3";
> +			reg = <0 0x18590000 0 0x1000>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
> +			clock-names = "xo", "alternate";
> +			#interconnect-cells = <1>;
> +		};
> +
>   		cpufreq_hw: cpufreq@18591000 {
>   			compatible = "qcom,cpufreq-epss";
>   			reg = <0 0x18591000 0 0x1000>,
> 

