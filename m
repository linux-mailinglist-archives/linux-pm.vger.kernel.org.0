Return-Path: <linux-pm+bounces-11290-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B123938B1C
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 10:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2957B1C2105C
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 08:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D5C1662FA;
	Mon, 22 Jul 2024 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMVgYA/S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEDA5464A
	for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2024 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721636678; cv=none; b=a9kbkhp4TTeif5UADy0WlPTNOjno1Eu5xUCsvRAkqRZMQrV+WWMOwkQngPzP2GgAZVmdUV3wVFO9KAq7RZxM0MJIulhgcdhMWc4tAJ5p50jsXq49vqNCcE+4NHZqzNegwY88RrFk0TwQnqHwcYQheDjqXkJ9xw3uB4Y0MYqSGyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721636678; c=relaxed/simple;
	bh=dOl0YE5EVmUekTPh1z3GkHps3RoYLWAbv+veTel0xyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf+mhMy9uU1n15TfWTLXg74OEFzCliRUPnYl6x2uMo1+kUDDMy/HU2RED8f1Ig47OnPwGpS0Gv9B/H9YUzlEK7CoKLsj/9uONi6DA2FMpShiP8TpXHM+JT6jwVAxj/+OdtJsMIEK2eHJZMNgMkzTBXVtH5lrXNCGWT7xSGgStQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZMVgYA/S; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efd855adbso1869021e87.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2024 01:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721636675; x=1722241475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgzE/IxCJWBRiP2I7PFm4ei8b0N+E/ct1yB02Kh58Sw=;
        b=ZMVgYA/SKaQC5f2j9DZjl3cx19EfHbzZoFFI2Dgf89FGpjjssAdU0d9jLpGo8X5EwI
         0D0hJpljANaOdVTKKpWxS7VY6NAFDjFGC3cYvu3NsHHag5Lc6V3xoeeRH6TZMxN/1J2j
         3XyqnoBObhm+T5X9G4rDZf4fLsbACtWP+aUaN1to13U/wfMx/eoiUGyHQjBHQT19z25o
         vXQHLD3tXrnGrOxhlC2uvGv3SEUgJiluoUT56KGQGxgHjRPx9y1ZShmDLpuNXbw7xc5x
         EtjUEBOsZUanuusKaJIORj8nBzHtFlcWR2YMROUs+ivLpCodFkpgry/akJ8XcPJMyuU2
         3rDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721636675; x=1722241475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgzE/IxCJWBRiP2I7PFm4ei8b0N+E/ct1yB02Kh58Sw=;
        b=NRucVR2+4hCQN+T5F5/URLUNG78ru/Lk2Q4t8NoOezqQBu/LjZZFF9UW1Dvo/DJbOO
         eYi4drZ9HN6r5m8wHzBUHVOPVKVH5glCAmh8/Gq1HyejLCxaUpaxW7JTuL5sB/leabcl
         8XT0gFgC7p5tpqjX1WPT/XXJQiPhbYkofm4z1+VdtW/2CCdd43qFm6DuB7iUpZPkDYDj
         3MvrVQQCsKDUuaHKJa7KClU5CB19kBAGcgLCYEB2preoeUs3bLkk+oLZswlx3yQ+osbI
         LLo0BWcNcxm6/M2xxIUJz2wzp3ynmkAYDTl/WOPXdtWMLztSg86mZiuvIREs0UnMUfNz
         g/kw==
X-Forwarded-Encrypted: i=1; AJvYcCX/6gOIdgbsRniOYHxVHl0+CsmPrj5mcpj/tzpK9RNicktUWTNW00vOjzgyWrt/Z3C1JvvxvjiUP6nMT3X2oWJPFBzSeiV4/iY=
X-Gm-Message-State: AOJu0Yx9bEZ8TjKg5CY0AMwD1Y8VA1MdIjTSECHrIC6fIx9W++0Jhotd
	7u/3CzO4HrSInsnY0CqAgXPIVBMLup6eFlrKuu1DpRF8PKLHAXRDlrY5ySbDrsU=
