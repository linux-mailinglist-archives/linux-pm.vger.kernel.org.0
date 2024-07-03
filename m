Return-Path: <linux-pm+bounces-10533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2082925A89
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 13:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D451F211D8
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 11:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F89F177992;
	Wed,  3 Jul 2024 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ijZiOZfC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFF5174EF0
	for <linux-pm@vger.kernel.org>; Wed,  3 Jul 2024 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003761; cv=none; b=jJEfNTkgfq0HLYCHSWKZAFCeZQBnpp51Sf6ujEjvP3VR+ijsnmheAvpSRkkSYD75iSIrqUI57sJaEq1rcWR3+dvHkpEWRFhFXaoMmR7nu1GLAexCLnrTbCCphP/ewd2sXm9b8vZokkF9u0iTCi0oYdTMK1ggz363v7rtS+GNFhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003761; c=relaxed/simple;
	bh=Um6OFwuQl3zsxZvzVYkhOfVGwWQHGW4jkk7FyvSE948=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0mt4G2gUqryva37CYIq0+c346YOIERIJsy8+7u8KJcPju+FCDxwIktdOcdF+ZPzjQBMBAPxqsaU2FV8/rvT+xQnKm6c2FvcVa6xUag1bSeeE3uAwYedeXJs0INYtPfTh4x7jU5i8J7uSbcdLzFCboRcQ0PBDbu0KW+kixn7Wc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ijZiOZfC; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ec61eeed8eso64771011fa.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 03:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720003757; x=1720608557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+oCQluoC8qtSjLERarQGyWRmhWoDfPg38XOkq2Vkd4g=;
        b=ijZiOZfCGPVdZ2CLtf1HcXi37SBf7oI4NeFK8CGCxS6Ih943RHV+LjJ2Qol7WJw1WZ
         vVzeAgd0G1yV25k1ndYnWaAacs79K6hp6Z3WO4KuJwT2c0dtJaQoddj/2H+x8u7XlspC
         aGQi5i38FaeoXWxpeaZ5cDCGOzqapLbmxDl3eqdZQ86YfO2mqLQCSks7xsLTQeAjJofJ
         GBqNNjc5y7r3V+mQMaNS7f3+Ok2b/XFNM4uLv6A95UDfAq4P3tNwezAwYHX252R5AiVp
         IHCfARjkrY0ipMwgaUKEiSPYaN6D8Q1IIId+xrPv5na1phK1UGget9JzUbEXTFqvPsxH
         bTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720003757; x=1720608557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oCQluoC8qtSjLERarQGyWRmhWoDfPg38XOkq2Vkd4g=;
        b=wGrawHht1ETPVr6j4IRIBLnotnxcGAkYC9ohaOOaSNpt0TD8zX4RcrorKxrSz6VCdQ
         za6EsHe0d7qCQjEIsO+IO5CZI+Ae3YSb+gRwnsAHD6Eaqvcnfs7cVNNJuxM9MipmUjLS
         Id7gSjcij/LUG0oAvBYRAyGb7yF70cIh4hc/eM1VePb+U9MxWai+hMXD0tp7nyUuDxzs
         WkSppTsPS4LKgBvo6vXxITTKh6/NbUfr9q0Twgy7fsN4rg0YL0gdnSUFMwaOAqmMXMvJ
         UsY7wwZ7sJAVDf40Qny2N/AuSvaxXYKVlF6rSIl6jApr1c4srtdEsNZ6dmn+PhM/lgvr
         xaoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY6CRfTJp9dofGpTlGrUvUInVucdZXe5i1gkI+ohxRe4TBXDXiY0KvmXdul97J8euYqHnf5BnnNzUf6xTcZ1CHhok2qdae2Vc=
X-Gm-Message-State: AOJu0YxaEahxDuqIECJQLhMtGtnXHQgB9d86tXjH7VjuPQo2XYuWsKuY
	i33/7mAZrjTOlXjw5JyoQgZKOfXZN8XUXhb3WbDG8l+lt3rfOZ4JCdSubDTa5uM=
X-Google-Smtp-Source: AGHT+IE8qUOiSOeMa1No93ZElWBx36fUbt9QiwfSUKevXmpoGLYCbyM0z6/scs7glRtZMd/DqTqN6A==
X-Received: by 2002:a05:651c:b23:b0:2ec:5fa1:2434 with SMTP id 38308e7fff4ca-2ee5e33a9e5mr76322521fa.9.1720003757433;
        Wed, 03 Jul 2024 03:49:17 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee53c1718asm18435541fa.42.2024.07.03.03.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:49:17 -0700 (PDT)
Date: Wed, 3 Jul 2024 13:49:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, angelogioacchino.delregno@collabora.com, 
	andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com, 
	ilia.lin@kernel.org, rafael@kernel.org, ulf.hansson@linaro.org, 
	quic_sibis@quicinc.com, quic_rjendra@quicinc.com, quic_rohiagar@quicinc.com, 
	abel.vesa@linaro.org, otto.pflueger@abscue.de, danila@jiaxyga.com, 
	quic_ipkumar@quicinc.com, luca@z3ntu.xyz, stephan.gerhold@kernkonzept.com, nks@flawful.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 08/10] soc: qcom: cpr3: Add IPQ9574 definitions
Message-ID: <sk66oje4p4yzh5hfk7pqihr72rap3vpidgdxzhje57uu47sjpf@z72v46onyiwf>
References: <20240703091651.2820236-1-quic_varada@quicinc.com>
 <20240703091651.2820236-9-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703091651.2820236-9-quic_varada@quicinc.com>

On Wed, Jul 03, 2024 at 02:46:49PM GMT, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> * Add thread, scaling factor, CPR descriptor defines to enable
>   CPR on IPQ9574.
> 
> * Skip 'acc' usage since IPQ9574 does not have acc
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v4: s/silver//, s/cprh/cpr4/
>     Skip 'acc' related code as IPQ9574 does not have acc
> 
> v3: Fix patch author
>     Included below information in cover letter
> v2: Fix Signed-off-by order
> Depends:
> 	[1] https://lore.kernel.org/lkml/20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org/T/
> 	[2] https://github.com/quic-varada/cpr/commits/konrad/
> ---
>  drivers/pmdomain/qcom/cpr3.c | 143 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 141 insertions(+), 2 deletions(-)
> 



> @@ -2703,7 +2840,8 @@ static int cpr_probe(struct platform_device *pdev)
>  
>  	mutex_init(&drv->lock);
>  
> -	if (desc->cpr_type < CTRL_TYPE_CPRH) {
> +	if (desc->cpr_type < CTRL_TYPE_CPRH &&
> +	    !of_device_is_compatible(dev->of_node, "qcom,ipq9574-cpr4")) {

No. Check for ->acc_desc instead.

>  		np = of_parse_phandle(dev->of_node, "qcom,acc", 0);
>  		if (!np)
>  			return -ENODEV;
> @@ -2828,6 +2966,7 @@ static void cpr_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id cpr3_match_table[] = {
> +	{ .compatible = "qcom,ipq9574-cpr4", .data = &ipq9574_cpr_acc_desc },
>  	{ .compatible = "qcom,msm8998-cprh", .data = &msm8998_cpr_acc_desc },
>  	{ .compatible = "qcom,sdm630-cprh", .data = &sdm630_cpr_acc_desc },
>  	{ }
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

