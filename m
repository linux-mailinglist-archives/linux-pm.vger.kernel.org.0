Return-Path: <linux-pm+bounces-21666-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6389A2E8C1
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 11:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E961883375
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 10:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120431C5D7A;
	Mon, 10 Feb 2025 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD7h+fwh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D267C1B414F;
	Mon, 10 Feb 2025 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739182301; cv=none; b=PNJ0lqmMqIOXvJN0/IjoZ3DfBoXs6BGMxYnPIqpxINvx47M0P4M+aPNcAO3R+hWoAwx9WSfY1Fgf8rh/fdzxj+4hWMJbpXOftFYsaADDOZMvoys0XyAnYz2AtORWZ+FRb7YoiL6Ep+VrAmh3sjTHae9YZ+WM1BM69iPYWMakRKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739182301; c=relaxed/simple;
	bh=PCIP0KuJodOIVmlmZ9G785GAXhRgrO5/sxDUOQ6dmJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmLCIOtidLWgiIKMXz+ezi5RypqccF1SHUrP7JbO4x3HSnEkRM0g6cjuOp9v6oUwqJH4sIenWoPLNvLzrwArH7RAcWa99PwFzGfSLMN6SCg6fJBpQrTN9Bk6oN94L3TqNElqMh65KQslj78i5ikjkyWuKLqjuUETbK82VLX6Osk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD7h+fwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEEEC4CED1;
	Mon, 10 Feb 2025 10:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739182301;
	bh=PCIP0KuJodOIVmlmZ9G785GAXhRgrO5/sxDUOQ6dmJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CD7h+fwh/7zmcpTHHi5s4l24BBw1OI/9pSz2fCCxNY+Z3yhrstDHzrRZjUhqUKmEV
	 gF2zlT7KMQdaK6YQEX2rJNq5nGXrZp6dqFsu2IdpO2s/R87U74PHKLJORrIxZ+YN92
	 Iae1GEvxE7+rYQS6pMokQCX1gALJRh5aN+iYXUY+XEity7f+Q8jqCTO09OC/MGgerZ
	 FgULNSc/i/FDBKbSyvEgOfRoIzIhbIlRQ4pJ2S3aaq+Q9xV6x3FXEg+Lgcsz6c3BOe
	 /LKgaS/Q/sOyCqRenlgCdJ606pFOQ1dM4HyPQQsN6JlorujiYbYXkJbxoON2tBJHWM
	 fUT5wqNRUuurA==
Date: Mon, 10 Feb 2025 11:11:38 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Odelu Kukatla <quic_okukatla@quicinc.com>, Mike Tipton <quic_mdtipton@quicinc.com>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 1/7] dt-bindings: interconnect: Add EPSS L3 compatible
 for SA8775P
Message-ID: <20250210-placid-energetic-jaguar-d523d2@krzk-bin>
References: <20250205182743.915-1-quic_rlaggysh@quicinc.com>
 <20250205182743.915-2-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250205182743.915-2-quic_rlaggysh@quicinc.com>

On Wed, Feb 05, 2025 at 06:27:37PM +0000, Raviteja Laggyshetty wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on
> SA8775P SoCs.
> The L3 instance on the SA8775P SoC is similar to those on SoCs
> like SM8250 and SC7280. These SoCs use the PERF register instead
> of L3_REG for programming the performance level, which is managed
> in the data associated with the target-specific compatibles.
> Since the hardware remains the same across all EPSS-supporting SoCs,
> the generic compatible is retained for all SoCs.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


