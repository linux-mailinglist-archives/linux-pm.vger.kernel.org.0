Return-Path: <linux-pm+bounces-36642-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4491BFB7BB
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 12:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9821891DEE
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 10:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B397C326D55;
	Wed, 22 Oct 2025 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xbkwqpvg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D0E31A7FE
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130589; cv=none; b=LURAWoqOGACjV0E5t7eW/qtOufHSec8LfJbZ6xMfU3srgqCd3qUaUQCGdfzK4fzxJ/v5MgNDaIjriwFtRGy3102N7CxyrGmcRqK5yHPzyyCnwFlRSgaSNsQUED8U5X5eYSmrX7P/1dV3KpRpgns1Scbgyyt17s5YVOioaN/kQ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130589; c=relaxed/simple;
	bh=dUV0ayqZiPaf4NOTXVPmQKKkCug+aByTSr9dcbRPtuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duV/DX0ZUv1uXbAJs5YGDv6NWop8rgrgUJYyaiAkamGGVoiuHsZ47ogLVyB5r5n1pFTHDBCGc3Idom98Jx9iRUFNFZAwtuGwOmK+T+5Bk6Wfg3d8+dIHpz7/C8qtGp607I0tVtD7SsE+OoMEpzZsI5iUe0i1rYaukloeLqcF1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xbkwqpvg; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b54f55a290cso1023624966b.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 03:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761130586; x=1761735386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o0A20oHPdwlwvYfXUnWJzAAzNbt9Wdmj/9G6WPspGzo=;
        b=XbkwqpvgwNgAqVFgu3Ij22ZaZIg8Dsa3XApkKeXwBwV7IUEsgwYc/0UTGWI94O0iBW
         nTI0adKhdcjmcORNyvhFS0/OCgQovU7TmEo842ofiGyAgVFi3W2IBwjBJ48Nmwhz6bSl
         +JXnaK6mRP/WKOC/9zS/GjNt+eU434E8KIz6eUNSvv8CXEYsQ8d/Ju6JE8oeXxLa+jaa
         S45J+dqY2sXL8dhqdNcUodIbyr3sA1FkFMHiXC8PTdpaGKcs5Ch+6YxyYvx73jXqB8ca
         q9QKQCt/G4koBFf12sK1+MasypKXaqKO6psmfFi1uYRXc5Xv1u29vY5clVDeAyinWSHR
         61DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761130586; x=1761735386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0A20oHPdwlwvYfXUnWJzAAzNbt9Wdmj/9G6WPspGzo=;
        b=MDOLqEwVd2BhTqWtFBoG6fkl5LvmyjaAtbfDo2y5vX688eTR4fEmO9TxrQX/Wz5wqM
         Nobibt7Jw51V73aiul4QV5LcWOritD6tIzdaEwkPv/EdmORRg/Tsa6t/osH9ZsrNn2IY
         jMYmuwIZsUP2dt9bbUiEENmOyctMoMncz9/4h27ObFjeS5r+1292fjNE2kDX0gA31JUU
         XxY1q3WfV4pC+FWIG7ZOmTw7+q9ISqW3OMl5NW8QtSOfvUUi7pPscvRqegFhoIRVrKSy
         M2FkrIqUo/T+bDu/1LkpDL9oKUKWuYYxaY9rtadykvmX8r/XEGnE9mVOd6fPL7xwM3dC
         6dFw==
X-Forwarded-Encrypted: i=1; AJvYcCUiZWn3b/vlogU6yJixgxJtOF35q2tD5oKkWDHY2o4sTm4XsDDEDiKBsg6n47TD+exs0ZzIXG6gYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhJAN/gNhnppyHv5a3w+yBsRatQm2kFtTIL4HGkS70T0SyFeWF
	J31dTmMNaj/eA+k/81sahCRAd7LmyaBXqmdARESSqQ/auumrsk7y3Hx6
