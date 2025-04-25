Return-Path: <linux-pm+bounces-26184-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E853FA9C503
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 12:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E213AA7B9
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 10:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3076C23A9BD;
	Fri, 25 Apr 2025 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iij5v1k3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9D7221540;
	Fri, 25 Apr 2025 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745576165; cv=none; b=hTX3xl8bIjYhpXIdR3cipAqBYuROAihuh8BVqrGkdBZML9wgojUy6WM/mVA5InNfqRWOQrIJwaMzQYr7ovfDz5xUKDkb4GoapT9CKbxPNa/JS1p2Ioa48VHBkiU6/BHUJuGZdX+fwkRsSz+vHa4uJ7hDn227YFAbZKSWGNdmNtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745576165; c=relaxed/simple;
	bh=SIrtiLIaeQGQ3nKXsSkidzhM/Umt2ybR0YFHiB429cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l36eiY+5FQDPkK2y5IpBsIhFpaIV62zLjngM1r156Yqu1XYepmdtFETcuMoCfa54C/2vMt4XoKQlDHdxJlNNNHO/wZFULpCC0+4reUDqIqdgShIQTyYJCCdiUZQCe3GAoqBG6rvMl4HS/CxxAkK/rahwLjidJuTMDxgUeEr55lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iij5v1k3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F26C4CEE4;
	Fri, 25 Apr 2025 10:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745576164;
	bh=SIrtiLIaeQGQ3nKXsSkidzhM/Umt2ybR0YFHiB429cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iij5v1k3+0LXiksOf1Rzl14G1724AnOcitFOjpSnu94e/Txg5VPqUFD20bbz8yfAq
	 HZEsehSnHhG2aXi0Jf4KE+4ltM7g/T/yWdBWh+ixsSQJIooTP1wWz0jZUfgZhjGpa2
	 VRyvoOzDuapvHc//HYAsMOSksGUx25y36vHB5w51VdNJMn0QtMB9R3cGLmgYI9yOM6
	 LUTGzh96Z4DKlDoQADZI92GqPpg4dMhysvfTv8Y7D8VJM8sSBMtXarIVYqIJJoforD
	 G9iGc3OmRI3drnJC+Al6/x7HQZNF5Mb9kTZVorMWe8dNx+WRv9gXtgLKYZg7NPOypG
	 66LwyalH3lsDQ==
Date: Fri, 25 Apr 2025 12:16:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Praveen Talari <quic_ptalari@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	psodagud@quicinc.com, djaggi@quicinc.com, quic_msavaliy@quicinc.com, 
	quic_vtanuku@quicinc.com, quic_arandive@quicinc.com, quic_mnaresh@quicinc.com, 
	quic_shazhuss@quicinc.com, Nikunj Kela <quic_nkela@quicinc.com>
Subject: Re: [PATCH v2 3/9] dt-bindings: qcom: geni-se: describe SA8255p
Message-ID: <20250425-grumpy-dainty-pillbug-be2145@kuoka>
References: <20250418151235.27787-1-quic_ptalari@quicinc.com>
 <20250418151235.27787-4-quic_ptalari@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250418151235.27787-4-quic_ptalari@quicinc.com>

On Fri, Apr 18, 2025 at 08:42:29PM GMT, Praveen Talari wrote:
> +  "#size-cells":
> +    const: 2
> +
> +  ranges: true
> +
> +  iommus:
> +    maxItems: 1
> +
> +  dma-coherent: true
> +
> +required:

required: block goes after properties and patternproperties. I guess you
copied it from the existing geni binding, but new bindings can improve.

> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +patternProperties:

Rest looks good so with this reordering:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


