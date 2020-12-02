Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDAB2CB68E
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 09:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgLBIO6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 03:14:58 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38880 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbgLBIO6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 03:14:58 -0500
Received: by mail-ed1-f65.google.com with SMTP id y4so2440578edy.5;
        Wed, 02 Dec 2020 00:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TT/uTUFFN/ii3XuIKhocsW1P+4esb3GMyjg45cYhfmw=;
        b=YDoaOFa1V89kPWEutQF83iLnEE9PdFRebOkk+UmyhQa5kf7AD9egffnUzd9xlOTeNt
         i5u2g5LHa1fDXI4Rc3V2c1EEwBARUemMZJc2ckepYEgwh+WW6EMpUBztpifN0U/zfHCF
         /MtRdUKnvq0LRuU10ajPzPMcZ8SrrHlSbpkV2cSzyTt9Au28DypVdkQCrvJS90BNniv4
         96MchgW8wr9p6hzOK5ote/SYZokgbch2olumONwQOVU9zZPGHiqGgNQ/BW/keneWNdOj
         3o/g1ITzi45nbcwncL4dEiKGNN3EeMyPXgB5gUUaiZOM42ooBTpf/09HyHc/4lmz8Pu6
         BcWA==
X-Gm-Message-State: AOAM530dW6f2swM2y9FwJqU+cfzXRddgQCXzMzGdUmvkaSLVGkIBuw8U
        2tByO9oUInRNZLzR0OVEi/E=
X-Google-Smtp-Source: ABdhPJyMM7FKXEQhSlSBoNgKgJu1OHlNcPb6mAKR0YIumHw63tEmeKdRM/o25l4uFRe8+xQEZ27xkQ==
X-Received: by 2002:a50:fd88:: with SMTP id o8mr1483615edt.386.1606896850107;
        Wed, 02 Dec 2020 00:14:10 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id dk4sm610413edb.54.2020.12.02.00.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 00:14:08 -0800 (PST)
Date:   Wed, 2 Dec 2020 10:14:07 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, georgi.djakov@linaro.org,
        cdleonard@gmail.com, kernel@pengutronix.de, linux-imx@nxp.com,
        kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH v2 1/7] arm64: dts: imx8m: Add NOC nodes
Message-ID: <20201202081407.GA7157@kozik-lap>
References: <20201201123932.12312-1-martin.kepplinger@puri.sm>
 <20201201123932.12312-2-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201123932.12312-2-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 01, 2020 at 01:39:26PM +0100, Martin Kepplinger wrote:
> From: Leonard Crestez <leonard.crestez@nxp.com>
> 
> Add initial support for dynamic frequency scaling of main NOC.
> 
> Make DDRC the parent of the NOC (using passive governor) so that the
> main NOC is automatically scaled together with DDRC by default.
> 
> Support for proactive scaling via interconnect will come on top.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm> (imx8mq)
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 22 ++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 22 ++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 22 ++++++++++++++++++++++
>  3 files changed, 66 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index c824f2615fe8..835b19f0ea42 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -921,6 +921,28 @@
>  
>  		};
>  
> +		noc: interconnect@32700000 {
> +			compatible = "fsl,imx8mm-noc", "fsl,imx8m-noc";
> +			reg = <0x32700000 0x100000>;
> +			clocks = <&clk IMX8MM_CLK_NOC>;
> +			devfreq = <&ddrc>;

This does not pass the dtschema checks. Are you missing here any
dependencies?

arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: interconnect@32700000: 'devfreq' does not match any of the regexes: 'pinctrl-[0-9]+'

Best regards,
Krzysztof