X-Gm-Gg: ASbGncttHdNO6qQ9v9zKylqeiuEHB58zVZJhKiRr5owq5oDfElio9syzwltCQdIfqYk
	zErxZXMhJ4+U5pINwA93IBu9SNOKkyczpdGDfjq7ijsYNfeOuMmEpPv6biH4Ct5mOEq9nRpG/ig
	n/QCPb8iCdMvhjo2RX0LlR25tUItGtTj6XBos/+UxK4+xhOg7oCbyqAnkgNIlX+oruQQWtWP+FM
	GG0A6f3aH+ILn4apDXUdR9o8U9b+F1Ksq2LNdiN2vtx643RYXDTVXN6aCLLRaljCx+JHECWOquU
	s5F26QBnMHLJ9o8bEjAsNjDek+Bu/GbtzeZQ0STaUdkBBFtFi7a6IlGyberwPvXOcg38MSkGFI3
	R2v86p9bvEABszaTxUBeySgcJT1RFWfOfIWg0NOYXsmbW/ahT+s4FXhEYxkZ+HjaCxKpCxknePa
	XnE7HIWxloMlz5Pe72oJWdZ/8WZqWfLU7BXWPM/YmcVTllfUN+iTUMtO/1ePAROTBZ/scsnD8=
X-Google-Smtp-Source: AGHT+IEdGRi/hFagoGGgzKcGR3Q9DoSBThXuzMQp+xb2RQm2aipBLwQ9bktG/U+2WDFiA7eALZVStg==
X-Received: by 2002:a17:906:da09:b0:b6b:a82a:bbbc with SMTP id a640c23a62f3a-b6ba82acfb4mr887771466b.33.1761130585840;
        Wed, 22 Oct 2025 03:56:25 -0700 (PDT)
Received: from alb3rt0-ThinkPad-P15-Gen-1 (host-79-17-196-24.retail.telecomitalia.it. [79.17.196.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb526175sm1337364466b.56.2025.10.22.03.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:56:25 -0700 (PDT)
Date: Wed, 22 Oct 2025 12:56:22 +0200
From: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengfei Li <pengfei.li_1@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ye.li@nxp.com, joy.zou@nxp.com
Subject: Re: [PATCH v7 3/3] arm64: dts: imx91: Add thermal-sensor and
 thermal-zone support
Message-ID: <aPi4VqxIF/hltDC5@alb3rt0-ThinkPad-P15-Gen-1>
References: <20251020-imx91tmu-v7-0-48d7d9f25055@nxp.com>
 <20251020-imx91tmu-v7-3-48d7d9f25055@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-imx91tmu-v7-3-48d7d9f25055@nxp.com>

On Mon, Oct 20, 2025 at 03:00:42PM -0400, Frank Li wrote:
> Add thermal-sensor and thermal-zone support.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> changes in v7
> - new patch
> ---
>  arch/arm64/boot/dts/freescale/imx91.dtsi | 58 ++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx91.dtsi b/arch/arm64/boot/dts/freescale/imx91.dtsi
> index 4d8300b2a7bca33bd0613db9e79d2fba6b40c052..f075592bfc01f1eb94d2a2bd8eea907cc2aed090 100644
> --- a/arch/arm64/boot/dts/freescale/imx91.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx91.dtsi
> @@ -6,6 +6,54 @@
>  #include "imx91-pinfunc.h"
>  #include "imx91_93_common.dtsi"
>  
> +/{
> +	thermal-zones {
> +		cpu-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <2000>;
> +			thermal-sensors = <&tmu 0>;
> +
> +			trips {
> +				cpu_alert: cpu-alert {
> +					temperature = <80000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit: cpu-crit {
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_alert>;
> +					cooling-device =
> +						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +	};
> +};

Here you define cooling-maps with passive and critical trip points. 

I was trying test that by enabling CONFIG_THERMAL_EMULATION and setting
the emulated temp via 

echo 85000 > /sys/class/thermal/thermal_zone0/emul_temp

By checking with mhz (from lmbench Yocto recipe) command I was expecting that the 91 start
throttling but is not the case, Am I missing something?

Thanks,
Alberto

