Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1624F3CBD9F
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jul 2021 22:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhGPUV7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jul 2021 16:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbhGPUV4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jul 2021 16:21:56 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32144C06175F
        for <linux-pm@vger.kernel.org>; Fri, 16 Jul 2021 13:19:00 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id y66so2892983oie.7
        for <linux-pm@vger.kernel.org>; Fri, 16 Jul 2021 13:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=763nLM9hOG1xzTfiRC2C+QIzwsAiunJSWdOJQ5k5fPs=;
        b=U+WJbIw+QbtFWTk7uPEAZRY73FbUf/tDRQRuXsIo1cPylkyO9zzhyU7pDwxd+yTJ85
         zpiR45QHSGo73POsvAUjPQ/l/iQI5fZlw/MyleuuGAD/oeAX6/x9NXOtqKG1i/9XQuie
         hw293qk7qpj2PJYW3rlJEjalQYHJ7s5xPgEbiJ+0+LqHdKAM0ly4PWB3aTYa9Mek1CuF
         AbK6EkBhFF4KMNpm/5riMYQ0dmjw+AxczWK1qsj9RebPQoMogqXRkiNReHSDDZ9Irb2F
         A12DOSe1qm7aN+5Y9osoDmM4W2DZHqBvIj9ID25oIKXMv/uoVezS7p6pfZq8+D4OhqfJ
         kFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=763nLM9hOG1xzTfiRC2C+QIzwsAiunJSWdOJQ5k5fPs=;
        b=r82MKC7Q9vrUkMfmr1GFTEUNDysY+G9emdHEtpFiPNEwb4CZPDSUCYKcvnaM0JAc42
         YE201IHe9dNe9Ki7CoBQH8O/J3MrkpnSTx3WZS3d3nCjDgk6Sr88KavsrkPlPXXyNWn/
         cz+bcOBFcb03OWZFx1puqjPs14UuIUY5ok1ycAHEqmtr0RTofQB4Kl61CWiMGoqAIUwQ
         Bu6voQy0eBliyzQdF9ngRkB1qKxxlxV7DThSJgFB8JN3BScXTQUXtzs3ff/79eyjaGBF
         6TRwZoFmjP8QnfJAYZIGpMkgnmkr3tA+be4STj1XohD5SWFlysV0jT8mt+8HmMG7vcgM
         VxuA==
X-Gm-Message-State: AOAM533k6QqE36iQ0OxRDKzYj05xn9ZD1zLs/FqFHU5Be68ns9UUCwvG
        PGbf1n/T00Kxyr4EMML62xeTfw==
X-Google-Smtp-Source: ABdhPJyhjp4YjBkTEJEbAorL7JPZfDyaZTF/3+0OklBw8xqW343rmBB9mWANS3uGMTklxuxtDX5/1w==
X-Received: by 2002:a54:448a:: with SMTP id v10mr2428740oiv.44.1626466739501;
        Fri, 16 Jul 2021 13:18:59 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q63sm404390ooq.4.2021.07.16.13.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 13:18:59 -0700 (PDT)
Date:   Fri, 16 Jul 2021 15:18:56 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     ulf.hansson@linaro.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, rojay@codeaurora.org, stephan@gerhold.net
Subject: Re: [PATCH v4 2/2] arm64: dts: sc7180: Add required-opps for i2c
Message-ID: <YPHpsO5LlQRQxj9y@yoga>
References: <1626429658-18961-1-git-send-email-rnayak@codeaurora.org>
 <1626429658-18961-3-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626429658-18961-3-git-send-email-rnayak@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 16 Jul 05:00 CDT 2021, Rajendra Nayak wrote:

> qup-i2c devices on sc7180 are clocked with a fixed clock (19.2 MHz)
> Though qup-i2c does not support DVFS, it still needs to vote for a
> performance state on 'CX' to satisfy the 19.2 Mhz clock frequency
> requirement.
> 

Sounds good, but...

> Use 'required-opps' to pass this information from
> device tree, and also add the power-domains property to specify
> the CX power-domain.
> 

..is the required-opps really needed with my rpmhpd patch in place?

Regards,
Bjorn

> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index a5d58eb..cd30185 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -785,8 +785,10 @@
>  						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
>  						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
>  				interconnect-names = "qup-core", "qup-config",
>  							"qup-memory";
> +				power-domains = <&rpmhpd SC7180_CX>;
> +				required-opps = <&rpmhpd_opp_low_svs>;
>  				status = "disabled";
>  			};
>  
>  			spi0: spi@880000 {
> @@ -837,8 +839,10 @@
>  						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
>  						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
>  				interconnect-names = "qup-core", "qup-config",
>  							"qup-memory";
> +				power-domains = <&rpmhpd SC7180_CX>;
> +				required-opps = <&rpmhpd_opp_low_svs>;
>  				status = "disabled";
>  			};
>  
>  			spi1: spi@884000 {
> @@ -889,8 +893,10 @@
>  						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
>  						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
>  				interconnect-names = "qup-core", "qup-config",
>  							"qup-memory";
> +				power-domains = <&rpmhpd SC7180_CX>;
> +				required-opps = <&rpmhpd_opp_low_svs>;
>  				status = "disabled";
>  			};
>  
>  			uart2: serial@888000 {
> @@ -923,8 +929,10 @@
>  						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
>  						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
>  				interconnect-names = "qup-core", "qup-config",
>  							"qup-memory";
> +				power-domains = <&rpmhpd SC7180_CX>;
> +				required-opps = <&rpmhpd_opp_low_svs>;
>  				status = "disabled";
>  			};
>  
>  			spi3: spi@88c000 {
> @@ -975,8 +983,10 @@
>  						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
>  						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
>  				interconnect-names = "qup-core", "qup-config",
>  							"qup-memory";
> +				power-domains = <&rpmhpd SC7180_CX>;
> +				required-opps = <&rpmhpd_opp_low_svs>;
>  				status = "disabled";
>  			};
>  
>  			uart4: serial@890000 {
> @@ -1009,8 +1019,10 @@
>  						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
>  						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
>  				interconnect-names = "qup-core", "qup-config",
>  							"qup-memory";
> +				power-domains = <&rpmhpd SC7180_CX>;
> +				required-opps = <&rpmhpd_opp_low_svs>;
>  				status = "disabled";
>  			};
>  
>  			spi5: spi@894000 {
> @@ -1074,8 +1086,10 @@
>  						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
>  						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
>  				interconnect-names = "qup-core", "qup-config",
>  							"qup-memory";
> +				power-domains = <&rpmhpd SC7180_CX>;
> +				required-opps = <&rpmhpd_opp_low_svs>;
>  				status = "disabled";
>  			};
>  
>  			spi6: spi@a80000 {
> @@ -1126,8 +1140,10 @@
>  						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
>  						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
>  				interconnect-names = "qup-core", "qup-config",
>  							"qup-memory";
> +				power-domains = <&rpmhpd SC7180_CX>;
> +				required-opps = <&rpmhpd_opp_low_svs>;
>  				status = "disabled";
>  			};
>  
>  			uart7: serial@a84000 {
> @@ -1160,8 +1176,10 @@
>  						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
>  						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
>  				interconnect-names = "qup-core", "qup-config",
>  							"qup-memory";
> +				power-domains = <&rpmhpd SC7180_CX>;
> +				required-opps = <&rpmhpd_opp_low_svs>;
>  				status = "disabled";
>  			};
>  
>  			spi8: spi@a88000 {
> @@ -1212,8 +1230,10 @@
>  						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
>  						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
>  				interconnect-names = "qup-core", "qup-config",
>  							"qup-memory";
> +				power-domains = <&rpmhpd SC7180_CX>;
> +				required-opps = <&rpmhpd_opp_low_svs>;
>  				status = "disabled";
>  			};
>  
>  			uart9: serial@a8c000 {
> @@ -1246,8 +1266,10 @@
>  						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
>  						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
>  				interconnect-names = "qup-core", "qup-config",
>  							"qup-memory";
> +				power-domains = <&rpmhpd SC7180_CX>;
> +				required-opps = <&rpmhpd_opp_low_svs>;
>  				status = "disabled";
>  			};
>  
>  			spi10: spi@a90000 {
> @@ -1298,8 +1320,10 @@
>  						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>,
>  						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
>  				interconnect-names = "qup-core", "qup-config",
>  							"qup-memory";
> +				power-domains = <&rpmhpd SC7180_CX>;
> +				required-opps = <&rpmhpd_opp_low_svs>;
>  				status = "disabled";
>  			};
>  
>  			spi11: spi@a94000 {
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
