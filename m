Return-Path: <linux-pm+bounces-9492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9760C90DB0A
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 19:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE94E1C21CC0
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 17:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E192314BF86;
	Tue, 18 Jun 2024 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZbjvGBi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEAD146013
	for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718733063; cv=none; b=UagpNV8y0WZQ0lTjVmmyhbHk/CdApLA/974FoVa3UkEpbYJEsyTYdGyzQhe9+wAXIViOvnz5KUpk4ss2N6ZiggCX/agJQ/v740p2NAWNXyKF0Q+KV1h2L3nlNfGb62N2qIsk72q07Zwh3XssbFVXFNszzxrDPIgvL4zRPVr53fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718733063; c=relaxed/simple;
	bh=d3mOZkwzhQUitJ9p5NHqTux2I2OqtKSPIYhdsh5PmW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sI+52p6wogMFbVfuiFf1+Ro4b894hAGDPSpOFSLPj9k3w4WifpNQHO6Ba4dgBJ/UXJD2p55A0LaxRpm4o7bP1PzP1mQWyjsWAloeSP1aC8UvsAIJaSDB1sA+FcFefycMrILcHpsmXV2Ad5vZ2zcJqsCduAYLIZcl/+tGAt8el+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UZbjvGBi; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52c7f7fdd24so7074310e87.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 10:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718733060; x=1719337860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jdrPsOFRH9tibJcIwTVDIHrvX0et09f9Ar+HQWRvLZQ=;
        b=UZbjvGBibP5eUYTkPaNxof/tkbNC8npO5YOvD3hQ4EtX1wH25FASo/SB13vTt+Rffx
         FvZTPnWMvGFaWZSF3ry5vXYjC8RLeF5SU0gqaNoM2MMlDHlXcVOpT22HMh4mUZgpjset
         gny+T5ZxSPjtbqBcELArMFbmZ4XICJl23MclKGrnMxm5xZptuKdYa+ovy+qi+yIQ4XiQ
         FP4TNqGI5IgNzGlPsYveXlh0A4fqIthbYniUNqLC7sDn5XBj0DBFX0rTNpQnz0IvwFAd
         3zPAwC/0kmTBHvsqH5zMEXCE49MrcAngFo4cqar0NuEPJU+a84CxoRcMIFrTXgksySPO
         44YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718733060; x=1719337860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdrPsOFRH9tibJcIwTVDIHrvX0et09f9Ar+HQWRvLZQ=;
        b=Gxt1zDx6F7Km5f3352U0BINVUXSSeHdwsnP2OUuTDokE7Qx5eOBu3HciMlJUWx6dLb
         4OvvTwrNTcLj3f4Tn8XtXsca1ytIF1DxH+HZgqQxFr8ED1vx96uNmZg8VoZ/W41t1LwZ
         EuJQ2dDYrI3yxWZR8dwi3NaG4Dy3AIYxktemIpU0mAFo9rDg+nwWvmcBxA/ACfslQYX4
         wmHNxYij+GvC9ruJhHksuwugxxss8RsXzZ1HOv/RIBIuksnZFDVgZo+Nhv7nIdQKiP66
         cjpxLN5IwhB1gGYfUPVJJDi6tVy9lKCWE+pUxkHh3NuDj14WlEInGi5whXa/lBmmlAPa
         CAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbxNkvm9RZs7AcmOGKG55zyek77BGa+mJ814rY9IT7KRns1F73GtAW87NRLOrn0Qfnsd1bbKFsnAc6/uhfAN3Kk0iOf81GcD4=
X-Gm-Message-State: AOJu0Yw1/QrDypoE8sSbd1mPdFnZVZrACb6qSzu9/oLj2aVRSuLalTPt
	H7WmGlxieIH5KnAVGfgchaj7V3V3qKLkGx9WT9eYjf/judoo1MeanR2P7ZcRdBM=
X-Google-Smtp-Source: AGHT+IGM/U45FeUpxxsmNAsTgVBSD3mO9NOKixFEiUXqhhF6IJuZRODRDq1PxwN+t2vV3hmMxogugA==
X-Received: by 2002:a2e:2416:0:b0:2ec:eee:f19e with SMTP id 38308e7fff4ca-2ec3cfe5a12mr3314651fa.37.1718733059948;
        Tue, 18 Jun 2024 10:50:59 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec3d00ae2bsm499111fa.51.2024.06.18.10.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 10:50:59 -0700 (PDT)
Date: Tue, 18 Jun 2024 20:50:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, phone-devel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3 02/23] gcc-sdm845: Add rates to the GP clocks
Message-ID: <wnf3mfgdm4p4f5wrxdtlx4wccnizdvohc7iiyu5t22eeb67r57@xun3r73hksrg>
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
 <20240618-starqltechn_integration_upstream-v3-2-e3f6662017ac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618-starqltechn_integration_upstream-v3-2-e3f6662017ac@gmail.com>

On Tue, Jun 18, 2024 at 04:59:36PM GMT, Dzmitry Sankouski wrote:
> sdm845 has "General Purpose" clocks that can be muxed to
> SoC pins.
> 
> Those clocks may be used as e.g. PWM sources for external peripherals.
> Add more frequencies to the table for those clocks so it's possible
> for arbitrary peripherals to make use of them.
> 
> See also: bf8bb8eaccf(clk: qcom: gcc-msm8916: Add rates to the GP clocks)

Each time I look at the table attached to the GP CLK, I feel that it's
plain wrong. In the end the GPCLK can in theory have arbitrary value
depending on the usecase.

Bjorn, Konrad, maybe we should add special clk_ops for GP CLK which
allow more flexibility than a default clk_rcg2_ops?

> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  drivers/clk/qcom/gcc-sdm845.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
> index ea4c3bf4fb9b..0efd3364e8f5 100644
> --- a/drivers/clk/qcom/gcc-sdm845.c
> +++ b/drivers/clk/qcom/gcc-sdm845.c
> @@ -283,7 +283,21 @@ static struct clk_rcg2 gcc_sdm670_cpuss_rbcpr_clk_src = {
>  	},
>  };
>  
> +/*
> + * This is a frequency table for "General Purpose" clocks.
> + * These clocks can be muxed to the SoC pins and may be used by
> + * external devices. They're often used as PWM source.
> + *
> + * See comment in gcc-mam8916.c at ftbl_gcc_gp1_3_clk.
> + */
>  static const struct freq_tbl ftbl_gcc_gp1_clk_src[] = {
> +	F(10000,   P_BI_TCXO,    16,  1, 120),
> +	F(20000,   P_BI_TCXO,    16,  1, 60),
> +	F(100000,  P_BI_TCXO,    16,  1,  12),
> +	F(500000,  P_GPLL0_OUT_EVEN, 12, 1, 100),
> +	F(1000000, P_GPLL0_OUT_EVEN, 12, 1, 50),
> +	F(2500000, P_GPLL0_OUT_EVEN, 12, 1, 10),
> +	F(5000000, P_GPLL0_OUT_EVEN, 12, 1, 5),
>  	F(19200000, P_BI_TCXO, 1, 0, 0),
>  	F(25000000, P_GPLL0_OUT_EVEN, 12, 0, 0),
>  	F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),
> 
> -- 
> 2.39.2
> 

-- 
With best wishes
Dmitry

