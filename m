Return-Path: <linux-pm+bounces-18589-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3769E483C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 23:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AC828110E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 22:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1B11F7090;
	Wed,  4 Dec 2024 22:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IXiSUX49"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB651F5439
	for <linux-pm@vger.kernel.org>; Wed,  4 Dec 2024 22:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733353166; cv=none; b=YhI68UTIW7fwAInQbLcYKiiecCLwZxkH+TDTNPFIZZwd7GO3/h/xzVoNg1SmAXrWgBAaZ7be8uGThJVD6nTDbjvQkuk/kzDAJ/WjV3JE/FJ7APKChH4AFzQt2bXU5bVpmXL6gfg2A0NWZJvQbWPzCAnJ4vmnVHJDmYc0+tL4Z68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733353166; c=relaxed/simple;
	bh=zu2zn/CG8LATXGnamKjYNIPIAQAZIUfMCZnfMDljbJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A77/xuT+uvBhDSwahW9+TqNUkvr1xTxz91lAK00y4wrhlj+If2Wms08qr9kZcsa2uJ0LNY3kAbTntUZbspVHveNJmzkUV+Y1VDnD6eZmk2/vZwfDcMhVuiYO8DI0ZPlH3yet91mEbGDF4Ivd98UPhTjadi5xHCG9UrlwYcvUil0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IXiSUX49; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53de84e4005so434408e87.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2024 14:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733353163; x=1733957963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTycC8k0POiTYVULvZ4XnFfri7Upa5YgerEMaIs+Jd8=;
        b=IXiSUX49C5EBU55+Vp5Lm6WBVLlKpOw12VSzXQiQ9BctKqBt2mNbFdy4bApo0/hCL6
         y/1P++taUn1sfQz75tL3k466L2ZAbQXHbOXbRkbMQ8lp+FjfM9HTWkO/7BM2j4yKfZ6S
         XJnL2Mc1oJaj3iEzTBGlpjCS+IbsqQcWckJWcvM7qQ5WRGSB8pr0GT/1aRJzELYvB1u4
         717qhqxcVAKjrFo8pWSqOhcYn+MjtR3MHrn1d4ABUjMe15DpzGI8+A/4Kb4Zf7DMBgqi
         eM4sUPSErrJ8SO4gOlICgpUtTXcp4cLqlmxuzaEiyHEH4ms1PTjQq3aBi1pO89Ie94ve
         uzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733353163; x=1733957963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTycC8k0POiTYVULvZ4XnFfri7Upa5YgerEMaIs+Jd8=;
        b=XECHjQ/cxJshv9iYRSODNpuURazY0THF4dV++ym6bAEcoV3j3qNqwN+zjBLwf0DvXs
         uN+qowsLD7BL1tD02jkTRg5wZgrf3V5dobfo3p7xETYoSImHZZUBJyGv5hIMcKXe7Odx
         KBf0O/fixoUtUKmg1Evfv0U6prgiHO6tyoTotB7Jm4kDjbTeoSs+WanTp2xM58RyPTfm
         a35VYrpNCDV5SD/ryI6K8hMR5rFIxD+e/CtVWtEPWkxmguEIn7A2EWepeEsxAqdg2yJq
         /uwFNe/T+5414xbublviMh5fpwj4WerTlhYfJdGmrHsN+wa20H7DCzz9LN9QhPa+f+OA
         8zsg==
X-Forwarded-Encrypted: i=1; AJvYcCVVqCqjnrRhXI1/E1w/9uEO8Y/ANfPBS7Yo4R4SQs8JqYFQqvu7NZ3tPhLfLgHsnQOdTHLJF2G+PQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh5RZEAOpTSv1LkGuE0h4hMB1yDTk42x8SeFb4ZHImVoRLnU7O
	hv+3+iIMqAYosBZk89um5Z2b8FMLy4g3wJojky6GyxljrZ78cKmCjAVKSduXji4=
X-Gm-Gg: ASbGncv35Z0LQ3WWvrrPW0GSCJdonerPUjSDOP/JWoYsLkPnwfyqIJIzOWsQUkUZqnN
	8yHlW1CKuupfoHy1IIO15hQ9J3CM4X8r8yOj2GVLgZIA0qGkB/IFtY0ag0qkho+09CY5TKt/Nyg
	5VGAVVZBxBpVf2ErDz/0EMSQIhI+XwjGmMNfPcJN8WtkRch2UEIrqawX1koegvi0VLnMMhCSaj2
	H9lpOtKXPUTVozJi+LKY7UhzDUUzf39fXV4oOA7ikuAW6kN0AkZStkX3oYOLxZhlM1uP3/HcqjU
	vjckMSpxr59FqUpDuKFGzZJ0lpgaJQ==
X-Google-Smtp-Source: AGHT+IFRjL/KhmDcGC8MucpwxgwNr0ZNRoGoJL7sxAYkJFIl0HN1ssgHjTDj9GY1umPdAlN+l8LS0A==
X-Received: by 2002:a05:6512:2252:b0:53d:d3ff:77f6 with SMTP id 2adb3069b0e04-53e12a22f22mr5085713e87.46.1733353163247;
        Wed, 04 Dec 2024 14:59:23 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e22947a16sm29976e87.33.2024.12.04.14.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 14:59:21 -0800 (PST)
Date: Thu, 5 Dec 2024 00:59:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: qcs6490-rb3gen: add and enable
 BT node
Message-ID: <pzkijkdswskaq6232uldapz3b6v6zplif7uah24iwq3ymlezft@skbcy2vod3c5>
References: <20241204131706.20791-1-quic_janathot@quicinc.com>
 <20241204131706.20791-3-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204131706.20791-3-quic_janathot@quicinc.com>

On Wed, Dec 04, 2024 at 06:47:04PM +0530, Janaki Ramaiah Thota wrote:
> Add a node for the PMU module of the WCN6750 present on the
> qcs6490-rb3gen board and assign its power outputs to the Bluetooth
> module.
> 
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 165 ++++++++++++++++++-
>  1 file changed, 164 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 27695bd54220..07650648214e 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: BSD-3-Clause
>  /*
> - * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  /dts-v1/;
> @@ -33,6 +33,7 @@
>  
>  	aliases {
>  		serial0 = &uart5;
> +		serial1 = &uart7;
>  	};
>  
>  	chosen {
> @@ -217,6 +218,63 @@
>  		regulator-min-microvolt = <3700000>;
>  		regulator-max-microvolt = <3700000>;
>  	};
> +
> +	wcn6750-pmu {
> +		compatible = "qcom,wcn6750-pmu";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_en>;
> +		vddaon-supply = <&vreg_s7b_0p972>;
> +		vddasd-supply = <&vreg_l11c_2p8>;
> +		vddpmu-supply = <&vreg_s7b_0p972>;
> +		vddrfa0p8-supply = <&vreg_s7b_0p972>;
> +		vddrfa1p2-supply = <&vreg_s8b_1p272>;
> +		vddrfa1p7-supply = <&vreg_s1b_1p872>;
> +		vddrfa2p2-supply = <&vreg_s1c_2p19>;
> +
> +		bt-enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;

Doesn't WCN6750 also have SW_CTRL and wifi-enable pins?

> +

-- 
With best wishes
Dmitry

