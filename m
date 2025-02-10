Return-Path: <linux-pm+bounces-21668-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A5FA2E9F5
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 11:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CEB816633B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 10:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80521CD1FD;
	Mon, 10 Feb 2025 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pHqPS8R+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB213192D7E
	for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2025 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739184644; cv=none; b=ctgPOHAETq+d+jh/XhIOcfg3Ib1AN4/Gid2W6M0QIJPGU9VPTD5KAF3bXDzslmAvff/2CAi+jJV516jhb9NFlVnyuV8H+rSO5G6W59t9fbiqiYIOl93MGmUWNjMzbS3uH9Hlm9/CaBiT9LG2EGrlYBJ4jHLbXJtb/hK9macykZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739184644; c=relaxed/simple;
	bh=ICUmdBt8XRJXVFbrpD7aAUnbaAPGI4U1gNjK3X4TlX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkbQ1EA4FxBaVlH8pAhgZLvrAjaY5daZuBgEO4L5V+J4WZvGLJYet7uRXAVNWp2QBdPTbBEkPLJDhxBl+mR4xBqXVuUUBcOgC7jBksoz8MgvKLtkMPxyHZ5vzt22oJTmkRKblt6jKBnt8VpT9gIU0aAkWSXeQfhdF8TrFkSfkho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pHqPS8R+; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30613802a59so43314811fa.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2025 02:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739184641; x=1739789441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hvFzwRKL6EFJPM/4hbqGptZn0OaUv9Jm6JVL6aPi71Y=;
        b=pHqPS8R+DmsEH1+IaoRj/9tOVl45iy5Dmm2A8gU5UJojGzGElHkLQi1q37RV1TcIvu
         qaVXCuNMLOQkM85+Z6Hs+jUrup20kJbppdwCMvreBNQGdhYiz3t3se5FgM1wOCrgvpz1
         G4+GwK+AHHHzt5FM+4/aPMxCBEyygVDi7eaCVw+lLraVn6c+qbFATLaW1DWO4NqGJ8pu
         2d48amIhphVWmbCXKqRPoZEeuDvqW7/bOisSgZy7WY+XX/CGB9EryjH5H2hDqnAuuE/M
         /REvbyY1ecr2SDfqeJ2NIvkOZQ9D8D3pxuoxD85K+nHL9JWkSzg1xer7F5hg16bIXoaM
         ObLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739184641; x=1739789441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvFzwRKL6EFJPM/4hbqGptZn0OaUv9Jm6JVL6aPi71Y=;
        b=VniOe8h4TTgxQVFwFwteDI5KFG5ejnvqqv+/Grnn85sJZdHdrdxR/Ezt0OIzSNgrR7
         NnxeAclfz57IhK2NdqgRHw9k3a9nVbiBILBgRD4W/DPH2o6+AVTEucUVRBz9PSgnaYE8
         KbqSPCj/D1Mt+jVAxdhU6+rHWCv05Ye7RMRS0iif4a53pzjXJo0zb47pXc268yLejSA5
         O6g9J8MeXIp91YCx+42N2pmc6GW3LlxN53j/emJVIe59WxejsGkIE8cDOR2mQnYQ+dk3
         bsDXITTQnIvdOP3qJRr2TXzZReuKpYxz0JtnwBEAoISJKHFyd9yiBcvfhpi80Zim+DRz
         4LEg==
X-Forwarded-Encrypted: i=1; AJvYcCUOQLI692tcFq/rH8r0bLaLms4ybXCfI12PrIX0DenxC4IAmSVR6DThF6Srjz3fG+MLC6uzcpFKTA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxye4lTp+EXOvaWM2No8iitTtqLu7ACnVxMA/vikoDHwpln6YBY
	kduiGpgQtQKZjtA2p5U71coG8kwwLKKP+0nqWMRh15gGOEcgFksBDfnqiEyO3bQ=
