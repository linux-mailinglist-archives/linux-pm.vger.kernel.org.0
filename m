Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750A43E5A00
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 14:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239470AbhHJMeU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 08:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240555AbhHJMeT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Aug 2021 08:34:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8576D60462;
        Tue, 10 Aug 2021 12:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628598837;
        bh=fhsz0BxVURPIdp6eG839zOcCbucoqG9Srd3uY0rDGfM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UjQoAzF/KSd7KTwl/9zpnY1yw1HV3jqfcWuzxJlimpM7BlpR4AX2gQ8wVr54kNE5f
         JzNcNaba5PKiJwigcmNrLnG+VyTBoPZ9gaWiV0ERZ0gF6VqVZ3g8qcEo7p8xFTwA7p
         vGAAy+Y/MF07RzrrtXyAD3/3hWsSm4Svd/MbPyFjNriivatsjxcNK8fuJTvv9buswM
         +GdXz9M/jnytv17hHZEDcgvE2RRnDdUqYMTPmvrhbI6UbvsDxGG4rAtiRdJEB6euWf
         fn/EP/pjZFQp28E0qgnVmz+JIJjR3tf1ltrr9L0busOsNOZN3dTjFnfvA+jcW8P+ty
         qapslyqaBremg==
Subject: Re: [v6 3/3] arm64: dts: qcom: sc7280: Add EPSS L3 interconnect
 provider
To:     Odelu Kukatla <okukatla@codeaurora.org>, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, mdtipton@codeaurora.org, sibis@codeaurora.org,
        saravanak@google.com, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
References: <1628577962-3995-1-git-send-email-okukatla@codeaurora.org>
 <1628577962-3995-4-git-send-email-okukatla@codeaurora.org>
From:   Georgi Djakov <djakov@kernel.org>
Message-ID: <544023fc-f440-53bb-3308-33a1782aac19@kernel.org>
Date:   Tue, 10 Aug 2021 15:33:52 +0300
MIME-Version: 1.0
In-Reply-To: <1628577962-3995-4-git-send-email-okukatla@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Odelu,

On 10.08.21 9:46, Odelu Kukatla wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider node on SC7280
> SoCs.
> 
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---
>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 53a21d0..e78f055 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -586,6 +586,15 @@
>   			qcom,bcm-voters = <&apps_bcm_voter>;
>   		};
>   
> +		epss_l3: interconnect@18590000 {

This DT node should be moved after apps_rsc: rsc@18200000
and before cpufreq@18591000

> +			compatible = "qcom,sc7280-epss-l3";
> +			reg = <0 0x18590000 0 1000>, <0 0x18591000 0 0x100>,
> +				<0 0x18592000 0 0x100>, <0 0x18593000 0 0x100>;

Please align to the open parenthesis, to be consistent with the rest of
the file.

> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
> +			clock-names = "xo", "alternate";
> +			#interconnect-cells = <1>;
> +		};
> +
>   		ipa: ipa@1e40000 {
>   			compatible = "qcom,sc7280-ipa";

Thanks,
Georgi