X-Google-Smtp-Source: AGHT+IFrF/v3D/EbEYt4Vwr1M6wYuXzOKRe+7Qed7iAdA18QZ/SGcjYDjEKN1Yi8ZAK82iRriZoPWw==
X-Received: by 2002:a05:6512:a86:b0:52c:b008:3db8 with SMTP id 2adb3069b0e04-52efb77a765mr3360812e87.38.1721636675345;
        Mon, 22 Jul 2024 01:24:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef5571de0sm1114612e87.202.2024.07.22.01.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 01:24:34 -0700 (PDT)
Date: Mon, 22 Jul 2024 11:24:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	gregkh@linuxfoundation.org, konrad.dybcio@linaro.org, djakov@kernel.org, 
	quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/5] clk: qcom: ipq5332: Register
 gcc_qdss_tsctr_clk_src
Message-ID: <bgu4ii2lumk2afgendf2hrcj57gavqd7k3essblcqnhue2auy3@bkmfy4zjv3xs>
References: <20240722055539.2594434-1-quic_varada@quicinc.com>
 <20240722055539.2594434-4-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722055539.2594434-4-quic_varada@quicinc.com>

On Mon, Jul 22, 2024 at 11:25:37AM GMT, Varadarajan Narayanan wrote:
> gcc_qdss_tsctr_clk_src (enabled in the boot loaders and dependent
> on gpll4_main) was not registered as one of the ipq5332 clocks.
> Hence clk_disable_unused() disabled 'gpll4_main' assuming there
> were no consumers for 'gpll4_main' resulting in system freeze or
> reboots.
> 
> After registering gcc_qdss_tsctr_clk_src, CLK_IGNORE_UNUSED can
> be removed from gpll4_main.

Commented below.

> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Fixes?

> ---
>  drivers/clk/qcom/gcc-ipq5332.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
> index f98591148a97..237b6a766179 100644
> --- a/drivers/clk/qcom/gcc-ipq5332.c
> +++ b/drivers/clk/qcom/gcc-ipq5332.c
> @@ -126,17 +126,6 @@ static struct clk_alpha_pll gpll4_main = {
>  			.parent_data = &gcc_parent_data_xo,
>  			.num_parents = 1,
>  			.ops = &clk_alpha_pll_stromer_ops,
> -			/*
> -			 * There are no consumers for this GPLL in kernel yet,
> -			 * (will be added soon), so the clock framework
> -			 * disables this source. But some of the clocks
> -			 * initialized by boot loaders uses this source. So we
> -			 * need to keep this clock ON. Add the
> -			 * CLK_IGNORE_UNUSED flag so the clock will not be
> -			 * disabled. Once the consumer in kernel is added, we
> -			 * can get rid of this flag.
> -			 */
> -			.flags = CLK_IGNORE_UNUSED,

You can't drop it in this patch, since GPLL4 still can get disabled if
GCC_QDSS_TSCTR_CLK_SRC gets disabled. This chunk should go to the next
patch (or you should reorder the patches).

>  		},
>  	},
>  };
> @@ -3388,6 +3377,7 @@ static struct clk_regmap *gcc_ipq5332_clocks[] = {
>  	[GCC_QDSS_DAP_DIV_CLK_SRC] = &gcc_qdss_dap_div_clk_src.clkr,
>  	[GCC_QDSS_ETR_USB_CLK] = &gcc_qdss_etr_usb_clk.clkr,
>  	[GCC_QDSS_EUD_AT_CLK] = &gcc_qdss_eud_at_clk.clkr,
> +	[GCC_QDSS_TSCTR_CLK_SRC] = &gcc_qdss_tsctr_clk_src.clkr,
>  	[GCC_QPIC_AHB_CLK] = &gcc_qpic_ahb_clk.clkr,
>  	[GCC_QPIC_CLK] = &gcc_qpic_clk.clkr,
>  	[GCC_QPIC_IO_MACRO_CLK] = &gcc_qpic_io_macro_clk.clkr,
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

