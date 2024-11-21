Return-Path: <linux-pm+bounces-17931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B2D9D5518
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 23:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A391F211DF
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 22:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC51B1DA103;
	Thu, 21 Nov 2024 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WqGHjc7W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36961CB512
	for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732226477; cv=none; b=HG3KibASV0oE/mP3rnI0GytAGbAAJ2skcu3Zc8t9SQZgorBguI7Dpk7Jr43bp/MdXc9kjX7nAbl45qtW7LMbxsZc6mgikO5rOtw0AAILzSPxx2qEdqLrWqihAI6o8ikyaXRqvpEqH9KbKK8T14gUR9e4fcwZAN2NHk+XeY98Gbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732226477; c=relaxed/simple;
	bh=oULDhTY9NKL7RUXhTGGxFaIwXHvE7IZ1UIswvh8QlU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwa7eFlRyKDTXzWhpoSCcVr1mO+LU+4oZV5Zfxf/RwMyr4t0poYAZrWV1K/NmffKRg/OPZgdv5zeA7Nn9cMJTK4da/zhYp3eaY+8fdjzSqyzWKZW88UU+EXwuUliRuDulLvf4DmhgyBujfvi+wDA7n5gJixsMKzkQsuOnoSDFBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WqGHjc7W; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ff99b5ede4so13675491fa.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2024 14:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732226474; x=1732831274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PypIErFyD/n0BNOpM458f7rPV3XZUhIzNxg2aBsXTpI=;
        b=WqGHjc7WJA77kBg4oS3H44MbbnPwmVQYq83522AaVel/GYU2VOp5kvlpquzNZyVYYP
         JxKXiEegpEcxst2sFX6DyIZ0RGUtJCdIuHBkuoaCe9xD54HtTqzZ5UKPfgXyKKz0ungC
         28MB94MY301/ZWVu3X7NhXDR4lwdTxJ2onSyS6whYP991AvlksYQn7clqahyXx+wwMZz
         CdskYLm0CCreKMEHhNTswwwfbhpKe6qowlDriWHKeMnFnkhw4F6ApmPr23ZWIT0lDuu5
         +Kr4PALqB9ah1gJUNwU/Id9FW7o5R511CJSKddva0735/Y68D5NGf4LN4nhxWN/xS106
         CCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732226474; x=1732831274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PypIErFyD/n0BNOpM458f7rPV3XZUhIzNxg2aBsXTpI=;
        b=pHY34NOz40ODJDV/1UeglSZvjHItGaoNzim5fJSovUlREy5RNJ2810aV6iJ6eNbJMG
         W8pb2xj0SECkOhySyqd4z9QBr16xg1+X4pCiUrWFOMqsjgpeg1mzKNVFQiNZEtmnXCFH
         Hb7z2wGMH8MnpQOVOxUJNwWLeJ/L6ui/pq9pDEAcqyLu/nJxt5M6/jWeWpyS3Rvx5jKi
         miyBD0AFOgZaUJB3f0X9nol546MFHdYAQNyCxOTj3ni20XnYZBpN4yi/6xTUzEOjaYnI
         7Gd1SCLfBugnPpatsdtsu+kt89o6cKisvSQ17CckCPzXnll1VB9s6lSN09Yw4fDIg77S
         yTwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVTKu2kDS9cPA+oVW3qWjIu/QA2QB3xmpRZPkHk5nmMkywYe71n7FgIVT28OZ/iJ/YENKK6mGK6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQgrn1IHdHjr5WDxW8teQFzd9RUgGQpGOgb2rLiIhAdBERY6Jj
	MihQ5eeQVSLfXhQSY0Nw0C8Vcq73GsRRm0VMP4QrKIUUf8nwbrFEKRzFBD9SkRQ=
X-Gm-Gg: ASbGncvJRGttBiKzH5RJVaIkMofOuPlLg5xetO5V82VsdlJKuVJ3cvIa8chmR0dGp6J
	HAZ/imcgnx09YFHF/ubH3oeA8X8U4oikIaPGWVzlX9tLM1+pADASVC3+ml/GE8/EoPk5+7812nv
	qdHrn6/tlm+YyY9yqf+Vf9d59q/tk/ZyTK6psdIUk5UAS0SCLq7NFk23kNPJ1CanJxuDT/frmJG
	NNO/33HlFwkdnKuPQ4meJ3c+0T9Iz3Jvhbl3Zxu56lVOqdZph1xgNGf/YqReGax37m2ClrVKKYm
	OzVsIBHpbNTl0dZ3pT0tyfqhW3g+2A==
X-Google-Smtp-Source: AGHT+IFFL2q/vIMRHr/WtuLEdj4EJHjWtGPHoUZcmjYRAKu5VLoo+jdnHtTWOwZ8S+bh83TLTJUqqQ==
X-Received: by 2002:a05:6512:2382:b0:53d:a8d3:aeca with SMTP id 2adb3069b0e04-53dd36ad5e2mr186652e87.28.1732226474029;
        Thu, 21 Nov 2024 14:01:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2499fccsm89849e87.270.2024.11.21.14.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:01:12 -0800 (PST)
Date: Fri, 22 Nov 2024 00:01:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Odelu Kukatla <quic_okukatla@quicinc.com>, Mike Tipton <quic_mdtipton@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: qcom: drop QPIC_CORE IDs
Message-ID: <fuplqyfqvfc6foi4tdsts53kvdokfzprxwxedgi6hyxicedvvk@3rrx67vihbex>
References: <20241121172737.255-1-quic_rlaggysh@quicinc.com>
 <20241121172737.255-2-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121172737.255-2-quic_rlaggysh@quicinc.com>

On Thu, Nov 21, 2024 at 05:27:36PM +0000, Raviteja Laggyshetty wrote:
> QPIC resources are modeled as clks, therefore remove corresponding
> defines from the binding as they're unused.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  include/dt-bindings/interconnect/qcom,sdx75.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/dt-bindings/interconnect/qcom,sdx75.h b/include/dt-bindings/interconnect/qcom,sdx75.h
> index e903f5f3dd8f..0746f1704ec0 100644
> --- a/include/dt-bindings/interconnect/qcom,sdx75.h
> +++ b/include/dt-bindings/interconnect/qcom,sdx75.h
> @@ -6,10 +6,8 @@
>  #ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SDX75_H
>  #define __DT_BINDINGS_INTERCONNECT_QCOM_SDX75_H
>  
> -#define MASTER_QPIC_CORE		0
> -#define MASTER_QUP_CORE_0		1
> -#define SLAVE_QPIC_CORE			2
> -#define SLAVE_QUP_CORE_0		3
> +#define MASTER_QUP_CORE_0		0
> +#define SLAVE_QUP_CORE_0		1

This changes the ABI of the driver. If this intended, please provide a
reason for that. Otherwise you can not change the values for the
existing defines.

>  
>  #define MASTER_LLCC			0
>  #define SLAVE_EBI1			1
> -- 
> 2.39.2
> 

-- 
With best wishes
Dmitry

