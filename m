Return-Path: <linux-pm+bounces-16503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963979B18AA
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 16:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 055A4B210D9
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 14:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A1E125A9;
	Sat, 26 Oct 2024 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJlgHG3h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62795182B4
	for <linux-pm@vger.kernel.org>; Sat, 26 Oct 2024 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729953911; cv=none; b=nm7m3WEWlB//NlhzbKUVlIEbSjOOaBHVAriuuNoWZWRHFSbAqtueCL0JQn0Th+CQPqL/x1Uuf0t4NkcEsG+/Nxt8e5+mJmT91c/+sKHOCzFzU5o/e/Knb6l81YfOrYDBx0sxD58kPkJHboB5mUIeqh3TwUtcVzZGoeZAo0xrhp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729953911; c=relaxed/simple;
	bh=H5JCTWHzJDfFcAzAjGbw0AJ975PXVf9SASk8fDJqYR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzcAcjMSWcvi94Qp6jHZ5/3cNFQueymbGv1A2clll/HjZFycPoEMa/GMoN/rOMwR0dsoXkVFxwzBkObottOnfQhN5XN4TdJtCv31q++rsmxz3SlQwNPLkQw872q5BaFbrgaPLbnTuehFTAEIPF6XjvlpnSS5DjJ1e7kdUEdVUDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VJlgHG3h; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso45350551fa.3
        for <linux-pm@vger.kernel.org>; Sat, 26 Oct 2024 07:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729953907; x=1730558707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=REkz7DRdRtxXTqGgy0w9BmyDW64v9/Nv/dpjM6jmtPU=;
        b=VJlgHG3h6N7pH2KX6QblE6rKXu8CJ/BtWYMOCW3MNatYzP9uH9PVV2XB7Mj0x6uJ2A
         Rv57RmWuQICVirYE5vFAKYqz2IGAz18ta8aIdCSA/EvO1DyeeC3/zFjHkeU6UT8BQuyG
         ba5l/qBpxUAbSjZb422AsgjQ8fIMMBLpuK3tZ8MDcjjmeb/DGzA+q4cCiKxa1CB8OYvI
         gF2Wi0ERZrC4JygmhYFvOHv7o3qM/1A/XMXDrSzS/l8qTGbeq5eQaJP/4A3bAJIyqKV0
         rWWzy+9Hhygxjwru3hsMpHtYN74adrkfeDcQHX6B5brBBgpMHyoja13ZKEo94rHZlCDD
         XRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729953907; x=1730558707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REkz7DRdRtxXTqGgy0w9BmyDW64v9/Nv/dpjM6jmtPU=;
        b=E49fwwQshY2nHH9RWV/o0b3N1BovjfPMt6OG5UgR9/SE7p/WIEwYejg8JbxCqIxkHK
         MSo251B24Wyya2lVIZ0+npD+wN3Fn1qLeV01NtttWyz0TJR713oA5p48NcyqH7FcUtgW
         PfslNsvF/bSWmWKSGR6WcvPoSdLM16faUTze4RJNp7faqzs5pnZlwywsjvArFaKTrsUs
         3gFJfD8TBfb/VYle3z6NTJOqa1tuRbOJbbL8zdSRcvqNKkivBHrpbvdC6ZZJCRNDWVeN
         J1K7hJHLXnyiQ4d4liLMWhpMU1/c6oUxCm8uM3h82d1GSrOAaiDXrEALKuf+CYqlII9q
         UiQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1PIVlKTNBYXmIfEP/fzKCzAro1y2GNLfzAO9XDjeJBkDzuh8TpMq1KiTlBPdAx/yjgFu9+4oPMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBlwwR+ukWHJL5hIVVngWYY5VbywIdSR/xMd1w1QkVW/bPg9f0
	gcg/93/q/if93WieG3VOf1X0X602LYpDmgnKQDxBxYypFGoJFYNOpLj3sDd2m2c=
X-Google-Smtp-Source: AGHT+IHPWOGIFx2rtlDawJl7JbLkIfvVYS64wBwBCl27j5ZKAZ0b6Wd5JFsRRAEPbMvro9n7y/Sdaw==
X-Received: by 2002:a2e:5119:0:b0:2fb:8c9a:fe3f with SMTP id 38308e7fff4ca-2fcbdfc7509mr16228161fa.22.1729953907276;
        Sat, 26 Oct 2024 07:45:07 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb4507b90sm5698381fa.12.2024.10.26.07.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 07:45:05 -0700 (PDT)
Date: Sat, 26 Oct 2024 17:45:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/3] dt-bindings: interconnect: Add EPSS L3 compatible
 for SA8775P
Message-ID: <7k2vnjop6xyshquqlbe22gm7o5empeluvsohfmq5ulnaas3keb@yzomhzi4w7vf>
References: <20241026123058.28258-1-quic_rlaggysh@quicinc.com>
 <20241026123058.28258-2-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026123058.28258-2-quic_rlaggysh@quicinc.com>

On Sat, Oct 26, 2024 at 12:30:56PM +0000, Raviteja Laggyshetty wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on
> SA8775P SoCs.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  .../devicetree/bindings/interconnect/qcom,osm-l3.yaml         | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> index 21dae0b92819..042ca44c32ec 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> @@ -34,6 +34,10 @@ properties:
>                - qcom,sm8250-epss-l3
>                - qcom,sm8350-epss-l3
>            - const: qcom,epss-l3
> +      - items:
> +          - enum:
> +              - qcom,sa8775p-epss-l3
> +          - const: qcom,epss-l3-perf

Why is it -perf? What's so different about it?

>  
>    reg:
>      maxItems: 1
> -- 
> 2.39.2
> 

-- 
With best wishes
Dmitry

