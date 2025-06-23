Return-Path: <linux-pm+bounces-29256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2C6AE366D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 09:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2B53AC152
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 07:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2041EFFB2;
	Mon, 23 Jun 2025 07:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U5V39glY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DA41487C3
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750662047; cv=none; b=b3GGZpki7BRs6VvEygPKKs94+gs8tuHt/G/ylYJ57l63TNsKMlQbtpOZXnG2+33Le+6iwkwRg6JXIyvNiL9U7Etcl58dF7DOf6faCCvOap8Q5ZrWsXkXo1Ym2PvAQdp8JYCCU4c2DEsndYHn3lFUcWhdTB3V3MK2aT96isUusB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750662047; c=relaxed/simple;
	bh=fkTxCHWLdcqIaJ40UUfakQLAPsDE0f9aTf0SAjS7K8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHfQ9F887MVSmE6r4Zyh3zYmejgFtWNMso9plsmNuysGjrV5i0WAP/zgcVP0uGcl5XRTdoFfNeQ1S5t5WvY+pndXYTShd9mgZe0NZvKsiyliPGcEDPtIE2rkC/p4Y/qYTTPANWJ9LdS4EExDwwE8jMchJeVa7c5V9n2Kr7mtj5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U5V39glY; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74264d1832eso4854896b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 00:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750662045; x=1751266845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r1kWOkDs7l6DKIrvxwugdor4k3RUV9HV/EqTyaUExsc=;
        b=U5V39glYuZvXxL3VttRKjvPcWtpHvljpMylgNK+IAc9vfYOppbi8vo1ELcshjQwDUt
         HAcfD83xmrAAEmnDs3SAstXlnspZmhbb7wxkjGb+J9N2MB0O9tZIW9+WE+PtcaGg64Sm
         t5mewOuU1B/o5TZTX68RD30Bj2/yZv+LJ6PxMPJwPNcDMj3hvDohGpYWBRFxzzrW5vhC
         O4iWuGFrSxr1KO9rCn4I9d1r8+zFSp3ae6pnzJjHRFTXvFyrxQ30FIfniGQ/xYpvDbMh
         vii0iIewo9gewU/+VLFwDolR8RvBkVMvQs7tdsyIiQh05/L/bYliX4hLzTGVTch+7F4t
         hUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750662045; x=1751266845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1kWOkDs7l6DKIrvxwugdor4k3RUV9HV/EqTyaUExsc=;
        b=YqbspMac8s3BTYp6Pg5It58t415gA+WlT0t4xLKDg931Z+wmTOmpjT/+cMk6osLWmZ
         cb26gNRmiqPx1kH400J8WPAoSXxMO1hCfhfwXSW/lrXVn8Y4/BTJ8eoy/pYuo1Ln7LlL
         zkVeYBodQ0B/qMASfOaYCUtT3a21dVn9GvPZcUjH5SaW9skCXqoVQ7LNsHIiK519mb55
         wGTvm6AZm9yLT+vgmLFMRFxyWAl+2kQGKaILzi7FTtZzwge34eflah3bNNhcCXr43d94
         hmobNGxH6oVW5RZVlye2aXd0PGnZdsMcidnnE0SZfUwTqmnpHPK8YNDOaVLVPOJxlSn7
         ywnA==
X-Forwarded-Encrypted: i=1; AJvYcCULYs/3UoH4XdRH1fWoJON4PU7kCPPA+qeaCX2XUyX+BB875NS9pRsxLDJ3yW4xG+6irgARJAdJNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFRWys0PFoSL4wxfAx5CdRedwl4fg8XKLiUQ8wwNz3JIPqaz74
	2eITKGyi85WgY/aU/zXkM5rjElmuc+Zo/BAMu/Fi9Z9CmJ449G80jvYlVsQ1K2Y8rUQ=
X-Gm-Gg: ASbGnctYfLx8ci45RW4q0vKCcE/zLl33OYjsHqrwU4P50ioUpMSNNqx8u8rHqL9jfAS
	M8DLAWDPBRccomniftuxb66ZAExuw6o+brpWy3QlLCvosm87AmIKSfYljH9ZHJDzXSl6ZAe+mnp
	aehSoPG1BbF4xzDR3lHxiID8CFGkGdi+/DeZTokJqpOgyEzPsXiBw65YUtStZGZiY1nJbrU5E7Z
	R0S+xgXCVjYhPzNTojaBwOn/aUVg6Jl0hQOKspdh0Cu4FF+KjmIF4cZo+us4ygp0ypX7s5jB/aj
	6fucL0GQO210tS+omRTtUTC9wrSK7YBdXSko6njmiQyPutAWexizI5vyr2a6RUk=
X-Google-Smtp-Source: AGHT+IEXarhTj8XelbP6w978NQxFdzm3KYgRpu9wOKj/2FZyhLsamJaeZ3ORI0nsqTL5pXTi/4utUw==
X-Received: by 2002:a05:6a00:4fc2:b0:736:35d4:f03f with SMTP id d2e1a72fcca58-7490d52ca7cmr17381283b3a.6.1750662044834;
        Mon, 23 Jun 2025 00:00:44 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6a72afsm7310911b3a.163.2025.06.23.00.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 00:00:44 -0700 (PDT)
Date: Mon, 23 Jun 2025 12:30:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Subject: Re: [PATCH v3 1/4] dt-bindings: opp: adreno: Update regex of OPP
 entry
Message-ID: <20250623070042.d7ibrjc24gbtfyci@vireshk-i7>
References: <20250620-x1p-adreno-v3-0-56398c078c15@oss.qualcomm.com>
 <20250620-x1p-adreno-v3-1-56398c078c15@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620-x1p-adreno-v3-1-56398c078c15@oss.qualcomm.com>

On 20-06-25, 12:24, Akhil P Oommen wrote:
> In some cases, an OPP may have multiple varients to describe the
> differences in the resources between SKUs. As an example, we may
> want to vote different peak bandwidths in different SKUs for the
> same frequency and the OPP node names can have an additional
> integer suffix to denote this difference like below:
> 
>  opp-666000000-0 {
>          opp-hz = /bits/ 64 <666000000>;
>          opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
>          opp-peak-kBps = <8171875>;
>          qcom,opp-acd-level = <0xa82d5ffd>;
>          opp-supported-hw = <0xf>;
>  };
> 
>  /* Only applicable for SKUs which has 666Mhz as Fmax */
>  opp-666000000-1 {
>          opp-hz = /bits/ 64 <666000000>;
>          opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
>          opp-peak-kBps = <16500000>;
>          qcom,opp-acd-level = <0xa82d5ffd>;
>          opp-supported-hw = <0x10>;
>  };
> 
> Update the regex to allow this usecase.
> 
> Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
> index a27ba7b663d456f964628a91a661b51a684de1be..0bd7d6b69755f5f53a045ba7b5e1d08030d980e6 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml
> @@ -23,7 +23,7 @@ properties:
>        const: operating-points-v2-adreno
>  
>  patternProperties:
> -  '^opp-[0-9]+$':
> +  '^opp(-[0-9]+){1,2}$':
>      type: object
>      additionalProperties: false

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

