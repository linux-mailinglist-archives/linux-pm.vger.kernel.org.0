Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC572ECA7
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 00:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbfD2WQ6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 18:16:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41986 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbfD2WQ6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 18:16:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id k9so6647688oig.9;
        Mon, 29 Apr 2019 15:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LLSomgcidVOLTe6rCarJcZL8h/0AxpVsGlwcNcgeIZc=;
        b=GplGoXfyHoTS1OA2KkHJwgAxUwRTMZ0mm76vDcIc9zn/55cpVVeSbDMN36ZcLEkduS
         1BfSZ2pskPu+Kv1WST0Z39+e45U/48zoou2N3TtWMn/K5DFsFow+CDFAeHYJRbLsclmE
         hxdiZNxuvuRPcYnbJ8tM9pxWeJ0lyfarrxlxVL/I+SvNadBZRRddsDcX9s4Hn/7hoe2I
         zUSrzm1UdC5R6LbmD+P6sUlSrYaVOKI2bF3OVSmAasMHgJIivy6yK97EBguLbDBcE/JO
         AWJntVCF0UrBITU0IahPkrSvpSF3l7fPv7C7tSHfdlBGiT13ubGVJ0oLnc0pSIDTstJC
         8R7A==
X-Gm-Message-State: APjAAAXB+yUJquQ5HmrWi0rWdNq1Eibf4lpdTEWUCUGwyrpU6laRmPif
        2wO5/VrUcgMyxn43OMxl0w==
X-Google-Smtp-Source: APXvYqwkOCIJLujhskobK/4m5vnwo3g+MH+dz03BglSEDJoU5hZlsyrMbfcO44Jj7KSt5Se3+VX4cA==
X-Received: by 2002:a54:4f15:: with SMTP id e21mr980418oiy.122.1556576217427;
        Mon, 29 Apr 2019 15:16:57 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 2sm13926206ots.22.2019.04.29.15.16.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 15:16:56 -0700 (PDT)
Date:   Mon, 29 Apr 2019 17:16:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: interconnect: Add Qualcomm QCS404 DT
 bindings
Message-ID: <20190429221656.GA1843@bogus>
References: <20190415104357.5305-1-georgi.djakov@linaro.org>
 <20190415104357.5305-2-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415104357.5305-2-georgi.djakov@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 15, 2019 at 01:43:54PM +0300, Georgi Djakov wrote:
> The Qualcomm QCS404 platform has several buses that could be controlled
> and tuned according to the bandwidth demand.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> 
> v2:
> - No changes.
> 
>  .../bindings/interconnect/qcom,qcs404.txt     | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> new file mode 100644
> index 000000000000..9befcd14a5b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
> @@ -0,0 +1,45 @@
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
> +clocks : list of phandles and specifiers to all interconnect bus clocks
> +clock-names : clock names should include both "bus_clk" and "bus_a_clk"
> +
> +Example:
> +
> +rpm-glink {
> +	...
> +	rpm_requests: glink-channel {
> +		...
> +		bimc: interconnect@0 {

Unit-address needs a 'reg' property. dtc should give you a warning 
(maybe W=1 is still needed).

> +			compatible = "qcom,qcs404-bimc";
> +			#interconnect-cells = <1>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> +				<&rpmcc RPM_SMD_BIMC_A_CLK>;
> +		};
> +
> +		pnoc: interconnect@1 {
> +			compatible = "qcom,qcs404-pcnoc";
> +			#interconnect-cells = <1>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
> +				<&rpmcc RPM_SMD_PNOC_A_CLK>;
> +		};
> +
> +		snoc: interconnect@2 {
> +			compatible = "qcom,qcs404-snoc";
> +			#interconnect-cells = <1>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +				<&rpmcc RPM_SMD_SNOC_A_CLK>;
> +		};
> +	};
> +};
