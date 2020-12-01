Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B042CA344
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 13:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbgLAM5a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 07:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgLAM53 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2020 07:57:29 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAD0C061A47
        for <linux-pm@vger.kernel.org>; Tue,  1 Dec 2020 04:56:49 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id z7so2493732wrn.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Dec 2020 04:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fhSdydiNHIuE7kH/VZv5LNrrxvRIALi9bCyYo0cAOQ0=;
        b=GBU61fFcIfgXME5qVa36xFJVFJmb5+EHsvpQuu7GUNrca+sC99MVJa5L3eXYGY/ue6
         vdeiDP5CstZt8slf4x3ydVOXINeGZElSS0q8mbuRJvo6Oqwe3F/cohI9+8Dctlke5zAs
         iBJHA+WM/dzYl8ENXWS1nAFYIlYtk9O8bO7h/hv1Gg8OJbrpYerXmC11DJn2tcMn60JM
         R0LUj26CsIy4MI6mFnbb5TJS7rlRV/CJ0eE8mqt7lXv9PQKD+LghHjpWccgBryN6KDJ1
         QqgwV6HnY3qwDzziY9sCwy8lwtq8pK7Xz55e2dVFbR/or3HpVdiqom+tOB5TDbf1QNKB
         GMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fhSdydiNHIuE7kH/VZv5LNrrxvRIALi9bCyYo0cAOQ0=;
        b=agyF1jszSTxZ1ljn7AgNSUGk6ER+NUv5XSr+HIeom8VILX/ExQ71aCZmAamuXuVuKC
         9bL56E59Hfne3+G+org3JByLkzk8bW6+ZH+DUoM9KSJSfJLXWavmlwlEEgBAzeHNTwdX
         hFIdltW0VOYnbcw4ZGWzXUpAJpPl+Kbk5rJL1xDd+x1iHWLyiWvluNXoqLnnyMp2kWGy
         YXaaIjPBeVOLytOm/tIkgYD6wzJmXG7shlhESBQHfx2AJxVmcIOjQ72G/sQj23OW8Uxu
         MvpFqSJgLqDw2ck/dJUkMMkxm5sVNAEOvfKEhTGMHbWyUp6zsBJ5UnFzRYEn75oiTu4e
         zxUA==
X-Gm-Message-State: AOAM530GuF+bwjOk5PPFheXG5bjp7GYsNjG/pAUrv/mwjzgL+RqffYqI
        m2GEi8u5lffvEttO78O1fALHzw==
X-Google-Smtp-Source: ABdhPJzQ1k3k98QkgMHXg5Y+DER3dcc331ppnIuJxF97i7TDGLT/iMqZRO5mfpwO6uJSzeSvhQu5ow==
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr3887518wru.70.1606827408027;
        Tue, 01 Dec 2020 04:56:48 -0800 (PST)
Received: from MacBook-Pro.local ([212.45.64.13])
        by smtp.googlemail.com with ESMTPSA id t136sm2859898wmt.18.2020.12.01.04.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 04:56:47 -0800 (PST)
Subject: Re: [PATCH v2 1/7] arm64: dts: imx8m: Add NOC nodes
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, robh@kernel.org,
        shawnguo@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, cdleonard@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Leonard Crestez <leonard.crestez@nxp.com>
References: <20201201123932.12312-1-martin.kepplinger@puri.sm>
 <20201201123932.12312-2-martin.kepplinger@puri.sm>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <4d089936-65fe-8601-73e7-0424d363b6f2@linaro.org>
Date:   Tue, 1 Dec 2020 14:56:46 +0200
MIME-Version: 1.0
In-Reply-To: <20201201123932.12312-2-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Martin,

Thank you for sending the patches.

On 1.12.20 14:39, Martin Kepplinger wrote:
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

As you are sending this, i believe that it should have your signed-off 
line (please check Documentation/process/submitting-patches.rst).

Also please give people some time to look into this (at least 1-2 weeks) 
before submitting a new version.

Thanks,
Georgi

> ---
>   arch/arm64/boot/dts/freescale/imx8mm.dtsi | 22 ++++++++++++++++++++++
>   arch/arm64/boot/dts/freescale/imx8mn.dtsi | 22 ++++++++++++++++++++++
>   arch/arm64/boot/dts/freescale/imx8mq.dtsi | 22 ++++++++++++++++++++++
>   3 files changed, 66 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index c824f2615fe8..835b19f0ea42 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -921,6 +921,28 @@
>   
>   		};
>   
> +		noc: interconnect@32700000 {
> +			compatible = "fsl,imx8mm-noc", "fsl,imx8m-noc";
> +			reg = <0x32700000 0x100000>;
> +			clocks = <&clk IMX8MM_CLK_NOC>;
> +			devfreq = <&ddrc>;
> +			operating-points-v2 = <&noc_opp_table>;
> +
> +			noc_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-150M {
> +					opp-hz = /bits/ 64 <150000000>;
> +				};
> +				opp-375M {
> +					opp-hz = /bits/ 64 <375000000>;
> +				};
> +				opp-750M {
> +					opp-hz = /bits/ 64 <750000000>;
> +				};
> +			};
> +		};
> +
>   		aips4: bus@32c00000 {
>   			compatible = "fsl,aips-bus", "simple-bus";
>   			reg = <0x32c00000 0x400000>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index a06d2a6268e6..8e2d413f97d4 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -772,6 +772,28 @@
>   
>   		};
>   
> +		noc: interconnect@32700000 {
> +			compatible = "fsl,imx8mn-noc", "fsl,imx8m-noc";
> +			reg = <0x32700000 0x100000>;
> +			clocks = <&clk IMX8MN_CLK_NOC>;
> +			devfreq = <&ddrc>;
> +			operating-points-v2 = <&noc_opp_table>;
> +
> +			noc_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-100M {
> +					opp-hz = /bits/ 64 <100000000>;
> +				};
> +				opp-600M {
> +					opp-hz = /bits/ 64 <600000000>;
> +				};
> +				opp-800M {
> +					opp-hz = /bits/ 64 <800000000>;
> +				};
> +			};
> +		};
> +
>   		aips4: bus@32c00000 {
>   			compatible = "fsl,aips-bus", "simple-bus";
>   			reg = <0x32c00000 0x400000>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index a841a023e8e0..d139a46ee8ce 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -1158,6 +1158,28 @@
>   			};
>   		};
>   
> +		noc: interconnect@32700000 {
> +			compatible = "fsl,imx8mq-noc", "fsl,imx8m-noc";
> +			reg = <0x32700000 0x100000>;
> +			clocks = <&clk IMX8MQ_CLK_NOC>;
> +			devfreq = <&ddrc>;
> +			operating-points-v2 = <&noc_opp_table>;
> +
> +			noc_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-133M {
> +					opp-hz = /bits/ 64 <133333333>;
> +				};
> +				opp-400M {
> +					opp-hz = /bits/ 64 <400000000>;
> +				};
> +				opp-800M {
> +					opp-hz = /bits/ 64 <800000000>;
> +				};
> +			};
> +		};
> +
>   		bus@32c00000 { /* AIPS4 */
>   			compatible = "fsl,aips-bus", "simple-bus";
>   			reg = <0x32c00000 0x400000>;
> 

