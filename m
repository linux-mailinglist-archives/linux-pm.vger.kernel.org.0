Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 939A1418A3
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 01:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407928AbfFKXIX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 19:08:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40298 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404124AbfFKXIW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jun 2019 19:08:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so5080714pfp.7
        for <linux-pm@vger.kernel.org>; Tue, 11 Jun 2019 16:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vjl9Ns8qTRMKP0J+iO0hKqMC3min1EiwS3qQ6sVNS1c=;
        b=YN/UgLNkyeTM1qoFucU0AJFUxeziYWrhUCibHWCA/qlMUN6spFPO8C0Kvv+zJFiWDC
         zXLmuybO9JFifvUo0mmqfj9igpjzb8fqlzcAz4+Yx47Sy3EhpPa2HK9x8iDXoDHBOzRw
         wBVo3r4//Gkv25xlprDkXizA7UxjgB+dzDQWPxtn0DwKTAGgkmLq2+RiOvUfT6vva2B1
         WjN23HAl91P5GutP+gJ9ynAWNtTOWJm11MBQHdpYh4QY6CW5KrXtCKBLV1zqh2z6R21S
         ++xN7LRProkA12fmgeIpexQ9SL27ncDFGksdFy/T+a3GvZ8I33Ej4FpjvxShMCxflUdd
         7GpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vjl9Ns8qTRMKP0J+iO0hKqMC3min1EiwS3qQ6sVNS1c=;
        b=pRDvWxCL8rewGSoOBok/Dm4g/iQ9VEXqXnazeJlW9jwLRUTbdw5CKfPhhj9o5NOJf6
         DiUf/NaUmT5LmvX971vK7IWovSuuyTy/R/9rYeHqGj8RLfu8wzP3o2KFqSP2HYw6phPH
         Xo6ILsDNWZK7f5uOF95ABz4ztxWIjzY+rGBX/XnbFlSviGyL+TuZzIVPJ0u/F9qEITbt
         ZzJcfazglmaiv2sfMSprQayP8HGMoDdpIffv/M8F9eXzaSYlEkZSN5ftKDPxnoWzK5lV
         3zwTZAesYAcd6GYyFn0I6hoaMSE2595jcd1HJlg1Uo3kHYjUt/ik/nQzcx3892Z8HPZ7
         6qHA==
X-Gm-Message-State: APjAAAXH4yEJ/Q9J4NWkOs7P1eHPYuKfWo3gFoI2lpXhW28r6rcAC2oS
        REune6zjarGUB1+LnygIn8P3NQ==
X-Google-Smtp-Source: APXvYqynsWTp0wdQaNa3lyxkx2tbF0tlUWrRe3v1z2Eum8yVKB/bjwEiZ8XB8FqYlwWcOT8gSLV1Jg==
X-Received: by 2002:a17:90a:25e6:: with SMTP id k93mr8367124pje.100.1560294501786;
        Tue, 11 Jun 2019 16:08:21 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c129sm29717844pfa.106.2019.06.11.16.08.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 16:08:20 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:08:18 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     robh+dt@kernel.org, agross@kernel.org, vkoul@kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: interconnect: Add Qualcomm QCS404 DT
 bindings
Message-ID: <20190611230818.GT4814@minitux>
References: <20190611164157.24656-1-georgi.djakov@linaro.org>
 <20190611164157.24656-2-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611164157.24656-2-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 11 Jun 09:41 PDT 2019, Georgi Djakov wrote:

> The Qualcomm QCS404 platform has several buses that could be controlled
> and tuned according to the bandwidth demand.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> 
> v3:
> - Add a reg property and move the interconnect nodes under the "soc" node.
> 
> v2:
> - No changes.
> 
>  .../bindings/interconnect/qcom,qcs404.txt     | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> new file mode 100644
> index 000000000000..14a827268dda
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> @@ -0,0 +1,46 @@
> +Qualcomm QCS404 Network-On-Chip interconnect driver binding
> +-----------------------------------------------------------
> +
> +Required properties :
> +- compatible : shall contain only one of the following:
> +			"qcom,qcs404-bimc"
> +			"qcom,qcs404-pcnoc"
> +			"qcom,qcs404-snoc"
> +- #interconnect-cells : should contain 1
> +
> +Optional properties :
> +reg : specifies the physical base address and size of registers
> +clocks : list of phandles and specifiers to all interconnect bus clocks
> +clock-names : clock names should include both "bus_clk" and "bus_a_clk"
> +
> +Example:
> +
> +soc {
> +	...
> +	bimc: interconnect@400000 {
> +		reg = <0x00400000 0x80000>;
> +		compatible = "qcom,qcs404-bimc";
> +		#interconnect-cells = <1>;
> +		clock-names = "bus_clk", "bus_a_clk";
> +		clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> +			<&rpmcc RPM_SMD_BIMC_A_CLK>;
> +	};
> +
> +	pnoc: interconnect@500000 {
> +		reg = <0x00500000 0x15080>;
> +		compatible = "qcom,qcs404-pcnoc";
> +		#interconnect-cells = <1>;
> +		clock-names = "bus_clk", "bus_a_clk";
> +		clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
> +			<&rpmcc RPM_SMD_PNOC_A_CLK>;
> +	};
> +
> +	snoc: interconnect@580000 {
> +		reg = <0x00580000 0x23080>;
> +		compatible = "qcom,qcs404-snoc";
> +		#interconnect-cells = <1>;
> +		clock-names = "bus_clk", "bus_a_clk";
> +		clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +			<&rpmcc RPM_SMD_SNOC_A_CLK>;
> +	};
> +};
