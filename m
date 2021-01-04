Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F562E97B1
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 15:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbhADOxp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 09:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbhADOxp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 09:53:45 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30A7C061793
        for <linux-pm@vger.kernel.org>; Mon,  4 Jan 2021 06:53:04 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q18so32492880wrn.1
        for <linux-pm@vger.kernel.org>; Mon, 04 Jan 2021 06:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:subject:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HAtIHzU9YXuhZVDWQSq0AHxX7Ade0jobNAYTrIOov+c=;
        b=pJhiM7EC4dN2iT0ISUQx5JqPG8ZY3ACJIIGv9zJTTKLVBzC7YV6m1d/5m+RIOcIZ3A
         90vb/WnIZmv4NFR5rLeiwjNB1mNR1ioA0F81iPUXcSQ/aFrnD5PP8+m/6aIp+OHAmNnG
         jYERNcn8dMXhXaJ+4etnqmtLlduCEeQkmjBCnXQ1p3L2PXzB6BMX+ML6zMLyVQIApOaq
         rLTZhfrPSqPhVG6ytuIBlr8PqNYC72YS4F8FnZ9jtomLQ1C7dNDSX+b6ea97mMiyeJuD
         65pHp9dtaQadBu/gFDJflOUzjyHzydfPS4jbnI5iS3D0h+YGjur225qJjqUJUuv6NFEt
         qUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HAtIHzU9YXuhZVDWQSq0AHxX7Ade0jobNAYTrIOov+c=;
        b=BF5Db+nWwBJlweJhnh3Tm3c0XjOI2CiIpSwLaFWkRoLU/vKQI97KuMZXb5ZAlF45w4
         z4/F2kIkgp+HaJ81l/XPFo5DzHfZjvCdFpZC3+bBu0rB60paxojmqbeEhrbk+D0QBMJX
         3D0W6zCtJiptemlru3kzMVpB1SmfjH7wo0b47esAr+A1/FY0mxNV4p8DFCiKPQNW/hcC
         xz4bHmKV0nu9ItnsFXECT/dzhRXrkDiXWAMNt5v2Uk8pRUkyrzEWsT/8Z6ZP/Q4XXKFW
         D1cFX58PKpOfFU4axp+CQR2JdEZ+4JNfOQawfsPg2PCpHBXczpDry4Lns/iuGcGPEXPB
         LTxg==
X-Gm-Message-State: AOAM532ypKif/irFTKX9vQxcPJdgaaB5CNRKvvScQixd9sjGtuV16rmy
        SvFq2R55cHMM7UQfw7My+AyWJQ==
X-Google-Smtp-Source: ABdhPJzSiDf76pgxkQZeU2oAlwxP1t9slLWuINnvnu/AaUe+1q+tQHfmKAhdcDzEm6EyMxwMP0Eb1g==
X-Received: by 2002:a05:6000:10c4:: with SMTP id b4mr81788248wrx.170.1609771983699;
        Mon, 04 Jan 2021 06:53:03 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id o74sm40110727wme.36.2021.01.04.06.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 06:53:03 -0800 (PST)
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, robh@kernel.org,
        shawnguo@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, cdleonard@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Leonard Crestez <leonard.crestez@nxp.com>
References: <20201210100906.18205-1-martin.kepplinger@puri.sm>
 <20201210100906.18205-2-martin.kepplinger@puri.sm>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v3 1/6] arm64: dts: imx8mq: Add NOC node
Message-ID: <5af9ae66-039c-2e94-6b69-d5a6b0f2a0b3@linaro.org>
Date:   Mon, 4 Jan 2021 16:53:03 +0200
MIME-Version: 1.0
In-Reply-To: <20201210100906.18205-2-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/10/20 12:09, Martin Kepplinger wrote:
> From: Leonard Crestez <leonard.crestez@nxp.com>
> 
> Add initial support for dynamic frequency scaling of the main NOC
> on imx8mq.
> 
> Make DDRC the parent of the NOC (using passive governor) so that the
> main NOC is automatically scaled together with DDRC by default.
> 
> Support for proactive scaling via interconnect will come on top.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>

Acked-by: Georgi Djakov <georgi.djakov@linaro.org>

> ---
>   arch/arm64/boot/dts/freescale/imx8mq.dtsi | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index a841a023e8e0..9c9d68a14e69 100644
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
> +			fsl,ddrc = <&ddrc>;
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