X-Gm-Gg: ASbGncuKoRItX29442Twvz5eB1lNbhXrrLjJXhzTSC6YdFlmGnZfcVjDt6Kkn/FUYkT
	k7FspOFn7wMpQrygwtrPxBOGI2MFvm89ajMCaK/EBW99cOHdtO9izBLymTywUlD2l6B3UV64Nq7
	2yTrC70wFFqQ3FYxDAb63SSB+UjcsKk5q0J3RIiTvmYln80FayQIBwO4NuFleAa+YTp3kdUyWT7
	ogube1nY4iwMwuhWPgSqjWiL4W/PGzxxJIUqePfxwIzC7CRjDqGqUmxU+iQvpyOcEZv9sFeH1XN
	JEWdfVJcu6ClSLZ2Ml2fxtF2EN3C7wMlwYdPoalkm95dMyIRjikicyabp7SjO85rBHbXOrU=
X-Google-Smtp-Source: AGHT+IE0t33F67YCixyaHQxIxAgdVJ1K3UHAFFUTrLatNRBrJe1hONkFkblGv5KgnVrurTiuJQHrfQ==
X-Received: by 2002:a2e:ab08:0:b0:301:12:1ef3 with SMTP id 38308e7fff4ca-307e57bc4b0mr44406991fa.4.1739184640660;
        Mon, 10 Feb 2025 02:50:40 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de2bb126sm12560731fa.72.2025.02.10.02.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 02:50:39 -0800 (PST)
Date: Mon, 10 Feb 2025 12:50:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Odelu Kukatla <quic_okukatla@quicinc.com>, Mike Tipton <quic_mdtipton@quicinc.com>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 2/7] interconnect: core: Add dynamic id allocation
 support
Message-ID: <bwiuhfgv4jw7tlwjqffgrxvskxbpf4forz46nn5g3vihz3z5od@w25y7hdprykf>
References: <20250205182743.915-1-quic_rlaggysh@quicinc.com>
 <20250205182743.915-3-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205182743.915-3-quic_rlaggysh@quicinc.com>

On Wed, Feb 05, 2025 at 06:27:38PM +0000, Raviteja Laggyshetty wrote:
> The current interconnect framework relies on static IDs for node
> creation and registration, which limits topologies with multiple
> instances of the same interconnect provider. To address this, update
> the interconnect framework APIs icc_node_create() and icc_link_create()
> APIs to dynamically allocate IDs for interconnect nodes during creation.
> This change removes the dependency on static IDs, allowing multiple
> instances of the same hardware, such as EPSS L3.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  drivers/interconnect/core.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 9d5404a07e8a..40700246f1b6 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -20,6 +20,8 @@
>  
>  #include "internal.h"
>  
> +#define ICC_DYN_ID_START 10000
> +
>  #define CREATE_TRACE_POINTS
>  #include "trace.h"
>  
> @@ -826,7 +828,12 @@ static struct icc_node *icc_node_create_nolock(int id)
>  	if (!node)
>  		return ERR_PTR(-ENOMEM);
>  
> -	id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
> +	/* negative id indicates dynamic id allocation */
> +	if (id < 0)

Nit: I think it might be better to add an explicit define for that and
to decline all other negatdive values. Please leave us some room for
future expansion.

> +		id = idr_alloc(&icc_idr, node, ICC_DYN_ID_START, 0, GFP_KERNEL);
> +	else
> +		id = idr_alloc(&icc_idr, node, id, id + 1, GFP_KERNEL);
> +
>  	if (id < 0) {
>  		WARN(1, "%s: couldn't get idr\n", __func__);
>  		kfree(node);
> @@ -962,6 +969,10 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
>  	node->avg_bw = node->init_avg;
>  	node->peak_bw = node->init_peak;
>  
> +	if (node->id >= ICC_DYN_ID_START)
> +		node->name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
> +					    node->name, dev_name(provider->dev));
> +
>  	if (node->avg_bw || node->peak_bw) {
>  		if (provider->pre_aggregate)
>  			provider->pre_aggregate(node);
> -- 
> 2.39.2
> 

-- 
With best wishes
Dmitry

