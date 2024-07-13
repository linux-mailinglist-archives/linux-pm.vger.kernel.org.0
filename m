Return-Path: <linux-pm+bounces-11071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 957A7930650
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jul 2024 18:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40AAF1F21CE3
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jul 2024 16:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE9713C3E4;
	Sat, 13 Jul 2024 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCaz9GhD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D4813B284
	for <linux-pm@vger.kernel.org>; Sat, 13 Jul 2024 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720887268; cv=none; b=Uisa/Zt2GRM0oMY26l3/3W9dhfrUYoDDleHKixz9xE6uu8Ko9sqMy5+qRDrWZq8b5UGcasMhvSDFGXWIpAa/NA7/Gc+t0dggSnjZliCqj+koD/KKx0WQsi/6Nu8XFAytkUBs9uZLNhuVHijAra7EVIlgPL8EjW7nhgAee17303c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720887268; c=relaxed/simple;
	bh=fsTC3Y8qqZHuiQ0bomRHIfTz22wOi1LskNdGbeB8kxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWxTtZx/hHaglZ1/LVsOx1f24lsUTqLD2rq7z+0ny9eF0MfrPIZsTukAjxT2TWrQZTTmOBQuf5is0zGVsF6bWZl3EkcG0j+s4upB0v8rAJ4FZuhaY0wfyrTHk+PyQbeoedZCIdns6CNfiHo7jehHkLtrOe5xTiDU6P0ErtG4pPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qCaz9GhD; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52eafec1e84so4099549e87.0
        for <linux-pm@vger.kernel.org>; Sat, 13 Jul 2024 09:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720887264; x=1721492064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A4ePwRcqLmC0XiHDmEJlnc7fWaWhmNItvxGSWyxvpXc=;
        b=qCaz9GhD4+b1PnJ6feLU4L8POPPeNpIRmOEz6gQSWo2AM/lyX9ePdoHvm/4NYQl/Sc
         3Oco+1dQLtHlZNeStTtODvxnstYr+HyDej4J/urnpaLx865Sh2GD3rfaKujfoUKtu+A1
         GVNTh+nIJcrA822+bE+XWaRbrco6RTIH0x1HQMSGOJ4xGZu13TFxKZ+2AZbfdgqiYWtq
         JGuyFkApzgoe02fHaORlDyrwek3GbrjR6qEUmC14u5pvd6ya7+ygfPBfWCU8OWCmQeV0
         CFBOdroe7W1zrXZ+NbW+WN4d8e2QrntynwXnyBEDCvOU/dPghBD6z6o8LWs+bsKcM7vW
         GdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720887264; x=1721492064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4ePwRcqLmC0XiHDmEJlnc7fWaWhmNItvxGSWyxvpXc=;
        b=W/GFmAUV0i2BoL8A/F6yU4yUmmhjgscR7OnmLM1vWk3fwpuBN/A/bIUN5QFhJoHkum
         cWvZzyzi41OlixRrwPZJ/gbjiVQ4yxQOgTf98d1iYY4GtnQ8WuMPAvBiRLNDbDj8bxma
         rb5eaB3Sz8nVUSciEQk/YcGkT/WaOPEUamahsKRmDCGRRW4H4AtIq8dEgK3zYCVVJlu0
         14RZgGJJQpQVGP1FfM84b3xdgxmQB9+1kS4FTH+k7ipowyvs/eh7CRQ50OmG5HHVLCRy
         iCSviqS2LuhxFejkouSdotC02m3dCNKrnnhzskxWUIJTQIa5v8QxImnFxSHqrUTYlhwd
         hOuw==
X-Forwarded-Encrypted: i=1; AJvYcCUn45pnYsY1jJqfUzojZhJuQ9P5qXudcVwKnunzgEQ2b8qFF5bzNB0oNx4gXMRqzDox0EkbOGXYB7vR7aRfoL47yFXxLVl9rxw=
X-Gm-Message-State: AOJu0YyxXG2tbE6g5S0Blg87ADnCPIrBzJUGMihPj5TBrb9blmV8AUJd
	cuRN0hVsIH1gBN9o5dj/XVCLcVl/QuyTmhGal1a37zY2o235muL66hDHMqbYsfQ=
X-Google-Smtp-Source: AGHT+IGeY8TQkgpmxoX4S+CP7z8jlYSZjcZOwh5zHLaL1082ORYhOHlTL0iy1ceyOWWGw9YkGYtBZQ==
X-Received: by 2002:a05:6512:281d:b0:52c:80f6:d384 with SMTP id 2adb3069b0e04-52eb9990d0emr10796860e87.3.1720887264053;
        Sat, 13 Jul 2024 09:14:24 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed24f424asm230606e87.115.2024.07.13.09.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 09:14:23 -0700 (PDT)
Date: Sat, 13 Jul 2024 19:14:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Kamal Wadhwa <quic_kamalw@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Jishnu Prakash <quic_jprakash@quicinc.com>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	Ajit Pandey <quic_ajipan@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: Re: [PATCH 2/5] dt-bindings: thermal: qcom: Add MBG thermal monitor
 bindings
Message-ID: <haqojsbi3ain6rvht5a3ytcmjwq64tswgrpj2azqrztrvlcvag@3u476p7t57dx>
References: <20240712-mbg-tm-support-v1-0-7d78bec920ca@quicinc.com>
 <20240712-mbg-tm-support-v1-2-7d78bec920ca@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712-mbg-tm-support-v1-2-7d78bec920ca@quicinc.com>

On Fri, Jul 12, 2024 at 06:13:29PM GMT, Satya Priya Kakitapalli wrote:
> Add bindings support for the MBG Temp alarm peripheral found on
> pm8775 pmics.
> 
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  .../bindings/thermal/qcom-spmi-mbg-tm.yaml         | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml
> new file mode 100644
> index 000000000000..9b6d1bc34a11
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/qcom-spmi-mbg-tm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. SPMI PMIC MBG Thermal Monitoring
> +
> +maintainers:
> +  - Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> +
> +description: |
> +  Qualcomm's thermal driver for the MBG thermal monitoring device.

I was hoping for the binding to tell me, what is MBG. But they don't.
Could you please fix that?

> +
> +properties:
> +  compatible:
> +    const: qcom,spmi-mbg-tm

-- 
With best wishes
Dmitry

